Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419542;
	b=P94tkJAdvOVYGMcLylQJN0CxjSHkGijZ69cFoLce4MAlkV4Mapzd9AzX+zLoBqU4xLlw
	 VJ8R5DhRWDXJwIiy82j4rYbbl0wYlTwPB6htwUNrUGi5UTFXjzHdqJjjlqSIyR7GX/KeQ
	 3DQyaN3CP9Mh7t/c3SyQT6PBdWLQvPNMkL2b+LHIHP5/QCb+SRVByZ8PAn0dzabOuQVWw
	 NGwyXKxShrRfafdXrVjOaXuf4plzNxpdhijBllcAQLnO2YqxuonAJqPzf7nxAOhGY29XS
	 Y+go0F6ByKgHJ6n2RWCN+5mIhiikimpNy+/58cng3GSEmrQBn8jwNg137TjVwPk2UrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419542;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qjqHIXXy6piGqleiVwHgUif+/ACGSqOw+PUghCMoew8=;
	b=yZ/0WaY1qwBr46q9Nm0MAVcrhRnQgIZcm2wqok3p4Z6UyVA+yIxggCKd/yc59FybeYpq
	 H/1fcwcUWaJ3YyAD5mnyaB2Y9ohF0XjULhk9TorxZndFBoZ2HBZM0KFH0MrmkCWvGhpX/
	 XWBY88Ae77AK/ykvm4MwIGFX+zVh492zg0sS8G3TVfIsXpVTA5HVl92HvTPw2m09eVFFo
	 vz/QX4ctXTL01ssx0fErxt5aWmyhaK4UZzEycdqFKmnMaS6r4cVMwegoFSSBI05fp+x+U
	 K1dGN9/cQml1HFg8jCf1NDJSXGcHT3xwzYU3JaXQ9sMS5ccdHO6SMGSEonCKP1i2htg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgR7aFyD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2946D606A891
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgR7aFyD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154581F00A07;
	Wed, 11 Nov 2026 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419541;
	bh=qjqHIXXy6piGqleiVwHgUif+/ACGSqOw+PUghCMoew8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dgR7aFyDAaisCpERbMXoKvjbD3pmGG81mIBKjrQ09iJeUdJdxCy2ib24ZMpEjaI+z
	 oNZLgn4pxr5Pqooy9wwJZPSi0DtUUeyND202pi01TSQfVN3mGUeX27NcLOY0Hram9O
	 oxOLGHA52Yv30wjHuPW9xb4O9cZqpS7L3PbbifUuqjLh4gd2bgvs9nuAfN1XmoRcWF
	 f3f22I2lQDCYOKUVfbtGuyxWuG7321hFFPxu4EMqvG4xr3ck+m7Q8MQos8f9+FTz6d
	 Cwsj42nffK9kcpzsG7Re+WHh/ayBmVOFjgy3FeZ3iFE/vNZQGFp4iHz8ZNN7fHGxuB
	 eMHBFj+oGPg0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ipmr: prevent info-leak in pmr_cache_report()
Date: Wed, 11 Nov 2026 12:52:18 -0500
Message-ID: <20261111175153.3696544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055356-failed-6.1-94a6736bb5ab@kernel.org>
References: <20261107055356-failed-6.1-94a6736bb5ab@kernel.org>
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
index 948993a4f4157..f9c66ca729978 100644
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

