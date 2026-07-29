Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2913D9DA0;
	Wed, 29 Jul 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338593; cv=none; b=FMKBADPmuWGsCxHMEhIxQydYCoKgq/bFlTRUiBYzCpcngg5dzx+Rg4j2Tp1sVa1twVd0kragGJJPJlSSpjTYCi3aid3r6/bJOHeF1Y4Xzg2DOL0LkombERzoeAILq4e0LkconEO1tjgi7cEg2xaK+EJABoOIWiZipCiTw1xKuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338593; c=relaxed/simple;
	bh=r/yey11PwuQaiKdNacCXZYcIRFP9DChos4riXWM+zTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grJTb/aQqYdU0mGTfM4BAM8EbWKBfo4DXpkl6NDuDOepxNKzCR6pkJIH2u4aYVuYVpvg1Iyl4/a0wkNg9fQcJmXg/OoLhlpizTTG+N0ywrXcBXuR66w4UnL8cHHQv4QnCsbHWmneh9nQhzQXljsctXLB6R8dEV4d13nyQldkp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=RLB2XXdN; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=RLB2XXdN; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="RLB2XXdN";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="RLB2XXdN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338590; bh=r/yey11PwuQaiKdNacCXZYcIRFP9DChos4riXWM+zTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RLB2XXdN5qIaw6g1fDHUcpZ6H3D9Ab9mLN1PEeeBYaNlA9FKLVxmZgwxQ6bF2/4vU
	 s2S5PfZ91efuDIBB5JYZroIh/2O1CT+DSbD1psPo+O6temrl+UH2L2pWh6E10S4ot3
	 jHreeQxe3FOU3Ux3HLvZBIhrkFwasHfe9xfj/7IBcFOf41L1k8VRd7VB1m1pwQ4bE8
	 X72Pu17C4yMKGHtaKTOWJsHiyFwfz5mZ1MF0KsvrLCk9catTc8pCQ9X+mBB3Tz//LQ
	 SR1EOLYmVDqd8Iu9R7G1/Q/em6Ild+ZuydHnQvVRF2QvkCDr1xRGRsSolN02uw++qF
	 8mzDlLsBNl0Rw==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id D208142532; Wed, 29 Jul 2026 16:23:10 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338590; bh=r/yey11PwuQaiKdNacCXZYcIRFP9DChos4riXWM+zTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RLB2XXdN5qIaw6g1fDHUcpZ6H3D9Ab9mLN1PEeeBYaNlA9FKLVxmZgwxQ6bF2/4vU
	 s2S5PfZ91efuDIBB5JYZroIh/2O1CT+DSbD1psPo+O6temrl+UH2L2pWh6E10S4ot3
	 jHreeQxe3FOU3Ux3HLvZBIhrkFwasHfe9xfj/7IBcFOf41L1k8VRd7VB1m1pwQ4bE8
	 X72Pu17C4yMKGHtaKTOWJsHiyFwfz5mZ1MF0KsvrLCk9catTc8pCQ9X+mBB3Tz//LQ
	 SR1EOLYmVDqd8Iu9R7G1/Q/em6Ild+ZuydHnQvVRF2QvkCDr1xRGRsSolN02uw++qF
	 8mzDlLsBNl0Rw==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 329A54252A;
	Wed, 29 Jul 2026 16:23:10 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jarod Wilson <jarod@redhat.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/15] media: redrat3: Ensure rc device is freed if enable_detector() fails
Date: Wed, 29 Jul 2026 16:22:40 +0100
Message-ID: <c990550a359e936cafb2ebb80b2b55974f557339.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This particular error path does not free the rc device at all, with
its priv pointer still pointing at freed memory.

Fixes: 2154be651b90 ("[media] redrat3: new rc-core IR transceiver device driver")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/redrat3.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 3f828a564e19..2b639fe59923 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -979,6 +979,7 @@ static int redrat3_dev_probe(struct usb_interface *intf,
 	struct usb_endpoint_descriptor *ep_narrow = NULL;
 	struct usb_endpoint_descriptor *ep_wide = NULL;
 	struct usb_endpoint_descriptor *ep_out = NULL;
+	struct rc_dev *rc = NULL;
 	u8 addr, attrs;
 	int pipe, i;
 	int retval = -ENOMEM;
@@ -1102,26 +1103,31 @@ static int redrat3_dev_probe(struct usb_interface *intf,
 	if (retval)
 		goto redrat_free;
 
-	rr3->rc = redrat3_init_rc_dev(rr3);
-	if (!rr3->rc) {
+	rc = redrat3_init_rc_dev(rr3);
+	if (!rc) {
 		retval = -ENOMEM;
 		goto led_free;
 	}
 
+	rr3->rc = rc;
+
 	/* might be all we need to do? */
 	retval = redrat3_enable_detector(rr3);
 	if (retval < 0)
-		goto led_free;
+		goto rc_free;
 
 	/* we can register the device now, as it is ready */
 	usb_set_intfdata(intf, rr3);
 
 	return 0;
 
+rc_free:
+	rc_unregister_device(rc);
 led_free:
 	led_classdev_unregister(&rr3->led);
 redrat_free:
 	redrat3_delete(rr3, rr3->udev);
+	rc_free_device(rc);
 
 no_endpoints:
 	return retval;
-- 
2.55.0

