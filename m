Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483FB478870
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346421; cv=none; b=jyR+bb5xwk8thP0jWVRJo6KOAETcX8rpjne0bUlZdVhy8ziUgVuWM1nobVCDkCeI0HAzKVT7mxgrpL01W6EWzdWsmWg2VvvCY/tp/tOGfbvyYLlql6F6oGdsMf/BK4VNIdniaRoJFpDODPXZyd1EPHKyXCtvqgfzORQH4miULMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346421; c=relaxed/simple;
	bh=6PNR4DrHON0nCmyhUm6N+rqAbRMnuGzZ3NWWQee0Px8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0LOSoKVlP/AQk2/p5Mq03+sXNuMzl7G10o4pRMTB5k90ZsUsvueLoKVjled6ZjbecgKfJopSuy59dKtKeuimUmNAw6dkxBUtJHctTKkKiuZ0tWngIofJFLmdBQJKqB7BQSjCAK0KJ6vmN6BHh8CAnGU4FX4akGfrV4e/uESMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn2p289R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn2p289R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0CC1F000E9;
	Wed,  2 Sep 2026 10:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346397;
	bh=oO4ScmyTdjD0I4Xi44OMNnxeiU9zFeMibj0Mz3TJj+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fn2p289RKOGuJxZ51j4iyh3pydbry+7ACDQIUa856ltgiQURR3OnUu6mY18GkuKjr
	 ZIYtaK028lmZ87ZxSYn5vWx2rUPSurGoGEXIMuIr3HwvcroKlXuGtbgzYIO/kXdD82
	 ejUsWRRZFP97Bi27xaIyVswi1wZ/zoZBWxzFqQw5sZvAcagrkFYLvm2sD7ItxqDuzd
	 qadi3L+VtGWWW6bbwrRtTw2hq1CUhvkimil3tmU8SU6cZpsygQhg/VKfSe0BiqN1GZ
	 O594NSu6GYqdgLyJHGU82UNLG/y0OubKA/Zz2GQhBeYvzbDIkhq46e451xcgRShj+w
	 f/l+8jxktgAnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] netfilter: nf_tables: place base_seq in struct net
Date: Wed,  2 Sep 2026 06:53:13 -0400
Message-ID: <20260902105314.2047944-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083159-bullion-crease-8e08@gregkh>
References: <2026083159-bullion-crease-8e08@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 64102d9bbc3d41dac5188b8fba75b1344c438970 ]

This will soon be read from packet path around same time as the gencursor.

Both gencursor and base_seq get incremented almost at the same time, so
it makes sense to place them in the same structure.

This doesn't increase struct net size on 64bit due to padding.

Signed-off-by: Florian Westphal <fw@strlen.de>

Both gencursor and base_seq get incremented almost at the same time, so it makes sense to place them in the same structure.

This does not increase struct net size on 64bit due to padding.

For the 5.10 backport, keep the older netlink API and perform the 16-bit byte-order conversion at each header construction site. Also split the object notification wrapper and preserve its flags so the follow-up packet-path notification fix applies without pulling in unrelated newer nf_tables API changes.

