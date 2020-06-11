<?php
namespace app\index\controller;

use app\index\model\User as UserModel;
use app\Response;
use app\Request;
use think\Controller;
// use think\db\Query;
use think\Session;

class User extends Controller
{
    //注册新用户
    public function add()
    {
        $user = new UserModel();
        //验证该用户是否存在
        $search = $user->where('phone', input('post.username'))->select();
        if (count($search)) {
            setcookie('userphone', input('post.username'), time()+(3600*24*7), '/');
            $this->success('用户已存在', './login');
        }
        $data=date('y-m-d h:i:s', time());
        // $user->phone = input('post.username');
        // $user->password = input('post.password');
        // $user->time = $data;
        $user->data([
            'phone' => input('post.username'),
            'password' => input('post.password'),
            'time' => $data,
            'name' => input('post.username'),
            'img' => '/static/images/head-image.png',
            'msg' => '还没有个人简介',
            'show' => '000'
        ]);
        $result = $user->save();
        if ($result != false) {
            setcookie('userphone', input('post.username'), time()+(3600*24*7), '/');
            $this->success('注册成功', './login');
        } else {
            $this->error('fail');
        }
    }



    // 登陆
    public function check()
    {
        $user = new UserModel();
        // var_dump(input());
        //autologin处理
        setcookie('autologin', input('post.autologin'), time()+(3600*24*7*31), '/');
        if (input('post.autologin')=='true') {
            setcookie('password', input('post.password'), time()+(3600*24*7), '/');
        } else {
            setcookie('password', input('post.password'), time()-1, '/');
        }
        //登陆处理
        $data = $user->where('phone', input('post.username'))->find();
        if ($data) {
            if ($data->power>0) {
                if ($data->password==input('post.password')) {
                    Session::set('userId', $data->id, 'think');
                    setcookie('userphone', input('post.username'), time()+(3600*24*7), '/');
                    if (Session::has('url','think')) {
                        $this->redirect(Session::get('url','think'));
                    }
                    $this->redirect('/');
                } else {
                    $this->error('密码错误');
                }
            } else {
                    $this->error('该账户已被封号');           
            }
        } else {    
                $this->success('该账户不存在', '/login');    
        }
    }


    
    public function post(){
        $user = new UserModel();
        return json_encode($user->all(input('post.id')));
    }
    //搜索一条数据
    public static function search($id)
    {
        // return $id;
        $user = new UserModel();
        return $user->get($id);
    }
    //搜索多条数据
    public static function searchAll($id){
        $user = new UserModel();
        return $user->all($id);
    }




    //changeInfo
    public function changeInfo()
    {
        $user = new UserModel();       
        // var_dump($test);
        //参数上传
        $param = request()->param();
        //图片上传
        $file = request()->file('image');
        if($file){
            $info = $file->move(ROOT_PATH . 'public/static/images/user' );
            if($info){
                $param['img'] =  '/static/images/user/'.$info->getSaveName();
            }else{
                echo $file->getError();
            }
        }

        $user = $user->get($param['id']);
        unset($param['user/changeinfo']);
        $result = $user->save($param);
        if ($result != false) {
            setcookie('userphone', $param['phone'], time()+(3600*24*7), '/');
            $this->success('修改成功', './info/id/'.$param['id']);
        } else {
            $this->redirect('./info/id/'.$param['id']);
            // var_dump($param);
        }
    
    }

    //测试接口
    public function test()
    {
        $user = new UserModel();
        var_dump($user->get(1));
    }

    // 后台登陆接口
    public function adminLogin(){
        $user = new UserModel();
        // $data = $user->get(1);
        $user = $user->get(["phone"=>input('post.user')]);
        if ($user->password==input('post.psd')){
            return json_encode(['state'=>'1','name'=>$user->phone]);
        }else{
            return json_encode(['state'=>'0']);
        } 
    }
    // 后台用户管理
    public function adminUser(){
        $user = new UserModel();
        $admin = $user->get(['phone'=>input('get.phone')]);
        return json_encode(['data'=>$user->with('info')->where('power','<',$admin->power)->select(),'power'=>$admin->power]);
    }
    public function adminChange(){
        $user = new UserModel();
        $user = $user->get(input('post.id'));
        // return $user;
        return $user->save(['power'=>input('post.power')]);
    }
}
