Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341406;
	b=YKDPEqLvR1XN2U6VDwljLGmEV6IwjkwDT0ULLsByLTZtpEOc6N9wb9RR0PKd0o+EOEEG
	 ifIM52xX/HVg3BHHAiF3xpczUPDmN00QVse4XOX8IS9YIVJaWbhStRBu5V7h3HnPMV/OG
	 6PPlJP6Xb2f19rbpADkc0KmVD8G+YW5EJkSl6q9bbP2Bi+q0RLwBy+CT9sdKbuKTSCq8W
	 6p2enocCYighx3LKaHDVseo5D04l6M7iL0i0IdQCjXYSd0WfhYqiHq24/IqsfK8Ixj1y4
	 xODMZZaDryS2uDyvo+arSKtH/nuETBCfWHZf9hUxXdabKlCexGep1ZRwmP2n6JOhF2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341406;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pzBl5faae79g/KyQ4RI+9R5khW/nm9FSkWjutKvVBI0=;
	b=TuOJQij+2JkFtOjM5vSWTs7lborK4X/wHQxMcCRA7k+FMHbbOLT5XobvbtHS+XPHkBva
	 icvlSy+UowJpOcw8oNmaMDnZhJ8Ymf0mSEqaTlVutzEyO0XgzM5kpT1zwsWn6ShquTKIF
	 BC3ue5K++tnWRt9xEVAuQAx5g40XkP5OL5jHaIY19UO1xOjmODnlhFZVTzh58hh0aeM52
	 UguJHWJeT2qxu7+ktFx++XX4Pnbh8RKT9d0c8WTU91rou0x59mJTd879MSQKfBoF74/1a
	 EpY5VRkSeB71vOWGHlDNEZGtBcxoK2uWNj1B8i7M+8tMzl1Ur8QPQ5PFyegQmu2gpHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NrWKeY74;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C062606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NrWKeY74
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3B41F0089F;
	Tue, 10 Nov 2026 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341406;
	bh=pzBl5faae79g/KyQ4RI+9R5khW/nm9FSkWjutKvVBI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NrWKeY74x8eCcODUDR6QTHYBwyloqkdH2Y/YNwgr+IKPM/U6EOqE7ik9jqAYZiBQM
	 OO6XQi4YKRuZp4Bi5fELHQfXiwNnfRXomlELAP+/IVIaTAAREqEVJWLEY7U2tF4h7d
	 4mS9jTetSpCoTDjEoTIi7ohwSzizelYQa9NNKkxlOpqU6Wg26zjNdy9rbQJjHQS7HX
	 coeEt75yWVxb335F+1AMdI031XIRp+OU5UcH9B/FZ5GTrsDER72yPDqk/5s4tkS4gb
	 0w98exxJp8QE34VLAGfmaI2rikwfAWaC3dyjBsAK4iWIhLongklrFl4hz7gGAb1oDn
	 uMS/+1NorSF9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Nikolaj=20Klitlund=20B=C3=B8rty?= <nbn@sj.dk>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)
Date: Tue, 10 Nov 2026 15:10:04 -0500
Message-ID: <20261110200900.3697486-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062304-failed-5.10-1430308fc9d4@kernel.org>
References: <20261107062304-failed-5.10-1430308fc9d4@kernel.org>
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
[ sashal: adapted quirks_table insertion to blacklist_table with the missing Realtek group heading added ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 55a54612a59e6..1eaa5c83da306 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -500,6 +500,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0bda, 0xb009), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x2ff8, 0xb011), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8761BUV Bluetooth devices */
+	{ USB_DEVICE(0x14b0, 0x047a), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },
-- 
2.53.0

