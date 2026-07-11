Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403693CAE76;
	Sat, 11 Jul 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783790146; cv=none; b=O3wvpmm5KZx6WRxdsOb7/K0v59BAsIADxwATDMIQBLiYWxfLJEOaM7xHodKvrhxWRe+ahcnXfD1kjW74/DSewkaA1WtJhHB2DzXBoOQZpFdahc/WXCWulNcPU08GJBDTXUJ1aH5NkYKstkzCA5qEGB0iF1oPFZ2WSiO/3CAd0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783790146; c=relaxed/simple;
	bh=HNEMbUM8Dc7MXv36hC9p06seebB9ZnD89UdgnIiyTTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AkHef4D8JG3xsfL6p8sUqkwf6NoCUQbVNa+JOubqgTacSoZjAsOEeuUuScpnlt5CDPkXp1o2iRN9xnnEv8TPHMAzQve/oh1v0iySsb30Hea+JClSux6Pd8Ou8YT3ygOXkFGaiLMwJiOlVI8xTMaJV4pdTtg52UlGSi9cr7RO6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdAxMIiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdAxMIiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE50D1F000E9;
	Sat, 11 Jul 2026 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783790145;
	bh=ck7cKutqom8FXqW9f3tKNdDyqqXs5y+HSAyjbPEnNkM=;
	h=From:To:Cc:Subject:Date;
	b=VdAxMIiQOsU2Hag44ILU7hjjfQ/8/fT+1he5wGJSsqu6mApw3IemgvlhZPh06Egvi
	 xAVedD9/dEQb4C3CvgYyKK7LUWpmuvkogJdLdvBaWj9Dqlwx/NBFGGSqNBq1rpQrKr
	 euT4vsm2acyDmEUWCzst8NFaICV4+tmHZpkSG6ifrUlzHLbtsWd/ziBUhTnjfqHL3w
	 Lp/fW1qvv3zoTJd+qPyZ0af/3pLG4Tqv3jHdwXUxcGbJEuEMRBHsbCgVmi+Ux1ZedX
	 BfmX0VAtS/4wooMN1S5JGjGgL1fZ+cW8doop88oopGgCq64zbD9o9HkC81Mo6pMjDl
	 Gx6PjTtR5PrHQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 10" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/core: skip aging from repeated aggressive merging
Date: Sat, 11 Jul 2026 10:15:35 -0700
Message-ID: <20260711171537.75278-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number of DAMON regions could temporarily exceed the user-defined
maximum number of regions limit for corner cases.  For example, users
could lower the limit via runtime parameters update.  For such a case,
kdamond_merge_regions() repeats merging regions in the case doubling the
merge threshold.  The repeated merge operation could update the age of
regions multiple times.  This corrupts the monitoring results.  Fix the
issue by asking the merge operation to skip aging for the corner case.

The user impact is degradation of the monitoring quality.  The impact
should be mild, since the degradation is only temporal, and it is not
common to happen in realistic setups.

The issue was discovered [1,2] by Sashiko.

[1] https://lore.kernel.org/20260621203548.10718-1-sj@kernel.org
[2] https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org

Fixes: 310d6c15e910 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet")
Cc: <stable@vger.kernel.org> # 6.10
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c             | 21 +++++++++++++--------
 mm/damon/tests/core-kunit.h |  2 +-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 806a67d02a6e9..6c4215cc809ec 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3308,7 +3308,7 @@ static unsigned int damon_merge_score(struct damon_region *r, bool last,
  * sz_limit	size upper limit of each region
  */
 static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
-		unsigned long sz_limit, struct damon_ctx *ctx)
+		unsigned long sz_limit, struct damon_ctx *ctx, bool count_age)
 {
 	struct damon_region *r, *prev = NULL, *next;
 	bool use_probe_hits = damon_has_probe_weights(ctx);
@@ -3319,12 +3319,14 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 		score = damon_merge_score(r, false, ctx, use_probe_hits);
 		last_score = damon_merge_score(r, true, ctx, use_probe_hits);
 
-		if (abs_diff(score, last_score) > thres)
-			r->age = 0;
-		else if ((score == 0) != (last_score == 0))
-			r->age = 0;
-		else
-			r->age++;
+		if (count_age) {
+			if (abs_diff(score, last_score) > thres)
+				r->age = 0;
+			else if ((score == 0) != (last_score == 0))
+				r->age = 0;
+			else
+				r->age++;
+		}
 
 		if (!prev)
 			goto set_prev_continue;
@@ -3366,15 +3368,18 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	struct damon_target *t;
 	unsigned int nr_regions;
 	unsigned int max_thres;
+	bool count_age = true;
 
 	max_thres = c->attrs.aggr_interval /
 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
 	do {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-			damon_merge_regions_of(t, threshold, sz_limit, c);
+			damon_merge_regions_of(t, threshold, sz_limit, c,
+					count_age);
 			nr_regions += damon_nr_regions(t);
 		}
+		count_age = false;
 		threshold = max(1, threshold * 2);
 	} while (nr_regions > c->attrs.max_nr_regions &&
 			threshold / 2 < max_thres);
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 6ad73559dd8ea..68d30648c612e 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -257,7 +257,7 @@ static void damon_test_merge_regions_of(struct kunit *test)
 		damon_add_region(r, t);
 	}
 
-	damon_merge_regions_of(t, 9, 9999, ctx);
+	damon_merge_regions_of(t, 9, 9999, ctx, true);
 	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
 	for (i = 0; i < 6; i++) {

base-commit: 3700e40ed9161bcf1b76601fa50b2b0ff8972eb8
-- 
2.47.3
