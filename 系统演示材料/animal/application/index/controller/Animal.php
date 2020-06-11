<?php
namespace app\index\controller;

use app\index\model\Animal as AnimalModel;
use app\Response;
use app\Request;
use think\Controller;
use think\db\Query;
// use think\db\Query;
use think\Session;

class Animal extends Controller
{
    //测试获取user
    public function getUser(){
        $power = User::search(28)->power;
        $animal = new AnimalModel();
        if($power>1){
            $animal->status = '1';
        }
        $date=date('y-m-d h:i:s', time());
        $result = $animal->save([
            'rescuer' => '28',
            'time' => $date,
        ]);
        if($result){
            echo 'success';
        }else{
            echo 'fail';
        }
    }
    // 新建
    public function create(){
        $animal = new AnimalModel();
        $param = request()->param();
        $files = request()->file('image');
        // 获取rescuer权限
        $power = User::search($param['rescuer'])->power;
        $date=date('y-m-d h:i:s', time());
        if($power>1){
            $animal->status = '1';
        }
        $result1 = $animal->save([
            'rescuer' => $param['rescuer'],
            'time' => $date,
        ]);
        unset($param["animal/create"]);
        unset($param["rescuer"]);
        $result2 = $animal->info()->save($param);
        $x=0;
        $img = [];
        foreach($files as $file){
            $x++;
            $name = 'img'.(string)$x;
            $info = $file->move(ROOT_PATH . 'public/static/images/animal' );
            if($info){
                $img[$name] = '/static/images/animal/'.$info->getSaveName();
            }else{
                echo 'wrong<br>';
                echo $file->getError();
            }
        }
        $result3 = $animal->img()->save($img);
        if($result1 != false && $result2 != false && $result3 != false){
            $this->success('创建成功', '/info'); 
        }else{
            $this->error('fail'); 
        }
    }
    //获取申请领养动物信息
    public static function getApply($id){
        $animal = new AnimalModel();
        return  array_reverse($animal->all($id));
    }

    //获取某个人发布的领养信息
    public static function getAll($i)
    {
        $animal = new AnimalModel();
        $animal = $animal->all(['rescuer'=>$i]);
        // 返回二维数组；
        return array_reverse($animal);
        
        //返回json；
        // $data = [];
        // for($i=0; $i<count($animal); $i++){
        //     // $data[$i] = $animal[$i]->appendRelationAttr('info',['type','tag','msg','title','adress'])->appendRelationAttr('img',['img1','img2','img3','img4','img5'])->toJson();
        //     $data[$i] = $animal[$i]->toJson();
        // }
        // return json_encode($data);
        //$animal[0]->appendRelationAttr('info',['type','tag','msg','title','adress'])->appendRelationAttr('img',['img1','img2','img3','img4','img5'])->toJson();
        
    }
    // 获取一条数据
    public static function search($id)
    {
        $animal = new AnimalModel();
        return $animal->get($id);
    }
    //搜索功能
    public function type(){
        $animal = new AnimalModel();
        if(input('post.page')){
            $page = intval(input('post.page'));
        }else{
            $page = 0;
        }
        if(input('post.type')){
            $data=$animal->hasWhere('info',function($query){
                $query->where('type','=',input('post.type'))->where('title|tag|msg|adress','like','%'.input('post.search').'%')->where('status','1');
            })->limit($page*5,5)->order('time')->with('info,img,res,res.info')->select();
            $count=$animal->hasWhere('info',function($query){
                $query->where('type','=',input('post.type'))->where('title|tag|msg|adress','like','%'.input('post.search').'%')->where('status','1');
            })->count();
        }else{
            $data=$animal->hasWhere('info',function($query){
                $query->where('title|tag|msg|adress','like','%'.input('post.search').'%')->where('status','1');
            })->limit($page*5,5)->order('time')->with('info,img,res,res.info')->select();
            $count=$animal->hasWhere('info',function($query){
                $query->where('title|tag|msg|adress','like','%'.input('post.search').'%')->where('status','1');
            })->count();
        }  
        return json_encode(['data'=>$data,'count'=>ceil($count/5),'page'=>$page+1]);      
        // return json_encode(['data'=>$data,'count'=>'19','page'=>'18']);      
    }
    public function test(){

    }
    // 添加领养人
    public function adopt()
    {
        $animal = new AnimalModel();
        $animal = $animal->get(input('get.animal'));
        $animal->save(['status'=>2]);
        echo  $animal->adopter()->save([
            'adopt'=>input('get.id'),
            'time'=>date('y-m-d h:i:s', time()),
        ]);       
        //   $this->redirect('http://www.animal.com/detail/id/'+input('get.id'));
       
    }
    // 检测是否被领养
    public static function already($id){
        $animal = new AnimalModel();
        $data = $animal->get($id);
        return $data->adopter;
    }
    //领养完成
    public function certain(){
        $animal = new AnimalModel();
        $data = $animal->get(input('post.id'));
        $data->adopter->save(['certain'=>'1']);
        return $data->adopter->certain;
    }

