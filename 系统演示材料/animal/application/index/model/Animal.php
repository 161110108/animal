<?php
namespace app\index\model;
use think\Model;
class Animal extends Model
{
    public function info()
    {
        return $this->hasOne('AnimalInfo');
    }
    public function img()
    {
        return $this->hasOne('AnimalImg');
    }
    public function apply()
    {
        return $this->hasMany('Apply');
    }
    public function adopter()
    {
        return $this->hasOne("Adopter");
    }
    public function res()
    {
        return $this->belongsTo('User','rescuer');
    }
}