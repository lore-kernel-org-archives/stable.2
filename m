Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B074E5347
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674003; cv=none; b=MGPPbUy1o3leH5Cifa2iQsxdL6JI1omW7yazDhuLOBtJ00gtGGT83klFeeWzOs7G/yfR4AUICNWU6JNN2l8nFq+sUAs0+arBpP6YcsQav325/wIOr1HDKEdrAWpYChuEf+OMH9ilkGq+HuekmPQOG38nTwF2UCBOBEuYTZF5WS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674003; c=relaxed/simple;
	bh=v2krNhuSkyuBj1zQImUR8YL9Grl0nwKW8u0t4Hpxjtw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NS12/PGAIjlAwRiy4YIqZkqHbIamfHO7vi6qj564O984TWp0Nlv+PtwC7BVWGb080UuoHxK+ue7jPb3UArawKO+NHlM/XqWWXYBlvoUPUn5wN/FPYuIAZG52ADAA+Q98cMrlrfQh4oG3XuNVM8sI8/P48lqPegEpCpT1AtMo7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rPuBC+WD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rPuBC+WD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10E31F00893;
	Tue, 29 Sep 2026 09:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790673997;
	bh=s9VPSAcMe39Hrx6q/GDv9vRLeBkbnHVeNfuXQ7VRjdU=;
	h=Subject:To:Cc:From:Date;
	b=rPuBC+WD7PFLEiiAeZoY5luTYfntxAnI9craw83jMwRjMJOJybbmm5eD0DYT7WspL
	 LOFk8KoltTzmBSSYDnv3HFze1/hl4jq2IGBzzgp/FxiUQVMl/kOILqkBvJzwlAWKlR
	 90Io3Q3rLDSDT1MuuVt/3WLR37cFT6qQNfMNpd8U=
Subject: FAILED: patch "[PATCH] net/sched: act_ct: fix helper UAF due to extensions realloc" failed to apply to 6.12-stable tree
To: i.maximets@ovn.org,aconole@redhat.com,axel.mierczuk@1password.com,jhs@mojatatu.com,kuba@kernel.org,lucien.xin@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:26:24 +0200
Message-ID: <2026092924-carve-arrogant-1991@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x dad19b59da050cb60d3f7023dac2a042a84bf0bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092924-carve-arrogant-1991@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dad19b59da050cb60d3f7023dac2a042a84bf0bd Mon Sep 17 00:00:00 2001
From: Ilya Maximets <i.maximets@ovn.org>
Date: Mon, 21 Sep 2026 16:55:48 +0200
Subject: [PATCH] net/sched: act_ct: fix helper UAF due to extensions realloc

While calling the helpers, a raw pointer to the extensions area is
wired into expectations list:

  -> nf_ct_helper()
   -> helper->help()
    -> nf_ct_expect_related_report()
     -> nf_ct_expect_insert()
      -> hlist_add_head_rcu(&exp->lnode, &master_help->expectations)

In case the connection is not confirmed yet, more extensions can be
added afterwards with *_ext_add() calls reallocating the extension
space and leaving the now invalid pointer in the expectations list
that is later accessed while removing the expectation.

Make sure that helpers are called at the end after all the other
extensions are already added.

Note that the helper rejection now leaves the mark and labels set,
but that's not different from how the NAT was handled before or how
the mark and the labels were handled on confirmation failure.  And
there are no atomicity guarantees provided by the API anyway.

Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
Cc: stable@vger.kernel.org
Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260921145655.3167436-7-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index f62051ec9d57..411e3dd92d07 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1102,6 +1102,18 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		}
 	}
 
+	if (commit) {
+		tcf_ct_act_set_mark(ct, p->mark, p->mark_mask);
+		tcf_ct_act_set_labels(ct, p->labels, p->labels_mask);
+
+		if (!nf_ct_is_confirmed(ct))
+			nf_conn_act_ct_ext_add(skb, ct, ctinfo);
+	}
+
+	/* Run helpers for the connection if nf_conntrack_in() was executed
+	 * or if we're about to commit.  This has to be done after all the
+	 * extensions are already added.
+	 */
 	if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
 		err = nf_ct_helper(skb, ct, ctinfo, family);
 		if (err != NF_ACCEPT)
@@ -1109,12 +1121,6 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	}
 
 	if (commit) {
-		tcf_ct_act_set_mark(ct, p->mark, p->mark_mask);
-		tcf_ct_act_set_labels(ct, p->labels, p->labels_mask);
-
-		if (!nf_ct_is_confirmed(ct))
-			nf_conn_act_ct_ext_add(skb, ct, ctinfo);
-
 		/* This will take care of sending queued events
 		 * even if the connection is already confirmed.
 		 */

