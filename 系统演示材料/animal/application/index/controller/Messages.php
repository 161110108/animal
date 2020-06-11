<?php
namespace app\index\controller;

use app\index\model\Apply as Mes;
use app\index\model\ApplyMessages as Mess;
use app\Response;
use app\Request;
use think\Controller;
// use think\db\Query;
use think\Session;
class Messages extends Controller
{
    // 获取聊天记录
    public function post()
    {
        $mes = new Mes();
        $messages = new Mess();
        // $mes->get(["access"=>27,"animal_id"=>40]);  
        $mes = $mes->get(["applyer"=>input('post.applyer'),"animal_id"=>input('post.animal_id')]);
        // 将接收信息状态更改为已读
        $messages->save(['status'=>1],['apply_id'=>$mes->id,'access'=>input('post.send')]);
        return json_encode(["data"=>$mes->messages]);
    }
    //发送消息
    public function create()
    {
        $mes = new Mes();  
        $mes = $mes->get(["applyer"=>input('post.applyer'),"animal_id"=>input('post.animal_id')]);
        $data=date('y-m-d h:i:s', time());
        $result = $mes->messages()->save([
            'msg'=>input('post.msg'),   
            'status'=>0,
            'time'=>$data,
            'send'=>input('post.send'),
            'access'=>input('post.access'),
            'animal_id'=>input('post.animal_id')
        ]);
        return $result;
    }
    // 新消息提醒
    public function news(){ 
        $send = explode(',',input('post.send'));
        $result = [];
        foreach($send as $a){
            $messages = new Mess();
            $datas = $messages->all(['send'=>$a,'access'=>input('post.access'),'status'=>0,'animal_id'=>input('post.animal_id')]);
            if(count($datas)>0){
                $result[$a] = count($datas);
            };
        }
        return json_encode($result);
    }
    public function test(){
        return input('post.access');
    }
    public function newApply()
    {
        $mes = new Mes();
        $result = $mes->save([
            'applyer'=>input('post.applyer'),
            'animal_id'=>input('post.animal_id'),
            'time'=>date('y-m-d h:i:s', time())
        ]);
        if($result==1){
            return 'success';
        }
    }
    public static function getApply($id)
    {
        $mes = new Mes();
        $result = $mes->where('applyer',$id)->column('animal_id');
        return $result;
    }
}