<?php
namespace app\index\model;
use think\Model;
class Apply extends Model
{
    public function messages()
    {
        return $this->hasMany('ApplyMessages');
    }
    public function animal()
    {
        return $this->belongsTo('Animal');
    }
}