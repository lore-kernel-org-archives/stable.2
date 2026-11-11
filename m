Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418746;
	b=zA7DhOwFmb14mS5cMnVrs2qDN8EVH1Pfl0GgiC4h0w7fBVodc8hYJjKHi8fzkaHAu3yQ
	 e2/9lOoNrr3O15ttQoftIIT30UuNdQIFsaTnZWmtqYbfBjHc4TpiLJDCFvP5WVNtrtXa/
	 fIG4jsPhXTKwcOiDn+tw3M3hHdS5kcjBUmURTJko8UmrI8KKo/Te8SfO5tKioy3DyU0Im
	 gegrDYEnOqGaumCjp5UwfKh+jvXf1vyOCrF9Zi2MkvcH87gH7jShaQud8fetnZJQkzVm/
	 /c80ebxLlUMyquVu1+3Au48wzz8FQuCbWyPkoafZA0paQoyMxMFDmpZ6Y0jtLIS0EaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418746;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RPx4W2H46ROzDhsE+zVNFq5Rqpkmfo96O19aFpn8vIo=;
	b=xGv9gixUDjnGueqZF8TzGR0gQYlq2VVERelg1PSl9eDc3wozEwpRZwkk3kGo3bDAe4Er
	 IJKIN6UgnzXi3TAYWa8ROeNiRH6QuBAvP6hk1yi0Cy+6NK5vY2ijw+65xdLYuqrK2II4v
	 uLc7jBzCIoIJ1c/VdDQBfiGOWn/erOUdlLENNHUITWatyILIJUwm3l4HpyNz00S8QlMwt
	 zsQ2gzMTyzYWc6H19Xf0jAzIcIBY3fLJFzwMhy4ViWFPUDzrAPGzXOfJCpM/t1bGAkw2L
	 oAroQSn/zPZ1kQ81rdirVy/0yUFJyYPStLzgof6VTeTQo1hLrNVRRt4N96pWL2pvp4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEqxYcxm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DA4606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEqxYcxm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAEC1F00A05;
	Wed, 11 Nov 2026 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418746;
	bh=RPx4W2H46ROzDhsE+zVNFq5Rqpkmfo96O19aFpn8vIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cEqxYcxmzTx1c+QcN6UqacSxf+ck5YLdsQ0P1PhC9+EHv0gbwgFgcic7EpmD0ATg+
	 2T+W+YdJ1PLubxbtqigjVeUnVObgHJ/o1V+TCnycICE0QV3b1PlJon7O7Oof5SKPO4
	 StD9yL9rNZmYHgSa4bcTyv25oFaiv919nZuZCFuJOfSPw/ucsN+OXYNmK+qSZsL8Mv
	 p+vjmKzndSvtTAyifc1ZOgX7Y5fsctRbMII4li8Q3Ide9uGi4x++ZElh6DxsCdt3x1
	 flK0rLwm+XT0A2bs42bdOZ2tDWlLxqtmi1sM/Ksmz+eI6Z2s6fs9RRLdlJds5OpYDJ
	 DKDRUnsMzSpSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ipmr: prevent info-leak in pmr_cache_report()
Date: Wed, 11 Nov 2026 12:39:03 -0500
Message-ID: <20261111173836.3630034-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052532-failed-6.12-94a6736bb5ab@kernel.org>
References: <20261107052532-failed-6.12-94a6736bb5ab@kernel.org>
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
index 3b58e8e88ad25..fec7012a62e45 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1088,11 +1088,12 @@ static int ipmr_cache_report(const struct mr_table *mrt,
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

