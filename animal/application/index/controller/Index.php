<?php
namespace app\index\controller;
use think\Controller;
use think\Request;
use think\View;
use think\Session;
class Index extends Controller
{
    protected $beforeActionList=[
        'remember' => ['except' => 'login,register,cancel'],
        'getUser'=> ['except'=>''],
        'checkLogin' => ['only' => 'info,create,changeInfo,detail'],
    ];
    //缓存当前页网址
    public function remember()
    {
        Session::set('url', request()->url(), 'think');
    }
    //未登陆跳转
    public function checkLogin()
    {
        if(!(Session::has('userId','think'))){
            $this->success('请先登陆','/login');
        }
    }
    //获取登陆信息
    public function getUser()
    {
        if(Session::has('userId','think')){
            $user = User::search(Session::get('userId','think'));
            $tag = 'true';  
        }else{
            $user = User::search(1);
            $tag = 'false';
        }
        $this->assign('tag',$tag);     
        $this->assign('user',$user);
    }
    //首页
    public function index()
    {       
        return $this->fetch();

    }
    //登陆页
    public function login()
    {
        $this->assign('phone',isset($_COOKIE['userphone'])?$_COOKIE['userphone']:'')  ;
        $this->assign('password',isset($_COOKIE['password'])?$_COOKIE['password']:'') ;
        $this->assign('autologin',isset($_COOKIE['autologin'])?$_COOKIE['autologin']:'false') ;
        return $this->fetch();
    }
    //注册
    public function register()
    {
        $data = new View();
        return $data->fetch();
    }
    //个人主页
    public function info()
    {
        if(input('get.id')){
            $id = input('get.id');  
        }else{
            $id = Session::get('userId','think');
        }
        $master = User::search($id);     
        $this->assign('master',$master);
        $animal = Animal::getAll($id);
        $this->assign('animal',$animal);
        $this->assign('apply',$this->test($id));
        return $this->fetch();
    }
    

    //修改个人信息
    public function changeInfo()
    {
        // if($tag =='false'){
        //     return $this->error('还没有登陆');
        // }
        return $this->fetch();
        
    }
    //注销登陆
    public function cancel()
    {
        Session::delete('userId','think');
        if(Session::has('url','think')){
            $this->redirect(Session::get('url','think'));
        }else{
            $this->redirect('/');   
        }
    }
    //发布领养消息
    public function create(){
        return $this->fetch();
    }
    //领养详情
    public function detail($id){
        
        $animal = Animal::search($id);
        $this->assign('animal',$animal);
        $role = '0';
        
        //检测自己是发布人
        $id = Session::get('userId','think');
        if($id==$animal->rescuer){
            $role = '1';
        }
        //检测自己是否申请人
        foreach($animal->apply as $ap){
            if($ap->applyer == $id){
                $role = '2';
            }
        }  
        $this->assign('role',$role);
        $this->assign('apply',json_encode($animal->apply));
        return $this->fetch();
    }
    

    public function test($id)
    {
        $result = Messages::getApply($id);
        $id =  implode(',',$result);
        $result = Animal::getApply($id);
        return $result;
    }
}
