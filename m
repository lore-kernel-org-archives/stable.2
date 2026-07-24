Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E37F8003D
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856298; cv=none; b=QZswTv6fXQfktOgXv8Rc46QCvwRBAslBFQxUVSkC935a/uzYg9nTG2EPIkbhhsKiHp6s6LiUS128eI2AmnOCUWjDur3MV2VuU2C4XfI4NWSXj45IR4hNnQgSeZw5CoEuNyaR9MJhtcDKqOFmLWmMyOCU/TbMfSds46ebADAun+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856298; c=relaxed/simple;
	bh=jxLXNF7uLRj8GnRc3LPAJ+oKjiYSV3JmrD5XRoRG7tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOiVccr0ji4f4aSYUZaC4R4n4aDSszAfRZXcABM0Ako1pRZDcJxy/mw2GlI5mRvb8hGFOslX8CHwyAFrDnkTBbsAjFE3eHlCJlcEPO1YMgUcgFWTmA00nP7qQaL9t/c0Fjs03hxipfv+9F5FBuVj9KPjGVBwpM0VWNfRPsy3Bsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE38sxws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE38sxws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221301F00A3A;
	Fri, 24 Jul 2026 01:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856296;
	bh=Dzq2EvfShdVuARdLVRPPzd23k0Za3EmqdAmBzbX9pbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AE38sxwsJ+RnWGnAHe+tU5goEl6GdIEcK6gJIhwsF0Bnf/6uFu0/fiUBxvjUAcSM+
	 JQCb3bENfabTW0DiPuQhFCSglBmTe2OrPI6P3R5G8ErZEy27XDt0Li5hikcUB8UwRu
	 WSWOfWcasPhmcjyODYUp+5Z6Z/1/KbfI6Wu6r2opZ6WcssGtVwuiwhYtqn/yUsLAfU
	 8n9tjp57nBe68nueO6yEvoOQl0GLeJfBR4veU+GuKlSLBmqM9nUzb39ExhhNoknD8c
	 ftwiZFvJ969qJj6juq2Vd6Cse+Jeuf++gsgR20qByqkMaiHDeKGQ/IomDggI12EJiv
	 iqem4vLzuq8cQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/7] netfilter: nf_tables: drop unused 3rd argument from validate callback ops
Date: Thu, 23 Jul 2026 21:24:48 -0400
Message-ID: <20260724012453.3832653-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724012453.3832653-1-sashal@kernel.org>
References: <2026072054-refresh-tumble-391b@gregkh>
 <20260724012453.3832653-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit eaf9b2c875ece22768b78aa38da8b232e5de021b ]

