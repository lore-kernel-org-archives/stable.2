Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622489;
	b=RHbCJW6b3C60GVCQp4H79V/a4IHyuunM1CXEo5L7bMWrez3E1WlhunrnWzPf+41gqf6W
	 X/Cy00ryaLkekjIVh4Z3jtJbfM2LVyJRXvpIoMoswicTK1mlFgXNClfdKLD91qzq2ezoN
	 5o2A+co45WOY/+e+Z/cprdk5HWTe+l4i1p0vwBQoxcmXESZ8a7AWLJfM9wF1rccf7g1B/
	 23MBxHTBpUjkRjQCg15zsSNGMqeUlfkqSJtrPpGiAYOAmMd8gq6XdhsOqYp64pCYqIhPL
	 XP5k+SC6+n+WhjyG4oVLyJmlplb7veR464HMavVaVkZaHUPZxtYJx/TS+AamLKpNGqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L4VhBun6s8kbKNduBM3HIL9aT4xNmBD9qwEyHJ8ijlA=;
	b=lFCRKZUX3VcwtSy/P60eZbNJcGqdzB86zp5hLbZI6p0WSUETvIWi7aVuSJYHM7KLOCNb
	 STXXbDiXEzz2JjEdjKWEbHFoSELERM2moVLmVtBGgNtFPt3SaJhngLI8/zItpjPd+jUd0
	 MlNKGxOT4GTDIEcu/YCyyMlolL3KAAmhK7drC+dbiqNEirbq7inP0ZjU5bnbmV4JzNMsF
	 PAVcR4kwbP2TbfFVhxHSXwkxIav/pJ/gpkHTHUUMVjkOZ5JuPmtiaSWJBxORGvV9yHgUM
	 E+a0xt6AHKrsGpEHFdS1ZJ7GOqHxLivU675x+M5jVvO92WB1uAFrNpk2i6muNuBsJXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NiG2yu/C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EF606A331
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiG2yu/C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB6D1F000CF;
	Wed, 25 Nov 2026 16:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622488;
	bh=L4VhBun6s8kbKNduBM3HIL9aT4xNmBD9qwEyHJ8ijlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NiG2yu/Cor1K3UPv+iTc/rBoVsvHebjQreDuhfwiPv1twxLE76YhWCr6wf1gFEg9t
	 uNA/cenGIZtGGnaMPjfuLOmEMzVCNVUCdo9TESBxxmw6eWhIAe3uzexqq7t/vg4TKR
	 knjPoUX+Grw9brZpA9PoX3ltBccLw2dgWvy9FMm/ixAIcngDfM3npXPDinVG7++W5H
	 szaXksFRpPqlL2Wyvp1SAVSBd7alVCRWUTrukumqBy7i/rAGUzkEi42C+atdHx8Xxl
	 9HCrzrG2DvMbzHZp4pSfOV3LPnCHU7I/8XtGf3kgASYyB99iejK5pA/JyY2PdSKE06
	 Zxr84TsnvFZow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] netfilter: nf_dup{4, 6}: Move duplication check to task_struct
Date: Wed, 25 Nov 2026 11:01:21 -0500
Message-ID: <20261125160115.575356-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125160115.575356-1-sashal@kernel.org>
References: <2026112501-gilled-capsize-0004@gregkh>
 <20261125160115.575356-1-sashal@kernel.org>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit a1f1acb9c5db9b385c9b3eb1f27f897c06df49ae ]

nf_skb_duplicated is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Due to the recursion involved, the simplest change is to make it a
per-task variable.

