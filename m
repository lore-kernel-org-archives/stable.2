Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E563C870E
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882346; cv=pass; b=bY3Nhw9Sfr0Jr3lWy7EEniMc/GnScF+TFhngkBUdaW2Xh9rKxj8j0Qny88OTDdgu0JMFdP5V0iB+fmLAIDZi63GSe8+qKn/kTHiYxhGRWCBeCxS4GuNFlrEhnT2/HuQ6Fx60ed8JBNbdpwga9wq+EA5L465jafnk335Wx0g2ZG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882346; c=relaxed/simple;
	bh=G3xnFzfZWqFFobQAxHC2BMN+3kMgEECKVYDwxdjAHf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEru6k2y4WwzUgbjGnqtKJVJqmuFZX3j+J6FYmwjKyoDMGViLcuMvhD81QQBYsNDHSZza8WBc+UGuUWDw/R4OAmIyqrTtia9k2qj2jarmm7CNT4Avork2+MO0XWplzTtmMBQ2y6X8qj/jtqeslV7F8sDVxJtF2OfW0bnrTBDB3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WGS6i/gX; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=5m1bH5/H; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WGS6i/gX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="5m1bH5/H"
ARC-Seal: i=1; a=rsa-sha256; t=1784882342; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KsBqVWOQwYt5hXXBLA45YBJrXg5eQ43+CdSH9vrSmjAszN6eKgWW5FCgFxtzA5RAKX
    mVmZg+E1tBpjyz9KTxRLTlTU2d7794gkKL0RvDVidaF0zPNR5EYAwo/iWxQJMcaaEZJO
    y6POnjSb4etYflNAvNz34lJgYi1jouhqknp0eEfJR5+DyIAdveg7iNFVF9NNA4odxFwE
    FnSNRrkon4gCrdKSwqC/sA6VOO7sD+BqVuokpk3qcC1PGAV+TpLn9MgJ5exBDgPEiPuk
    uerKy52Zr6a4UQtSbkRFyrumVnfKHDtGRmAHriheyTZs9dw+TCpDsM9f35iJTlrJxJ0p
    2xqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882342;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=lm/Gj3ybw8g0WC8hb6abOAXWMgufkFDbHxsjp0vCuqs=;
    b=TC33FIm94o23LKYp0RcBNST83Nn+LX7/QQ+pnbTmIdWF/3s2aE70k+DQDBwX5EM7Sk
    qaTbGc581ZKZ1LQO63CHJwqXldWSAAb2+41FlbRGveZHia4u810ofPBdNo0uIkWn/Msl
    tBmH3HdEKkWZbZU8kNvEx5lgcx7FXtQSAlmGahdvFph63tYsVmBZ/bjo2wL0CTvzpK/F
    Ue3lewsZQiBg3T/9O3dOm7X4w5UXm46YVz1NpVoUP/unEUZgZTXjwZlKysKA6wHp/AUV
    4Rn56cN+3scZ3E8msq/3w1E38bwoO9j7U0tGUpuLdJVULcBSW323vh+YDxGUIEaC5dy0
    rKyQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882342;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=lm/Gj3ybw8g0WC8hb6abOAXWMgufkFDbHxsjp0vCuqs=;
    b=WGS6i/gXgSM08oe30p0CG71b+p2iGQ6Tmco9h9pEgBJ3mLYtqIZGfjzzfp9ZL5dghU
    +DM2I28oDUrsZY3EIpMiWrDNfHN0mr7/TRYjyaoNk+X19ElR2/e5j8UER+yDSBf1K5u3
    3Jed1hpvmCZyMffBzXaEpckZJgzLdRTJlDITjZDrs3EoDjfOcrHRK1zNLHB7HpbMy/17
    k4791HY46Cn3c3GZWwJfwZE7wRv4FpqUJuOOD3OBtx169K+7HqN/DxsIx9mXv4VBZBqU
    wmDHi3DUEULzZRvPZhmS8rzMIbYuO74W//LF/HG9QWddGC+LQ9laTPrgnmg4My6bFcRC
    0Gsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882342;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=lm/Gj3ybw8g0WC8hb6abOAXWMgufkFDbHxsjp0vCuqs=;
    b=5m1bH5/H2UYTA20YdphMcb3z3VH4JxDhMN56fbX9mEFXqdPR4Hi3P3nOKSSY3Hwnfj
    YGKOiX3oUxUA6SwQBNAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8d1rT3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:39:01 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
Date: Fri, 24 Jul 2026 10:38:47 +0200
Message-ID: <20260724083851.12603-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072029-luminance-darkening-4c27@gregkh>
References: <2026072029-luminance-darkening-4c27@gregkh>
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
index ff6ca51..3e84f4b 100644
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

