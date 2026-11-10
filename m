Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281531;
	b=eIw28RoLBYnXXriWalxisVrZUiy9t9el2+zK/OXVvC+Q0kdiGlIFUnb+fx82dwntZp9R
	 F6eXxHyRwqnP6AlAi5kUxkpdNQ5nEKXtHu2EWbeW1iwUWVlEwU3NqHRMdNVKZPDQiL67I
	 w1SY+bU0IUSOXvRoscsABLMffSHZEZoM97dsq+HfFOZ5mlXI8TYC6LF477Rec3Mtfo4Ul
	 Z6k/lpJTyhROzEQyTgQeNpmy4ytYygCGkgWUT4CMYTldLA+Ofcj8RPSX/JwH8UC204Oim
	 Ofw8C2vOU+3uPgk1yDfDIwl9hngx9xj7CHgOn1h8mojrm6lsFMT/pSnCjdkvVcAHTGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281531;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=kYZL4rnheTABX8WBq6es/I5ToDAjBICPT1On+50K6v8=;
	b=2gIN67958Owbtm7f3i+X6oOcIdkZwnh4yTdfio5HcmVkiwl5JWZga8XDPjejBs137Dkj
	 2v8AadwjCegFc+a5X/P2oG16PO8joi4v3bK7NsZaL69JxzVy1EWqq2d4QKu9u2KvJT9hj
	 hr7v57T8u4MNzbl/n4FnYIaFLe0vdkWAl+rTmcvNvgTihx//KoDxm6ZZCYQAADQ46VCs9
	 mYucsaCsQUCo/2A9Jiohtg3D1xS1oFxt0Ta55U/hxpY3ZaX5t7hZ/AIsJVHwpj4fOIPcJ
	 h7HVu8h9504vl8FAYWac7z68msIzGUvZVTt+FNHfWaDhT+G7aBxmc2uJFOfSxVhXwDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=O+pJ2ISY;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA3606A31C;
	Tue, 10 Nov 2026 03:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6BA3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=O+pJ2ISY
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kYZL4rnheTABX8WBq6es/I5ToDAjBICPT1On+50K6v8=;
	b=O+pJ2ISYefi+uQbSG8ycqQGnH/z7NrmGZHSo+XHWOuf0vcZKcfEd23EplWUiXpDkHM96r0NeU
	yp3dz/6B5Buz52OiYksk+F92u09V4ADKRXMBrHLxaEh6QFMGkriWAiR+Dr9URWjPjfxIw379wqV
	Y9WUrbQtUnqsarRTCUL3VOM=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jNsdg1lvmzLlTm;
	Tue, 10 Nov 2026 11:31:51 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id A765C4048B;
	Tue, 10 Nov 2026 11:32:05 +0800 (CST)
Received: from vm.huawei.com (7.238.34.231) by whupemk100010.china.huawei.com
 (7.152.184.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 11:32:04 +0800
From: Pengfei Lv <lvpengfei20@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stern@rowland.harvard.edu>, <michal.pecio@gmail.com>,
	<stable@vger.kernel.org>, <xuhaiyang5@hisilicon.com>, <xuetao09@huawei.com>,
	<caiyadong@huawei.com>, <suzhuangluan@hisilicon.com>, Pengfei Lv
	<lvpengfei20@huawei.com>
Subject: [PATCH v4] usb: core: hub: Re-guess ep0 maxpacket size after reset
Date: Tue, 10 Nov 2026 11:30:38 +0800
Message-ID: <20261110033038.2882473-1-lvpengfei20@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109093935.2634235-1-lvpengfei20@huawei.com>
References: <20261109093935.2634235-1-lvpengfei20@huawei.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100010.china.huawei.com (7.152.184.41)

Per USB 2.0 spec section 5.5.3, the ep0 maxpacket size is fixed for
all device speeds except full-speed devices, where it can be 8, 16,
32, or 64 bytes and can only be determined by reading the device
descriptor.  During initial enumeration the USB core guesses 64 bytes
for full-speed devices; after reading the descriptor, the real value
is stored in udev->ep0.desc.wMaxPacketSize and applied to hardware by
usb_ep0_reinit().

Commit ff33299ec8bb ("USB: core: Fix race by not overwriting
udev->descriptor in hub_port_init()") guarded the ep0 maxpacket guess
block with "if (initial)", so on the reset path the guess is skipped
and the host keeps using the value from the previous enumeration.  If
a buggy full-speed device responds with one 8-byte packet and NAKs
all further polling, the HC doesn't recognize a short transfer but
keeps polling for the rest of the descriptor till unlink, and the
device cannot be re-enumerated.

This was observed in production on a 6.6 LTS kernel with a full-speed
USB banking token (bMaxPacketSize0 = 8) in a virtual-machine USB
passthrough scenario; the reset re-enumeration hangs 100% of the time
after the VM issues USBDEVFS_RESET.  The device is not strictly
compliant (it should continue answering IN tokens), but this class of
USB banking token is widely deployed in enterprise environments, and
the regression breaks a configuration that previously worked.

The 18-byte GET_DESCRIPTOR that runs after SET_ADDRESS (wLength=18)
is unaffected: the device sends the full 18 bytes as 8 + 8 + 2, and
the final 2-byte packet is always a short packet regardless of
maxpacket.  This is why the device completes initial enumeration yet
hangs on reset re-enumeration.

Fix this by removing the "if (initial)" guard so that the ep0
maxpacket size is re-guessed on every reset, and by calling
usb_ep0_reinit() right after the maxpacket size is re-guessed so that
the re-guessed value is applied to hardware before the GET_DESCRIPTOR
data stage.

Fixes: ff33299ec8bb ("USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Pengfei Lv <lvpengfei20@huawei.com>

---

v4: Per further review by Alan Stern, move the usb_ep0_reinit() call
to right after the ep0 maxpacket re-guess block.  Each layer does the
right thing on its own side.

v3: https://lore.kernel.org/linux-usb/20261109093935.2634235-1-lvpengfei20@huawei.com/
---
 drivers/usb/core/hub.c | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 199d3f535a89..e3d8ee3271cb 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4969,33 +4969,33 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 	}
 	oldspeed = udev->speed;
 
-	if (initial) {
-		/* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
-		 * it's fixed size except for full speed devices.
+	/* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
+	 * it's fixed size except for full speed devices.
+	 */
+	switch (udev->speed) {
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:
+		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
+		break;
+	case USB_SPEED_HIGH:		/* fixed at 64 */
+		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
+		break;
+	case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
+		/* to determine the ep0 maxpacket size, try to read
+		 * the device descriptor to get bMaxPacketSize0 and
+		 * then correct our initial guess.
 		 */
-		switch (udev->speed) {
-		case USB_SPEED_SUPER_PLUS:
-		case USB_SPEED_SUPER:
-			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
-			break;
-		case USB_SPEED_HIGH:		/* fixed at 64 */
-			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
-			break;
-		case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
-			/* to determine the ep0 maxpacket size, try to read
-			 * the device descriptor to get bMaxPacketSize0 and
-			 * then correct our initial guess.
-			 */
-			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
-			break;
-		case USB_SPEED_LOW:		/* fixed at 8 */
-			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(8);
-			break;
-		default:
-			goto fail;
-		}
+		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
+		break;
+	case USB_SPEED_LOW:		/* fixed at 8 */
+		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(8);
+		break;
+	default:
+		goto fail;
 	}
 
+	usb_ep0_reinit(udev);
+
 	speed = usb_speed_string(udev->speed);
 
 	/*
-- 
2.34.1

