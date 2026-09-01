Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445A643CE72
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278558; cv=none; b=kAa+gLkAqUs2W4QN/3aHoitzWwRSt8r4SJTfqEv35fTtqsy1HDBgG/DMV1sKnvvhtY3PLr+myMjuPXEvILxnAYzdfHKMU7OSpsB/yj94O077bGHBjpMdxeRYNnRm3Crjrqzf3GVekaW/Z71hYnfxEQ9sfEJaRZ9OmXvM/bXvCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278558; c=relaxed/simple;
	bh=cK0qTLZam/abaC1amg4Ao1WJnvylYM81IoCtwvym6FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqFM4qp1VsIHm13fW/sFrRptxT+Z5nu4bE4PlyIq7KdACFk6aIDNWHrjKiKdY/pX+5c8cwlB5+gQDodriYfKb/DGf+K1QGvJOzoMm8khzY6K+ZFBl0xEyTRxalhOKDLPn6/MJ6gQFjDu1Wz2D3Frobn5T1EDyMkeuYcGm8rRXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejqxBCQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejqxBCQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838A41F000E9;
	Tue,  1 Sep 2026 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788278556;
	bh=RqkF5L790EHpc/OBL8YmPltqJs7i15ecdgOG6FSQ35s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ejqxBCQSUNbSTOkEsay3WLp0n1gfPtAFbKjeD4h64PJl3DAe0e/acmRLJlJ2WZ921
	 7pC5MFMpJFYXq/j4yNztEEaG4H6oLxEV1cUmn7bU8I45WFuyO2AECvA/UG6H9S1JTa
	 SW1tqJzFgspa8bHsoNb/EWqhLd+M3hE+G8pK3R0F8q2cLeV1y3X4R1ZT8sXiLHWBB3
	 eNfRhecgcBORfma43zQ2toDyznSLCOoKv9/nESEpPZistSy00y21jxgZ/VxQ6Q4UUX
	 4DFGmfQt5mmu+HJJHMLNKUGH160xdP/iuYnSM2WfRNiGSbBjIV3m6blImbHCBjNYpM
	 EyioMf6rSEHCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] netfilter: nf_tables: place base_seq in struct net
Date: Tue,  1 Sep 2026 12:02:33 -0400
Message-ID: <20260901160234.1283938-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901160234.1283938-1-sashal@kernel.org>
References: <2026083157-seldom-action-9ebb@gregkh>
 <20260901160234.1283938-1-sashal@kernel.org>
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
 net/netfilter/nf_tables_api.c     | 40 ++++++++++++++-----------------
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 4056d22724873..c5454104da8b3 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1817,7 +1817,6 @@ struct nftables_pernet {
 	struct mutex		commit_mutex;
 	u64			table_handle;
 	u64			tstamp;
-	unsigned int		base_seq;
 	unsigned int		gc_seq;
 	u8			validate_state;
 };
