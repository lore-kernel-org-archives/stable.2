Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3930C147
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604759; cv=none; b=nZfa8oL+w4NRJiCO1u7WDXEyguEofHn0yEnbM1lx/4ET+0nYYYu9DkGvyC07UrbY2H9hTghUwMZQjCRcGRQdLK7uF/pepdZyPcdcxO0EK9SZKoiVQgBw8bJA5BxOtu6drAHFGYVmqaPUYYdlmE5Fdaq7SgMvqSOUo+JXTQCRhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604759; c=relaxed/simple;
	bh=IBvCuoB0ecwJKQjILsnlOo0fE5oUMXAmZnt0/reEOYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/copPo27UlEwvmyxKxIHC7IgGBAGYnN82TZ/F8oP5aeHVj+7/kZCXOSopnoJK7payde6bfh1OO8Zy/ll9xFMuMT4DShNMZ2D02wqgFfoUzYUU5/P0uL7AC9/sHMuAwNs5u9yrvKxG7xSTSsKKsfgQdIZTJvPXKNlgUlCmFdTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw2tA3nw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw2tA3nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106261F000FF;
	Thu, 17 Sep 2026 00:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604757;
	bh=TN1WaI3aRC4V5PqfSo341nQgvj7QmJptMmMX+zECjW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iw2tA3nwNrvRjAe1pHhK4Ak0i5q1EOI/DNiSpRB76O8IYiKPyXrMHS5gfWJ140naV
	 /KV7CrMKLRDC4HsvviLO7FF58CJpkb2QUqHHhkdHB1DYGFcDqNJl4tVMb88OXUjSha
	 XTHHMtMRvSCXxEoOIvJ2uHZf/vDLM3WOf27tJsapbVORqy46p79tyJqEk5/f7QbV3p
	 Ma4JgGbGmecXJl1pcHcYPHdZH/I/skR7kQ/bOrXEab1njTf/rnQ+uSr6begzmJUZfT
	 d/pmjBViLbE8TBIbTVopcmJZfKdMxCc4gQeltmWAnZKoHUTWv+U57Go6p0CH25Q9nM
	 gyP1QmfL8Kk3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net/sched: act_api: release all action references on NEWACTION failure
Date: Wed, 16 Sep 2026 20:25:55 -0400
Message-ID: <20260917002555.3378809-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091628-saucy-tattling-3b65@gregkh>
References: <2026091628-saucy-tattling-3b65@gregkh>
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
index c724eea8cf8c5..6178b5c3f55d0 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -750,19 +750,14 @@ EXPORT_SYMBOL(tcf_action_exec);
 
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

