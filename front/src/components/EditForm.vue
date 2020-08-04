<template>
  <div>
   <b-modal 
    id="modal-edit" 
    title="Formulário de usuário" 
    @ok="submit"
    >
    <b-container>
      <p v-if="errors.length">
        <b>Erro:</b>
        <ul>
          <li v-for="error in errors" :key="error">{{ error }}</li>
        </ul>
      </p>


      <b-row>
        <b-col>
          <b-form-input v-model="username" placeholder="Nome do usuário" class="my-3"></b-form-input>
          <b-form-input v-model="profileUrl" placeholder="Url do perfil do usuário" class="my-3"></b-form-input>
        </b-col>
      </b-row>
    </b-container>
  </b-modal>

  <b-modal id="form-submitted">
    <h5>Formulário enviado</h5>
  </b-modal>
  </div>
</template>

<script>
export default {
  name: 'EditForm',
  props: ['id', 'username'],
  data() {
    return {
      githubUrl: 'https://github.com/',
      errors: []
    }
  },
  computed: {
    profileUrl() {
      return this.githubUrl + this.username
    }
  },
  methods: {
    checkForm() {
      if(this.username && this.profileUrl.split('https://github.com/').pop()) {
        return true
      }

      this.errors = []

      if(!this.username) {
        this.errors.push('Insira um nome de usuário')
      }

      if(!this.profileUrl.split('https://github.com/').pop()) {
        this.errors.push('Insira uma url de perfil válida ')
      }

    },
    async submit(bvModalEvt) {
      bvModalEvt.preventDefault()
      if(this.checkForm()) {

        const body = {'profile': { 'username': this.username, 'profile_url': this.profileUrl }}
        const data = { 'id': this.id, 'body': body }
        await this.$store.dispatch('profile/updateProfile', data)

        this.$root.$emit('bv::hide::modal', 'modal-edit')
        this.$root.$emit('bv::show::modal', 'form-submitted')
      }
    }
  }
}
</script>

<style>
</style>
