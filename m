Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1AA40E8E5
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901123; cv=none; b=CFIFtVXcly9BCeplU2SFTttgEPAzmwjQ93rmABgk6FKAhuABjpA7RHChTJQ2oIt30E5ZOOh0r1Yz/ywbtoa+r07b/PCBAZVQmTSx9tXzeffBdtUUGVtNuQS/G4acCfDvg5+jdD4b7JgJLlmxXqkASBl72a+Pk2U24V15q03EPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901123; c=relaxed/simple;
	bh=dTmqjJ1A0rx0L3Yz5VKymYbyJYy+f3YeiDTHTuNs6Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T37TSwGpNQCJDqJjCE3XzKZyRU1sJj0jGSWT/2fy5zn925T0sZ5bO4s2Dc4mFyzxv6nRZ4iS3SW0bh64Kb4t7bIB72VLGJ6ksgjbRYx2iWozQbq+drd/h7b01onZt+gDgoFgMcUJjOfWb6btdo4VDxOZnceE8cEolK1XdlXxTAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKNOVojN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKNOVojN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782901120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3K0jYSno9pP21YqICBjADCSbE+ZxELgscbZYlBI/F54=;
	b=aKNOVojNM442gZrE54TIISg5xgxbbPkMcDMn8xOguU7z7QY9l8LIPj/sLz4M+c79OYszrC
	ZP+iPnHC9kwSBKFrQm2Bbvl8J/NAe8c/B0JErFxG5YWK/CD0Axef04v7p2vqw6BCu5bGuc
	V0ot5GjxfzZQp8Ks/7KIFIA2c7zBfC4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-7aHYyTceN7mOHTTJYLjKJQ-1; Wed,
 01 Jul 2026 06:18:37 -0400
X-MC-Unique: 7aHYyTceN7mOHTTJYLjKJQ-1
X-Mimecast-MFC-AGG-ID: 7aHYyTceN7mOHTTJYLjKJQ_1782901116
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FF4A195C242;
	Wed,  1 Jul 2026 10:18:36 +0000 (UTC)
Received: from nixos.redhat.com (unknown [10.44.49.208])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D03D36936;
	Wed,  1 Jul 2026 10:18:33 +0000 (UTC)
From: Sascha Grunert <sgrunert@redhat.com>
To: linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sascha Grunert <sgrunert@redhat.com>
Subject: [PATCH 2/2] usbip: block SET_INTERFACE for isoc alt settings
Date: Wed,  1 Jul 2026 12:18:26 +0200
Message-ID: <20260701101826.894848-3-sgrunert@redhat.com>
In-Reply-To: <20260701101826.894848-1-sgrunert@redhat.com>
References: <20260701101826.894848-1-sgrunert@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

USB/IP cannot forward isochronous transfers. When the client activates
an alt setting with isoc endpoints, the transfers fail with -EPROTO and
the resulting usb_clear_halt cascade disconnects the device.

Intercept SET_INTERFACE in tweak_set_interface_cmd() and fake success
when the target alt setting contains isoc endpoints, keeping the device
at alt 0.

Tested with a Turtle Beach Velocity One Flight yoke (10f5:7001)
forwarded to a VM via USB/IP, which previously disconnect-looped every
few seconds and now stays connected.

Cc: stable@vger.kernel.org
Signed-off-by: Sascha Grunert <sgrunert@redhat.com>
---
 drivers/usb/usbip/stub_rx.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index d0e3d3f..f323b48 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -100,6 +100,28 @@ static int tweak_clear_halt_cmd(struct urb *urb)
 	return ret;
 }
 
+static bool altsetting_has_isoc(struct usb_device *udev, __u16 interface,
+				__u16 alternate)
+{
+	struct usb_interface *intf;
+	struct usb_host_interface *alt;
+	int i;
+
+	intf = usb_ifnum_to_if(udev, interface);
+	if (!intf)
+		return false;
+
+	alt = usb_altnum_to_altsetting(intf, alternate);
+	if (!alt)
+		return false;
+
+	for (i = 0; i < alt->desc.bNumEndpoints; i++) {
+		if (usb_endpoint_xfer_isoc(&alt->endpoint[i].desc))
+			return true;
+	}
+	return false;
+}
+
 static int tweak_set_interface_cmd(struct urb *urb)
 {
 	struct usb_ctrlrequest *req;
@@ -111,6 +133,20 @@ static int tweak_set_interface_cmd(struct urb *urb)
 	alternate = le16_to_cpu(req->wValue);
 	interface = le16_to_cpu(req->wIndex);
 
+	/*
+	 * USB/IP cannot forward isochronous transfers.  If the requested
+	 * alt setting activates isochronous endpoints, pretend the switch
+	 * succeeded without touching the device.  This prevents the
+	 * cascade of failed isoc URBs that leads to a device disconnect.
+	 */
+	if (alternate != 0 && altsetting_has_isoc(urb->dev, interface,
+						  alternate)) {
+		dev_info(&urb->dev->dev,
+			 "usb_set_interface blocked: inf %u alt %u (isoc)\n",
+			 interface, alternate);
+		return 0;
+	}
+
 	usbip_dbg_stub_rx("set_interface: inf %u alt %u\n",
 			  interface, alternate);
 
-- 
2.52.0