Stable-dep-of: 7904b94768e9 ("netfilter: nf_tables: don't queue packet path object notifications")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h |   5 +-
 include/net/netns/nftables.h      |   1 +
 net/netfilter/nf_tables_api.c     | 110 +++++++++++++++++-------------
 net/netfilter/nft_quota.c         |   2 +-
 4 files changed, 67 insertions(+), 51 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index af9eaab50f056..fc42e0c032bc5 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1193,7 +1193,7 @@ struct nft_object *nft_obj_lookup(const struct net *net,
 
 void nft_obj_notify(struct net *net, const struct nft_table *table,
 		    struct nft_object *obj, u32 portid, u32 seq,
-		    int event, int family, int report, gfp_t gfp);
+		    int event, u16 flags, int family, int report, gfp_t gfp);
 
 /**
  *	struct nft_object_type - stateful object type
@@ -1611,13 +1611,14 @@ struct nftables_pernet {
 	struct list_head	notify_list;
 	struct mutex		commit_mutex;
 	u64			tstamp;
-	unsigned int		base_seq;
 	u8			validate_state;
 	unsigned int		gc_seq;
 };
 
 extern unsigned int nf_tables_net_id;
 
+#define nft_pernet(net)	net_generic(net, nf_tables_net_id)
+
 static inline u64 nft_net_tstamp(const struct net *net)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
diff --git a/include/net/netns/nftables.h b/include/net/netns/nftables.h
index 8c77832d02404..b9be4169317bf 100644
--- a/include/net/netns/nftables.h
+++ b/include/net/netns/nftables.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 
 struct netns_nftables {
+	unsigned int		base_seq;
 	u8			gencursor;
 };
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 15486d3051f6b..4ee363ae9d3e8 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -837,11 +837,9 @@ nf_tables_chain_type_lookup(struct net *net, const struct nlattr *nla,
 	return ERR_PTR(-ENOENT);
 }
 
-static __be16 nft_base_seq(const struct net *net)
+static unsigned int nft_base_seq(const struct net *net)
 {
-	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
-
-	return htons(nft_net->base_seq & 0xffff);
+	return READ_ONCE(net->nft.base_seq);
 }
 
 static const struct nla_policy nft_table_policy[NFTA_TABLE_MAX + 1] = {
@@ -861,7 +859,7 @@ static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -938,7 +936,7 @@ static int nf_tables_dump_tables(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = net_generic(net, nf_tables_net_id);
-	cb->seq = nft_net->base_seq;
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -1667,7 +1665,7 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -1760,7 +1758,7 @@ static int nf_tables_dump_chains(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = net_generic(net, nf_tables_net_id);
-	cb->seq = nft_net->base_seq;
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -3050,7 +3048,7 @@ static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
 	u16 type = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 
 	nlh = nfnl_msg_put(skb, portid, seq, type, flags, family, NFNETLINK_V0,
-			   nft_base_seq(net));
+			   htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -3178,7 +3176,7 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = net_generic(net, nf_tables_net_id);
-	cb->seq = nft_net->base_seq;
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -4075,7 +4073,8 @@ static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
-			   NFNETLINK_V0, nft_base_seq(ctx->net));
+			   NFNETLINK_V0,
+			   htons(nft_base_seq(ctx->net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -4194,7 +4193,7 @@ static int nf_tables_dump_sets(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	nft_net = net_generic(net, nf_tables_net_id);
-	cb->seq = nft_net->base_seq;
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (ctx->family != NFPROTO_UNSPEC &&
@@ -5134,7 +5133,8 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	seq    = cb->nlh->nlmsg_seq;
 
 	nlh = nfnl_msg_put(skb, portid, seq, event, NLM_F_MULTI,
-			   table->family, NFNETLINK_V0, nft_base_seq(net));
+			   table->family, NFNETLINK_V0,
+			   htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -5201,7 +5201,8 @@ static int nf_tables_fill_setelem_info(struct sk_buff *skb,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
-			   NFNETLINK_V0, nft_base_seq(ctx->net));
+			   NFNETLINK_V0,
+			   htons(nft_base_seq(ctx->net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -6487,7 +6488,7 @@ static int nf_tables_fill_obj_info(struct sk_buff *skb, struct net *net,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -6534,7 +6535,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	nft_net = net_generic(net, nf_tables_net_id);
-	cb->seq = nft_net->base_seq;
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -6559,7 +6560,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 				char *buf = kasprintf(GFP_ATOMIC,
 						      "%s:%u",
 						      table->name,
-						      nft_net->base_seq);
+						      nft_base_seq(net));
 
 				audit_log_nfcfg(buf,
 						family,
@@ -6680,11 +6681,10 @@ static int nf_tables_getobj(struct net *net, struct sock *nlsk,
 		reset = true;
 
 	if (reset) {
-		const struct nftables_pernet *nft_net;
 		char *buf;
 
-		nft_net = net_generic(net, nf_tables_net_id);
-		buf = kasprintf(GFP_ATOMIC, "%s:%u", table->name, nft_net->base_seq);
+		buf = kasprintf(GFP_ATOMIC, "%s:%u", table->name,
+				nft_base_seq(net));
 
 		audit_log_nfcfg(buf,
 				family,
@@ -6765,24 +6765,14 @@ static int nf_tables_delobj(struct net *net, struct sock *nlsk,
 	return nft_delobj(&ctx, obj);
 }
 
-void nft_obj_notify(struct net *net, const struct nft_table *table,
-		    struct nft_object *obj, u32 portid, u32 seq, int event,
-		    int family, int report, gfp_t gfp)
+static void
+__nft_obj_notify(struct net *net, const struct nft_table *table,
+		 struct nft_object *obj, u32 portid, u32 seq, int event,
+		 u16 flags, int family, int report, gfp_t gfp)
 {
-	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct sk_buff *skb;
 	int err;
-	char *buf = kasprintf(gfp, "%s:%u",
-			      table->name, nft_net->base_seq);
-
-	audit_log_nfcfg(buf,
-			family,
-			obj->handle,
-			event == NFT_MSG_NEWOBJ ?
-				 AUDIT_NFT_OP_OBJ_REGISTER :
-				 AUDIT_NFT_OP_OBJ_UNREGISTER,
-			gfp);
-	kfree(buf);
 
 	if (!report &&
 	    !nfnetlink_has_listeners(net, NFNLGRP_NFTABLES))
@@ -6792,8 +6782,9 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 	if (skb == NULL)
 		goto err;
 
-	err = nf_tables_fill_obj_info(skb, net, portid, seq, event, 0, family,
-				      table, obj, false);
+	err = nf_tables_fill_obj_info(skb, net, portid, seq, event,
+				      flags & (NLM_F_CREATE | NLM_F_EXCL),
+				      family, table, obj, false);
 	if (err < 0) {
 		kfree_skb(skb);
 		goto err;
@@ -6804,13 +6795,34 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 err:
 	nfnetlink_set_err(net, portid, NFNLGRP_NFTABLES, -ENOBUFS);
 }
+
+void nft_obj_notify(struct net *net, const struct nft_table *table,
+		    struct nft_object *obj, u32 portid, u32 seq, int event,
+		    u16 flags, int family, int report, gfp_t gfp)
+{
+	char *buf = kasprintf(gfp, "%s:%u",
+			      table->name, nft_base_seq(net));
+
+	audit_log_nfcfg(buf,
+			family,
+			obj->handle,
+			event == NFT_MSG_NEWOBJ ?
+				 AUDIT_NFT_OP_OBJ_REGISTER :
+				 AUDIT_NFT_OP_OBJ_UNREGISTER,
+			gfp);
+	kfree(buf);
+
+	__nft_obj_notify(net, table, obj, portid, seq, event,
+			 flags, family, report, gfp);
+}
 EXPORT_SYMBOL_GPL(nft_obj_notify);
 
 static void nf_tables_obj_notify(const struct nft_ctx *ctx,
 				 struct nft_object *obj, int event)
 {
-	nft_obj_notify(ctx->net, ctx->table, obj, ctx->portid, ctx->seq, event,
-		       ctx->family, ctx->report, GFP_KERNEL);
+	__nft_obj_notify(ctx->net, ctx->table, obj, ctx->portid,
+			 ctx->seq, event, ctx->flags, ctx->family,
+			 ctx->report, GFP_KERNEL);
 }
 
 /*
@@ -7444,7 +7456,7 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -7500,7 +7512,7 @@ static int nf_tables_dump_flowtable(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = net_generic(net, nf_tables_net_id);
-	cb->seq = nft_net->base_seq;
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -7680,17 +7692,16 @@ static void nf_tables_flowtable_destroy(struct nft_flowtable *flowtable)
 static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 				   u32 portid, u32 seq)
 {
-	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nlmsghdr *nlh;
 	char buf[TASK_COMM_LEN];
 	int event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, NFT_MSG_NEWGEN);
 
 	nlh = nfnl_msg_put(skb, portid, seq, event, 0, AF_UNSPEC,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
-	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_net->base_seq)) ||
+	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_base_seq(net))) ||
 	    nla_put_be32(skb, NFTA_GEN_PROC_PID, htonl(task_pid_nr(current))) ||
 	    nla_put_string(skb, NFTA_GEN_PROC_NAME, get_task_comm(buf, current)))
 		goto nla_put_failure;
@@ -8568,6 +8579,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	struct nft_trans_elem *te;
 	struct nft_chain *chain;
 	struct nft_table *table;
+	unsigned int base_seq;
 	unsigned int gc_seq;
 	LIST_HEAD(adl);
 	int err;
@@ -8638,8 +8650,10 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	 * Bump generation counter, invalidate any dump in progress.
 	 * Cannot fail after this point.
 	 */
