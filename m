Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046789;
	b=ThNClvnV8cNZ2paW6jV2i8U/n3wuWxI/xY2ZFtxgxTtq7nGjUBkkVaPKvnPeekIRc7tm
	 fR4qt3img7eWRUp8c7/YlYa2dJjqKEXDgGiT2p4tjczByLkVCKBqXTeBrWUmWPUq/GiLY
	 EDAYAtqMjHnK2Fi02ccc7qfbzcihrsskWrdQNvAvG8ViXhO71ujYXT/Cf5tDcXwvacku0
	 wzAMPnTA9XP6qvZFmkhp/y9Lwn7gmmD0CWUsxdC1DcDRhkiR0xgwH4IQG/SBj5vtau7Kd
	 PHVT0LwrNdr3lAYfAdVGP7V/PtiSsu83Jo/GPG66nQTgQpizbNH126fY0pLK81mOnxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046789;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vFazRMz+Z8kdUs9KRLFbJVpwDAXPNrnd0ATycwrkacI=;
	b=bcGaEZ7rHF1lGwHhWxBvtFfYBckklzRg0yOp4JumeI73DIZhttlPUlO4ARwRgo2NIF9L
	 39opEe1K6mdbCxjI9g3ad/Snv7h3oMnN2FOkfHqPy+R/1BC6bMlQjYIjvYAUrOrkNte78
	 PnSQC1Tog+TkTIeHHoMIe/Df/1Aw1O2Sdby1y1cbvY+u5oZvvkS7x9kdhZ8wPlsGCgKOy
	 iEHQJmkA+z8lL1OGxzhZH7hGFlfFBkujx8HY0iehcKykpaJWojXy9s5qjiA3oAjHjevxk
	 qOmOnFl7iIIlbZ66JrHngS9UrnjWwpv2Dr/K5e5yuMRx0uXUGxUvG9WA+lteik3WPjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W1qyz6Xe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19E4606EEBE
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W1qyz6Xe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3731F0089F;
	Sat,  7 Nov 2026 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046788;
	bh=vFazRMz+Z8kdUs9KRLFbJVpwDAXPNrnd0ATycwrkacI=;
	h=From:To:Cc:Subject:Date;
	b=W1qyz6XePTZoDsAeBN08mm+BpGHl2ef0FyLJLnq4yJpO6d2hc9hPcNYIxXFB7O//E
	 wb9TYGFdgLxvBj6oeTw1iDMEgymcWJbxW4U9bT9xOfckVZZOrcjoaq7u0yKDEJ0UNf
	 Gz6eEVZ4GVSMAuXcaCbm9lfAono23w2E3yZ/RcUQITvoyQCgTu/hWBEg63Xw8vfo+4
	 2fE8fiz68dDm2yjl5LKMSaAvf4sd5cAt7uXWmpD/nYMq+o/uXitE7Di3hTczq55mMf
	 mf1sJg2Lomb6JVPCpkMdko056xM1HaqpLbVBwUin/DHysJgHff8pKh5NObEUzuTqMZ
	 DUEny16ROk0Qw==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	yanquanmin1@huawei.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:46 -0500
Message-ID: <20261107051946-failed-6.12-29c6084658af@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 29c6084658af41b5b1fefd873d26d441830ced34
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051946-failed-6.12-29c6084658af@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 29c6084658af41b5b1fefd873d26d441830ced34 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Tue, 1 Sep 2026 17:27:21 -0700
Subject: [PATCH] mm/damon/core: handle uninitialized
 damos_quota_goal->last_psi_total

When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
delta for the feedback loop is calculated using
damos_quota_goal->last_psi_total.  However, it is initialized only after
the first feedback loop.  The first iteration of the loop uses the
uninitialized value.  As a result, the feedback loop can change the
effective quota in an unexpected way at the first iteration.

The user impact of the issue is not big, because the issue impacts only
the first iteration of the feedback loop.  The feedback loop also has an
internal cap of the quota adjustment.  The wrong adjustment will soon be
corrected over a few iterations.  For this reason, doing no initialization
at commit time was intentional.  It is also explicitly commented.  That
said, nobody likes behaviors that are unexpected or difficult to be
expected.

Check last_psi_total initialization and skip the tuning round when it is
not initialized.  For this, initialize last_psi_total with U64_MAX in the
goal creation and the goal commit time.  U64_MAX means the field is not
initialized.  The tuning round shows the value and adjusts it to guarantee
the current quota is maintained for the round, and last_psi_total is
correctly initialized on the next round.

Before this change, committing a new PSI goal on an existing PSI goal with
goal-only DAMON sysfs command (commit_schemes_quota_goals) just worked.
After this change, the tuning round right after the commit will be
unnecessarily skipped, because last_psi_total is unconditionally marked as
not initialized in the damos_commit_quota_goal_union().  This is an
intended tradeoff for simplicity.  Skipping just one round of tuning is no
problem.  Meanwhile it makes both the code and the behavior simple to
understand.

Also update the quota goal commit unit test for changed last_psi_total
setup behavior.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260902002725.108635-3-sj@kernel.org
Link: https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org [1]
Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goal")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Tested-by: Lian Wang <lianux.mm@gmail.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Quanmin Yan <yanquanmin1@huawei.com>
Cc: <stable@vger.kernel.org> # 6.9.x
---
 mm/damon/core.c             | 13 +++++++++++--
 mm/damon/tests/core-kunit.h |  9 +++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5ee2d0448a809..f950a3b9fcb99 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -697,6 +697,8 @@ struct damos_quota_goal *damos_new_quota_goal(
 		return NULL;
 	goal->metric = metric;
 	goal->target_value = target_value;
+	if (metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
+		goal->last_psi_total = U64_MAX;
 	INIT_LIST_HEAD(&goal->list);
 	return goal;
 }
@@ -1190,6 +1192,9 @@ static void damos_commit_quota_goal_union(
 		struct damos_quota_goal *dst, struct damos_quota_goal *src)
 {
 	switch (dst->metric) {
+	case DAMOS_QUOTA_SOME_MEM_PSI_US:
+		dst->last_psi_total = U64_MAX;
+		break;
 	case DAMOS_QUOTA_NODE_MEM_USED_BP:
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 		dst->nid = src->nid;
@@ -1211,7 +1216,6 @@ static void damos_commit_quota_goal(
 	dst->target_value = src->target_value;
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
-	/* keep last_psi_total as is, since it will be updated in next cycle */
 	damos_commit_quota_goal_union(dst, src);
 }
 
@@ -3139,7 +3143,12 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
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
2.53.0




