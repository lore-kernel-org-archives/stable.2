Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26163BB102
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673885; cv=none; b=D6ctGAC3A/htNKJ+h7MRHXKp5sobtQ0j/DHkxU4CWcomNVmpvejIbe9Yozlh3DhM9EuCd9qq/ywwuTRlojZwx2LrwZi3p3yCZDSKN6oUDDa/8rkueHXJhUWissximofA7JQacb1uSA8ody6/+t8E9B5kK6fggCtM6w30jNB/F7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673885; c=relaxed/simple;
	bh=xfwfeeN4qQAICbk+ZvD1phfRy7IPlbIreiWnGYBWovs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XP2yREel9uxS8tu6HcJ7i9UdZ4trknok3W6AkDA4/hz6GwxbcK8sZgB5WvcSeI0xQRcH3wSpxyP7h6Us4yZ4bOpaLF4LzdpLswDkhwOZpIJRm9QbUR7HlnhiPrhoxDUrVEDGiMQE3gRrcRfJtYmPNPL/J5g10csE/CDP+1xcIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EiV2Oora; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EiV2Oora"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD4D1F000FF;
	Tue, 29 Sep 2026 09:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790673881;
	bh=EcT7c4s8IUZaI8jTjsEfI87xnXQwxsmAZZADtPLcHcU=;
	h=Subject:To:Cc:From:Date;
	b=EiV2OorauMcCdCWZjqxj+oiZiducKn4e6hceuYJ1DBpFBzPPZN7F9+l1uorHmw4zX
	 XQykGNICOY5regBFL2/0EBJNX1TxrvbyPZk19JI4pJk3fsuEf2qj7eOgj84/KcSNv6
	 c/rLcAQL0fQW4VIJ5UF+SLuCri2xRwDTamCex+1o=
Subject: FAILED: patch "[PATCH] net/sched: act_ct: avoid modifying shared unconfirmed ct" failed to apply to 6.18-stable tree
To: i.maximets@ovn.org,aconole@redhat.com,axel.mierczuk@1password.com,jhs@mojatatu.com,kuba@kernel.org,lucien.xin@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:24:27 +0200
Message-ID: <2026092927-flatness-surprise-1efc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f85009dfcd65e5969526b0db7a49b5413746e630
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092927-flatness-surprise-1efc@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f85009dfcd65e5969526b0db7a49b5413746e630 Mon Sep 17 00:00:00 2001
From: Ilya Maximets <i.maximets@ovn.org>
Date: Mon, 21 Sep 2026 16:55:46 +0200
Subject: [PATCH] net/sched: act_ct: avoid modifying shared unconfirmed ct
 entry

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

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 55f3521edb4c..e72143d36b11 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -979,11 +979,11 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
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
@@ -998,6 +998,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	retval = p->action;
 	commit = p->ct_action & TCA_CT_ACT_COMMIT;
 	clear = p->ct_action & TCA_CT_ACT_CLEAR;
+	nat = p->ct_action & TCA_CT_ACT_NAT;
 	tmpl = p->tmpl;
 
 	tcf_lastuse_update(&c->tcf_tm);
@@ -1046,6 +1047,19 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
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
@@ -1083,7 +1097,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		if (err)
 			goto drop;
 		add_helper = true;
-		if (p->ct_action & TCA_CT_ACT_NAT && !nfct_seqadj(ct)) {
+		if (nat && !nfct_seqadj(ct)) {
 			if (!nfct_seqadj_ext_add(ct))
 				goto drop;
 		}

