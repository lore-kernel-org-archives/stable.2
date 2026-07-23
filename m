Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762773B14AF
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836730; cv=none; b=D7ESPDKCaL1XhxtlP1nMKSu3xiq0pwgCv83OrTo/sPwQfy8sIFeGfFiX/gQte351Ofm5u/ZfNywhG9VJrcHz13mIhYf50nis9PohZ8xd9+xDSB6H1NEn3MpmrPHeBfVeEct7q8/UrmH5gnyCFdrgsHzPd8Fm2ykz7S+OW2Rx5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836730; c=relaxed/simple;
	bh=2lDItnn3Tj6Y83q8pw61TCfnob4RjKLBgAtrEmZ8vNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4WNXjX+inLevKFISxhVa9bxL2BWWFHlwPoPkMuX0vqccIRosm5yzHenvlqIeBUR5khLYLiB8Tg9ESGQ3W/iz3k9OfGT5Av/9WvcH9F5o5IGsV26KYJ/8gf9TiUxCrH1kf2tpUDZVxZqIbK2u+7vm8CNLL15C49r8P0j4APbVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5/TwHGG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5/TwHGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891781F00A3A;
	Thu, 23 Jul 2026 19:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784836726;
	bh=4+5+wTxhgCYqUGQSypUeY6j+FuWB0XRoCmNN5doH3iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X5/TwHGGwFhjVh3MMytdOeUn6UUCct8QJaSpNn9avNZTW+w0Tm8sPvuq3Wplm4cVQ
	 YN3p6zdM1u9StjnYI6xUIhkF0grxRQ0QLt2Q7BWealEdRMQ/WAqD1A5z5rfMeUY9Eb
	 JkK63W6YQqO5UMmupEJH3PaOR26WmD6R6dC7htbUmWmhpR+FSHdH/xdkms7itRvGAk
	 bJd/H0E8eUVbFHFpmMSGokmPAwnR+M4mf6e83h1d2Mb2uL6hlZQqMXvfJDK/jPO8qC
	 tqcRmTJviAHqIs7JnS/6HU+t3attxMOPElAGu4aCx1jYzN31QH9NjQT4qLxZlybGvR
	 Bt4n8mQxVMJjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] netfilter: nf_tables: remove register tracking infrastructure
Date: Thu, 23 Jul 2026 15:58:41 -0400
Message-ID: <20260723195842.3683768-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723195842.3683768-1-sashal@kernel.org>
References: <2026072054-folic-tartly-6b52@gregkh>
 <20260723195842.3683768-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 6b94d081f81dd524626f7aab2b98a9de335edb72 ]

This facility was disabled in commit
9e539c5b6d9c ("netfilter: nf_tables: disable expression reduction infra"),
because not all nft_exprs guarantee they will update the destination
register: some may set NFT_BREAK instead to cancel evaluation of the
rule.

This has been dead code ever since.
There are no plans to salvage this at this time, so remove this.

Signed-off-by: Florian Westphal <fw@strlen.de>
Link: https://patch.msgid.link/20260224205048.4718-10-fw@strlen.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: d07955dd34ec ("netfilter: nft_fib: reject fib expression on the netdev egress hook")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h        |  32 -------
 include/net/netfilter/nft_fib.h          |   2 -
 include/net/netfilter/nft_meta.h         |   3 -
 net/bridge/netfilter/nft_meta_bridge.c   |  20 -----
 net/bridge/netfilter/nft_reject_bridge.c |   1 -
 net/ipv4/netfilter/nft_dup_ipv4.c        |   1 -
 net/ipv4/netfilter/nft_fib_ipv4.c        |   2 -
 net/ipv4/netfilter/nft_reject_ipv4.c     |   1 -
 net/ipv6/netfilter/nft_dup_ipv6.c        |   1 -
 net/ipv6/netfilter/nft_fib_ipv6.c        |   2 -
 net/ipv6/netfilter/nft_reject_ipv6.c     |   1 -
 net/netfilter/nf_tables_api.c            |  67 ---------------
 net/netfilter/nft_bitwise.c              | 104 -----------------------
 net/netfilter/nft_byteorder.c            |  11 ---
 net/netfilter/nft_cmp.c                  |   3 -
 net/netfilter/nft_compat.c               |  10 ---
 net/netfilter/nft_connlimit.c            |   1 -
 net/netfilter/nft_counter.c              |   1 -
 net/netfilter/nft_ct.c                   |  46 ----------
 net/netfilter/nft_dup_netdev.c           |   1 -
 net/netfilter/nft_dynset.c               |   1 -
 net/netfilter/nft_exthdr.c               |  34 --------
 net/netfilter/nft_fib.c                  |  42 ---------
 net/netfilter/nft_fib_inet.c             |   1 -
 net/netfilter/nft_fib_netdev.c           |   1 -
 net/netfilter/nft_flow_offload.c         |   1 -
 net/netfilter/nft_fwd_netdev.c           |   2 -
 net/netfilter/nft_hash.c                 |  36 --------
 net/netfilter/nft_immediate.c            |  12 ---
 net/netfilter/nft_last.c                 |   1 -
 net/netfilter/nft_limit.c                |   2 -
 net/netfilter/nft_log.c                  |   1 -
 net/netfilter/nft_lookup.c               |  12 ---
 net/netfilter/nft_masq.c                 |   3 -
 net/netfilter/nft_meta.c                 |  45 ----------
 net/netfilter/nft_nat.c                  |   2 -
 net/netfilter/nft_numgen.c               |  22 -----
 net/netfilter/nft_objref.c               |   2 -
 net/netfilter/nft_osf.c                  |  25 ------
 net/netfilter/nft_payload.c              |  47 ----------
 net/netfilter/nft_queue.c                |   2 -
 net/netfilter/nft_quota.c                |   1 -
 net/netfilter/nft_range.c                |   1 -
 net/netfilter/nft_redir.c                |   3 -
 net/netfilter/nft_reject_inet.c          |   1 -
 net/netfilter/nft_reject_netdev.c        |   1 -
 net/netfilter/nft_rt.c                   |   1 -
 net/netfilter/nft_socket.c               |  26 ------
 net/netfilter/nft_synproxy.c             |   1 -
 net/netfilter/nft_tproxy.c               |   1 -
 net/netfilter/nft_tunnel.c               |  26 ------
 net/netfilter/nft_xfrm.c                 |  27 ------
 52 files changed, 693 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index ca1e40803074d6..aac4e1c5430088 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -123,17 +123,6 @@ struct nft_regs {
 	};
 };
 
-struct nft_regs_track {
-	struct {
-		const struct nft_expr		*selector;
-		const struct nft_expr		*bitwise;
-		u8				num_reg;
-	} regs[NFT_REG32_NUM];
-
-	const struct nft_expr			*cur;
-	const struct nft_expr			*last;
-};
-
 /* Store/load an u8, u16 or u64 integer to/from the u32 data register.
  *
  * Note, when using concatenations, register allocation happens at 32-bit
@@ -420,8 +409,6 @@ int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src, gfp_t gfp);
 void nft_expr_destroy(const struct nft_ctx *ctx, struct nft_expr *expr);
 int nft_expr_dump(struct sk_buff *skb, unsigned int attr,
 		  const struct nft_expr *expr, bool reset);
-bool nft_expr_reduce_bitwise(struct nft_regs_track *track,
-			     const struct nft_expr *expr);
 
 struct nft_set_ext;
 
@@ -933,7 +920,6 @@ struct nft_offload_ctx;
  *	@destroy_clone: destruction clone function
  *	@dump: function to dump parameters
  *	@validate: validate expression, called during loop detection
- *	@reduce: reduce expression
  *	@gc: garbage collection expression
  *	@offload: hardware offload expression
  *	@offload_action: function to report true/false to allocate one slot or not in the flow
@@ -967,8 +953,6 @@ struct nft_expr_ops {
 						bool reset);
 	int				(*validate)(const struct nft_ctx *ctx,
 						    const struct nft_expr *expr);
-	bool				(*reduce)(struct nft_regs_track *track,
-						  const struct nft_expr *expr);
 	bool				(*gc)(struct net *net,
 					      const struct nft_expr *expr);
 	int				(*offload)(struct nft_offload_ctx *ctx,
@@ -1848,20 +1832,4 @@ static inline u64 nft_net_tstamp(const struct net *net)
 	return nft_pernet(net)->tstamp;
 }
 
-#define __NFT_REDUCE_READONLY	1UL
-#define NFT_REDUCE_READONLY	(void *)__NFT_REDUCE_READONLY
-
-void nft_reg_track_update(struct nft_regs_track *track,
-			  const struct nft_expr *expr, u8 dreg, u8 len);
-void nft_reg_track_cancel(struct nft_regs_track *track, u8 dreg, u8 len);
-void __nft_reg_track_cancel(struct nft_regs_track *track, u8 dreg);
-
-static inline bool nft_reg_track_cmp(struct nft_regs_track *track,
-				     const struct nft_expr *expr, u8 dreg)
-{
-	return track->regs[dreg].selector &&
-	       track->regs[dreg].selector->ops == expr->ops &&
-	       track->regs[dreg].num_reg == 0;
-}
-
 #endif /* _NET_NF_TABLES_H */