Since commit a654de8fdc18 ("netfilter: nf_tables: fix chain dependency validation")
the validate() callback no longer needs the return pointer argument.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: d07955dd34ec ("netfilter: nft_fib: reject fib expression on the netdev egress hook")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h        | 3 +--
 include/net/netfilter/nft_fib.h          | 4 +---
 include/net/netfilter/nft_meta.h         | 3 +--
 include/net/netfilter/nft_reject.h       | 3 +--
 net/bridge/netfilter/nft_reject_bridge.c | 3 +--
 net/netfilter/nf_tables_api.c            | 3 +--
 net/netfilter/nft_compat.c               | 6 ++----
 net/netfilter/nft_fib.c                  | 3 +--
 net/netfilter/nft_flow_offload.c         | 3 +--
 net/netfilter/nft_fwd_netdev.c           | 3 +--
 net/netfilter/nft_immediate.c            | 3 +--
 net/netfilter/nft_lookup.c               | 3 +--
 net/netfilter/nft_masq.c                 | 3 +--
 net/netfilter/nft_meta.c                 | 6 ++----
 net/netfilter/nft_nat.c                  | 3 +--
 net/netfilter/nft_osf.c                  | 3 +--
 net/netfilter/nft_queue.c                | 3 +--
 net/netfilter/nft_redir.c                | 3 +--
 net/netfilter/nft_reject.c               | 3 +--
 net/netfilter/nft_reject_inet.c          | 3 +--
 net/netfilter/nft_reject_netdev.c        | 3 +--
 net/netfilter/nft_rt.c                   | 3 +--
 net/netfilter/nft_socket.c               | 3 +--
 net/netfilter/nft_synproxy.c             | 3 +--
 net/netfilter/nft_tproxy.c               | 3 +--
 net/netfilter/nft_xfrm.c                 | 3 +--
 26 files changed, 28 insertions(+), 57 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 166621818a405e..486b345a0241ae 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -932,8 +932,7 @@ struct nft_expr_ops {
 	int				(*dump)(struct sk_buff *skb,
 						const struct nft_expr *expr);
 	int				(*validate)(const struct nft_ctx *ctx,
-						    const struct nft_expr *expr,
-						    const struct nft_data **data);
+						    const struct nft_expr *expr);
 	bool				(*reduce)(struct nft_regs_track *track,
 						  const struct nft_expr *expr);
 	bool				(*gc)(struct net *net,
diff --git a/include/net/netfilter/nft_fib.h b/include/net/netfilter/nft_fib.h
index eed099eae672aa..fc6ee031b35c4b 100644
--- a/include/net/netfilter/nft_fib.h
+++ b/include/net/netfilter/nft_fib.h
@@ -21,9 +21,7 @@ nft_fib_is_loopback(const struct sk_buff *skb, const struct net_device *in)
 int nft_fib_dump(struct sk_buff *skb, const struct nft_expr *expr);
 int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		 const struct nlattr * const tb[]);
-int nft_fib_validate(const struct nft_ctx *ctx, const struct nft_expr *expr,
-		     const struct nft_data **data);
-
+int nft_fib_validate(const struct nft_ctx *ctx, const struct nft_expr *expr);
 
 void nft_fib4_eval_type(const struct nft_expr *expr, struct nft_regs *regs,
 			const struct nft_pktinfo *pkt);
diff --git a/include/net/netfilter/nft_meta.h b/include/net/netfilter/nft_meta.h
index 9b51cc67de5439..22e98ac336f7ed 100644
--- a/include/net/netfilter/nft_meta.h
+++ b/include/net/netfilter/nft_meta.h
@@ -41,8 +41,7 @@ void nft_meta_set_destroy(const struct nft_ctx *ctx,
 			  const struct nft_expr *expr);
 
 int nft_meta_set_validate(const struct nft_ctx *ctx,
-			  const struct nft_expr *expr,
-			  const struct nft_data **data);
+			  const struct nft_expr *expr);
 
 bool nft_meta_get_reduce(struct nft_regs_track *track,
 			 const struct nft_expr *expr);
