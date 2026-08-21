Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F1429CEC
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323770; cv=none; b=Wg3rsuDdNhWuhifgvIsiFApGfl+U00tSAVCYOGzs0EC0HJh3gQgns/P7KllQ6A5256wdCU2bGrti+S++0uqVJHJ/xYKWJ3qLBvNQkrmu9i0yjvKzj7zKQchAgeA/alP8BF6kM1jHH6gJEaA3DmGGv0+oTY9yZcrkAEZSdhchAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323770; c=relaxed/simple;
	bh=KGAEf+d+aj7nIMgOGQBTi4+8jWGvfuPho969+miyuiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGlCmyv9aS9X5+4xHQ78Lz4S0HQkmUNATgwI7GeKdaVBPQorGPB/Zydnebtz3jOmA2kgnToIyWncTeaUMjoxQJ1glrkjdxS461vIkvxTsXmlsYXfELOokiXxpla1XpdJK4IA/8txAf6muCXJ2XEus9XdvAfPUUJfYWL0RSR4A6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7AEZnzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7AEZnzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF0E1F000E9;
	Fri, 21 Aug 2026 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323768;
	bh=cY/bCTs/ytFP0GgR833XxTA8YY8eu9KHttaiqH7sjvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S7AEZnzZxZOyFKPkcahw3UQXEiArmccUtbQ9lw8QU3Wj+TuhYBiOMRg0mW0QvFQSc
	 stSzdzZwkPZzejrV8kGz6uINK6SwCwELICv6CifozwFKrqdt1fPTq1rDjXAx0pPFOc
	 LyYWl/zT7EsS4PUz6x089lafUR0j3gI7WBK4ta/b4Yi3jCh1k3oOhNynphxN+H8m4H
	 M1BzXQkm51JaUcO1CG+3e2JLfY1ll3erlbwrYRA4df+esRVra8Ydyy7nj1vlT9CWXL
	 C1y54WuGzG0jK54pHEO1jNiNdyEEBmYZf+NW7sQnfzwGuMnnPglueAd36HXFldYgbx
	 SkfuTInDNq/SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] inet: frags: add inet_frag_putn() helper
Date: Fri, 21 Aug 2026 10:49:22 -0400
Message-ID: <20260821144926.3428433-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081749-cash-armed-755d@gregkh>
References: <2026081749-cash-armed-755d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit ae2d90355aa5592b0e99c8bbb4c3fa1d8e205f1b ]

inet_frag_putn() can release multiple references
in one step.

Use it in inet_frags_free_cb().

Replace inet_frag_put(X) with inet_frag_putn(X, 1)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250312082250.1803501-2-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 653d7ddf6cba ("inet: frags: publish queues before arming timer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_frag.h                 | 4 ++--
 include/net/ipv6_frag.h                 | 3 ++-
 net/ieee802154/6lowpan/reassembly.c     | 7 ++++---
 net/ipv4/inet_fragment.c                | 3 +--
 net/ipv4/ip_fragment.c                  | 2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c | 3 ++-
 net/ipv6/reassembly.c                   | 4 ++--
 7 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index fcabb34fff35d..433d72ebb9d66 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -133,9 +133,9 @@ struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key);
 void inet_frag_queue_flush(struct inet_frag_queue *q,
 			   enum skb_drop_reason reason);
 
-static inline void inet_frag_put(struct inet_frag_queue *q)
+static inline void inet_frag_putn(struct inet_frag_queue *q, int refs)
 {
-	if (refcount_dec_and_test(&q->refcnt))
+	if (refs && refcount_sub_and_test(refs, &q->refcnt))
 		inet_frag_destroy(q);
 }
 
