let a = parseInt("{$user.power}");
if (a > 1) {
    $('#user_sign').css('display', 'block')
}

$('#more').mouseenter(function () {
    $(this).children('.drop').css('display', 'block');
}).mouseleave(function(){
    $(this).children('.drop').css('display', 'none');
})



var type='';
var search='';
//type功能
$('.type-select').children().click(function(){
    type=$(this).attr('name');
    $('.type-select').children().css('background','none')
    $(this).css('background','#f00');
    ap();
})
//search功能
$('#search').click(function(){
    search =$(this).prev().val();
    ap();
})

function ap(page=''){
    $('#loading').css('display','block')
    $.post('/animal/type',{'type':type,'page':page,'search':search},(res)=>{
        res = JSON.parse(res);
        setTimeout(function(){
            $('#loading').css('display','none')
        },500)
        data = res.data;
        page = parseInt(res.page);
        count = parseInt(res.count);
        str='<section id="main-content"><h3>领养信息</h3>';
        data.forEach((item)=>{
            str+=`<div class="show">
            <!-- title,img,url,tag,Intro_Msg,rescuer,adress -->
            <a href="/detail/id/${item.id}" class="animal">
                <p class="title">${item.info.title}</p>
                <p class="adress">地址：${item.info.adress}</p>
                <p class="msg">${item.info.msg}</p>
                <p class="time">${item.time}</p>
                <img src="${item.img.img1}" alt="">
                <img src="${item.img.img2}" alt="">
                <img src="${item.img.img3}" alt="">
                <img src="${item.img.img4}" alt="">
            </a>
            <a href="./info?id=${item.res.id}" class="rescuer">
                <img src="${item.res.info.img}" alt="">
                <p class="title">${item.res.info.name}</p>
                <p>${item.res.info.msg}</p>
            </a>`
            // <div class="id">
            //     <em>认证</em>
            // </div>
            if(item.res.power>1){
                str += '<div class="id"><em>认证</em></div>'
            }
            str+='</div>'
        })
        if(data.length==0){
            str+='<span>没有搜索结果</span>'
        }
        str+=`<div class="page-box">
                <ul>
                    <li><button>上一页</button></li>`
        let start =0, end = 0;
        if(count>7){
            if(page<=3){
                start=1;
            }else if(page>=count-3){
                start = count-6;
            }else{
                start = page-3;
            }
            end = start+6;
        }else{
            start = 1;
            end = count;
        }
        for(let i=start; i<=end; i++){      
            if(i==page){
                str += `<li><a class='visit'>${i}</a></li>`;
            }else{
                str += `<li><a>${i}</a></li>`;
            }
        }
        
        str+=`<li><button>下一页</button></li>
                </ul>
                <div>
                    <span>共${res.count}页</span>
                    <span>第</span>
                    <input type="text">
                    <span>页</span>
                    <button class="jump">跳转</button>
                </div>
            </div></section>`
        $('#main-content').remove();
        $('header').after(str);
        $('.page-box button').eq(0).click(()=>{
            if(page>1){
                ap(page-2);
            }
        })
        $('.page-box button').eq(1).click(()=>{
            if(page<count){
                ap(page)
            }
        })
        $('.jump').click(function(){
            let jumpPage = parseInt($(this).prevAll('input').val());
            if(jumpPage>0 && jumpPage<=count){
                ap(jumpPage-1);
            }else{
                alert('输入参数有误');
            }
        })
        $('.page-box a').click(function(){
            ap(parseInt($(this).text())-1)
        })
    })
}

