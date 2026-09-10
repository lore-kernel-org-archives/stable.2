Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8F280325;
	Thu, 10 Sep 2026 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001542; cv=none; b=m96ZvAM1Z/4vVt4eplpXqyEo0Fu6RirF2e10+6VtwRtTIB/z+uIJNyf+XOEoS+T5MxVoFBgDkDNqwnKGRY+bUMO4rq/gvcndD/G+lLLY2C4EqFKTgY66rSpGoauEJoewW4PIc5MDXG8YSGGPPpfj1NixZ2Ej6RqnTv18/8WZMTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001542; c=relaxed/simple;
	bh=xVF3/LjHRoO4g4gBhUpawJc1tu217xxP+4YvdxYObQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRp6x0Luqs6iv+ClkGrCLQQC7ryzO7xzjxmDM6B3fg5bHsCTxtRSqGfBvcK9zAn02zqmy/mDW/js7sVpoLiNh6yL8g3fCM5AEXLsE7ZUrYev464yjYEE0VDqnMMtIe/DQGUpj3CcNv9imIDhVin+RhzJ5FpDKa9wY1hvb5byTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaP1OHVM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaP1OHVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6845C1F000FF;
	Thu, 10 Sep 2026 00:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789001540;
	bh=Og7N11O5YYaUrsmy3+ySp1IY4U4GbXEY41hK8hCALX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZaP1OHVM9OxicTAsTGsYdRURxCmk9cA8Yot1NKZUXLItO+mKg9+nwXHYrIU8XVTmr
	 sfri5bT6yIjsVV3XcPC3EYHOipBqH2QWkBz7Jms4ryvfQkykcUNd+cSuSfx+rbnYZc
	 yI1/OMGURD+fzKTJPoU8UfC1AvoJ8MVVcOT4/H8JCCnY46I24IN5QuuwpYNklY2Bkp
	 E9tlS/qqC7FEWpmSHMnWNbxfvPBdClDFmQk7byuwqqUaNAGQhd5AnUk2JITu8TswC8
	 MUHFNvPWGwgUAtnnoVKNioYlMUbIwhWFAEYnsEyzNYAxDNF/IsVvZHbP65uklmxy4A
	 lrFypmbgrol3Q==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.2.y] mm/damon/core: skip aging from repeated aggressive merging
Date: Wed,  9 Sep 2026 17:52:12 -0700
Message-ID: <20260910005213.126528-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090839-reoccupy-dizzy-a7bd@gregkh>
References: <2026090839-reoccupy-dizzy-a7bd@gregkh>
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

Link: https://lore.kernel.org/20260712165432.87609-1-sj@kernel.org
Link: https://lore.kernel.org/20260621203548.10718-1-sj@kernel.org [1]
Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org [2]
Fixes: 310d6c15e910 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.10
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 0250dbe08c730d003ef9f484da56ae09a1ea0c4c)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c             | 21 +++++++++++++--------
 mm/damon/tests/core-kunit.h |  2 +-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a86812d457c14..372ca1161c57d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3118,18 +3118,20 @@ static void damon_verify_merge_regions_of(struct damon_region *r)
  * sz_limit	size upper limit of each region
  */
 static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
-				   unsigned long sz_limit)
+		unsigned long sz_limit, bool count_age)
 {
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
 		damon_verify_merge_regions_of(r);
-		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
-			r->age = 0;
-		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
-			r->age = 0;
-		else
-			r->age++;
+		if (count_age) {
+			if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
+				r->age = 0;
+			else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
+				r->age = 0;
+			else
+				r->age++;
+		}
 
 		if (prev && prev->ar.end == r->ar.start &&
 		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
@@ -3163,15 +3165,18 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	struct damon_target *t;
 	unsigned int nr_regions;
 	unsigned int max_thres;
+	bool count_age = true;
 
 	max_thres = c->attrs.aggr_interval /
 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
 	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-			damon_merge_regions_of(t, threshold, sz_limit);
+			damon_merge_regions_of(t, threshold, sz_limit,
+					count_age);
 			nr_regions += damon_nr_regions(t);
 		}
+		count_age = false;
 		if (nr_regions <= c->attrs.max_nr_regions ||
 				max_thres <= threshold)
 			break;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index fbcc882dccc94..e543cfff15909 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -261,7 +261,7 @@ static void damon_test_merge_regions_of(struct kunit *test)
 		damon_add_region(r, t);
 	}
 
-	damon_merge_regions_of(t, 9, 9999);
+	damon_merge_regions_of(t, 9, 9999, true);
 	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
 	if (damon_nr_regions(t) != 6)
-- 
2.47.3

