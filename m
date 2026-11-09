Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217235;
	b=O3dsijkIsTxl/zBVLu0fukIhFUUL3hO+nHAJPcIxOlnI6pJVWdjZFJ0W5bXbZ3pCdFm6
	 y3T0bK8tZhu2LiUZM6mdahsscferzmSeIGJK2NGthd9S9JvG0klIlEREd76UW0TZXrXG2
	 SoG3ZUpjPRQj/D1Migp9GLp5BtPuxMVkSp1/aheUjS/FZn9GEOBeUlzZHlRcAvId3rkes
	 vjSCWyBeQwJs6xJcpJfoDj4rHGBfPvQS5PZYCegLCfiPv/jnBeZs87hTU1QBszQjeHfby
	 eQTlfbda+YyZ5PAcgDSOpGNJONG4spP7LmhQHSBn44VwOYr/Znrzoc31NEFg6f4i8Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217235;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=dDWEgytPPKV+HivhmAiQbllvi873e/vHkc9VeSbfZaA=;
	b=JhKjIiHPHj+WvvZYhWZG4ZxP7cTN/IW8zkhlmCXR+M1Kjfwa/nMkQ9FF2ENKZ7bq11jq
	 zfF6HS3ZYeZeSQ3V+iMZoZc7vpmB7/dwg6iG5aMs4DHQU9w46kc9WQnYXvLkfkBZdfYDF
	 FrPadFsd9XJI6K+CLn27pc47ZczzCfuH2jLaVhs2vZPvdBtBd6ldAJWGkaALhLAqPREE6
	 WbqZuVx1e5Up+/3zxMIxOyf6DbVL2LpHH7/aBp+u3ABcAkXKjRjIgbOZKM5HxsavRFTHd
	 9HndE+IBDsLRbNU4uoBVS2uGyep599dZx2gKz7VBXShDpDwCQT1k3Dcw7Is+7vgsmpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vNgPCbao;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F36606A323;
	Mon,  9 Nov 2026 09:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34F36606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vNgPCbao
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dDWEgytPPKV+HivhmAiQbllvi873e/vHkc9VeSbfZaA=;
	b=vNgPCbaoamGgr1YIYPnbh1Q2JgGBeBa2zgZQAQBiCCRVKLEO9SxwNdAUPwQJDF6s+rhwjwSyD
	p6LMnhC1QiSCzmaHkr65lMQBQFtMKYjv/DT65pQYc7p2Tj8onuV9zRaeH2WuFP7QIDdQENHScGR
	yHQjN3TlSV79Jv3aSExi0Gk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jNPry28cSz1T4Fv;
	Mon,  9 Nov 2026 17:40:02 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 247114056D;
	Mon,  9 Nov 2026 17:40:29 +0800 (CST)
Received: from vm.huawei.com (7.238.34.231) by whupemk100010.china.huawei.com
 (7.152.184.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 9 Nov
 2026 17:40:28 +0800
From: Pengfei Lv <lvpengfei20@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stern@rowland.harvard.edu>, <michal.pecio@gmail.com>,
	<stable@vger.kernel.org>, <xuhaiyang5@hisilicon.com>, <xuetao09@huawei.com>,
	<caiyadong@huawei.com>, <suzhuangluan@hisilicon.com>, Pengfei Lv
	<lvpengfei20@huawei.com>
Subject: [PATCH v3] usb: core: hub: Re-guess ep0 maxpacket size after reset
Date: Mon, 9 Nov 2026 17:39:35 +0800
Message-ID: <20261109093935.2634235-1-lvpengfei20@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106031625.1824732-1-lvpengfei20@huawei.com>
References: <20261106031625.1824732-1-lvpengfei20@huawei.com>
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
usb_ep0_reinit() before each device-descriptor read so that the
re-guessed value is applied to hardware before the GET_DESCRIPTOR
data stage.

Fixes: ff33299ec8bb ("USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Pengfei Lv <lvpengfei20@huawei.com>

---

v3: Per review by Alan Stern and Michal Pecio, drop the !initial guard
and move the usb_ep0_reinit() calls from after the re-guess block to
right before each get_bMaxPacketSize0() invocation, so that ep0 is
re-initialised before every descriptor read.  The commit message is
reworded to be HCD-agnostic.

v2: https://lore.kernel.org/linux-usb/20261106031625.1824732-1-lvpengfei20@huawei.com/
---
 drivers/usb/core/hub.c | 52 +++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 199d3f535a89..d86bbba1457c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4969,31 +4969,29 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
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
 
 	speed = usb_speed_string(udev->speed);
@@ -5062,6 +5060,9 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 				goto fail;
 			}
 
+			/* Sync the guessed ep0 maxpacket size to hardware if needed */
+			usb_ep0_reinit(udev);
+
 			maxp0 = get_bMaxPacketSize0(udev, buf,
 					GET_DESCRIPTOR_BUFSIZE, retries == 0);
 			if (maxp0 > 0 && !initial &&
@@ -5127,6 +5128,9 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 		if (do_new_scheme)
 			break;
 
+		/* Sync the guessed ep0 maxpacket size to hardware if needed */
+		usb_ep0_reinit(udev);
+
 		maxp0 = get_bMaxPacketSize0(udev, buf, 8, retries == 0);
 		if (maxp0 < 0) {
 			retval = maxp0;
-- 
2.34.1

