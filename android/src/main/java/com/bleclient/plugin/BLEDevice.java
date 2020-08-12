package com.bleclient.plugin;

import java.util.UUID;

class BLEDevice {
	private UUID characteristic;
	private String name;
	private UUID service;
    BLEDevice(String name, UUID service, UUID characteristic){
		this.characteristic = characteristic;
		this.name = name;
		this.service = service;
    }
	UUID getCharacteristic() {return this.characteristic;}
	String getName() {return this.name;}
	UUID getService() {return this.service;}
}