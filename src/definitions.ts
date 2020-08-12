import { BluetoothGATTCharacteristics } from "./utils/ble-gatt-characteristics.enum";
import { BluetoothGATTServices } from "./utils/ble-gatt-services.enum";
import { WebPlugin } from "@capacitor/core";



declare module "@capacitor/core/dist/esm/core-plugin-definitions" {

	interface PluginRegistry {
		BluetoothLEClient: BluetoothLEClientPlugin;
	}
}

export interface BluetoothLEClientPlugin extends WebPlugin {
	connect(options: BluetoothGATTConnectOptions): Promise<BluetoothGATTConnectResult>;
	disableNotifications(options: BluetoothGATTNotificationOptions): Promise<BluetoothGATTDisableNotificationsResult>;
	disconnect(options: BluetoothGATTDisconnectOptions): Promise<BluetoothGATTDisconnectResult>
	discover(options: BluetoothGATTServiceDiscoveryOptions): Promise<BluetoothGATTServiceDiscoveryResult>;
	enable(): Promise<BluetoothGATTEnableResult>;
	enableNotifications(options: BluetoothGATTNotificationOptions): Promise<BluetoothGATTEnableNotificationsResult>;
	getCharacteristic(options: GetCharacteristicOptions): Promise<GetCharacteristicResult>;
	getCharacteristics(options: GetCharacteristicOptions): Promise<GetCharacteristicResult>;
	getService(options: GetServiceOptions): Promise<GetServiceResult>;
	getServices(options: GetServiceOptions): Promise<GetServiceResult>;
	hasPermissions(): Promise<HasPermissionsResult>;
	isAvailable(): Promise<BluetoothGATTAvailabilityResult>;
	isConnected(options: BluetoothGATTisConnectedOptions): Promise<BluetoothGATTConnectedResult>;
	isEnabled(): Promise<BluetoothGATTEnabledResult>;
	read(options: BluetoothGATTCharacteristicReadOptions): Promise<BluetoothGATTCharacteristicReadResult>;
	readDescriptor(options: BluetoothGATTDescriptorReadOptions): Promise<BluetoothGATTDescriptorReadResult>;
	scan(options: BluetoothGATTScanOptions): Promise<BluetoothGATTScanResults>;
	write(options: BluetoothGATTCharacteristicWriteOptions): Promise<BluetoothGATTCharacteristicWriteResult>;
	writeDescriptor(options: BluetoothGATTDescriptorWriteOptions): Promise<BluetoothGATTDescriptorWriteResult>;
}

export interface BluetoothGATTAvailabilityResult {
	isAvailable: boolean
}

export interface BluetoothGATTConnectedResult {
	connected: boolean
}

export interface BluetoothGATTEnabledResult {
	enabled: boolean
}

export type BluetoothGATTEnableResult = {
	enabled: boolean
}

export interface BluetoothGATTScanOptions {
	services: Array<BluetoothGATTServices | number>
}

export interface BluetoothGATTPeripheral {
	name: string,
	id: string
}

export interface BluetoothGATTScanResults {
	devices: BluetoothGATTPeripheral[]
}

export interface BluetoothGATTConnectOptions {
	id: string,
	name?: string,
	service?: string,
	characteristic?: string,
	timeout?: number,
	autoConnect?: boolean
}

export interface BluetoothGATTConnectResult {
	connected: true
}

export interface BluetoothGATTDisconnectOptions {
	id: string,
	name: string,
	service: string,
	characteristic: string
}

export interface BluetoothGATTDisconnectResult {
	disconnected: true;
}

export interface BluetoothGATTisConnectedOptions {
    id: string,
    name: string,
    service: string,
    characteristic: string
}

export interface BluetoothGATTServiceDiscoveryOptions {
	id: string
}

export interface BluetoothGATTServiceDiscoveryResult {
	discovered: true
}

export type BluetoothGATTByteData = number[];

export interface BluetoothGATTCharacteristicReadOptions {
	id: string,
	service: BluetoothGATTServices | number,
	characteristic: BluetoothGATTCharacteristics | number
}



export interface BluetoothGATTCharacteristicReadResult {
	value: BluetoothGATTByteData
}

export interface BluetoothGATTCharacteristicWriteOptions {
	id: string,
	service: BluetoothGATTServices | number,
	characteristic: BluetoothGATTCharacteristics | number
	value: string //Base64 encoded string of byte array
}

export interface BluetoothGATTCharacteristicWriteResult {
	value: BluetoothGATTByteData
}

export interface BluetoothGATTDescriptorReadOptions {
	id: string,
	service: BluetoothGATTServices | number,
	characteristic: BluetoothGATTCharacteristics | number,
	descriptor: number
}

export interface BluetoothGATTDescriptorReadResult {
	value: BluetoothGATTByteData
}

export interface BluetoothGATTDescriptorWriteOptions {
	id: string,
	service: BluetoothGATTServices | number,
	characteristic: BluetoothGATTCharacteristics | number,
	descriptor: number,
	value: string //Base64 encoded string of byte array
}

export interface BluetoothGATTDescriptorWriteResult {
	value: BluetoothGATTByteData
}

export interface BluetoothGATTNotificationOptions {
	id: string,
	service: BluetoothGATTServices | number,
	characteristic: BluetoothGATTCharacteristics | number,
}

export interface BluetoothGATTEnableNotificationsResult {
	enabled: true
}

export interface BluetoothGATTDisableNotificationsResult {
	disabled: true
}

export interface GetServiceOptions {
	id: string,
	service?: BluetoothGATTServices | number
}

export interface GATTService {
	uuid: BluetoothGATTServices | number,
	isPrimary: boolean,
	characteristics: Array<BluetoothGATTCharacteristics | number>,
	included?: Array<BluetoothGATTServices | number>
}

export type GetServiceResult = GATTService | { services: GATTService[] };

export interface GetCharacteristicOptions {
	id: string,
	service: BluetoothGATTServices | number,
	characteristic?: BluetoothGATTCharacteristics | number
}

export interface GATTCharacteristicProperties {
	authenticatedSignedWrites: boolean,
	broadcast: boolean,
	indicate: boolean,
	notify: boolean,
	read: boolean,
	write: boolean,
	writeWithoutResponse: boolean
	reliableWrite?: boolean,
	writableAuxiliaries?: boolean,
}

export interface GATTCharacteristic {
	uuid: BluetoothGATTCharacteristics | number,
	properties: GATTCharacteristicProperties,
	descriptors: number[]
}

export type GetCharacteristicResult = GATTCharacteristic | { characteristics: GATTCharacteristic[] };

export type BluetoothGATTCallback = (data: BluetoothGATTByteData) => any;

export interface BluetoothGATTCallbacks {
	[characteristic: number]: BluetoothGATTCallback
}

export interface HasPermissionsResult {
	isAllowed: boolean
}

