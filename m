Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795510694;
	b=NRhXQ1tnM1WLSAHBwj1ZpbkpaEoI9Z5UZdeh52QjK/rtKbv6CkFtkhknjOUkaW0x1W9A
	 TOmrO6wKGMSgqZIeEJUT4AizqWq9BvApi1pojCVTCfd8ShWOqEtM8jcoN3pbOkPQ5nDoN
	 SAndqIeCYz8niHa3xseWVgVSbio4QvAk6axFQaKzS0G2XGw68lGMDNmZGdyPDKqpk36UP
	 8CLv0om/KvY7Cjsn6jp0GVHFSE/tVz8V2k0ZsgejA4MzIfXuKAySSWAkf/IKsNmYAPWJ0
	 sUlNSAR3kBOxUnRYfmyfUjuqPhqpYizUfcCNgcVAeDopZviAwy2M67GO9eUypGQT3Fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510694;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tzEQeW/wuuJvqekiey+fKvjmkJWG3WIcbMSJ7WBzTE0=;
	b=i1zk3azkgiTVxSr9CIcxe5KrbEeQIrrdyazuY5ILswoKGpkQxFl78qk4wWYrbHD1ArUm
	 cxwU2/wQYnqDC4EH7PqtVtJS9tSErSanc8rk5UcFGgnocqnn3DzPdVsb05bOkYZE7RIkY
	 s4SMwtaBZUZBlQPyMkvVQRB4+2tOQG694E2840AA0SSznb2GF7lWc/beBd20t6vL5L5BY
	 NiPssly5dWp5Bg0jI6CwZ9neIwDKm/GuqJNvJa4rFwbXnJLbtKutKxZxyWS73BEUNr74X
	 1l6CNPi1BymZqB+pWASP2uKLV3CoFhspTzlsoL0SiX6pvTSt7/eMSdgCA9yQKWap9Uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Fi5o5H7r;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7530606A6AB;
	Tue, 24 Nov 2026 08:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7530606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Fi5o5H7r
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2D845205A23;
	Tue, 24 Nov 2026 09:58:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzEQeW/wuuJvqekiey+fKvjmkJWG3WIcbMSJ7WBzTE0=;
	b=Fi5o5H7rFhHZw9eMbm9eBG0DvzGD20YtbyRvEABgKYPa6Cg+lvyEhQf+s25fFNWapowFGf
	4r8TwZBiMagGijP+f+UUcR3vfDLr8FXMPpB33uyn5LdOFbE4N0CKu9o/u/qcRMCJHKv9p0
	AOFt8vOGi/fVnh0/PmMh2T2j/TgdYDWNQayxi2kRTUgOEqHgpiek1yroLPFwk+7swulFjK
	P4RgVx8dMHZMxW2P3TS3D4Qi5Q1eRhfN9yF1T61OZ+I1wq4Lh4SNjLR+Kjo9/snQv2NvQF
	BVoUVk2kZ57MBuIpaQMTWvWEMpK0bnBDcIPNiv7RSqF5JSXXix6depfPynrZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzEQeW/wuuJvqekiey+fKvjmkJWG3WIcbMSJ7WBzTE0=;
	b=MbQoVxnZmgSdZkGeUt5KsPx3PBqr73kQRkYlEd/IYz9zTV5cQsY6j8A3TVgNQNVfRlz9hk
	FAg9g1eVHJc2AspyP8EV5NcpcOByxp5A8msb9CPlv5u0uTaGk7g0k3+j0oIKXGpAddXRdM
	jMm5HEKOzBUjC7M9gdTy6GDCIVX325zGbuap9aPK5wv1pZgrEeB3AIjEyUI+k/bCp2cHmK
	DDXHw+Gp0WIm8atZ/WV8RaZbuRNHQt21B9e48ZDJpgZ0QmA9/zIR62y4DYkMeH6gE5AWe/
	NzhgLU22q9Uu9mIeP3mTX+AFSxqoCJGd+OKeTS+vIW8ifP7BqaHps1vDtDNvow==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510686; a=rsa-sha256;
	cv=none;
	b=GJQX46WAKErDyatg8cpkjY+ngh791NnAWdUW3Zz+h/PvUtq29GKRQAwpJTO3oXPYSZvTI/
	2+RlPLve0nq/0ypbQoiLtvwlE1y2Fv+vjaewXT0D7xdMIS56IOqTmc+tglVMSzLJ1WbvrS
	rB6IZoaJLQoh8sfOfrpnAqfYAMV16agpsgJPoyDWz6QUGpqC5X5TBlqpKtjwHJJ0qXH41R
	S8nf5JKwnPwfVyMBJalIeIDNomP7xV0kgnjn3Z5M7net6uSWrGuOS9r3sTico6D+ausUJ+
	1JxLrWponpZ9CLn+p6l2wX9OBMkyGYpEfBPZg+nxdA/RVSRevdYFUgqMJMrJ1Q==
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 06/12] can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state
Date: Tue, 24 Nov 2026 09:51:33 +0100
Message-ID: <20261124085757.1093632-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124085757.1093632-1-mkl@pengutronix.de>
References: <20261124085757.1093632-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Hartkopp <socketcan@hartkopp.net>

