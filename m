Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9089638736F;
	Wed,  9 Sep 2026 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928866; cv=none; b=Qzxm27qiMJgeBD09XcsdaXEDELvFcK5Jlwb4ciDm8APCepUsd6JuuDyBUxsg7umwrLKH++NMgAOM9iqkX8gTLVl0HY5I9lo9Z3kErIbX7eqRynrYeGmtbocmeOlTu+EJprHAul7x45DUKstNpN/SinizXIdUpNeNZBcPOwQ43GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928866; c=relaxed/simple;
	bh=byZhMLfKxBGjxD0VBKwPC/GwsXnX9exJwA0EkIpf92Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pn3clMu+zG0lO/OkOuYxTPrCIlIXgoLQEMiWrVnfBNoAgPmV+LDv2aS8RcFyfT7Ik4zCv5bmqYZmDifE88+KiMT6VEztW59u6cQNFTsmNb3EJWrpgZLmbNctZnPIgNeHBCr8feb0IxNbY3PqvyfxsU905VmQKvQ58XKr2eJ+WWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoDqkSuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoDqkSuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A151F00A3A;
	Wed,  9 Sep 2026 04:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788928862;
	bh=RppHdJ069L4RLGMx76xnjPu/gB00fphi6UNzE0iIqGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YoDqkSuY+Xk1xkH/DAA7iRQE2ygIKWlvlE75a5TgM918YE43deUmGxr23dF2L3jqw
	 QMaVScPyvhxjhQqhg579rzVfpFiYy3FpFkD0CeGU3fnd1j10LGh65H6l9i/8SLZ2YH
	 h5IWzBiR40MsQQqpCtlH/a/RfiXEDU0NYvebzQj7lDlKhTT/uHOLNhZYre7R45QHu3
	 HZ5NHxzoO+BOpRogbQlxGP/YeUgv2viAWmvPj3W1toWTe9yJ6ROLVdc2B0K8iwVItg
	 INvyPIMXkIvc+G47xOCG0gNWTgDFmlRLhHQExL/m+NmntjWzhc11siaBv16Ok/eR8m
	 rC6CgcNW7xgBg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/core: skip aging from repeated aggressive merging
Date: Tue,  8 Sep 2026 21:40:55 -0700
Message-ID: <20260909044055.213060-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090840-shifter-galvanize-450f@gregkh>
References: <2026090840-shifter-galvanize-450f@gregkh>
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
index 70ac1f08753d1..c98539efd2a56 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2364,17 +2364,19 @@ static void damon_merge_two_regions(struct damon_target *t,
  * sz_limit	size upper limit of each region
  */
 static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
-				   unsigned long sz_limit)
+		unsigned long sz_limit, bool count_age)
 {
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
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
@@ -2408,15 +2410,18 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	struct damon_target *t;
 	unsigned int nr_regions;
 	unsigned int max_thres;
+	bool count_age = true;
 
 	max_thres = c->attrs.aggr_interval /
 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
 	do {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-			damon_merge_regions_of(t, threshold, sz_limit);
+			damon_merge_regions_of(t, threshold, sz_limit,
+					count_age);
 			nr_regions += damon_nr_regions(t);
 		}
+		count_age = false;
 		threshold = max(1, threshold * 2);
 	} while (nr_regions > c->attrs.max_nr_regions &&
 			threshold / 2 < max_thres);
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 6687778752728..80dcf1d641e07 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -261,7 +261,7 @@ static void damon_test_merge_regions_of(struct kunit *test)
 		damon_add_region(r, t);
 	}
 
-	damon_merge_regions_of(t, 9, 9999);
+	damon_merge_regions_of(t, 9, 9999, true);
 	/* 0-112, 114-130, 130-156, 156-170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
 	for (i = 0; i < 5; i++) {
-- 
2.47.3

