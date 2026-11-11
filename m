Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418381;
	b=A4z6QMKfQTELRahKFf0Tzrw7XCR/ngU4uLzFra4uN3eOPfyvsTEFkmvieVaTE8uOvL8q
	 0BpDNhNk/ha0HMrMBIjYUiP1K7V2RiT4MZdWShWJVBEorPRPOg+t+LDj/ZBzdcE1tAOB+
	 VUJPb1v0+IRMzt//aYSFjPsNBJnLrYZlb4qv5U1XN4G6gb7rg4xYEUsZp3r4bm3QZCkwR
	 SU3KpNMxoqodWVZbuP3Pn6S5ZFo45fCQSt5PM5v8n4GpXv3zNW1h1DSFHvQMKbPgBFNEx
	 GCf5Y0zT6hFNE2gkr7g1k1upfyiO24sjW0qxOflOLXvPfBwElLlP1HHmLvpBxNGB36Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418381;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hwPLgwzYzkq5UTNhoH/QXwRXPyRS0sVP85Tr0KvPeQo=;
	b=VJuOzc7ie93QNW58ikLqBmkrf2XHVNmhLh8eepPTqzVEUY66hyd2LP50oRO5RKmHaKQ0
	 xd00DL/ZVgpDhutaNL/teqmo1jIl9YMQE+/jIyHCTpDCQ0fwUpKHKIPldOF1VB7Ashu2N
	 NPdRleWjkdxzGFXPeTEGEkgk3AE1L3/zEXh0V0aUi5Vax+pxcoHfvN61GoWSGpMd2BU6v
	 Ec7xPUWauIboPicgSK3Q63FNc+tsNwEwG0Pg9rDipmWtUhTqLjoN8ofxn+KTfVFzgGNLN
	 iyttNxcFUqeNpifBMSjQFU7aIeGG8iCSn5/pR7S4L+zD642L9k/RyZhrf/1a2TCl2iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIfJGN00;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A96606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIfJGN00
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E921F00A05;
	Wed, 11 Nov 2026 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418381;
	bh=hwPLgwzYzkq5UTNhoH/QXwRXPyRS0sVP85Tr0KvPeQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EIfJGN006EuxWI8bVXUTcEzqKBORsZFryOBWBLhee/R10nZC1sBXGo1ZzPcGWISTQ
	 H0gsRLutBK+VlUnlbCnXnft90BwKxiw7KoGqC6v5c3GT3kEGNIinCm/3RyIXZfSM6k
	 EHouhgzusBllq21xQM5uL2kxT6ZJhP9BWTT+/k3m6QMcHX80b02WjexoRLp3bhvJQ3
	 m/80Mql4w17CoDMT2cLcPaS9iWeR0KckUggLXyyqQBKmuDaJAlh7BVPghVG/ef87L6
	 0FKATLa7wh15DPHDvrya1IMWCp2mAPeK97MRZYLQxeT4n7iTurxtsj8yeSOAGc8INa
	 CWjNAp9/kjIpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ipmr: prevent info-leak in pmr_cache_report()
Date: Wed, 11 Nov 2026 12:32:58 -0500
Message-ID: <20261111173235.3591073-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051350-failed-6.18-94a6736bb5ab@kernel.org>
References: <20261107051350-failed-6.18-94a6736bb5ab@kernel.org>
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
index dd9ed871a1b4f..cd587d84f388e 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1112,11 +1112,12 @@ static int ipmr_cache_report(const struct mr_table *mrt,
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

