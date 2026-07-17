Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FBC3BE14D
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301396; cv=none; b=h5EJdnxuSeAPOG1FguMmTzWosyVSBnHs8XDjZOHwDGEWQZbETeM4WdCDhHQ7elR0CTiIuC0eVFJBJNeqm62YUAm9gkjevEh+4yJ9y1itsisL8QQwDqGqGajHoZK00gB+Q/JdLWVavaTo+4Op63PJyZORh3pjIl624gcId5PuRiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301396; c=relaxed/simple;
	bh=NNibbsMBzcBhzHKyyVyWoEjs9JNqg5eZd/fl/Nu8GEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOp5rhLp/rekHoaQRgylOKgMRvY2kGrVnHmiPjn1jAHhT+M7Uzqf3CsmfqgAlU5648/KdJ//4tIzr1zAqctU6iui8panQsaMnGUGuIYtSqggm+7QgCUk266UNTT7IY7ERZIUVe68IZKXSifKrhuXofiIG9C0i9JhsJq0YMDJbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXkjmYQ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXkjmYQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784301394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TRhb9mvNrRYyHgkhEJwct4IUo2+m3ly9XG+UwgjaINA=;
	b=bXkjmYQ3rvFSjX6TY3q4fHvN7jBKP1DwS41ueLPojKhvo9DK/ILi+YqULCojnKp06c4dgX
	dnW/vtWGr+2JbYoaVV6sMzL2MiO3inE2FaOwZ0hXrhpZlwjGFcsZwjxeO51xLcaL4MJwpG
	GxPAN3R/xtNOln6TtkKAMG2mwxiJ6pE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-dNHHZgzCNfWqsyxdkLZFtg-1; Fri,
 17 Jul 2026 11:16:30 -0400
X-MC-Unique: dNHHZgzCNfWqsyxdkLZFtg-1
X-Mimecast-MFC-AGG-ID: dNHHZgzCNfWqsyxdkLZFtg_1784301389
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CFF11955D8D;
	Fri, 17 Jul 2026 15:16:29 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 726A33004182;
	Fri, 17 Jul 2026 15:16:27 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	linux-usb@vger.kernel.org,
	Stefano Brivio <sbrivio@redhat.com>,
	Oliver Neukum <oneukum@suse.com>,
	Laurent Vivier <lvivier@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net] usbnet: cap max_mtu for drivers without bind callback
Date: Fri, 17 Jul 2026 17:16:26 +0200
Message-ID: <20260717151626.2913171-1-lvivier@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Commit c7159e960f14 ("usbnet: limit max_mtu based on device's hard_mtu")
caps max_mtu inside the if (info->bind) block in usbnet_probe(). Drivers
without a bind callback never enter this block, so max_mtu stays at
ETH_MAX_MTU.

QEMU's usb-net device (0x0525/0xa4a2) is claimed by the cdc_subset
driver which has no bind callback. The guest accepts any MTU from DHCP
(e.g. 65520 from passt), leading to TCP segments that exceed the
device's 2048-byte receive buffer and are silently dropped.

Move the max_mtu capping after the if/else block so it applies to all
usbnet drivers.

Fixes: c7159e960f14 ("usbnet: limit max_mtu based on device's hard_mtu")
Cc: stable@vger.kernel.org
Link: https://gitlab.com/qemu-project/qemu/-/issues/3268
Link: https://bugs.passt.top/show_bug.cgi?id=189
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/net/usb/usbnet.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 25518635b7b7..d87299025552 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1825,10 +1825,6 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 		if ((dev->driver_info->flags & FLAG_NOARP) != 0)
 			net->flags |= IFF_NOARP;
 
-		if ((dev->driver_info->flags & FLAG_NOMAXMTU) == 0 &&
-		    net->max_mtu > (dev->hard_mtu - net->hard_header_len))
-			net->max_mtu = dev->hard_mtu - net->hard_header_len;
-
 		if (net->mtu > (dev->hard_mtu - net->hard_header_len))
 			net->mtu = dev->hard_mtu - net->hard_header_len;
 
@@ -1851,6 +1847,10 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 		if (status == 0 && !usb_check_bulk_endpoints(udev, ep_addrs))
 			status = -EINVAL;
 	}
+	if ((dev->driver_info->flags & FLAG_NOMAXMTU) == 0 &&
+	    net->max_mtu > (dev->hard_mtu - net->hard_header_len))
+		net->max_mtu = dev->hard_mtu - net->hard_header_len;
+
 	if (status >= 0 && dev->status)
 		status = init_status(dev, udev);
 	if (status < 0)
-- 
2.54.0

