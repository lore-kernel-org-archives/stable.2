Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794689418;
	b=MzROtlRw07PHsqiKOKbL9JigdAa0to63Cy5MkbOnjN9ol8Ie+Vdig5ympafNTIy+Ix90
	 v0fFK6agY6O5vqq/aGul6vEwaWSVF/mjz+yWk05WgroZsEoW9bpQM6wrchgFgBObCR0Fn
	 4Vm4riYH26Q33LbwQB13WlwPBai4ViQcMhZMJG+C2wWW7qo670EO8mREddyhf8lEUphef
	 FESJ0Qj+ieNTHNleJ/uYZclR3xBi831MAQqO+BB7Zg9iu5DuoX6Ppgop2h0V3Qfq5YZgg
	 /5ERFbp24a4ZPeVFv77ISFQgIheW+kbi1LimArplXx/Qbtm/CKoTgOIX0telIuJf6Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689418;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Ti0JWkIkKPgSVJO+xE5HKdSUB2nbIRtCDPD5HTD8o0Y=;
	b=c76AzYi8beF4B9bBm3D0G2+1TMmmsOjQ5HxwVC2NiwZeF6GPKf9yfDdK1XfrwFRKCywK
	 d8/niS8rCdzg5J5LYtUTTBLmfRshicCMmBP4k/x0hQ7F7sRrZVbqjBmWgqnQeZOLWM+jk
	 w/3gGzai0hNXzTyX1uouiK4u+XOEwCyeKKLIuuagzc/0ksGQI8YtpLYwXA8RoucTAKZMT
	 k6y8bU/RXRhv+sJ8v0uMCbns5WIc3/tdxVkb35MXg32FlkoIH97FbrRw7g2r7jUJnXcQP
	 WgKZXI6ujV1LkNCOB7rvq70gurEneIMUb/nUyy3TUF2GF/fE9LEVtofHhOF0wk1W+HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LxBUgqKW;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB1606A329;
	Sat, 14 Nov 2026 20:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71DB1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LxBUgqKW
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6D5822022EA;
	Sat, 14 Nov 2026 21:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti0JWkIkKPgSVJO+xE5HKdSUB2nbIRtCDPD5HTD8o0Y=;
	b=LxBUgqKWmDSXZSi0182q69XSK0cZr7XQrr+Y2IDKkjiF4VWztyVDilVpYRoroYOCDtsZVS
	wxeyATRf+DTaFzu6w3t8s+S+qw5LNBhNTQYckXOWlxhh8qfDpYD/dFCmoGF+MhKrVvphVN
	TF7i6gehPhHGN1slCi5qr59bNQL0AKgL7X+zDdO1/50R36t/i5GPfU2XyCID+lU2iG9+1v
	5PLDd8a71AtoSw0Cne+tpxwqkyFRjv/ACcxMK92iNGPS08P5ftyZsDHdrGMfn7TlkgZx8B
	kDsPhe0rzXnBuIEQqxicyRnlj8sHYWiK/3Veshi+XPjF8xwJhOA7nPBd6x94Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti0JWkIkKPgSVJO+xE5HKdSUB2nbIRtCDPD5HTD8o0Y=;
	b=MvKDxKUW/vcZ6SEMJ3F0Q41pFoUW8zEx6ek5sRo7DQ1/GiIAT3O1HiEMDvzjQeYADpnTnk
	5bb7ExlW9cFQzCnA0x4sVMtV1/nvlHEX/RjmO44UUx/CL039UL2d84OK+htulVx1IBRC5q
	WsUBqnCbriyQZO/s/quB9Eudp5KwuZJDR7jyzdQ0pHb+pn5AG55Zi533hVFQR+awVrYos5
	YH60563VsNsccbxAlp1mGV/09mXmDrUKxeHauOB+Kshw5lZf0k+5nndj0XLrOgbUHjqp40
	R7jT+dQ5+YOYYAfFbfCFQLow6FW62BTOqVFVvmYVkBnbCLncby71oPuYbfklLg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794689415; a=rsa-sha256;
	cv=none;
	b=gM0fRy/dp1sf+kg3v4qk3HWeedobLL5/YgvDZPLCRRHSW0GGeVPVkiShzmkIgaGhG0o7Di
	PZqBzzgP3HUGWYQlfweKQaB6ry72rPUoQfVqatR1D6vylBkiLWUMyQ61PHzX3P9qWJtK51
	yg4rsngYkGXLRT8Vw21BbCbpF05v7j9uilbP0Mbet2aAe+eU9fbltqBxSMSrJ6DM+pXsvl
	gJO4IC96AWjH1HkPawO39MjFr4tDRjJFKOG763fGVMoJT2WnRB7kMi4m1cezZ3B5TYViRU
	Js8qtj8605EgsTOrVNuyX7rHyeh85hZvypsNvviJHXxQulMjWq7Aewpv+YhLKQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSKhT-004BfK-0x;
	Sat, 14 Nov 2026 21:50:15 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 097065EBD70;
	Sat, 14 Nov 2026 20:50:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 21:49:56 +0100
