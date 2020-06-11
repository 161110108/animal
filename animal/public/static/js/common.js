/**
 * 公共ajax请求函数封装
 * 传入参数为一个json对象{必须包含：url，type，sucess}
 */
function CreateAjax(json){
    //1.创建ajax
    var ajax = null;
    if(window.XMLHttpRequest){
        ajax = new XMLHttpRequest();
    }else{
        ajax = new ActiveXObject();
    }
    //2.打开服务器
    if(json.type == 'get'){
        var url = json.data ? json.url + '?' + json.data : json.url;
        ajax.open('get',json.url,true);
        ajax.send(null);
    }else{
        ajax.open('post',json.url,true);
        ajax.setRequestHeader('Content-Type','appliction/x-www-from-urlencoded');
        ajax.send(json.data);
    }
    //3.调用数据
    ajax.onreadystatechange = function(){
        if(ajax.readyState == 4 && ajax.status == 200){
            
            json.success && json.success(ajax.responseText);
        }
    }
}