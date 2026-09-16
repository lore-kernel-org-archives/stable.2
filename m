Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D739FCC8
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573236; cv=none; b=DnAmAN8ttOUSY+sIzTo8IG7tBNJsxj5vw/FsMVQ6exwLN1eblWA0FWEhoMSjOkaxw8Siy6PDh3Ou4G2AqgIF2kMm35jMNolK/x9EqArqMHkrSxlGG1Irl4G+D6acx9t2sTwbtCbdpgI6pJv0hEzKNmfFwzh8a5j1y8ZL2BNpW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573236; c=relaxed/simple;
	bh=FY6RlekvXOj3CAn6xVIkRl6tsSltNfghnE4VO57jWU8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Cq6XMEtZ+sjiiM84Cilyr3ZIes9QOwrU6miA13p3iUCc08vBnsUdTtl+PNJ+dYfbqeUEaWhnLtKQHgKyHuSTEwebg65CAebaYTDAkOIA8kj5kfiULw5oqDLBJagZuySqmNEXFtJrqXY7nMjiA36GSd0DlplKA6nSiYSpHR+hLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lffrK9Cm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lffrK9Cm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB261F000FF;
	Wed, 16 Sep 2026 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789573235;
	bh=PPnB/LHt++pPbyzjvuFDhzZoeqodMUFo/ZgMHF100do=;
	h=Subject:To:Cc:From:Date;
	b=lffrK9Cm0VytV0iK9fYpCUxTq/TU4ZLuzPs1ygt5TtVgMexUEdVvFZjEHr/B2XEi9
	 ZiDlOxjAnvs6CSMAFsHS0YL+SYnI8sR5ueGMKlRy/s49rsBhe+eMXpxAidrBzictZs
	 xPAHWwiSnvL7A+K8Nmieae0HyInPeIKoYd1yZFIk=
Subject: FAILED: patch "[PATCH] net/sched: act_api: release all action references on" failed to apply to 6.6-stable tree
To: luoxuanqiang@kylinos.cn,jhs@mojatatu.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:29:23 +0100
Message-ID: <2026091623-census-prorate-fa39@gregkh>
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
git cherry-pick -x 478eb5abb51931a152abab068f8a717b7ff480fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091623-census-prorate-fa39@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 478eb5abb51931a152abab068f8a717b7ff480fd Mon Sep 17 00:00:00 2001
From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Date: Wed, 9 Sep 2026 15:03:35 +0800
Subject: [PATCH] net/sched: act_api: release all action references on
 NEWACTION failure

When a batched RTM_NEWACTION request replaces an existing action,
tcf_idr_check_alloc() takes a temporary reference on it. If a later
action fails to initialize, tcf_action_destroy() uses strict release
semantics to clean up the actions initialized so far. For an action
bound to a filter, the strict check returns -EPERM without dropping
the temporary reference.

This error also makes tcf_action_destroy() return before releasing
subsequent entries. Any new action initialized between the bound
action and the failing entry is leaked together with its reserved
IDR slot, preventing reuse of its index.

Use tcf_idr_release() to drop each reference held by the batch without
rejecting bound actions. This allows cleanup to continue through all
initialized entries and preserves the module reference release when
an action is destroyed. Explicit action deletion and flushing retain
their separate bind-count checks.

Fixes: 55334a5db5cd ("net_sched: act: refuse to remove bound action outside")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260909070336.32979-2-xuanqiang.luo@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 37eced84dfa5..19501dc99464 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1200,18 +1200,13 @@ EXPORT_SYMBOL(tcf_action_exec);
 
 int tcf_action_destroy(struct tc_action *actions[], int bind)
 {
-	const struct tc_action_ops *ops;
 	struct tc_action *a;
 	int ret = 0, i;
 
 	tcf_act_for_each_action(i, a, actions) {
 		actions[i] = NULL;
-		ops = a->ops;
-		ret = __tcf_idr_release(a, bind, true);
-		if (ret == ACT_P_DELETED)
-			module_put(ops->owner);
-		else if (ret < 0)
-			return ret;
+		/* Drop our reference even if the action is still bound to a filter. */
+		ret = tcf_idr_release(a, bind);
 	}
 	return ret;
 }

