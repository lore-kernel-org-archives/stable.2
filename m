Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929392F6596
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888057; cv=pass; b=lm4jF7ufgN7oJOZrHFEDckHdKEeg1mfgaEUHQRBk9olaqYNrdsqtoVbaLqIw90V59MeN9h8Dni/ZAT/BDJfwKnSikDpy21iFZUPF8nVl2Pm2uG2g1Y4OVsyAkytFF5o+s52i8gZBgrMwIs7+DhY55+9oExn8nR/ixEfcIVpUbi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888057; c=relaxed/simple;
	bh=WRJw7eVuEJKKNzMjFcz5LEUNkJ9hyOZg3lxqXbIkY0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWRNCDctJJcRPhvnCKaxnXfSdY3t717fs07aknZVK3zaEgR1ivZ9KSaMI6NN682fTIbCmJzldZZ5gKgvHY4DoZ4YCTQedxeeD5Owg0YlvjZhXuxGEeLVVK15dz6w+hCnqsDOr9VKG23YobVcek4afpmPLDXDqWFswKcLgMIbTWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CksBwaxh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Hd7C/xPx; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CksBwaxh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Hd7C/xPx"
ARC-Seal: i=1; a=rsa-sha256; t=1784888046; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bOq+Hox5bRaC+NsvYBV1JsWLMCuxl4gNZTvu3RP2bSZ3+PddvxDjFG0hFSFtdD/O1C
    byErvxUgqRNb+DKs9MS2Azje828nBkGlm7YDCp7oa++2v/gIZJipoS0ePok1RabEc+ld
    iaz18k7HG71NW4Zyoa7VclPFVlv7sRzNdDH0c3VNVHYxr5u/wcu5GdOoJBg9O2Le8MeS
    K9NPvOglZO0Md0cxD9c7UsYt6C8KDa2FPq8vbyhIf1SmmYnsvCLlu9oC6k9UWY20TwF7
    jsAEsMWeZMTOv3AQ7sIAAH/D06GK1Pu1O5aVF+06D0zD8xcPHNGGiBWUWMnmGp+LSNw8
    1URg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888046;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=MMoEhD3T4Mmk/TVg1+CJoWpYJEJXteu3zhjGp+ZqWxs=;
    b=XdJdjeOxpRxm1UnBCdKqfz8QAh26cvxn0vDgnjkC6UAigmrWQyQ6bv2UJUNAn4ia+8
    svw2MnTHSMpyIK47w+ODp9D660I8WYaYFOuvNq4tS5q++AenYdeFhCniXOKXFB/0LkA6
    jqkeo3tvFCtQzD9Dcm8dzu5QXAkNyLY9648qViFYGge31oXpZSrC6nDxfTPb0sd+Q6GV
    r2clHHV/Hk5s+V9c2PuOPqYyJsOKmKImGtSFdYXbZgD1tD70F2XCS2Z2MVH/Z9MFjXnU
    FL5+N6lY/TBmKlO31Qwrwg4eUp89s1Cpd1utmpaHolAKHNbvWRTYTAsSEIYAA3CK7tOW
    iX+A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888046;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=MMoEhD3T4Mmk/TVg1+CJoWpYJEJXteu3zhjGp+ZqWxs=;
    b=CksBwaxhap54kmJ1zJ3Y1yqfn3+cEOVgwuRdpn0/ZVu2+Gnpp4OHHXIxIb2ZxP2KbJ
    us2A3ARmKpACeqaLXfWR52r+H0EhtKRyVZB2E5HePb9kYHdpZz42t2d39SzAcjQ7aqMI
    /7y0BRUY8SBMVxk3kPG0kI9O+yxxbgZX/LJlj6zTE1D4q3m2LIeettnh0KcCll9UOAwJ
    V8xtpaGEiDcy/nhoo/fpXe12OR0ngBYX04+OOlEGL9Xur9oRT9jvYyZ6nAcyYgXMpgQS
    qvQHyKgoBHeHbSaJS7HabTv2BZbgWNvUCaWSq/yKo24NeF59MBchsZUBSwD39O1tmii7
    iSgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888046;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=MMoEhD3T4Mmk/TVg1+CJoWpYJEJXteu3zhjGp+ZqWxs=;
    b=Hd7C/xPxGdR4LJBBHrTJre0bRkw4Iy7VMRslxAcMDwV5PNv2mCPuoyQZPhBzyCs77C
    aBvjr3c9HxgBX8FhWSAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAE6tFF
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:14:06 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10.y 5/9] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
Date: Fri, 24 Jul 2026 12:13:38 +0200
Message-ID: <20260724101342.16000-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724101342.16000-1-socketcan@hartkopp.net>
References: <2026072037-bagginess-bluish-c081@gregkh>
 <20260724101342.16000-1-socketcan@hartkopp.net>
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
index 8397fc2..09a6bd5 100644
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

