Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70D353A90
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882639; cv=pass; b=SnaiMwJY/A5DPw3VQWCiYoxLzphBTw38VnH1CwYrtjpQ74XWILoOw4u0NWUwigz0CfgPb0tnuYMVSqmxxJ/KB4br8UT3my974MMXzm4dMH3O9ZY4GNBYKGxyRScsEV+HzrjERsEWuqpkzJRW9pONT5gYIEi/2UTG2rrZWdVw+lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882639; c=relaxed/simple;
	bh=GG+GlfDc4uz/l9KTRpH8elHNvc1l1MqqvGfjNZ6xTSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuVEq0j8B76CG8ZV2y2nwA3TyjuKhgGoOI9q9BehjHJg9/TgttKVzwPgLpJateld3ohgvToTg1Cl0ecPZWv1e/OhcZoCyIYBPXkL3rvK5baEbqjJf3B3nY2SbDonfjfS0Lf4aaqW0EWzFsBNTbR5540WL4yFKfyMaUA+FoxyM0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JhEaf2KA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Pcu407ja; arc=pass smtp.client-ip=85.215.255.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JhEaf2KA";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Pcu407ja"
ARC-Seal: i=1; a=rsa-sha256; t=1784882449; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Yq313Y1QJTLy5U7bWJPnSqbcL+GqPH1yub6jDzmlDv0e6CqRB2VZ3m3gilPAzxQPrs
    Pqa4KpNwXk29WvuICB50zHsbY0yZudgaIeBiaHHljtsV5m0xKZJFbUiAoHBu0ICLWYw1
    77hoGKL9DXBZSnMqUQXKtX0QFANcSQJ2CwCL/qYu+9NW0ZiZjtqSD10s3RZuzhJPrDzS
    7S4r6L6KvsbtYFJF8M4CUuAWqi7kWAhzctrwScx6t8ZpMo1FHCaRO/YarL3W7S28p+4P
    Dzfp51LOGV8X1ETqKUZmCki6vjzYkdfYI5nAtOWUo8WLIdrKSFLjjWR3Jjtx6nPH3kRx
    O+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882449;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6zm6RLmPOq7X5wywsTliFUx52JQ13I5TWHgSzK37pBg=;
    b=PwQlEaP/Rx1d8uSI4LrFbwMMsCJQ9FuraqNAhsyKR9mTU7dWPsBPaxEQBZ4aqVQOgh
    5p4yftEfMZ4TWz2VcjoB15+wrtpnv+6zFjNfU3KfIyk9I5qp8mDBP1Mtdvzd6YAa7lkr
    8YoaoqHMSf3RLoiYYvb30+KxzZLP+5mq/nwXfvbPBsl1hMWUbc/b3jH0uXPa8sUkPxzT
    sbGiyHPSGs+2iJ0db/FfVvzFN4mPQalzGjoSP92YYDhYuHqtlIexLc1srYzXTTzvVxZW
    vmQu/7OGCFiOqJPsFIZQgWFmtiSEs4nXLu43XeNDe3RKegjdRp73QSVIVtSDoeNYV5dH
    PO3w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882449;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6zm6RLmPOq7X5wywsTliFUx52JQ13I5TWHgSzK37pBg=;
    b=JhEaf2KAGCs9bs+W7/0JCHYqSsRzpDoD3tvbRvIkkiu92zFjcQCy5moq35vl30wxGE
    OqZ0zxJ+nylxoAo7FR3IwujSjK42fJCuNaoBq1ogl9CbURjIFb//Du5SI5PoAbkfndHA
    wC6y1dugxdbmSZSC+WEG+UEgnRkeWZpDJjSJbSGyPmAzsrfnp1O+klo2WDZeseO+5BCv
    I/pXARhQDMYRGcS5AEsWtfwsvKUY82Fn5myhkGLy9cCcHlqNmCRFl66fFb1vdzPWaFyX
    2nyxm5KIfP28JSUSoYhOAx/4ior815qJW68bF8pLKUN4PwSq6Inp/xEaas8V35SMrISR
    LYEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882449;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6zm6RLmPOq7X5wywsTliFUx52JQ13I5TWHgSzK37pBg=;
    b=Pcu407ja6dADCCO8errwQIPtr9I8OVG77rKNSG49qpP9E2frKHlGHxrxNOqVFRzpSB
    ba/mp6F9T8wBAo7gHUDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8enrWu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:40:49 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
Date: Fri, 24 Jul 2026 10:40:38 +0200
Message-ID: <20260724084042.12984-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072028-goldmine-rosy-2743@gregkh>
References: <2026072028-goldmine-rosy-2743@gregkh>
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
index eb0e173..80fa80d 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1241,22 +1241,37 @@ free_op:
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
@@ -1319,7 +1334,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1392,16 +1411,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1503,6 +1518,14 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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

