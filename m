Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4623CD8BF
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882636; cv=pass; b=B/OKPyGHd+5vpdpvlkrWSYyQvhCovv+XtRrJtpK+AAykUVF5PVHJir7ZvrTdWIF8684GRhf1dn6zrjOIzTlCFDwRkss/lsTNUQys3LxU1dh6IRl0b3+fDn+aX1eRVNYHH5Pk57QicG1dT/QRgnZfIiR8CvHWBfRZ424TJZadJE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882636; c=relaxed/simple;
	bh=Vj18neYRvlbtEfL+86N0scG2hks72IYC4cPDvY1dznA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0MSdV0fSBDpJHauHZu1X8xvfN+gsYOYcEYflwggEG7QSV7KvscsIgiiBczLgMYSJylH4pjeZOIXKpliCOGPXILIAyvIgBpU0UOL4nlkYpQHq9pWn0UJvwriluOW9DBvSG3ctZ6i0nDr6BMoMHggf3Z+HRSBTGdmVlROuijFwpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=F7MDF5Jh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=0GY7+gao; arc=pass smtp.client-ip=85.215.255.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="F7MDF5Jh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="0GY7+gao"
ARC-Seal: i=1; a=rsa-sha256; t=1784882449; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZMc+e3LlkhaiJBUWH8aCsXRAOLZNkPz4QGxsmJKK8n8Q/7ylhXxtiQ9CAvEiuOHPn/
    Baza4C3bu8gr4ZzRlPett+FGJWVRrD3qtGnq7lZDeXRsZZAhTEwj774OxiYqFJoNX68+
    E047SbBjwwbUgiRUSNybgxHR6Nbt7tZTf18dHAa7Oap1ELMYoixb9ATfRRjCNMUO7W7Z
    SbKDTc1huBVo8gLjnX6JIx4jcrMQuCcSnwO3pUlzfaC85eZzySwYgB5yxUWbcLOB3idR
    uF5rCA46i7XPaxjXnCJiDWy9zQJbkqe1d+WmUVHQUxSrDXD7N//iIXUgLFsQ5HXyVPtD
    2XXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882449;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=b3nB3OzW8BKuj90aMpK7pBpiNZ/INncCqowEsHzqJqg=;
    b=FDQSyW+KdE7ECZtvWW0dMRR6ZtY8Ht/JX7N6fCEfwT1KPiHBn306BjKCmp6aACZ4ZO
    M1UMDcffyn5omMU7R8Fj3nbP7BPqVoZnI1tgfX0qckziZjgKIGPjTXYmckXpDs/pWuXb
    T5xuLZlSIKgIAE8wx6IfDuB4iKqdOdnHlQ5f3tW2TueWYBmJwtCKozYzRZKUPq2ykYxo
    qbxfwovgBPZTiHXoLfukz6zru7AAreAVGMp/Va3HfgMXxgu/eEEQhzuau9RJskuT9l5N
    FJbn0QViLE+/fCsgfkUgexAM9x1/LWR9pSVpvaixTsc21owIUfnY2sxch6yvF7r/aUza
    SC4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882449;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=b3nB3OzW8BKuj90aMpK7pBpiNZ/INncCqowEsHzqJqg=;
    b=F7MDF5Jh/T2oXtil855nbVc/nnw92g0fScsfRemRhlEfCTFsn4V/XGnIK6xW2HVmwu
    /zn3GaUfPE79toPwjnVtDS5cY2sF8RORM7TE72JFgKkepJYrJXIWicq/IIAVUg26A42t
    CTqkcaJybStaPLZQHwDhxes/ucpHhy710LrYJHWhO5fdf8O+Aw/QXSeMGyobBSkyiAID
    cuXYu8sMDJZHguh368tQzitFsMhHiEeis2et39tjHEZ0SY+OfYhmWR2lUrtjHWQsFgDi
    zeQa5sziEyEA7VG1yekB0DeUniekSqCEVgbzFlw7hqHIzQ3wEXJV9iuv7I/RQocqVR1z
    w22Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882449;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=b3nB3OzW8BKuj90aMpK7pBpiNZ/INncCqowEsHzqJqg=;
    b=0GY7+gao6TOe2BZYy+8e9U1PCbVQKPD//nynuYxp46jT77JqEhpr+8xq1l4KYy7UjU
    GQHrtSh/H3hvo+aLNADg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8enrWt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:40:49 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/8] can: bcm: extend bcm_tx_lock usage for data and timer updates
Date: Fri, 24 Jul 2026 10:40:37 +0200
Message-ID: <20260724084042.12984-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072034-name-yahoo-51a6@gregkh>
References: <2026072034-name-yahoo-51a6@gregkh>
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
index bba0b27..eb0e173 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -127,7 +127,7 @@ struct bcm_op {
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
-	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
+	spinlock_t bcm_tx_lock; /* protect tx data and timer updates */
 	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
 };
 
@@ -466,12 +466,18 @@ static bool bcm_tx_set_expiry(struct bcm_op *op, struct hrtimer *hrt)
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
@@ -488,25 +494,47 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
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
 
@@ -1030,6 +1058,8 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	/* check the given can_id */
 	op = bcm_find_op(&bo->tx_ops, msg_head, ifindex);
 	if (op) {
+		void *new_frames;
+
 		/* update existing BCM operation */
 
 		/*
@@ -1040,11 +1070,23 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1054,36 +1096,38 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1160,10 +1204,12 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
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

