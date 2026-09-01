Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B446C838
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278557; cv=none; b=RzczywUkVpu/HF65gvsM4ofVLDshFpMunjWHvidR/LjdPVETP4ZB59pQpQlg8WbcCWZF6fvFSVKNck70FKMovs8jXQ2/fjdwdG6JRo/zP2HjbPwUiZRDsCDclqIeG0RW/3XuKiK5Wi3bnjxnksEzVbZYcFO1/UPbwQYtBllI/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278557; c=relaxed/simple;
	bh=3WA5I9FTVWOFPFInPxNR1N8Qye1sbT3dgmW1r0ws53s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANrNLyjW5sAkDj+XsakV2pHGI83Cz2LEpLvdKQN6bcZT3Sgapni2WDU3IslBe2haIx1vVEKcndv6WipRiSLUKANy/D4f5OlqNe9iWj2pFpQl/Wwco7ezMF1UdyVKSlRW3Ppvpih7IZ2Cn0zvZxp0eI8W1KBbv/Jj95xB/sF7/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy9fYLq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy9fYLq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9EB1F00A3A;
	Tue,  1 Sep 2026 16:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788278556;
	bh=UQK/+CyDHWOLpJvw77acrn1Cv31r627vJoklEjL4Kjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sy9fYLq0UVZXuQapeyEFoYAEK+nCQrBXg6U84aGDBAYoc7RHmN8QJmu97TOrTz0JD
	 tQEmSeLU67he0PstPq/lSAKEWEXfxi1ghfdvYmcROA0+tSL8UtmUAUjFUXnGEMLedU
	 4ilq/etPiTACK7GWOtmDLTWmeaWTGXuTuc9SFa8apbb2lsIkYHXhrpLFi8ihnobmUi
	 kWWuft9K9qsbyiyVf4kZVegV04kSOcAnmYzsGw0IcYUebXZirgPht4yfS/LWoA2y2V
	 +u8j/JX0wV9EZi/Hyn97beFJ3Z9ETsavJlP2FPzI7RY6LpYH5cPYM9dgiYvSbwsL8t
	 533uSVKv8v/dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] netfilter: nft_set_rbtree: Remove unused variable nft_net
Date: Tue,  1 Sep 2026 12:02:32 -0400
Message-ID: <20260901160234.1283938-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083157-seldom-action-9ebb@gregkh>
References: <2026083157-seldom-action-9ebb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yang Li <yang.lee@linux.alibaba.com>

[ Upstream commit 67059b61597c004e23b074547b40604222bee3a0 ]

The code that uses nft_net has been removed, and the nft_pernet function
is merely obtaining a reference to shared data through the net pointer.
The content of the net pointer is not modified or changed, so both of
them should be removed.

silence the warning:
net/netfilter/nft_set_rbtree.c:627:26: warning: variable ‘nft_net’ set but not used

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7103
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 7904b94768e9 ("netfilter: nf_tables: don't queue packet path object notifications")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c  | 28 +++++++++++++++-------------
 net/netfilter/nft_set_rbtree.c |  2 --
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2c894a7d8a401..19c92fc457e4a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -922,11 +922,11 @@ nf_tables_chain_type_lookup(struct net *net, const struct nlattr *nla,
 	return ERR_PTR(-ENOENT);
 }
 
-static __be16 nft_base_seq(const struct net *net)
+static unsigned int nft_base_seq(const struct net *net)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 
-	return htons(nft_net->base_seq & 0xffff);
+	return READ_ONCE(nft_net->base_seq);
 }
 
 static const struct nla_policy nft_table_policy[NFTA_TABLE_MAX + 1] = {
@@ -946,7 +946,7 @@ static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -1789,7 +1789,7 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -3398,7 +3398,7 @@ static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
 	u16 type = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 
 	nlh = nfnl_msg_put(skb, portid, seq, type, flags, family, NFNETLINK_V0,
-			   nft_base_seq(net));
+			   htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -4593,7 +4593,8 @@ static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
-			   NFNETLINK_V0, nft_base_seq(ctx->net));
+			   NFNETLINK_V0,
+			   htons(nft_base_seq(ctx->net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -5938,7 +5939,8 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	seq    = cb->nlh->nlmsg_seq;
 
 	nlh = nfnl_msg_put(skb, portid, seq, event, NLM_F_MULTI,
-			   table->family, NFNETLINK_V0, nft_base_seq(net));
+			   table->family, NFNETLINK_V0,
+			   htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -6018,7 +6020,8 @@ static int nf_tables_fill_setelem_info(struct sk_buff *skb,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
-			   NFNETLINK_V0, nft_base_seq(ctx->net));
+			   NFNETLINK_V0,
+			   htons(nft_base_seq(ctx->net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -7838,7 +7841,7 @@ static int nf_tables_fill_obj_info(struct sk_buff *skb, struct net *net,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -8205,9 +8208,8 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 		    struct nft_object *obj, u32 portid, u32 seq, int event,
 		    u16 flags, int family, int report, gfp_t gfp)
 {
-	struct nftables_pernet *nft_net = nft_pernet(net);
 	char *buf = kasprintf(gfp, "%s:%u",
-			      table->name, nft_net->base_seq);
+			      table->name, nft_base_seq(net));
 
 	audit_log_nfcfg(buf,
 			family,
@@ -8872,7 +8874,7 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -9119,7 +9121,7 @@ static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 	int event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, NFT_MSG_NEWGEN);
 
 	nlh = nfnl_msg_put(skb, portid, seq, event, 0, AF_UNSPEC,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 9c9b07f2def1b..91d677b692f7e 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -653,7 +653,6 @@ static void nft_rbtree_gc(struct nft_set *set)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe, *rbe_end = NULL;
-	struct nftables_pernet *nft_net;
 	struct net *net = read_pnet(&set->net);
 	u64 tstamp = nft_net_tstamp(net);
 	struct rb_node *node, *next;
@@ -661,7 +660,6 @@ static void nft_rbtree_gc(struct nft_set *set)
 
 	set  = nft_set_container_of(priv);
 	net  = read_pnet(&set->net);
-	nft_net = nft_pernet(net);
 
 	gc = nft_trans_gc_alloc(set, 0, GFP_KERNEL);
 	if (!gc)
-- 
2.53.0

