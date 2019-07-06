<template>
  <v-layout
    column
  >
    <terminal
      v-for="(item, index) in terminals"
      :key="index"
      :connection-number="terminals[index].connectionNumber"
      :working-directory="terminals[index].workingDirectory"
      :main-command="terminals[index].mainCommand"
      :parameters="terminals[index].parameters"
      :messages="terminals[index].messages"
    />
    <add-terminal
      @up="dockerComposeUp"
      @down="dockerComposeDown"
      @exec="dockerComposeExec"
    />
  </v-layout>
</template>

<script>
import axios from '@/plugins/axios';
import Terminal from '@/components/Terminal.vue';
import AddTerminal from '@/components/AddTerminal.vue';

export default {
  components: {
    Terminal,
    AddTerminal,
  },
  data() {
    return {
      terminals: [],
    };
  },
  mounted() {
    this.$options.sockets.onmessage = ({ data }) => {
      const message = JSON.parse(data);
      const terminal = this.terminals.filter(t => t.connectionNumber === message.number)[0];
      terminal.messages.push(message.data);
    };
  },
  methods: {
    async dockerComposeUp({ workingDirectory }) {
      const { data: { number: connectionNumber } } = await axios.post('/docker-compose/up', {
        workingDirectory,
      });
      this.terminals.push({
        connectionNumber,
        workingDirectory,
        mainCommand: 'up',
        messages: [],
      });
    },
    async dockerComposeDown({ workingDirectory }) {
      const { data: { number: connectionNumber } } = await axios.post('/docker-compose/down', {
        workingDirectory,
      });
      this.terminals.push({
        connectionNumber,
        workingDirectory,
        mainCommand: 'down',
        messages: [],
      });
    },
    async dockerComposeExec({ workingDirectory, parameters }) {
      const { data: { number: connectionNumber } } = await axios.post('/docker-compose/exec', {
        workingDirectory,
        parameters: parameters.split(' '),
      });
      this.terminals.push({
        connectionNumber,
        workingDirectory,
        mainCommand: 'exec',
        parameters,
        messages: [],
      });
    },
  },
};
</script>
