Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8D37C93C
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331119; cv=none; b=EObJex/0oasFiVSFizFc9QI78agj/3yWgB0EfwG6LSuOTd40/MZrioq91bzBk1rGHJmsq+YgfbjfgRIwdYOPrr3g2KNaYeJxVe6BYCbizZyJ8JiUMKDBLauuxJtqMXvYHlCXDQ/84BruUT4ZGZMMyj/kDmngISga03SnrbvFo/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331119; c=relaxed/simple;
	bh=UXNR+cxkzU2vBSEa6t8+6u5gPxGf1pYLdNIgqS0EGXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTiIrdo8BRVcKjRbCMFFVc7GjMmB90AUi4yF1b6HX+GNnBOl7SP/NiSIyT0Hk6SgR/+uQQcrZJIAfFE5qCdlUheJxyOTy/h3gdwAQ+NzcnyW5Q9tkE3P0J7/z1FXQv3ejPG4jVnEevDLySWvbpHmXLlVSGgijSz8L+ix6JRuDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Anrjx85E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Anrjx85E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E131F0155D;
	Fri, 21 Aug 2026 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787331109;
	bh=DOyrmDmSLqx5mo/S7Mp1ZqmlvXiZ9+LLgMBgPuRZ35Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Anrjx85EyDUtAfh1BEWUL6SeAL1wTQMrMH8S3v5fDlxEMIcVHDsJPq4q4flT4GSYK
	 rZSyKXJN5XkRzgXnHz+MkhnNuycEBaWK8u0VHkZHSgJK3egsH23yu4+QrPJxh6mYnH
	 OvjPrNDBzjNTL8OUClK9Qu1ScLpJNdWLTMQAHbNXeXDGoqvcrmd7Vy07iaFfWlfBNw
	 sNif4rOIqb8nr+nSyGY6beamW4TnXgKsCKzgb5uMT3d+dKnrc4dq/NfDeTnYioBctG
	 h99jxghu3MgBqe9DHZQDlBiVQSGmOORKW7KrBTcZ7RjhaHCZYD22kcQMvwFdFogsGt
	 4UU69K1TcjShg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] inet: frags: add inet_frag_putn() helper
Date: Fri, 21 Aug 2026 12:51:43 -0400
Message-ID: <20260821165147.3593301-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081750-scion-darkened-b02a@gregkh>
References: <2026081750-scion-darkened-b02a@gregkh>
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
index 26506dd4b357d..3c988faa48ec2 100644
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
index 00a4a7ac0d322..5b38b414702a7 100644
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
index 66bd7e29f4c71..42a1f6b7acac2 100644
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
index aee6d8eee8c9f..ef07689cfb2a2 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -449,6 +449,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	struct frag_hdr *fhdr;
 	struct frag_queue *fq;
 	struct ipv6hdr *hdr;
+	int refs = 1;
 	u8 prevhdr;
 
 	/* Jumbo payload inhibits frag. header */
@@ -491,7 +492,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	}
 
 	spin_unlock_bh(&fq->q.lock);
-	inet_frag_put(&fq->q);
+	inet_frag_putn(&fq->q, refs);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nf_ct_frag6_gather);
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 225a23f7fefa7..8969b61779fc0 100644
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

