Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9C5964E4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907031; cv=none; b=LxZeMKU9RKIhzeek8N9dvvrWtOrHiCQTegryLuTPrZLRqmbSI0u5LTaTMz/cqQbcSoyRiHpziyaza3Yq2dHxORbYS8YUdxdNG9GTV2BZ/gObk13+K7UZDdMyGjCadXZ6FN4CRsVM/yV3Mx2/F3qyI9W1tENDNvuGIRF3ueilmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907031; c=relaxed/simple;
	bh=hT4mLvAk8BD1oKJOiXSng8uhzxGuNejMd38DeTEFD+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXfppaGvtDto9Dhj/yfsKbQbsOzchSMHJkrNKxkFtsfHImki6/V/R8XVPp49UMuKndy7HFhiDLmD3iYfvJK+g+oByvxJXUnBxgIwz1C5glpDyQcQWXuEp7XgDe5UBchkcRRlrk4528//sEhhXr7tAssx0FcBExrmsEDEriJ09kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHYizj5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHYizj5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A141F00A3A;
	Tue,  8 Sep 2026 22:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907027;
	bh=Fu7korJSjDskwdFIAeht1O08Yx+SI3MnYKYz8qFbIVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FHYizj5zQ1MDf5PjFbTa+tRnEJArKn9aRehS6Bh9I/tFfSt9YRS7/nfR15r8+lV7s
	 IDr9TtYcHKJG+PMZsMUp4Ra3goKBEkbjvCyY1K12LYxGX94M9v66aeuZr5OSdzQI+q
	 +nUiimBWSiqTXS5G6FuDBqIupwzjaBpMh8tuB+9NAHMRJ+KhKWxiOz5SUWAWQgEtWF
	 GthK87ZKMpPkPHYJddFuMKpB2fZf2jIGrEcveZIrCeJQPzGN3Oj/Sv3neYB8ONu5jw
	 MJ8j2B7ZVEpY57jKSJorjxfKUvA4B+tPkYIekM3NkeqjDODUOM82FhLKM5PSYT/agc
	 vGrmwukGNzBGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] inet: frags: add inet_frag_putn() helper
Date: Tue,  8 Sep 2026 18:37:03 -0400
Message-ID: <20260908223705.504692-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090319-football-expel-7883@gregkh>
References: <2026090319-football-expel-7883@gregkh>
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
Stable-dep-of: e36ce6e78fe3 ("ip: orphan prefetched skbs before multicast forwarding")
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
index 0b0876610553f..bba42c62f8671 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -141,9 +141,9 @@ struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key);
 /* Free all skbs in the queue; return the sum of their truesizes. */
 unsigned int inet_frag_rbtree_purge(struct rb_root *root);
 
-static inline void inet_frag_put(struct inet_frag_queue *q)
+static inline void inet_frag_putn(struct inet_frag_queue *q, int refs)
 {
-	if (refcount_dec_and_test(&q->refcnt))
+	if (refs && refcount_sub_and_test(refs, &q->refcnt))
 		inet_frag_destroy(q);
 }
 
diff --git a/include/net/ipv6_frag.h b/include/net/ipv6_frag.h
index 5052c66e22d23..def43863ba494 100644
--- a/include/net/ipv6_frag.h
+++ b/include/net/ipv6_frag.h
@@ -66,6 +66,7 @@ ip6frag_expire_frag_queue(struct net *net, struct frag_queue *fq)
 {
 	struct net_device *dev = NULL;
 	struct sk_buff *head;
+	int refs = 1;
 
 	rcu_read_lock();
 	/* Paired with the WRITE_ONCE() in fqdir_pre_exit(). */
@@ -108,7 +109,7 @@ ip6frag_expire_frag_queue(struct net *net, struct frag_queue *fq)
 	spin_unlock(&fq->q.lock);
 out_rcu_unlock:
 	rcu_read_unlock();
-	inet_frag_put(&fq->q);
+	inet_frag_putn(&fq->q, refs);
 }
 
 /* Check if the upper layer header is truncated in the first fragment. */
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index a91283d1e5bfc..92b1c50e7c286 100644
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
index 9586bbbe92f9c..4117b40c1f3a2 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -144,8 +144,7 @@ static void inet_frags_free_cb(void *ptr, void *arg)
 	}
 	spin_unlock_bh(&fq->lock);
 
-	if (refcount_sub_and_test(count, &fq->refcnt))
-		inet_frag_destroy(fq);
+	inet_frag_putn(fq, count);
 }
 
 static LLIST_HEAD(fqdir_free_list);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 0ed999fdca2d7..dd1258d0ad051 100644
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
index 6642f06d1b1dc..758f194f73024 100644
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
index 32ba4417eb1de..320cc38a9f575 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -375,7 +375,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	fq = fq_find(net, fhdr->identification, hdr, iif);
 	if (fq) {
 		u32 prob_offset = 0;
-		int ret;
+		int ret, refs = 1;
 
 		spin_lock(&fq->q.lock);
 
@@ -384,7 +384,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 				     &prob_offset);
 
 		spin_unlock(&fq->q.lock);
-		inet_frag_put(&fq->q);
+		inet_frag_putn(&fq->q, refs);
 		if (prob_offset) {
 			__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
 					IPSTATS_MIB_INHDRERRORS);
-- 
2.53.0

