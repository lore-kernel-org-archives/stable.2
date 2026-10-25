Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792957916;
	b=rWRXN6PEq7CEZyiggeJ1TVviTCdLwVjm4GLJoecmjl9wFics6Q9HUue+RGvUi3MPr0VL
	 3XyumNFfV8jvnzmYoIiO/0JiP/jLepIDCh4OBNI6JHmK1MtgFqQlI7sa6fzeoojIrkE7Q
	 8kyhecteBL0q9fThUrdvSkcA6ccqgdiHnhfkLr3GZWsKWAmkIRXPpjVU/vzoQG5az7Ult
	 EZICJzW2y9tY3AXMxEE/d5A905v0ZjsaxG6p2r8CZcRZ/guLMiiFfxLKwtiQESCjphYBa
	 xtGOMNh2IxtVdP0KkFCr+c/0/EYWvRJJ0P6zcDIg79FFe3xZbVwuR5nsPzjAnWaAgbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=A6LAyYDvYUIAHYggP9Nr+YWJtMpQmji9qwlrMmD8DsU=;
	b=HWiWoJ5C482VrXuKA/7V8zt5UlSer5vUC/+nlV9e24Jl8LmFQHbmF28z/5e1Q2jFgGg7
	 1v452xyUe749LRLROw8qbUKa4rYgVzi5UEiwu25GGqc54yS+Pp/cvHXMb9I1HWq1Ovf+X
	 62cvUt8Hu6UYyKiKEqdXP7ydF9naV8IdFANM57bTTpvI4ytfiy4a9PT6vrCD75rvVYVQF
	 y4SrOgNO+ymon+8dbxPdFMmXlc/XP1BnA8HjnHHeAryjWSPQdScsesxFbw0500RjDr7lk
	 s89AKmHSNATxuUGOhHvOTSX2UpydZBE69WAfPn7y3eVR3A11ZCWoiciKm07NvtIlqng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NMCTZO5v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E1606A31A;
	Sun, 25 Oct 2026 19:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A52E1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NMCTZO5v
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DFB9A201F0D;
	Sun, 25 Oct 2026 20:51:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792957912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6LAyYDvYUIAHYggP9Nr+YWJtMpQmji9qwlrMmD8DsU=;
	b=NMCTZO5viDjJ3IbY5p1ii1hAQ7pSjdDBN2sFKtO86Cud/Scdj8HgF9h4k5ERrgJoCdFrzL
	6gxLZR7aT4IqRkfWpGvURMPooh2DVA+VzwgdTnsQannwz9AkN1hFO+/Ypv4SNeyYjM2Ep5
	jAXZbf64HRiObgHiFRGQqDCVOv0CwAOHD1UlwMZr1YS/68exDL+IQGYbJz4sQOoYgxV6uR
	1IFKAOQhfk2bVfcpBNKl4pGUvC1SrHpmMDPR+DDvDbHPgoqr4AN43G4OPJJZxJwJjCpcq1
	9EqYIrFsr4M4tDI2dBWPokexjegte346GyFOD6XoyFe0OdnuGtq7I2xAKUmEtw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792957912; a=rsa-sha256;
	cv=none;
	b=SpoPA2ixu8gnGPLwMmGHwEJcNgbDhbAdTxc2SDPbsdZ7pVuSdIKn4ntAfSBj2lC+LWaVll
	H1keqlskZLDcbkLBnmBPccnm+R2K7OMjzoeEp7XV0Lwx47PKR0x3vrf2qbIEIfnjXAfONH
	fTUUzSwzKkR/KTJA+rPk0bOZNEHm1zB2yGhYOaVtxDepvk8GKZv4PMR2mtInQsMSX6Di+U
	yslkKZUI+pIMJxGJF/uriQUKQuHGntI1N1JrdAgY/MdxkBtwRkvcUx5/0TGjMyli3rewT9
	1lz43jZ7gP/taWayrE976Fzzlo+sr1lu74rlgIRRQ8WNTAgLZnr1GoXjCUjMLg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792957912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6LAyYDvYUIAHYggP9Nr+YWJtMpQmji9qwlrMmD8DsU=;
	b=QxTWUvbfxHjLYtN1ybCQ6TFSwqfQxGxcEjSy5ckyJxO4Swc2bW59b5liViUhC4ZZgONTBe
	3hODdhD2gEqTL8+Ls5L8imW/aae0J1xrkULPzo9jJPqF06iWLBfsLl5Ki1trEwjisT6tWI
	P9igr4adUSV0QfmRPTADnZ8rW8/vjGxkX1ftbVK03i4PDXAL9FypjEKVSH/boiJ8YIXYdp
	1woC95NcqJs3Q26HxWuHOdlmJfYIsAt7JfD7ub25h+nSy/hFu/fUpalUlBrP+5vm3w09GG
	U221QMfl0j1N2h6GgSrgbQIoyOdtXqhGhrhNsgzTK4sMRH4ihDOXgdwdfms9oA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL4G0-001AwP-2e;
	Sun, 25 Oct 2026 20:51:52 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8D2375D41F5;
	Sun, 25 Oct 2026 19:51:52 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 25 Oct 2026 20:51:42 +0100
