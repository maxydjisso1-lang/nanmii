import React from 'react';
import { View, Text } from 'react-native';

export default function App() {
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center', backgroundColor: '#1a1a1a' }}>
      <Text style={{ color: 'white', fontSize: 24, fontWeight: 'bold' }}>Nanmii Asset</Text>
      <Text style={{ color: '#888', fontSize: 14, marginTop: 8 }}>Build Test</Text>
    </View>
  );
}
