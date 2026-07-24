Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98993B47C4
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882536; cv=pass; b=WaPdQBdC2l1PdfgYuRpCzHtSY45ps1PssDC7bQrz73/6m/GookhTHzjVHYKZYmNVkHor/YpSg8LO/cD4iI7wqlYClR32e3srK+R3mQbQgM4rcOxDnsk+4L2881dmcpakIeamRLgPW0/d/N6qSr6SiAJJH7McXvJzCQe2ZG7JZAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882536; c=relaxed/simple;
	bh=tU9nblBLiWp4a4fUHrwG/eL00I7iHhdxjnDMKcbCRSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nn5o6yc4Q/8ppHR8jfFn3Zj7Q8lyspW86wCkmhlv0QpoDPRjyN7Vr0qOB/UwvyiWPdS7+u68eDZolT1j012l9g2CNAD+goXtH2U9xl8jK45Xh077Fx1DpyH/9vyZiDq0VwHsz0RnqQYtZLl/fZA20rvk+cmqSOoiPv4SoXI4ycM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LWXvcvry; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Mb50E8hw; arc=pass smtp.client-ip=85.215.255.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LWXvcvry";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Mb50E8hw"
ARC-Seal: i=1; a=rsa-sha256; t=1784882532; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sKF0sczJ3kO7asNbGfBe3We7Zq9dc+hm9JpWDIY2cyRae6v95JWvPxLx20BN34nPf1
    SafF6kh1tMT0WCmTe1nP52QA9uHM+0iOj99ziDpuO0/m6Og9zlgVcbzspvcvPg2PxKOu
    wV3GX3AQBklbVPxU1H+rivpru1YX259ApVGAJO6p0wJbKCh9uZtN/b3yykf51dAAt+gr
    wzLu4oMsI5cWxYJjuVxrTNCg6oj33XlV09garrGaz9YQx/edZOCRD6R1zCMP9uQVJ5Jr
    VAc62IgoY/jPBu59wkM1V78lLQ+hwdnwN2VT5n34sxo9MCiR3W1UJ/L0weWvFEKtc+HP
    KZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882532;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LqQ2l5m4ljyZzKRp8fWx5v7GTgHFMlhw6oqdDgunM+4=;
    b=cRObjZcdWaXcJ8+UnE7RszAQ4mEyluhOT2ln0iLTx68LNnkbYSB2ig8rYyqtzJr2IH
    stWRNAFUStMMR4IwaXuVHy9xsTEircU9+NrV5zaowPq2YclQxOawmlkh088csgOjTOvJ
    fHycj/OfoI6O/ICwyprkS8NADBQ9CpAYz/RgkEjR2XdDfMuO/Z1RvWi+zP5S9g8x2ssH
    33YsOVI+Gs5zKnJdfmmOwn3kJg2R7GoRdoTl2nGfN0JMmHBWnkPWd7xhLAhW3CWO4YcT
    uvxiaPiX70Z0pR/NtmVi0VK/gB9pZUgDfD9epIE7+FRStOfXx49cAwWUho/LccaplNzH
    m0dg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882532;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LqQ2l5m4ljyZzKRp8fWx5v7GTgHFMlhw6oqdDgunM+4=;
    b=LWXvcvryp2bGTXxQ325QkP+T7VelJ5pufZizm6hXnEKhARhxVIllnnwFlj5kwYSa9d
    zsa0PyagBr2Z1kqskxBVpyWtQJMAld7j9oc24YfeQbIfz3cit1rA4zge7wqL+AmnZW5g
    TIIzGvE0A6puKi+W4X+pUjhK0GAl0k23ru8HLQzQUsl6Tl9IWAJOAlzJgkHoE0uGzlI2
    JS/A6FMy6slVeK+Zj90Vpp/z/4W53to2+g6S4WmT8tdWk2OKN2VO++a+0iN4e6g+LEHE
    2ioqRdtA54iluSNaRQqKBU5j/0vX68Kp+Ohi4GOCfnbrtYxwRCyYkmRcuVZ+CCR6XWcj
    sC6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882532;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LqQ2l5m4ljyZzKRp8fWx5v7GTgHFMlhw6oqdDgunM+4=;
    b=Mb50E8hwpJ9wZa7XYDV88f/b2cQSUzRi+Z+zqFGLRODWyP3HqluRyr3FmxKCHSaZ3F
    ZRazTTIzEFf9JdAopMBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8gCrXS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:42:12 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
Date: Fri, 24 Jul 2026 10:42:03 +0200
Message-ID: <20260724084204.13169-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072056-posing-gown-1aaf@gregkh>
References: <2026072056-posing-gown-1aaf@gregkh>
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

