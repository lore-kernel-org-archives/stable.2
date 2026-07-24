Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF230E0F2
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856304; cv=none; b=IsLGxopOBZ+2oP4IJhgTn+4FH+bEkiXLgN6ZdTx7ICXXtCUiCRD7uXaswomg83j/gQq+F8zz97ixlvAcDWB7lliK5nmqduEAo8m3DVDSwG+ysYCI0IlELPN8khw4oKz+1bRmQhr/TooSCtDKRV8M2vrYaplV2/xz3gE7oTc2r/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856304; c=relaxed/simple;
	bh=HjiP7HOBvKBbZPlJ4eSauyKI3+KNy0+eeMgTJiH1hNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNGYMqLTnvsj+14HQsMhdZbmVFIIBLQ2ZkCenpAGJR0XUcWu7YCWURL900AEDxKn6Fjdg+fF+Zebkj7BEkzQhP6+uo3PezfPf1V5ddhRqovglm+pnnEoANyJdWf4kgAzaa938xK1tkLeYTXOisW3H8sDd6nkKgyOLMyW7LQW4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw4kg2ix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw4kg2ix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22F41F00A3F;
	Fri, 24 Jul 2026 01:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856300;
	bh=RB71JhwXB7gukg3pBuhya4DxvY+G1prOQ0DVzfbXVpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hw4kg2ixdDcQyNqw/+WYykcCs7kbxPHdpcUykDqfol7RRheOXN58o6Ag3Y2gbhFyl
	 53u9Q/lQontvjukM4HxZc7o1C0A5u80+TBe2g1SsbAXc5daod0gxl8+CJstrjkTkhD
	 jiCvZtGLQ2uRZCcSaXOTLy4NtHU/vuQPqRaRF+bQ3p7ZONOCTMfpVtlpZCgM0kspTu
	 mkkTf0h3dvKXxp6pJQ/TtmiYJTVZHWmEmg8GKHY080FqHjytbOpGWENibVYJl+WHRc
	 E3xER5KY+4LdNrJNiRi1713zVBOG7zwYRaCiP3ubV+FMHLwGKX0G4drlM3AmNqWy87
	 nFbi/zEnTpgAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 6/7] netfilter: nf_tables: remove register tracking infrastructure
Date: Thu, 23 Jul 2026 21:24:52 -0400
Message-ID: <20260724012453.3832653-6-sashal@kernel.org>
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
 include/net/netfilter/nf_tables.h        |  31 -------
 include/net/netfilter/nft_fib.h          |   2 -
 include/net/netfilter/nft_meta.h         |   2 -
 net/bridge/netfilter/nft_meta_bridge.c   |  20 -----
 net/bridge/netfilter/nft_reject_bridge.c |   1 -
 net/ipv4/netfilter/nft_dup_ipv4.c        |   1 -
 net/ipv4/netfilter/nft_fib_ipv4.c        |   2 -
 net/ipv4/netfilter/nft_reject_ipv4.c     |   1 -
 net/ipv6/netfilter/nft_dup_ipv6.c        |   1 -
 net/ipv6/netfilter/nft_fib_ipv6.c        |   2 -
 net/ipv6/netfilter/nft_reject_ipv6.c     |   1 -
 net/netfilter/nf_tables_api.c            |  67 ---------------
 net/netfilter/nft_bitwise.c              | 103 -----------------------
 net/netfilter/nft_byteorder.c            |  11 ---
 net/netfilter/nft_cmp.c                  |   3 -
 net/netfilter/nft_compat.c               |  10 ---
 net/netfilter/nft_connlimit.c            |   1 -
 net/netfilter/nft_counter.c              |   1 -
 net/netfilter/nft_ct.c                   |  45 ----------
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
 net/netfilter/nft_payload.c              |  47 -----------
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
 52 files changed, 689 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index e0b6c328d53776..e5a2df7df98847 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -122,17 +122,6 @@ struct nft_regs {
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
@@ -405,8 +394,6 @@ int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src, gfp_t gfp);
 void nft_expr_destroy(const struct nft_ctx *ctx, struct nft_expr *expr);
 int nft_expr_dump(struct sk_buff *skb, unsigned int attr,
 		  const struct nft_expr *expr);
