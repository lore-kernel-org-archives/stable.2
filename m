Received: from mailrelay-egress12.pub.mailoutpod3-cph3.one.com (mailrelay-egress12.pub.mailoutpod3-cph3.one.com [46.30.211.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C553A2551
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412573; cv=none; b=iwwdYrchoKMkBhBW+1F2rx9Fw8GTFwZfKpPl4MIF8RK/z//PwokEu0BLMcBeoRyTQHqkXGw89d6rLvdGqeHKfOR2lPc8aI1wZxi5wL4/eKOjCp07c0xVZpycZ+p3f7DmWJSAI3HZMq2Iw73c8lCL1lKOOLHjK4na3fSKX64XOs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412573; c=relaxed/simple;
	bh=krFWek1GDHqUjxRPt97GpNKCxcFaCMg1x/4WW41A1nU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=AK0VU6xfHO0zAR+G47Ylw4jyOVbVM1fRtFH1r8awdgw2dR4Omfr5OuflzXhvsN+h4eRnwE1W4JbbwdQSDnDweuxkuAhJIZ6z96hVCBxcZ2D8QvHNRpR2Sn4VNt2t2HdEzPYVDdMjyEl6ZizWUhwU1Bmfgi49MpWdlZDAQbpgOIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=niemelat.fi; spf=none smtp.mailfrom=niemelat.fi; dkim=pass (2048-bit key) header.d=niemelat.fi header.i=@niemelat.fi header.b=08yY1h0b; dkim=permerror (0-bit key) header.d=niemelat.fi header.i=@niemelat.fi header.b=jhwwkpTs; arc=none smtp.client-ip=46.30.211.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=niemelat.fi
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=niemelat.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=niemelat.fi header.i=@niemelat.fi header.b="08yY1h0b";
	dkim=permerror (0-bit key) header.d=niemelat.fi header.i=@niemelat.fi header.b="jhwwkpTs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790412569; x=1791017369;
	d=niemelat.fi; s=rsa1;
	h=content-transfer-encoding:content-type:subject:from:cc:to:mime-version:date:
	 message-id:from;
	bh=smuX1zjGDYS7kVIRNbxjdVEp8V+SVplgbQdjEcjPMGk=;
	b=08yY1h0bCmTnRytT+tjmBiS05dEbcUsoGbXhdLzjpJxGG/b53mim7z8ce//khy/xbfAv5tFoqWE+h
	 Robqs27s21KzQeAhB4BTma3UIWnbX6VFgF898YUc6Vx17sk4lEf4Sybtco1Nzgv8vqXUVIJQNGTQ7C
	 1llOQpk0dNcwXpj1ZGP+88C6uqid+IyYPs8cU5i91leLXa8NOemkaWrLvUk+T/ma+H5MnsIeI7mBwb
	 4IE0xJ/v8vdq6XqKrYqsdEv+t3XxXzDD2LfO+dxTI6XRpyDAnLHU49SoYjGJk7hcQt/tJ0Co4VUuwR
	 kSesQRCZ8oyRVMVCD/qxwJuZlcjGrZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790412569; x=1791017369;
	d=niemelat.fi; s=ed1;
	h=content-transfer-encoding:content-type:subject:from:cc:to:mime-version:date:
	 message-id:from;
	bh=smuX1zjGDYS7kVIRNbxjdVEp8V+SVplgbQdjEcjPMGk=;
	b=jhwwkpTszLPWDHBvAuMlXCvi1CqjRC4trYzsJhwnPPeVbCQQfIFeFdOzozAB7BL1fHxrt3Lw1r9EA
	 bRTAwR/DA==
X-HalOne-ID: 2d9476d0-b987-11f1-957b-33fc7c51c1c8
Received: from [192.168.100.222] (84-231-125-96.elisa-mobile.fi [84.231.125.96])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 2d9476d0-b987-11f1-957b-33fc7c51c1c8;
	Sat, 26 Sep 2026 08:49:28 +0000 (UTC)
Message-ID: <be59323c-d616-4ce9-b886-e1a7be1a7b7e@niemelat.fi>
Date: Sat, 26 Sep 2026 11:49:27 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
From: Niko <unknown@niemelat.fi>
Subject: [REGRESSION] Bluetooth: ASUS USB-BT540 (0b05:1bef) fails after
 BTUSB_REALTEK quirk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I would like to report a regression affecting an ASUS USB-BT540 Bluetooth
adapter (USB ID 0b05:1bef).

The regression appears to be caused by commit:

980084de4d9b25193398d89a1c0430ba3501b683
Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU

which adds BTUSB_REALTEK | BTUSB_WIDEBAND_SPEECH for this USB ID.

Hardware
========

Host:
   Raspberry Pi
   Debian 13 (Trixie)
   Raspberry Pi kernel: 6.18.50+rpt-rpi-v8

Adapter:
   ASUS USB-BT540
   USB ID: 0b05:1bef

USB descriptors:

   bcdUSB               1.10
   bcdDevice            2.00
   iManufacturer           1 Realtek
   iProduct                2 Bluetooth Controller
   iSerial                 0

The descriptors appear to match the device reported in the original patch,
including bcdUSB 1.10 and bcdDevice 2.00.

Problem
=======

With the stock btusb driver containing:

   { USB_DEVICE(0x0b05, 0x1bef), .driver_info = BTUSB_REALTEK |
                                        BTUSB_WIDEBAND_SPEECH },

the adapter fails during Realtek initialization.

The kernel reports:

   Bluetooth: hci1: RTL: examining ...
   Bluetooth: hci1: RTL: Read reg16 failed (-32)

I have also observed:

   Bluetooth: hci1: RTL: Read reg16 failed (-110)

The device then disconnects/re-enumerates and does not become a usable
Bluetooth controller.

I reproduced the failure after cold boots and using different Raspberry Pi
USB ports.

The same behavior was also observed with Raspberry Pi kernels 6.12.109 and
6.18.50.

Power/undervoltage problems were also checked on the Raspberry Pi:

   vcgencmd get_throttled
   throttled=0x0

Test / workaround
=================

To isolate the problem, I built btusb.ko from the exact Raspberry Pi 6.18.50
kernel source.

I made only one functional change to drivers/bluetooth/btusb.c: I 
removed the
0b05:1bef entry which forces this device through BTUSB_REALTEK.

The adjacent ASUS USB-BT600 0b05:1d70 entry and all other btusb code were
left unchanged.

With 0b05:1bef falling back to the generic btusb path, the same physical
USB-BT540 works correctly.

BlueZ detects the USB-BT540 as a second controller.

The working controller reports:

   Type: Primary
   Bus: USB
   HCI Version: 5.4 (0xd)
   HCI Revision: 0x000e
   LMP Version: 5.4 (0xd)
   LMP Subversion: 0x8761
   Manufacturer: Realtek Semiconductor Corporation (93)

btmgmt also reports:

   version 13
   manufacturer 93

and the controller remains powered and operational.

hciconfig reports:

   UP RUNNING PSCAN
   RX errors: 0
   TX errors: 0

BLE operation
=============

This is not only an HCI enumeration test.

With the generic btusb path the adapter successfully performs BLE scanning
and discovers BLE devices.

It is also currently being used continuously by a Python application using
Bleak to communicate with Ensto ELTE6-BT BLE heating controllers.

The complete path:

   USB-BT540
     -> generic btusb
     -> BlueZ
     -> Bleak
     -> BLE heating controller
     -> MQTT

is working reliably.

Therefore the controller appears to be fully usable through the generic
btusb path rather than merely enumerating successfully.

Test on another computer
========================

I also tested the same physical ASUS USB-BT540 on a separate Pop!_OS system
running kernel 7.1.1.

On that system the adapter worked as a second BlueZ controller using the
generic btusb path.

The only notable message there was:

   Bluetooth: hci1: Failed to read codec capabilities (-22)

but the controller itself was operational.

Observation
===========

This is interesting because the USB descriptors of this adapter appear to
match those from the device used for the original BTUSB_REALTEK patch:

   VID:PID       0b05:1bef
   bcdUSB        1.10
   bcdDevice     2.00
   Manufacturer  Realtek
   Product       Bluetooth Controller

However, the behavior of this unit appears to be the opposite of the unit
described in the original patch.

On this adapter:

   BTUSB_REALTEK
     -> Realtek initialization
     -> Read reg16 fails (-32 or -110)
     -> controller unusable

while:

   generic btusb
     -> controller initializes
     -> HCI operational
     -> BLE scanning works
     -> BLE GATT communication works reliably

I am therefore not suggesting simply reverting the 0b05:1bef entry, since
the USB-BT540 used for the original patch apparently required the Realtek
firmware path to operate.

It seems possible that ASUS/Realtek USB-BT540 adapters with the same VID:PID
and bcdDevice exist with different internal hardware, ROM or firmware
revisions, or that there is another distinction which is not represented by
the USB descriptors.

For comparison, this working unit identifies itself as:

   HCI Version:    5.4
   HCI Revision:   0x000e
   LMP Version:    5.4
   LMP Subversion: 0x8761
   Manufacturer:   Realtek (93)

I can provide additional logs, USB/HCI information, and test proposed driver
changes if needed.

Regards,
Niko

