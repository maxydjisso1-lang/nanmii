import { AppRegistry } from 'react-native';
import AppNative from './AppNative';
import { name as appName } from './app.json';

AppRegistry.registerComponent(appName, () => AppNative);
