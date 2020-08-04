<template>
  <div>
    <b-navbar class="navbar-wrapper" togglebale="md" type="light">
      <b-navbar-brand><router-link :to="{ name: 'home' }">GH Scrapper</router-link></b-navbar-brand>
      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav class="ml-auto">
          <b-button v-b-modal.modal-create variant="success" id="addProfile" >Adicionar perfil</b-button>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>

    <CreateForm />
  </div>
</template>

<script>
import CreateForm from './CreateForm'

export default {
  name: 'NavBar',
  components: {
    CreateForm
  },
  methods: {
  },
}
</script>

<style scoped>
.navbar-wrapper {
  background: #1a535c;
}

.navbar-wrapper a {
  color: #fff; 
}

.navbar-wrapper a:hover {
  color: #4ecdc4; 
  text-decoration: none;
}
</style>
