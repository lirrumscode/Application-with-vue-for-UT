<template>
  <div>
    <div class="login-page">
      <div class="form" id="app">
        <img src="https://static.platzi.com/media/blog/unnamed-8089fc33-6322-4bd3-85de-1da032257d4b.png" class="img-platzi" />
        <h3 class="h20">Platzi User Api</h3>
        <form class="login-form" method="POST" v-on:submit.prevent="submit(email,username)">
          <input
            type="email"
            v-model="email"
            id="email"
            name="email"
            placeholder="Your Email"
            required
          />
          <input
            type="text"
            v-model="username"
            placeholder="Your username"
            id="username"
            name="username"
          />
          <button class="btn">Submit</button>
        </form>
      </div>
    </div>
    <Footer></Footer>
  </div>
</template>
<script>
import Footer from "@/components/Footer.vue";

export default {
  name: "Login",
  components: {
    Footer,
  },
  data() {
    return {
      email: "",
      username: "",
    };
  },
  methods: {
    /* Validation login from localstorage */
    submit: function (email, username) {
      if (email == "") {
        alert("please fill the fields");
      } else if (username == "") {
        alert("please fill the fields");
      } else {

          localStorage.setItem("email", email) 
          localStorage.setItem("username", username)
          alert("welcome to the WeatherApp, " + localStorage.getItem('email'));
          this.$router.push("/dashboard");
      }
    },
  },
};
</script>
<style scoped lang="scss">
@import "../assets/index.css";
</style>