diff --git a/include/net/netfilter/nft_reject.h b/include/net/netfilter/nft_reject.h
index 56b123a42220e0..bce67b3a42aa83 100644
--- a/include/net/netfilter/nft_reject.h
+++ b/include/net/netfilter/nft_reject.h
@@ -15,8 +15,7 @@ struct nft_reject {
 extern const struct nla_policy nft_reject_policy[];
 
 int nft_reject_validate(const struct nft_ctx *ctx,
-			const struct nft_expr *expr,
-			const struct nft_data **data);
+			const struct nft_expr *expr);
 
 int nft_reject_init(const struct nft_ctx *ctx,
 		    const struct nft_expr *expr,
diff --git a/net/bridge/netfilter/nft_reject_bridge.c b/net/bridge/netfilter/nft_reject_bridge.c
index 71b54fed7263df..1cb5c16e97b7fa 100644
--- a/net/bridge/netfilter/nft_reject_bridge.c
+++ b/net/bridge/netfilter/nft_reject_bridge.c
@@ -170,8 +170,7 @@ static void nft_reject_bridge_eval(const struct nft_expr *expr,
 }
 
 static int nft_reject_bridge_validate(const struct nft_ctx *ctx,
-				      const struct nft_expr *expr,
-				      const struct nft_data **data)
+				      const struct nft_expr *expr)
 {
 	return nft_chain_validate_hooks(ctx->chain, (1 << NF_BR_PRE_ROUTING) |
 						    (1 << NF_BR_LOCAL_IN));
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8b7e49996d0424..b6f74fa699f225 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3538,7 +3538,6 @@ static void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *r
 int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 {
 	struct nft_expr *expr, *last;
-	const struct nft_data *data;
 	struct nft_rule *rule;
 	int err;
 
@@ -3556,7 +3555,7 @@ int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 			/* This may call nft_chain_validate() recursively,
 			 * callers that do so must increment ctx->level.
 			 */
-			err = expr->ops->validate(ctx, expr, &data);
+			err = expr->ops->validate(ctx, expr);
 			if (err < 0)
 				return err;
 		}
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 37090ada8e8dee..e1ca7f453ed7b6 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -350,8 +350,7 @@ static int nft_target_dump(struct sk_buff *skb, const struct nft_expr *expr)
 }
 
 static int nft_target_validate(const struct nft_ctx *ctx,
-			       const struct nft_expr *expr,
-			       const struct nft_data **data)
+			       const struct nft_expr *expr)
 {
 	struct xt_target *target = expr->ops->data;
 	unsigned int hook_mask = 0;
@@ -610,8 +609,7 @@ static int nft_match_large_dump(struct sk_buff *skb, const struct nft_expr *e)
 }
 
 static int nft_match_validate(const struct nft_ctx *ctx,
-			      const struct nft_expr *expr,
-			      const struct nft_data **data)
+			      const struct nft_expr *expr)
 {
 	struct xt_match *match = expr->ops->data;
 	unsigned int hook_mask = 0;
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 7a92a5e5508fdf..60913a97a47f2e 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -25,8 +25,7 @@ EXPORT_SYMBOL(nft_fib_policy);
 			NFTA_FIB_F_MARK | NFTA_FIB_F_IIF | NFTA_FIB_F_OIF | \
 			NFTA_FIB_F_PRESENT)
 
