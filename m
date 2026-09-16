Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F10B4BCABA
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602135; cv=none; b=OTsS8GVyJXKcNrEUn14qmlJOcQOACQlcTfwk1aAI/0Pj1ILQpNcxVnl1zLowjC7BMItmDeUD95DOMsqeHpIor9s5gz2CTloTu7KAh4PCnjyyRG6FcWIJzAoH5NkJLQlM3OR2iu9I/CZH6qjNIfqq1W7hRd+XlxIalLa+w54xY2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602135; c=relaxed/simple;
	bh=lBp3dJ9V6cdN3P0KArQiIbMnJoHTu2hbXjWLNWmHnPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p11trzD9uY5kkoqHT+yQRfoFr7Ywt0HYSfNflYSUZmOtjh+jrgOHCeBNkul1RcA+9igUNymaHMfAlcjD8FzUA+b21FRc8SdzaxLF5Mz8Us2GQhekQ5W0cyj9fi1RHqyPuuwJ9cwOTYCawzRxOkLLCN65teDwcp53bPp7yGU5gpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrC4AeTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrC4AeTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B221F000FF;
	Wed, 16 Sep 2026 23:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602132;
	bh=IE4l4Z9z2d1t/5fCKqK23sBmB1DbYCSjbrVa/08Cy0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OrC4AeTxtSwbaldYKrjIgfJb2U8srb44KGL4oT7ji3EG6Ro1LnukJ3x015LdKi9yf
	 Y0Nue+X5+e6pPphpIQMrVgLR1GF7MyS0mFTnyEpSZAYxi5p4+58fY8w3YPNrrGgQjS
	 EcNIKYtOrPtgMKJxAmznIcSzlg51vTzeZQhBL5k1MH/qq9ASPlwW5t+cAv7wZP7vsJ
	 SGDnuoYbAJNvIIDRiKHIXiUKD4dpooBvcPCLpkg8mDx7DtPvoYO0z8MGs4LggfRUqu
	 xY7GhSRkJMhyZe7ahaEPswWEclXu/vrzqSwaMykamELOxu21szcEm2Y/v5nZZCc0BO
	 T/g3inscQas+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net/sched: act_api: release all action references on NEWACTION failure
Date: Wed, 16 Sep 2026 19:42:10 -0400
Message-ID: <20260916234210.3296141-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091623-census-prorate-fa39@gregkh>
References: <2026091623-census-prorate-fa39@gregkh>
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
index 8514888378168..9d1e7019be4c5 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1135,19 +1135,14 @@ EXPORT_SYMBOL(tcf_action_exec);
 
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