    public function recom(){
        $animal = new AnimalModel();
        // 获取id27用户最近三个项目
        $tarAnimalArr = History::search(input('post.id')); 
        // return input('post.id');
        $tarAnimalIdArr = array();//存储最近三个项目
        foreach($tarAnimalArr as $tarAnimal){
            array_push($tarAnimalIdArr, $tarAnimal->animal_id);
            if(count($tarAnimalIdArr)>=3){ break;}
        }
        // return count($tarAnimalIdArr);
        if(count($tarAnimalIdArr)<3){
            return 1;
        }
        // 将三个项目虚拟成一个项目,并将每一个tag进行一次搜索，
        $targetAllId = array();//有重复相似项目集
        foreach($tarAnimalIdArr as $tarAmimalId){
            $tagArr = explode(';',$this->search($tarAmimalId)->info->tag);
            foreach($tagArr as $tag){
                if($tag){ 
                    $targetAllId = array_merge($targetAllId,$this->getRecomCol($tag,$tarAnimalIdArr));//targetAllId：U总；
                }
            }
        }
        
        // 计算每个项目的重复次数
        $result = array(); //animal_id=>次数
        foreach($targetAllId as $id){
            if(array_key_exists($id,$result)){
                $result[$id] ++;
            }else{
                $result[$id]=1;
            }
        }

        
        // 计算每个项目的相似分数
        $grade = array(); //animal_id => 分数
        foreach($result as $key=>$value){
            $tagCount = $this->tagCount($key); //
            // echo 'count：'.$tagCount.'<br>';
            $grade[$key] = pow($result[$key],2)/$tagCount;
        }
        
        // 排序
        // echo 'grade：';var_dump($grade);echo '<br>';
        $n = 0; 
        $resultItem = array();
        for($i=0;$i<count($grade);){
            $topGrade = 0;
            $topID = 0;
            foreach($grade as $key=>$value){
                if(bccomp($value,$topGrade,2)==1){
                    $topGrade = $value;
                    $topID = $key;
                }
            }
            $resultItem[$n] = $animal->with('info,img,res,res.info')->select($topID)[0];
            $n++;
            //推荐top-6；
            if($n>5){
            break;
            }
            unset($grade[$topID]);
        }
        // echo 'grade：';var_dump($grade);echo '<br>';
        // echo '目标项目：';var_dump($tarAnimalIdArr);echo '<br>';
        // echo 'u总：';var_dump($targetAllId);echo '<br>';
        // echo '结果：';var_dump($result);echo '<br>';
        // echo '最终结果';var_dump($resultItem);echo '<br>';
        return json_encode($resultItem);
    }
    public function getRecomCol($tag,$idArr){
        $animal = new AnimalModel();
        $datas = $animal->hasWhere('info',['tag'=>['like','%'.$tag.'%']])->order('time')->select();
        $result=array();
        foreach($datas as $data){
            if( $data->id!=$idArr[0] && $data->id!=$idArr[1] && $data->id!=$idArr[2] && $data->status==1 ){
                array_push($result,$data->id);
            }  
        }
        return $result;
    }
    public function tagCount($id){
        $animal = new AnimalModel();
        $data = explode(';',$animal->get($id)->info->tag);
        return count($data)-1;
    }
    public function adminExam(){
        $animal = new AnimalModel();
        $data = $animal->where(['status'=>0])->with('info,img,res,res.info')->select();
        return json_encode($data);
    }
    public function allow(){
        $animal = new AnimalModel();
        // return input('get.id');
        return $animal->save(['status'=>1],['id'=>input('get.id')]);
    }
    public function adminAll(){
        $animal = new AnimalModel();
        return json_encode($animal->with('info,img,res,res.info')->select());
    }
    public function changeStatus(){
        $animal = new AnimalModel();
        $animal = $animal->get(input('post.id'));
        return $animal->save(["status"=>input('post.status')]);
    }
}