The rx timeout is only started at the end of isotp_send_fc() and for
consecutive frames inside a block in isotp_rcv_cf(). So so->rx.state
can stay in ISOTP_WAIT_DATA without a running rx timeout:

- isotp_send_fc() returns early, when it can not allocate the skb or
  does not find the CAN device anymore
- isotp_rcv_ff() does not send a flow control frame in listen mode
- isotp_rcv_cf() has stopped the rx timeout and does not restart it at
  the end of a block, when the flow control frame is not sent
- isotp_rcv_cf() has stopped the rx timeout before it drops a
  consecutive frame with an invalid length (reported by Sashiko)

On a bound socket the next first frame or single frame resets the
state. But when the CAN device has been removed, no further CAN frame
is received and so->rx.state remains in ISOTP_WAIT_DATA. isotp_bind()
then rejects a new binding with -EAGAIN until the socket is closed.

Start the rx timeout in isotp_rcv_ff() and isotp_rcv_cf() whenever the
reception continues in ISOTP_WAIT_DATA state, before a flow control
frame is sent. isotp_send_fc() restarts the rx timeout as before. All
this runs under so->rx_lock, so the order of the rx timeout start and
the transmission of the flow control frame does not matter.

In listen mode a first frame that is not followed by consecutive
frames now leads to ETIMEDOUT, like a missing consecutive frame inside
a block already does. So a listening socket reports a missing
consecutive frame consistently, independent of its position in the
PDU.

Check the length of a consecutive frame first in isotp_rcv_cf(), so
that an invalid frame is dropped without stopping the rx timeout. An
invalid frame also no longer updates the timestamp for
CAN_ISOTP_FORCE_RXSTMIN.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-can/179504035916.3136.12986898667697830880@kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261120-can-bcmlock-memcg-v7-6-f6b84f5257b1@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 8229b6a69ecd..0b7db1ead7a9 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -634,6 +634,10 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	so->rx.sn = 1;
 	WRITE_ONCE(so->rx.state, ISOTP_WAIT_DATA);
 
+	/* start rx timeout, isotp_send_fc() restarts it */
+	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
+
 	/* no creation of flow control frames */
 	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
 		return 0;
@@ -650,6 +654,17 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	struct sk_buff *nskb;
 	int i;
 
+	/* CFs are never longer than the FF */
+	if (cf->len > so->rx.ll_dl)
+		return 1;
+
+	/* CFs have usually the LL_DL length */
+	if (cf->len < so->rx.ll_dl) {
+		/* this is only allowed for the last CF */
+		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
+			return 1;
+	}
+
 	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
 		return 0;
 
@@ -662,6 +677,7 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 		so->lastrxcf_tstamp = skb->tstamp;
 	}
 
+	/* stop the rx timeout only for valid CFs (checked above) */
 	hrtimer_cancel(&so->rxtimer);
 
 	/* isotp_rx_timer_handler() may have raced us for so->rx.state
@@ -670,17 +686,6 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
 		return 1;
 
-	/* CFs are never longer than the FF */
-	if (cf->len > so->rx.ll_dl)
-		return 1;
-
-	/* CFs have usually the LL_DL length */
-	if (cf->len < so->rx.ll_dl) {
-		/* this is only allowed for the last CF */
-		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
-			return 1;
-	}
-
 	if ((cf->data[ae] & 0x0F) != so->rx.sn) {
 		/* wrong sn detected - report 'illegal byte sequence' */
 		sk->sk_err = EILSEQ;
@@ -726,13 +731,13 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 		return 0;
 	}
 
+	/* start rx timeout, isotp_send_fc() restarts it */
+	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
+
 	/* perform blocksize handling, if enabled */
-	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
-		/* start rx timeout watchdog */
-		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
-			      HRTIMER_MODE_REL_SOFT);
+	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs)
 		return 0;
-	}
 
 	/* no creation of flow control frames */
 	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
-- 
2.53.0

