Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082210;
	b=A6wJG/Eb6o4ZryPPCrP8PofnszT6zp/FdYDqKdBNWIxWPO7PgJcXffwdJdrxXoPwosb8
	 8Kyl7CScD0CHAs+BShORxyWNQebncBt0Vz3eGB81CV3ZXdG2/ScDQRR8fcaX2cImKMVPJ
	 AQfTK6QVWDtnsdlY11EelQlYG2oNhBFFCosMbSD2qUuGI00KLbPvT2DaPA4fsYSdJzJu5
	 Jb/Qcx+mn0mvYEWRcyIzQ6mXyf598vGlbH0I0WXJSuLuTdAFFs9pLmitYEXhvrp8DICJC
	 u0UpDqzm4C7zmXFf2UJMAq/RwlTkx2/xeORiECCAt/Ns+QzH1y9CfHCV/uL5vW1Wxlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082210;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/7U2bcNPCrBwzjsXKuwnPci/B9bQIw0g0WjpcO31XJk=;
	b=m1HBlIAjciQWqgnVmONOfEHnIPAsTfYilOZwhYSo9X8UV+6o/MPnSc4cz8uBDXdDIycI
	 0Xx6sX/BzLKg70XJ/9apgFRfnbhB4g0fAOKjCzP8eIl6+HMEWZ4p3SqOUFsqPUCuEkQ3e
	 lyyLXE8bGtY4o8p1Yb+0AnR58jDFyDClYjb37vhzLG0tgOn8K72Fu/6EC6dS99hUeT/y+
	 6mKs7LuVvT13qGLfXc+PYAS8lDyc+dab151Ga4poivtcGBbdX3ab8750sW7SK7dgVGgOi
	 IYU0ddGs/CGdZ1Ax/L1OXFcLBRY+oboUvYRzIq3+yh7aw5UE+SoxAVNdJ/7UOoQA74Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fcq25Rk9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E45606D802;
	Sat,  7 Nov 2026 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fcq25Rk9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AF21F0089F;
	Sat,  7 Nov 2026 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082210;
	bh=/7U2bcNPCrBwzjsXKuwnPci/B9bQIw0g0WjpcO31XJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fcq25Rk9wDih03eqM0dlNBTkWHIQAQD2kLZ5vXyWgLDMhBS9qeC3I8FfEBwhMhEf5
	 WJlUtvd4IkD/ZrhOhG0kfhzn+zb++D1EDsXx+U46Moy5n08Bm0hTEUomea+lvNLq1u
	 xnh0YWrBaZNSiy8vMQdCRThX61jNJIg0r8pA6PmkJ7l2tJ18u4ovuZDW7PyodO1Oqd
	 MnJJY/dbYC3hMLp3sEcoNKq3ty6L7XxbW/ss3j//RouhSFwkjMo9jHswkjynehnQBQ
	 +0RHzXZMImB6M/kRwS396C4Xr+uC8nUiM1TQLcpfMIA36rIF7YQ656aps/7dS+u3lr
	 ZWt0p6pO1oX0A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [RFC PATCH 6.18.y 2/5] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Sat,  7 Nov 2026 12:09:58 -0800
Message-ID: <20261107201001.206120-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107201001.206120-1-sj@kernel.org>
References: <20261107201001.206120-1-sj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
(cherry picked from commit 29c6084658af41b5b1fefd873d26d441830ced34)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4c536a9b958e4..f2666770b5436 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -348,6 +348,8 @@ struct damos_quota_goal *damos_new_quota_goal(
 		return NULL;
 	goal->metric = metric;
 	goal->target_value = target_value;
+	if (metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
+		goal->last_psi_total = U64_MAX;
 	INIT_LIST_HEAD(&goal->list);
 	return goal;
 }
@@ -798,6 +800,9 @@ static void damos_commit_quota_goal_union(
 		struct damos_quota_goal *dst, struct damos_quota_goal *src)
 {
 	switch (dst->metric) {
+	case DAMOS_QUOTA_SOME_MEM_PSI_US:
+		dst->last_psi_total = U64_MAX;
+		break;
 	case DAMOS_QUOTA_NODE_MEM_USED_BP:
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 		dst->nid = src->nid;
@@ -816,7 +821,6 @@ static int damos_commit_quota_goal(
 	dst->target_value = src->target_value;
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
-	/* keep last_psi_total as is, since it will be updated in next cycle */
 	damos_commit_quota_goal_union(dst, src);
 	return 0;
 }
@@ -2171,7 +2175,12 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
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
-- 
2.47.3