Move the per-CPU variable nf_skb_duplicated to task_struct and name it
in_nf_duplicate. Add it to the existing bitfield so it doesn't use
additional memory.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 82052e5b5ec3 ("netfilter: nf_dup: preserve guard across NFQUEUE reinjection")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netfilter.h        | 11 -----------
 include/linux/sched.h            |  1 +
 net/ipv4/netfilter/ip_tables.c   |  2 +-
 net/ipv4/netfilter/nf_dup_ipv4.c |  6 +++---
 net/ipv6/netfilter/ip6_tables.c  |  2 +-
 net/ipv6/netfilter/nf_dup_ipv6.c |  6 +++---
 net/netfilter/core.c             |  3 ---
 7 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 9b3357d8d8c3e..3ca1996a6daba 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -499,17 +499,6 @@ struct nf_defrag_hook {
 extern const struct nf_defrag_hook __rcu *nf_defrag_v4_hook;
 extern const struct nf_defrag_hook __rcu *nf_defrag_v6_hook;
 
-/*
- * nf_skb_duplicated - TEE target has sent a packet
- *
- * When a xtables target sends a packet, the OUTPUT and POSTROUTING
- * hooks are traversed again, i.e. nft and xtables are invoked recursively.
- *
- * This is used by xtables TEE target to prevent the duplicated skb from
- * being duplicated again.
- */
-DECLARE_PER_CPU(bool, nf_skb_duplicated);
-
 /*
  * Contains bitmask of ctnetlink event subscribers, if any.
  * Can't be pernet due to NETLINK_LISTEN_ALL_NSID setsockopt flag.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index efee6139c6af6..139735e265c5d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1021,6 +1021,7 @@ struct task_struct {
 	/* delay due to memory thrashing */
 	unsigned                        in_thrashing:1;
 #endif
+	unsigned			in_nf_duplicate:1;
 #ifdef CONFIG_PREEMPT_RT
 	struct netdev_xmit		net_xmit;
 #endif
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 4320f67df7baa..412419a249dad 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -270,7 +270,7 @@ ipt_do_table(void *priv,
 	 * but it is no problem since absolute verdict is issued by these.
 	 */
 	if (static_key_false(&xt_tee_enabled))
-		jumpstack += private->stacksize * __this_cpu_read(nf_skb_duplicated);
+		jumpstack += private->stacksize * current->in_nf_duplicate;
 
 	e = get_entry(table_base, private->hook_entry[hook]);
 
diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_ipv4.c
index ec94ee1051c77..d11d7e2e1307b 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -54,7 +54,7 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	struct iphdr *iph;
 
 	local_bh_disable();
-	if (this_cpu_read(nf_skb_duplicated))
+	if (current->in_nf_duplicate)
 		goto out;
 	/*
 	 * Copy the skb, and route the copy. Will later return %XT_CONTINUE for
@@ -86,9 +86,9 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 		--iph->ttl;
 
 	if (nf_dup_ipv4_route(net, skb, gw, oif)) {
-		__this_cpu_write(nf_skb_duplicated, true);
+		current->in_nf_duplicate = true;
 		ip_local_out(net, skb->sk, skb);
-		__this_cpu_write(nf_skb_duplicated, false);
+		current->in_nf_duplicate = false;
 	} else {
 		kfree_skb(skb);
 	}
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index fb375ce7f916d..9110392c83f6d 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -292,7 +292,7 @@ ip6t_do_table(void *priv, struct sk_buff *skb,
 	 * but it is no problem since absolute verdict is issued by these.
 	 */
 	if (static_key_false(&xt_tee_enabled))
-		jumpstack += private->stacksize * __this_cpu_read(nf_skb_duplicated);
+		jumpstack += private->stacksize * current->in_nf_duplicate;
 
 	e = get_entry(table_base, private->hook_entry[hook]);
 
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
index a8bb04bd94cf2..6da3102b7c1b3 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -48,7 +48,7 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 		 const struct in6_addr *gw, int oif)
 {
 	local_bh_disable();
-	if (this_cpu_read(nf_skb_duplicated))
+	if (current->in_nf_duplicate)
 		goto out;
 	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (skb == NULL)
@@ -64,9 +64,9 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 		--iph->hop_limit;
 	}
 	if (nf_dup_ipv6_route(net, skb, gw, oif)) {
-		__this_cpu_write(nf_skb_duplicated, true);
+		current->in_nf_duplicate = true;
 		ip6_local_out(net, skb->sk, skb);
-		__this_cpu_write(nf_skb_duplicated, false);
+		current->in_nf_duplicate = false;
 	} else {
 		kfree_skb(skb);
 	}
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index f8346fee36b6b..49694f4b1baa4 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -31,9 +31,6 @@
 const struct nf_ipv6_ops __rcu *nf_ipv6_ops __read_mostly;
 EXPORT_SYMBOL_GPL(nf_ipv6_ops);
 
-DEFINE_PER_CPU(bool, nf_skb_duplicated);
-EXPORT_SYMBOL_GPL(nf_skb_duplicated);
-
 #ifdef CONFIG_JUMP_LABEL
 struct static_key nf_hooks_needed[NFPROTO_NUMPROTO][NF_MAX_HOOKS];
 EXPORT_SYMBOL(nf_hooks_needed);
-- 
2.53.0

