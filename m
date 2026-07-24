Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8423C4168
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882407; cv=pass; b=XqFri2AwTHYrIIyDRa3eN3x/FyvSoWP2QT2NhsWLPWbO4dJBHzIgLiYDlLPindoqse7jAOVM/Mids0NnQCfNvSnz1I35vXEKZxEhCbP+ID3XYr8PjbglD6Mf6RkUCnlK3uGYvcVGr6ILDxP9yWMn1GXR85fB4Mb7hf/V7Hpr2lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882407; c=relaxed/simple;
	bh=Vvy5tFMn0p5UCMAtLd+u3aKZVXjq8e8ldTYJibZnIf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCEOG5J1yb/3VzR/4oE1rp6m8bJ5wIAj5K2UNAly+1hkfAciQjeznJMDQ2kuTf2bqpGiWZLcnUd+g8RiDsR9gafw81Tt+DKzWFrFiG+lOYkXYGAHKXT2A6LIR3os+PwgaQMvok3hGnqwYMJlzh4mMsdo80658mVAZuLUV+rYrG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dDZeCLog; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=d0SLPHob; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dDZeCLog";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="d0SLPHob"
ARC-Seal: i=1; a=rsa-sha256; t=1784882402; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ho4RAjDHJ/dfIm4PpIZQol6jQC7gDxD8aE35h/bI4pFIboTfDyYOwC0qX5yBHZVV0g
    ImcqtRld6BbncA9Y5hHG3h45LlFGVHYBl74jgQmQCKvx7KsbsfZkmzPCEV4NyJCJRqPv
    dDRdt3oM71txdEz1iy3ueuVxv5SQrAw+VcKz+OU0dSyQltdl6w65tgY3kTafwsMfMqph
    rvP7ELRa8KEZQqT3n1eEd7RR9SpwBomDEZGZ0IweF9o5WXTcFvmcn0QiALrmwKJZXFtq
    IcK6b5fTYDLIdrxwbW5MyrrhAxfgNfDpB0zZMSYDgRH0TBiSWGcfeXDHuZygfmEfp/E2
    Td8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882402;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HBumkadRmWc+ZYfkU1fuJD5LOaG/+9/IriXMOUYPzGw=;
    b=j5VTZ8z7bJWzW+99pLdT5hXKyLp9yJm1/sMAqxmAHfi3PChoVWnES4WjfallObr+en
    A1IAgN2/K0+LLlrMtFmbnf4JkpwIuPoNZdhu5mlYrFcwXa6uIO9m3EXSjVM+Bgsp8FBe
    Ye3jWjJUuyX69VwQLPe3/DbfhceMveRwW6h18gFvLKtF9hMCQIyKIJuArFQghDKrmLUA
    BbUfB6gy66xXxT6lkk7tSPytdjrfjAH3pqzeVlC4erIxjLP+3MBJMcRAbxF1JKT0wEF6
    4cVQTAqZZ65ASKQZnNULYrDTZD7tP1TBEiWQ5QNkmhVh7Of3WgKv/egGRsOODU9LlAo6
    HHdw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882402;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HBumkadRmWc+ZYfkU1fuJD5LOaG/+9/IriXMOUYPzGw=;
    b=dDZeCLogZ3UQvxlHfYLT/ciiU3CxcF+6fxxMQXhg63U3I44fCcyUQbRHReHu5aPQ0n
    HjBb/aiYA01qIcbsD0gB34zGbCNoH/1tHgdwCUtCfQr1zF0T4PD+jrL0B4nGaTyky0LT
    QQAySm47Nej7Wzaju1T3gsl6IS5Fqkno+oQeI5H3bi0yqznjvXYi+GEj6RA0lxevAD5l
    8gnclGA+liHix8BUfXcJBN1weiO9WN0d+26k8Ol0O+9QdhbIfby3c4w655K5NhucX3to
    udSHU36K6TiM1v+n8Qrs5DhWXCz+4W4zT6jUFVmHBGWCICIP8lvOJS5+fNC1MQ5VR+uz
    89Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882402;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HBumkadRmWc+ZYfkU1fuJD5LOaG/+9/IriXMOUYPzGw=;
    b=d0SLPHobx7ijVU/PxjUOsPw1FoVv63t5G9h/7tfTfvUBBJ2/eG8Xo8JmU6JZvatYej
    s107ssNZuhh9mIpGndDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8e1rV8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:40:01 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
Date: Fri, 24 Jul 2026 10:39:50 +0200
Message-ID: <20260724083954.12817-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072028-pecan-railroad-6cb7@gregkh>
References: <2026072028-pecan-railroad-6cb7@gregkh>
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

