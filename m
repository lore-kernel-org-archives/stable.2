Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794669477;
	b=ENiLzZtdNYebQt7iGW4lq88g79raP91pQmk+QSqmw3ibMu9ioAXkne17yf6dzMV5nbov
	 NaRQMHoh8Xfg7xSnJyXCE6jspFqLdbdQXZBRxov+343zGcs3Ke8YmiOCn9dNDT4I96TCN
	 UQxOf2nnVMsHbm5olFZQmzEbFtcziiVmyMP5QSLO1fJ0dgwrIuGgXFrjxfCvHLHin/jGP
	 vXmjejOOZ5tki/41T7vNbhAUsYvpKxu4/ji6tYXUPERVKQTJHBJ6bFcyJJdvnoj5Y27wq
	 9nQjmQyat2/BeXsDQzHkcgMsCkDgYB3QGT9NAgkVM0pVQ9ncm8xxE0Otxbr8Bp+KjPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669477;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Ti0JWkIkKPgSVJO+xE5HKdSUB2nbIRtCDPD5HTD8o0Y=;
	b=1ozRiLNVZXFE+mTGq3+RWViLqHqzPygOySflZDCQM8JuCRZTxSx762B7AQAESQH+9bjg
	 JZmaaI8kcI7FTbicwon98zqUCTs4+TJJWSETxfwUk8feJQp0ReG7vmRz1Upp94BVDqg8p
	 YPhlDvfV6vvbsYQDbmDKqNPPdBW1xJPg1GRx6IzDaVXuXKUROc2hxKDnhy4LHBHKaynBj
	 JzE2CH2XcUrn21Nv8cmnMWiWgzjxeOMOh0mfA1qF09IBLLrT117z/EO8ninF/isvqGWqM
	 uFURNemwmOAYG92/o0qF7Ju7ZnAs3mk5+zr0pXTQEvI24RbDF8qIvRo4SJuOvI8G1tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dYK9kqeI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043D606A332;
	Sat, 14 Nov 2026 15:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9043D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dYK9kqeI
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 562372022EA;
	Sat, 14 Nov 2026 16:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti0JWkIkKPgSVJO+xE5HKdSUB2nbIRtCDPD5HTD8o0Y=;
	b=dYK9kqeIKuxuDeTeTWTGkHdnQE8k5tA+5aNBHYaxdiwmzeC2lupUhmgHVi0EJOklZAxwAf
	9sIFQJFlPvDi/akUIbOF8dwLFWtI3ZovUYbk22+Hissa8T0OXQPbExlIShDvN8bjBZFHqG
	YVwPGObtHdVw1is+cirzKw4BbdsiLd7hLtGpM9SIV7PbH1ExY1ieu5VyN8EI7xCdGZlG/j
	U4mgGdu2weYedjl8YE4tWjNWMrbjFZO7O55Lb4LmcNhvpu0dxZR+PFa6+W8+N89afUnLEg
	/hwEdar0HxXP4+MT0A8jynAu141Djcctbdfq/eO7JWzjFxBKv8L7kPOuuwS5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti0JWkIkKPgSVJO+xE5HKdSUB2nbIRtCDPD5HTD8o0Y=;
	b=WoMZ7ZIOwr0HoJ/JeTjlYKhlX3lG/xPhOCSsIv69dYxrfl50w5/T+YWGPQDOtmFEutwutz
	PNnSZbloFioX4vsRb6/R72agnN/i5pOr06DSD82dffBEUzA0kfxQUE/9+W0OWSLgdBzx7f
	EWtFXNCjf2dh7rI+GggZRQEn35FMyE+NSjbvIQn+4AdgyTadAcMhFMIlzerHh20v/hix4i
	AmvJSy9Fpwyw6y3328LXnrleD5MVGZSJDrvj6HyblyaAAGGCkpoeFW3UAosHD7/dB4uBO2
	rGX0W4KVUU8hMMoYGHd+YRihCBu0xSDPsd3WHEmpUvDGaUt27RAGD3O8+qraXw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794669474; a=rsa-sha256;
	cv=none;
	b=G8JKzuEnsovfI/1n9N0jLYRJYpIBjl+4UjkX24o9Yl2Z3ohATtV9aQb3OYZyBApl2MHl3e
	CowP+TdN0H0DMsqXGkteGzwa8++ypw/wPeWi1q6eyKzvjKkAVXh6gDLwrw24SZZphQCWpU
	xqv34NnMzrM44MUchcUH8hdK/+sHBtXTud0FN19aSfbXn3L0Wh82thy55MtnY9AsivZPtB
	6pvi6eAeGhxPpUR4c0YXtzEmJxUCpUtVMPX8MsjJH+Zmf19JQjb/TxnTVfwKSDdqERYc4a
	SmKNRpIvKnCX1pzWLXVoeIL1nedfR/ZKdcdECf5ZC/YCYnLdVRNWokNoC4C3Hw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSFVq-0049oD-0l;
	Sat, 14 Nov 2026 16:17:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EBC165EBB30;
	Sat, 14 Nov 2026 15:17:53 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 16:17:41 +0100
Subject: [PATCH can-next v7 2/6] can: gs_usb: gs_usb_probe(): init netdev
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
Message-Id: <20261114-gs_usb-fixes-v7-2-58b6341b1c08@pengutronix.de>
References: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=4199; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=HP0EDW+WYKMQf1wWMtYGpxOpElxHWNwuHeeJfWjuVy8=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6UT37k1LSOrfCuXvb1p0TvZKrU7TU/H2d3Oyznzr0a
 iTu3grm7ihlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBE7nxg+O/IYrbUZ9/mBWe/
 ruv8XPAyR74jvrZsq/WNU42b7qx5aMrE8D/47I+rRxU3hupNaqmKeGWtoH1b+dzLHQ+83kYf/rn
 PcDMDAA==
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

