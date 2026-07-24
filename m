Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD3279DAF
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882333; cv=pass; b=ZsQbjEnpsw9Ua4MdmaKqMOvCqXu/4Zg4d1NxYhqEp6A70Mr5Y1dPPu/fk81NI0yU0Zyqibjwv7749lbX5duCGbjq0mkppxaVU2gS5OxlK5Kbe/2nbJryy9E/kb9o5DPRAkCqCdSMLNz78+TRF5lcv/vDKFZJwU1zPrwZalEM/Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882333; c=relaxed/simple;
	bh=WRJw7eVuEJKKNzMjFcz5LEUNkJ9hyOZg3lxqXbIkY0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pw8GyBsYMKF8VIf1y0g+1KqBXVTDg7KXjGD1pzwOeeLpjd1UPHK4/Z/rMj5A/OXSHXtM0iynJJBCrHbZFmz6HiLiSqArPpwPO6SXvmz89RwRz4V2YjggRU9825wONV1rMkSIww893JY+kq9H0784Ywhw9CpVpBG5ZYCmcZKrnR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Bgjuf/A6; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=i/mgmwpu; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Bgjuf/A6";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="i/mgmwpu"
ARC-Seal: i=1; a=rsa-sha256; t=1784882146; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jxdr/Eo8lZwEp9vZksEvTGoB89QeqHW61ekTshwsjcZycYDAtXkemLhYulggI1npeI
    s6EekIQspBnNPt8iB3xrIJ3QNnlevuI1/qkE/vr/2Xdb6Ne2zXShjFit0EHrN9fO61kf
    lhnLeMCNb/nOrgYipj8W6jCXbP4+hgvai5jaDx6+EaAyryK6Q7ZW6By3Iy1YaY7NfW/f
    qNsky/wHRvAtwmH2Lgqmo9Wivgm+P0O65gmPaHpL2mcXFYQuJB7/5Zyae53s3tgInSS8
    ++99ZSF1LONa46miTNRzdbmT8p4WQ/p4AMkNagyTVCjTQUvk2996WOlssfzxjHanm8q/
    0I3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882146;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=MMoEhD3T4Mmk/TVg1+CJoWpYJEJXteu3zhjGp+ZqWxs=;
    b=opSIkEpzMAllS1huKwnww+6bB3CH+tixIoO0ffZxnWqzKus2DOM4MwbLX8aBdjXbEU
    CPe9xybMGwDZCRB4cXiM+xsQurLTQvpGLK+h6xMpB1rr6GBaR2th8W2e73BqKXLdKM3X
    na7bhf+sxshFeS97BZFRkctVu/HBMP40uEx6oI0JATkAKQJmIaxz8y96+4/XodEFWRnD
    UJVbQVB8H7iO+nc04i19gCmYEed3d9IuyCW0JWV3TeVWDxxP0VwLeH0G7xb19ihb3N2G
    R8VGsAvbviDrPglqAa3sRcRM0/Wl9EkxFlxfANIdI6CYZCTPaacJwTJl7XqcgOCVBZ4e
    h98Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882146;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=MMoEhD3T4Mmk/TVg1+CJoWpYJEJXteu3zhjGp+ZqWxs=;
    b=Bgjuf/A6/2M1M4/l7Dh4QBfNr7q0fjIoWRYWwQQRtCusSnaUMH3gpGIMzropYGD9tg
    PWMDRHxt4Bt+R+Io12OHJoWHyxZGvHo5OKMccr6WJ3Rf9ughaEmQ6OhM23ZZ+noFE7/A
    fpCiTi8THCugkRZTBLWOM3wgM6SQLIwUSoQTIKL9ud9+RySYqto0ikwOJz1mO7nPgW5z
    84Qr+d0vZPM6QStbM5qTyCHb/ebnyYGxJwCGyAIr31HifrHGgbVZKL0/4kP/U6F+KhWI
    Yul9Mfo5YVmEzeAyez5Og5f1aRrwqOTo5VqRlZrCgwLgRQUBrzuXtwG57SRETvgCdC6l
    hV2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882146;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=MMoEhD3T4Mmk/TVg1+CJoWpYJEJXteu3zhjGp+ZqWxs=;
    b=i/mgmwpunCquVA+7Vq3tD2mwgT6mM6KqZMV83nZqGUGMCTC17vgS9n4T9vKcrhgbc3
    FQL7B6Uq/5Pnw65za3Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8ZkrM3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:35:46 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/9] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
Date: Fri, 24 Jul 2026 10:35:30 +0200
Message-ID: <20260724083534.12119-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072029-swimmable-robust-7e81@gregkh>
References: <2026072029-swimmable-robust-7e81@gregkh>
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

