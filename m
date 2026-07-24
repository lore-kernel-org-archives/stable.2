Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0AF39CCE5
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882720; cv=pass; b=fVYfgUVt2qwB3BNTnHg41KQHZwODxpIGhBkQ0wMX8RYrrsnwBZ1K+d+u6hCpFgGxFNGTwjy62JcO+/jfBPayVhBLDH9yMZqcF+xjaFyfVm7WtxFXzyxJuo3AnUFz8+Qt5TOnLuONP5DNZsuaKtc42akivZJp8ZPbrpzhj4ztufQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882720; c=relaxed/simple;
	bh=NhvkOuLb/yVnd2UBn99m8hb1o5hI4L0utC8GtjiKWkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hi9IsjMCFmkKa3uKzztzjqJV+NjZ9tJk1K176AdPLwcvx1BYvayyhJQ9ZGTE1sc6VKoJgap49lHhDUrTlaxRCZT+rYHfRH1U4SG3wWuO4mzDWofJYeq7HvmCL9+Wl4XM3xSLnpk2r76YF8gRU+8i13uy8qYIJps6julcwUgyzz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Bohm3U4X; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6XDlUngq; arc=pass smtp.client-ip=85.215.255.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Bohm3U4X";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6XDlUngq"
ARC-Seal: i=1; a=rsa-sha256; t=1784882531; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ev+nRFci8Z1fG6N/a72TBy8kPuB7FOmTg7BX50Ph6oq7BAVPQYydAHyJqKsThpME9I
    BKesa6VusXXs82SMIV7Oi82svMNccxeLOZUTkCiEYyugwQM2dutHmli9xFtf3WASvjD1
    /hcwQtVQUqjLMCVeekhMk3cwx3eQKuznGAbOpX5qdg9+a92+FZaULaoc+0hcJyupC6sE
    TqV0sTIE9oQfongqhKUJ4iWk9g1rUHhEGRM4E9bhlXp+gyQebfuPF6YAW6bdt/hxA9DH
    I/YU0qmSgI+vA+BliIoB7ZOUZXiv6v6gwsKPDsOUKWHmRr1+DyQZIP7HIQPvlXNePdIG
    SB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882531;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Wmh3lpLGPR2sH9dc8PaQB2Th95nhTRNorN/O9hCys+Q=;
    b=INDfieQOcpiFhyNsz1xQjWnksXjVCeZVmUNfpvrKSvmuilvto0yU+MVNVYK/1eytJC
    Lsmk51VV5UOVhiVxsXakUNkvt6uFwqZT4kMcFbhNyTTXunEHDSK0+pC8S8Y0gLgJLusv
    GK1ulv/QctCv3Qi6NoqhdQTeUnCsam632cgRpica70j2C/4shTPHazFKVfrOszjYnyvb
    3eYuubHexnetie2dgawyALLFfekFD54i3bzWUhumOXRwPIZN+vgzFaOGBNdtZ+4mGhrq
    +mTh3fPErjB6u5zXXS8SjlZ5rE6V4jXt4Q7c07NNOTC7tsnlzsnkCRldzD3V/H+01X0L
    nXPg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882531;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Wmh3lpLGPR2sH9dc8PaQB2Th95nhTRNorN/O9hCys+Q=;
    b=Bohm3U4XPCV87R25jqznFBXt1xvFVwarCAJlJVAifJIzymXPSyPCpFiPc6cwy7rCqp
    sw0An+LGbpsrn+TOZ7iiJ6g0dQW9AYMyiVYq1DI3DLomoItQLSDoPoZVCmrmswF2HG9D
    J8C/PS1NemezSjYq9RMEvM3YYB2nQa01n1xUlq5TPv6lNwwdXnS0qnSv7SnSDCihkpcp
    Yg9L5COG7BXhf0d3STYoHEKuvujjEcr3i/FL1aeTw5bHJPRaoVReRYog7hnY3j2R0aNl
    4sPpImLtX4r/fNPtg6zVy5MeJzwNsbAVBX8VNeeZ2xrLcu7hNn2aWSZhtHPCifWlpmWL
    N8tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882531;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Wmh3lpLGPR2sH9dc8PaQB2Th95nhTRNorN/O9hCys+Q=;
    b=6XDlUngqVVLIbMawELGORD3hed99Fs4vUHUD0ysD8M88uOs+hN6sU/KJlURvfvZxFl
    LXPgpG6/OSZLmqr8X0CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8gBrXO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:42:11 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
Date: Fri, 24 Jul 2026 10:42:00 +0200
Message-ID: <20260724084204.13169-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072028-crewman-plant-5456@gregkh>
References: <2026072028-crewman-plant-5456@gregkh>
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
index 0f435d6..0283c8f 100644
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
@@ -1500,6 +1515,14 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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

