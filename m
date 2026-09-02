Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E147124C
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346419; cv=none; b=nr4sVJVFKGiIkbQ9rxb9ta3aUWbR67Jh6e27SMC5Wgb+dmJoFlLWtosQhwBdE5IQjled9K+q1imF9v0ERMlVkCHu+gZJgziVdlFO2iQb0D6jM5lS4UUI/Y60vvq1MzjweH9sfqhVwXbtyQwlfu8EGTYF5GeDceBhFxsiWMztAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346419; c=relaxed/simple;
	bh=FkfkU33ji3xNrYxBpwi9Ksh1EOsmVsEpXWWdc0uEj5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rR5D1K/q7ZV5p+UUU4iQuf9MvCSO+aWS3+FWENE1vi4+MCMBX9t+hhoRIXvbi+tsHnLg0F4JHp7o9MKIoW2uYYrKwZdH/e99KXBBc4Y+gCBg+BDjfgkEra4nQK9Ogmc8s4QjMDArbpQgoKbrlCRuR9A5FlT2ZnuPOjXBvqgI/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCVLZw7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCVLZw7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2EE1F00A3F;
	Wed,  2 Sep 2026 10:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346398;
	bh=WdamEbeB6LMS4I4Cysyfncx0hmmVAhEg8OaK9WbvyTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCVLZw7yVrr2lE6VWNPZbtLTUECj6jrD13QwmNI6s00fmJLbl6rcGXDuO0LaPdrH9
	 gbCQfNKygG7DzI3IGw5VAAAuCBzRBvwd6R+vSblHwZ1J+UpGImGGnpFOAYQwxB7W6+
	 9rljSUPRL9xWxcL278jx4sSZ900162rgUQwGfCGG2YEwaS6dWvFOzbnbP38ih4U9LJ
	 /ZnpFlHfpjWUgM8D4EYTDRVTjNnXxRfxzZE6NAl1quKJWP/+X3gt6hYjPmWRSck4vX
	 2zEScLd851l1PwlD8emMvkA0MxBdlNOJ6uNdotLqMV+4f9tk9cEBBxZTXvostgB6F/
	 T4AQw/9pKZo7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fourie Zhang <littleddfu@gmail.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Fourie Zhang <fouriezhang@tencent.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] netfilter: nf_tables: don't queue packet path object notifications
Date: Wed,  2 Sep 2026 06:53:14 -0400
Message-ID: <20260902105314.2047944-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902105314.2047944-1-sashal@kernel.org>
References: <2026083159-bullion-crease-8e08@gregkh>
 <20260902105314.2047944-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fourie Zhang <littleddfu@gmail.com>

[ Upstream commit 7904b94768e983bcb2be34a8d6d1f3450f5b838b ]

All file:line references below are against v7.2-rc4 (ac5b0e5651b1). The
trace was captured on 7.2.0-rc6-kasan72rc6 (075b74841bd0), where the same
lines apply.

nft_obj_notify() is exported and reached from the packet path. Its only
in-tree caller is nft_quota_obj_eval() (net/netfilter/nft_quota.c:68),
which notifies with GFP_ATOMIC while evaluating a rule for a transiting
packet, holding no mutex.

