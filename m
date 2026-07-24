Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7642A17E
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888667; cv=pass; b=pfKZJZjQVeHBsaNsYvdalA2iFO9e7vf6tWZ+ZNe4/xhofLoYDe8EF5yOtrICu0Z5d7XMZcfthRnN4ZxcWGOs8lISArRX+Wo4+ZTgXxRgBKrdL2cL6fW/xLD6EBgG6XaMdHksp5pDKrSRUY1mA4S8ETOn9x8D2/cMvq3o9VrPs8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888667; c=relaxed/simple;
	bh=Vvy5tFMn0p5UCMAtLd+u3aKZVXjq8e8ldTYJibZnIf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeTPUN74GUrx+hFaScNWckQ6PpQCv6x3wqXMGxFO2fFGY2lvr5Gcd+EwL7QLe9BeU2nvPDACLOoDjnCznzWLoYzRaALAA2LKGNQ4iejXQ6vpzopZdtmCG7CCEA44/bIAy0xuhAvSXbgn1p7TbA9BGK5a45QR2DmMjNS0B6vH8jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=b8sFEn+U; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=U6Mrbjc8; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="b8sFEn+U";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="U6Mrbjc8"
ARC-Seal: i=1; a=rsa-sha256; t=1784888660; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QrY1Cm9pFE9nrvElGDx8eZx5HUJtnGIwrTJPX16NHIwup4Q4neNVQlNESFNJVHdZAV
    WmjUob9kFbNhJlDIxTTV914S9Mh7zjzWeGXAK3L9cAE34ODm5vEnH1waqSyyh9a8xZmg
    N4PO+7VPI8js+XPVGG/wyqrvxsXgvRAMSxt3nuczuLdGu6lmYIiEMRNqe61RdW5+Ekxw
    s+IC61Osoonqg6/CmH4UUm+WriJU0fkKFuCx7UMlLgEE4Fx20C+AHj/wXURmu3IrffUj
    aBP4DMe3E9WxtRzHVaLdGOoN/veajGHreUWGvoXwcsAGoaGx6o6U5VVxmAQoUQfti2YY
    /TDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888660;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HBumkadRmWc+ZYfkU1fuJD5LOaG/+9/IriXMOUYPzGw=;
    b=t2k8JZCRIOo7NII4Kl68wq7+E3yKolrNXhIX3zwxVLczGDPBTA3WdNTrybdtOyJnrG
    rBT9eJirsJ94oiA/R9jWIDx4MYLIXh0KYNeWh+Mgyc9PfY4bjPokORr44DUU30K/b5l0
    eJhGst+2ufV/CRFTZFRP4JK22rQ+kj+uNP8ZLtoixythEGevyc137fSZj3z1fk5cmZtD
    NTfFFCzuA31Eos3NgkG+L8px/WsyBKbb7pr60khnQlbbDo7eYR18/vU+Rg4W2M5Wpj+E
    fzJm1SpMuSHG38d0Y48dmi6tw5TnU09RMEjkYrJ1o2RfVlOyDG9TgmVj/0pvZC7jM02f
    QyLA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888660;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HBumkadRmWc+ZYfkU1fuJD5LOaG/+9/IriXMOUYPzGw=;
    b=b8sFEn+Ucu5zfg0g7fAdYTkyhMqyx10AeVlkP8qafiHVZ83na+iPfWwkE1w9tC0Gzw
    S1wO7MRIXEZD/Nhj6U1yMDEUy0yiSi2DpD8F89jma/TigMoHCZJJQPMNjPxdcirHlf9R
    VvbRPlomNRwapuVSWu9QtblyB7Q9HTqczRt1QPBlUDTK4muFkc8yrFAtkx+EVsGTaSbL
    RTdiMC6rl0LqPrAmqrX/mv6IdOBhAB7TMRrxRZJgIR2uJ/2zESHVcTB39SlNYsyWDA5O
    r6XeU+pA/914jCsa6BTiRkMbDzB566fq00DrkQ/JqxC6gIc5mqWqZumol92/KvMqYNzc
    da/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888660;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HBumkadRmWc+ZYfkU1fuJD5LOaG/+9/IriXMOUYPzGw=;
    b=U6Mrbjc86gYd6xH6jhhBchMoRIyEJistS2OTIIW3/1ADe4hxF8RxGPjASXSgO41S+6
    dEbmasXb6kR79hIhOqAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAOKtIb
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:24:20 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6.y 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
Date: Fri, 24 Jul 2026 12:24:06 +0200
Message-ID: <20260724102410.16731-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102410.16731-1-socketcan@hartkopp.net>
References: <2026072011-untruth-wrongly-ed18@gregkh>
 <20260724102410.16731-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit 62ec41f364648be79d54d94d0d240ee326948afd upstream.

