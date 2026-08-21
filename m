Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463937DEAD
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331119; cv=none; b=dkO4fc3L44DQ7JytJ8uTR2IM4W47iiQFVuCI1wI+//5hLxasiJZIXvm2F0yqTV2ZIjHMrcYByfcezRlvHIqCmaXe/hvifOnuytVUSXWu7M5+V+X3Ihm6ytIGO0YYgEXaRbLmih0W0t4K9/bb7LTtkfVjp1mtDiZibOJT0Jtdsnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331119; c=relaxed/simple;
	bh=Zf2uySZ+Z1U5S6SjhG5XI/m/qxxO3JQ26uM0oN5RrO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRNslK5Gi0rUWDkldqggHO2PpWBDNOn6BfofncaAbF0yPD/FSbXLVZ+6yfJdhWruSnLUMw2n2OuH59t314rvoB6wPYpA+ArrKGSVcpDcf/6eya9Y9Kw7nBBOxpZpd7AEApF41jUSFSWiXMW3n+IP8J8O3pjLYOccvigZfWatn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsMCml9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsMCml9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA08F1F01566;
	Fri, 21 Aug 2026 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787331111;
	bh=5uCWK3IGeUAVaebrj/mJGP+vm1DZMKmDWfjPFTUN6VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OsMCml9NSprylBRN5QRdfqhwcrvG6ESN2MAARTMWMDenhGqWI769yilN1lMP/7ff5
	 IVjrmjJN1F/o/C6w2cdQsFpKSqLNJYydbvasgK+4izINMicopnTmW56O0kjIa15Rtf
	 JuOxitKbbzfSFoHqtx1TbQR+O1UYyMNNinc0bb64LCApulgnvmGNoHBnGC47H6hxP8
	 oeLKPhnLpkxGsHLncFiiUGU5c1QQtZ8DxtdfN0+8rAsv7nqqMtiZPwh1hplNaqnFwL
	 2f1lvptIwSMTBERmZUAFTTxtZpAHbjDyEe078zTij3TfXDJgycgHNa3x7jTfB4ynms
	 Sqp5n7j7cH3pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] inet: frags: save a pair of atomic operations in reassembly
Date: Fri, 21 Aug 2026 12:51:46 -0400
Message-ID: <20260821165147.3593301-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821165147.3593301-1-sashal@kernel.org>
References: <2026081750-scion-darkened-b02a@gregkh>
 <20260821165147.3593301-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit ca0359df45a55a9eb4d6dc09a481064abf78320f ]

As mentioned in commit 648700f76b03 ("inet: frags:
use rhashtables for reassembly units"):

  A followup patch will even remove the refcount hold/release
  left from prior implementation and save a couple of atomic
  operations.

This patch implements this idea, seven years later.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20250312082250.1803501-5-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 653d7ddf6cba ("inet: frags: publish queues before arming timer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ieee802154/6lowpan/reassembly.c     |  5 ++++-
 net/ipv4/inet_fragment.c                | 18 ++++++++----------
 net/ipv4/ip_fragment.c                  |  5 ++++-
 net/ipv6/netfilter/nf_conntrack_reasm.c |  5 ++++-
 net/ipv6/reassembly.c                   |  9 ++++-----
 5 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 755847504e72e..ea5dbcc300b15 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -304,17 +304,20 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
 		goto err;
 	}
 
+	rcu_read_lock();
 	fq = fq_find(net, cb, &hdr.source, &hdr.dest);
 	if (fq != NULL) {
-		int ret, refs = 1;
+		int ret, refs = 0;
 
 		spin_lock(&fq->q.lock);
 		ret = lowpan_frag_queue(fq, skb, frag_type, &refs);
 		spin_unlock(&fq->q.lock);
 
+		rcu_read_unlock();
 		inet_frag_putn(&fq->q, refs);
 		return ret;
 	}
+	rcu_read_unlock();
 
 err:
 	kfree_skb(skb);
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index cfe3b6f585f51..e5b03de2f6afc 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -375,7 +375,8 @@ static struct inet_frag_queue *inet_frag_alloc(struct fqdir *fqdir,
 
 	timer_setup(&q->timer, f->frag_expire, 0);
 	spin_lock_init(&q->lock);
-	refcount_set(&q->refcnt, 3);
+	/* One reference for the timer, one for the hash table. */
+	refcount_set(&q->refcnt, 2);
 
 	return q;
 }
@@ -397,7 +398,11 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 	*prev = rhashtable_lookup_get_insert_key(&fqdir->rhashtable, &q->key,
 						 &q->node, f->rhash_params);
 	if (*prev) {
-		int refs = 2;
+		/* We could not insert in the hash table,
+		 * we need to cancel what inet_frag_alloc()
+		 * anticipated.
+		 */
+		int refs = 1;
 
 		q->flags |= INET_FRAG_COMPLETE;
 		inet_frag_kill(q, &refs);
@@ -407,7 +412,6 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 	return q;
 }
 
-/* TODO : call from rcu_read_lock() and no longer use refcount_inc_not_zero() */
 struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key)
 {
 	/* This pairs with WRITE_ONCE() in fqdir_pre_exit(). */
@@ -417,17 +421,11 @@ struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key)
 	if (!high_thresh || frag_mem_limit(fqdir) > high_thresh)
 		return NULL;
 
