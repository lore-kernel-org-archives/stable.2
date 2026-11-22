Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373338;
	b=3TILOTkNAcTooCvdon+0uHPCKB/0Fm0BLdS86xpCGldeZ7VGVYKgukr97ZA/h3Oc4dkt
	 xMX8XSUAWzwfoF6/BRd6kVS1KUT6AzR9wBLyywe05JeOFXdURy4xgPp2IMXb2vyhIjfF5
	 djUZNNFlkZ4Wv14uysGxWXzrguRdJoOkSt2YNivk/8H9qTFBhEYQwKrVFJQggSH3hMTV7
	 Kzf4cBkqkRM9s8zyxmaSCB5oKvXpxG1heTIYQN2dvRgIWRBJXEylZ1DUNbXZSWQjfBr/R
	 1YD2DHJUUBW0/PedoZG178PKkyM1kNuiiJbTAHBn3qIrOR5J9nQDdkpxmWIb8q5wixA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373338;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9N2WNj7YVmlCUwAen74jHLg5hKAx6GwlKsGjT+YsiuU=;
	b=CzwD6GDn+l0o+nis8Eq/ydn1BCu1v70iLjsItxgh3y1NbtXaMm519nwc0I0ARuhttcaK
	 5zaBvmWUKireRfDfkpZx1ymXvxJJIDW6u2uKw8Ort3DPQ6BaHjvQ1gTBoLyhQzr5AZ0+N
	 hnbcsjh+kbvCSD/uz6pTHymVOaTT9sFqga7ARrO5ITJJiGJeMB0Tal3D8yqukRJt4xk5H
	 C9na2fktpZmqOCLHpIvVCAb8iUHkbCydPeq0xhHLj2PDB9sgyl5EisjSeWDNo2Ao7/9aH
	 2Yvag8YrOJGAgeA8FPl+R1l3BriK4mt3TUscw4LT1wR0RRWva6Rg9tODLBMjbkAJSQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PVi0gje7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1D606A32C;
	Sun, 22 Nov 2026 18:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4B1D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PVi0gje7
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EB93F20220C;
	Sun, 22 Nov 2026 19:48:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9N2WNj7YVmlCUwAen74jHLg5hKAx6GwlKsGjT+YsiuU=;
	b=PVi0gje7RHX+6uqQTSnnPs4s7DJ96xEKFY5KO9nSS1micxpUSpZUwSyo7wbQZc0FKp/rcI
	fqMjIQ4LA61UJTRJAjTElPZlvUBpmIq2S/8wfda4/OpMoOBNX5pogDZ8XqQM2VZg44Ay68
	UWPR+Awo49rm1L0sLCIBkJmUxXAx6B+AP4yyxIDdlmp08UjXusfkod7oTblofgszzgCvW9
	Uw46+dvkx+23Dhzf9dUq7evZuKSso9GqI07H+FD6x34soJ09ShuS8VU3goRWYyf50jOGQ7
	Cv19rHQj959y0937ivvB45b9KUbNd2UKpetP3JVeNYmAK+bZeUliXJ0wHPzRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9N2WNj7YVmlCUwAen74jHLg5hKAx6GwlKsGjT+YsiuU=;
	b=TZKwI9jHMhZ5oFxx0cZ0ykt//rVnXXsivTlWPZ5SDFKoKXBlnGUp7nPHtuSvzArZKTeIKw
	Eii7kK+r1Zs+6D9seGAmahcnLSNn1TSnOlWH5w0YoGz9Xv+OXfNCAPu3UyP+RuF8SZKqd2
	CB7yNK5mlUp75y+3Zplllbuz6VGQcUHTzP2MX3tvnxfY6HXeswIqf6+eP/mpmi/lZkoqaN
	nyT2ZuzQRvidpXCNtRYQLZbIXSJnd8Hr6egWQIQF5GjdSyIxU2FONRJ9zCKRi+Vwj0s/Fk
	o3P0HaxA7U4UPm1frqYgKuSCVGyHIX+CNOBWnJW28N4JLlF/sOCie/qur6gpAw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373329; a=rsa-sha256;
	cv=none;
	b=du1+JfHHQoEy3NWVzhoIzOoxYMJ97ZLfHUjqp9UpxzrMlVvYLHS7q5Qp8v5MR1FO2TpuGP
	96ihnelU3UJp3qNTBN6JTDmPiRxOJ/lUNLyESPOC7ZzhGbPiqq4xLJBafSb1gq7ZtM0SJl
	VSj6YvxTQnRSARCh5CBPhyujCYWZZhgDuL8Fd5S5A6KbRXgBm+diBGQNgbGYy/QR8sRewS
	hbs5mMBbszJuHhwUAYCfUZ4JnvWvRjeI7Gptjj3lns1q6l8tGNePXPkCjzG2XDU9wue4/S
	wl6QE7jB/cY42D51A8nU+GyA6c00AX7Ps0JUsYsBUaWtc0FC9oA2Ls2YuOf4fw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:25 +0100
Subject: [PATCH can-next v10 01/14] can: gs_usb: gs_usb_probe(): init
 netdev completely before register_candev()
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
Message-Id: <20261122-gs_usb-fixes-v10-1-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=4265; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=/jUR29lrku0FN0ClogEy+hCBXwhs8H/ok5eQXLbPN70=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmtmRwUlcUcGxXu8DcdO6VxO0l2TInEw/cuqO5z/HQf
 N4f5SesOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRw5cYGXZGPk536lbyC4/4
 8DPlrb4t5xcHqW2C03d2r3m9LP/A/QiGfyoXdsS9nc4611F0zvw3q7S/9wuoPn6plXfpvNOHKQc
 3HeMFAA==
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
index 3b9b2f104d86..d1124c49460e 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1490,18 +1490,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
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
@@ -1509,7 +1499,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 static void gs_destroy_candev(struct gs_can *dev)
 {
-	unregister_candev(dev->netdev);
 	can_rx_offload_del(&dev->offload);
 	free_candev(dev->netdev);
 }
@@ -1587,21 +1576,16 @@ static int gs_usb_probe(struct usb_interface *intf,
 
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
@@ -1621,7 +1605,37 @@ static int gs_usb_probe(struct usb_interface *intf,
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
@@ -1637,8 +1651,10 @@ static void gs_usb_disconnect(struct usb_interface *intf)
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

