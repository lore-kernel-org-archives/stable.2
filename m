Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793040325;
	b=Dw2iahvXe+01GNheI9R6SWZFxxIJvZtqyuL6SQPEHXLkIdKcuaaa2tgVJ1lv8awDUF3b
	 GLWlV2AAuyJ8FUId89vJZZG2bVbJ0TXFyBM+EKQ40lznOTULd+h79l4ZVbccDpiWa+Rrp
	 twIyHmQgCWVYYxnw5k5iM8H0P6c4wQ47u3NPonnqYlRKSy9r0EnmCErFCqNDDXZTjWeg4
	 5GQABEI1HcG1Zuk52k39pWFscJf4UmjvyyZ6H4XVqB2mAk5LCCRjQwdBWc88Y4sYbQwR/
	 kpSgKmFwsycH1pIRUJP/hq1AkRqeZVJzp6RcZt8VA+V4WxTvO6/rDFh64PF9klJFHMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040325;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=TT6w2M9PdtcrkgQofns/eaPda8NY559LH8hMrL2zYwY=;
	b=c4O2suEvPG2cKM+feGWhDQKZhmDlGCS0+InAFZt4lTuQDoHKb9BTGmVyhVTo8tzK8xGb
	 SfetfH7XMSTvhZgVZUxp3LHtqkIz/RMrP+SiXZ/3IC675g6Px5OnyYNDpUjLc7DRa7gyf
	 iRTIuBavX2PDjgfRFJ95T8EPCtRdTt4w5332I57MukBlVdDUrrqw/Uy8pQDRBqxQ/iOJF
	 ThsjAH+xqC21B5S7nFNFFwekpHnU+zKrInmBPr2D8vg7lNnbKMA5kLxK/Uzjte6fKrUIN
	 L/BpeflpSUBCDxX+xxF8UhfpFu/9HsVpO+z5xDJES1IdZ8T/g0p8sf45Hvuoa8Kq9ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Mjpg48e3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2535A606A322;
	Mon, 26 Oct 2026 18:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2535A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Mjpg48e3
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 27C6820291F;
	Mon, 26 Oct 2026 19:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793040318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TT6w2M9PdtcrkgQofns/eaPda8NY559LH8hMrL2zYwY=;
	b=Mjpg48e3vBlvHpPBPSkonBB4+Ik2CHTc0E+VL/m9IsFpSOzUUCc9xxzzZvhUDGYFOcGcb8
	vawcjRb4pXZ6fkTBeKYSPDzwLgypHK2s226fKTEfNlBAtsqwt7b8ti9s4MuVgYEjHsf/1K
	43V89cvypDYyDVYaVMnsrKjKVxTo7alHJWcaQoZbAxvmTIzwzhTofLj6aHaVkXAeSj3KB/
	mUjagYuNfp0ondUWyWoaHVEOBlu4BrhKNBDT2wzdg4Cv1Sve+qZQ2A/4u6T2xjy03YWFB8
	QEP2EHbYO1BGEA5UcIvUtCUj9bv/02Njrd2ipeksGXqPfhHZc2KZRTwQHqCcgg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793040318; a=rsa-sha256;
	cv=none;
	b=ZQrDNkwqoObkg4FgjkM9U4ftiQEzceKChXZOsL/LyEJt+5m2ewPKQMLe/31Rga5YnTBmnH
	FBtrYqVefRe1jy2d74lE98NovD7mB/ceopC/3KObOFBx6o6MGDyKzVWbU+DrcD0IPOz1wv
	myNuGftVZS6pVZcGmjpwF7QekMK7FP/gbFq7luFEhVqIay19clcpsc+kmaznu8v2rcVwNj
	jvYfhCgeKVEu05EpxOXj4V+0Rtdd97M5DKRvlafYsDmBpSCiJjjP4dOfScKROeh63g01AO
	fnzgyQzPwuMjJh7PdWRH0FfcHy7ycQYyNw7DbzK2NgP8ppBR0hzRyWDDDARz3w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793040318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TT6w2M9PdtcrkgQofns/eaPda8NY559LH8hMrL2zYwY=;
	b=NamUxjDWiWS/cywiQneZUShaFw6QbOOGWhAwy3Z9vP6oyuoOvP1rae4mOoVqC5fEwU74VI
	te+VOLziqRKh/dYHsTUVQYuQbuoFQVwB+N5BktO8pt5UTcclQf5pJV2h1m4jJGELnYdrq/
	U2D9u2yyenXf8oshTjYtJpW7khWAZotW9O2DuCzAS5n5Q2DtkSMXPDg7hC/duhcb0uNgQy
	NO7GFvJUooGVgntinG3TJrTsvwuaPszvaniX09CDzjPH30JfriUW9D+oK5JqgbI8cPu5EA
	1MCFtv/+pKR9ekz1JESv7GF9DmBi3Rl7InALiXx5lTaAjYF1pLluJ5aIlfLIBw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLPh8-001JyR-08;
	Mon, 26 Oct 2026 19:45:18 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C8A125D7287;
	Mon, 26 Oct 2026 18:45:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 26 Oct 2026 19:45:07 +0100
Subject: [PATCH v4 2/4] can: gs_usb: gs_usb_probe(): init netdev completely
 before register_candev()
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
Message-Id: <20261026-gs_usb-fixes-v4-2-59e3b6360053@pengutronix.de>
References: <20261026-gs_usb-fixes-v4-0-59e3b6360053@pengutronix.de>
In-Reply-To: <20261026-gs_usb-fixes-v4-0-59e3b6360053@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=4281; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Dzuwp7w8p8oSMZnC5UKTITwgAdFSeFsiLdJsDWbad3w=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6P39nfJ5fevEBIcZUof13bTetfe8szJcfsr/ONpGP3
 /2fh6V2RykLgxgXg6yYIsvSHycUBQIdSntfJkyCmcPKBDKEgYtTACYyK4rhr/D9spdWjd2cVbLv
 Kq/528/3jXFZ+jMzpOn15c3REx4viWNk+MZ+/Pd76ZbitMjspNs9phWrnj//yPlfh/2SW/POlK4
 lfAA=
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
 drivers/net/can/usb/gs_usb.c | 65 +++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 15f28833f2de..31c25cda9f43 100644
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
@@ -1636,9 +1650,10 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		return;
 	}
 
-	for (i = 0; i < parent->channel_cnt; i++)
-		if (parent->canch[i])
-			gs_destroy_candev(parent->canch[i]);
+	for (i = 0; i < parent->channel_cnt; i++) {
+		unregister_candev(parent->canch[i]->netdev);
+		gs_destroy_candev(parent->canch[i]);
+	}
 
 	kfree(parent);
 }

-- 
2.53.0

