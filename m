Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C613B420494
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888624; cv=pass; b=eU5qD0NHfujYjuynkR9BV4A+fA+l356F0e/U67g8iSM2c/8b5unB3Y/gpzsFnAFTyXmMJi7da72Sal7CmVHypY7VudWYbzoNBzzGIeAc5Yo2PSfHs4B5ClRw/7kgGrLuvqNc13Bb3Jxfcg1pQy/wEFhvlDYSgIKusJXtdQEYXQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888624; c=relaxed/simple;
	bh=0cQYzkgynnFeIYAYReZFVrdwL9pxJkSPg2ShEGjXWFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6D1/tRuKwHLenCHwd/kHEqCtOvXuPQMGmYau8DcieyBxc22sULXu//CL9WhGbbmorlViQiGwmFvei8X2Zs1VQQSUn6D/av9SUkx4MubpiZ9g5rawvojJy6S4SFRLr8e2w/v6xFslPzwwdRl4eAer2zca6CEHHfxk17pA/7ICpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jqp738mN; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=zMV1kofc; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jqp738mN";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="zMV1kofc"
ARC-Seal: i=1; a=rsa-sha256; t=1784888617; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Hp51BIVvpsb1RWA18dDFOKBFtkxDMeIAqFgAOx0MDHUAgZ7R6Tg07BZyWuDS65ZPjB
    Ze9+36Ofj0SPqA8H2V8T5AAa96O2Rab6aiWpduW2h1ZTomvFk3WRvJASsaJCQf0n0ka7
    YdIkavK9gYlKHCExruXm1/TeHYYhQXfQ1gOw4/yuvJXCxtuI1VuLn44iDUBeyGf7XKVa
    xt1Rx5RUO2zUoQtAC6VkjVVGW8WMK2ZrzYH27MftGLcep85aF95C+eoh777zwlQgXlNj
    E99tPD+YaGqheKhL7t/AwJ0h0FMwL8qS5Jdn7JLs5euEDz0N1/Qfhoz7FoBUpDwJwFFY
    MZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888617;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tuxG3K5YeAaRFnAAceXbJHOBUpw9KHWRLs03o1L98zk=;
    b=Ht61sHlaMBNHippL3Prjit7aFyE7tL0ZIne+/pt5sVc9nMYAY3WPnilKv7IDvyNX/m
    ID6ZduivDCb7SmylS7rpEYU08fwrvVNPsgER92HkZnyw64bqHrppmOFZFy/Ln49OoiNJ
    uiX0G1rqQpMpS+TXJ1Q7CF6CHDMY4aAe8oVgC+um2kPUEx5wiRcRzF7H3t74RIZT3opq
    6TrqS8Sd6+2KmqEFnaN+dcXJN2AeThOHa5AY6FUvb3VbpdhzRUIYBC+10z0Z9IN95yfA
    qJD5Rqu3wi0IAj/g+1I3PFyvRh8qSvuudXUdjbFcFzgh6kJRpvH8PE4Svmm1G2sZbm2q
    K1jQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888617;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tuxG3K5YeAaRFnAAceXbJHOBUpw9KHWRLs03o1L98zk=;
    b=jqp738mN+2J+DkH4mquAGP8JSxsfpfT9P/XyqJ/cTiumVIct11GrL/9o2Z/7tFPAxO
    MXSBC9srbKBbTjOWfHmJ6GGaKpQja8jRkFKlE6i37Wo9tlPE4f67iSNjuSl1trQqYCkT
    UqaKwoS5ESI+kIS1xFCnVM38XuocYQ7xP5174TKg+Z2jZDa7LIAIkE0St2+rlndQntji
    1QPgQBb9W+bLAO6MCkNPKQSyEDY4tgDSa+00ipatMFr93jYM3htiaLe0WK8PlNiHNJ13
    1gx6pv4c3yoO/TMw1I91e62QK/LiKw5gyQBZda1Cum5Mn9rpv0BIe6FkVAe1+Z5dA46R
    2Sxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888617;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tuxG3K5YeAaRFnAAceXbJHOBUpw9KHWRLs03o1L98zk=;
    b=zMV1kofcvdYpfouz7UA2jgfWdLUjgfsYb8voINONaNvrMICp1b5ZO0dbPNIJTyDBk6
    c45/86+D/oQz4xkURWAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OANatIK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:23:36 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1.y 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
Date: Fri, 24 Jul 2026 12:23:28 +0200
Message-ID: <20260724102329.16572-7-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102329.16572-1-socketcan@hartkopp.net>
References: <2026072012-repair-flip-109e@gregkh>
 <20260724102329.16572-1-socketcan@hartkopp.net>
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
index c24fbbf..42440e3 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -761,11 +761,6 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
-	/* save rx timestamp */
-	op->rx_stamp = skb->tstamp;
-	/* save originator for recvfrom() */
-	op->rx_ifindex = skb->dev->ifindex;
-
 	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
 	spin_lock_bh(&op->bcm_rx_update_lock);
 
@@ -789,6 +784,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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

