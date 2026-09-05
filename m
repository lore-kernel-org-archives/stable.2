Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2580E381AEC;
	Sat,  5 Sep 2026 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788609913; cv=none; b=raOiDdJ028hxpj3c8A1msBe8c1D6k8FA5pwtR2JjW3EKIeGFrpSxCmNQaN7fXjMtrtFhdOL5MYCEUQofOQZ9WgqVJq2QHQhjR9GOnYzhHjdEkgkqDfQa6i1y7jo6s8pFaatMA619tyBVYuEeI+Mw8YFcFUjk+ZFJKwYTdZq23E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788609913; c=relaxed/simple;
	bh=K6MbrBQlIeiFcBEDt6UWI0HR0lk3Q+lvtJD3LHvHCkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lrj27za7WgGTXtePU3gdUvs5lEiqzafMKOs8Bsfu0EzuIMzKCxvNEeylaYFNwS0iaG06irepqxVXtrjSPFdUwLa5habNxExwWJDHpOlSGzaByf2wgeBuiO3lrUvqHA1v4icBNqSlymBKmu2U1oiHtj2laSPMHAd4dpeq3cXNdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khNbDBMZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khNbDBMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98250C2BCB3;
	Sat,  5 Sep 2026 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788609912;
	bh=K6MbrBQlIeiFcBEDt6UWI0HR0lk3Q+lvtJD3LHvHCkg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=khNbDBMZrw5bPU+uQO+VeAyB9KL1HMtzUV6cI5XwnF6t5XMtT7xqYA+SS4Sa/MFhx
	 QKwyxPr6ApK3njE6QB/+RV8u6BbeahNAvxE5NqKKqHgq/Qb8IFh74BmMjNPqWJQop1
	 uD0laK/flyrdKyDqrcRwQofNZqwzsXT0njuP7xYBUdQK2ngk5VElBi3y2/ae9aCHFT
	 DvNcoeZWMIQeAdbo+WYK880TkTJpXE7cD1PGU9WetboNJMIK3gQFW1JP+KEbm4/Mcj
	 gkP4rTfbmvqqCoPxBwLRr03S8himVIJzkaIV1S44B5Eg9+XvH3TsIUIFR59JK+U8HV
	 oTJZhgEaqp69w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAD6C624DB;
	Sat,  5 Sep 2026 12:05:12 +0000 (UTC)
From: =?utf-8?q?Nikolaj_Klitlund_B=C3=B8rty_via_B4_Relay?= <devnull+nbn.sj.dk@kernel.org>
Date: Sat, 05 Sep 2026 14:05:12 +0200
Subject: [PATCH] Bluetooth: btusb: Add device ID for Realtek RTL8761BUE
 (StarTech AV53C1)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260905-startech-av53c1-v1-1-3385f9bb220c@sj.dk>
X-B4-Tracking: v=1; b=H4sIAHcFnGoC/x3MQQqAIBBA0avIrBPUsqirRAubxppNhYoE0t2Tl
 m/xf4FIgSnCJAoEyhz5Oit0IwAPd+4keasGo0yvRmVlTC4kwkO6bFvUUq8d2dYbq3GAWt2BPD/
 /cV7e9wNlCZg3YQAAAA==
X-Change-ID: 20260905-startech-av53c1-1b4e53f251c7
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, =?utf-8?q?Nikolaj_Klitlund_B=C3=B8rty?= <nbn@sj.dk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788609911; l=2680;
 i=nbn@sj.dk; s=20260905; h=from:subject:message-id;
 bh=qikB7+kXC0YvR5kdQ4345D7/gSWOZ6njl78gr4Q01Mc=;
 b=KvlU26Ro04cGwNSf5bWuo5LvGwBncPF0PXfBHwsjW6ROazoTYySahibtxhOFiV3/0PuoK3dqP
 L/xMQdFIWkzDD18eU1CaGm6EAv6HszIS9+xbLfUElaHsJBhPP7Vrk57
X-Developer-Key: i=nbn@sj.dk; a=ed25519;
 pk=gSabhnk9EeLlA58h6ZHttMKWKQwb5LGja3BORiZv9gQ=
X-Endpoint-Received: by B4 Relay for nbn@sj.dk/20260905 with auth_id=1005
X-Original-From: =?utf-8?q?Nikolaj_Klitlund_B=C3=B8rty?= <nbn@sj.dk>
Reply-To: nbn@sj.dk

From: Nikolaj Klitlund Børty <nbn@sj.dk>

Add the USB ID 0x14b0:0x047a for the StarTech AV53C1-USB-BLUETOOTH
adapter, a Realtek RTL8761BUE based Bluetooth 5.3 dongle.

Without this entry btusb treats the device as a generic Bluetooth
adapter and never loads the Realtek firmware, leaving the controller on
its ROM firmware. In that state it advertises and scans actively, but
never reports advertisements during passive scanning. LE connections
initiated by the kernel wait for a passive-scan report before issuing
LE Create Connection, so connecting and pairing from BlueZ time out
without any error from the controller.

The same product is also sold with the ID 0x2c0a:0x8761, which is
already supported.

lsusb -v output for the device:

Bus 001 Device 010: ID 14b0:047a StarTech.com Ltd. Bluetooth Radio
Device Descriptor:
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  idVendor           0x14b0 StarTech.com Ltd.
  idProduct          0x047a
  bcdDevice            2.00
  iManufacturer           1 Realtek
  iProduct                2 Bluetooth Radio
  iSerial                 3 00E04C239987
  bNumInterfaces          2
    Interface Descriptor:
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth

Cc: stable@vger.kernel.org
Signed-off-by: Nikolaj Klitlund Børty <nbn@sj.dk>
---
Tested on Home Assistant OS 18.2 (kernel 6.18.39): without this entry the
adapter enumerates and scans, but btusb never loads rtl_bt/rtl8761bu_fw.bin,
and LE connections from BlueZ never complete because the controller reports
no advertisements during passive scanning. Details in the commit message.
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d70a3e7a13f5d18c75bc1c9fbc1ac5706e832f61..c3c581a5adbb09f7118a3932cdda210d68d2336d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -860,6 +860,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x37ad, 0x0600), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x14b0, 0x047a), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8761CU Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x1bef), .driver_info = BTUSB_REALTEK |

---
base-commit: 4d7d9486c04d917265f64c55bd23b2cc4fe7749c
change-id: 20260905-startech-av53c1-1b4e53f251c7

Best regards,
-- 
Nikolaj Klitlund Børty <nbn@sj.dk>


