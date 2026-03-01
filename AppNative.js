import React from 'react';
import { View, Text, StyleSheet, ScrollView } from 'react-native';
import { StatusBar } from 'expo-status-bar';

export default function AppNative() {
  return (
    <View style={styles.container}>
      <StatusBar barStyle="light-content" />
      <ScrollView style={styles.content}>
        <View style={styles.header}>
          <Text style={styles.title}>Nanmii Asset</Text>
          <Text style={styles.subtitle}>Mobile Application</Text>
        </View>

        <View style={styles.statusCard}>
          <Text style={styles.statusLabel}>Status</Text>
          <Text style={styles.statusValue}>Running</Text>
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Features</Text>
          <View style={styles.featureItem}>
            <Text style={styles.featureName}>✓ React Native UI</Text>
          </View>
          <View style={styles.featureItem}>
            <Text style={styles.featureName}>✓ Mobile First</Text>
          </View>
          <View style={styles.featureItem}>
            <Text style={styles.featureName}>✓ Expo Build</Text>
          </View>
        </View>
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#1a1a1a',
  },
  content: {
    flex: 1,
    padding: 16,
  },
  header: {
    marginVertical: 20,
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
    color: '#ffffff',
  },
  subtitle: {
    fontSize: 16,
    color: '#888888',
    marginTop: 4,
  },
  statusCard: {
    backgroundColor: '#2a2a2a',
    padding: 16,
    borderRadius: 8,
    marginVertical: 16,
  },
  statusLabel: {
    fontSize: 14,
    color: '#888888',
  },
  statusValue: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#4CAF50',
    marginTop: 8,
  },
  section: {
    marginVertical: 16,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#ffffff',
    marginBottom: 12,
  },
  featureItem: {
    backgroundColor: '#2a2a2a',
    padding: 12,
    borderRadius: 6,
    marginBottom: 8,
  },
  featureName: {
    fontSize: 14,
    color: '#4CAF50',
  },
});
