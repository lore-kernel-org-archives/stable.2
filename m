Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7233E7647
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673058; cv=none; b=LbCFgZ1mORFs1soMC1xYvHKS4ogwYo29D7uMyOnJ8aVWa3fnF2SCNY3VXcXs7Ae0rbxCDeeadWC5Sxa9/FuuiyW67Ik5UJF1T8KCZRYg9XEmELhhkqHdEsr5f6V8Tm0CsphghrLEEoxj5Fhn25L4i8BJFcIw0JOXBn62fWbxNmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673058; c=relaxed/simple;
	bh=s7AQnWvhHSQCwOOGvd8Ook2NCBeE07ih/mpxCQ+XaOI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MwSoH8I8yAgL2yNHdsb0vwYuWeoLfwqGVJ0+XFTvpLFF8MX1nELftk85OrRgSjh3Z2igoW6k5ATA8m/kTnVxEkTJaaKGUyYQ43kHQlwYmjPCzPaszokfmAtyxfPPDiSatwpxYQi1iYQtADqGSrNHmLDNhlIuoyLqvUSjKGK0aJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gx1l6Dw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gx1l6Dw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220721F000FF;
	Tue, 29 Sep 2026 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790673045;
	bh=Y2w0ul2fjz1aW/ZTj/Ktp4qfgSIQwl1YQltAMgxN//E=;
	h=Subject:To:Cc:From:Date;
	b=gx1l6Dw8hd1k9bSjHZUc+xxI/2DqXQS7YltKbse8IILBOsIvq2K7WT/93FtL3jrSX
	 /IHbAmigBC9a8R8dO6WB54677m2Ey+P544pJr/D/On5jItFtMbbhOj9Ht2W6U81VEx
	 u3lEwOD8zXy+Hh/emnmGGfEpC1YckqQxrXn5isKE=
Subject: FAILED: patch "[PATCH] net/sched: act_ct: remove 'add_helper' dead code" failed to apply to 6.6-stable tree
To: i.maximets@ovn.org,aconole@redhat.com,jhs@mojatatu.com,kuba@kernel.org,lucien.xin@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:10:40 +0200
Message-ID: <2026092940-dropout-pebbly-3736@gregkh>
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
git cherry-pick -x 00df72e39f306e2f7adb68528a5c92109da6a0a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092940-dropout-pebbly-3736@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

