Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712741D217
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970696; cv=none; b=n2IR07z1X1ys54HmphAmNWyp4FlKCa6i63QjRBYAXN3514m6ZUZRTA9Ixi84LN92IZdILnsyVEm8QIR36XquJKWFKY7uegPs4PbR5bqZeQyU33Hm2vhLJR7kDZSyufsArLExgVwSoKsIGmAIp7Ux61u4+I67VGNvHvXKnErsK7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970696; c=relaxed/simple;
	bh=anMeph4UEX4XhOJVM6+LmZtw3+CxkOMfa0jrNVlU1+E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lo/3fntI4PeApMR/26RITrB75RPSwXfPclcBFPbUyo0oA6qJbk/NFpwWiZr+B9uBpB+Cp6m1qJ/2HxSoiXvD3EQXwxQ43khfcix8SDVckvOTe5EuDVlrXckDGSYMC+TbEYrEPGBONgwne65a7bSLsCrEldpQd5T2WyEuJDK9AfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NYSrXMHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NYSrXMHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A8D1F000E9;
	Mon, 17 Aug 2026 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970695;
	bh=zjjgR1XTwr8Hgkjox+Hu4q5oZPjfkvbZqdJwP2NfyHM=;
	h=Subject:To:Cc:From:Date;
	b=NYSrXMHTCC5XNvvpKqFQDk1A5ctdFATEUUrfAZWH/Q9owN4FgzR1+ymiCxx9NTUgn
	 Ls+1sjhHYyFh/uP2BUdqYoBPczYZ4dkGY1VyqZ4bz7dvB0a7P2KUf+70GLs1LPn8aE
	 ZKm07dsypJWXZrUoSHw4MX/ZNSs9y4feVohlvsac=
Subject: FAILED: patch "[PATCH] net/sched: act_ct: fix sk_buff leak when the header checks" failed to apply to 6.1-stable tree
To: hj351016@gmail.com,jhs@mojatatu.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:43:53 +0200
Message-ID: <2026081753-suffix-dill-686c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8a7ed561671aa6a911a2de99e59ef670a4d0b1df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081753-suffix-dill-686c@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8a7ed561671aa6a911a2de99e59ef670a4d0b1df Mon Sep 17 00:00:00 2001
From: Hyunjung Ko <hj351016@gmail.com>
Date: Thu, 6 Aug 2026 19:12:34 +0900
Subject: [PATCH] net/sched: act_ct: fix sk_buff leak when the header checks
 reject a packet

tcf_ct_handle_fragments() runs its header sanity checks before handing
anything to the defragmentation engine:

	if (family == NFPROTO_IPV4)
		err = tcf_ct_ipv4_is_fragment(skb, &frag);
	else
		err = tcf_ct_ipv6_is_fragment(skb, &frag);
	if (err || !frag)
		return err;

tcf_ct_ipv4_is_fragment() returns -EINVAL or -ENOMEM;
tcf_ct_ipv6_is_fragment() adds -EPROTO when ipv6_find_hdr() fails. None of
them frees or queues the skb, so on that path the caller still owns it.

tcf_ct_act() however funnels every non-zero return into the
ownership-transfer exit:

	err = tcf_ct_handle_fragments(net, skb, family, p->zone, &defrag);
	if (err)
		goto out_frag;
	...
out_frag:
	if (err != -EINPROGRESS)
		tcf_action_inc_drop_qstats(&c->common);
	return TC_ACT_CONSUMED;

TC_ACT_CONSUMED means the action took ownership of the skb, so no caller
frees it - sch_handle_ingress(), sch_handle_egress() and
tcf_qevent_handle() all deliberately skip the free for that verdict. The
skb is therefore orphaned: one sk_buff plus its data buffer is leaked per
malformed packet, unbounded. Note the drop counter is already incremented
for these errors, so the statistics claim a drop that never happens.

Three different ownership states reach out_frag: today - the skb may be
queued by the defrag engine (-EINPROGRESS), already freed by
nf_ct_handle_fragments(), or still owned by us. Tell the caller which of
those it is, and free the packet ourselves in the last case, which
restores the TC_ACT_SHOT behaviour that predated the Fixes: commit.

Reproduced on v7.2-rc6 with a 54-byte frame carrying a 40-byte IPv6
header with nexthdr = 0 (hop-by-hop) and nothing after it, on a
clsact ingress chain with "action ct". kmemleak reports one leaked
232-byte skbuff_head_cache object plus its 704-byte data buffer per
packet; with this patch it reports none.

Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo frags")
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260806101235.809370-1-hj351016@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index be535a261fa0..e250969c84ac 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -840,8 +840,15 @@ static int tcf_ct_ipv6_is_fragment(struct sk_buff *skb, bool *frag)
 	return 0;
 }
 
+/* On error, tells the caller whether it still owns @skb and must free it
+ * itself.  @skb is ours only when the header checks below reject the packet
+ * before it is handed to the defragmentation engine; once nf_ct_handle_
+ * fragments() has been called the skb is either queued (-EINPROGRESS) or has
+ * already been freed by it.
+ */
 static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
-				   u8 family, u16 zone, bool *defrag)
+				   u8 family, u16 zone, bool *defrag,
+				   bool *skb_is_ours)
 {
 	enum ip_conntrack_info ctinfo;
 	struct tc_skb_cb cb;
@@ -859,8 +866,12 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 		err = tcf_ct_ipv4_is_fragment(skb, &frag);
 	else
 		err = tcf_ct_ipv6_is_fragment(skb, &frag);
-	if (err || !frag)
+	if (err) {
+		*skb_is_ours = true;
 		return err;
+	}
+	if (!frag)
+		return 0;
 
 	cb = *tc_skb_cb(skb);
 	err = nf_ct_handle_fragments(net, skb, zone, family, &proto, &cb.mru);
@@ -977,6 +988,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
 	bool add_helper = false;
+	bool skb_is_ours = false;
 	bool skip_add = false;
 	bool defrag = false;
 	struct nf_conn *ct;
@@ -1012,9 +1024,18 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	 */
 	nh_ofs = skb_network_offset(skb);
 	skb_pull_rcsum(skb, nh_ofs);
-	err = tcf_ct_handle_fragments(net, skb, family, p->zone, &defrag);
-	if (err)
+	err = tcf_ct_handle_fragments(net, skb, family, p->zone, &defrag,
+				      &skb_is_ours);
+	if (err) {
+		/* The skb is still ours only when the header checks rejected
+		 * it; returning TC_ACT_CONSUMED for such a packet would leak
+		 * it, since no caller frees an skb it was told it no longer
+		 * owns.
+		 */
+		if (skb_is_ours)
+			goto drop;
 		goto out_frag;
+	}
 
 	err = nf_ct_skb_network_trim(skb, family);
 	if (err)

