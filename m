Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340519;
	b=raFsoPceLZhkD4vFYvvCuK3trfjjZkd98q/VbHCgRzaXHmUUcmngfpjcq3zNa36X3oQ+
	 e5wuvVst+dTvl52S60KaP7esag0D7wf2JxkyOQanpKWukAo2E2TWpLBUaIAi0lHNBvaDQ
	 l1LwyuXB8vud5NAPgjaktbSELnBsvE2gVNWup2m4y9fkr/kR51Tvj/JsHFG8r43fIBOQY
	 GrZ6VWVsnZ3mEF1otiYeNDThD9gFVzgH+/6Xg+C4b9I1xRaf4M2no3a/BCFUaOREdTkAF
	 c/4CFW+XYiSFXWwbVMzw4XTFSD8bFaqosP2SDZxN2drxeSe7H8mLGtY7caMvxRvd0tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340519;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JLDYprL1v/SZeQHPxRisjRWypCDw8535wjXx2AYPANA=;
	b=gkZy931UmrB7/m74EVypJ+mMcvRxoApFrDWIKOi6x3CdhgKiYbr5zCij0Uq0Yuq3yCSX
	 y98amwhTEnmAq3o14OnTFwV5QzVEb5UjXuMDn+HryIyvd/Xg5RoMhTD4aydYnAp6yBaj0
	 VuoO8MhkYaGZkSIWKBRG79sPS7aisalRDHLH12AIDaquAF0SjgNHV3HHHpHFdtSq6lx77
	 SnyaOrCrXy9bIy4VxGGmwTdLNPN7KccLylT1a8Mci6hELlaFg/MonnuTUw+WvzYyjJ8bO
	 i0EKenZMq7Rxh8dN70cIhRAOI7p+7fPQ+gdo9YhYwd8LzLWpL29mnYSkgWFc8V5Z2Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsuKOlFG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C41606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsuKOlFG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC471F008A5;
	Tue, 10 Nov 2026 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340518;
	bh=JLDYprL1v/SZeQHPxRisjRWypCDw8535wjXx2AYPANA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VsuKOlFGFg7y0/+nauFc6AP6mb86m0oKZV0/4H48uE2Uc337BPktIFZCvW05jUNKP
	 FmoOz3Zh/o4kApLJL8Q7ILjMvyeWqYk/MW6QqJuJFk1B3M06R0YjpRd0Rj+pvfkcDv
	 Q/yWXJOTkW7O8xr0eotbvvsgccejGlfnuXY2NN0WGc2t0nhGY4glrKXHpHEJ28gxJ6
	 2LsOSqHPhaSIrfPqgxOES6cciMdSdX8rYUOn8ujyq56YZztFVCqn/FlR4Q/vOiQVYY
	 wzheQ9nNDSDrxw4NzthenWxwfZhAStVGEli+lNzKm+uvuflYmbLk14cpIKXbGHhlcQ
	 zg1O1t+R+H0eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Nikolaj=20Klitlund=20B=C3=B8rty?= <nbn@sj.dk>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)
Date: Tue, 10 Nov 2026 14:55:16 -0500
Message-ID: <20261110195357.3634441-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060619-failed-5.15-1430308fc9d4@kernel.org>
References: <20261107060619-failed-5.15-1430308fc9d4@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nikolaj Klitlund Børty <nbn@sj.dk>

[ Upstream commit 1430308fc9d47a801a305700cd444b1a0051d14a ]

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
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ sashal: Adjusted insertion context to the existing RTL8761BU group in blacklist_table instead of quirks_table. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index de588bee66e66..0b96df90c65e4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -546,6 +546,8 @@ static const struct usb_device_id blacklist_table[] = {
 	  					     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x14b0, 0x047a), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
-- 
2.53.0