diff --git a/include/net/netns/nftables.h b/include/net/netns/nftables.h
index cc8060c017d5f..99dd166c5d07c 100644
--- a/include/net/netns/nftables.h
+++ b/include/net/netns/nftables.h
@@ -3,6 +3,7 @@
 #define _NETNS_NFTABLES_H_
 
 struct netns_nftables {
+	unsigned int		base_seq;
 	u8			gencursor;
 };
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 19c92fc457e4a..f1228c1cc36f1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -924,9 +924,7 @@ nf_tables_chain_type_lookup(struct net *net, const struct nlattr *nla,
 
 static unsigned int nft_base_seq(const struct net *net)
 {
-	struct nftables_pernet *nft_net = nft_pernet(net);
-
-	return READ_ONCE(nft_net->base_seq);
+	return READ_ONCE(net->nft.base_seq);
 }
 
 static const struct nla_policy nft_table_policy[NFTA_TABLE_MAX + 1] = {
@@ -1033,7 +1031,7 @@ static int nf_tables_dump_tables(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -1885,7 +1883,7 @@ static int nf_tables_dump_chains(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -3569,7 +3567,7 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -3708,7 +3706,6 @@ nf_tables_getrule_single(u32 portid, const struct nfnl_info *info,
 static int nf_tables_getrule(struct sk_buff *skb, const struct nfnl_info *info,
 			     const struct nlattr * const nla[])
 {
-	struct nftables_pernet *nft_net = nft_pernet(info->net);
 	u32 portid = NETLINK_CB(skb).portid;
 	struct net *net = info->net;
 	struct sk_buff *skb2;
@@ -3740,7 +3737,7 @@ static int nf_tables_getrule(struct sk_buff *skb, const struct nfnl_info *info,
 	buf = kasprintf(GFP_ATOMIC, "%.*s:%u",
 			nla_len(nla[NFTA_RULE_TABLE]),
 			(char *)nla_data(nla[NFTA_RULE_TABLE]),
-			nft_net->base_seq);
+			nft_base_seq(net));
 	audit_log_nfcfg(buf, info->nfmsg->nfgen_family, 1,
 			AUDIT_NFT_OP_RULE_RESET, GFP_ATOMIC);
 	kfree(buf);
@@ -4730,7 +4727,7 @@ static int nf_tables_dump_sets(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (ctx->family != NFPROTO_UNSPEC &&
@@ -5910,7 +5907,7 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (dump_ctx->ctx.family != NFPROTO_UNSPEC &&
@@ -6257,7 +6254,7 @@ static int nf_tables_getsetelem(struct sk_buff *skb,
 	}
 
 	if (reset)
-		audit_log_nft_set_reset(table, nft_pernet(net)->base_seq,
+		audit_log_nft_set_reset(table, nft_base_seq(net),
 					nelems);
 
 	return err;
@@ -7900,7 +7897,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -7934,7 +7931,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 			idx++;
 		}
 		if (ctx->reset && entries)
-			audit_log_obj_reset(table, nft_net->base_seq, entries);
+			audit_log_obj_reset(table, nft_base_seq(net), entries);
 		if (rc < 0)
 			break;
 	}
@@ -8103,7 +8100,7 @@ static int nf_tables_getobj_reset(struct sk_buff *skb,
 	buf = kasprintf(GFP_ATOMIC, "%.*s:%u",
 			nla_len(nla[NFTA_OBJ_TABLE]),
 			(char *)nla_data(nla[NFTA_OBJ_TABLE]),
-			nft_net->base_seq);
+			nft_base_seq(net));
 	audit_log_nfcfg(buf, info->nfmsg->nfgen_family, 1,
 			AUDIT_NFT_OP_OBJ_RESET, GFP_ATOMIC);
 	kfree(buf);
@@ -8935,7 +8932,7 @@ static int nf_tables_dump_flowtable(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -9115,7 +9112,6 @@ static void nf_tables_flowtable_destroy(struct nft_flowtable *flowtable)
 static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 				   u32 portid, u32 seq)
 {
-	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct nlmsghdr *nlh;
 	char buf[TASK_COMM_LEN];
 	int event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, NFT_MSG_NEWGEN);
@@ -9125,7 +9121,7 @@ static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 	if (!nlh)
 		goto nla_put_failure;
 
-	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_net->base_seq)) ||
+	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_base_seq(net))) ||
 	    nla_put_be32(skb, NFTA_GEN_PROC_PID, htonl(task_pid_nr(current))) ||
 	    nla_put_string(skb, NFTA_GEN_PROC_NAME, get_task_comm(buf, current)))
 		goto nla_put_failure;
@@ -10253,11 +10249,11 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
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
 
@@ -10474,7 +10470,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 
 	nft_commit_notify(net, NETLINK_CB(skb).portid);
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
-	nf_tables_commit_audit_log(&adl, nft_net->base_seq);
+	nf_tables_commit_audit_log(&adl, nft_base_seq(net));
 
 	nft_gc_seq_end(nft_net, gc_seq);
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
@@ -10794,7 +10790,7 @@ static bool nf_tables_valid_genid(struct net *net, u32 genid)
 	mutex_lock(&nft_net->commit_mutex);
 	nft_net->tstamp = get_jiffies_64();
 
-	genid_ok = genid == 0 || nft_net->base_seq == genid;
+	genid_ok = genid == 0 || nft_base_seq(net) == genid;
 	if (!genid_ok)
 		mutex_unlock(&nft_net->commit_mutex);
 
@@ -11458,7 +11454,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 	INIT_LIST_HEAD(&nft_net->module_list);
 	INIT_LIST_HEAD(&nft_net->notify_list);
 	mutex_init(&nft_net->commit_mutex);
-	nft_net->base_seq = 1;
+	net->nft.base_seq = 1;
 	nft_net->gc_seq = 0;
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
 
-- 
2.53.0

