Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033131;
	b=WDf4Y59iPcuM8fX3PExMGjZsXCibvY5c/KTFEh7M+gMKv0D2ByI3cq31P0AXJcLzm4k/
	 q+qWXLjVWQaReSoYg0cppZCLiWAQaYrKx7wqXQGV8R8jHZwp9gQuPN/VCEpHUtv6XXn3F
	 YABvtfnZr1ynKmy1rZNgWYvPv1KC6jcE2bCd+iTIWk0yYGhv0gdIOyh0G8efrbLd0UQ9S
	 s7MQ6q/gSZXdQ3Nv6DFZXgs1WBn8A6otgzm0BQKJ1pV2YJo9dG/H7xcNJCysd6obD20or
	 OgNzAPT6H1wrjP5Z2GLqAI7q6HMqTsv88qS7tVV5bE2y468Hhm2ijo8GWpKiryzyF7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033131;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=xWy6aVIAvaLsHF5r8F2JqA2rXqFMJpPlAWoqL6u/CR0=;
	b=4e9wftrh8zjwc8I8IjvJQLbTzhVkVtpi9KRx+8u+Jz1j1cVf1FNhGleeFRn3YGZ5nxt4
	 r6aef0cpB+ZXzhjnAJtb9bTSvWTDhk0royhIp255FhzvNqfL8U0PoZF6kEdhvdityvXTy
	 Rm828hssc3Ei8tI04EK0XyNfKo8rrgfiWMViM9yiv0NFNz3vlOiMAH1dAZ3CSRP7BbVQa
	 8bLiLgmFPqWH3YUPz1Iodzxd6DlitlQLDw7hGl862eAERI9yrNJtbYyS+GA3YWoKyBnsa
	 UWXBnVqZ6Wh9T0Pg9Rr/Tgk8QEQI//Gw4OQkXWLzcAPd1ylQ0Kc1jbXlppEy0ZLQusQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=TpSpaMnu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DEE606A31E;
	Mon, 26 Oct 2026 16:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3DEE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=TpSpaMnu
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DE7D6202920;
	Mon, 26 Oct 2026 17:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793033123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWy6aVIAvaLsHF5r8F2JqA2rXqFMJpPlAWoqL6u/CR0=;
	b=TpSpaMnuNipWID7IxJDiLqQTYj5TCtw+rGkzhgK5/OkAeg8nh5ycXrjLlpGzLpthfGGfVb
	uBgI5BTtaqBqgRVZDYQZdAcvAQidAezH90GNKny3DKLdZrUaWJYUoIyLBnGWmbN4vEXyQF
	1urbkEmgIrbmiYcr/q3VXd1CjnXcfunCnKiQG3C55AuKmln1Yy4LpZ4NXvBDJ5bHnwYZ8m
	CuHtTXs1IT0hCoB3A2GjFMUzi1LT6dCJVakZWIw2eI4NMmc1d3UiPojhxtlnoTzaqw8pAM
	2otosr/q/kPjqMLinqrEMsfgecgcqyTDPNpXi+UFnE1O0EvPBSmr2B+yDug6gg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793033123; a=rsa-sha256;
	cv=none;
	b=cjzUtOxrA8xcG9OlXffz2VnzCd3xIQmhjZyIaqhBz0ygSfKi59uk1zKmJNUyYliZT9hrrR
	W7AY5Mi8Poi/r48uthpA4GZu/vLVzamN9FQ1/6/uszbsg7pfrtZvfHdB/XRr+NxK/H6JcW
	KI7cS+Qop0JOZSEofhqb7sr1FFfGFiGKs30nTz+SDnBs/AYhdFaFZMSgAn7Oj9akr8ziJD
	vTpNTnqsfr9nGCPLML4OC1UTOqqZcO9DEu6lTjkAmnPC5JuoLIsPAVZ9XQrt2yuRJvaHVr
	4AU/QCIUACAm7rm3Y4SFNRUK+JGyPrWXDYyB0tlJVvEGK1SiUV7XhA4La8ioHQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793033123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWy6aVIAvaLsHF5r8F2JqA2rXqFMJpPlAWoqL6u/CR0=;
	b=Ja3yv3jvQkl6kKhOTmzfUe6jg8BRlnP6AifJfDR1vlA4fSlmgiNavpr7IlwwXFRyqyfnHf
	TvqWJ92/aK/iM/TO4I8CkibjxUYPrQLFFM5/7B04bVvBC1/UE+lHFz6xR8jJFmRpzKgkNB
	MkpjoDS6k1cDmKwkRfllaKCJyKzhF9UXHbfkzQqclqhvBkJKTYH1/nMPsDud52DJwSbnWH
	NkpXKahIA9kpU15W+J+BEiWIZbwXY1ebHye6pqEDZoahdOuE7V+ZjizOXdJZJYL/IG6/2v
	j/3yNMIUeCD9hSX+JeN+4SVaO86mQNKL9fPgJSZIDQuWO1a71vveesh43z+yiA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLNp5-001JFe-2Z;
	Mon, 26 Oct 2026 17:45:23 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 595F15D7169;
	Mon, 26 Oct 2026 16:45:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 26 Oct 2026 17:45:06 +0100
Subject: [PATCH v3 2/4] can: gs_usb: gs_usb_probe(): init netdev completely
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
Message-Id: <20261026-gs_usb-fixes-v3-2-3a68f1f62813@pengutronix.de>
References: <20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de>
In-Reply-To: <20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=3903; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=vHZ80av5rIroORy41pg0hJNajU/ljJERoC7gSetS3Wo=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi63zw/IfSz1rmtS/dyZG5yOhWatS2AU/clz9ofF8TjP
 /Z3vLsj11HKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJrL/J8L9S9853ZfYiy10m
 34XkxTzlpGSj2B4ZxxtKPG6SWfHvTQPDX4n2jY+ul/7sDvsWoTKhVXHX6sCZevfnKfrs2qV4Ks3
 dnA0A
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
 drivers/net/can/usb/gs_usb.c | 57 +++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 15f28833f2de..cbe3750bb68a 100644
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
@@ -1593,14 +1582,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 			/* save error code to return later */
 			rc = PTR_ERR(parent->canch[i]);
 
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
 		parent->canch[i]->parent = parent;
 
@@ -1621,7 +1603,37 @@ static int gs_usb_probe(struct usb_interface *intf,
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
@@ -1636,9 +1648,10 @@ static void gs_usb_disconnect(struct usb_interface *intf)
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

