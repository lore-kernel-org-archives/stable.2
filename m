Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EACC448CE9
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292470; cv=none; b=IfDjyOwFLa5iCDJIUQ+u/a80s8FC6b2jGX08TzcC1TNEzmB0J12nRqRBlmyMvyVoL4HZyQVBO12b8kP7ricnn2oTuimbF43SvPYDkUIxIciEm5Tf7s9Yb0XgjCKzCsbWKo4gJueNY8zthJrh+tP8WNMz9pBwDzSLQOBep8Prkm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292470; c=relaxed/simple;
	bh=7ndYxMa9HXcYzbxwJJXK+/FqdNsWA7UXMIE80kJAvao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=es0VwyDs8CYZkfofLhVsx3Mtw//cIqaqIH6q+u0d77QVYvBl+Yx43AzwCBVdI7p1CgAA4LiiLosTiyzPaYJG1XNDwAW+QFq5DOkwdU+Z0Yudsu9YuApFGPoa/19LOSUogiH4etqJkMzpz7LZ/a0ifQFGw4m1ytymPGesgAlLs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0X5KaaY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0X5KaaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1581F00A3A;
	Tue,  1 Sep 2026 19:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788292469;
	bh=GPvFg5zVB3X4jc0f4se9nzQPqvlRugaLHueFTKFWdUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D0X5KaaY0dsvAwRXkXVAfteYT0CLV/8geNfVeBTOcK5HjTJSVjOlQ3nCLNPczIIl6
	 b5rbzvm5+bc/MltLIifUwtHmn5U7qt+fDA80fAkYLy10Z2a1cpC7x9yNjLJOUzszdV
	 BpbXhVvt/0gE2AyCoGKN2/SHzCsVVr0QTy3NJa5xg6WjrAGCn/3/+SPOypikAkMGUV
	 G6xDraPU0dXozq+rcA44pP5JLsSsIGt8LhuQ88OvJUTZpSSZB7LTKemJwVLW5ZuK2U
	 Re2gnlQ1o/LsPSvtwbKBaWnoSSES9IfL3OucXMA2M5Z2pL50UTPV09C1QtH83LuHkg
	 aSn4sNfYFIR5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] netfilter: nf_tables: place base_seq in struct net
Date: Tue,  1 Sep 2026 15:54:25 -0400
Message-ID: <20260901195426.1450757-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901195426.1450757-1-sashal@kernel.org>
References: <2026083157-plexiglas-pouring-6a0f@gregkh>
 <20260901195426.1450757-1-sashal@kernel.org>
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
Stable-dep-of: 7904b94768e9 ("netfilter: nf_tables: don't queue packet path object notifications")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h |  1 -
 include/net/netns/nftables.h      |  1 +
 net/netfilter/nf_tables_api.c     | 58 +++++++++++++++----------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index e0b6c328d5377..cdd97037a1c21 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1753,7 +1753,6 @@ struct nftables_pernet {
 	struct mutex		commit_mutex;
 	u64			table_handle;
 	u64			tstamp;
-	unsigned int		base_seq;
 	u8			validate_state;
 	unsigned int		gc_seq;
 };
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
index 5fc2296d48c46..67b830b45cc4b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -944,11 +944,9 @@ nf_tables_chain_type_lookup(struct net *net, const struct nlattr *nla,
 	return ERR_PTR(-ENOENT);
 }
 
