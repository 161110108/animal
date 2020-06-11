import Vue from 'vue'
import Router from 'vue-router'
import Index from '@/components/Index'
import Login from '@/components/Login'
import Exam from '@/components/index/Exam'
import Power from '@/components/index/Power'
import Animal from '@/components/index/Animal'

Vue.use(Router)

export default new Router({
  routes: [
    {path:'/',redirect:'/exam'},
    {path: '/',name: 'Index',component: Index,
    //  beforeEnter:(to,from,next)=>{
    //     if(localStorage.getItem('user')){
    //       next()
    //     }else{
    //       next('/login')
    //     }
    //   },
      children:[
        {path:'/exam',component:Exam},
        {path:'/power',component:Power},
        {path:'/animal',component:Animal}
      ]
    },
    {path:'/login',name:'Login',component:Login}
  ],
  mode:'history'  
})
