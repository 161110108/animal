import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
//挂载Vuex
Vue.use(Vuex)

//创建VueX对象
const store = new Vuex.Store({
    state:{
        //存放的键值对就是所要管理的状态
        exam:[],
        user:[],
        power:0,
        animal:[],
        optionsAll:[
            {value:0,label:'封号'},
            {value:1,label:'普通用户'},
            {value:2,label:'动保用户'},
            {value:3,label:'管理员'},
        ],
        optionsAnimal:[
            {value:-1,label:'拒绝'},
            {value:0,label:'待审核'},
            {value:1,label:'代领养'},
            {value:2,label:'已完成'}
        ]
    },
    mutations:{
        setExam(state,data){
            state.exam = data
        },
        setUser(state,data){
            state.user = data
        },
        setPower(state,power){
            state.power = power;
        },
        setAnimal(state,data){
            state.animal = data
        }
    },
    actions:{
        updateExam(context){
            axios.get('/api/animal/adminExam')
            .then(res=>{
                // console.log(res.data)
                // console.log(res.data[0].info.type)
                context.commit('setExam',res.data)
            })
        },
        updateUser(context){
            axios.get('/api/user/adminUser?phone='+localStorage.getItem('user'))
            .then(res=>{
                let data = res.data.data;
                data.splice(0,1)
                context.commit('setUser',data)
                context.commit('setPower',res.data.power)
            })
        },
        updateAnimal(context){
            axios.get('/api/animal/adminAll')
            .then(res=>{
                let data = res.data;
                data.splice(0,1)
                console.log(data)
                context.commit('setAnimal',data)
            })
        }

    }
})

export default store