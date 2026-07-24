Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E378C427FAB
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888527; cv=pass; b=lZS2koheZXsxXRWuHwHGA7NckqmEUnrE+rdpxbtVFs19izqvx4F94oCEnz5+Ld7L2p33t4EOWURnjlmF49nozceH9z2ab5MXcMpnrEgJgXO6j+8OhA3FyV4OWG8dnxnTXn8fWXWAazzmLppazVIljm8ZiHZ7NQq1X4kATyOMC3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888527; c=relaxed/simple;
	bh=6zPjHnU1UUq0JI4Y13E3M7wR+dvHB/hQ828pHiTCu5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeWqZE7M+jQpz5WBUdnuOdfo18irQWwghQiHKGUjIdEw9k1eXAX9MmCpAiDGVXGrUYZxV1Ox/lxL45bWVJavnLD5cZfAaQkNKW6JkICqjjrYLIpv6iuvh/Ab2Eb91H2RPtBEClozoCo/oQFYx2N2omLgsRWHvfQOZBnIWAVE1CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=llOXl7Zs; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mHKcBy9l; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="llOXl7Zs";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mHKcBy9l"
ARC-Seal: i=1; a=rsa-sha256; t=1784888521; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OqTYZGIY3HGBf8eHSYyNLpl9ZkR+uV4ng56hxkDmUB/bLIE1izFPzj+BhxqB4GKekN
    JCsY3nJVa1U0qpYv+BU16gll52zgDOLatu3wtJBMQATUd6Iv74Nxt/xcI3+pZytg87vm
    wifjgshsRnQYvGvQe41kxiJ8yOIllDnJ9zCU+d4cfekHcVBzEMXORWqHoZJzwDnCbzd3
    mS/SM/KSFTyyLejnFwSYJjfOi7QeHtd9bYWy2vo20NCuT/C5SbY4ngK7NJGHgrS9cG0b
    9VCrkbxt7TcyrNyoBDMdlb5J7pmi0PVWZxiQEpimEgip2eXtLW6Ep0WxAgn5rtXB3eGd
    XhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888521;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dR8Xy6bbu19HXLHVOsSaC8p+SD/nMuwPiuRMGCN9AFo=;
    b=OSuVrVrasZPA/FEe0xotRR171KKVIg9AgxFEFanIcjWUFp+EZEYqCrcQU2bOibEhLF
    s8/n2xu6RfbyANIheZOhSCpSYN6f+UkYj3SE32uqrcyuCjMxb4gBF4RlWiMrATxOZn+c
    2Hb0r4C1HPggMxWIxGB0gV6YM6IHXPdK509ak0vTlaMNYsyebDO4t/SeIPponCOJwBDI
    LaHrhpLOjWqSnXZqcYlZYaaMiLGHy1sirqT+RW1X7gtA8PKBN+rAtN55jTrJrAGO2aor
    jyKqn8pRMC6Jxx4JHic4B6rMNAHFoX3d+iTDg3q23+JP0CSLJJdMhZ/xaZ3DTXbvQGsV
    2PCQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888521;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dR8Xy6bbu19HXLHVOsSaC8p+SD/nMuwPiuRMGCN9AFo=;
    b=llOXl7ZsXaRV4HvXQI9oFUBBaCFQT/+lU1yUvz1S/juyQ5wbp9oo5r74IXiAE0cMjb
    NFw8JT910GycBRD0i+hpXMNbQ3uX87a3fDH5Z9D14pIJ7GIpaPfgSxuJUu4ZWyKBjE8z
    fWUFP7LzKkK/2t7NGyYieFOCMXr6GaI+mnWw+70Ryhwq/RtHmJkDgzWJanqy6SzfTk9v
    mvTHx91dU3YeXB4JupdJALkFUtBJdHPG6/QCEC23g9sJ+gj1DM5cZ7EZmCEbqBBb8EsJ
    qG03MMuXypCoxx7JpwhzG3UNN11fjr+oZontsUJrAY7RFozOfwKkqGgyMZ/Z96z/aWTU
    6nOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888521;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dR8Xy6bbu19HXLHVOsSaC8p+SD/nMuwPiuRMGCN9AFo=;
    b=mHKcBy9l65keoYU9a+fAPhU4nuSaSCQFx3Hi8d49Qgx5U553q4kpejwA41MpDO/OpI
    5Y3H1EPAT9aJrAlw5sAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAM0tHi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:22:00 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15.y 8/9] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
Date: Fri, 24 Jul 2026 12:21:48 +0200
Message-ID: <20260724102149.16440-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102149.16440-1-socketcan@hartkopp.net>
References: <2026072036-giving-knee-3a33@gregkh>
 <20260724102149.16440-1-socketcan@hartkopp.net>
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
index 4afc2ed..0db9c48 100644
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