bcm_tx_setup() validates cf->len against the CAN/CAN FD DLC limits
before installing frames for TX_SETUP, but bcm_rx_setup() never did
the same for the RTR-reply frame configured via RX_SETUP with
RX_RTR_FRAME.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-7-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 59 +++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 8529061..01773cb 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1199,22 +1199,37 @@ free_op:
 	return err;
 }
 
-static void bcm_rx_setup_rtr_check(struct bcm_msg_head *msg_head,
-				   struct bcm_op *op, void *new_frames)
+static int bcm_rx_setup_rtr_check(struct bcm_msg_head *msg_head,
+				  struct bcm_op *op, void *new_frames)
 {
+	struct canfd_frame *frame0 = new_frames;
+
+	if (!(msg_head->flags & RX_RTR_FRAME))
+		return 0;
+
+	/* this frame is sent out as-is by bcm_can_tx() whenever a matching
+	 * remote request is received, so validate its length the same way
+	 * bcm_tx_setup() validates TX_SETUP frames before installing it
+	 */
+	if (msg_head->flags & CAN_FD_FRAME) {
+		if (frame0->len > 64)
+			return -EINVAL;
+	} else {
+		if (frame0->len > 8)
+			return -EINVAL;
+	}
+
 	/* funny feature in RX(!)_SETUP only for RTR-mode:
 	 * copy can_id into frame BUT without RTR-flag to
 	 * prevent a full-load-loopback-test ... ;-]
 	 * normalize this on the staged buffer, before it is
 	 * ever installed into op->frames.
 	 */
-	if (msg_head->flags & RX_RTR_FRAME) {
-		struct canfd_frame *frame0 = new_frames;
+	if ((msg_head->flags & TX_CP_CAN_ID) ||
+	    frame0->can_id == op->can_id)
+		frame0->can_id = op->can_id & ~CAN_RTR_FLAG;
 
-		if ((msg_head->flags & TX_CP_CAN_ID) ||
-		    frame0->can_id == op->can_id)
-			frame0->can_id = op->can_id & ~CAN_RTR_FLAG;
-	}
+	return 0;
 }
 
 /*
@@ -1277,7 +1292,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 				return err;
 			}
 
-			bcm_rx_setup_rtr_check(msg_head, op, new_frames);
+			err = bcm_rx_setup_rtr_check(msg_head, op, new_frames);
+			if (err < 0) {
+				kfree(new_frames);
+				return err;
+			}
 		}
 
 		spin_lock_bh(&op->bcm_rx_update_lock);
@@ -1350,16 +1369,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (msg_head->nframes) {
 			err = memcpy_from_msg(op->frames, msg,
 					      msg_head->nframes * op->cfsiz);
-			if (err < 0) {
-				if (op->frames != &op->sframe)
-					kfree(op->frames);
-				if (op->last_frames != &op->last_sframe)
-					kfree(op->last_frames);
-				kfree(op);
-				return err;
-			}
+			if (err < 0)
+				goto free_op;
 
-			bcm_rx_setup_rtr_check(msg_head, op, op->frames);
+			err = bcm_rx_setup_rtr_check(msg_head, op, op->frames);
+			if (err < 0)
+				goto free_op;
 		}
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
@@ -1461,6 +1476,14 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	}
 
 	return msg_head->nframes * op->cfsiz + MHSIZ;
+
+free_op:
+	if (op->frames != &op->sframe)
+		kfree(op->frames);
+	if (op->last_frames != &op->last_sframe)
+		kfree(op->last_frames);
+	kfree(op);
+	return err;
 }
 
 /*
-- 
2.43.0

