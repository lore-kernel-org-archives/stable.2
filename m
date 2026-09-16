Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B355295D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602825; cv=none; b=CBrFpOG55kQujvHlEoH+QP6ShHMIOkTXY+1bjRFaZX6P81DEBY9dVpG6n/ts5IH8h58OcDD5paGbo/i2xouZ9OW2ddRaRJtAtXUs/coBlAyQWERZepTSwjTG5fHzMc0YzTygXjolsVWZfPEp4hGPuCweyuDRRaO31jMFVmV2+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602825; c=relaxed/simple;
	bh=AkUBJt3ztSP1uRAU0jOhyPqgSagvcF1psvobDRJLNuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjFg0pCup6j6NhsPNSkgORffTtBMeDKQD/IdeHrN3bivaFvCu9ndCJ67cuYwxRXRxcJPYDXzi3B9YkjGcOnfm4WsXNuXZSfog3mGT0dxuj1WQZ9a34AOvVw02ScfbVWfdFZNQpHn/YP1qBhKNC2VfMHjgsHLjCQvBy/L6r33uuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGtKNcz4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGtKNcz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192E71F00898;
	Wed, 16 Sep 2026 23:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602823;
	bh=i/iLE4/p9ZH1+HpXR4dgKXgJyPUBLsJXh1m0JA2AyXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VGtKNcz4M8kSQ4pjRe6ENez805AYbUxqZg6Sb9hQeqdao5wMKGRCyvPnqQESjXjwo
	 /7nmpKooYP8n+NM7Qnm1XQpZ0K8cDKTXvQrMWT1NzpujkBSqWa8yjS6hbo5aJL57AR
	 jbYkIsjZmg98z4pOz4XtTevTe/6sOjEQI4Ndp9Y+KUjXS7IIVNT+CVAZx+vkv0+b3h
	 7Byt8m0tYy1Z2XcEQPjQb5sarKXkLLzJbl78SGkgzWF24tKhjceRBEny4N1SCyVAzC
	 f6Vwebc6b7m9b9zQGgMb9rxxrRbh7UIuONXXNNFR7ZSOLJnx7ULO4uGEIPzkM07UEd
	 JPJdoBSoEl2RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net/sched: act_api: release all action references on NEWACTION failure
Date: Wed, 16 Sep 2026 19:53:41 -0400
Message-ID: <20260916235341.3313676-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091624-used-privatize-a012@gregkh>
References: <2026091624-used-privatize-a012@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

[ Upstream commit 478eb5abb51931a152abab068f8a717b7ff480fd ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_api.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 47f0d4c3dc487..3dbf0919ba526 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1133,19 +1133,14 @@ EXPORT_SYMBOL(tcf_action_exec);
 
 int tcf_action_destroy(struct tc_action *actions[], int bind)
 {
-	const struct tc_action_ops *ops;
 	struct tc_action *a;
 	int ret = 0, i;
 
 	for (i = 0; i < TCA_ACT_MAX_PRIO && actions[i]; i++) {
 		a = actions[i];
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
-- 
2.53.0

