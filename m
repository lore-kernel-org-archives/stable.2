Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08BC41E6A9
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888052; cv=pass; b=c4fiy2cA80PrvZ9RpdHwIYiPXZKLLBReb18q5SDBRnBquT+bYzNQnlKu6GLrRMJ9Ooi1zXu1Fw/G7ubRGK5ZRvV90C4CxeHHlkxLHEQ8MwsK5/tblB71UAN7sSY8AY/9UU7iHjNMHCoBeJr/xZoistABmX5UUFzbwOHrYCQ7bxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888052; c=relaxed/simple;
	bh=v2jp7AXtDa6VU1cP9KrBfSscEB1UfiwBQh9OUbehQkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sb7fkaU66oRIiwH0Rkxd5pP8FKiqEsxSpZ+S7WMT4l360WNyjSHcs6gGrv7z95K8jx94rZA5dS6fyM1AHElRg7jEZPPKdaPdmdpfSQQnpfbiadXc4prXH+AMXi3hv/hSPZAChvFY72bwh/2w1AdkSxPLQRm5aNJnu8oyRJaAx1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nnjU/c+0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=0iBbmMTf; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nnjU/c+0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="0iBbmMTf"
ARC-Seal: i=1; a=rsa-sha256; t=1784888046; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lbiysIeGLDadY10nR2YIBFiFbh1RBqzFDoRLXNSsg65XUY3Wc2+J5J6BBChhsHY1Mk
    0/IoxdnJ1dHhyARK8VzPwfsaJYdNk6xuyuBs1m7PQH3Dve6CkINLnEFiJZM4yNCKQs/k
    2hwxhk9QIgg4eM6rl/ELivv1ehDkaffrqCVc7kwOxqgu/L00wp9gM7OTUiZQKEGT8E90
    3mRFDYbsw5JjvKwCD/R7wfvqHbYHkAC8Z2szHZiRD8em4s0PVOjM8wvOq9rQZD8hkMkS
    XO1e+hP9uLI3DDAJm6olFWqPtLNOSrgmGPAqqs1UejcAurmZw86DEdqtn4MLT8875nQQ
    92Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888046;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eiL/Og5AVfnNdySZXC53uQLfrHKrauHVEQve/4SaWAY=;
    b=opRxN158jtdZoJ9RR8pZmR6DGtNR2+FO+ZkzYNZD5YVDImvQs0VXQdrIho5cLvnyoP
    oK1wTSGaCYKBux4g+CUjb5PCvhE3FaxLZZRBrj0CaBlIM4g4Pn1nZb8nV3h7DVorfJ3m
    bOcrSlS6hKeX8CLrpQTvly2TM4Zg/CyAS/Cy2bD0Fs8KlyPfRiM3cXaJqMADYJEW+WP5
    vCdZXz2MdzR2O0KVB2fh5Svm3rxiwmyNF1hFovrcInyR0uIn1mXq9xiapZttyiCQrxeE
    uXL0mOyim32Uo6i8JsVdD0iATV/2k+DXBhkpynHMV04io0I3UexVuAPhPpU7ZZaN/JMy
    laDQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888046;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eiL/Og5AVfnNdySZXC53uQLfrHKrauHVEQve/4SaWAY=;
    b=nnjU/c+0tHSY/pFhjA6GD8pRzbabTYqv2EYNWqer7J85FjvppeFeSU4PbDdz3dq5eL
    yhQqIhMQranVHzcQwhAKSFyt0G2KBN1eqfrCZqC+nQ6np7YUzOU23j2FUOkQknpjs0Pg
    TsI+mduDjnd7i+C+EQbu6exgwPJUIT6OPaw1T3D4j8hkRadtREgvphUPfMBOeejcrgA6
    IvlPaULUVXBL+y+pP3CP2zuD17pcVxZY4BycCJVqTwnbquePevr+u/1hzxJ21sGXbk1B
    sf415gmDOV43QQLTHEXyG8HLTk8YcQqbg3tkeJlOr4U0nUFTyKRy9UNqiy/lLP3JAEXU
    QgaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888046;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eiL/Og5AVfnNdySZXC53uQLfrHKrauHVEQve/4SaWAY=;
    b=0iBbmMTff/kWRABUIauB8pgR2Ep/VrvqqGc1Ekhhpq8pucMo4LwXxxn4h7gkbLZYeu
    C9Ibp+V06ggmYLwK7gBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAE6tFI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:14:06 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10.y 8/9] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
Date: Fri, 24 Jul 2026 12:13:41 +0200
Message-ID: <20260724101342.16000-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724101342.16000-1-socketcan@hartkopp.net>
References: <2026072037-bagginess-bluish-c081@gregkh>
 <20260724101342.16000-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit 58fd6cbc8541216af1d7ed272ea7ac2b66d50fd8 upstream.

For an rx op subscribed on all interfaces (ifindex == 0), the same op
is registered once in the shared per-netns wildcard filter list, so
bcm_rx_handler() can run concurrently on different CPUs for frames
arriving on different net devices.

op->rx_stamp and op->rx_ifindex were written before bcm_rx_update_lock was
taken, allowing concurrent writers to race each other - including a torn
store of the 64-bit rx_stamp on 32-bit platforms.

Beyond a torn store bcm_send_to_user() must report the timestamp/ifindex
of the very same frame whose content it is delivering. So the assignment
is placed in the same unbroken bcm_rx_update_lock section as the content
comparison.

As a side effect, the RTR-request frame feature (which never reach
bcm_send_to_user()) no longer updates rx_stamp/rx_ifindex, since only
the notification path needs them.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-10-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index c28256c..95eb791 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -756,11 +756,6 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
-	/* save rx timestamp */
-	op->rx_stamp = skb->tstamp;
-	/* save originator for recvfrom() */
-	op->rx_ifindex = skb->dev->ifindex;
-
 	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
 	spin_lock_bh(&op->bcm_rx_update_lock);
 
@@ -784,6 +779,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	 */
 	bcm_update_rx_stats(op);
 
+	/* save rx timestamp and originator for recvfrom() under lock.
+	 * For an op subscribed on all interfaces (ifindex == 0)
+	 * bcm_rx_handler() can run concurrently on different CPUs so
+	 * the CAN content and the meta data must be bundled correctly.
+	 */
+	op->rx_stamp = skb->tstamp;
+	op->rx_ifindex = skb->dev->ifindex;
+
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
 		bcm_rx_update_and_send(op, op->last_frames, rxframe);
-- 
2.43.0