diff --git a/include/net/ipv6_frag.h b/include/net/ipv6_frag.h
index df61b98b52153..ff5644fa976eb 100644
--- a/include/net/ipv6_frag.h
+++ b/include/net/ipv6_frag.h
@@ -66,6 +66,7 @@ ip6frag_expire_frag_queue(struct net *net, struct frag_queue *fq)
 {
 	struct net_device *dev = NULL;
 	struct sk_buff *head;
+	int refs = 1;
 
 	rcu_read_lock();
 	spin_lock(&fq->q.lock);
@@ -112,7 +113,7 @@ ip6frag_expire_frag_queue(struct net *net, struct frag_queue *fq)
 	spin_unlock(&fq->q.lock);
 out_rcu_unlock:
 	rcu_read_unlock();
-	inet_frag_put(&fq->q);
+	inet_frag_putn(&fq->q, refs);
 }
 
 /* Check if the upper layer header is truncated in the first fragment. */
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 867d637d86f08..2df1a027e68a1 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -45,6 +45,7 @@ static void lowpan_frag_expire(struct timer_list *t)
 {
 	struct inet_frag_queue *frag = from_timer(frag, t, timer);
 	struct frag_queue *fq;
+	int refs = 1;
 
 	fq = container_of(frag, struct frag_queue, q);
 
@@ -56,7 +57,7 @@ static void lowpan_frag_expire(struct timer_list *t)
 	inet_frag_kill(&fq->q);
 out:
 	spin_unlock(&fq->q.lock);
-	inet_frag_put(&fq->q);
+	inet_frag_putn(&fq->q, refs);
 }
 
 static inline struct lowpan_frag_queue *
@@ -302,13 +303,13 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
 
 	fq = fq_find(net, cb, &hdr.source, &hdr.dest);
 	if (fq != NULL) {
-		int ret;
+		int ret, refs = 1;
 
 		spin_lock(&fq->q.lock);
 		ret = lowpan_frag_queue(fq, skb, frag_type);
 		spin_unlock(&fq->q.lock);
 
-		inet_frag_put(&fq->q);
+		inet_frag_putn(&fq->q, refs);
 		return ret;
 	}
 
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 21a002750e163..61fb0c04d3bd3 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -145,8 +145,7 @@ static void inet_frags_free_cb(void *ptr, void *arg)
 	}
 	spin_unlock_bh(&fq->lock);
 
-	if (refcount_sub_and_test(count, &fq->refcnt))
-		inet_frag_destroy(fq);
+	inet_frag_putn(fq, count);
 }
 
 static LLIST_HEAD(fqdir_free_list);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index d3abc84a6c02e..b3c5ca0ad156e 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -112,7 +112,7 @@ static void ip4_frag_free(struct inet_frag_queue *q)
 
 static void ipq_put(struct ipq *ipq)
 {
-	inet_frag_put(&ipq->q);
+	inet_frag_putn(&ipq->q, 1);
 }
 
 /* Kill ipq entry. It is not destroyed immediately,
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index fbcc8af7435c1..483f3541b1e59 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -448,6 +448,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	struct frag_hdr *fhdr;
 	struct frag_queue *fq;
 	struct ipv6hdr *hdr;
+	int refs = 1;
 	u8 prevhdr;
 
 	/* Jumbo payload inhibits frag. header */
@@ -490,7 +491,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	}
 
 	spin_unlock_bh(&fq->q.lock);
-	inet_frag_put(&fq->q);
+	inet_frag_putn(&fq->q, refs);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nf_ct_frag6_gather);
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index a48be617a8ab5..5d56a8e5166bc 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -380,7 +380,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	fq = fq_find(net, fhdr->identification, hdr, iif);
 	if (fq) {
 		u32 prob_offset = 0;
-		int ret;
+		int ret, refs = 1;
 
 		spin_lock(&fq->q.lock);
 
@@ -389,7 +389,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 				     &prob_offset);
 
 		spin_unlock(&fq->q.lock);
-		inet_frag_put(&fq->q);
+		inet_frag_putn(&fq->q, refs);
 		if (prob_offset) {
 			__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
 					IPSTATS_MIB_INHDRERRORS);
-- 
2.53.0