Subject: [PATCH v2 2/4] can: gs_usb: gs_usb_probe(): init netdev completely
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
Message-Id: <20261025-gs_usb-fixes-v2-2-535d45097f72@pengutronix.de>
References: <20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de>
In-Reply-To: <20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=3373; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=UW04p+Y9GFMDBc5QQ3CwIi6JsTBDUEvshwY0r6AchVA=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6F3t5ykOd61EH+BquXr8a+JGT+Vt3mY/qjW/bxRxeV
 s8T2XX/ZEcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAm0nGZkaHzR5L4L4fIS5Fn
 i3n7j5m1GvTrMu4zZrtjNmnDnCuc8zoZGfa87JE4tM9fM/Pw408rBPZ8yGusCTu0RqhpU9GahGM
 LHvMBAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

In gs_usb_probe(), gs_make_candev() is called to allocate and set up the
CAN channel, as well as to call register_candev(). However, gs_usb_probe()
defers the assignment of dev->parent and parent->hf_size_rx until after
gs_make_candev() returns. This opens a race window for the user space to
bring up the CAN interface, while it's not completely setup.

To close the race window, initialize all CAN interfaces in a first loop and
then register them in a second loop.

Closes: https://sashiko.dev/#/bug/linux-be54de7d-0b75-408c-b3ee-dd90c9756857
Closes: https://sashiko.dev/#/bug/linux-71076d59-0843-4749-a5ab-fdd98a08582f
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 54 ++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 15f28833f2de..2564c1672793 100644
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
@@ -1590,17 +1580,18 @@ static int gs_usb_probe(struct usb_interface *intf,
 
 		parent->canch[i] = gs_make_candev(i, intf, &dconf);
 		if (IS_ERR_OR_NULL(parent->canch[i])) {
+			const unsigned int cur = i;
+
 			/* save error code to return later */
 			rc = PTR_ERR(parent->canch[i]);
 
-			/* on failure destroy previously created candevs */
-			icount = i;
-			for (i = 0; i < icount; i++)
-				gs_destroy_candev(parent->canch[i]);
+			/* on failure clean up previously created candevs */
+			for (i = 0; i < cur; i++) {
+				can_rx_offload_del(&parent->canch[i]->offload);
+				free_candev(parent->canch[i]->netdev);
+			}
 
-			usb_kill_anchored_urbs(&parent->rx_submitted);
-			kfree(parent);
-			return rc;
+			goto out_usb_kill_anchored_urbs;
 		}
 		parent->canch[i]->parent = parent;
 
@@ -1621,7 +1612,36 @@ static int gs_usb_probe(struct usb_interface *intf,
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
+				gs_destroy_candev(dev);
+
+			for (; i < parent->channel_cnt; i++) {
+				can_rx_offload_del(&dev->offload);
+				free_candev(dev->netdev);
+			}
+
+			goto out_usb_kill_anchored_urbs;
+		}
+	}
+
 	return 0;
+
+out_usb_kill_anchored_urbs:
+	usb_kill_anchored_urbs(&parent->rx_submitted);
+	kfree(parent);
+
+	return rc;
 }
 
 static void gs_usb_disconnect(struct usb_interface *intf)

-- 
2.53.0

