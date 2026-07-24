Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98F42EEA7
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888725; cv=pass; b=t3KuKWgBfEvKsYi+VMliF3mnFHetoaNJsFg2AJ5Q2ZckTE98Xt3M5hKKz8wAW0Ka29Qujrr/4P/7R0Sa9YCOC8dc7Dtm2KpbzDFIqxjBJo4gM+sUKwqE7suw0kfIHNEEHLzpd9ehWxpiOrbSzibh7y9gBJJQsQFg90hI9TEfV5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888725; c=relaxed/simple;
	bh=GG+GlfDc4uz/l9KTRpH8elHNvc1l1MqqvGfjNZ6xTSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqzmDyyIIX3Kbmn975ANF6qlt+R8VjCpbUPe+cS4pzYugj+0bw52kgi7XHLqVNNJF0Jxf5zNQUE8N6U07P8gJWAwFSJtG2J2Lt7Jl37phjBsxBF74OPb3E/wPK+4/EDxKjy5NwNo3R9jYLvusvsr/Gdgk1JE5wb8Y2pegBE5gLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=G50Ln/EF; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bgPfIQNa; arc=pass smtp.client-ip=85.215.255.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="G50Ln/EF";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bgPfIQNa"
ARC-Seal: i=1; a=rsa-sha256; t=1784888720; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=X0KuU1ojTFhBnLsbmt3eW7zj5Lvpt1PKo0OMqjMY0qI/NrbYl7J44ocSDjarAlUu13
    gaJpgfTfgvC+jgoraS1U/SI54KWbJQCZDxvTzV5SOLGEBq61QVHtp300gBZjpKSqp2TF
    akw+1RXMEqSiqrV9Sq0tFxaFjo1r5I9dGFGbdrbff3SYIju96HGSWHaJYidvsVdryAa/
    xTcY8yziYi/UyEghkbNVheTkzr9m76OMI6cbQKGXMxNRBsPoUf0FYsBc2bZdZYQpgTmu
    nd+FvPntgRiZo0UTIjYE21IPvxd9hx/7ZLt7ehvFP13QPeA9Jzjjn53CbvuuYLyKd+/f
    R5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888720;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6zm6RLmPOq7X5wywsTliFUx52JQ13I5TWHgSzK37pBg=;
    b=V9bvv5ueX7FjnMUpsotoKCxFmQhSafx2+8kd4X4Tj2SdckWIfsZH+Na3SN+H4juIeK
    HFfFmGehcaSA7LI1riF+kiTKRmYFvhLcW9DJsAWLCKZ9X9JUZK/GQg/ntvJWseAppXFT
    dh9e+F6b4qPtUMXO4nOBphmsHMHmBSDX1uNE8sjjZTwFtpNlPchATiMl+qAvkxh/1n9V
    csWkUV4r2uPLSXKhZQrsJ/pXT4pZLBA3fLUp/PI9UAGZLSofk0uy7MIUc0ztoJU45cS6
    QBMuu0qMom9GPag2qSTEwhwj1jS035hx8o4YTTsG6ETznPAbzA8dLyarn1nCouIeZDdd
    ZVVQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888720;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6zm6RLmPOq7X5wywsTliFUx52JQ13I5TWHgSzK37pBg=;
    b=G50Ln/EFnUFBo2iDDS3X7fIJKFWGhf5yVlk2AVT0ChCxYFKStjaAEwzl60P6UQFD/V
    y6muZffV8+IkkBDOIhDrBRpO3d0dQY38yAVYPdsgQJatU0hwQfvMK/0H0oNqNK1lDUkM
    t4tJqLqEV+gcQ8mlNV49Eyt4XWO22jAekLAkcXOACkNJ1C00nG3JMrra8H87J0sZWAzs
    5m6Ti9VAol9gcaXpYP0Cc1Fcm6d0ctkJXuxRy/uRTx2lXzK88u9L+g/fSWR0heSXvmZb
    NrJJSmfyDdsIfWA4ZefXjESb+Dp1dCOXMQVJP9qie/EfixN3HUlsmKGjGTrNAO8qj66g
    7KvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888720;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6zm6RLmPOq7X5wywsTliFUx52JQ13I5TWHgSzK37pBg=;
    b=bgPfIQNarkvR4dsDtgJTKorC3vU0qo8yEJbHzUEpuwBqgqSpHQiXQQjdFdB1YldUGD
    nhAjZpN3TkRlP5QMiqDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAPKtIw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:25:20 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12.y 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
Date: Fri, 24 Jul 2026 12:25:09 +0200
Message-ID: <20260724102513.16898-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102513.16898-1-socketcan@hartkopp.net>
References: <2026072011-atypical-tapping-9d9e@gregkh>
 <20260724102513.16898-1-socketcan@hartkopp.net>
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

