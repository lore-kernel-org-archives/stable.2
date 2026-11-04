Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796289;
	b=Y5CMzTn2Q1r5fXyR5EQ7uyQRSzECx55G7guO52TsopHH1zAPnutwwYBYTQbfJs5ogJWX
	 /Cb53bDyhqEBxyABOG/2eEC4lpgQusnVFSzhPgcU5XjPy2FDD/EZm1J9SAT90oPABi+hu
	 69pi5pR6O8KVC3+T0BzYRNgOCNfssVMPUsmILaproUmWVhPALx/ZGU75U5o+UndNUyXT4
	 fLQ5lIxNzAjNPmrZofYK2gm3DC92CpceCzAzxal5zu7SBKgOhNpVjz8Q4u0+pbErDP6QE
	 nVi0cDhO68OknC/yJSmuZEi1b5ZecIqeFDIAjHLuLd5CX5VDWaqdf2sXE57StZJ1HGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796289;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=E7Vw/XE5thAVyI3TZeFiM04oOjnhXJsy/OqySkvTrQQ=;
	b=Yx5Ja4nO/ON3ktGKvAtCiI/lXwHipx31mx6WmnVZG0eu8sLX6n6p7/SKv/XbYFy+or48
	 vybrJHtz3AUA1JgMxIlrVu79WCO1CBwnnce+WUeLIaxHRb2vnCqNOOHUAOSzHef1NiJT1
	 1CL6kGTZddjPmyoqmB1HDNdamSoartRjp6k46lmLiDST/WvsMzJTAyPrJDG3EOI/mvKlp
	 4onQobwpz4l+uI/PWL2eroA/tDZULxfHt4MLKYHSjldaUAeu3OuqwCWImNoGzKXqaRBAP
	 KsvDHDjNF9epQIUhZliiY3U0QqQuGp0qfdjigbQuCxpiD7QfFH3Xq4IocVy1WVfdmLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=qV222pOf;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C0606A339;
	Wed,  4 Nov 2026 12:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E47C0606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=qV222pOf
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=E7Vw/XE5thAVyI3TZeFiM04oOjnhXJsy/OqySkvTrQQ=;
	b=qV222pOffz4XdiVtpWlxIi+W+hNXn/YAUcK1nndQSUvuKi4iuZOC3b9Noqn3XuawVwEcA4Z23
	mAX/IulpkKSKC1aK28T6wjGvRTNKam3HShwQBj1l0Uf/8XYJUd10YSYdVPypsM8/9Ukzea+4sem
	Rutfl2N2antt2dxRKnjIPQg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jKQB61xQCzmVBl;
	Wed,  4 Nov 2026 20:44:30 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 11CAD40578;
	Wed,  4 Nov 2026 20:44:41 +0800 (CST)
Received: from vm.huawei.com (7.238.34.231) by whupemk100010.china.huawei.com
 (7.152.184.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 20:44:40 +0800
From: Pengfei Lv <lvpengfei20@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<xuhaiyang5@hisilicon.com>, <xuetao09@huawei.com>, <caiyadong@huawei.com>,
	<suzhuangluan@hisilicon.com>, Pengfei Lv <lvpengfei20@huawei.com>
Subject: [PATCH] usb: core: hub: Re-guess ep0 maxpacket size on reset
Date: Wed, 4 Nov 2026 20:44:02 +0800
Message-ID: <20261104124402.1269650-1-lvpengfei20@huawei.com>
X-Mailer: git-send-email 2.34.1
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk100010.china.huawei.com (7.152.184.41)

Per USB 2.0 spec section 5.5.3, the ep0 maxpacket size is fixed for
all device speeds except full-speed devices, where it can be 8, 16,
32, or 64 bytes and can only be determined by reading the device
descriptor.  During the initial enumeration of a full-speed device,
the USB core guesses 64 bytes (hub_port_init() with initial=true);
after reading the descriptor, the real value (e.g. 8) is stored in
udev->ep0.desc.wMaxPacketSize and propagated to the xHCI ep0 context
via an Evaluate Context command (xhci_check_maxpacket()).

After a port reset (usb_reset_and_verify_device() -> hub_port_init()
with initial=false), the "if (initial)" guard added by commit
ff33299ec8bb ("USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()") skips the ep0 maxpacket
guess block, so udev->ep0.desc.wMaxPacketSize retains the real value
(e.g. 8).  The xHCI Reset Device command preserves the ep0 context
as well, so the xHC ep0 max_packet also stays at 8.

When the subsequent re-enumeration then uses the "new scheme" and
issues a 64-byte GET_DESCRIPTOR (get_bMaxPacketSize0 with size=64),
xhci_check_maxpacket() sees hw==sw==8 and does not issue an Evaluate
Context command.  The xHC queues a Data TRB of length 64 but applies
ep0 max_packet=8 for short-packet detection.  If the device's first
data packet is exactly 8 bytes and it sends no ZLP, the xHC does not
recognise a short packet, keeps issuing IN tokens for the remaining
56 bytes, and the control transfer hangs in the Data stage until URB
timeout.  (A standard 18-byte descriptor returned as 8+8+2 is not
affected because the final 2-byte packet is a short packet.)

Fix this by removing the "if (initial)" guard so that the ep0
maxpacket size is re-guessed from udev->speed on every reset.  For
full-speed devices this re-establishes the 64-byte guess, which makes
xhci_check_maxpacket() issue an Evaluate Context command that brings
the xHC ep0 context back to max_packet=64 before the GET_DESCRIPTOR
data stage; the data stage then terminates correctly via short-packet
detection, and the ep0 maxpacket is subsequently corrected to the
real value as usual.

For high-speed, low-speed, and SuperSpeed-or-faster devices the
re-guess is a no-op (guessed value equals the fixed real value).
The descriptor-immutability checks (!initial && maxp0 !=
udev->descriptor.bMaxPacketSize0) remain unchanged.

Fixes: ff33299ec8bb ("USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Pengfei Lv <lvpengfei20@huawei.com>
---
 drivers/usb/core/hub.c | 46 ++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 199d3f535a89..51f66b24b353 100644
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
-- 
2.34.1

