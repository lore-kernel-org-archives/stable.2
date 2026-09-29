Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B24E9C38
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673968; cv=none; b=ZtkoTuaz9Cq5Du7W0ID9VHWhu9eupYyKcoiiKAc33kMmXpcvViZRtnaCWqJhywOasJRt6BKGFRZxRDJ2DBX17fpbYJPiOWOwJ8obFJdE3e1n5gQ/ecClLlN9E3w5PSfSvgwtVeITfj6g6DFV+8pF8uBjYYUaT3PtDSTun48fCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673968; c=relaxed/simple;
	bh=WtjBMxuRrGtPuOyqW4gnz7z4OZxViLlyD+C4Ttp8Gnw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H1qAHnYU2iQ95Z/zDj3V+HB+uFjjcP5sdxEciRfwM18Mo2B00AwhzEtTRiLZmCMZwAGJjZ8B/yLx0Xj0v+O3x1650GZOmgVJMFq6e5EJ8FScaDmyGDMLc3ckHI8tMUl45LOPYGvmSryRosViwWXFAqyWo6i6B93z2oO6C7b2cNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MQH7ufxz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MQH7ufxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6CB1F000FF;
	Tue, 29 Sep 2026 09:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790673961;
	bh=PF5r7jZQzTdvXfK6a7e+mME+zdMQDHc6CM93Y7uPLrg=;
	h=Subject:To:Cc:From:Date;
	b=MQH7ufxz8oIqmmO6yDJLHdls6QtDzMuobzmwEnDQMcHrLpRGLpWcATomJKZDVMU6F
	 NeCQn/AQ3ExSvosA+lRZqsPO8lcl70WEdgP4F0DdD3lcGlldeDpzdBXKA1UEfXEvsP
	 1RBx/tUsuF9ZIUln2rZpp2uKKagqLkl0d9K0njd0=
Subject: FAILED: patch "[PATCH] net/sched: act_ct: remove 'add_helper' dead code" failed to apply to 6.18-stable tree
To: i.maximets@ovn.org,aconole@redhat.com,jhs@mojatatu.com,kuba@kernel.org,lucien.xin@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:25:56 +0200
Message-ID: <2026092956-avalanche-oversized-b625@gregkh>
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
git cherry-pick -x 00df72e39f306e2f7adb68528a5c92109da6a0a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092956-avalanche-oversized-b625@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

