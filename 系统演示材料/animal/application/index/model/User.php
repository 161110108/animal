<?php
namespace app\index\model;
use think\model\Merge;
class User extends Merge
{
    protected  $relationModel = ['UserInfo'];
    protected $fk = 'user_id';
    public function info(){
        return $this->hasOne('UserInfo');
    }
}