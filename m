Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE4563FC9
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095732; cv=none; b=Lq7PJVd4/9L6RGWeCQSVD45GfvMqtiK+KAbmbNQE9oDrzIrHui78PkcXKKRv2VhpGpsCnJZJreL+rBzKjY6y9drKWtPn3SDUsxPJ3AIUMQRSAWtrv93/8PWBKaTPe/snzXJzH3m0IN0eEzep+v9tSQMzrYBdo/ZbPw35H90a/To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095732; c=relaxed/simple;
	bh=ScjOgL6DUr02IqhJGYixR0YTri/Fi+vTkDZXdRnuKUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClxFByINHKQW5DqFsoN1iX1A+/j2f/i3AhwedrQoiWh34abRrz7I19UHMPQlLX/myizG1CSez0+QVbnM6OMd1gzrUoO0g+z9MSewYKBjLyOmnar2RtL0lnaB32OI9cn/h5lipWBpe95S7GHUu8tE068z/FUVoMAuCUOeTmHi0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBfDo5nD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBfDo5nD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467251F000FF;
	Tue, 22 Sep 2026 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095724;
	bh=Q38XRnfE7N+0qtl6GnnI+MTwkKFzluJ5nv2QNO5WhRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aBfDo5nDypQAwGc3lpQoHgQ+xWI6EBITMrEWok8eLNFr4IrqoD6ktb6b9gsC9hcyB
	 cow4WPvnE7pZM4u1ClmLhVoIM8SzLMQtp9OO/aZtZqccILsBCzfYbEbaY3bjKtDhQf
	 t7R5a1S3c9aF6nlu71D5DK05ANxpB/BXa/gzCh37yhRtQhJympADbv2ChlsetAb2RN
	 Q5DiDB+d9cb1wUrYTkFO5v/0ohne3ZD1Oa38EcpEJ4bL+lc8IlnlWHKGqoiYtKuWxJ
	 yReDNf/V3FtURvF6yGQcZeOfhvGTNO4lnem2UsrPBxpYtogcbvlmh8H/X8LUyKdhKb
	 z7MdPozBqpgMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] xfrm: Refactor xfrm_input lock to reduce contention with RSS
Date: Tue, 22 Sep 2026 12:48:40 -0400
Message-ID: <20260922164842.3125154-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092226-ebony-armband-9098@gregkh>
References: <2026092226-ebony-armband-9098@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit 10a11861943902fda74f37f456b45183b2bca270 ]

With newer NICs like mlx5 supporting RSS for IPsec crypto offload,
packets for a single Security Association (SA) are scattered across
multiple CPU cores for parallel processing. The xfrm_state spinlock
(x->lock) is held for each packet during xfrm processing.

When multiple connections or flows share the same SA, this parallelism
causes high lock contention on x->lock, creating a performance
bottleneck and limiting scalability.

The original xfrm_input() function exacerbated this issue by releasing
and immediately re-acquiring x->lock. For hardware crypto offload
paths, this unlock/relock sequence is unnecessary and introduces
significant overhead. This patch refactors the function to relocate
the type_offload->input_tail call for the offload path, performing all
necessary work while continuously holding the lock. This reordering is
safe, since packets which don't pass the checks below will still fail
them with the new code.

Performance testing with iperf using multiple parallel streams over a
single IPsec SA shows significant improvement in throughput as the
number of queues (and thus CPU cores) increases:

+-----------+---------------+--------------+-----------------+
| RX queues | Before (Gbps) | After (Gbps) | Improvement (%) |
+-----------+---------------+--------------+-----------------+
|         2 |          32.3 |         34.4 |             6.5 |
|         4 |          34.4 |         40.0 |            16.3 |
|         6 |          24.5 |         38.3 |            56.3 |
|         8 |          23.1 |         38.3 |            65.8 |
|        12 |          18.1 |         29.9 |            65.2 |
|        16 |          16.0 |         25.2 |            57.5 |
+-----------+---------------+--------------+-----------------+

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Stable-dep-of: 3cf5cdecd99c ("xfrm: save input state data before secpath resets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_input.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 5d3633ce6ba32..01734b4b06578 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -493,6 +493,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		if (encap_type == -1) {
 			async = 1;
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
+			spin_lock(&x->lock);
 			goto resume;
 		}
 		/* GRO call */
@@ -529,6 +530,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
 				goto drop;
 			}
+
+			nexthdr = x->type_offload->input_tail(x, skb);
 		}
 
 		goto lock;
@@ -626,11 +629,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop_unlock;
 		}
 
-		spin_unlock(&x->lock);
-
 		if (xfrm_tunnel_check(skb, x, family)) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERROR);
-			goto drop;
+			goto drop_unlock;
 		}
 
 		seq_hi = htonl(xfrm_replay_seqhi(x, seq));
@@ -638,9 +639,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_SKB_CB(skb)->seq.input.low = seq;
 		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
 
-		if (crypto_done) {
-			nexthdr = x->type_offload->input_tail(x, skb);
-		} else {
+		if (!crypto_done) {
+			spin_unlock(&x->lock);
 			dev_hold(skb->dev);
 
 			nexthdr = x->type->input(x, skb);
@@ -651,9 +651,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			}
 
 			dev_put(skb->dev);
+			spin_lock(&x->lock);
 		}
 resume:
-		spin_lock(&x->lock);
 		if (nexthdr < 0) {
 			if (nexthdr == -EBADMSG) {
 				xfrm_audit_state_icvfail(x, skb,
-- 
2.53.0

