Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3C3DDAE1
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136996; cv=none; b=TNlpYe6aFHtCzc+tmLK/4YchqasAWcoJVXahGaqKmdYKPy9MEP3+kWim8pUc+5wGCvmbNqYnTApn2OyjWp2d1Vm2TLwzyDgpUU2ao797rXU10+TBpy8k3bwS7neXQ8nRlb6Qdnq2n5TiXtRf6yHVVC8tuD4Ipl2TTtu5WTeiR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136996; c=relaxed/simple;
	bh=oske5IT+0Jxt8FV9lY7qQB5fVx2GIoBK5TkJPNHjXz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hK6Xw4Y9pOjkk/L6FbnFNFIq2/koKNN+qe+uDQ6wJrTWrP42NgvvDt5tOe8WFWbaX4biKtDVoB/vyW04CqMx0aR622eXZ2hROLQOCx7OrObdy4Rb1L5yWU27nNWntOzd5Wg3xOUp++Fo4BE3Do+4DDkOFayH9kGSGKe65i54QQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiX1dNuH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiX1dNuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785136993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1YdMYbSNSRTLrXvkowbw8IdGzcoEefYu8TY9ARtQFCI=;
	b=GiX1dNuHgNEMgOb7XswDokHwMXyhKtSC9SV0qTBtjGZa/gi1ero8WnmEXyWBdM7ux5FgSK
	YBt7jnkLo9EmYufkjNAWZxmZ3+aXuKSYqrUutfdN7dRWBw66tmRgIKcgJssvUXQR+5JWpF
	NIqK1HYTiqhWDJVCnCuYXTwgb6vnEgM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-YD7OBC22Mqm8n8ZJWNTSyQ-1; Mon,
 27 Jul 2026 03:23:09 -0400
X-MC-Unique: YD7OBC22Mqm8n8ZJWNTSyQ-1
X-Mimecast-MFC-AGG-ID: YD7OBC22Mqm8n8ZJWNTSyQ_1785136988
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 206A0180121A;
	Mon, 27 Jul 2026 07:23:08 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF74D180057E;
	Mon, 27 Jul 2026 07:23:05 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	netdev@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org,
	Laurent Vivier <lvivier@redhat.com>,
	jarod@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH net v2] usbnet: cap max_mtu for drivers without bind callback
Date: Mon, 27 Jul 2026 09:23:04 +0200
Message-ID: <20260727072304.154608-1-lvivier@redhat.com>
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
the bind block based on the device's hard_mtu.

Fixes: f77f0aee4da4 ("net: use core MTU range checking in USB NIC drivers")
Cc: jarod@redhat.com
Cc: stable@vger.kernel.org
Link: https://gitlab.com/qemu-project/qemu/-/issues/3268
Link: https://bugs.passt.top/show_bug.cgi?id=189
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2:
    - Set max_mtu to net->mtu at init, update inside bind
    - Fix Fixes tag to f77f0aee4da4

 drivers/net/usb/usbnet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 25518635b7b7..9f11ca449aad 100644
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
@@ -1825,8 +1825,9 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 		if ((dev->driver_info->flags & FLAG_NOARP) != 0)
 			net->flags |= IFF_NOARP;
 
-		if ((dev->driver_info->flags & FLAG_NOMAXMTU) == 0 &&
-		    net->max_mtu > (dev->hard_mtu - net->hard_header_len))
+		if (dev->driver_info->flags & FLAG_NOMAXMTU)
+			net->max_mtu = ETH_MAX_MTU;
+		else
 			net->max_mtu = dev->hard_mtu - net->hard_header_len;
 
 		if (net->mtu > (dev->hard_mtu - net->hard_header_len))
-- 
2.54.0

