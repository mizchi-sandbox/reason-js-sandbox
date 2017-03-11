const test = require('ava')
const myMod = require('../../_build/self/myMod')

test('same output with reason', t => {
  t.is(myMod.secret, 'hello')
})

test('increment', t => {
  t.is(myMod.increment(3), 4)
})

test('three', t => {
  t.is(myMod.three, 3)
})
