<template>
  <div>
      <b-modal 
    id="modal-create" 
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
      <b-modal id="form-create-submitted">
        <h5>Formulário enviado</h5>
  </b-modal>
  </div>
</template>

<script>
export default {
  name: 'CreateForm',
  data() {
    return {
      username: '',
      profileUrl: 'https://github.com/',
      errors: []
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
        await this.$store.dispatch('profile/createProfile', body)

        this.$root.$emit('bv::hide::modal', 'modal-create')
        this.$root.$emit('bv::show::modal', 'form-create-submitted')
      }
    }
  }
}
</script>

<style>
</style>
