Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575CF3BD650
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560510; cv=none; b=jWXuNd5ZHl6uyXynn7F5fdHJ1LTh9MSFF/TfGx2x3fpusFxiLwjF4yY0vSvdatpp/fip6KI4zxayvWczgoxHgKUqHl25411BCxd7XnUqqrduOXYzsVveBb0pKxXKlbI93jeu0Yn7dfbODGCUEbE3Uo5LZqz0P/j2KhinG8jH/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560510; c=relaxed/simple;
	bh=Rf6mHxYRAa/sIHHpFoUUufTCQGdneXQpk2Ohgx2qnSg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UjX+K+XiUbAsbCE0W2WGrDgV8mtfRNaoxovY/WkpriGV3zCTTHE958GkMGEdBJ31UJk9mwGQ/TKqT0M9cRhV62eG5ejna43EJjKd28h1HqsZ4trNmK/WDMFbB3ryv9FjX1pfpbDmBl/PoFyIuhPpVED/kwa0qjCh4hPtTBE6dVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BsMpFPQ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BsMpFPQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55C81F000E9;
	Mon, 20 Jul 2026 15:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560509;
	bh=qj68Z3oI/oAc6/Fm8azF4519DOi3+FWcQyZThGDT4+o=;
	h=Subject:To:Cc:From:Date;
	b=BsMpFPQ0SW6P0d2dsinC2OQAWzn0SmKJC/iBP5kMEv99HVV518STlw6dbIR2y23uP
	 T9cxORy5wO5xazIeEmI1FDN+w057ak8LG4A5mpWZ4FIpMxmr8zKKx8gQXBm/BMfN7a
	 qtY34gGbxYpGBYCzoUHKxNaAmXNxwGQlVSo9x0GA=
Subject: FAILED: patch "[PATCH] can: bcm: validate frame length in bcm_rx_setup() for RTR" failed to apply to 6.12-stable tree
To: socketcan@hartkopp.net,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:14:28 +0200
Message-ID: <2026072028-goldmine-rosy-2743@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 62ec41f364648be79d54d94d0d240ee326948afd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072028-goldmine-rosy-2743@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62ec41f364648be79d54d94d0d240ee326948afd Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 14 Jul 2026 18:55:29 +0200
Subject: [PATCH] can: bcm: validate frame length in bcm_rx_setup() for RTR
 replies

bcm_tx_setup() validates cf->len against the CAN/CAN FD DLC limits
before installing frames for TX_SETUP, but bcm_rx_setup() never did
the same for the RTR-reply frame configured via RX_SETUP with
RX_RTR_FRAME.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-7-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 68a62f605432..2d9c9cd74536 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1246,22 +1246,37 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1324,7 +1339,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1397,16 +1416,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1505,6 +1520,14 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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

