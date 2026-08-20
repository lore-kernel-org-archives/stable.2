Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D743718DB2A
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199703; cv=none; b=BAe/WwCxiHhvmNjGi1slcgngkWuBJZJh7ANKE+MklPcEII38qd2qLwJdk5WUlvpIXRH6w5wNWECVdx5zAnvG9v5GkcZXw6krJtEJhI/HnfMvlTUGkE23VSowJgpiEUzB4W9F7MiywxxxboH1PNNmusfXXKc720iWkLaCT2h1N6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199703; c=relaxed/simple;
	bh=0NHK+302PdQig3u1QQx2j5WdwX6uz4jD2bUmEC0Fne4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOnPDpHCtP0acv9IaerX/h32Luekm6BakaroZ0eu5K8jWvGVszy1r0ZFRg+jAVvGk/tAZMNQabIM3nBwZwxGIqYLkWd/uAHnX93PhSjpiVaZbT2+/rk4JXRhvQRVwNNCNMGkpJ6Yl7NSiFFYBWfQnx5zbdemjverBa4x+/c1Z2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYk17aEp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYk17aEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1551F000E9;
	Thu, 20 Aug 2026 04:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787199701;
	bh=oY/jJKjQrL2MeYFiixmRo1wiqg9mM+TfvBXlDTJajAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lYk17aEprGiW99pBHTU9CM3QzYFoXST7JkzDu3/gVdInzEsEdvJosck3sWXjk8Ttg
	 audJ7b8oxoU2X84xkyWhY0pTAtqCRe8sJeJBmbE3oKAE07OWiLeBZ89IdeYKBHHROR
	 FKHPbio9u5emhVI9MVyCSswCbXlzi+6xBK6icUKPWzwE+VtgeeSQQ0iGq65lm4ZwZQ
	 pvfZhaDVBriRI1RKo2ZccubCNcw3fTuBfX3D49ul3FHBO8SWCFVFnAM/owJU5lwRAE
	 WqGoWBBwc5+M3DmW7/11yVucWZRn3WFCja3RAlSkiVVc5G5N2ufvoGQWvb+HCrC7w9
	 hdVRuWBcfBL5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunjung Ko <hj351016@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] net/sched: act_ct: fix sk_buff leak when the header checks reject a packet
Date: Thu, 20 Aug 2026 00:21:35 -0400
Message-ID: <20260820042135.1376434-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820042135.1376434-1-sashal@kernel.org>
References: <2026081754-splendid-scabby-9156@gregkh>
 <20260820042135.1376434-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

[ Upstream commit 8a7ed561671aa6a911a2de99e59ef670a4d0b1df ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 0742060400805..f8c58a5876460 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -696,8 +696,15 @@ static int tcf_ct_ipv6_is_fragment(struct sk_buff *skb, bool *frag)
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
 	struct nf_conn *ct;
@@ -714,8 +721,12 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
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
 
 	mru = tc_skb_cb(skb)->mru;
 
@@ -961,6 +972,7 @@ static int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	struct nf_hook_state state;
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
+	bool skb_is_ours = false;
 	bool skip_add = false;
 	bool defrag = false;
 	struct nf_conn *ct;
@@ -997,9 +1009,18 @@ static int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
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
 
 	err = tcf_ct_skb_network_trim(skb, family);
 	if (err)
-- 
2.53.0

