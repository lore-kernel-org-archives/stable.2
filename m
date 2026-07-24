Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A242376E
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888776; cv=pass; b=AjkXlwpDNc2st3heh6RzGuTej/6kDvXiPMIJUqnJAgvamdSg0UiMDyXS2GsffFeIKAG9BVOhV6vD++uQbOZbdkdTtYmNEQlJTAn/nk/MP6mG2XlgUKB9JsswYEgvzywOiwXXgmLLrRXquXNXPzYwLIRisqpbuxLEjEiJz0YR5rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888776; c=relaxed/simple;
	bh=tU9nblBLiWp4a4fUHrwG/eL00I7iHhdxjnDMKcbCRSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgcKrwkePppdwN9ibqieDf8ddd1nKVq7ibxYCaPZmKUEk0khrEMeu/iOiodzxonm/FNgKFFO0OYr3HpV70kTeeP08Mt1CULpKqp27uQgztKpIqjes4Yp/HiNZc+CquofskWER+wFUTnKqZ4UzHYN/DzquKSZCSZ9f7vHVsqbcoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=PAblAzgk; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NdokLzJK; arc=pass smtp.client-ip=81.169.146.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PAblAzgk";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NdokLzJK"
ARC-Seal: i=1; a=rsa-sha256; t=1784888767; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dFR9echb9VfAh/xdVWkCAZxbwYfcPqnHzcfQAMQle/Z9d4LbIFyPYCf/RL4fRQ/BRQ
    UpMtTlU7q4I5+FtwQn3+Q0wuXLwC2P+RFxEAJk+yV6Nw9B+wlTN8fN6lAMixlwjOnw8+
    TSWiktivDiPCho6k0gASBf8/bcMo8aws4jQ1zC9QcLdUiUe3chAgTfGcT8J0JMm+92Fl
    X1vdFIR4h145uFe+yvgS2BkUwpUppbYoWB3WGVrcczJ8/xqYRUHEsBd9mlY8GzvWxp9P
    eT4uUNfjX1RTSV6xf7Zz3ImMrSMWyJ/BzpFc3pZRawUK3LLWyeXjgfqlB+wwfonznyEi
    /k7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888767;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LqQ2l5m4ljyZzKRp8fWx5v7GTgHFMlhw6oqdDgunM+4=;
    b=sFCjrgMTzfFDNON0Zk117KpSUVS+XmkhusCfnsVBoElk7RU5vR+f4uwGDGrW3+a/Bu
    bg8a3AC8hN+lw82Fjp7Y3h8VNtMdBkT1xK7kbrUscBd2kp2S++ctMCUQ5DbqU3qmklB6
    Vfj1akSWmyBdYZOYzBeaahA/VT7/3DxtsZbQ9Ndvrti08Q2vyegIcGIRxbTP9omHHGWN
    x6pg+c5Lj21NMqGrg0TgpYK5DrQ6EA/H0dHr7KuId0ksm0wc84O0P4EM1tDrfEjg6ft6
    /lXFyP6g7f49dLRkJh7qAdSmEj/Yu00eFWKJ4+n9lK67RIlZbBopYmXuO7IsppaPlP+I
    IVAA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888767;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LqQ2l5m4ljyZzKRp8fWx5v7GTgHFMlhw6oqdDgunM+4=;
    b=PAblAzgkYCPS+PtPLMrX3PlAuAPO/pWDBBov2hhbgppzttPx4ayWwO5BQP494hXwfp
    D84srt1NnpVUB1imCz4MJyf0upVpItEocY3/WVLB6/JQhtae9NdXWEdSQLDea8UmLtzo
    DBS2rnR73m6OFjHTtLIS4m6e0NCGu7ENCjNQYh76s2Oy1h13cdIDod6Lha5bkG+8K35x
    A24p5XdR+Tcdi40nXDGXESIZVsOVJR+OCA0aNi9Y4Kh0WvNjhoWZDaZYB4z+43D/MAMj
    /cWg62rGecQCsAepGSCNhqqxBFXSmxH5WSJ8cFlyOAxKZYDWPah/Wb2gEUgR+3+hA83q
    x5/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888767;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LqQ2l5m4ljyZzKRp8fWx5v7GTgHFMlhw6oqdDgunM+4=;
    b=NdokLzJKMu5WEzLVRZT7Z2eLuHJpxdJAMzekLKM9m/WgLttutYoDe4wbtgrbiYmE/m
    gJ5mvA7cp7fGbbOiNxAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAQ7tJP
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:26:07 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.18.y 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
Date: Fri, 24 Jul 2026 12:25:57 +0200
Message-ID: <20260724102558.17056-7-socketcan@hartkopp.net>
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
index bb67e7b..ef9eafb 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -794,11 +794,6 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
-	/* save rx timestamp */
-	op->rx_stamp = skb->tstamp;
-	/* save originator for recvfrom() */
-	op->rx_ifindex = skb->dev->ifindex;
-
 	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
 	spin_lock_bh(&op->bcm_rx_update_lock);
 
@@ -830,6 +825,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 			traffic_flags |= RX_OWN;
 	}
 
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
 		bcm_rx_update_and_send(op, op->last_frames, rxframe,
-- 
2.43.0

