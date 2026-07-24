Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959683C4168
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882473; cv=pass; b=Pr/oS+jMWTvNI85BS+WDdhiqpPMb606yKRQldu9RejMY9iSH0O0dmhqCcNoVUkHvHgaswZL1JOlbwJ8p35AFLtcDIqDB0CCIqHKvCjAcMK6TJC4CP8tZGBuiDrVEJ4ofQLl89+sowNhEmAxfmEOFrevucQCfS5j4SAM1tqFiDME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882473; c=relaxed/simple;
	bh=Kxf5qhGPM5N3lnT1RzqB/ekC/7LhalxrQQ9FOhfAQec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIqxSFrwOnurHj3MvPWSg1BcbUZVRRKgvVi+0YilzdO8w/vf+Bz5EYZXqFaSq/xaNFa8wAAbNPuFoTlL2xLnmMr9yWfFiZnf6u8JBpmajQamMie3zwOj1SCtxBL9fYhiSysr6qoStKzElC3fDCoklHjtU1g6iNNG6gideFnUql8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=r5RcBIJX; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=himRiqsa; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="r5RcBIJX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="himRiqsa"
ARC-Seal: i=1; a=rsa-sha256; t=1784882287; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LLXmZV6RVR8TdJpQOsH1oaGFvpR9WLfVwgihMF7dGP1Kb5kCJpTwlAxJ69UDsS2T7g
    FCTfOVjE20LrIuF5qttE+1rQfn4/cOLhQM3M9cHR2lFe3yC7KMHkYrB3RzAiHXYniTKn
    T4ekomx9B5YQvI3DqsJ7YQGZuKVLPKiSM/88zVEJ5dLCg3dQ44iQYs2/mCu0k3XPfJFy
    6Traqf/BkAhAQMDI0E5c+npTq2sItRJM49BxypHCMTPffPZ0Xt3mpai2GUdecsfQG4PZ
    DU3G9wqd9uZ6uFofspO1K5z0ySWobzbIRMWlc2IM+MPAaPEkomSKw4nOQCfus5qu+k8Y
    fLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882287;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I+6E+U3XH2imCk/2kxzFLRVExuHXUt8zim26IL7dPi8=;
    b=exuns87gLVxku8OA09VMwwR5gDQhwjsajFk9cY1G/BzuqwUstf/FyebZd8wvRtljvk
    mp/J5t/dx88q2aWyMJKKpydYh56iXGsSRF9apSabZGFELuOtWvyqz3flImDF6s2d0ehQ
    Dz5q1CuaeXE6866TrW34hmEVFnMwpVw1ZtlB+vuTla6Mt7m7vIWYCh0ix1OaVuHk4JU3
    YJJpqqRf4CVEucQQeL4NtZIyUDozQLsKfNoDWCXlBXgBJrrZWjsEqeXarnOim3/7QXIB
    8Fb/2b0XqQpSHt54fcG7CH/739abBIGfoajQFtF+53/6jPgPwgBH+WNCBPyBiNzPymy1
    QAlQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882287;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I+6E+U3XH2imCk/2kxzFLRVExuHXUt8zim26IL7dPi8=;
    b=r5RcBIJX03HfXzqaPSGld9Ifu8+9JX85eYr8zAZbXHidt74u6ru3DdB4nrGwFZGMPv
    cxq/mTFIra8ya6z9grgnlG8zXOW6JrD/M1MYLY3VTVevTBq85U7Y+8t1kksbWejWZVer
    A29PU21Al5+yPf7Ve9D0L21Z2pq3IjshTCUr3pHCvAJqV2rKqtKEwQ+9emaFtWdJhzlO
    Ij4c4AK4Aq7nygtU8CjPn8z+P5jksoya7EI6Oux5N8UBoTakGBFb4vQl71fqjRzYWtm9
    X1WjtC+YNJE5Fp053bBd4Cu5kp4LSwNLyi0IAspnAhH3s7/K/7/5cUzLv75GbRqaPcHv
    nVvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882287;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I+6E+U3XH2imCk/2kxzFLRVExuHXUt8zim26IL7dPi8=;
    b=himRiqsa2/HYFUA7qYXk4KRP2PnBrm84qG71jWCxIFSEKncxvs6ZCvwGxpqvO2TxUP
    CN9kgTcxrM+9EfOIF7CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8c7rQ4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:38:07 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/9] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
Date: Fri, 24 Jul 2026 10:37:52 +0200
Message-ID: <20260724083756.12430-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072029-dividend-latitude-611e@gregkh>
References: <2026072029-dividend-latitude-611e@gregkh>
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
index 090f31b..1263822 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1194,22 +1194,37 @@ free_op:
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
@@ -1272,7 +1287,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1345,16 +1364,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1456,6 +1471,14 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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