diff --git a/include/net/netfilter/nft_fib.h b/include/net/netfilter/nft_fib.h
index 38cae7113de462..6147d37c88895b 100644
--- a/include/net/netfilter/nft_fib.h
+++ b/include/net/netfilter/nft_fib.h
@@ -36,6 +36,4 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 void nft_fib_store_result(void *reg, const struct nft_fib *priv,
 			  const struct net_device *dev);
 
-bool nft_fib_reduce(struct nft_regs_track *track,
-		    const struct nft_expr *expr);
 #endif
diff --git a/include/net/netfilter/nft_meta.h b/include/net/netfilter/nft_meta.h
index d602263590fed5..f74e63290603d9 100644
--- a/include/net/netfilter/nft_meta.h
+++ b/include/net/netfilter/nft_meta.h
@@ -43,9 +43,6 @@ void nft_meta_set_destroy(const struct nft_ctx *ctx,
 int nft_meta_set_validate(const struct nft_ctx *ctx,
 			  const struct nft_expr *expr);
 
-bool nft_meta_get_reduce(struct nft_regs_track *track,
-			 const struct nft_expr *expr);
-
 struct nft_inner_tun_ctx;
 void nft_meta_inner_eval(const struct nft_expr *expr,
 			 struct nft_regs *regs, const struct nft_pktinfo *pkt,
diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index d12a221366d60c..f184e61839d6ab 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -102,7 +102,6 @@ static const struct nft_expr_ops nft_meta_bridge_get_ops = {
 	.eval		= nft_meta_bridge_get_eval,
 	.init		= nft_meta_bridge_get_init,
 	.dump		= nft_meta_get_dump,
-	.reduce		= nft_meta_get_reduce,
 };
 
 static void nft_meta_bridge_set_eval(const struct nft_expr *expr,
@@ -149,24 +148,6 @@ static int nft_meta_bridge_set_init(const struct nft_ctx *ctx,
 	return 0;
 }
 
-static bool nft_meta_bridge_set_reduce(struct nft_regs_track *track,
-				       const struct nft_expr *expr)
-{
-	int i;
-
-	for (i = 0; i < NFT_REG32_NUM; i++) {
-		if (!track->regs[i].selector)
-			continue;
-
-		if (track->regs[i].selector->ops != &nft_meta_bridge_get_ops)
-			continue;
-
-		__nft_reg_track_cancel(track, i);
-	}
-
-	return false;
-}
-
 static int nft_meta_bridge_set_validate(const struct nft_ctx *ctx,
 					const struct nft_expr *expr)
 {
@@ -191,7 +172,6 @@ static const struct nft_expr_ops nft_meta_bridge_set_ops = {
 	.init		= nft_meta_bridge_set_init,
 	.destroy	= nft_meta_set_destroy,
 	.dump		= nft_meta_set_dump,
-	.reduce		= nft_meta_bridge_set_reduce,
 	.validate	= nft_meta_bridge_set_validate,
 };
 
diff --git a/net/bridge/netfilter/nft_reject_bridge.c b/net/bridge/netfilter/nft_reject_bridge.c
index 1cb5c16e97b7fa..cd2b04236a99ca 100644
--- a/net/bridge/netfilter/nft_reject_bridge.c
+++ b/net/bridge/netfilter/nft_reject_bridge.c
@@ -184,7 +184,6 @@ static const struct nft_expr_ops nft_reject_bridge_ops = {
 	.init		= nft_reject_init,
 	.dump		= nft_reject_dump,
 	.validate	= nft_reject_bridge_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_reject_bridge_type __read_mostly = {
diff --git a/net/ipv4/netfilter/nft_dup_ipv4.c b/net/ipv4/netfilter/nft_dup_ipv4.c
index ef5dd88107ddbb..d53a65ddbd7b73 100644
--- a/net/ipv4/netfilter/nft_dup_ipv4.c
+++ b/net/ipv4/netfilter/nft_dup_ipv4.c
@@ -76,7 +76,6 @@ static const struct nft_expr_ops nft_dup_ipv4_ops = {
 	.eval		= nft_dup_ipv4_eval,
 	.init		= nft_dup_ipv4_init,
 	.dump		= nft_dup_ipv4_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nla_policy nft_dup_ipv4_policy[NFTA_DUP_MAX + 1] = {
diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index 94931d52048f11..73f0446020faf2 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -157,7 +157,6 @@ static const struct nft_expr_ops nft_fib4_type_ops = {
 	.init		= nft_fib_init,
 	.dump		= nft_fib_dump,
 	.validate	= nft_fib_validate,
-	.reduce		= nft_fib_reduce,
 };
 
 static const struct nft_expr_ops nft_fib4_ops = {
@@ -167,7 +166,6 @@ static const struct nft_expr_ops nft_fib4_ops = {
 	.init		= nft_fib_init,
 	.dump		= nft_fib_dump,
 	.validate	= nft_fib_validate,
-	.reduce		= nft_fib_reduce,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/ipv4/netfilter/nft_reject_ipv4.c b/net/ipv4/netfilter/nft_reject_ipv4.c
index 6cb213bb7256a8..55fc23a8f7a706 100644
--- a/net/ipv4/netfilter/nft_reject_ipv4.c
+++ b/net/ipv4/netfilter/nft_reject_ipv4.c
@@ -45,7 +45,6 @@ static const struct nft_expr_ops nft_reject_ipv4_ops = {
 	.init		= nft_reject_init,
 	.dump		= nft_reject_dump,
 	.validate	= nft_reject_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_reject_ipv4_type __read_mostly = {
diff --git a/net/ipv6/netfilter/nft_dup_ipv6.c b/net/ipv6/netfilter/nft_dup_ipv6.c
index 492a811828a71b..95ec27b3971c11 100644
--- a/net/ipv6/netfilter/nft_dup_ipv6.c
+++ b/net/ipv6/netfilter/nft_dup_ipv6.c
@@ -74,7 +74,6 @@ static const struct nft_expr_ops nft_dup_ipv6_ops = {
 	.eval		= nft_dup_ipv6_eval,
 	.init		= nft_dup_ipv6_init,
 	.dump		= nft_dup_ipv6_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nla_policy nft_dup_ipv6_policy[NFTA_DUP_MAX + 1] = {
diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index da4a35c20f1017..d600fd2d45a469 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -226,7 +226,6 @@ static const struct nft_expr_ops nft_fib6_type_ops = {
 	.init		= nft_fib_init,
 	.dump		= nft_fib_dump,
 	.validate	= nft_fib_validate,
-	.reduce		= nft_fib_reduce,
 };
 
 static const struct nft_expr_ops nft_fib6_ops = {
@@ -236,7 +235,6 @@ static const struct nft_expr_ops nft_fib6_ops = {
 	.init		= nft_fib_init,
 	.dump		= nft_fib_dump,
 	.validate	= nft_fib_validate,
-	.reduce		= nft_fib_reduce,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/ipv6/netfilter/nft_reject_ipv6.c b/net/ipv6/netfilter/nft_reject_ipv6.c
index 5c61294f410ee1..ed69c768797ec6 100644
--- a/net/ipv6/netfilter/nft_reject_ipv6.c
+++ b/net/ipv6/netfilter/nft_reject_ipv6.c
@@ -46,7 +46,6 @@ static const struct nft_expr_ops nft_reject_ipv6_ops = {
 	.init		= nft_reject_init,
 	.dump		= nft_reject_dump,
 	.validate	= nft_reject_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_reject_ipv6_type __read_mostly = {
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c39fd25a9c9755..fb469623f9cf6c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -754,58 +754,6 @@ static int nft_delflowtable(struct nft_ctx *ctx,
 	return 0;
 }
 
-static void __nft_reg_track_clobber(struct nft_regs_track *track, u8 dreg)
-{
-	int i;
-
-	for (i = track->regs[dreg].num_reg; i > 0; i--)
-		__nft_reg_track_cancel(track, dreg - i);
-}
-
-static void __nft_reg_track_update(struct nft_regs_track *track,
-				   const struct nft_expr *expr,
-				   u8 dreg, u8 num_reg)
-{
-	track->regs[dreg].selector = expr;
-	track->regs[dreg].bitwise = NULL;
-	track->regs[dreg].num_reg = num_reg;
-}
-
-void nft_reg_track_update(struct nft_regs_track *track,
-			  const struct nft_expr *expr, u8 dreg, u8 len)
-{
-	unsigned int regcount;
-	int i;
-
-	__nft_reg_track_clobber(track, dreg);
-
-	regcount = DIV_ROUND_UP(len, NFT_REG32_SIZE);
-	for (i = 0; i < regcount; i++, dreg++)
-		__nft_reg_track_update(track, expr, dreg, i);
-}
-EXPORT_SYMBOL_GPL(nft_reg_track_update);
-
-void nft_reg_track_cancel(struct nft_regs_track *track, u8 dreg, u8 len)
-{
-	unsigned int regcount;
-	int i;
-
-	__nft_reg_track_clobber(track, dreg);
-
-	regcount = DIV_ROUND_UP(len, NFT_REG32_SIZE);
-	for (i = 0; i < regcount; i++, dreg++)
-		__nft_reg_track_cancel(track, dreg);
-}
-EXPORT_SYMBOL_GPL(nft_reg_track_cancel);
-
-void __nft_reg_track_cancel(struct nft_regs_track *track, u8 dreg)
-{
-	track->regs[dreg].selector = NULL;
-	track->regs[dreg].bitwise = NULL;
-	track->regs[dreg].num_reg = 0;
-}
-EXPORT_SYMBOL_GPL(__nft_reg_track_cancel);
-
 /*
  * Tables
  */
@@ -9638,16 +9586,9 @@ void nf_tables_trans_destroy_flush_work(void)
 }
 EXPORT_SYMBOL_GPL(nf_tables_trans_destroy_flush_work);
 
-static bool nft_expr_reduce(struct nft_regs_track *track,
-			    const struct nft_expr *expr)
-{
-	return false;
-}
-
 static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *chain)
 {
 	const struct nft_expr *expr, *last;
-	struct nft_regs_track track = {};
 	unsigned int size, data_size;
 	void *data, *data_boundary;
 	struct nft_rule_dp *prule;
@@ -9684,15 +9625,7 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 			return -ENOMEM;
 
 		size = 0;
-		track.last = nft_expr_last(rule);
 		nft_rule_for_each_expr(expr, last, rule) {
-			track.cur = expr;
-
-			if (nft_expr_reduce(&track, expr)) {
-				expr = track.cur;
-				continue;
-			}
-
 			if (WARN_ON_ONCE(data + size + expr->ops->size > data_boundary))
 				return -ENOMEM;
 
diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 1afb36fb5994db..e0a6703dc0e4a6 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -402,61 +402,12 @@ static int nft_bitwise_offload(struct nft_offload_ctx *ctx,
 	return 0;
 }
 
-static bool nft_bitwise_reduce(struct nft_regs_track *track,
-			       const struct nft_expr *expr)
-{
-	const struct nft_bitwise *priv = nft_expr_priv(expr);
-	const struct nft_bitwise *bitwise;
-	unsigned int regcount;
-	u8 dreg;
-	int i;
-
-	if (!track->regs[priv->sreg].selector)
-		return false;
-
-	bitwise = nft_expr_priv(track->regs[priv->dreg].selector);
-	if (track->regs[priv->sreg].selector == track->regs[priv->dreg].selector &&
-	    track->regs[priv->sreg].num_reg == 0 &&
-	    track->regs[priv->dreg].bitwise &&
-	    track->regs[priv->dreg].bitwise->ops == expr->ops &&
-	    priv->sreg == bitwise->sreg &&
-	    priv->sreg2 == bitwise->sreg2 &&
-	    priv->dreg == bitwise->dreg &&
-	    priv->op == bitwise->op &&
-	    priv->len == bitwise->len &&
-	    !memcmp(&priv->mask, &bitwise->mask, sizeof(priv->mask)) &&
-	    !memcmp(&priv->xor, &bitwise->xor, sizeof(priv->xor)) &&
-	    !memcmp(&priv->data, &bitwise->data, sizeof(priv->data))) {
-		track->cur = expr;
-		return true;
-	}
-
-	if (track->regs[priv->sreg].bitwise ||
-	    track->regs[priv->sreg].num_reg != 0) {
-		nft_reg_track_cancel(track, priv->dreg, priv->len);
-		return false;
-	}
-
-	if (priv->sreg != priv->dreg) {
-		nft_reg_track_update(track, track->regs[priv->sreg].selector,
-				     priv->dreg, priv->len);
-	}
-
-	dreg = priv->dreg;
-	regcount = DIV_ROUND_UP(priv->len, NFT_REG32_SIZE);
-	for (i = 0; i < regcount; i++, dreg++)
-		track->regs[dreg].bitwise = expr;
-
-	return false;
-}
-
 static const struct nft_expr_ops nft_bitwise_ops = {
 	.type		= &nft_bitwise_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_bitwise)),
 	.eval		= nft_bitwise_eval,
 	.init		= nft_bitwise_init,
 	.dump		= nft_bitwise_dump,
-	.reduce		= nft_bitwise_reduce,
 	.offload	= nft_bitwise_offload,
 };
 
@@ -559,48 +510,12 @@ static int nft_bitwise_fast_offload(struct nft_offload_ctx *ctx,
 	return 0;
 }
 
-static bool nft_bitwise_fast_reduce(struct nft_regs_track *track,
-				    const struct nft_expr *expr)
-{
-	const struct nft_bitwise_fast_expr *priv = nft_expr_priv(expr);
-	const struct nft_bitwise_fast_expr *bitwise;
-
-	if (!track->regs[priv->sreg].selector)
-		return false;
-
-	bitwise = nft_expr_priv(track->regs[priv->dreg].selector);
-	if (track->regs[priv->sreg].selector == track->regs[priv->dreg].selector &&
-	    track->regs[priv->dreg].bitwise &&
-	    track->regs[priv->dreg].bitwise->ops == expr->ops &&
-	    priv->sreg == bitwise->sreg &&
-	    priv->dreg == bitwise->dreg &&
-	    priv->mask == bitwise->mask &&
-	    priv->xor == bitwise->xor) {
-		track->cur = expr;
-		return true;
-	}
-
-	if (track->regs[priv->sreg].bitwise) {
-		nft_reg_track_cancel(track, priv->dreg, NFT_REG32_SIZE);
-		return false;
-	}
-
-	if (priv->sreg != priv->dreg) {
-		track->regs[priv->dreg].selector =
-			track->regs[priv->sreg].selector;
-	}
-	track->regs[priv->dreg].bitwise = expr;
-
-	return false;
-}
-
 const struct nft_expr_ops nft_bitwise_fast_ops = {
 	.type		= &nft_bitwise_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_bitwise_fast_expr)),
 	.eval		= NULL, /* inlined */
 	.init		= nft_bitwise_fast_init,
 	.dump		= nft_bitwise_fast_dump,
-	.reduce		= nft_bitwise_fast_reduce,
 	.offload	= nft_bitwise_fast_offload,
 };
 
@@ -637,22 +552,3 @@ struct nft_expr_type nft_bitwise_type __read_mostly = {
 	.maxattr	= NFTA_BITWISE_MAX,
 	.owner		= THIS_MODULE,
 };
-
-bool nft_expr_reduce_bitwise(struct nft_regs_track *track,
-			     const struct nft_expr *expr)
-{
-	const struct nft_expr *last = track->last;
-	const struct nft_expr *next;
-
-	if (expr == last)
-		return false;
-
-	next = nft_expr_next(expr);
-	if (next->ops == &nft_bitwise_ops)
-		return nft_bitwise_reduce(track, next);
-	else if (next->ops == &nft_bitwise_fast_ops)
-		return nft_bitwise_fast_reduce(track, next);
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(nft_expr_reduce_bitwise);
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 51f5de5c4ca363..baf677643008ed 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -177,23 +177,12 @@ static int nft_byteorder_dump(struct sk_buff *skb,
 	return -1;
 }
 
-static bool nft_byteorder_reduce(struct nft_regs_track *track,
-				 const struct nft_expr *expr)
-{
-	struct nft_byteorder *priv = nft_expr_priv(expr);
-
-	nft_reg_track_cancel(track, priv->dreg, priv->len);
-
-	return false;
-}
-
 static const struct nft_expr_ops nft_byteorder_ops = {
 	.type		= &nft_byteorder_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_byteorder)),
 	.eval		= nft_byteorder_eval,
 	.init		= nft_byteorder_init,
 	.dump		= nft_byteorder_dump,
-	.reduce		= nft_byteorder_reduce,
 };
 
 struct nft_expr_type nft_byteorder_type __read_mostly = {
diff --git a/net/netfilter/nft_cmp.c b/net/netfilter/nft_cmp.c
index 2605f43737bc96..b61dc9c3383ee1 100644
--- a/net/netfilter/nft_cmp.c
+++ b/net/netfilter/nft_cmp.c
@@ -190,7 +190,6 @@ static const struct nft_expr_ops nft_cmp_ops = {
 	.eval		= nft_cmp_eval,
 	.init		= nft_cmp_init,
 	.dump		= nft_cmp_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_cmp_offload,
 };
 
@@ -282,7 +281,6 @@ const struct nft_expr_ops nft_cmp_fast_ops = {
 	.eval		= NULL,	/* inlined */
 	.init		= nft_cmp_fast_init,
 	.dump		= nft_cmp_fast_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_cmp_fast_offload,
 };
 
@@ -376,7 +374,6 @@ const struct nft_expr_ops nft_cmp16_fast_ops = {
 	.eval		= NULL,	/* inlined */
 	.init		= nft_cmp16_fast_init,
 	.dump		= nft_cmp16_fast_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_cmp16_fast_offload,
 };
 
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 1e8142e64e8082..69355d4fe3d878 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -778,14 +778,6 @@ static const struct nfnetlink_subsystem nfnl_compat_subsys = {
 
 static struct nft_expr_type nft_match_type;
 
-static bool nft_match_reduce(struct nft_regs_track *track,
-			     const struct nft_expr *expr)
-{
-	const struct xt_match *match = expr->ops->data;
-
-	return strcmp(match->name, "comment") == 0;
-}
-
 static const struct nft_expr_ops *
 nft_match_select_ops(const struct nft_ctx *ctx,
 		     const struct nlattr * const tb[])
@@ -828,7 +820,6 @@ nft_match_select_ops(const struct nft_ctx *ctx,
 	ops->dump = nft_match_dump;
 	ops->validate = nft_match_validate;
 	ops->data = match;
-	ops->reduce = nft_match_reduce;
 
 	matchsize = NFT_EXPR_SIZE(XT_ALIGN(match->matchsize));
 	if (matchsize > NFT_MATCH_LARGE_THRESH) {
@@ -918,7 +909,6 @@ nft_target_select_ops(const struct nft_ctx *ctx,
 	ops->dump = nft_target_dump;
 	ops->validate = nft_target_validate;
 	ops->data = target;
-	ops->reduce = NFT_REDUCE_READONLY;
 
 	if (family == NFPROTO_BRIDGE)
 		ops->eval = nft_target_eval_bridge;
diff --git a/net/netfilter/nft_connlimit.c b/net/netfilter/nft_connlimit.c
index 5dd50b3ab5a452..18c439044d3ae7 100644
--- a/net/netfilter/nft_connlimit.c
+++ b/net/netfilter/nft_connlimit.c
@@ -247,7 +247,6 @@ static const struct nft_expr_ops nft_connlimit_ops = {
 	.destroy_clone	= nft_connlimit_destroy_clone,
 	.dump		= nft_connlimit_dump,
 	.gc		= nft_connlimit_gc,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_connlimit_type __read_mostly = {
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index 0d70325280cc57..813c75cd2c259e 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -301,7 +301,6 @@ static const struct nft_expr_ops nft_counter_ops = {
 	.destroy_clone	= nft_counter_destroy,
 	.dump		= nft_counter_dump,
 	.clone		= nft_counter_clone,
-	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_counter_offload,
 	.offload_stats	= nft_counter_offload_stats,
 };
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index e83aa87a348e7d..1d1673f49ff751 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -679,29 +679,6 @@ static int nft_ct_get_dump(struct sk_buff *skb,
 	return -1;
 }
 
-static bool nft_ct_get_reduce(struct nft_regs_track *track,
-			      const struct nft_expr *expr)
-{
-	const struct nft_ct *priv = nft_expr_priv(expr);
-	const struct nft_ct *ct;
-
-	if (!nft_reg_track_cmp(track, expr, priv->dreg)) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	ct = nft_expr_priv(track->regs[priv->dreg].selector);
-	if (priv->key != ct->key) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	if (!track->regs[priv->dreg].bitwise)
-		return true;
-
-	return nft_expr_reduce_bitwise(track, expr);
-}
-
 static int nft_ct_set_dump(struct sk_buff *skb,
 			   const struct nft_expr *expr, bool reset)
 {
@@ -736,27 +713,8 @@ static const struct nft_expr_ops nft_ct_get_ops = {
 	.init		= nft_ct_get_init,
 	.destroy	= nft_ct_get_destroy,
 	.dump		= nft_ct_get_dump,
-	.reduce		= nft_ct_get_reduce,
 };
 
-static bool nft_ct_set_reduce(struct nft_regs_track *track,
-			      const struct nft_expr *expr)
-{
-	int i;
-
-	for (i = 0; i < NFT_REG32_NUM; i++) {
-		if (!track->regs[i].selector)
-			continue;
-
-		if (track->regs[i].selector->ops != &nft_ct_get_ops)
-			continue;
-
-		__nft_reg_track_cancel(track, i);
-	}
-
-	return false;
-}
-
 #ifdef CONFIG_RETPOLINE
 static const struct nft_expr_ops nft_ct_get_fast_ops = {
 	.type		= &nft_ct_type,
@@ -765,7 +723,6 @@ static const struct nft_expr_ops nft_ct_get_fast_ops = {
 	.init		= nft_ct_get_init,
 	.destroy	= nft_ct_get_destroy,
 	.dump		= nft_ct_get_dump,
-	.reduce		= nft_ct_set_reduce,
 };
 #endif
 
@@ -776,7 +733,6 @@ static const struct nft_expr_ops nft_ct_set_ops = {
 	.init		= nft_ct_set_init,
 	.destroy	= nft_ct_set_destroy,
 	.dump		= nft_ct_set_dump,
-	.reduce		= nft_ct_set_reduce,
 };
 
 #ifdef CONFIG_NF_CONNTRACK_ZONES
@@ -787,7 +743,6 @@ static const struct nft_expr_ops nft_ct_set_zone_ops = {
 	.init		= nft_ct_set_init,
 	.destroy	= nft_ct_set_destroy,
 	.dump		= nft_ct_set_dump,
-	.reduce		= nft_ct_set_reduce,
 };
 #endif
 
@@ -857,7 +812,6 @@ static const struct nft_expr_ops nft_notrack_ops = {
 	.type		= &nft_notrack_type,
 	.size		= NFT_EXPR_SIZE(0),
 	.eval		= nft_notrack_eval,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_notrack_type __read_mostly = {
diff --git a/net/netfilter/nft_dup_netdev.c b/net/netfilter/nft_dup_netdev.c
index 0573f96ce07913..06866799e9463e 100644
--- a/net/netfilter/nft_dup_netdev.c
+++ b/net/netfilter/nft_dup_netdev.c
@@ -80,7 +80,6 @@ static const struct nft_expr_ops nft_dup_netdev_ops = {
 	.eval		= nft_dup_netdev_eval,
 	.init		= nft_dup_netdev_init,
 	.dump		= nft_dup_netdev_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_dup_netdev_offload,
 	.offload_action	= nft_dup_netdev_offload_action,
 };
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 87c6a02675ba36..b1c6bb490d4624 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -430,7 +430,6 @@ static const struct nft_expr_ops nft_dynset_ops = {
 	.activate	= nft_dynset_activate,
 	.deactivate	= nft_dynset_deactivate,
 	.dump		= nft_dynset_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 struct nft_expr_type nft_dynset_type __read_mostly = {
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index cac46accf566b5..19d48577e77bd6 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -701,40 +701,12 @@ static int nft_exthdr_dump_strip(struct sk_buff *skb,
 	return nft_exthdr_dump_common(skb, priv);
 }
 
-static bool nft_exthdr_reduce(struct nft_regs_track *track,
-			       const struct nft_expr *expr)
-{
-	const struct nft_exthdr *priv = nft_expr_priv(expr);
-	const struct nft_exthdr *exthdr;
-
-	if (!nft_reg_track_cmp(track, expr, priv->dreg)) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	exthdr = nft_expr_priv(track->regs[priv->dreg].selector);
-	if (priv->type != exthdr->type ||
-	    priv->op != exthdr->op ||
-	    priv->flags != exthdr->flags ||
-	    priv->offset != exthdr->offset ||
-	    priv->len != exthdr->len) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	if (!track->regs[priv->dreg].bitwise)
-		return true;
-
-	return nft_expr_reduce_bitwise(track, expr);
-}
-
 static const struct nft_expr_ops nft_exthdr_ipv6_ops = {
 	.type		= &nft_exthdr_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_exthdr)),
 	.eval		= nft_exthdr_ipv6_eval,
 	.init		= nft_exthdr_init,
 	.dump		= nft_exthdr_dump,
-	.reduce		= nft_exthdr_reduce,
 };
 
 static const struct nft_expr_ops nft_exthdr_ipv4_ops = {
@@ -743,7 +715,6 @@ static const struct nft_expr_ops nft_exthdr_ipv4_ops = {
 	.eval		= nft_exthdr_ipv4_eval,
 	.init		= nft_exthdr_ipv4_init,
 	.dump		= nft_exthdr_dump,
-	.reduce		= nft_exthdr_reduce,
 };
 
 static const struct nft_expr_ops nft_exthdr_tcp_ops = {
@@ -752,7 +723,6 @@ static const struct nft_expr_ops nft_exthdr_tcp_ops = {
 	.eval		= nft_exthdr_tcp_eval,
 	.init		= nft_exthdr_init,
 	.dump		= nft_exthdr_dump,
-	.reduce		= nft_exthdr_reduce,
 };
 
 static const struct nft_expr_ops nft_exthdr_tcp_set_ops = {
@@ -761,7 +731,6 @@ static const struct nft_expr_ops nft_exthdr_tcp_set_ops = {
 	.eval		= nft_exthdr_tcp_set_eval,
 	.init		= nft_exthdr_tcp_set_init,
 	.dump		= nft_exthdr_dump_set,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops nft_exthdr_tcp_strip_ops = {
@@ -770,7 +739,6 @@ static const struct nft_expr_ops nft_exthdr_tcp_strip_ops = {
 	.eval		= nft_exthdr_tcp_strip_eval,
 	.init		= nft_exthdr_tcp_strip_init,
 	.dump		= nft_exthdr_dump_strip,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops nft_exthdr_sctp_ops = {
@@ -779,7 +747,6 @@ static const struct nft_expr_ops nft_exthdr_sctp_ops = {
 	.eval		= nft_exthdr_sctp_eval,
 	.init		= nft_exthdr_init,
 	.dump		= nft_exthdr_dump,
-	.reduce		= nft_exthdr_reduce,
 };
 
 static const struct nft_expr_ops nft_exthdr_dccp_ops = {
@@ -788,7 +755,6 @@ static const struct nft_expr_ops nft_exthdr_dccp_ops = {
 	.eval		= nft_exthdr_dccp_eval,
 	.init		= nft_exthdr_dccp_init,
 	.dump		= nft_exthdr_dump,
-	.reduce		= nft_exthdr_reduce,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index b4f49f65fc42fd..889a9cbc7071ca 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -168,47 +168,5 @@ void nft_fib_store_result(void *reg, const struct nft_fib *priv,
 }
 EXPORT_SYMBOL_GPL(nft_fib_store_result);
 
-bool nft_fib_reduce(struct nft_regs_track *track,
-		    const struct nft_expr *expr)
-{
-	const struct nft_fib *priv = nft_expr_priv(expr);
-	unsigned int len = NFT_REG32_SIZE;
-	const struct nft_fib *fib;
-
-	switch (priv->result) {
-	case NFT_FIB_RESULT_OIF:
-		break;
-	case NFT_FIB_RESULT_OIFNAME:
-		if (priv->flags & NFTA_FIB_F_PRESENT)
-			len = NFT_REG32_SIZE;
-		else
-			len = IFNAMSIZ;
-		break;
-	case NFT_FIB_RESULT_ADDRTYPE:
-	     break;
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
-
-	if (!nft_reg_track_cmp(track, expr, priv->dreg)) {
-		nft_reg_track_update(track, expr, priv->dreg, len);
-		return false;
-	}
-
-	fib = nft_expr_priv(track->regs[priv->dreg].selector);
-	if (priv->result != fib->result ||
-	    priv->flags != fib->flags) {
-		nft_reg_track_update(track, expr, priv->dreg, len);
-		return false;
-	}
-
-	if (!track->regs[priv->dreg].bitwise)
-		return true;
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(nft_fib_reduce);
-
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Florian Westphal <fw@strlen.de>");
diff --git a/net/netfilter/nft_fib_inet.c b/net/netfilter/nft_fib_inet.c
index 666a3741d20b6d..a88d44e163d19e 100644
--- a/net/netfilter/nft_fib_inet.c
+++ b/net/netfilter/nft_fib_inet.c
@@ -49,7 +49,6 @@ static const struct nft_expr_ops nft_fib_inet_ops = {
 	.init		= nft_fib_init,
 	.dump		= nft_fib_dump,
 	.validate	= nft_fib_validate,
-	.reduce		= nft_fib_reduce,
 };
 
 static struct nft_expr_type nft_fib_inet_type __read_mostly = {
diff --git a/net/netfilter/nft_fib_netdev.c b/net/netfilter/nft_fib_netdev.c
index 9121ec64e918f4..3f3478abd84546 100644
--- a/net/netfilter/nft_fib_netdev.c
+++ b/net/netfilter/nft_fib_netdev.c
@@ -58,7 +58,6 @@ static const struct nft_expr_ops nft_fib_netdev_ops = {
 	.init		= nft_fib_init,
 	.dump		= nft_fib_dump,
 	.validate	= nft_fib_validate,
-	.reduce		= nft_fib_reduce,
 };
 
 static struct nft_expr_type nft_fib_netdev_type __read_mostly = {
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 75dddcaa9aa37f..2df9178d423a6c 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -481,7 +481,6 @@ static const struct nft_expr_ops nft_flow_offload_ops = {
 	.destroy	= nft_flow_offload_destroy,
 	.validate	= nft_flow_offload_validate,
 	.dump		= nft_flow_offload_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_flow_offload_type __read_mostly = {
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 1223bdea1f00d4..f6c4b3356696f1 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -228,7 +228,6 @@ static const struct nft_expr_ops nft_fwd_neigh_netdev_ops = {
 	.init		= nft_fwd_neigh_init,
 	.dump		= nft_fwd_neigh_dump,
 	.validate	= nft_fwd_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops nft_fwd_netdev_ops = {
@@ -238,7 +237,6 @@ static const struct nft_expr_ops nft_fwd_netdev_ops = {
 	.init		= nft_fwd_netdev_init,
 	.dump		= nft_fwd_netdev_dump,
 	.validate	= nft_fwd_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_fwd_netdev_offload,
 	.offload_action	= nft_fwd_netdev_offload_action,
 };
diff --git a/net/netfilter/nft_hash.c b/net/netfilter/nft_hash.c
index c91f2bef58694e..722836b2c37720 100644
--- a/net/netfilter/nft_hash.c
+++ b/net/netfilter/nft_hash.c
@@ -165,16 +165,6 @@ static int nft_jhash_dump(struct sk_buff *skb,
 	return -1;
 }
 
-static bool nft_jhash_reduce(struct nft_regs_track *track,
-			     const struct nft_expr *expr)
-{
-	const struct nft_jhash *priv = nft_expr_priv(expr);
-
-	nft_reg_track_cancel(track, priv->dreg, sizeof(u32));
-
-	return false;
-}
-
 static int nft_symhash_dump(struct sk_buff *skb,
 			    const struct nft_expr *expr, bool reset)
 {
@@ -195,30 +185,6 @@ static int nft_symhash_dump(struct sk_buff *skb,
 	return -1;
 }
 
-static bool nft_symhash_reduce(struct nft_regs_track *track,
-			       const struct nft_expr *expr)
-{
-	struct nft_symhash *priv = nft_expr_priv(expr);
-	struct nft_symhash *symhash;
-
-	if (!nft_reg_track_cmp(track, expr, priv->dreg)) {
-		nft_reg_track_update(track, expr, priv->dreg, sizeof(u32));
-		return false;
-	}
-
-	symhash = nft_expr_priv(track->regs[priv->dreg].selector);
-	if (priv->offset != symhash->offset ||
-	    priv->modulus != symhash->modulus) {
-		nft_reg_track_update(track, expr, priv->dreg, sizeof(u32));
-		return false;
-	}
-
-	if (!track->regs[priv->dreg].bitwise)
-		return true;
-
-	return false;
-}
-
 static struct nft_expr_type nft_hash_type;
 static const struct nft_expr_ops nft_jhash_ops = {
 	.type		= &nft_hash_type,
@@ -226,7 +192,6 @@ static const struct nft_expr_ops nft_jhash_ops = {
 	.eval		= nft_jhash_eval,
 	.init		= nft_jhash_init,
 	.dump		= nft_jhash_dump,
-	.reduce		= nft_jhash_reduce,
 };
 
 static const struct nft_expr_ops nft_symhash_ops = {
@@ -235,7 +200,6 @@ static const struct nft_expr_ops nft_symhash_ops = {
 	.eval		= nft_symhash_eval,
 	.init		= nft_symhash_init,
 	.dump		= nft_symhash_dump,
-	.reduce		= nft_symhash_reduce,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 02ee5fb69871f8..37c29947b380b4 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -320,17 +320,6 @@ static bool nft_immediate_offload_action(const struct nft_expr *expr)
 	return false;
 }
 
-static bool nft_immediate_reduce(struct nft_regs_track *track,
-				 const struct nft_expr *expr)
-{
-	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
-
-	if (priv->dreg != NFT_REG_VERDICT)
-		nft_reg_track_cancel(track, priv->dreg, priv->dlen);
-
-	return false;
-}
-
 static const struct nft_expr_ops nft_imm_ops = {
 	.type		= &nft_imm_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_immediate_expr)),
@@ -341,7 +330,6 @@ static const struct nft_expr_ops nft_imm_ops = {
 	.destroy	= nft_immediate_destroy,
 	.dump		= nft_immediate_dump,
 	.validate	= nft_immediate_validate,
-	.reduce		= nft_immediate_reduce,
 	.offload	= nft_immediate_offload,
 	.offload_action	= nft_immediate_offload_action,
 };
diff --git a/net/netfilter/nft_last.c b/net/netfilter/nft_last.c
index de1b6066bfa856..e845779268d3a9 100644
--- a/net/netfilter/nft_last.c
+++ b/net/netfilter/nft_last.c
@@ -125,7 +125,6 @@ static const struct nft_expr_ops nft_last_ops = {
 	.destroy	= nft_last_destroy,
 	.clone		= nft_last_clone,
 	.dump		= nft_last_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 struct nft_expr_type nft_last_type __read_mostly = {
diff --git a/net/netfilter/nft_limit.c b/net/netfilter/nft_limit.c
index 21d26b79b46072..0daeb0b23c2052 100644
--- a/net/netfilter/nft_limit.c
+++ b/net/netfilter/nft_limit.c
@@ -243,7 +243,6 @@ static const struct nft_expr_ops nft_limit_pkts_ops = {
 	.destroy	= nft_limit_pkts_destroy,
 	.clone		= nft_limit_pkts_clone,
 	.dump		= nft_limit_pkts_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static void nft_limit_bytes_eval(const struct nft_expr *expr,
@@ -299,7 +298,6 @@ static const struct nft_expr_ops nft_limit_bytes_ops = {
 	.dump		= nft_limit_bytes_dump,
 	.clone		= nft_limit_bytes_clone,
 	.destroy	= nft_limit_bytes_destroy,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/netfilter/nft_log.c b/net/netfilter/nft_log.c
index e3558813799579..575021f6ee33cd 100644
--- a/net/netfilter/nft_log.c
+++ b/net/netfilter/nft_log.c
@@ -291,7 +291,6 @@ static const struct nft_expr_ops nft_log_ops = {
 	.init		= nft_log_init,
 	.destroy	= nft_log_destroy,
 	.dump		= nft_log_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_log_type __read_mostly = {
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index aeaf6988efd672..c56cc6f3f8fad3 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -232,17 +232,6 @@ static int nft_lookup_validate(const struct nft_ctx *ctx,
 	return 0;
 }
 
-static bool nft_lookup_reduce(struct nft_regs_track *track,
-			      const struct nft_expr *expr)
-{
-	const struct nft_lookup *priv = nft_expr_priv(expr);
-
-	if (priv->set->flags & NFT_SET_MAP)
-		nft_reg_track_cancel(track, priv->dreg, priv->set->dlen);
-
-	return false;
-}
-
 static const struct nft_expr_ops nft_lookup_ops = {
 	.type		= &nft_lookup_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_lookup)),
@@ -253,7 +242,6 @@ static const struct nft_expr_ops nft_lookup_ops = {
 	.destroy	= nft_lookup_destroy,
 	.dump		= nft_lookup_dump,
 	.validate	= nft_lookup_validate,
-	.reduce		= nft_lookup_reduce,
 };
 
 struct nft_expr_type nft_lookup_type __read_mostly = {
diff --git a/net/netfilter/nft_masq.c b/net/netfilter/nft_masq.c
index 868bd4d7355553..2b01128737a3a8 100644
--- a/net/netfilter/nft_masq.c
+++ b/net/netfilter/nft_masq.c
@@ -143,7 +143,6 @@ static const struct nft_expr_ops nft_masq_ipv4_ops = {
 	.destroy	= nft_masq_ipv4_destroy,
 	.dump		= nft_masq_dump,
 	.validate	= nft_masq_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_masq_ipv4_type __read_mostly = {
@@ -171,7 +170,6 @@ static const struct nft_expr_ops nft_masq_ipv6_ops = {
 	.destroy	= nft_masq_ipv6_destroy,
 	.dump		= nft_masq_dump,
 	.validate	= nft_masq_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_masq_ipv6_type __read_mostly = {
@@ -213,7 +211,6 @@ static const struct nft_expr_ops nft_masq_inet_ops = {
 	.destroy	= nft_masq_inet_destroy,
 	.dump		= nft_masq_dump,
 	.validate	= nft_masq_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_masq_inet_type __read_mostly = {
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 05cd1e6e6a2f61..983158274c68dc 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -742,60 +742,16 @@ static int nft_meta_get_offload(struct nft_offload_ctx *ctx,
 	return 0;
 }
 
-bool nft_meta_get_reduce(struct nft_regs_track *track,
-			 const struct nft_expr *expr)
-{
-	const struct nft_meta *priv = nft_expr_priv(expr);
-	const struct nft_meta *meta;
-
-	if (!nft_reg_track_cmp(track, expr, priv->dreg)) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	meta = nft_expr_priv(track->regs[priv->dreg].selector);
-	if (priv->key != meta->key ||
-	    priv->dreg != meta->dreg) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	if (!track->regs[priv->dreg].bitwise)
-		return true;
-
-	return nft_expr_reduce_bitwise(track, expr);
-}
-EXPORT_SYMBOL_GPL(nft_meta_get_reduce);
-
 static const struct nft_expr_ops nft_meta_get_ops = {
 	.type		= &nft_meta_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_meta)),
 	.eval		= nft_meta_get_eval,
 	.init		= nft_meta_get_init,
 	.dump		= nft_meta_get_dump,
-	.reduce		= nft_meta_get_reduce,
 	.validate	= nft_meta_get_validate,
 	.offload	= nft_meta_get_offload,
 };
 
-static bool nft_meta_set_reduce(struct nft_regs_track *track,
-				const struct nft_expr *expr)
-{
-	int i;
-
-	for (i = 0; i < NFT_REG32_NUM; i++) {
-		if (!track->regs[i].selector)
-			continue;
-
-		if (track->regs[i].selector->ops != &nft_meta_get_ops)
-			continue;
-
-		__nft_reg_track_cancel(track, i);
-	}
-
-	return false;
-}
-
 static const struct nft_expr_ops nft_meta_set_ops = {
 	.type		= &nft_meta_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_meta)),
@@ -803,7 +759,6 @@ static const struct nft_expr_ops nft_meta_set_ops = {
 	.init		= nft_meta_set_init,
 	.destroy	= nft_meta_set_destroy,
 	.dump		= nft_meta_set_dump,
-	.reduce		= nft_meta_set_reduce,
 	.validate	= nft_meta_set_validate,
 };
 
diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index 6e21f72c5b5741..e32cd9fbc7c2ec 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -320,7 +320,6 @@ static const struct nft_expr_ops nft_nat_ops = {
 	.destroy        = nft_nat_destroy,
 	.dump           = nft_nat_dump,
 	.validate	= nft_nat_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_nat_type __read_mostly = {
@@ -351,7 +350,6 @@ static const struct nft_expr_ops nft_nat_inet_ops = {
 	.destroy        = nft_nat_destroy,
 	.dump           = nft_nat_dump,
 	.validate	= nft_nat_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_inet_nat_type __read_mostly = {
diff --git a/net/netfilter/nft_numgen.c b/net/netfilter/nft_numgen.c
index bd058babfc820c..06e87dfd76e741 100644
--- a/net/netfilter/nft_numgen.c
+++ b/net/netfilter/nft_numgen.c
@@ -84,16 +84,6 @@ static int nft_ng_inc_init(const struct nft_ctx *ctx,
 	return err;
 }
 
-static bool nft_ng_inc_reduce(struct nft_regs_track *track,
-				 const struct nft_expr *expr)
-{
-	const struct nft_ng_inc *priv = nft_expr_priv(expr);
-
-	nft_reg_track_cancel(track, priv->dreg, NFT_REG32_SIZE);
-
-	return false;
-}
-
 static int nft_ng_dump(struct sk_buff *skb, enum nft_registers dreg,
 		       u32 modulus, enum nft_ng_types type, u32 offset)
 {
@@ -178,16 +168,6 @@ static int nft_ng_random_dump(struct sk_buff *skb,
 			   priv->offset);
 }
 
-static bool nft_ng_random_reduce(struct nft_regs_track *track,
-				 const struct nft_expr *expr)
-{
-	const struct nft_ng_random *priv = nft_expr_priv(expr);
-
-	nft_reg_track_cancel(track, priv->dreg, NFT_REG32_SIZE);
-
-	return false;
-}
-
 static struct nft_expr_type nft_ng_type;
 static const struct nft_expr_ops nft_ng_inc_ops = {
 	.type		= &nft_ng_type,
@@ -196,7 +176,6 @@ static const struct nft_expr_ops nft_ng_inc_ops = {
 	.init		= nft_ng_inc_init,
 	.destroy	= nft_ng_inc_destroy,
 	.dump		= nft_ng_inc_dump,
-	.reduce		= nft_ng_inc_reduce,
 };
 
 static const struct nft_expr_ops nft_ng_random_ops = {
@@ -205,7 +184,6 @@ static const struct nft_expr_ops nft_ng_random_ops = {
 	.eval		= nft_ng_random_eval,
 	.init		= nft_ng_random_init,
 	.dump		= nft_ng_random_dump,
-	.reduce		= nft_ng_random_reduce,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 1ee17098de0c44..8228dc4369de99 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -123,7 +123,6 @@ static const struct nft_expr_ops nft_objref_ops = {
 	.deactivate	= nft_objref_deactivate,
 	.dump		= nft_objref_dump,
 	.validate	= nft_objref_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 struct nft_objref_map {
@@ -246,7 +245,6 @@ static const struct nft_expr_ops nft_objref_map_ops = {
 	.destroy	= nft_objref_map_destroy,
 	.dump		= nft_objref_map_dump,
 	.validate	= nft_objref_map_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index 23ec9b397f1ebc..66c8ddd2963571 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -136,30 +136,6 @@ static int nft_osf_validate(const struct nft_ctx *ctx,
 	return nft_chain_validate_hooks(ctx->chain, hooks);
 }
 
-static bool nft_osf_reduce(struct nft_regs_track *track,
-			   const struct nft_expr *expr)
-{
-	struct nft_osf *priv = nft_expr_priv(expr);
-	struct nft_osf *osf;
-
-	if (!nft_reg_track_cmp(track, expr, priv->dreg)) {
-		nft_reg_track_update(track, expr, priv->dreg, NFT_OSF_MAXGENRELEN);
-		return false;
-	}
-
-	osf = nft_expr_priv(track->regs[priv->dreg].selector);
-	if (priv->flags != osf->flags ||
-	    priv->ttl != osf->ttl) {
-		nft_reg_track_update(track, expr, priv->dreg, NFT_OSF_MAXGENRELEN);
-		return false;
-	}
-
-	if (!track->regs[priv->dreg].bitwise)
-		return true;
-
-	return false;
-}
-
 static struct nft_expr_type nft_osf_type;
 static const struct nft_expr_ops nft_osf_op = {
 	.eval		= nft_osf_eval,
@@ -168,7 +144,6 @@ static const struct nft_expr_ops nft_osf_op = {
 	.dump		= nft_osf_dump,
 	.type		= &nft_osf_type,
 	.validate	= nft_osf_validate,
-	.reduce		= nft_osf_reduce,
 };
 
 static struct nft_expr_type nft_osf_type __read_mostly = {
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 7dfc5343dae46f..36c31ad2d64c14 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -250,31 +250,6 @@ static int nft_payload_dump(struct sk_buff *skb,
 	return -1;
 }
 
-static bool nft_payload_reduce(struct nft_regs_track *track,
-			       const struct nft_expr *expr)
-{
-	const struct nft_payload *priv = nft_expr_priv(expr);
-	const struct nft_payload *payload;
-
-	if (!nft_reg_track_cmp(track, expr, priv->dreg)) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	payload = nft_expr_priv(track->regs[priv->dreg].selector);
-	if (priv->base != payload->base ||
-	    priv->offset != payload->offset ||
-	    priv->len != payload->len) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	if (!track->regs[priv->dreg].bitwise)
-		return true;
-
-	return nft_expr_reduce_bitwise(track, expr);
-}
-
 static bool nft_payload_offload_mask(struct nft_offload_reg *reg,
 				     u32 priv_len, u32 field_len)
 {
@@ -578,7 +553,6 @@ static const struct nft_expr_ops nft_payload_ops = {
 	.eval		= nft_payload_eval,
 	.init		= nft_payload_init,
 	.dump		= nft_payload_dump,
-	.reduce		= nft_payload_reduce,
 	.offload	= nft_payload_offload,
 };
 
@@ -588,7 +562,6 @@ const struct nft_expr_ops nft_payload_fast_ops = {
 	.eval		= nft_payload_eval,
 	.init		= nft_payload_init,
 	.dump		= nft_payload_dump,
-	.reduce		= nft_payload_reduce,
 	.offload	= nft_payload_offload,
 };
 
@@ -1008,32 +981,12 @@ static int nft_payload_set_dump(struct sk_buff *skb,
 	return -1;
 }
 
-static bool nft_payload_set_reduce(struct nft_regs_track *track,
-				   const struct nft_expr *expr)
-{
-	int i;
-
-	for (i = 0; i < NFT_REG32_NUM; i++) {
-		if (!track->regs[i].selector)
-			continue;
-
-		if (track->regs[i].selector->ops != &nft_payload_ops &&
-		    track->regs[i].selector->ops != &nft_payload_fast_ops)
-			continue;
-
-		__nft_reg_track_cancel(track, i);
-	}
-
-	return false;
-}
-
 static const struct nft_expr_ops nft_payload_set_ops = {
 	.type		= &nft_payload_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_payload_set)),
 	.eval		= nft_payload_set_eval,
 	.init		= nft_payload_set_init,
 	.dump		= nft_payload_set_dump,
-	.reduce		= nft_payload_set_reduce,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/netfilter/nft_queue.c b/net/netfilter/nft_queue.c
index 344fe311878fe0..8eb13a02942ed3 100644
--- a/net/netfilter/nft_queue.c
+++ b/net/netfilter/nft_queue.c
@@ -191,7 +191,6 @@ static const struct nft_expr_ops nft_queue_ops = {
 	.init		= nft_queue_init,
 	.dump		= nft_queue_dump,
 	.validate	= nft_queue_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops nft_queue_sreg_ops = {
@@ -201,7 +200,6 @@ static const struct nft_expr_ops nft_queue_sreg_ops = {
 	.init		= nft_queue_sreg_init,
 	.dump		= nft_queue_sreg_dump,
 	.validate	= nft_queue_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/netfilter/nft_quota.c b/net/netfilter/nft_quota.c
index df0798da2329b9..870a2b87e0d52c 100644
--- a/net/netfilter/nft_quota.c
+++ b/net/netfilter/nft_quota.c
@@ -265,7 +265,6 @@ static const struct nft_expr_ops nft_quota_ops = {
 	.destroy	= nft_quota_destroy,
 	.clone		= nft_quota_clone,
 	.dump		= nft_quota_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_quota_type __read_mostly = {
diff --git a/net/netfilter/nft_range.c b/net/netfilter/nft_range.c
index ea382f7bbd78db..cbb02644b83626 100644
--- a/net/netfilter/nft_range.c
+++ b/net/netfilter/nft_range.c
@@ -138,7 +138,6 @@ static const struct nft_expr_ops nft_range_ops = {
 	.eval		= nft_range_eval,
 	.init		= nft_range_init,
 	.dump		= nft_range_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 struct nft_expr_type nft_range_type __read_mostly = {
diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index 95eedad85c835c..58ae802db8f52d 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -146,7 +146,6 @@ static const struct nft_expr_ops nft_redir_ipv4_ops = {
 	.destroy	= nft_redir_ipv4_destroy,
 	.dump		= nft_redir_dump,
 	.validate	= nft_redir_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_redir_ipv4_type __read_mostly = {
@@ -174,7 +173,6 @@ static const struct nft_expr_ops nft_redir_ipv6_ops = {
 	.destroy	= nft_redir_ipv6_destroy,
 	.dump		= nft_redir_dump,
 	.validate	= nft_redir_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_redir_ipv6_type __read_mostly = {
@@ -203,7 +201,6 @@ static const struct nft_expr_ops nft_redir_inet_ops = {
 	.destroy	= nft_redir_inet_destroy,
 	.dump		= nft_redir_dump,
 	.validate	= nft_redir_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_redir_inet_type __read_mostly = {
diff --git a/net/netfilter/nft_reject_inet.c b/net/netfilter/nft_reject_inet.c
index 49020e67304ad7..dcae83ddc32e58 100644
--- a/net/netfilter/nft_reject_inet.c
+++ b/net/netfilter/nft_reject_inet.c
@@ -79,7 +79,6 @@ static const struct nft_expr_ops nft_reject_inet_ops = {
 	.init		= nft_reject_init,
 	.dump		= nft_reject_dump,
 	.validate	= nft_reject_inet_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_reject_inet_type __read_mostly = {
diff --git a/net/netfilter/nft_reject_netdev.c b/net/netfilter/nft_reject_netdev.c
index 2558ce1505d989..b53e81e4ca75db 100644
--- a/net/netfilter/nft_reject_netdev.c
+++ b/net/netfilter/nft_reject_netdev.c
@@ -158,7 +158,6 @@ static const struct nft_expr_ops nft_reject_netdev_ops = {
 	.init		= nft_reject_init,
 	.dump		= nft_reject_dump,
 	.validate	= nft_reject_netdev_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_reject_netdev_type __read_mostly = {
diff --git a/net/netfilter/nft_rt.c b/net/netfilter/nft_rt.c
index 9525f1e02a7d83..700656565b6560 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -195,7 +195,6 @@ static const struct nft_expr_ops nft_rt_get_ops = {
 	.init		= nft_rt_get_init,
 	.dump		= nft_rt_get_dump,
 	.validate	= nft_rt_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 struct nft_expr_type nft_rt_type __read_mostly = {
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 35d0409b009501..98326d585e0756 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -249,31 +249,6 @@ static int nft_socket_dump(struct sk_buff *skb,
 	return 0;
 }
 
-static bool nft_socket_reduce(struct nft_regs_track *track,
-			      const struct nft_expr *expr)
-{
-	const struct nft_socket *priv = nft_expr_priv(expr);
-	const struct nft_socket *socket;
-
-	if (!nft_reg_track_cmp(track, expr, priv->dreg)) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	socket = nft_expr_priv(track->regs[priv->dreg].selector);
-	if (priv->key != socket->key ||
-	    priv->dreg != socket->dreg ||
-	    priv->level != socket->level) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	if (!track->regs[priv->dreg].bitwise)
-		return true;
-
-	return nft_expr_reduce_bitwise(track, expr);
-}
-
 static int nft_socket_validate(const struct nft_ctx *ctx,
 			       const struct nft_expr *expr)
 {
@@ -296,7 +271,6 @@ static const struct nft_expr_ops nft_socket_ops = {
 	.init		= nft_socket_init,
 	.dump		= nft_socket_dump,
 	.validate	= nft_socket_validate,
-	.reduce		= nft_socket_reduce,
 };
 
 static struct nft_expr_type nft_socket_type __read_mostly = {
diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index 4d3e5a31b4125d..4c5e7d120910af 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -291,7 +291,6 @@ static const struct nft_expr_ops nft_synproxy_ops = {
 	.dump		= nft_synproxy_dump,
 	.type		= &nft_synproxy_type,
 	.validate	= nft_synproxy_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_synproxy_type __read_mostly = {
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index 50481280abd265..f2101af8c867f4 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -331,7 +331,6 @@ static const struct nft_expr_ops nft_tproxy_ops = {
 	.init		= nft_tproxy_init,
 	.destroy	= nft_tproxy_destroy,
 	.dump		= nft_tproxy_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 	.validate	= nft_tproxy_validate,
 };
 
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 96784825855785..073e05636f6bbe 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -124,31 +124,6 @@ static int nft_tunnel_get_dump(struct sk_buff *skb,
 	return -1;
 }
 
-static bool nft_tunnel_get_reduce(struct nft_regs_track *track,
-				  const struct nft_expr *expr)
-{
-	const struct nft_tunnel *priv = nft_expr_priv(expr);
-	const struct nft_tunnel *tunnel;
-
-	if (!nft_reg_track_cmp(track, expr, priv->dreg)) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	tunnel = nft_expr_priv(track->regs[priv->dreg].selector);
-	if (priv->key != tunnel->key ||
-	    priv->dreg != tunnel->dreg ||
-	    priv->mode != tunnel->mode) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	if (!track->regs[priv->dreg].bitwise)
-		return true;
-
-	return false;
-}
-
 static struct nft_expr_type nft_tunnel_type;
 static const struct nft_expr_ops nft_tunnel_get_ops = {
 	.type		= &nft_tunnel_type,
@@ -156,7 +131,6 @@ static const struct nft_expr_ops nft_tunnel_get_ops = {
 	.eval		= nft_tunnel_get_eval,
 	.init		= nft_tunnel_get_init,
 	.dump		= nft_tunnel_get_dump,
-	.reduce		= nft_tunnel_get_reduce,
 };
 
 static struct nft_expr_type nft_tunnel_type __read_mostly = {
diff --git a/net/netfilter/nft_xfrm.c b/net/netfilter/nft_xfrm.c
index 8a07b46cc8fb73..81cbe8408c83cc 100644
--- a/net/netfilter/nft_xfrm.c
+++ b/net/netfilter/nft_xfrm.c
@@ -258,32 +258,6 @@ static int nft_xfrm_validate(const struct nft_ctx *ctx, const struct nft_expr *e
 	return nft_chain_validate_hooks(ctx->chain, hooks);
 }
 
-static bool nft_xfrm_reduce(struct nft_regs_track *track,
-			    const struct nft_expr *expr)
-{
-	const struct nft_xfrm *priv = nft_expr_priv(expr);
-	const struct nft_xfrm *xfrm;
-
-	if (!nft_reg_track_cmp(track, expr, priv->dreg)) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	xfrm = nft_expr_priv(track->regs[priv->dreg].selector);
-	if (priv->key != xfrm->key ||
-	    priv->dreg != xfrm->dreg ||
-	    priv->dir != xfrm->dir ||
-	    priv->spnum != xfrm->spnum) {
-		nft_reg_track_update(track, expr, priv->dreg, priv->len);
-		return false;
-	}
-
-	if (!track->regs[priv->dreg].bitwise)
-		return true;
-
-	return nft_expr_reduce_bitwise(track, expr);
-}
-
 static struct nft_expr_type nft_xfrm_type;
 static const struct nft_expr_ops nft_xfrm_get_ops = {
 	.type		= &nft_xfrm_type,
@@ -292,7 +266,6 @@ static const struct nft_expr_ops nft_xfrm_get_ops = {
 	.init		= nft_xfrm_get_init,
 	.dump		= nft_xfrm_get_dump,
 	.validate	= nft_xfrm_validate,
-	.reduce		= nft_xfrm_reduce,
 };
 
 static struct nft_expr_type nft_xfrm_type __read_mostly = {
-- 
2.53.0

