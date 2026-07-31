Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201E35C698
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490042; cv=none; b=QD03HpyoM4WhuMlB+ZEe3eoVtjBzwqEZsjuDqPUE7yh/qbjVVZMJIHv3DiYFoueiAWZ0yeYXlrObryZ6Jj1Fecjr3BdsdMYR3kWXWhQ40Xm60MqCIdqyrHCP6kCK2eI9rR3WqH2V9iNyvQTD9LiihcEzFhHm9S9XQWpYr39fhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490042; c=relaxed/simple;
	bh=hqZihM8hK+I8nFhpFn08kRiurxV1utL6Ta1OJMrFiIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GMIwRMcTW29DNfINueU60RqNsyr28uEbtapNTDm+ey/AF26W69xMXfc/C7pC//x6Rr1JsmnGvo8DMueDkKRa46fQY63R/mn0i1/Y8Hv6HfpNkWBhh7Wm56FsXWKGJs8vtsFLfj4Zu4wKY+6cfkioPiNNS5jSk0ahK4++1olvxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AP2Ra4my; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AP2Ra4my"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785490040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+h/M58pkHioJJHeT49LZUSs+akm76z/lS6bXu9sSoX0=;
	b=AP2Ra4myYgWDucaLbVeOrsaWKW3TeJs00xANQWt7M3CnFz1YI21QmW85jqqH7YLywzPP5T
	bHbOeucQVSzrjlimTvJ9b3xuOVI4t394Y1rpsJrDbMCn1zcnOOd3G4xTwrP7b07yeUNA+d
	M236rDvukCXN0fz6qoFmgzsT39H+rSI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-LD-_2h9BNHeGDPWYwuGc9w-1; Fri,
 31 Jul 2026 05:27:16 -0400
X-MC-Unique: LD-_2h9BNHeGDPWYwuGc9w-1
X-Mimecast-MFC-AGG-ID: LD-_2h9BNHeGDPWYwuGc9w_1785490035
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AB2E1800350;
	Fri, 31 Jul 2026 09:27:15 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2EE741800480;
	Fri, 31 Jul 2026 09:27:13 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Stefano Brivio <sbrivio@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org,
	Laurent Vivier <lvivier@redhat.com>,
	jarod@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH net v3] usbnet: cap max_mtu for drivers without bind callback
Date: Fri, 31 Jul 2026 11:27:11 +0200
Message-ID: <20260731092711.857684-1-lvivier@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

usbnet_probe() initializes max_mtu to ETH_MAX_MTU and only caps it
inside the if (info->bind) block. Drivers without a bind callback
never enter this block, so max_mtu stays at ETH_MAX_MTU.

QEMU's usb-net device (0x0525/0xa4a2) is claimed by the cdc_subset
driver which has no bind callback. The guest accepts any MTU from DHCP
(e.g. 65520 from passt), leading to TCP segments that exceed the
device's 2048-byte receive buffer and are silently dropped.

Initialize max_mtu to net->mtu at probe time and update it inside
the bind block.

Fixes: f77f0aee4da4 ("net: use core MTU range checking in USB NIC drivers")
Cc: jarod@redhat.com
Cc: stable@vger.kernel.org
Link: https://gitlab.com/qemu-project/qemu/-/issues/3268
Link: https://bugs.passt.top/show_bug.cgi?id=189
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v3:
    - set max_mtu to ETH_MAX_MTU under if (info->bind) before calling
      info->bind()
    v2:
    - Set max_mtu to net->mtu at init, update inside bind
    - Fix Fixes tag to f77f0aee4da4

 drivers/net/usb/usbnet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 25518635b7b7..a19ecf718f36 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1794,7 +1794,7 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 	 */
 	dev->hard_mtu = net->mtu + net->hard_header_len;
 	net->min_mtu = 0;
-	net->max_mtu = ETH_MAX_MTU;
+	net->max_mtu = net->mtu;
 
 	net->netdev_ops = &usbnet_netdev_ops;
 	net->watchdog_timeo = TX_TIMEOUT_JIFFIES;
@@ -1804,6 +1804,7 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 	// allow device-specific bind/init procedures
 	// NOTE net->name still not usable ...
 	if (info->bind) {
+		net->max_mtu = ETH_MAX_MTU;
 		status = info->bind(dev, udev);
 		if (status < 0)
 			goto out1;
-- 
2.54.0