-int nft_fib_validate(const struct nft_ctx *ctx, const struct nft_expr *expr,
-		     const struct nft_data **data)
+int nft_fib_validate(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
 	const struct nft_fib *priv = nft_expr_priv(expr);
 	unsigned int hooks;
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 786519740b5595..6bdafe91bc786a 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -392,8 +392,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 }
 
 static int nft_flow_offload_validate(const struct nft_ctx *ctx,
-				     const struct nft_expr *expr,
-				     const struct nft_data **data)
+				     const struct nft_expr *expr)
 {
 	unsigned int hook_mask = (1 << NF_INET_FORWARD);
 
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 0a551c16020379..d1afebeef35413 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -212,8 +212,7 @@ static int nft_fwd_neigh_dump(struct sk_buff *skb, const struct nft_expr *expr)
 }
 
 static int nft_fwd_validate(const struct nft_ctx *ctx,
-			    const struct nft_expr *expr,
-			    const struct nft_data **data)
+			    const struct nft_expr *expr)
 {
 	return nft_chain_validate_hooks(ctx->chain, (1 << NF_NETDEV_INGRESS) |
 						    (1 << NF_NETDEV_EGRESS));
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 731511d58b7caf..44d56424184728 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -243,8 +243,7 @@ static int nft_immediate_dump(struct sk_buff *skb, const struct nft_expr *expr)
 }
 
 static int nft_immediate_validate(const struct nft_ctx *ctx,
-				  const struct nft_expr *expr,
-				  const struct nft_data **d)
+				  const struct nft_expr *expr)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
 	struct nft_ctx *pctx = (struct nft_ctx *)ctx;
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index a1ec9dcdc29879..fb4c129c63d302 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -200,8 +200,7 @@ static int nft_lookup_dump(struct sk_buff *skb, const struct nft_expr *expr)
 }
 
 static int nft_lookup_validate(const struct nft_ctx *ctx,
-			       const struct nft_expr *expr,
-			       const struct nft_data **d)
+			       const struct nft_expr *expr)
 {
 	const struct nft_lookup *priv = nft_expr_priv(expr);
 	struct nft_set_iter iter;
diff --git a/net/netfilter/nft_masq.c b/net/netfilter/nft_masq.c
index 93bc2851acb49f..b38f455a6c99a2 100644
--- a/net/netfilter/nft_masq.c
+++ b/net/netfilter/nft_masq.c
@@ -26,8 +26,7 @@ static const struct nla_policy nft_masq_policy[NFTA_MASQ_MAX + 1] = {
 };
 
 static int nft_masq_validate(const struct nft_ctx *ctx,
-			     const struct nft_expr *expr,
-			     const struct nft_data **data)
+			     const struct nft_expr *expr)
 {
 	int err;
 
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 54f377b7ce074d..671923f4d9eb91 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -581,8 +581,7 @@ static int nft_meta_get_validate_xfrm(const struct nft_ctx *ctx)
 }
 
 static int nft_meta_get_validate(const struct nft_ctx *ctx,
-				 const struct nft_expr *expr,
-				 const struct nft_data **data)
+				 const struct nft_expr *expr)
 {
 	const struct nft_meta *priv = nft_expr_priv(expr);
 
@@ -600,8 +599,7 @@ static int nft_meta_get_validate(const struct nft_ctx *ctx,
 }
 
 int nft_meta_set_validate(const struct nft_ctx *ctx,
-			  const struct nft_expr *expr,
-			  const struct nft_data **data)
+			  const struct nft_expr *expr)
 {
 	struct nft_meta *priv = nft_expr_priv(expr);
 	unsigned int hooks;
diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index fed4f88cf9e7d1..4b855c277f5cc5 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -136,8 +136,7 @@ static const struct nla_policy nft_nat_policy[NFTA_NAT_MAX + 1] = {
 };
 
 static int nft_nat_validate(const struct nft_ctx *ctx,
-			    const struct nft_expr *expr,
-			    const struct nft_data **data)
+			    const struct nft_expr *expr)
 {
 	struct nft_nat *priv = nft_expr_priv(expr);
 	int err;
diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index 9bf2dfd351846e..c8184264910552 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -117,8 +117,7 @@ static int nft_osf_dump(struct sk_buff *skb, const struct nft_expr *expr)
 }
 
 static int nft_osf_validate(const struct nft_ctx *ctx,
-			    const struct nft_expr *expr,
-			    const struct nft_data **data)
+			    const struct nft_expr *expr)
 {
 	unsigned int hooks;
 
diff --git a/net/netfilter/nft_queue.c b/net/netfilter/nft_queue.c
index c6a13ef03ea122..5fb9e89d929d2a 100644
--- a/net/netfilter/nft_queue.c
+++ b/net/netfilter/nft_queue.c
@@ -69,8 +69,7 @@ static void nft_queue_sreg_eval(const struct nft_expr *expr,
 }
 
 static int nft_queue_validate(const struct nft_ctx *ctx,
-			      const struct nft_expr *expr,
-			      const struct nft_data **data)
+			      const struct nft_expr *expr)
 {
 	static const unsigned int supported_hooks = ((1 << NF_INET_PRE_ROUTING) |
 						     (1 << NF_INET_LOCAL_IN) |
diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index 98ab0533051824..ffde20e5cb5ebf 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -26,8 +26,7 @@ static const struct nla_policy nft_redir_policy[NFTA_REDIR_MAX + 1] = {
 };
 
 static int nft_redir_validate(const struct nft_ctx *ctx,
-			      const struct nft_expr *expr,
-			      const struct nft_data **data)
+			      const struct nft_expr *expr)
 {
 	int err;
 
diff --git a/net/netfilter/nft_reject.c b/net/netfilter/nft_reject.c
index 927ff8459bd90e..3ef8c41d6876be 100644
--- a/net/netfilter/nft_reject.c
+++ b/net/netfilter/nft_reject.c
@@ -24,8 +24,7 @@ const struct nla_policy nft_reject_policy[NFTA_REJECT_MAX + 1] = {
 EXPORT_SYMBOL_GPL(nft_reject_policy);
 
 int nft_reject_validate(const struct nft_ctx *ctx,
-			const struct nft_expr *expr,
-			const struct nft_data **data)
+			const struct nft_expr *expr)
 {
 	return nft_chain_validate_hooks(ctx->chain,
 					(1 << NF_INET_LOCAL_IN) |
diff --git a/net/netfilter/nft_reject_inet.c b/net/netfilter/nft_reject_inet.c
index 973fa31a9dd6cd..49020e67304ad7 100644
--- a/net/netfilter/nft_reject_inet.c
+++ b/net/netfilter/nft_reject_inet.c
@@ -61,8 +61,7 @@ static void nft_reject_inet_eval(const struct nft_expr *expr,
 }
 
 static int nft_reject_inet_validate(const struct nft_ctx *ctx,
-				    const struct nft_expr *expr,
-				    const struct nft_data **data)
+				    const struct nft_expr *expr)
 {
 	return nft_chain_validate_hooks(ctx->chain,
 					(1 << NF_INET_LOCAL_IN) |
diff --git a/net/netfilter/nft_reject_netdev.c b/net/netfilter/nft_reject_netdev.c
index 7865cd8b11bb6a..2558ce1505d989 100644
--- a/net/netfilter/nft_reject_netdev.c
+++ b/net/netfilter/nft_reject_netdev.c
@@ -145,8 +145,7 @@ static void nft_reject_netdev_eval(const struct nft_expr *expr,
 }
 
 static int nft_reject_netdev_validate(const struct nft_ctx *ctx,
-				      const struct nft_expr *expr,
-				      const struct nft_data **data)
+				      const struct nft_expr *expr)
 {
 	return nft_chain_validate_hooks(ctx->chain, (1 << NF_NETDEV_INGRESS));
 }
diff --git a/net/netfilter/nft_rt.c b/net/netfilter/nft_rt.c
index 7d21e16499bfa1..ab507cf86e5835 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -160,8 +160,7 @@ static int nft_rt_get_dump(struct sk_buff *skb,
 	return -1;
 }
 
-static int nft_rt_validate(const struct nft_ctx *ctx, const struct nft_expr *expr,
-			   const struct nft_data **data)
+static int nft_rt_validate(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
 	const struct nft_rt *priv = nft_expr_priv(expr);
 	unsigned int hooks;
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 2d33674e9e5e90..f56953f1022eb5 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -275,8 +275,7 @@ static bool nft_socket_reduce(struct nft_regs_track *track,
 }
 
 static int nft_socket_validate(const struct nft_ctx *ctx,
-			       const struct nft_expr *expr,
-			       const struct nft_data **data)
+			       const struct nft_expr *expr)
 {
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index 0cc638553aef2b..10748572c075bc 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -248,8 +248,7 @@ static void nft_synproxy_eval(const struct nft_expr *expr,
 }
 
 static int nft_synproxy_validate(const struct nft_ctx *ctx,
-				 const struct nft_expr *expr,
-				 const struct nft_data **data)
+				 const struct nft_expr *expr)
 {
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index f066e09c8d1e19..b848539f72a86c 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -313,8 +313,7 @@ static int nft_tproxy_dump(struct sk_buff *skb,
 }
 
 static int nft_tproxy_validate(const struct nft_ctx *ctx,
-			       const struct nft_expr *expr,
-			       const struct nft_data **data)
+			       const struct nft_expr *expr)
 {
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
diff --git a/net/netfilter/nft_xfrm.c b/net/netfilter/nft_xfrm.c
index 30259846c3525d..34a37699f90f7f 100644
--- a/net/netfilter/nft_xfrm.c
+++ b/net/netfilter/nft_xfrm.c
@@ -229,8 +229,7 @@ static int nft_xfrm_get_dump(struct sk_buff *skb,
 	return 0;
 }
 
-static int nft_xfrm_validate(const struct nft_ctx *ctx, const struct nft_expr *expr,
-			     const struct nft_data **data)
+static int nft_xfrm_validate(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
 	const struct nft_xfrm *priv = nft_expr_priv(expr);
 	unsigned int hooks;
-- 
2.53.0

