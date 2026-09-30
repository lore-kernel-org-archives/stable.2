Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB03EED8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726680; cv=none; b=c/SEh93qsZ10Zl6i8MEi+aGWUPKsP4t4iXZmKjAN0+Ztnec1aa90aN8ShAOsPT8v+n8QA9e4jhdHSblT3iRHFurRwRX+IN0lVTYlV+Ez+NxwBSa3ST9rx6EraG4rrrvPbiIfk1XjyDGSrcVlke65/UPie+ArCc0aN3VUUCjbZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726680; c=relaxed/simple;
	bh=zzJOQMSoOP+PpeSDqkVrkUGBSjfpZO0zDS0OT7yWRNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNzaKuumZ9tNqcBfjY9E4FWTnFFCYLX6U4I19JZhcxQSnxupzKKSAFIoTwz1Y7i0oaes9GhyGP2ueuDPcodwjMGiUR/JaV/3KPdauBXEJMRn6pbgksNXptmnnbmjJSvZlaYWUW7iUqVbgo4LjP8RQVR0Lbl8r2QzG9aZI8CyluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcSvCaqz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcSvCaqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A661F00893;
	Wed, 30 Sep 2026 00:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726679;
	bh=J9k6hCosEss/3BDp9+ePrJG5i+iBXJVlR34llBMI6qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jcSvCaqz4nPXmSJ16x4Y2R7TSqMfjv42sUW3nG359NJzq23qg39hMbXPDXIT8NkB6
	 vbED8mcKTCy+x/F/09dS/DiKd2n4ZjyPXbXBfY4UtqVBk08tDB2/wpvlgTWV4fJEvg
	 mS+9QTZG85yhyhnIksNG8xdXayl2YRjy0LjQxGUr81074jDl/fsquh0PmVPXl8FS8J
	 PuIk5qujIZYn7m6bUO3Es5gXbuzochQIpYE+ppvF/YUbBWgPKV7CxkIeWTo3QnYBVL
	 2B4+p6daJTsi82h794IunqYevRE3O8/Fb8nAEG+aIJf7oVEiygL0tFyLXIlvnPG8BC
	 W5+xZ9XyNav0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	Aaron Conole <aconole@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] net/sched: act_ct: avoid modifying shared unconfirmed ct entry
Date: Tue, 29 Sep 2026 20:04:35 -0400
Message-ID: <20260930000435.2867626-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930000435.2867626-1-sashal@kernel.org>
References: <2026092927-fencing-hypnotize-05db@gregkh>
 <20260930000435.2867626-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit f85009dfcd65e5969526b0db7a49b5413746e630 ]

In a case where skb with an unconfirmed ct entry gets cloned, we may
end up processing both again but with different sets of extensions.

The series of events:

 1. The first clone wants to commit and runs the helpers wiring up
    the extension pointer into the expectation list.
 2. Then it looses the confirmation keeping the entry unconfirmed.
 3. Second clone now wants to commit labels or run NAT and adds the
    new extension for that breaking the pointer in the expectation
    list causing UAF on the destruction path later.

While this is possible to trigger, there should be no practical
network pipeline where we need to process both clones without
modifications in the same zone.  So, let's just reset the entry in
case for some reason we got an skb with a shared one.  This doesn't
affect any known use cases, but avoids any potential problems with
sharing and modification of the unconfirmed ct entry.

Unlike openvswitch module, act_ct allows for NAT without commit.
Changing that would be a uAPI break.  So, act_ct needs to reset on NAT
regardless of the commit flag to avoid reallocation of the extension
space.  This, however, doesn't really change the picture for sensible
networking cases as there should be no need to run the same packet
twice (before and after the clone) through conntrack without packet
header or zone changes and without commit.

The fixes tag points to the introduction of helpers, since that's the
main UAF trigger for the sharing.

Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
Cc: stable@vger.kernel.org
Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260921145655.3167436-5-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 370085ab6ea41..e77b6685dce7d 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -980,11 +980,11 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 				 struct tcf_result *res)
 {
 	struct net *net = dev_net(skb->dev);
+	bool cached, commit, clear, nat;
 	enum ip_conntrack_info ctinfo;
 	struct tcf_ct *c = to_ct(a);
 	struct nf_conn *tmpl = NULL;
 	struct nf_hook_state state;
-	bool cached, commit, clear;
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
 	bool add_helper = false;
@@ -999,6 +999,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	retval = p->action;
 	commit = p->ct_action & TCA_CT_ACT_COMMIT;
 	clear = p->ct_action & TCA_CT_ACT_CLEAR;
+	nat = p->ct_action & TCA_CT_ACT_NAT;
 	tmpl = p->tmpl;
 
 	tcf_lastuse_update(&c->tcf_tm);
@@ -1047,6 +1048,19 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	 * different zone.
 	 */
 	cached = tcf_ct_skb_nfct_cached(net, skb, p);
+
+	/* If the ct entry is not confirmed and shared with some other skb,
+	 * e.g., a cloned one, we can't just modify it with a commit or nat
+	 * as we must not modify the extension set.  Reset.
+	 */
+	if (cached && (commit || nat)) {
+		ct = nf_ct_get(skb, &ctinfo);
+		if (ct && !nf_ct_is_confirmed(ct) && nf_ct_shared(ct)) {
+			nf_reset_ct(skb);
+			cached = false;
+		}
+	}
+
 	if (!cached) {
 		if (tcf_ct_flow_table_lookup(p, skb, family)) {
 			skip_add = true;
@@ -1084,7 +1098,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		if (err)
 			goto drop;
 		add_helper = true;
-		if (p->ct_action & TCA_CT_ACT_NAT && !nfct_seqadj(ct)) {
+		if (nat && !nfct_seqadj(ct)) {
 			if (!nfct_seqadj_ext_add(ct))
 				goto drop;
 		}
-- 
2.53.0