-	while (++nft_net->base_seq == 0)
+	base_seq = nft_base_seq(net);
+	while (++base_seq == 0)
 		;
+	WRITE_ONCE(net->nft.base_seq, base_seq);
 
 	gc_seq = nft_gc_seq_begin(nft_net);
 
@@ -8824,7 +8838,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 
 	nft_commit_notify(net, NETLINK_CB(skb).portid);
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
-	nf_tables_commit_audit_log(&adl, nft_net->base_seq);
+	nf_tables_commit_audit_log(&adl, nft_base_seq(net));
 
 	nft_gc_seq_end(nft_net, gc_seq);
 	nf_tables_commit_release(net);
@@ -9103,7 +9117,7 @@ static bool nf_tables_valid_genid(struct net *net, u32 genid)
 	mutex_lock(&nft_net->commit_mutex);
 	nft_net->tstamp = get_jiffies_64();
 
-	genid_ok = genid == 0 || nft_net->base_seq == genid;
+	genid_ok = genid == 0 || nft_base_seq(net) == genid;
 	if (!genid_ok)
 		mutex_unlock(&nft_net->commit_mutex);
 
@@ -9711,7 +9725,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 	INIT_LIST_HEAD(&nft_net->module_list);
 	INIT_LIST_HEAD(&nft_net->notify_list);
 	mutex_init(&nft_net->commit_mutex);
-	nft_net->base_seq = 1;
+	net->nft.base_seq = 1;
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
 	nft_net->gc_seq = 0;
 
diff --git a/net/netfilter/nft_quota.c b/net/netfilter/nft_quota.c
index 0363f533a42b8..c4d1389f7185a 100644
--- a/net/netfilter/nft_quota.c
+++ b/net/netfilter/nft_quota.c
@@ -60,7 +60,7 @@ static void nft_quota_obj_eval(struct nft_object *obj,
 	if (overquota &&
 	    !test_and_set_bit(NFT_QUOTA_DEPLETED_BIT, &priv->flags))
 		nft_obj_notify(nft_net(pkt), obj->key.table, obj, 0, 0,
-			       NFT_MSG_NEWOBJ, nft_pf(pkt), 0, GFP_ATOMIC);
+			       NFT_MSG_NEWOBJ, 0, nft_pf(pkt), 0, GFP_ATOMIC);
 }
 
 static int nft_quota_do_init(const struct nlattr * const tb[],
-- 
2.53.0

