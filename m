Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072A2F5324;
	Wed,  2 Sep 2026 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308854; cv=none; b=lSo6MXGPwwG6Znmmb7yiEk9Wthb5ZiosyBHQmVs0fvoU4KjzfGSOamN4H5h3VbKMJb9A5a72V9A0D1j582btj4MMZBR43oVv9oKMGgJ3pPwRabNftkTYIcLLz4bjaf/ZMei2tPhmNalJ3S90kf2mcu48mvy0WmMD6jubt34UPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308854; c=relaxed/simple;
	bh=s7pVSJOEltTV/WyNYgejAsjWg5izNrR7PpH6dlVvvbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDcjH77dJ2JWTHdEINfWQbT2Wgk9HY6zwdna2jCrzLKVz1VsQ9Ligj6Bsq/7SEjFbT2exEj+K6j1MK1TwzlDxyzzf7ZoXy8LXVxX8UuCLUVAiUupjGFHKHefwM3fqg0reGc0PPoQ/9DdaayZQ961EjH6dvfT4ZN3FjgHMPAHdzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfbAthgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfbAthgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6761F00A3E;
	Wed,  2 Sep 2026 00:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788308853;
	bh=SfHgIbwjiDjLtKHgMa5uADWtbVJn1DArTTqrj0I3xWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JfbAthgRBHPFv6T+0PEu95zWODpJg5fDB1H2k4FMhtqoOLLiMJ4WncB991oUR7IWf
	 PoEHUuFwqVCyxHyCL43BD+vOyEpBvs28GJTuudj+0ff3DSz0+Dgu0iSVUMwCy548zs
	 cJLGko83qIa5PJGO1P43gFkkaWELE0yLE3f/ahXTI7H0q5aktc2lqymNmsMj3sUQAa
	 pda74jc/AR36HHSFZbxGYMpD0BsZdmOVaz7k/ukUl9MuCMk5AbBdPpMMjoqC5M4iTd
	 oYpbZcwwvb3q+cyDnq78rT+bjfGcIGO1tgnkphsdm5oDM8p62PWmXdMR1uu8BQk1Ud
	 2FeKTaWhFO7/w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/4] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Tue,  1 Sep 2026 17:27:21 -0700
Message-ID: <20260902002725.108635-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902002725.108635-1-sj@kernel.org>
References: <20260902002725.108635-1-sj@kernel.org>
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
difficult to be expected.

Check last_psi_total initialization and skip the tuning round when it is
not initialized.  For this, initialize last_psi_total with U64_MAX in
the goal creation and the goal commit time.  U64_MAX means the field is
not initialized.  The tuning round shows the value and adjusts it to
guarantee the current quota is maintained for the round, and
last_psi_total is correctly initialized on the next round.

Before this change, committing a new PSI goal on an existing PSI goal
with goal-only DAMON sysfs command (commit_schemes_quota_goals) just
worked.  After this change, the tuning round right after the commit will
be unnecessarily skipped, because last_psi_total is unconditionally
marked as not initialized in the damos_commit_quota_goal_union().  This
is an intended tradeoff for simplicity.  Skipping just one round of
tuning is no problem.  Meanwhile it makes both the code and the behavior
simple to understand.

Also update the quota goal commit unit test for changed last_psi_total
setup behavior.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org

Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goal")
Cc: <stable@vger.kernel.org> # 6.9.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c             | 13 +++++++++++--
 mm/damon/tests/core-kunit.h |  9 +++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0df785e72438f..20748b0a71026 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -636,6 +636,8 @@ struct damos_quota_goal *damos_new_quota_goal(
 		return NULL;
 	goal->metric = metric;
 	goal->target_value = target_value;
+	if (metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
+		goal->last_psi_total = U64_MAX;
 	INIT_LIST_HEAD(&goal->list);
 	return goal;
 }
@@ -1129,6 +1131,9 @@ static void damos_commit_quota_goal_union(
 		struct damos_quota_goal *dst, struct damos_quota_goal *src)
 {
 	switch (dst->metric) {
+	case DAMOS_QUOTA_SOME_MEM_PSI_US:
+		dst->last_psi_total = U64_MAX;
+		break;
 	case DAMOS_QUOTA_NODE_MEM_USED_BP:
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 		dst->nid = src->nid;
@@ -1150,7 +1155,6 @@ static void damos_commit_quota_goal(
 	dst->target_value = src->target_value;
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
-	/* keep last_psi_total as is, since it will be updated in next cycle */
 	damos_commit_quota_goal_union(dst, src);
 }
 
@@ -3039,7 +3043,12 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
 		break;
 	case DAMOS_QUOTA_SOME_MEM_PSI_US:
 		now_psi_total = damos_get_some_mem_psi_total();
-		goal->current_value = now_psi_total - goal->last_psi_total;
+		/* uninitialized last_psi_total; make no effect this round */
+		if (goal->last_psi_total == U64_MAX)
+			goal->current_value = goal->target_value;
+		else
+			goal->current_value = now_psi_total -
+				goal->last_psi_total;
 		goal->last_psi_total = now_psi_total;
 		break;
 	case DAMOS_QUOTA_NODE_MEM_USED_BP:
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index f1e11548c771b..af26b3d60957b 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -757,19 +757,16 @@ static void damos_test_commit_quota_goal_for(struct kunit *test,
 		struct damos_quota_goal *dst,
 		struct damos_quota_goal *src)
 {
-	u64 dst_last_psi_total = 0;
-
-	if (dst->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
-		dst_last_psi_total = dst->last_psi_total;
 	damos_commit_quota_goal(dst, src);
 
 	KUNIT_EXPECT_EQ(test, dst->metric, src->metric);
 	KUNIT_EXPECT_EQ(test, dst->target_value, src->target_value);
 	if (src->metric == DAMOS_QUOTA_USER_INPUT)
 		KUNIT_EXPECT_EQ(test, dst->current_value, src->current_value);
-	if (dst_last_psi_total && src->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
-		KUNIT_EXPECT_EQ(test, dst->last_psi_total, dst_last_psi_total);
 	switch (dst->metric) {
+	case DAMOS_QUOTA_SOME_MEM_PSI_US:
+		KUNIT_EXPECT_EQ(test, dst->last_psi_total, U64_MAX);
+		break;
 	case DAMOS_QUOTA_NODE_MEM_USED_BP:
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
-- 
2.47.3
