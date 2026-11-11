Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419112;
	b=v/MBIfgi7S8Pal/n+H37GMiH3kVeJP+xFcfHjqvYUZLEC9GNn0ghmeR7PauMBitJzw/s
	 lQAnr8qz74QHym2ShhYHvuO6knKRqXHK3HAUNBy2HQDjAMlwYR/67iptSZxXw2NCDJrDa
	 s6upK9g1bK2LGdVoKUF0BoK3w5LH2sdrSFe+xgVedu7fy8hmw3WvviUXi/CupUs1RK1xx
	 22FGZTEJf4iuIZrqsVftuXxuJiQnGG686dbWGWvz8UehrOoKKQKFfhmmaylyNdwR1qgXU
	 xoRLiG6Tbcwejni7+fSjxyFLYcvYn1aGbXGdziQhs1e9/dvAoU5z3cKLBtcmJhuO77Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419112;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JCcZl0NKO4r6xS5iodOTiKldicOGYB07k7RVkaSj9Zg=;
	b=oE8a1n69QFRJ5br1qwoQODxkAsAZRv057KJHu98IQA9IJx5+TRf3Blc2/FQ7dSTw3s8l
	 x5o0j5sydxSmqDgGIkgSibxRv7Ax5Dg2d4RGYFrb8nibe3GG5MgrvYWE4FEWxnbpKRjJ1
	 08F/mW68U41Tt8SewbiBQ6rDF8KkTuZTcIXMWo3IIQSSbsQz8j5Fb54F79SgoaCgGbLku
	 YrMFxKYlDjmzMoB7jUK6U3sNIEp45IXjYlKH1kBiUrEwOyKpq+Sj9pa4Gq4jey1JJYcal
	 8R/TMZCTco7e3JqqisOdPxFHzH3VyAVICTSTFQT+TWnLFevewGFQXpFbGRPdW9DncKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=obDPY6bq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172B5606B4D4
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=obDPY6bq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6AD1F00A05;
	Wed, 11 Nov 2026 17:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419111;
	bh=JCcZl0NKO4r6xS5iodOTiKldicOGYB07k7RVkaSj9Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=obDPY6bq33zvVT2GPiLQ/4fnkJi36W4cgCVU9+yIItIBKyUsJSCRl6oqdGubW80EV
	 Bnm34AoIh5i9kaKaVrLS1pvUYeCb+hiV0enzG6hiJ5iCEfZqQCnX36BvGaJyb6BjWR
	 9xITDPuaX5119J889QpL+Mr43Usy1u3zIBnn13MuqdWH2p1mzjIYxI3f8MNGn5Mcoq
	 W9XvUVsnB69MY1zYd+GbE5HlRoDfZPXMKHDgtDg3avcJtPNbVP05MX853UkWpWjxZO
	 OtKQdSyaAeji5iFUSpO3Je0LSDUAVm7+DLlu1tl7mP/AiIIOffitwyFqhrYX/nriSO
	 wd7yRQm0/Tu2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ipmr: prevent info-leak in pmr_cache_report()
Date: Wed, 11 Nov 2026 12:45:08 -0500
Message-ID: <20261111174441.3663023-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053830-failed-6.6-94a6736bb5ab@kernel.org>
References: <20261107053830-failed-6.6-94a6736bb5ab@kernel.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 4f34002e2e37639133693c13a2a9977fab86880d ]

Yiming Qian reported:

<quote>
 ipmr_cache_report()` allocates a report skb with `alloc_skb(128,
 GFP_ATOMIC)` and appends a `struct igmphdr` using `skb_put()`. In the
 non-`IGMPMSG_WHOLEPKT` path it initializes only:

 - `igmp->type`
 - `igmp->code`

 but does not initialize:

 - `igmp->csum`
 - `igmp->group`

 Later, `igmpmsg_netlink_event()` copies the bytes after `sizeof(struct
 igmpmsg)` into the `IPMRA_CREPORT_PKT` netlink attribute and emits
 `RTM_NEWCACHEREPORT` on `RTNLGRP_IPV4_MROUTE_R`.

 As a result, 6 bytes of stale heap data from the skb head are
 disclosed to userspace.
</quote>

Let's use skb_put_zero() instead of skb_put() to fix this bug.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260430070611.4004529-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 94a6736bb5ab ("ipmr: only copy pktinfo to cache reports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipmr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index edd2413edff99..391b0152d6c85 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1087,11 +1087,12 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg->im_vif_hi = vifi >> 8;
 		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
 		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
-		/* Add our header */
-		igmp = skb_put(skb, sizeof(struct igmphdr));
+		/* Add our header.
+		 * Note that code, csum and group fields are cleared.
+		 */
+		igmp = skb_put_zero(skb, sizeof(struct igmphdr));
 		igmp->type = assert;
 		msg->im_msgtype = assert;
-		igmp->code = 0;
 		ip_hdr(skb)->tot_len = htons(skb->len);	/* Fix the length */
 		skb->transport_header = skb->network_header;
 	}
-- 
2.53.0

