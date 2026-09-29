Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A154E9C35
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673061; cv=none; b=Y1vhLMnCBc5zDvMy7w+RKISbK12ynejdIyjncSnh0SjD4uNxyBI+1eOfnN6/ZdjqGr+MoG/CcruW/2yDDa8yb0Bf/9McrlIwzMXCA0DduFjdDEAhs/U+YuNAVFQSPfML08UZI2NG6XCZ4+7TOwBR+7HESAaumO/883UZRX+V2WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673061; c=relaxed/simple;
	bh=nOQyl/gytjfOZ4BSoNKuX8HkWUi1ZwveoEp3VJ2GM8k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gDY0qmYHBxPUty2pj+p4nHR0s7w6wAc2k7ecEslujzfjoR7wf6LEc7lPP66qfqQhfdlc7S6qpOEPHgI+r/k5uJuRsOJQyNFIP17wIiSavAcdIJxwCAgFJQsV45zerV3Zvdudy3yThhMn4zZ9kFYC0mEMcGqsB9zwJob8nPDaV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DIc9lju0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DIc9lju0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787111F00893;
	Tue, 29 Sep 2026 09:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790673055;
	bh=qMXK11FeSpAFShJdnZW2YSRjOumGrrYJErvpfczVEQQ=;
	h=Subject:To:Cc:From:Date;
	b=DIc9lju0K+im4IFmwRhK2RnDkq/PcADtIUePvGBDO8ZAiL8vCSI1fRKNKArHp9ROj
	 FxTpFlT/YbQzE99t09AZhCQJ+7QwhhsSOKkxFxtNrFCqcmvVGV+qmZIFB8cdEK2YGX
	 pjLRCPBc58fEQCaS1RfQ0FM+b2S5OcEQKLj1T8u4=
Subject: FAILED: patch "[PATCH] net/sched: act_ct: fix helper UAF due to extensions realloc" failed to apply to 6.6-stable tree
To: i.maximets@ovn.org,aconole@redhat.com,axel.mierczuk@1password.com,jhs@mojatatu.com,kuba@kernel.org,lucien.xin@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:10:49 +0200
Message-ID: <2026092949-ceremony-whomever-76f9@gregkh>
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
git cherry-pick -x dad19b59da050cb60d3f7023dac2a042a84bf0bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092949-ceremony-whomever-76f9@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

