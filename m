Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9B3C0A02
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181153; cv=none; b=Vw2YDBw6oXVhwg9Ct9LbmQEd6ZuT0CJwhPrZKDALN39xM7/WyLuzcIJR8z/C2VhC+91cqHItLEu2VZ2nDbwAKmujVMQJGVTiwjqTzj0BMZWH43eXJuxt9KdZZKrb+Yi+i6AfhktWPjjtUy0yoyPNf8aGN7IY0n6waZ7D2sbDbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181153; c=relaxed/simple;
	bh=nLqs0Z55xX1WKTIVbunRPvGkQ8l+MZvJvFNAV7G2pPs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UrQ8RFg0+k5uQwOcg9k1wfWRHAg8X60CjByLwRBmlCHgBqX7nHnyTw2l7kU655worcRsx2qEH7bIaxW7FeZBhOdO37mvTQFDRTrCUsGsQY0xFcQXFnzs7rn6SGgasniEDdPtEZtWIY8t8bYh9vZ0kG3BIJaXsJNUthUlA88aRuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PGqCvBQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PGqCvBQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AAB1F000E9;
	Mon, 31 Aug 2026 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788181151;
	bh=6j7B7EvSIR92iK98aDWzjBn4kNyP+OMp/c3lb18RbaA=;
	h=Subject:To:Cc:From:Date;
	b=PGqCvBQ2NR5y6s0lOt4Es5Ts7OG4ZtAH1bBkx9pM1JwcLUY865vEfQO0/rVpiWq1M
	 hiy4IYe9N4jKdmVF2wOr0QVcaqUq8LH5LqjBCNoyxT10VZqJKUr4NcOKyXPMIGYKi1
	 uxLdIXzRc93e+NAh79Q2N3WSypAJ3aumA2isfF28=
Subject: FAILED: patch "[PATCH] netfilter: nf_tables: don't queue packet path object" failed to apply to 6.6-stable tree
To: littleddfu@gmail.com,corvus@tencent.com,fouriezhang@tencent.com,pablo@netfilter.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:58:57 +0200
Message-ID: <2026083157-seldom-action-9ebb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7904b94768e983bcb2be34a8d6d1f3450f5b838b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083157-seldom-action-9ebb@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7904b94768e983bcb2be34a8d6d1f3450f5b838b Mon Sep 17 00:00:00 2001
From: Fourie Zhang <littleddfu@gmail.com>
Date: Mon, 10 Aug 2026 19:35:01 +0800
Subject: [PATCH] netfilter: nf_tables: don't queue packet path object
 notifications

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

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index af357f6c5070..3a7c8f7a6304 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8715,18 +8715,17 @@ static int nf_tables_delobj(struct sk_buff *skb, const struct nfnl_info *info,
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
@@ -8740,10 +8739,10 @@ __nft_obj_notify(struct net *net, const struct nft_table *table,
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
@@ -8752,6 +8751,7 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 {
 	char *buf = kasprintf(gfp, "%s:%u",
 			      table->name, nft_base_seq(net));
+	struct sk_buff *skb;
 
 	audit_log_nfcfg(buf,
 			family,
@@ -8762,17 +8762,27 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
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

