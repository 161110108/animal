<?php
namespace app\index\controller;

use app\index\model\History as HistoryModel;
use app\Response;
use app\Request;
use think\Controller;
// use think\db\Query;
use think\Session;

class History extends Controller
{
    public static function search($user_id){
        $history = new HistoryModel();
        return $history->where('user_id',$user_id)->limit(3)->order('time desc')->select();
    }
    public static function create($user_id,$animal_id){
        $history = new HistoryModel();
    }
}