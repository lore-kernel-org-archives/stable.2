Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38263B5F5D
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673975; cv=none; b=TF5wwd2b2SzPMVpLr2NqsSRMPwxnh13DEPyfVgBpuI/kDjrhDM32PfqLTjuPxHvbITRT/tqHeQIysD+PdenEHmBPvJsOyCaeg9QC8Q5YiMc70AguJ/kCNDh3uoMIKIXoi1AAMNe2jiuKUlcdmQLezDN7e/UKSOLJUPnK48zCo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673975; c=relaxed/simple;
	bh=oMRLZlJaub3svmMIuiIcjKlD2yG/KCKsdl6F4bnq7Qc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AoInltkunbMsLCRbzpw+hfai08x8JJrWqhzp3cmQ4NHjXTJWxhm6WUHYWqAxvewULNsW2agfp8ykvS/48+5OMY89WwdyLsY0Q9XuKHMKIx5UJYBcqnRXylQRT7AvBfeUJ8Esdul6bfvGyzDa+27aorFUqHaOIcvx7JdCY1gKeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b8CZAwX1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b8CZAwX1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644781F000FF;
	Tue, 29 Sep 2026 09:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790673969;
	bh=GWO5lcpxioXxvj25LEkjEv88jMn3pW3LjwveBilXX2A=;
	h=Subject:To:Cc:From:Date;
	b=b8CZAwX1Aq0XEtYkP0CFInlmAb1SK7QlCbPxm/H+cGpZ+oDivOuS4cgVjkbHe/9I1
	 2PcCTGPZg5OHz2cR6xfe4qVBNrUv0cNVK1+KPup/dzzR2CO9Fbi2HzFvExyl3dETfT
	 kRNIDMffTXuTu04zOwNvKS+Oik/fc6u1qYiJx45o=
Subject: FAILED: patch "[PATCH] net/sched: act_ct: remove 'add_helper' dead code" failed to apply to 6.12-stable tree
To: i.maximets@ovn.org,aconole@redhat.com,jhs@mojatatu.com,kuba@kernel.org,lucien.xin@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:25:56 +0200
Message-ID: <2026092956-canine-emblem-38a5@gregkh>
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
git cherry-pick -x 00df72e39f306e2f7adb68528a5c92109da6a0a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092956-canine-emblem-38a5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 00df72e39f306e2f7adb68528a5c92109da6a0a9 Mon Sep 17 00:00:00 2001
From: Ilya Maximets <i.maximets@ovn.org>
Date: Mon, 21 Sep 2026 16:55:47 +0200
Subject: [PATCH] net/sched: act_ct: remove 'add_helper' dead code

This variable can only become 'true' when the connection is not
confirmed, but it is only checked when it is confirmed.  So, it can be
treated as being always false and just removed.

Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260921145655.3167436-6-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index e72143d36b11..f62051ec9d57 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -986,7 +986,6 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	struct nf_hook_state state;
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
-	bool add_helper = false;
 	bool skb_is_ours = false;
 	bool skip_add = false;
 	bool defrag = false;
@@ -1096,14 +1095,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		err = __nf_ct_try_assign_helper(ct, p->tmpl, GFP_ATOMIC);
 		if (err)
 			goto drop;
-		add_helper = true;
+
 		if (nat && !nfct_seqadj(ct)) {
 			if (!nfct_seqadj_ext_add(ct))
 				goto drop;
 		}
 	}
 
-	if (nf_ct_is_confirmed(ct) ? ((!cached && !skip_add) || add_helper) : commit) {
+	if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
 		err = nf_ct_helper(skb, ct, ctinfo, family);
 		if (err != NF_ACCEPT)
 			goto nf_error;

