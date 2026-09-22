Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E95380FD2
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102087; cv=none; b=KNhpjkMys3bZMHXxcmMAVitMhgILPwZCSsORvIvxa48AEthg4/ueXQl72EwS1HmnOgdX8QYR7mITgl9N4hzu9KRSeW8MehhtQ8J6Gs+2Bx/eBuFomfv8ePwpB1jMea1QI4PHu+9kR/RGzlp/EnLtqCuYRhLG3Ikwnx7SdE/b33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102087; c=relaxed/simple;
	bh=tLJPAyOeB1Nc7jNtGG5Qza0c4eCACFtWkIVnBMFJG0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2NxWtmbk/sBuILJDxzZEjRPhl8HAgTxKWvFWuj+ddRSxF3jpwZzEhIJ1dlth646b3WANVF4m0M0iK58IedP8YvSEoVhhM07ljLAH23mDNabuargX3EDFqAdqQlLC3iy44gOJEy+kgavr8wVm5eIGvhzEOKyGhgQktfL3prI85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbvJ/5XZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbvJ/5XZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2FC1F00893;
	Tue, 22 Sep 2026 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102085;
	bh=4/nF87bmI2Vxix3KYK9jdrprqJl4XTzucGn4W0pu4L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EbvJ/5XZPASMQBBYjoR+wluk51d0KXOpbGh0op43sJrYHzjR28PgjbCGi4YXcdieN
	 CipqVVCnnfbfnC8RtqeAHR9EBDujOFf09vlJrMxqfGUDUO3Umxc/p/lkEbGL7sFExD
	 taKtzZH6JL4nMV6TjpejXzfck4y5/2oQOXPij6V8jcQXWC4Q9bmcohjC59QNTI1Qcy
	 WSfuok7U0MIqKFgAyJPe5tDVsmZ+WoYbgqaEP1/DTLFimo1lhN/3Q2qfm85hFADrxR
	 gvfz9jVfU1KPCESXhlHhfNBhni0HBkl9WI1NE3YFURF3ryTU8QdSRzouJi9U2S8v7+
	 Hwp9lQbHoNmLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] xfrm: Refactor xfrm_input lock to reduce contention with RSS
Date: Tue, 22 Sep 2026 14:34:40 -0400
Message-ID: <20260922183442.3692649-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922183442.3692649-1-sashal@kernel.org>
References: <2026092228-detective-absolute-febb@gregkh>
 <20260922183442.3692649-1-sashal@kernel.org>
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
index 31a677073fd3a..39e149a87cf0b 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -506,6 +506,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			async = 1;
 			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
+			spin_lock(&x->lock);
 			goto resume;
 		}
 
@@ -544,6 +545,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
 				goto drop;
 			}
+
+			nexthdr = x->type_offload->input_tail(x, skb);
 		}
 
 		goto lock;
@@ -632,11 +635,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
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
@@ -644,9 +645,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_SKB_CB(skb)->seq.input.low = seq;
 		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
 
-		if (crypto_done) {
-			nexthdr = x->type_offload->input_tail(x, skb);
-		} else {
+		if (!crypto_done) {
+			spin_unlock(&x->lock);
 			dev_hold(skb->dev);
 
 			nexthdr = x->type->input(x, skb);
@@ -654,9 +654,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				return 0;
 
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

