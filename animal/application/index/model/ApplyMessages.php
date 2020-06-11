<?php
namespace app\index\model;
use think\Model;
class ApplyMessages extends Model
{
    public function apply(){
        return $this->belongsTo('Apply');
    }
}