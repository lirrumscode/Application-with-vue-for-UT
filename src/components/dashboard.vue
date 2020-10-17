<template>
  <div>
    <nav class="menu" tabindex="0">
      <div class="smartphone-menu-trigger"></div>
      <header class="avatar">
        <img src="https://static.platzi.com/media/blog/unnamed-8089fc33-6322-4bd3-85de-1da032257d4b.png" />
        <h2>{{ email }}</h2>
      </header>
      <ul>
        <li tabindex="0" class="icon-dashboard">
          <span>{{ email }}</span>
        </li>
        <li tabindex="0" class="icon-settings">
          <span>
            <router-link to="/">
              <a>Logout</a>
            </router-link>
          </span>
        </li>
      </ul>
    </nav>
    <main>
      <div class="container" id="contenedor">
        <h2>Platzi APi</h2>
        <div class="row">
          <div class="col-sm-12 col-lg-6 col-md-6 div-container">
            <div class="card">
              <span class="txt-update" v-if="info">{{ info.last_update }}</span>
              <span class="title" v-if="info">
                {{ info.name }}
                <img :src="info.flag" class="img-name" />
              </span>
              <img :src="info.avatar" class="img-card" v-if="info" />
              <span class="txt" v-if="info">{{ info.platzi_rank }}</span>
              <span class="txt" v-if="info">{{ info.description }}</span>
              <span class="txt" v-if="info">
                <a :href=" info.website" class="span-website">Sitio Web</a>
              </span>
            </div>
          </div>
        </div>
        <br />
        <h5 class="title-courses" :class="['alert',state3 ? 'text-hide' : 'text-show']">Badge</h5>
        <div class="row">
          <div
            class="col-sm-12 col-lg-6 col-md-6 div-container"
            v-for="data in info.careers"
            :key="data.id"
          >
            <div class="card">
              <span class="title" v-if="data">{{ data.career }}</span>
              <img :src="data.golden_achievement" class="img-card" v-if="data" />
              <span class="txt" v-if="data">{{ data.title }}</span>
            </div>
          </div>
        </div>
        <br />
        <h5 class="title-courses" :class="['alert',state ? 'text-hide' : 'text-show']">Contributions</h5>
        <div class="row">
          <div
            class="col-sm-12 col-lg-6 col-md-6 div-container"
            v-for="data in info.contributions"
            :key="data.id"
          >
            <div class="card">
              <span class="title" v-if="data">{{ data.course_name }}</span>
              <span class="txt" v-if="data">{{ data.title }}</span>
              <span class="txt" v-if="data">
                <img src="https://img.icons8.com/material-rounded/15/000000/filled-star.png" />
                stars: {{ data.n_stars }}
              </span>
            </div>
          </div>
        </div>
        <br />
        <h5 class="title-courses" :class="['alert',state2 ? 'text-hide' : 'text-show']">Courses approved</h5>
        <div class="row">
          <div
            class="col-sm-12 col-lg-6 col-md-6 div-container"
            v-for="data in info.courses"
            :key="data.id"
          >
            <div class="card">
              <span class="title" v-if="data">{{ data.career }}</span>
              <img :src="data.badge" class="img-card" v-if="data" />
              <span class="txt" v-if="data">{{ data.title }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- end container -->
    </main>
    <Footer></Footer>
  </div>
</template>
<script>
import axios from "axios";
import Footer from "@/components/Footer.vue";

export default {
  name: "dashboard",
  components: {
    Footer,
  },

  data() {
    return {
      contribuciones: [],
      courses:[],
      badge:[],
      email: localStorage.getItem("email"),
      info: null,
    state:false,
    state2:false,
    state3:false,
      params: {
        access_key: "8c368817ea0c3e0f64fa10ae3ffc2f3f",
        query: localStorage.getItem("username"),
      },
    };
  },
  mounted() {
    this.getUser();
  },
  methods: {
    async getUser() {
      axios
        .get(
          "https://platzi-user-api.jecsham.com/api/v1/getUserSummary/@" +
            this.params.query
        )
        .then((response) => {
          console.log(response.data.userData);
          this.info = response.data.userData;
          this.contribuciones = response.data.userData.contributions;
          if(this.contribuciones == ''){
            this.state = true;
          }
          else{
            this.state = false;
          }
                    this.courses = response.data.userData.courses;
          if(this.courses == ''){
            this.state2 = true;
          }
          else{
            this.state2 = false;
          }
                              this.badge = response.data.userData.careers;
          if(this.courses == ''){
            this.state3 = true;
          }
          else{
            this.state3 = false;
          }
          if (response.status == 200) {
            console.log("Petición exitosa");
          } else {
            alert("error en la petición");
          }
        })
        .catch((e) => console.log(e));
    },
    logout() {
      this.$router.push({ path: "/" });
      localStorage.clear("username");
    },
  },
};
</script>
<style scoped lang="scss">
@import "../assets/main.css";
@import "../assets/card.css";
</style>
