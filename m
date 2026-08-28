Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CB3597B;
	Fri, 28 Aug 2026 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881629; cv=none; b=P5COCcOcFF1xjtCOD+U5ZiE63oq578OhFo9cc+m8DuA+ZRAmW5Xr53SoFp1ZpOOmsEbzFQOVmgWiOpzjC8UtKcJIKyn5Q82OjLfSm5qUU3M7CAGQ+jObqnpb2nQIJpKYcmtyUfpZSXVLgeFJHYB7GE9vhMUJTF4Lgg4aEV4QzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881629; c=relaxed/simple;
	bh=MtGhWLt1va2LhhX5o7pCaqaKmQAqmJr54P2gLvdIcnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VA2nMrdSWWN3PfesMXxjirKBxot580Bi+WkG6HB5SjRKgC9siRa4NYuz1jEQtjBRcbjiqO5cU1drVF/4mUhBXtyWvwHBC0tV5aZZzZCN2mA3aY4UUlehWNxHV2idaUkQiE6l7KQpIn/kiXwP3WrXbwTAYLuNERgwFiiqzMlR3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls40H+Ui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls40H+Ui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164491F00A3E;
	Fri, 28 Aug 2026 01:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881628;
	bh=VRfutuzu05ykYxc/Mly0vRTBPzzKGyxJTyvmxyHFbck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ls40H+UikY24YXzGLtz8LM6CXyfz9UeGBPGKiq4mUB7b4bp0iZIar+rhXFGA+mu24
	 z/f89P1uaUxS/gS6zbm+uPHZCpcm4uFxvP1q7m4io11IVBMsQxbq9bp6JSISCSaMzU
	 qea+b5ybj4+B+Fy/Gg9qv+vh7YFcJeMMoW0vAoDvWM2nCNFWVsprZsSCxg22jh2a/W
	 G54eKpPe4VdQZFXQr5offUfJ1idEjXsZVDN8JYJgcDXN5+lPwVZE1+rm2cTOmHvMJZ
	 MTaLnlSL7VEF7jxG9MWhTdQVG+Bp6nfOs8XLRHlDHqmaU/BHrDAXYBeE6nZ+Yq0Jg+
	 k/taNyCv5R4hw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 2/4] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Thu, 27 Aug 2026 18:46:56 -0700
Message-ID: <20260828014659.121058-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828014659.121058-1-sj@kernel.org>
References: <20260828014659.121058-1-sj@kernel.org>
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
 mm/damon/core.c             | 10 +++++++++-
 mm/damon/tests/core-kunit.h |  9 +++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f8dddbff74a77..f7e66898aeb84 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -635,6 +635,8 @@ struct damos_quota_goal *damos_new_quota_goal(
 		return NULL;
 	goal->metric = metric;
 	goal->target_value = target_value;
+	if (metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
+		goal->last_psi_total = U64_MAX;
 	INIT_LIST_HEAD(&goal->list);
 	return goal;
 }
@@ -1122,6 +1124,9 @@ static void damos_commit_quota_goal_union(
 		struct damos_quota_goal *dst, struct damos_quota_goal *src)
 {
 	switch (dst->metric) {
+	case DAMOS_QUOTA_SOME_MEM_PSI_US:
+		dst->last_psi_total = U64_MAX;
+		break;
 	case DAMOS_QUOTA_NODE_MEM_USED_BP:
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 		dst->nid = src->nid;
@@ -1143,7 +1148,6 @@ static void damos_commit_quota_goal(
 	dst->target_value = src->target_value;
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
-	/* keep last_psi_total as is, since it will be updated in next cycle */
 	damos_commit_quota_goal_union(dst, src);
 }
 
@@ -3032,6 +3036,10 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
 		break;
 	case DAMOS_QUOTA_SOME_MEM_PSI_US:
 		now_psi_total = damos_get_some_mem_psi_total();
+		/* uninitialized last_psi_total; make no effect this round */
+		if (goal->last_psi_total == U64_MAX)
+			goal->last_psi_total = now_psi_total +
+				goal->target_value;
 		goal->current_value = now_psi_total - goal->last_psi_total;
 		goal->last_psi_total = now_psi_total;
 		break;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index b643f9a83f14a..65443aba03300 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -751,19 +751,16 @@ static void damos_test_commit_quota_goal_for(struct kunit *test,
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
