Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794564538;
	b=g13BvKL6NhEs9BVNjKo7gAkl700DYzlVCJbgrtk5qo1X93gy2CCQ9k+F83qOIUvM3waA
	 Kj3FpmCszerahmJrV+RcKMCv3gNblJXS1DcChULojHphgF2avoICvDOcrCsvj/hVdKysO
	 r3gA3JMFfDoU6DkAhxuiRnrDXAQNdB5wjRf4eYDiIkBWCCM9VHIHiwxe0SvZbxRrRYRrn
	 P9B8ehlNNRzNQGIxshdFI3UhX4Fh/jXTcsvDGDglwbwPboClOiHpdQsZAHG32VdlkcVXL
	 aPqJ1jeZzok9XyOYNeZRvh1RR48CKtTngDTiI+POEgT8RpuJLRj8AXE5cweOCPsQfkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564538;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=OT+afa1wLgeFLqzZhZGdmgAbeeLMo8nJiRCU6WEaetI=;
	b=diJ8ftaFWTPgQQsnNfGv6cZ+RIMO86E60ZIdYS48qz8Vk1XJOoCrZ9YFz6/nqW6ja0Lt
	 cQr6Y9bjRFb7pzUzTsESc4rAcAHPiTtEo+nyUMKEekC9h5SdhwGDEZitax2DEFPaAfQ+W
	 +l4hV1mwNCKJOIiX+FnzOWatWw4LmtHnKZBYDhEJg163m6UV5O2jGGViNpseazCuYAuBX
	 zeZmhSMLS5xAVlxZo26pDCeMCw6IoslAiEnTGEmuEmVrbzGgCrgqXos37prXvYEH85sB2
	 QoVV64COfMsD+/rd8TIOxLNBxMikNjFZyGSGe5TfzyeK6dFguuz/9Nx9taEZp2g90tA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="cEjd/gwR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD8606B11D;
	Fri, 13 Nov 2026 10:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4BD8606B11D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=cEjd/gwR
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8FCDB2020E7;
	Fri, 13 Nov 2026 11:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT+afa1wLgeFLqzZhZGdmgAbeeLMo8nJiRCU6WEaetI=;
	b=cEjd/gwRmKfjW9CBn+Tvpo5LZjBTcUSa3WN1GPHgEsKa2sGWOaCi33Gqv3+1hW8AjhQy7d
	ZEpbXri0GUrEs5ausfrD6MP50SXuoEMCkhlTRLNlUak7xGm5c1ClyUIvnj5oAFjPJHR7PB
	ZAfx4qKEP7gWtd9VXuQlPKacqEWAxUDScwo1gEUknkXBjUEV3MyJRlyZssRyXNaQHfk4wp
	er5TruijRjK5ok50z8RGfFCyhQn4ZUVPHROzeeUi5YsUn8EOl6D41Aldh7CJGaKTpj1Rip
	a0vWhZxqVBPnGSaK5l0LyhcQyzt1rVUqJqi4fJHO3/I5zarAy9JGnOGLjdsdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT+afa1wLgeFLqzZhZGdmgAbeeLMo8nJiRCU6WEaetI=;
	b=Ek2qCdBG/aV7kMprjTvL84f96CUy64DvytMb/s/cKC1DFaowonpXjHW//SfqnsWachX4U0
	Z8VTc+9gh0bgGJms8V3k1cUtdUDakupBqTjzp680LDaQvc9PJNEGpTWdj+gt2hvxDv7gkE
	0zrbsOwTr64tMICyCp0w7zfEuDP7MppnuP2I52czhQ+I0TRyQSA1ozwpdL4ES+aIKkeLfg
	j1r//+FGRBDfnaq21mDW9ldDhQIqjHZ2mh8sQeKrg+2k3nnNFk2RgjEqAyIeBKNNvb4dNZ
	Sk8RqOop6A/EywUILF+nLmaaSelVf20HXG7LvXmkEgnyLSCbW9BwsBs4NtFZXg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794564534; a=rsa-sha256;
	cv=none;
	b=VgoQ4NY/Elfnl32M/0hhwmyHWuONOKUbVP8eShEAT2+pSKlXldrNfFLltYe3WFKxuc9O9O
	PddwVdrsZFHoHyLiFkgQAzNPdxjfr+G0G+NyJxbKmx6igbVUQzyRXmEH704sZrcnce2uI6
	7RyuwcJ51A3Efe51D1W+3ZxIEVNA8D6MLfiJLMGIdKzhi9h21CivbLb2LB5xH6ajaRtPKe
	YCnT+tY0bELm4XNkUu2cJN4TANYbBKRD6JfExLvGcRjSxkQuqo0YoQxC7bhX7i2M2BAMKa
	rDaQC6Zi6Huvm4fFDhB3egrHBlRliO4fe0Jf8fK7JbL+eXsD8Wm6mBtssieJ7g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRoDG-003ySH-1a;
	Fri, 13 Nov 2026 11:08:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3692F5EA84F;
	Fri, 13 Nov 2026 10:08:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 13 Nov 2026 11:08:40 +0100
Subject: [PATCH can-next v6 3/6] can: gs_usb: gs_usb_probe(): init netdev
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
Message-Id: <20261113-gs_usb-fixes-v6-3-0c039e1bfd74@pengutronix.de>
References: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
In-Reply-To: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=4199; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=w+qmsSA5+xABUS37EGtRsdYalHXZjHdWdMb/eoFl6yo=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj69nDDdJYtHBsPNHexf15VcqtMfOrWNzNdtx0269/8K
 jDp4gaPSR2lLAxiXAyyYoosS3+cUBQIdCjtfZkwCWYOKxPIEAYuTgGYiKwgw/9otnndiQK3u26l
 SXadSrW8JLkvYtnSz2eYle5wyhTfz61m+O/2f34lvwDDpodBypaHzx6z/Viz9V/Niddpz4o8t0z
 R4mACAA==
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
index aa90cc58f28b..1527163e8c35 100644
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

