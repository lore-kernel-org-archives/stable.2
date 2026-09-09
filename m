Received: from mta1.migadu.com (out-145.mta1.migadu.com [95.215.58.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44B356A12
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937461; cv=none; b=XxCq+0vtHONe0l0TG6Q5/VSWwSwVvnHwc6q1Sdv1mz/tBce8olZjSSG04WMOZ3j7Dvhrs2Ft53PgrtPJW/Zq5A9tm63ZcsWQ6Exhxymv13fSslb/EuNd/C3Jcidt8751SGSTUc9qO0+GFY28gnSm0hNnQ28MXBRqjSueddPoR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937461; c=relaxed/simple;
	bh=T6lie9elNQONzQUM6lpEByBCQyx9hgQM9lLk5pi6gO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oX5I7zrsLv74vuIjrvOZn0qLJqZu/VGNAxTeiaJqZYdgKJYf3jhuToOzR6bGwyAS8ksgi6Cmjy50MQuHnM6s3yS5wxofrKTQHMSoraMilR2ahrMp2xmdUzmc7m5OMlwehq83jJpfI/HcKAUuqlQNn+diGxD0gOQ9X0QlOS+XAFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N37lVx5B; arc=none smtp.client-ip=95.215.58.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N37lVx5B"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=T6lie9elNQONzQUM6lpEByBCQyx9hgQM9lLk5pi6gO4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788937456; v=1; x=1789542256;
 b=N37lVx5ByPLtwf34oE7jKgfe1KDMS1uDMqmwhuY9ZA82XlkB9NMSVSNO4y1mGmeR5MPZYf5L
 ANTKDZ1AE11RzztNQp7/3gOf/b7M3xnWcaH2zVXhu8t0hDF9IlS7WWmZN29SPiAhg7mxWZR23em
 FXMCOSVnOSFNY0mefTOE5Dys=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id da7b0975fc924df2;
	Wed, 09 Sep 2026 07:04:16 +0000
X-Mizu-Trace-ID: da7b0975fc924df2
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v1 1/2] net/sched: act_api: release all action references on NEWACTION failure
Date: Wed,  9 Sep 2026 15:03:35 +0800
Message-ID: <20260909070336.32979-2-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909070336.32979-1-xuanqiang.luo@linux.dev>
References: <20260909070336.32979-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

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
---
 net/sched/act_api.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 37eced84dfa5f..19501dc994641 100644
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
-- 
2.43.0

