import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import ProfileDetail from './components/ProfileDetail'
import Home from './components/Home'

Vue.config.productionTip = false

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)
Vue.use(VueRouter)

const router = new VueRouter({
  routes: [
    { path: '/', name: 'home', component: Home},
    { path: '/profile/:id', name: 'profile', component: ProfileDetail }
  ]
})

new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
