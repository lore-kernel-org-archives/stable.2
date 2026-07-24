Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6453F4DF3
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888775; cv=pass; b=V+9i0BB32F1n+gS6zDJ04SDKU21GPq7qBU6jiT8aDj8h284udB6OoRxBpYk/gzL5qItoLi9zQMka3N5H3cf4p7Sixoh0h+i7t6RQhHi+g+lrzRJQ+vo/eCZLhanb0omczIICsZiz4RVGw/n+0tDqUmcwyKU+5G3/F/Ze8Lod9yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888775; c=relaxed/simple;
	bh=NhvkOuLb/yVnd2UBn99m8hb1o5hI4L0utC8GtjiKWkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nq5yqSpYiUI6UcKhIDEzrBGKGi/FMMiTcmjw59DEVlyjgjICv/AOGV6C4jOYQ/qAO4cx+n8ZN+c4pu9dkaP5t5ThyfdXn6SNpDa7/5smLxpT4f2/yEb0DHJYIiC+IbXC8IF1E2SBOPkzddkDPegL6aJcIcyh1e3iQ4Ihklt7YsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=a742tfrZ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jIqF8qqM; arc=pass smtp.client-ip=81.169.146.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="a742tfrZ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jIqF8qqM"
ARC-Seal: i=1; a=rsa-sha256; t=1784888767; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dcXyheqxrgr13xM6CTxv6Y/YUQgR4kpgZujE0RHcnXklS2sTYat439VcmjxQx97gbT
    TgUeWA9V76inV02gU2bTWi66RqeQwnQxuTcePdNBzR8yZ1pX0kb4uFEDEV2YdVicj0Fe
    8kFXCHJ8MEojUz70KpzLaMJ29zNLuugCJtLaTiAEb8yNsqAV6j7OilQ5Ilqy6q5dS/FS
    PYtOsu7+WD+HENsMM+voyjBT4iNbZDa5fENwpDf+ZBRytLxocA8O5N3C2eJxJWtKQwhH
    gHsR/SA7IHbpLG+E680BGxfgazMTB9YTXTJrjLx9387YVpsT7f1dzbDmuVHj+zl7WmaY
    9MFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888767;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Wmh3lpLGPR2sH9dc8PaQB2Th95nhTRNorN/O9hCys+Q=;
    b=F59zDwrow9KOaItrufE9U1QjxAbrVgnuTRsCFGk6hfwKYqpQlRjXw6sgj2K+41b+PE
    CslP7XGeATObzZfA4zAjsGZ2wsdvTJNL1wsydKbJeJbFK0GKI0HnkdH4nnGpa6MPQpIj
    wqPWBZHnWdDItq61pyGl4xVhlh5VDsCvGzDOb8kM4MnuHBbSXtnXyC4Eq7pGzXxjM3xJ
    B5wSop0UGuxq5CJzgQ1tgobQYM8XKkv+66fF/JEngPYmOdMLvIDYnzml6sM1ektQn5kz
    UW9qQ1RzTXZmGOo6nMn733T9b01Nz3XUR9A8IGkdtF4Q3yAZzImX1GbIzALFyaKRl8s9
    EQXg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888767;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Wmh3lpLGPR2sH9dc8PaQB2Th95nhTRNorN/O9hCys+Q=;
    b=a742tfrZcYTCKw9Z1lF241NspwS3Au2JxuIGeJ5A5FQrt8XOTgyijIHxathUu22z5+
    bFSYJLQ+EIR5JiZCqPUNrv04tSVW6p6zbLDcFwZchQ2LGL0/0eavgJbTo4Gr70gHIS12
    r+MKsZv999Vwpl05C8W7vzFzeBQNw1Ntlu7gyxlmVrZWPW2xurMf53D9x4rA2FoapL8h
    3ZSkcx5BkcnemTopxmtYB0wyl7Lp8bo1PfMeyOcpIMRS1tmbiPVUzPYeltDa0we6wH1m
    +jzrcUPOGFfTBUVAurk891Az56gX6JyKrUTeI2E9/KhBGPCpI3U8+c9tztWq+CIDzBOd
    4zwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888767;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Wmh3lpLGPR2sH9dc8PaQB2Th95nhTRNorN/O9hCys+Q=;
    b=jIqF8qqMTPriTkFsCJ7vq0DbtVuOQ1iBh0OMYKwOmWFv6csdIZZdXyZ7krvleM7AnD
    +gnj6lfKLTBaEihYpiBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAQ6tJM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:26:06 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.18.y 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
Date: Fri, 24 Jul 2026 12:25:54 +0200
Message-ID: <20260724102558.17056-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102558.17056-1-socketcan@hartkopp.net>
References: <2026072010-winner-hurried-07df@gregkh>
 <20260724102558.17056-1-socketcan@hartkopp.net>
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

