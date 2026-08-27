Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C3A389DF3;
	Thu, 27 Aug 2026 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804970; cv=none; b=eZhqyRM2KFPt4+exmCtrJ9rmNc0cKFsGiXY7wO4Mj1uqQJHXiSigxV+IZgP3mnGSdKsMOancCTdHuo8y3BUeIkcq1FUTz3q8yMJoLUxY1XNZys8t3xJfzCP++/bqTDgrQvP8zXmq8FzOcPvHFua2H1j/kUyl8yEb67gZ6Ss02ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804970; c=relaxed/simple;
	bh=Tc+7cBVCBQnf77YrHoF37bzyflc3XoGdTlEbrJuLgSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmcQOcU3OaqzcVlwORhzzbePTmEYhGG7zTWVgAoEMDwDZyLNs3U8zwbEALnqyZodVrdhDzSblKZagJ5RlAymcBfaiNpDm4v2O3l4NzzYpHqnWkkmsiRrHhI+IykJTqdwYk9xjQs+EPN1ahfLTPr6PX7ookYr0O2YKKwvt0fXdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2Hocz03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2Hocz03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8A41F00A3A;
	Thu, 27 Aug 2026 04:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787804969;
	bh=8OhKNZlcbIRJFXZB0BB5LWgKdrRUKnRyLDo/v7ocG2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k2Hocz03j8gNlThKs7aOx21XiilaMgxNp5HiTEagJ2jw0S1YA31Qu0dnzA5e0wM0Q
	 6cszBKjC5flBpySgaW+OX/GVYik/CWO8K7n3x9JfiEVVKsWyay0PmeR9Ry8aS2qWtM
	 j6pvS/EwqMjgPkBxa3FxCMRSLaFWwARxLtHQnB19qRnHimv9mEk2cNlDELapYEG912
	 sxuP8M6I+tcwvP9q+nJ5plp+Ha/WRDSNCvW2z8ibZIV8noyp+3TnObKsGwb9CsX/zo
	 LDj0+Bl2L4yAgBH7isgbQPx6so87RibHJywVlLPHJyXc9F+1e8fiPLTI2e+6Hm/8rO
	 40mx2wW3AKMog==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/core: initialize damos_quota_goal->last_psi_total
Date: Wed, 26 Aug 2026 21:29:18 -0700
Message-ID: <20260827042920.93580-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827042920.93580-1-sj@kernel.org>
References: <20260827042920.93580-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
delta for the feedback loop is calculated using
damos_quota_goal->last_psi_total.  However, it is initialized only after
the first feedback loop.  The first iteration of the loop uses the
uninitialized value.  As a result, the feedback loop can change the
effective quota in an unexpected way at the first iteration.

The user impact of the issue is not big, because the issue impacts only
the first iteration of the feedback loop.  The feedback loop also has an
internal cap of the quota adjustment.  The wrong adjustment will soon be
corrected over a few iterations.  For this reason, doing no
initialization at commit time was intentional.  It is also explicitly
commented.  That said, nobody likes behaviors that are unexpected or
difficult to be expected.  Fixing it is also simple and not expensive.

Initialize the field at the beginning of kdamond and each commit of
SOME_MEM_PSI_US type quota goals.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org

Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goal")
Cc: <stable@vger.kernel.org> # 6.9.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f8dddbff74a77..0d4a571482fb9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1122,6 +1122,9 @@ static void damos_commit_quota_goal_union(
 		struct damos_quota_goal *dst, struct damos_quota_goal *src)
 {
 	switch (dst->metric) {
+	case DAMOS_QUOTA_SOME_MEM_PSI_US:
+		dst->last_psi_total = damos_get_some_mem_psi_total();
+		break;
 	case DAMOS_QUOTA_NODE_MEM_USED_BP:
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 		dst->nid = src->nid;
@@ -1143,7 +1146,6 @@ static void damos_commit_quota_goal(
 	dst->target_value = src->target_value;
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
-	/* keep last_psi_total as is, since it will be updated in next cycle */
 	damos_commit_quota_goal_union(dst, src);
 }
 
@@ -3741,6 +3743,17 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 	return -EBUSY;
 }
 
+static void damos_init_quota_goal_last_psi(struct damos *s)
+{
+	struct damos_quota_goal *goal;
+
+	damos_for_each_quota_goal(goal, &s->quota) {
+		if (goal->metric != DAMOS_QUOTA_SOME_MEM_PSI_US)
+			continue;
+		goal->last_psi_total = damos_get_some_mem_psi_total();
+	}
+}
+
 static void kdamond_init_ctx(struct damon_ctx *ctx)
 {
 	unsigned long sample_interval = ctx->attrs.sample_interval ?
@@ -3757,6 +3770,7 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 	damon_for_each_scheme(scheme, ctx) {
 		damos_set_next_apply_sis(scheme, ctx);
 		damos_set_filters_default_reject(scheme);
+		damos_init_quota_goal_last_psi(scheme);
 	}
 }
 
-- 
2.47.3