Subject: [PATCH can-next v8 2/7] can: gs_usb: gs_usb_probe(): init netdev
 completely before register_candev()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-gs_usb-fixes-v8-2-f615502b005b@pengutronix.de>
References: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=4199; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=HP0EDW+WYKMQf1wWMtYGpxOpElxHWNwuHeeJfWjuVy8=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cbK+++fknFeWOfvuTnPs4zlkMXvxoodG0lvyCtjlb
 UpPCpmHdJSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAi01MZGS6/qNI43fk7fouW
 ktziOXrLjZovee+dP2W+wc9JDEue7VzLyLD03qV1Xs7mDQm5s2bd8JaPC1yukP/05O006Z88RxN
 KDjECAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

In gs_usb_probe(), gs_make_candev() is called to allocate and set up the
CAN channel, as well as to call register_candev(). However, gs_usb_probe()
defers the assignment of dev->parent and parent->hf_size_rx until after
gs_make_candev() returns. This opens a race window for the user space to
bring up the CAN interface, while it's not completely setup.

To close the race window, initialize all CAN interfaces in a first loop and
then register them in a second loop: Don't call register_candev() from
gs_make_candev() but explicitly from gs_usb_probe(). Adjust
gs_destroy_candev() likewise, move unregister_candev() to
gs_usb_disconnect() and the error paths in gs_usb_probe(), to keep it
inverse to symmetric to gs_make_candev().

Closes: https://sashiko.dev/#/bug/linux-be54de7d-0b75-408c-b3ee-dd90c9756857
Closes: https://sashiko.dev/#/bug/linux-71076d59-0843-4749-a5ab-fdd98a08582f
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 64 +++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index cac4ce323a1d..6997cc8a6b2d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1493,18 +1493,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
-	rc = register_candev(dev->netdev);
-	if (rc) {
-		dev_err(&intf->dev,
-			"Couldn't register candev for channel %d (%pe)\n",
-			channel, ERR_PTR(rc));
-		goto out_can_rx_offload_del;
-	}
-
 	return dev;
 
-out_can_rx_offload_del:
-	can_rx_offload_del(&dev->offload);
 out_free_candev:
 	free_candev(dev->netdev);
 	return ERR_PTR(rc);
@@ -1512,7 +1502,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 static void gs_destroy_candev(struct gs_can *dev)
 {
-	unregister_candev(dev->netdev);
 	can_rx_offload_del(&dev->offload);
 	free_candev(dev->netdev);
 }
@@ -1590,21 +1579,16 @@ static int gs_usb_probe(struct usb_interface *intf,
 
 	for (i = 0; i < icount; i++) {
 		unsigned int hf_size_rx = 0;
+		struct gs_can *dev;
 
-		parent->canch[i] = gs_make_candev(i, intf, &dconf);
-		if (IS_ERR_OR_NULL(parent->canch[i])) {
+		dev = gs_make_candev(i, intf, &dconf);
+		if (IS_ERR_OR_NULL(dev)) {
 			/* save error code to return later */
-			rc = PTR_ERR(parent->canch[i]);
+			rc = PTR_ERR(dev);
 
-			/* on failure destroy previously created candevs */
-			icount = i;
-			for (i = 0; i < icount; i++)
-				gs_destroy_candev(parent->canch[i]);
-
-			usb_kill_anchored_urbs(&parent->rx_submitted);
-			kfree(parent);
-			return rc;
+			goto out_gs_destroy_candev;
 		}
+		parent->canch[i] = dev;
 		parent->canch[i]->parent = parent;
 
 		/* set RX packet size based on FD and if hardware
@@ -1624,7 +1608,37 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
 	}
 
+	for (i = 0; i < icount; i++) {
+		struct gs_can *dev = parent->canch[i];
+
+		rc = register_candev(dev->netdev);
+		if (rc) {
+			const unsigned int cur = i;
+
+			dev_err(&intf->dev,
+				"Couldn't register candev for channel %d (%pe)\n",
+				i, ERR_PTR(rc));
+
+			for (i = 0; i < cur; i++)
+				unregister_candev(parent->canch[i]->netdev);
+
+			goto out_gs_destroy_candev;
+		}
+	}
+
 	return 0;
+
+out_gs_destroy_candev:
+	for (i = 0; i < parent->channel_cnt; i++) {
+		if (!parent->canch[i])
+			continue;
+
+		gs_destroy_candev(parent->canch[i]);
+	}
+
+	kfree(parent);
+
+	return rc;
 }
 
 static void gs_usb_disconnect(struct usb_interface *intf)
@@ -1640,8 +1654,10 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 	}
 
 	for (i = 0; i < parent->channel_cnt; i++)
-		if (parent->canch[i])
-			gs_destroy_candev(parent->canch[i]);
+		unregister_candev(parent->canch[i]->netdev);
+
+	for (i = 0; i < parent->channel_cnt; i++)
+		gs_destroy_candev(parent->canch[i]);
 
 	kfree(parent);
 }

-- 
2.53.0

