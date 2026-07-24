Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164842882B
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888667; cv=pass; b=rx7t7UwIt1w3S6J5BRSuUMs97O5p/1TsdSycpSf7b/XFaA4J+pbm4cRtvuJTpL/BGZ4DRNwjMHrKQtHxofzHwrBDkOUIzRcJrTLoTR9T+aPM6OI1sMxrziBUh/30hYEIdHSeIJ+lYJBdnCTgYtGXR+mSz657EOWR89AehejXkjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888667; c=relaxed/simple;
	bh=DBfu49NF4sLsfK/PSt1Ua/yVe0eJoMmhNnaDD5ehC8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3Vyiq8/UqDYUk3MSfaPYwu/fWlBnTG5X6smKjz0PO974wlgfWPaOpof+DIZkn6RMMvNxZUIQXn56oCgeOe3jNJwEGFU6+2cB8f3RfMwPJiyNQe7vOqvy9rPtRs70Hs157bRFx0wt1ZGBQbX/STMwhIw+b6aml65kHb6/8Yjmqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WUZGwJ4N; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NKLE9f1j; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WUZGwJ4N";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NKLE9f1j"
ARC-Seal: i=1; a=rsa-sha256; t=1784888660; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=c2G/a+a4KRHagjQaiLVle84mzUR9Z+R55d0970tr5xsIk28H5YAyFRALjIZUZLDR06
    K/mmaN6SwcI1YzHlQjcg0NPmS6PSfLA2ELr1Ogg6shd8WB5uSDgzfb1p6SJSLvrzF0Fj
    mc/yaoNCe66gh8pq04oaeGpmMoxVrfPhcZnCyS4YSbPB5DnvnTIKunfORVOmfTQkZDJd
    C9w2dMgUvozdN5NhMCF3jNtzkH6Kbcnmtqi0kZq8MKgXsHsD6kMooo3WM3OqvGU4qixp
    rE0lZW1X6KFS0DPeAYgQVd8W/yWfv9ddEtzBt7RX/OVQcNtdaYNWV+eDAUQ0ld5uZJTZ
    NkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888660;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XPMdLfKpt4tvZuM0mnIk6MzLclmOGk8ieT+fodWQ1I0=;
    b=ZHaBFZtu51yjDzdsCesrN5QA9rrslEJve9uXhBG1VNKH0g7Zm/i37N3kep3fgzTxN9
    71fCd/hZCYX8owuctDmMEhkQGxXClWNIz9Cdn17K7mFREf6d725iKTbGMmzxuOV1ZDn3
    vY3+Arg1JH+O24fZTAGgRHTsYS7D3GCmp66JbTd+iZSglSPBhU5WVIqe4t36uQM+1OE4
    GlJGApZRCBpvpceZJqYm2+rxvNAB9e/2c3OJRr2qwpG9lCa8+z0QSP+gVHk29Umt4PT6
    1KPlsRYQVAKGsImyDGuvnvRsFYujD5I2uR5jNgXPEBlYrSsNqlkXxSsD+fOCYEszHflk
    ly9g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888660;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XPMdLfKpt4tvZuM0mnIk6MzLclmOGk8ieT+fodWQ1I0=;
    b=WUZGwJ4N4+LlWRDCEznmCVXrtegGBDIyJsMdW+i52UGtJ9EVermIY91UHgZO+grwoy
    7jktbTalHvgRWv8CHCoETQzcXqM/GDpZrz1yuDLkodleQ78PjykSK+BU/ODafc2/2UTJ
    rz3LO+kaRDlaRJQ2pORcM7Ohw5nLc/1JfYxTDrdrkofLJgEcSmme1+x2RNVQByDhwKLu
    vMfEHku/HBSy5YM3x/0byLaapsnfPWDr2N/u6bZko7KRbwH0Klp7MExKlaEr7i2ZJQLl
    eOjzKXswmGRNUbAfCFwIZtehMf3e6vK/u96CAOmfcIZJ2bJFKBh33W9gsw8gFA4scgvX
    BQlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888660;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XPMdLfKpt4tvZuM0mnIk6MzLclmOGk8ieT+fodWQ1I0=;
    b=NKLE9f1jtmD9EEmq+YJ7FgKNJ2eou8jx/txhLqpKWXwOyYjVZKPRcvsTs9y/+j7Jxx
    bM3XfDJLF5XsTZa8oFAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAOKtIZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:24:20 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6.y 3/8] can: bcm: extend bcm_tx_lock usage for data and timer updates
