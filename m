Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339428;
	b=x57HYLNnAo1FTSF+9o18VV4v4RwJayLayQc75RU9YOKSStGqaCy2nmEuYnJFfmEC2yL2
	 svnhc3PJn2rSqNCGeeoWBryI+PgayrpiNFSSJyK5ZjelaD/2A/up89wsETcC3oQ4wuSMM
	 AKud43pbp3/6Q8x+F8/XFfFdwAb2Xl2PuTiU05a/Wq8dHBUzlNX0fNRAvljqpdo8nFFHx
	 +IS9CqByVLqZlToKe93xivLbdSxTwo5DYSDsQygH5fWptx9F/rwdoY9FpFQ3JpopR/D8j
	 0Z1Y1pywa9oYOipDf49d6D4zRpGa4lwr8/zIfYVunCono1J8upcDOHFHP6ohOjmeGrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Xkq9mma51XUa9yb13B7yOe2Zra/nLX/ZbGjh9FPzGG0=;
	b=ZyhyikXzsQ+B3YQ85OcihM2tAcI9/+ibWmhYZ8ariuys314eWYykEN9ysBwQr8jVmtQw
	 eWptNZLeBlcmqyBsKiNsIL7icDwVleRmS/MgPmMw56AdMbd4OjJgIFFXwEZGCdoKpacEa
	 hpRIo1Vhtu1rXHGRWeuZ1vN4gCRR+7C0vgAaIQhZMXSuz3Xxk42spl+UnnqUfwI8NWaRd
	 /INikLsdW/BR5F3hS0WeeZoZPAoyePQOpPaEVu5jtcMVQ64y3goIXCPCfX0tLd7UuvaOF
	 6nitAFpPjAMQTwkVWOfMhL7vabYDkzk8D5wnuMZU71gbnODNteS/AxRv9ZbPYslxl8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSouQEuB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35531606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSouQEuB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE6B1F0089F;
	Tue, 10 Nov 2026 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339428;
	bh=Xkq9mma51XUa9yb13B7yOe2Zra/nLX/ZbGjh9FPzGG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eSouQEuBz7IPB2Wt5J233bmwEubNuc7dmIP+IkPQhX2EDDjNXD8uB9y8y8v7ANbAH
	 3dkaupwZCjPdCEKDaDvBmSyMz8H98eXdfZ0cN4pYQ7PXnqX9rpKG9dLYE00lUQjt+O
	 fVlYZZMn2mC4JA0zvRflklAugpM1f1ToLyr6dYb9utdRVDWL9mMB6lO3ef6WrtXfs9
	 Zcp9EyLCOvwtfSDFf8+2+lW7hhSzwy7AnOdJqJK7QuS4L8xWNawFkqF6+BHzCpdvSY
	 VXEIOR2yaWTmKzNueWcB0Qc4CUrNKCoLYsIuL6DJN8LiaZK/aCDeMua0UopkQ9AdcE
	 VOBUR9rNP3cgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Nikolaj=20Klitlund=20B=C3=B8rty?= <nbn@sj.dk>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)
Date: Tue, 10 Nov 2026 14:37:05 -0500
Message-ID: <20261110193636.3544595-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054859-failed-6.1-1430308fc9d4@kernel.org>
References: <20261107054859-failed-6.1-1430308fc9d4@kernel.org>
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
[ sashal: adapted the quirks_table insertion to the existing blacklist_table context because upstream's neighboring entries are absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4702ab9aa9ca3..5ed1a89c090bc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -692,6 +692,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x7392, 0xc611), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x14b0, 0x047a), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
-- 
2.53.0

