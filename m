Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F0B492E55
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908550; cv=none; b=WuRAaCVIVB35ASVZjFFOzdNV/spWpCe5fxiul6T8+gykglV9Ejq4/cU071H3tzXRkz00288oDbaBuSrDTAKRlMuxTsy9H/P9HTRoDZLeL59q0DSiTHE4O6KJ2QzkAX/otx2j41SQlD0pKA9shos1glh81zkOuKHoeUDruKQVHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908550; c=relaxed/simple;
	bh=jt0ZQxh3gJrXGhPrCkBVJnyIp82F/bEtbMufqPk70ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttfivYAbK15CTIkJvT8IHp9rEFCPo2qSn3dMzbUG5Y8BazakxLn4YLz1XzTXcb1qVP29Bth9WD9I7IyXj+QH9qtYtG6KKbdMO/LrRhnNWcv+oZ/a0FdJVnSwZif2Sq26EGrUVi2KbiaogPMrvuqfA6LAqOdx+c4tlc5wny4Gbi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vkhe7awM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vkhe7awM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4461F00A3A;
	Tue,  8 Sep 2026 23:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908549;
	bh=mcAJ2pArFMwRRDELKWfn/k9KHicB8Agaypy1B43CLSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vkhe7awMPvp0WEDa95/IRo8bwasezKSi7qBS0eGhI3qQrMK8VMa/f4WDiH6IH403J
	 99GexhTITlSFF1z3/ttXkP7eUvwyC0J8czeOMykypPDSQwVUb7Emf/U7knsTSP3RKB
	 j2IUhCbpMszAWv6EFk+Ns+nAuAIiwdJuIzzGvwQTpd9duW10yrBqEOn3MXA/OA8IbN
	 HOWQGYT4QzZhw6gNGqrjoSSbKbfwt+Gmta/zRwBF/3PbB7fZiLNvBtkC5L7HmLfO6s
	 gD5Jls7zQbHfBFF8/Mkq25mkPK+cmSL5TpGprqB2EtDVHz2GuI5cFiiBiBb8P8cEF2
	 JMJTwKdI79okw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] inet: frags: add inet_frag_putn() helper
Date: Tue,  8 Sep 2026 19:02:25 -0400
Message-ID: <20260908230227.559723-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090320-tiptop-scrooge-9ea0@gregkh>
References: <2026090320-tiptop-scrooge-9ea0@gregkh>
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
index 4cbd413e71a3f..1a212499fc98a 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -135,9 +135,9 @@ struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key);
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
index 0a4779175a523..3443c7905b785 100644
--- a/include/net/ipv6_frag.h
+++ b/include/net/ipv6_frag.h
@@ -65,6 +65,7 @@ ip6frag_expire_frag_queue(struct net *net, struct frag_queue *fq)
 {
 	struct net_device *dev = NULL;
 	struct sk_buff *head;
+	int refs = 1;
 
 	rcu_read_lock();
 	/* Paired with the WRITE_ONCE() in fqdir_pre_exit(). */
@@ -107,7 +108,7 @@ ip6frag_expire_frag_queue(struct net *net, struct frag_queue *fq)
 	spin_unlock(&fq->q.lock);
 out_rcu_unlock:
 	rcu_read_unlock();
-	inet_frag_put(&fq->q);
+	inet_frag_putn(&fq->q, refs);
 }
 
 /* Check if the upper layer header is truncated in the first fragment. */
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index be6f06adefe0a..f5b554894d024 100644
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
@@ -301,13 +302,13 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
 
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
index 18217537cb298..ef2ef64dc8af4 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -144,8 +144,7 @@ static void inet_frags_free_cb(void *ptr, void *arg)
 	}
 	spin_unlock_bh(&fq->lock);
 
-	if (refcount_sub_and_test(count, &fq->refcnt))
-		inet_frag_destroy(fq);
+	inet_frag_putn(fq, count);
 }
 
 static void fqdir_work_fn(struct work_struct *work)
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index ec2264adf2a6a..f24e498dd1efc 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -107,7 +107,7 @@ static void ip4_frag_free(struct inet_frag_queue *q)
 
 static void ipq_put(struct ipq *ipq)
 {
-	inet_frag_put(&ipq->q);
+	inet_frag_putn(&ipq->q, 1);
 }
 
 /* Kill ipq entry. It is not destroyed immediately,
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 8313069b9f391..3d9bff1675323 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -447,6 +447,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	struct frag_hdr *fhdr;
 	struct frag_queue *fq;
 	struct ipv6hdr *hdr;
+	int refs = 1;
 	u8 prevhdr;
 
 	/* Jumbo payload inhibits frag. header */
@@ -489,7 +490,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	}
 
 	spin_unlock_bh(&fq->q.lock);
-	inet_frag_put(&fq->q);
+	inet_frag_putn(&fq->q, refs);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nf_ct_frag6_gather);
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 6993675171556..31bfc7932378a 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -374,7 +374,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	fq = fq_find(net, fhdr->identification, hdr, iif);
 	if (fq) {
 		u32 prob_offset = 0;
-		int ret;
+		int ret, refs = 1;
 
 		spin_lock(&fq->q.lock);
 
@@ -383,7 +383,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 				     &prob_offset);
 
 		spin_unlock(&fq->q.lock);
-		inet_frag_put(&fq->q);
+		inet_frag_putn(&fq->q, refs);
 		if (prob_offset) {
 			__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
 					IPSTATS_MIB_INHDRERRORS);
-- 
2.53.0

