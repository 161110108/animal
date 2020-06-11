<template>
  <div id="animal">
     <el-input class="search" v-model="input" placeholder="请输入内容"></el-input>
     <template>
        <el-select v-model="statusChoose" placeholder="请选择">
            <el-option
              v-for="item in status"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
    </template>


    <template>
      <el-table :data="animalArr" border style="width: 100%">
        <el-table-column prop="time" label="日期" width="180"></el-table-column>
        <el-table-column prop="info.title" label="标题" width="180"></el-table-column>
        <el-table-column prop="res.info.name" label="送养人"></el-table-column>
        <el-table-column prop="info.adress" label="地址"></el-table-column>
        <el-table-column prop="info.type" label="类型"></el-table-column>

        <el-table-column label="类型">
            <template slot-scope="scope">
            <el-select style="width: 140px" v-model="scope.row.status" placeholder="请选择" @change="change(scope.row)">
              <el-option
                v-for="item in optionsAnimal"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
            </template>
        </el-table-column>
        
        <el-table-column fixed="right" label="操作" width="140">
          <template slot-scope="scope">
            <el-button @click="handleClick(scope.row)" type="text" size="small">查看</el-button>
          </template>
        </el-table-column>
      </el-table>
    </template>
  </div>
</template>
  </div>
</template>
<script>
import { mapState, mapMutations,mapActions } from "vuex";
export default {
  data() {
    return {
        timer:'',
        input:'',
        status:[
            {value:-1,label:'拒绝'},
            {value:0,label:'待审核'},
            {value:1,label:'代领养'},
            {value:2,label:'已完成'},
            {value:3,label:'全部'}
        ],
        statusChoose:3
    };
  },
  created() {
      this.$emit('choose',2)
    this.updateAnimal()
    this.timer = setInterval(this.updateAnimal,3000)
  },
  beforeDestroy(){
      clearInterval(this.timer)
  },
  computed: {
    ...mapState(["animal","optionsAnimal"]),
    animalArr(){
      return this.animal.filter(item=>{
          if(this.statusChoose==3){
            return item.info.title.match(this.input) || item.res.info.name.match(this.input) || item.info.adress.match(this.input) || item.info.type.match(this.input)
          }else{
            return item.status==this.statusChoose && (item.info.title.match(this.input) || item.res.info.name.match(this.input) || item.info.adress.match(this.input) || item.info.type.match(this.input))
          }
          
      })
    }
  },
  methods: {
    ...mapMutations(["setAnimal"]),
    ...mapActions(['updateAnimal']),
    handleClick(val){
        window.location.href = 'http://www.animal.com/detail/id/'+val.id
    },
    change(item){
        this.$axios.post('/api/animal/changeStatus',{
            id:item.id,
            status:item.status
        }).then(res=>{
            this.$message({
                    message:'修改成功',
                    offset:100
                })
        })
    },
  }
};
</script>
<style scoped>
.search{
    margin-bottom:20px;
    width:300px;
}
#animal {
  line-height: 1.6em;
}
</style>