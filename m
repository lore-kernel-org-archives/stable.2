Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186836;
	b=BVd9rT1fsu1d+bzGx04Ckp1N+AjKT83B/RCyJ3VfIL4xxhGcjzoqCeA4XJ+RMpkqyt4X
	 KXVwG7cHlWA4NmmCj4RC1J0X1iuAI4vGzUKS8MRVQ55f4nxOgAY7BjFRhRyjzrbkZEloj
	 weodk4xR3wJPPy4FHObKN9X5AnMdScS60u9XKB3VZFi9qSkbH3ZhU5dTkZ5wqaRzRuO8C
	 FUASzCxEizA5leT3YZNxM29pZvjE1WVYDOC+99OTmcbIbyyhU0qdEtFYi9xhAjfmMa6UX
	 neMUnAGmqtz7OccOBr6D4+yzVRbGa4fX0w7ogM2JUR6V5/mBJgep21a4KImaObftbpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186836;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fEP0Wfy3b8UPkAa4H8VbKGMy0BEcET/8qvo41zJg5uc=;
	b=Yqud49ag0hnmmuhQOxK+BP0a+t/EJZEg0JTdOUu9eliEliHtj/c14lG2cCAx3jo+K9Sc
	 ITc9owBdPAV5kW9Dzpg31JOv6DbLD8pzoWG5IKDnJcfloWJF9r5CM1D1MebPjQ/ma1NwT
	 RFepV350vVfrzLv7N1HA8960SjF0X2UbpzxGY8dzhFqja1U6J2zzQTa0uhg9bAKxLCGBo
	 5YAXfQ9JPKcuerWDBfXy3E/qj0FK9hFD59kzHYaE/eDJ9IOKBvdZmJDHLlC96cggFoJZe
	 1Qdlrrdoj0wV0dZZiMxo52Vc4XUFsir2v86qRmJzjn0aBNb7WtVMI5WKRbJ9FQaD60w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctSI5Wg8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05AE606A31C;
	Mon,  9 Nov 2026 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctSI5Wg8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8E31F008A2;
	Mon,  9 Nov 2026 01:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794186835;
	bh=fEP0Wfy3b8UPkAa4H8VbKGMy0BEcET/8qvo41zJg5uc=;
	h=From:To:Cc:Subject:Date;
	b=ctSI5Wg8d7MagOKSJaei+kuz/u3rcYDU1pvSkuqcEw2j1If8b+KWGhjrZMMofIlv5
	 Nrh3/vjcF3aqMsX2wprkQnRt/SlsYomQKhFxF0U5tyt18Co4qNgumzL+ylNk0G56Qt
	 PLg0iwI9aStPnjrZGdvmzHlHMclCb6NB01Rcn0ypBxJXNXNdSivtXtjjBtG1sNQFfF
	 Sd4J++xwyUnsgneCfRROmlc2OwbfoxH07sAGa8Kt20VPeJkuWp0x6YK01dvN6oPJ4M
	 M2FKu0k31aGuPYRRR2HedjY9VNcoCC7l2N+vL9uubS6JecbNJTPyg2xwJueuq7CDf7
	 bOvYBLV9sIYyg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 6.12.y v2] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Sun,  8 Nov 2026 17:13:46 -0800
Message-ID: <20261109011347.92467-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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
Changes from v1
- v1: https://lore.kernel.org/20261108195145.115792-4-sj@kernel.org
- Split out from the series.
- Rebase to lastest stable-rc/linux-6.12.y (commit a100533c838ba).
Changes from RFC
- RFC: https://lore.kernel.org/20261107214525.304638-4-sj@kernel.org
- None.

 mm/damon/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3142776e2e0ee..420ef0adaa7e3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -324,6 +324,8 @@ struct damos_quota_goal *damos_new_quota_goal(
 		return NULL;
 	goal->metric = metric;
 	goal->target_value = target_value;
+	if (metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
+		goal->last_psi_total = U64_MAX;
 	INIT_LIST_HEAD(&goal->list);
 	return goal;
 }
@@ -707,7 +709,8 @@ static int damos_commit_quota_goal(
 	dst->target_value = src->target_value;
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
-	/* keep last_psi_total as is, since it will be updated in next cycle */
+	else if (dst->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
+		dst->last_psi_total = U64_MAX;
 	return 0;
 }
 
@@ -1616,7 +1619,12 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
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
 	default:

base-commit: a100533c838bab5a555d92e082e38e092f2b4ea6
-- 
2.47.3
