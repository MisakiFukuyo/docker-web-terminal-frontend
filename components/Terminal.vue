<template>
  <v-flex
    xs6
  >
    <v-card>
      <v-card-title primary-title>
        <div>
          <p>
            {{ workingDirectory }}
            {{ mainCommand }}
            {{ parameters }}
          </p>
          <div ref="terminal" class="terminal" />
        </div>
      </v-card-title>
    </v-card>
  </v-flex>
</template>

<script>
import '@/node_modules/xterm/dist/xterm.css';
import { Terminal } from 'xterm';


export default {
  props: {
    workingDirectory: {
      type: String,
      default: '',
    },
    mainCommand: {
      type: String,
      default: '',
    },
    parameters: {
      type: String,
      default: '',
    },
    connectionNumber: {
      type: Number,
      default: -1,
    },
    messages: {
      type: Array,
      default() {
        return [];
      },
    },
  },
  data() {
    return {
      cursor: 0,
      terminal: new Terminal(),
    };
  },
  watch: {
    messages(newMessages) {
      for (; this.cursor < newMessages.length; this.cursor += 1) {
        this.terminal.write(newMessages[this.cursor]);
      }
    },
  },
  mounted() {
    this.terminal.open(this.$refs.terminal);
    this.$socket.sendObj({
      number: this.connectionNumber,
      stdtype: 'stdout',
    });
    this.$socket.sendObj({
      number: this.connectionNumber,
      stdtype: 'stderr',
    });
  },
};
</script>
