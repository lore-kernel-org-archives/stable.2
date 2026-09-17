Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF22F8EAA
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604361; cv=none; b=M3t48fgvWK0GABL95DYBQsIM5kYQX8m3HwOVk2RfGSJAOoleWPIIdGDxn5xENjMRm3fD/tE77S4+LEboKvAWyNzgsbYDRPHzMoHmeEAG6KNZlOB+ny2dQ//w455YydkKewqDtUtM3kQ8DsKpzfEwfYg5J5AAHDEJujv9YbK7Hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604361; c=relaxed/simple;
	bh=G3KBlowlAaXR6+5JHCeg0dRCpUTD8rva8KX0fmM3eqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmWQlQHK3z/ajVdRqoc63yjauHYaZwNEvLE9cws6TA05rm6JxPtXoIhnvitW31jh9cyJt4AHpXXlZPo5j76pcbMn3/g1BWbzu4SKLdj0mgGjvzgyLsfG3okT0+nPu1A5FRa9ok7jrnuI1TJuymu2kZdqqPzN6Rzlz2HXW+zU1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF2wxLbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF2wxLbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64721F0089A;
	Thu, 17 Sep 2026 00:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604360;
	bh=I8vgtOse/eSHhTCWqvfhYzOwDxWu0BG7K9T9vUk9l9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fF2wxLbg8a9A/IIwHiioKfy788jUvoArkXYZDWqh/3quog0EZ1I+9FHbtgNhR/fia
	 0HHNTvNG5afG0IBwMe0QZ2rlXyT9I2pT9pDeqzgXuBq6WPkfxADrnyatGprginyvoy
	 xHtn4FGQIXmoUZU1Nez8I2E7A5V+r6XDF3sH45Ry+zz9F4OE9tlUbeD00sNMwvrCqd
	 ZKFe+5JxOV7fRgUhNHI9rDxy7/MjyoZE4QjuyLU3CuvAXmYn18Ue7TA3hq0QNucefR
	 TEVuTCWoZ19zroL2scCUUWLAtEGuI6N2/0DAL4tB3xETPN+ZMPYsx9lbOtei8GEkbD
	 bN/HblZ5J7Q8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net/sched: act_api: release all action references on NEWACTION failure
Date: Wed, 16 Sep 2026 20:19:18 -0400
Message-ID: <20260917001918.3361119-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091626-turkey-huff-71e2@gregkh>
References: <2026091626-turkey-huff-71e2@gregkh>
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
index 20944a2e162e7..64fc0e19ac40a 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -798,19 +798,14 @@ EXPORT_SYMBOL(tcf_action_exec);
 
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