-static __be16 nft_base_seq(const struct net *net)
+static unsigned int nft_base_seq(const struct net *net)
 {
-	struct nftables_pernet *nft_net = nft_pernet(net);
-
-	return htons(nft_net->base_seq & 0xffff);
+	return READ_ONCE(net->nft.base_seq);
 }
 
 static const struct nla_policy nft_table_policy[NFTA_TABLE_MAX + 1] = {
@@ -968,7 +966,7 @@ static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -1052,7 +1050,7 @@ static int nf_tables_dump_tables(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -1793,7 +1791,7 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -1890,7 +1888,7 @@ static int nf_tables_dump_chains(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -3206,7 +3204,7 @@ static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
 	u16 type = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 
 	nlh = nfnl_msg_put(skb, portid, seq, type, flags, family, NFNETLINK_V0,
-			   nft_base_seq(net));
+			   htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -3352,7 +3350,7 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -4296,7 +4294,8 @@ static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
-			   NFNETLINK_V0, nft_base_seq(ctx->net));
+			   NFNETLINK_V0,
+			   htons(nft_base_seq(ctx->net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -4431,7 +4430,7 @@ static int nf_tables_dump_sets(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (ctx->family != NFPROTO_UNSPEC &&
@@ -5589,7 +5588,7 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (dump_ctx->ctx.family != NFPROTO_UNSPEC &&
@@ -5618,7 +5617,8 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	seq    = cb->nlh->nlmsg_seq;
 
 	nlh = nfnl_msg_put(skb, portid, seq, event, NLM_F_MULTI,
-			   table->family, NFNETLINK_V0, nft_base_seq(net));
+			   table->family, NFNETLINK_V0,
+			   htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -5688,7 +5688,8 @@ static int nf_tables_fill_setelem_info(struct sk_buff *skb,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
-			   NFNETLINK_V0, nft_base_seq(ctx->net));
+			   NFNETLINK_V0,
+			   htons(nft_base_seq(ctx->net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -7481,7 +7482,7 @@ static int nf_tables_fill_obj_info(struct sk_buff *skb, struct net *net,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -7538,7 +7539,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -7572,7 +7573,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 			idx++;
 		}
 		if (ctx->reset && entries)
-			audit_log_obj_reset(table, nft_net->base_seq, entries);
+			audit_log_obj_reset(table, nft_base_seq(net), entries);
 		if (rc < 0)
 			break;
 	}
@@ -7741,7 +7742,7 @@ static int nf_tables_getobj_reset(struct sk_buff *skb,
 	buf = kasprintf(GFP_ATOMIC, "%.*s:%u",
 			nla_len(nla[NFTA_OBJ_TABLE]),
 			(char *)nla_data(nla[NFTA_OBJ_TABLE]),
-			nft_net->base_seq);
+			nft_base_seq(net));
 	audit_log_nfcfg(buf, info->nfmsg->nfgen_family, 1,
 			AUDIT_NFT_OP_OBJ_RESET, GFP_ATOMIC);
 	kfree(buf);
@@ -8497,7 +8498,7 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, htons(nft_base_seq(net) & 0xffff));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -8553,7 +8554,7 @@ static int nf_tables_dump_flowtable(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -8735,17 +8736,16 @@ static void nf_tables_flowtable_destroy(struct nft_flowtable *flowtable)
 static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 				   u32 portid, u32 seq)
 {
-	struct nftables_pernet *nft_net = nft_pernet(net);
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
@@ -9824,11 +9824,11 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	 * Bump generation counter, invalidate any dump in progress.
 	 * Cannot fail after this point.
 	 */
-	base_seq = READ_ONCE(nft_net->base_seq);
+	base_seq = nft_base_seq(net);
 	while (++base_seq == 0)
 		;
 
-	WRITE_ONCE(nft_net->base_seq, base_seq);
+	WRITE_ONCE(net->nft.base_seq, base_seq);
 
 	gc_seq = nft_gc_seq_begin(nft_net);
 
@@ -10021,7 +10021,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 
 	nft_commit_notify(net, NETLINK_CB(skb).portid);
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
-	nf_tables_commit_audit_log(&adl, nft_net->base_seq);
+	nf_tables_commit_audit_log(&adl, nft_base_seq(net));
 
 	nft_gc_seq_end(nft_net, gc_seq);
 	nf_tables_commit_release(net);
@@ -10311,7 +10311,7 @@ static bool nf_tables_valid_genid(struct net *net, u32 genid)
 	mutex_lock(&nft_net->commit_mutex);
 	nft_net->tstamp = get_jiffies_64();
 
-	genid_ok = genid == 0 || nft_net->base_seq == genid;
+	genid_ok = genid == 0 || nft_base_seq(net) == genid;
 	if (!genid_ok)
 		mutex_unlock(&nft_net->commit_mutex);
 
@@ -10958,7 +10958,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 	INIT_LIST_HEAD(&nft_net->module_list);
 	INIT_LIST_HEAD(&nft_net->notify_list);
 	mutex_init(&nft_net->commit_mutex);
-	nft_net->base_seq = 1;
+	net->nft.base_seq = 1;
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
 	nft_net->gc_seq = 0;
 
-- 
2.53.0