Date: Fri, 24 Jul 2026 12:24:05 +0200
Message-ID: <20260724102410.16731-3-socketcan@hartkopp.net>
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

commit 12ce799f7ab1e05bd8fbf79e46f403bfe5597ebc upstream.

Stage new CAN frame content for an existing tx op into a kmalloc()'d
buffer and validate it there, mirroring the approach already used in
bcm_rx_setup(). Only copy the validated data into op->frames while
holding op->bcm_tx_lock, so bcm_can_tx() and bcm_tx_timeout_handler()
can no longer observe a partially updated or unvalidated frame.

Add a missing error path for memcpy_from_msg() when copying CAN frame
data from userspace.

Also move the kt_ival1/kt_ival2/ival1/ival2 updates in bcm_tx_setup()
under op->bcm_tx_lock, and read kt_ival1/kt_ival2/count under the same
lock in bcm_tx_set_expiry() and bcm_tx_timeout_handler(), closing the
torn 64-bit ktime_t read on 32-bit platforms.

Fixes: c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-6-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 104 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 29 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 762db0b..8529061 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -125,7 +125,7 @@ struct bcm_op {
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
-	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
+	spinlock_t bcm_tx_lock; /* protect tx data and timer updates */
 	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
 };
 
@@ -440,12 +440,18 @@ static bool bcm_tx_set_expiry(struct bcm_op *op, struct hrtimer *hrt)
 {
 	ktime_t ival;
 
+	spin_lock_bh(&op->bcm_tx_lock);
+
 	if (op->kt_ival1 && op->count)
 		ival = op->kt_ival1;
-	else if (op->kt_ival2)
+	else if (op->kt_ival2) {
 		ival = op->kt_ival2;
-	else
+	} else {
+		spin_unlock_bh(&op->bcm_tx_lock);
 		return false;
+	}
+
+	spin_unlock_bh(&op->bcm_tx_lock);
 
 	hrtimer_set_expires(hrt, ktime_add(ktime_get(), ival));
 	return true;
@@ -462,25 +468,47 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 {
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, timer);
 	struct bcm_msg_head msg_head;
+	bool tx_ival1, tx_ival2;
+
+	/* snapshot kt_ival1/kt_ival2/count under lock to avoid torn
+	 * ktime_t reads racing with concurrent bcm_tx_setup() updates
+	 */
+	spin_lock_bh(&op->bcm_tx_lock);
+	tx_ival1 = op->kt_ival1 && (op->count > 0);
+	tx_ival2 = !!op->kt_ival2;
+	spin_unlock_bh(&op->bcm_tx_lock);
+
+	if (tx_ival1) {
+		u32 flags, count;
+		struct bcm_timeval ival1, ival2;
 
-	if (op->kt_ival1 && (op->count > 0)) {
 		bcm_can_tx(op, NULL);
-		if (!op->count && (op->flags & TX_COUNTEVT)) {
 
+		/* snapshot variables under lock to avoid torn reads racing
+		 * with concurrent bcm_tx_setup() updates
+		 */
+		spin_lock_bh(&op->bcm_tx_lock);
+		flags = op->flags;
+		count = op->count;
+		ival1 = op->ival1;
+		ival2 = op->ival2;
+		spin_unlock_bh(&op->bcm_tx_lock);
+
+		if (!count && (flags & TX_COUNTEVT)) {
 			/* create notification to user */
 			memset(&msg_head, 0, sizeof(msg_head));
 			msg_head.opcode  = TX_EXPIRED;
-			msg_head.flags   = op->flags;
-			msg_head.count   = op->count;
-			msg_head.ival1   = op->ival1;
-			msg_head.ival2   = op->ival2;
+			msg_head.flags   = flags;
+			msg_head.count   = count;
+			msg_head.ival1   = ival1;
+			msg_head.ival2   = ival2;
 			msg_head.can_id  = op->can_id;
 			msg_head.nframes = 0;
 
 			bcm_send_to_user(op, &msg_head, NULL, 0);
 		}
 
-	} else if (op->kt_ival2) {
+	} else if (tx_ival2) {
 		bcm_can_tx(op, NULL);
 	}
 
@@ -988,6 +1016,8 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	/* check the given can_id */
 	op = bcm_find_op(&bo->tx_ops, msg_head, ifindex);
 	if (op) {
+		void *new_frames;
+
 		/* update existing BCM operation */
 
 		/*
@@ -998,11 +1028,23 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (msg_head->nframes > op->nframes)
 			return -E2BIG;
 
-		/* update CAN frames content */
+		/* get new CAN frames content into a staging buffer before
+		 * locking: validate and normalize the frames there so that
+		 * bcm_can_tx() / bcm_tx_timeout_handler() never observe a
+		 * partially updated or unvalidated frame in op->frames
+		 */
+		new_frames = kmalloc(msg_head->nframes * op->cfsiz, GFP_KERNEL);
+		if (!new_frames)
+			return -ENOMEM;
+
 		for (i = 0; i < msg_head->nframes; i++) {
 
-			cf = op->frames + op->cfsiz * i;
+			cf = new_frames + op->cfsiz * i;
 			err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
+			if (err < 0) {
+				kfree(new_frames);
+				return err;
+			}
 
 			if (op->flags & CAN_FD_FRAME) {
 				if (cf->len > 64)
@@ -1012,36 +1054,38 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 					err = -EINVAL;
 			}
 
-			if (err < 0)
+			if (err < 0) {
+				kfree(new_frames);
 				return err;
+			}
 
 			if (msg_head->flags & TX_CP_CAN_ID) {
 				/* copy can_id into frame */
 				cf->can_id = msg_head->can_id;
 			}
 		}
+
+		spin_lock_bh(&op->bcm_tx_lock);
+
+		/* update CAN frames content */
+		memcpy(op->frames, new_frames, msg_head->nframes * op->cfsiz);
+
 		op->flags = msg_head->flags;
 
-		/* only lock for unlikely count/nframes/currframe changes */
 		if (op->nframes != msg_head->nframes ||
-		    op->flags & TX_RESET_MULTI_IDX ||
-		    op->flags & SETTIMER) {
-
-			spin_lock_bh(&op->bcm_tx_lock);
+		    op->flags & TX_RESET_MULTI_IDX) {
+			/* potentially update changed nframes */
+			op->nframes = msg_head->nframes;
+			/* restart multiple frame transmission */
+			op->currframe = 0;
+		}
 
-			if (op->nframes != msg_head->nframes ||
-			    op->flags & TX_RESET_MULTI_IDX) {
-				/* potentially update changed nframes */
-				op->nframes = msg_head->nframes;
-				/* restart multiple frame transmission */
-				op->currframe = 0;
-			}
+		if (op->flags & SETTIMER)
+			op->count = msg_head->count;
 
-			if (op->flags & SETTIMER)
-				op->count = msg_head->count;
+		spin_unlock_bh(&op->bcm_tx_lock);
 
-			spin_unlock_bh(&op->bcm_tx_lock);
-		}
+		kfree(new_frames);
 
 	} else {
 		/* insert new BCM operation for the given can_id */
@@ -1118,10 +1162,12 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 	if (op->flags & SETTIMER) {
 		/* set timer values */
+		spin_lock_bh(&op->bcm_tx_lock);
 		op->ival1 = msg_head->ival1;
 		op->ival2 = msg_head->ival2;
 		op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
 		op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+		spin_unlock_bh(&op->bcm_tx_lock);
 
 		/* disable an active timer due to zero values? */
 		if (!op->kt_ival1 && !op->kt_ival2)
-- 
2.43.0