-bool nft_expr_reduce_bitwise(struct nft_regs_track *track,
-			     const struct nft_expr *expr);
 
 struct nft_set_ext;
 
@@ -933,8 +920,6 @@ struct nft_expr_ops {
 						const struct nft_expr *expr);
 	int				(*validate)(const struct nft_ctx *ctx,
 						    const struct nft_expr *expr);
-	bool				(*reduce)(struct nft_regs_track *track,
-						  const struct nft_expr *expr);
 	bool				(*gc)(struct net *net,
 					      const struct nft_expr *expr);
 	int				(*offload)(struct nft_offload_ctx *ctx,
@@ -1770,20 +1755,4 @@ static inline u64 nft_net_tstamp(const struct net *net)
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
index fc6ee031b35c4b..80899efd3ced56 100644
--- a/include/net/netfilter/nft_fib.h
+++ b/include/net/netfilter/nft_fib.h
@@ -36,6 +36,4 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 void nft_fib_store_result(void *reg, const struct nft_fib *priv,
 			  const struct net_device *dev);
 
-bool nft_fib_reduce(struct nft_regs_track *track,
-		    const struct nft_expr *expr);
 #endif
diff --git a/include/net/netfilter/nft_meta.h b/include/net/netfilter/nft_meta.h
index 22e98ac336f7ed..1aaeb8ca87a90f 100644
--- a/include/net/netfilter/nft_meta.h
+++ b/include/net/netfilter/nft_meta.h
@@ -43,6 +43,4 @@ void nft_meta_set_destroy(const struct nft_ctx *ctx,
 int nft_meta_set_validate(const struct nft_ctx *ctx,
 			  const struct nft_expr *expr);
 
-bool nft_meta_get_reduce(struct nft_regs_track *track,
-			 const struct nft_expr *expr);
 #endif
diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index c3ecd77e25cb8c..f06f32fa384250 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -99,27 +99,8 @@ static const struct nft_expr_ops nft_meta_bridge_get_ops = {
 	.eval		= nft_meta_bridge_get_eval,
 	.init		= nft_meta_bridge_get_init,
 	.dump		= nft_meta_get_dump,
-	.reduce		= nft_meta_get_reduce,
 };
 
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
 static const struct nft_expr_ops nft_meta_bridge_set_ops = {
 	.type		= &nft_meta_bridge_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_meta)),
@@ -127,7 +108,6 @@ static const struct nft_expr_ops nft_meta_bridge_set_ops = {
 	.init		= nft_meta_set_init,
 	.destroy	= nft_meta_set_destroy,
 	.dump		= nft_meta_set_dump,
-	.reduce		= nft_meta_bridge_set_reduce,
 	.validate	= nft_meta_set_validate,
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
index 000539b94e1ef7..cd481d7bded3fc 100644
--- a/net/ipv4/netfilter/nft_dup_ipv4.c
+++ b/net/ipv4/netfilter/nft_dup_ipv4.c
@@ -75,7 +75,6 @@ static const struct nft_expr_ops nft_dup_ipv4_ops = {
 	.eval		= nft_dup_ipv4_eval,
 	.init		= nft_dup_ipv4_init,
 	.dump		= nft_dup_ipv4_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nla_policy nft_dup_ipv4_policy[NFTA_DUP_MAX + 1] = {
diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index 31a96aaeccec53..573d9328d47028 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -158,7 +158,6 @@ static const struct nft_expr_ops nft_fib4_type_ops = {
 	.init		= nft_fib_init,
 	.dump		= nft_fib_dump,
 	.validate	= nft_fib_validate,
-	.reduce		= nft_fib_reduce,
 };
 
 static const struct nft_expr_ops nft_fib4_ops = {
@@ -168,7 +167,6 @@ static const struct nft_expr_ops nft_fib4_ops = {
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
index 5a7abea7739c76..f971d585d8b39e 100644
--- a/net/ipv6/netfilter/nft_dup_ipv6.c
+++ b/net/ipv6/netfilter/nft_dup_ipv6.c
@@ -73,7 +73,6 @@ static const struct nft_expr_ops nft_dup_ipv6_ops = {
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
index b6f74fa699f225..b95b38ddf44b92 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -729,58 +729,6 @@ static int nft_delflowtable(struct nft_ctx *ctx,
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
@@ -9153,16 +9101,9 @@ void nf_tables_trans_destroy_flush_work(void)
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
@@ -9200,15 +9141,7 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
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
index 5b96f5a490ddaa..1bdfffd7e0c8d7 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -281,60 +281,12 @@ static int nft_bitwise_offload(struct nft_offload_ctx *ctx,
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
 
@@ -435,48 +387,12 @@ static int nft_bitwise_fast_offload(struct nft_offload_ctx *ctx,
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
 
@@ -513,22 +429,3 @@ struct nft_expr_type nft_bitwise_type __read_mostly = {
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
index 60b18efadf5ccd..7fd540cc1c517a 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -169,23 +169,12 @@ static int nft_byteorder_dump(struct sk_buff *skb, const struct nft_expr *expr)
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
index 30181e12409dd7..4473334eb94238 100644
--- a/net/netfilter/nft_cmp.c
+++ b/net/netfilter/nft_cmp.c
@@ -189,7 +189,6 @@ static const struct nft_expr_ops nft_cmp_ops = {
 	.eval		= nft_cmp_eval,
 	.init		= nft_cmp_init,
 	.dump		= nft_cmp_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_cmp_offload,
 };
 
@@ -280,7 +279,6 @@ const struct nft_expr_ops nft_cmp_fast_ops = {
 	.eval		= NULL,	/* inlined */
 	.init		= nft_cmp_fast_init,
 	.dump		= nft_cmp_fast_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_cmp_fast_offload,
 };
 
@@ -373,7 +371,6 @@ const struct nft_expr_ops nft_cmp16_fast_ops = {
 	.eval		= NULL,	/* inlined */
 	.init		= nft_cmp16_fast_init,
 	.dump		= nft_cmp16_fast_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_cmp16_fast_offload,
 };
 
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index e1ca7f453ed7b6..da6a3a5544c624 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -775,14 +775,6 @@ static const struct nfnetlink_subsystem nfnl_compat_subsys = {
 
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
@@ -825,7 +817,6 @@ nft_match_select_ops(const struct nft_ctx *ctx,
 	ops->dump = nft_match_dump;
 	ops->validate = nft_match_validate;
 	ops->data = match;
-	ops->reduce = nft_match_reduce;
 
 	matchsize = NFT_EXPR_SIZE(XT_ALIGN(match->matchsize));
 	if (matchsize > NFT_MATCH_LARGE_THRESH) {
@@ -915,7 +906,6 @@ nft_target_select_ops(const struct nft_ctx *ctx,
 	ops->dump = nft_target_dump;
 	ops->validate = nft_target_validate;
 	ops->data = target;
-	ops->reduce = NFT_REDUCE_READONLY;
 
 	if (family == NFPROTO_BRIDGE)
 		ops->eval = nft_target_eval_bridge;
diff --git a/net/netfilter/nft_connlimit.c b/net/netfilter/nft_connlimit.c
index b3411dec16fd2e..e2ddb55968531b 100644
--- a/net/netfilter/nft_connlimit.c
+++ b/net/netfilter/nft_connlimit.c
@@ -246,7 +246,6 @@ static const struct nft_expr_ops nft_connlimit_ops = {
 	.destroy_clone	= nft_connlimit_destroy_clone,
 	.dump		= nft_connlimit_dump,
 	.gc		= nft_connlimit_gc,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_connlimit_type __read_mostly = {
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index 7411bba75d4cb9..c9802db9606325 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -300,7 +300,6 @@ static const struct nft_expr_ops nft_counter_ops = {
 	.destroy_clone	= nft_counter_destroy,
 	.dump		= nft_counter_dump,
 	.clone		= nft_counter_clone,
-	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_counter_offload,
 	.offload_stats	= nft_counter_offload_stats,
 };
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index e2ef510ab04894..bef0dce30487c1 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -690,29 +690,6 @@ static int nft_ct_get_dump(struct sk_buff *skb, const struct nft_expr *expr)
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
 static int nft_ct_set_dump(struct sk_buff *skb, const struct nft_expr *expr)
 {
 	const struct nft_ct *priv = nft_expr_priv(expr);
@@ -746,27 +723,8 @@ static const struct nft_expr_ops nft_ct_get_ops = {
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
 static const struct nft_expr_ops nft_ct_set_ops = {
 	.type		= &nft_ct_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_ct)),
@@ -774,7 +732,6 @@ static const struct nft_expr_ops nft_ct_set_ops = {
 	.init		= nft_ct_set_init,
 	.destroy	= nft_ct_set_destroy,
 	.dump		= nft_ct_set_dump,
-	.reduce		= nft_ct_set_reduce,
 };
 
 #ifdef CONFIG_NF_CONNTRACK_ZONES
@@ -785,7 +742,6 @@ static const struct nft_expr_ops nft_ct_set_zone_ops = {
 	.init		= nft_ct_set_init,
 	.destroy	= nft_ct_set_destroy,
 	.dump		= nft_ct_set_dump,
-	.reduce		= nft_ct_set_reduce,
 };
 #endif
 
@@ -842,7 +798,6 @@ static const struct nft_expr_ops nft_notrack_ops = {
 	.type		= &nft_notrack_type,
 	.size		= NFT_EXPR_SIZE(0),
 	.eval		= nft_notrack_eval,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_notrack_type __read_mostly = {
diff --git a/net/netfilter/nft_dup_netdev.c b/net/netfilter/nft_dup_netdev.c
index 6e0a66588fb32c..017ed8f18cbc0c 100644
--- a/net/netfilter/nft_dup_netdev.c
+++ b/net/netfilter/nft_dup_netdev.c
@@ -79,7 +79,6 @@ static const struct nft_expr_ops nft_dup_netdev_ops = {
 	.eval		= nft_dup_netdev_eval,
 	.init		= nft_dup_netdev_init,
 	.dump		= nft_dup_netdev_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_dup_netdev_offload,
 	.offload_action	= nft_dup_netdev_offload_action,
 };
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 6e71b937fb3542..1ea4b22ef2c4cf 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -429,7 +429,6 @@ static const struct nft_expr_ops nft_dynset_ops = {
 	.activate	= nft_dynset_activate,
 	.deactivate	= nft_dynset_deactivate,
 	.dump		= nft_dynset_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 struct nft_expr_type nft_dynset_type __read_mostly = {
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index f3fefe70abff2c..fbdcb30f221ce8 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -699,40 +699,12 @@ static int nft_exthdr_dump_strip(struct sk_buff *skb, const struct nft_expr *exp
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
@@ -741,7 +713,6 @@ static const struct nft_expr_ops nft_exthdr_ipv4_ops = {
 	.eval		= nft_exthdr_ipv4_eval,
 	.init		= nft_exthdr_ipv4_init,
 	.dump		= nft_exthdr_dump,
-	.reduce		= nft_exthdr_reduce,
 };
 
 static const struct nft_expr_ops nft_exthdr_tcp_ops = {
@@ -750,7 +721,6 @@ static const struct nft_expr_ops nft_exthdr_tcp_ops = {
 	.eval		= nft_exthdr_tcp_eval,
 	.init		= nft_exthdr_init,
 	.dump		= nft_exthdr_dump,
-	.reduce		= nft_exthdr_reduce,
 };
 
 static const struct nft_expr_ops nft_exthdr_tcp_set_ops = {
@@ -759,7 +729,6 @@ static const struct nft_expr_ops nft_exthdr_tcp_set_ops = {
 	.eval		= nft_exthdr_tcp_set_eval,
 	.init		= nft_exthdr_tcp_set_init,
 	.dump		= nft_exthdr_dump_set,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops nft_exthdr_tcp_strip_ops = {
@@ -768,7 +737,6 @@ static const struct nft_expr_ops nft_exthdr_tcp_strip_ops = {
 	.eval		= nft_exthdr_tcp_strip_eval,
 	.init		= nft_exthdr_tcp_strip_init,
 	.dump		= nft_exthdr_dump_strip,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops nft_exthdr_sctp_ops = {
@@ -777,7 +745,6 @@ static const struct nft_expr_ops nft_exthdr_sctp_ops = {
 	.eval		= nft_exthdr_sctp_eval,
 	.init		= nft_exthdr_init,
 	.dump		= nft_exthdr_dump,
-	.reduce		= nft_exthdr_reduce,
 };
 
 static const struct nft_expr_ops nft_exthdr_dccp_ops = {
@@ -786,7 +753,6 @@ static const struct nft_expr_ops nft_exthdr_dccp_ops = {
 	.eval		= nft_exthdr_dccp_eval,
 	.init		= nft_exthdr_dccp_init,
 	.dump		= nft_exthdr_dump,
-	.reduce		= nft_exthdr_reduce,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 60913a97a47f2e..c0a5fd54b41793 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -167,47 +167,5 @@ void nft_fib_store_result(void *reg, const struct nft_fib *priv,
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
index 6bdafe91bc786a..164037962a3de9 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -480,7 +480,6 @@ static const struct nft_expr_ops nft_flow_offload_ops = {
 	.destroy	= nft_flow_offload_destroy,
 	.validate	= nft_flow_offload_validate,
 	.dump		= nft_flow_offload_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_flow_offload_type __read_mostly = {
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index d1afebeef35413..0989344ca1c69c 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -226,7 +226,6 @@ static const struct nft_expr_ops nft_fwd_neigh_netdev_ops = {
 	.init		= nft_fwd_neigh_init,
 	.dump		= nft_fwd_neigh_dump,
 	.validate	= nft_fwd_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops nft_fwd_netdev_ops = {
@@ -236,7 +235,6 @@ static const struct nft_expr_ops nft_fwd_netdev_ops = {
 	.init		= nft_fwd_netdev_init,
 	.dump		= nft_fwd_netdev_dump,
 	.validate	= nft_fwd_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_fwd_netdev_offload,
 	.offload_action	= nft_fwd_netdev_offload_action,
 };
diff --git a/net/netfilter/nft_hash.c b/net/netfilter/nft_hash.c
index e15d0edc761c29..6b71ee75938a53 100644
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
 			    const struct nft_expr *expr)
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
index 44d56424184728..23c21f212d41f9 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -319,17 +319,6 @@ static bool nft_immediate_offload_action(const struct nft_expr *expr)
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
@@ -340,7 +329,6 @@ static const struct nft_expr_ops nft_imm_ops = {
 	.destroy	= nft_immediate_destroy,
 	.dump		= nft_immediate_dump,
 	.validate	= nft_immediate_validate,
-	.reduce		= nft_immediate_reduce,
 	.offload	= nft_immediate_offload,
 	.offload_action	= nft_immediate_offload_action,
 };
diff --git a/net/netfilter/nft_last.c b/net/netfilter/nft_last.c
index 2ff387b649cfc0..0959e5adfe96ad 100644
--- a/net/netfilter/nft_last.c
+++ b/net/netfilter/nft_last.c
@@ -124,7 +124,6 @@ static const struct nft_expr_ops nft_last_ops = {
 	.destroy	= nft_last_destroy,
 	.clone		= nft_last_clone,
 	.dump		= nft_last_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 struct nft_expr_type nft_last_type __read_mostly = {
diff --git a/net/netfilter/nft_limit.c b/net/netfilter/nft_limit.c
index a263596da99acb..9f69be2016c4a1 100644
--- a/net/netfilter/nft_limit.c
+++ b/net/netfilter/nft_limit.c
@@ -242,7 +242,6 @@ static const struct nft_expr_ops nft_limit_pkts_ops = {
 	.destroy	= nft_limit_pkts_destroy,
 	.clone		= nft_limit_pkts_clone,
 	.dump		= nft_limit_pkts_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static void nft_limit_bytes_eval(const struct nft_expr *expr,
@@ -298,7 +297,6 @@ static const struct nft_expr_ops nft_limit_bytes_ops = {
 	.dump		= nft_limit_bytes_dump,
 	.clone		= nft_limit_bytes_clone,
 	.destroy	= nft_limit_bytes_destroy,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/netfilter/nft_log.c b/net/netfilter/nft_log.c
index 4eb59c3f42b817..8258e12a5c9ead 100644
--- a/net/netfilter/nft_log.c
+++ b/net/netfilter/nft_log.c
@@ -290,7 +290,6 @@ static const struct nft_expr_ops nft_log_ops = {
 	.init		= nft_log_init,
 	.destroy	= nft_log_destroy,
 	.dump		= nft_log_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_log_type __read_mostly = {
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index fb4c129c63d302..11837d9f2594f7 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -226,17 +226,6 @@ static int nft_lookup_validate(const struct nft_ctx *ctx,
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
@@ -247,7 +236,6 @@ static const struct nft_expr_ops nft_lookup_ops = {
 	.destroy	= nft_lookup_destroy,
 	.dump		= nft_lookup_dump,
 	.validate	= nft_lookup_validate,
-	.reduce		= nft_lookup_reduce,
 };
 
 struct nft_expr_type nft_lookup_type __read_mostly = {
diff --git a/net/netfilter/nft_masq.c b/net/netfilter/nft_masq.c
index b38f455a6c99a2..d52f3f3419efb9 100644
--- a/net/netfilter/nft_masq.c
+++ b/net/netfilter/nft_masq.c
@@ -128,7 +128,6 @@ static const struct nft_expr_ops nft_masq_ipv4_ops = {
 	.destroy	= nft_masq_ipv4_destroy,
 	.dump		= nft_masq_dump,
 	.validate	= nft_masq_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_masq_ipv4_type __read_mostly = {
@@ -175,7 +174,6 @@ static const struct nft_expr_ops nft_masq_ipv6_ops = {
 	.destroy	= nft_masq_ipv6_destroy,
 	.dump		= nft_masq_dump,
 	.validate	= nft_masq_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_masq_ipv6_type __read_mostly = {
@@ -231,7 +229,6 @@ static const struct nft_expr_ops nft_masq_inet_ops = {
 	.destroy	= nft_masq_inet_destroy,
 	.dump		= nft_masq_dump,
 	.validate	= nft_masq_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_masq_inet_type __read_mostly = {
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 671923f4d9eb91..06d2af67ef0d3c 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -741,60 +741,16 @@ static int nft_meta_get_offload(struct nft_offload_ctx *ctx,
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
@@ -802,7 +758,6 @@ static const struct nft_expr_ops nft_meta_set_ops = {
 	.init		= nft_meta_set_init,
 	.destroy	= nft_meta_set_destroy,
 	.dump		= nft_meta_set_dump,
-	.reduce		= nft_meta_set_reduce,
 	.validate	= nft_meta_set_validate,
 };
 
diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index 4b855c277f5cc5..59083121415b41 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -321,7 +321,6 @@ static const struct nft_expr_ops nft_nat_ops = {
 	.destroy        = nft_nat_destroy,
 	.dump           = nft_nat_dump,
 	.validate	= nft_nat_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_nat_type __read_mostly = {
@@ -352,7 +351,6 @@ static const struct nft_expr_ops nft_nat_inet_ops = {
 	.destroy        = nft_nat_destroy,
 	.dump           = nft_nat_dump,
 	.validate	= nft_nat_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_inet_nat_type __read_mostly = {
diff --git a/net/netfilter/nft_numgen.c b/net/netfilter/nft_numgen.c
index 5b4dde41ec3632..830ff7301f7748 100644
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
@@ -176,16 +166,6 @@ static int nft_ng_random_dump(struct sk_buff *skb, const struct nft_expr *expr)
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
@@ -194,7 +174,6 @@ static const struct nft_expr_ops nft_ng_inc_ops = {
 	.init		= nft_ng_inc_init,
 	.destroy	= nft_ng_inc_destroy,
 	.dump		= nft_ng_inc_dump,
-	.reduce		= nft_ng_inc_reduce,
 };
 
 static const struct nft_expr_ops nft_ng_random_ops = {
@@ -203,7 +182,6 @@ static const struct nft_expr_ops nft_ng_random_ops = {
 	.eval		= nft_ng_random_eval,
 	.init		= nft_ng_random_init,
 	.dump		= nft_ng_random_dump,
-	.reduce		= nft_ng_random_reduce,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 35d8042464b300..11c263c50cd8fe 100644
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
index c8184264910552..781fcbf6ad4105 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -135,30 +135,6 @@ static int nft_osf_validate(const struct nft_ctx *ctx,
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
@@ -167,7 +143,6 @@ static const struct nft_expr_ops nft_osf_op = {
 	.dump		= nft_osf_dump,
 	.type		= &nft_osf_type,
 	.validate	= nft_osf_validate,
-	.reduce		= nft_osf_reduce,
 };
 
 static struct nft_expr_type nft_osf_type __read_mostly = {
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 22409dffce75a7..2906f40a37f842 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -213,31 +213,6 @@ static int nft_payload_dump(struct sk_buff *skb, const struct nft_expr *expr)
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
@@ -541,7 +516,6 @@ static const struct nft_expr_ops nft_payload_ops = {
 	.eval		= nft_payload_eval,
 	.init		= nft_payload_init,
 	.dump		= nft_payload_dump,
-	.reduce		= nft_payload_reduce,
 	.offload	= nft_payload_offload,
 };
 
@@ -551,7 +525,6 @@ const struct nft_expr_ops nft_payload_fast_ops = {
 	.eval		= nft_payload_eval,
 	.init		= nft_payload_init,
 	.dump		= nft_payload_dump,
-	.reduce		= nft_payload_reduce,
 	.offload	= nft_payload_offload,
 };
 
@@ -880,32 +853,12 @@ static int nft_payload_set_dump(struct sk_buff *skb, const struct nft_expr *expr
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
index 5fb9e89d929d2a..c99d4b9c33fa2c 100644
--- a/net/netfilter/nft_queue.c
+++ b/net/netfilter/nft_queue.c
@@ -189,7 +189,6 @@ static const struct nft_expr_ops nft_queue_ops = {
 	.init		= nft_queue_init,
 	.dump		= nft_queue_dump,
 	.validate	= nft_queue_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops nft_queue_sreg_ops = {
@@ -199,7 +198,6 @@ static const struct nft_expr_ops nft_queue_sreg_ops = {
 	.init		= nft_queue_sreg_init,
 	.dump		= nft_queue_sreg_dump,
 	.validate	= nft_queue_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static const struct nft_expr_ops *
diff --git a/net/netfilter/nft_quota.c b/net/netfilter/nft_quota.c
index 60e6d0c5f04ec4..c2b5bcc7ac056a 100644
--- a/net/netfilter/nft_quota.c
+++ b/net/netfilter/nft_quota.c
@@ -264,7 +264,6 @@ static const struct nft_expr_ops nft_quota_ops = {
 	.destroy	= nft_quota_destroy,
 	.clone		= nft_quota_clone,
 	.dump		= nft_quota_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_quota_type __read_mostly = {
diff --git a/net/netfilter/nft_range.c b/net/netfilter/nft_range.c
index 229f274f182382..172c96908b203a 100644
--- a/net/netfilter/nft_range.c
+++ b/net/netfilter/nft_range.c
@@ -137,7 +137,6 @@ static const struct nft_expr_ops nft_range_ops = {
 	.eval		= nft_range_eval,
 	.init		= nft_range_init,
 	.dump		= nft_range_dump,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 struct nft_expr_type nft_range_type __read_mostly = {
diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index ffde20e5cb5ebf..ba1864fc1be758 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -147,7 +147,6 @@ static const struct nft_expr_ops nft_redir_ipv4_ops = {
 	.destroy	= nft_redir_ipv4_destroy,
 	.dump		= nft_redir_dump,
 	.validate	= nft_redir_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_redir_ipv4_type __read_mostly = {
@@ -175,7 +174,6 @@ static const struct nft_expr_ops nft_redir_ipv6_ops = {
 	.destroy	= nft_redir_ipv6_destroy,
 	.dump		= nft_redir_dump,
 	.validate	= nft_redir_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_redir_ipv6_type __read_mostly = {
@@ -204,7 +202,6 @@ static const struct nft_expr_ops nft_redir_inet_ops = {
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
index ab507cf86e5835..afc8058c627c51 100644
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
index f56953f1022eb5..0fcb25ba64dd08 100644
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
index 10748572c075bc..d894cbe39d2ae7 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -290,7 +290,6 @@ static const struct nft_expr_ops nft_synproxy_ops = {
 	.dump		= nft_synproxy_dump,
 	.type		= &nft_synproxy_type,
 	.validate	= nft_synproxy_validate,
-	.reduce		= NFT_REDUCE_READONLY,
 };
 
 static struct nft_expr_type nft_synproxy_type __read_mostly = {
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index b848539f72a86c..4f41a70ce1890b 100644
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
index 1dda2096949d06..7265bb0c100459 100644
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
index 34a37699f90f7f..b0540cee997c07 100644
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