-	rcu_read_lock();
-
 	prev = rhashtable_lookup(&fqdir->rhashtable, key, fqdir->f->rhash_params);
 	if (!prev)
 		fq = inet_frag_create(fqdir, key, &prev);
-	if (!IS_ERR_OR_NULL(prev)) {
+	if (!IS_ERR_OR_NULL(prev))
 		fq = prev;
-		if (!refcount_inc_not_zero(&fq->refcnt))
-			fq = NULL;
-	}
-	rcu_read_unlock();
 	return fq;
 }
 EXPORT_SYMBOL(inet_frag_find);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 903b99cd0d5a9..8524f2ac2cf3a 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -477,18 +477,21 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);
 
 	/* Lookup (or create) queue header */
+	rcu_read_lock();
 	qp = ip_find(net, ip_hdr(skb), user, vif);
 	if (qp) {
-		int ret, refs = 1;
+		int ret, refs = 0;
 
 		spin_lock(&qp->q.lock);
 
 		ret = ip_frag_queue(qp, skb, &refs);
 
 		spin_unlock(&qp->q.lock);
+		rcu_read_unlock();
 		inet_frag_putn(&qp->q, refs);
 		return ret;
 	}
+	rcu_read_unlock();
 
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
 	kfree_skb(skb);
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 9f935fa1d3126..662e3c78b741d 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -452,7 +452,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	struct frag_hdr *fhdr;
 	struct frag_queue *fq;
 	struct ipv6hdr *hdr;
-	int refs = 1;
+	int refs = 0;
 	u8 prevhdr;
 
 	/* Jumbo payload inhibits frag. header */
@@ -479,9 +479,11 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	hdr = ipv6_hdr(skb);
 	fhdr = (struct frag_hdr *)skb_transport_header(skb);
 
+	rcu_read_lock();
 	fq = fq_find(net, fhdr->identification, user, hdr,
 		     skb->dev ? skb->dev->ifindex : 0);
 	if (fq == NULL) {
+		rcu_read_unlock();
 		pr_debug("Can't find and can't create new queue\n");
 		return -ENOMEM;
 	}
@@ -495,6 +497,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	}
 
 	spin_unlock_bh(&fq->q.lock);
+	rcu_read_unlock();
 	inet_frag_putn(&fq->q, refs);
 	return ret;
 }
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index ab24d8ca3b134..359b0b4ec1bbc 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -305,9 +305,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	skb_postpush_rcsum(skb, skb_network_header(skb),
 			   skb_network_header_len(skb));
 
-	rcu_read_lock();
 	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMOKS);
-	rcu_read_unlock();
 	fq->q.rb_fragments = RB_ROOT;
 	fq->q.fragments_tail = NULL;
 	fq->q.last_run_head = NULL;
@@ -319,9 +317,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 out_oom:
 	net_dbg_ratelimited("ip6_frag_reasm: no memory for reassembly\n");
 out_fail:
-	rcu_read_lock();
 	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMFAILS);
-	rcu_read_unlock();
 	inet_frag_kill(&fq->q, refs);
 	return -1;
 }
@@ -379,10 +375,11 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	}
 
 	iif = skb->dev ? skb->dev->ifindex : 0;
+	rcu_read_lock();
 	fq = fq_find(net, fhdr->identification, hdr, iif);
 	if (fq) {
 		u32 prob_offset = 0;
-		int ret, refs = 1;
+		int ret, refs = 0;
 
 		spin_lock(&fq->q.lock);
 
@@ -391,6 +388,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 				     &prob_offset, &refs);
 
 		spin_unlock(&fq->q.lock);
+		rcu_read_unlock();
 		inet_frag_putn(&fq->q, refs);
 		if (prob_offset) {
 			__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
@@ -400,6 +398,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 		}
 		return ret;
 	}
+	rcu_read_unlock();
 
 	__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_REASMFAILS);
 	kfree_skb(skb);
-- 
2.53.0