Since commit 67cc570edaa0 ("netfilter: nf_tables: coalesce multiple
notifications into one skbuff") that notification is no longer sent
immediately. __nft_obj_notify() queues it onto nft_net->notify_list via
nft_notify_enqueue() (net/netfilter/nf_tables_api.c:1211), which is a bare
list_add_tail(). notify_list has no lock of its own
(include/net/netfilter/nf_tables.h:1951), it is serialised by commit_mutex:
the six other enqueue sites all run inside a netlink transaction, and the
drain in nft_commit_notify() (net/netfilter/nf_tables_api.c:10746) does
list_del() + kfree_skb() from nf_tables_commit() with commit_mutex held.

Sending packets through a chain that references a depleted quota object
therefore races an unlocked list_add_tail() against list_del() +
kfree_skb() on another CPU. The WRITE_ONCE(prev->next, new) in __list_add()
then stores through an sk_buff that has already been freed:

  BUG: KASAN: slab-use-after-free in __nft_obj_notify+0x2c5/0x2d0
  Write of size 8 at addr ff110001047183c0 by task poc/76
  CPU: 0 UID: 1000 PID: 76 Comm: poc Tainted: G  W  7.2.0-rc6-kasan72rc6 #4
  Call Trace:
   <IRQ>
   __nft_obj_notify (include/linux/list.h:164 include/linux/list.h:191
                     net/netfilter/nf_tables_api.c:1211
                     net/netfilter/nf_tables_api.c:8743)
   nft_quota_obj_eval (net/netfilter/nft_quota.c:68)
   nft_do_chain_inet
   nf_hook_slow
   __ip_local_out
   ip_push_pending_frames
   udp_send_skb
   udp_sendmsg
   __x64_sys_sendto

  Allocated by task 77:
   __alloc_skb (net/core/skbuff.c:704)
   __nft_obj_notify (include/net/netlink.h:1055
                     net/netfilter/nf_tables_api.c:8731)
   nft_quota_obj_eval (net/netfilter/nft_quota.c:68)
   nft_do_chain

  Freed by task 79:
   nf_tables_commit (include/linux/skbuff.h:1332
                     net/netfilter/nf_tables_api.c:10759
                     net/netfilter/nf_tables_api.c:11185)
   nfnetlink_rcv_batch (net/netfilter/nfnetlink.c:574)
   netlink_unicast
   netlink_sendmsg

  The buggy address belongs to the cache skbuff_head_cache of size 232

Queueing from the packet path is wrong even leaving the race aside:
notify_list is only drained by nft_commit_notify() from nf_tables_commit()
(:11185), so a notification enqueued outside a transaction is not sent
until some later netlink batch commits, if one ever does.

The gfp argument that nft_obj_notify() still takes is a leftover of the
pre-67cc570edaa0 behaviour, where this path called nfnetlink_send()
directly. Restore that: split the message construction out into
nft_obj_notify_alloc() and let each caller decide what to do with the skb.
nft_obj_notify(), the exported one reached from the packet path, sends it
straight away; nf_tables_obj_notify(), which runs under commit_mutex, keeps
queueing it, so transaction notifications are still coalesced.

Fixes: 67cc570edaa0 ("netfilter: nf_tables: coalesce multiple notifications into one skbuff")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 36 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 4ee363ae9d3e8..9e5835181758f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6765,18 +6765,17 @@ static int nf_tables_delobj(struct net *net, struct sock *nlsk,
 	return nft_delobj(&ctx, obj);
 }
 
-static void
-__nft_obj_notify(struct net *net, const struct nft_table *table,
-		 struct nft_object *obj, u32 portid, u32 seq, int event,
-		 u16 flags, int family, int report, gfp_t gfp)
+static struct sk_buff *
+nft_obj_notify_alloc(struct net *net, const struct nft_table *table,
+		     struct nft_object *obj, u32 portid, u32 seq, int event,
+		     u16 flags, int family, int report, gfp_t gfp)
 {
-	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct sk_buff *skb;
 	int err;
 
 	if (!report &&
 	    !nfnetlink_has_listeners(net, NFNLGRP_NFTABLES))
-		return;
+		return NULL;
 
 	skb = nlmsg_new(NLMSG_GOODSIZE, gfp);
 	if (skb == NULL)
@@ -6790,10 +6789,10 @@ __nft_obj_notify(struct net *net, const struct nft_table *table,
 		goto err;
 	}
 
-	nft_notify_enqueue(skb, report, &nft_net->notify_list);
-	return;
+	return skb;
 err:
 	nfnetlink_set_err(net, portid, NFNLGRP_NFTABLES, -ENOBUFS);
+	return NULL;
 }
 
 void nft_obj_notify(struct net *net, const struct nft_table *table,
@@ -6802,6 +6801,7 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 {
 	char *buf = kasprintf(gfp, "%s:%u",
 			      table->name, nft_base_seq(net));
+	struct sk_buff *skb;
 
 	audit_log_nfcfg(buf,
 			family,
@@ -6812,17 +6812,27 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 			gfp);
 	kfree(buf);
 
-	__nft_obj_notify(net, table, obj, portid, seq, event,
-			 flags, family, report, gfp);
+	/* Called from the packet path, holding no mutex: notify_list is
+	 * serialised by commit_mutex, so send this notification directly.
+	 */
+	skb = nft_obj_notify_alloc(net, table, obj, portid, seq, event,
+				   flags, family, report, gfp);
+	if (skb)
+		nfnetlink_send(skb, net, portid, NFNLGRP_NFTABLES, report, gfp);
 }
 EXPORT_SYMBOL_GPL(nft_obj_notify);
 
 static void nf_tables_obj_notify(const struct nft_ctx *ctx,
 				 struct nft_object *obj, int event)
 {
-	__nft_obj_notify(ctx->net, ctx->table, obj, ctx->portid,
-			 ctx->seq, event, ctx->flags, ctx->family,
-			 ctx->report, GFP_KERNEL);
+	struct nftables_pernet *nft_net = nft_pernet(ctx->net);
+	struct sk_buff *skb;
+
+	skb = nft_obj_notify_alloc(ctx->net, ctx->table, obj, ctx->portid,
+				   ctx->seq, event, ctx->flags, ctx->family,
+				   ctx->report, GFP_KERNEL);
+	if (skb)
+		nft_notify_enqueue(skb, ctx->report, &nft_net->notify_list);
 }
 
 /*
-- 
2.53.0

