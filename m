Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015342AF94
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888623; cv=pass; b=Qsu0fSDNUGYcKAckewTo66isI+2bK3vVQ6nRVfH2U2i29NzFWB3KVfujrAFcqTWSgBXzClucolnUMC2zB2mksBt+HY5XpPQ5C1AYiWc6GNrghw12lbj2OQItgJ6e2udphSJSNZWXdK/Lsfl1yQUiJC0nPUaT+dsUTsTUom+CBnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888623; c=relaxed/simple;
	bh=G3xnFzfZWqFFobQAxHC2BMN+3kMgEECKVYDwxdjAHf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwPrRGbkEaXEEBgu2irlL5vHygGx+dOQcEjhIgBPoa5Woekkfn0TDyPMWQxy6Gp7AosZV5Yqed/O0T8xhJLnfCdhzNiNsu/Nh0LReZ63XqHaRYUJaOeoeDIdVG1eCWC3/4lv9Coxr1n0SerE34PGYqrxgY1ZzmJuxraDF6bx9d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=omCVAI12; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=HvZhvuD8; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="omCVAI12";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="HvZhvuD8"
ARC-Seal: i=1; a=rsa-sha256; t=1784888616; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XbDOVSpAKTBZZ6k1/1njPKr6ykd7i1fW0VWUVgUsSB5dzClohmxDVfTA52/h3w3nj/
    mpDZFjyZj9miCZPGKB+s2MOFpT42BbaD3xPKV6qP1r8TCjLIyS9VnR43g2kJOKbkPbo2
    NRJZMhLz1FyD/3zjbjNiEBWHdzJtgeCFjsFK6eQGdgZfMSF3WzN1pl1K45Jie4Y6b1wC
    U0zqxubv+xbGEHUdN5ZKlfNZhmBlLKGwFcWUtWGWYY3qkDDpReUJ5R1tUwiXbJq6axsk
    XHcY2X6wnBhlABJUjUJd9Lmt2uVq17IYCsXUnZad1TMaJyi62duOGgtmt9gihoG8zz6u
    cVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888616;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=lm/Gj3ybw8g0WC8hb6abOAXWMgufkFDbHxsjp0vCuqs=;
    b=dDHWeu0aKhLQ6/RizrZEFh59CNQoQnUWolO1l9SnYVlSRpvKbFN8tT5soJ/gm4O7uU
    Qk3RlXtcbRzaGtRPn57PXaGgNg0u2XDs1SR6gFtJ6W6mSEbH1W1kEnktpPlt72B9XjWT
    VYKbvNfAhkM2gWnOGqi65aYSvnzXwItmgKDJZzhJGNuFVUkVbiCdYzsgFIelvZ52ydkk
    w6+epZV2QrkhiISuUH6CIldwMfqQpncMMWicbdK3TrnNdN27nfiGeyi82TZHiN4c6r/p
    paXzfZcUJ6qf21fm35ViWupJ0LjHtNMJffe7qTsQTr7c1gAjJnjeM/YW2YaEemaz/GBs
    1ulw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888616;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=lm/Gj3ybw8g0WC8hb6abOAXWMgufkFDbHxsjp0vCuqs=;
    b=omCVAI12bc0/YuDmwX/nElWe6tcE2w0DWVZND7J0/EYjV7cpzxYlZtplGXeeWCaEsV
    GV/QJuiKMBT0qq5fyiCDAUWDlMsKER33WkBLu4nCkYDuMrHCNnMTdJMTMe4V4Jd9FNdo
    ftkkOXzm5/hGLg/moLqRT6Be5pllycBcOib4d8FLP/0HNOydq5H3k7fzL7Cp3pUVc1Xh
    C9/Jo1nRo4HK0eegspIEwcWYzaUgTccosCDMrpKqwWQ/gF+RARhxlGiE6fy8gl0aerED
    z0TewqB+Uq22OQC6KBRsybT0IUMDMFimx76avscz7zveB9TQeTeR60B593MD2Pn3gC9s
    RdJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888616;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=lm/Gj3ybw8g0WC8hb6abOAXWMgufkFDbHxsjp0vCuqs=;
    b=HvZhvuD8R2e2b/VKc7t0YP7lKlavPnVoT7LMas9yz978SqkpbQeGUG69pYflqq7U/C
    37mG1J/2MjwqoCTamUDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OANatIH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:23:36 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1.y 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
Date: Fri, 24 Jul 2026 12:23:25 +0200
Message-ID: <20260724102329.16572-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102329.16572-1-socketcan@hartkopp.net>
References: <2026072012-repair-flip-109e@gregkh>
 <20260724102329.16572-1-socketcan@hartkopp.net>
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

