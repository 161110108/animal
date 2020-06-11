<template>
  <div id="exam">
     <el-input class="search" v-model="input" placeholder="请输入内容"></el-input>
    <template>
      <el-table :data="examArr" border style="width: 100%">
        <el-table-column prop="time" label="日期" width="180"></el-table-column>
        <el-table-column prop="info.title" label="标题" width="180"></el-table-column>
        <el-table-column prop="res.info.name" label="送养人"></el-table-column>
        <el-table-column prop="info.adress" label="地址"></el-table-column>
        <el-table-column prop="info.type" label="类型"></el-table-column>
        <el-table-column fixed="right" label="操作" width="140">
          <template slot-scope="scope">
            <el-button @click="handleClick(scope.row)" type="text" size="small">查看</el-button>
            <el-button @click="allow(scope.row)" type="text" size="small">通过审核</el-button>
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
        input:''
    };
  },
  created() {
    this.$emit('choose',0)
    this.updateExam()
    this.timer = setInterval(this.updateExam,3000)
  },
  beforeDestroy(){
      clearInterval(this.timer)
  },
  computed: {
    ...mapState(["exam"]),
    examArr(){
      return this.exam.filter(item=>{
          return item.info.title.match(this.input) || item.res.info.name.match(this.input) || item.info.adress.match(this.input) || item.info.type.match(this.input)
      })
    }
  },
  methods: {
    ...mapMutations(["setExam"]),
    ...mapActions(['updateExam']),
    handleClick(val){
        window.location.href = 'http://www.animal.com/detail/id/'+val.id
    },
    allow(val,ind){
        this.$axios.get('/api/animal/allow?id='+val.id)
        .then(res=>{
            console.log(res)
        });
        this.updateExam();
        console.log(this.exam)
    }
  }
};
</script>
<style scoped>
.search{
    margin-bottom:20px;
    width:300px;
}
#exam {
  line-height: 1.6em;
}
</style>