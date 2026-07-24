Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB33CB2F8
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882347; cv=pass; b=VDwMBduYWzRtkacWYf0Z9CrgoKMj07nBbC+BE1XLo6s/8NQwtWCgCLtuUuAYBznGx93boyYk0MjaTxXCO68JCcZG9JEmPcpnxS3o4nG32rG14NR4fm9I50GzPGp/Klgj+Tj3QhrG8BUF49waH9W/9JXXVAbnnBpRqe60rxKBA3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882347; c=relaxed/simple;
	bh=0cQYzkgynnFeIYAYReZFVrdwL9pxJkSPg2ShEGjXWFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWEai299M3Lj9o8F37zZrgZCSG77vBGB4h2BiQzuSG2NO5nmvMzpS7ExEM73ANPh/kr683eCh+/NAFWg8suWtRODIffBiTYV8dm9t4ll3t8Vq3JXMzI5nr9d9+ql0MQDBcwPuP01M3R+PjzYtMEZcK5F/qgTmz+NEW5WSnDGzm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KzkXcyKt; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6jMTVuKV; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KzkXcyKt";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6jMTVuKV"
ARC-Seal: i=1; a=rsa-sha256; t=1784882342; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jKed2w2FIamb59XOfy/onHdgXAfDhREYu1/tbGqBGf6WAlSJv4LnyHGHsslmp1VdKA
    Jl5k4I9NaC3Il4VGJ1sin4JBMNMoOfIFSuy83bcomBaYKY2GIsTpMle4DWH6UqNosm9X
    6gEIYPnrQrnsEL5Au8MyUmyhw6Wdqn/NwjkV+Mkh91RPeiQtnFEzyCh/JV1+ixh8qyP8
    /kStFsSYIP84idvXP2SGeV/BS8U9vu8I2dTYyW0HholpEEFQR6eNcxz1Dxm8Y5JGAisJ
    nA+JSznFTxsYjOzVmRAjuFw3NmEoIhuyOlivE9hpe6cjzPvGcXbT03CY8r525kf8C9sZ
    dZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882342;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tuxG3K5YeAaRFnAAceXbJHOBUpw9KHWRLs03o1L98zk=;
    b=FJXEueSlUNPBJ9g8cZdyoJHv4kyqokOr7uCNpayBnzvrYVKUh+MU8Z0pG+lMFymIz7
    ZfbK4BrtZqu+avI5ltcapyiJSQdLThsSebFux1g6U2M+g2Xg7su+W9g/v2rm5g5vPcuq
    t0UMA+VIjAlNQxsy9Dgy844fooDslmX8YBtv0DFvKKtz0qetioToNvebk/vhdl5of2b7
    82Z/EDMbwL+Usuuw6F70Oht8jHIQe6Wac6JtFue0K3eUFtP2SAGUCeBjJ1pMk285/jcl
    axtMbXLDYyrEpZrnwD4aefwacR50NTR3eJwT5ntcEB2MXhpzzIQKFlXGV/NALJbosGBi
    lA4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882342;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tuxG3K5YeAaRFnAAceXbJHOBUpw9KHWRLs03o1L98zk=;
    b=KzkXcyKtvY0tlJH+cuDR/D3Y//PblQRPS5KvFTOBHUGdbooGGcrRR5LHgsouRpeSnp
    5Cg0j88XZtk7C3WOHR2Cjzi+vYDC3LuByLG2c6/c3xBhRWieXHPBf3vX9YNwJRGHhT5F
    ljxwkfIBgz1PQQzRXhKImAk6TE/x6+2eKqajbKpVlO6F/PWG5wQ75QL5eGdMUrd/CCS/
    aW9v7aHINvefE8r8Sq7IrjPykBMFkeYxbsvAtgJV6U80Cn2//P8sQ+QmtQft5RswMpx/
    /vzPmj3iMYhsC6h+HzaaxQFk1r/4og4fTXvrM5WN5ZbyafbW0K3xS/NzQ8mRhv5xYx0I
    fZdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882342;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tuxG3K5YeAaRFnAAceXbJHOBUpw9KHWRLs03o1L98zk=;
    b=6jMTVuKVJP0JfRLq9yfWKZusJ3gQxoNbJMfAk7OSCmD9UXszMBcvTcbuQgDl97vG+m
    d/NKvu680LD9DoJfv9CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8d2rT6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:39:02 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
Date: Fri, 24 Jul 2026 10:38:50 +0200
Message-ID: <20260724083851.12603-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072057-dwelling-ripping-7c3f@gregkh>
References: <2026072057-dwelling-ripping-7c3f@gregkh>
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

