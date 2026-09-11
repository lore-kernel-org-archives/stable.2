Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829748C406
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134560; cv=none; b=pBMDhT9/g37hSVkLTAlGo9owfyQbm1R9r2ZYcgj55TBJc89HPrHgUD/Xka6bmp6LxLnUHNtVhbhSE89uqu86o3xSa81/HBdkwmlbdCJyfX6avXKGufH2e2BfnXaYp6TFG4XHcIG3rmCXbrfk52WDGK6xfJNrXxV//PM0JL4oHS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134560; c=relaxed/simple;
	bh=kdkmqAatzIjtZKxl1W2e6MjWNUcq5Ih9uYD3TIIG4dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r530moNykGmNsuoNN1i3hcty30wtfSbZpkV2J6kf5HuCEizF8mJu7jeDL9eV3Z0TBkASSKDJy9q/arZoRkpZIR+sMlEVJymtO6FkEZ6+waaHX0U4xgkxA6LEBytNII3DuqbrmOvbKNvDyD6lFfpaM56OnCFkGoqu/MMm0NXQ1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihuZCf9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihuZCf9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E631F000FF;
	Fri, 11 Sep 2026 13:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134552;
	bh=G0uYWeyT4fK92rPfsbD17JlqulCmFAAmuH19nLfAWkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ihuZCf9IxaqozGUp/LTyz0wafslJ8VOHAtndmM4tKFT4N9A9+/0eoGhRh8cvSUXdG
	 S7pkHBT7C4rl4HYYNWZRiBUFqjF4RgRTHco+hvHpFvKjtqgbmR6koU0hhXcGpMbTW8
	 W1DKzUjlkX/mj+XwUCFihI+qlwYkOehvXU1yxvX0Tdycanss3G4IkiKkKeFFOsAVVM
	 mgyLtBwg2nsF3DkQHl96IcICPDc2nrNHvObK7R35crqgbEiR/0nBLWBBzZVfkSYLqy
	 CSbVHJrSfKKU8qy6Dciv4D3O0PbZzdNeZmft7S4iJlg2hKNJFSzCisfLposLeCmQL7
	 n7z6z8KxpV3tw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y v2] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Fri, 11 Sep 2026 06:49:04 -0700
Message-ID: <20260911134904.96369-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090831-drinkable-maybe-5e01@gregkh>
References: <2026090831-drinkable-maybe-5e01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch series "mm/damon: unurgent fixes for infinite loop, NULL de-ref and
races", v1.1.

Sashiko found a few issues in DAMON that could cause infinite loop, NULL
dereference and monitoring results degradation.  The first two sounds
scary but the infinite loop happens only under unreasonable user setup.
The NULL dereference is only in a unit test.  Monitoring results
degradation is trivial since it is only best-effort, and those happens
from only unlikely races.  Still those are bugs that better to fix if
possible.  Fix those.

This patch (of 6):

Due to online parameter update like events, the number of DAMON regions
could be higher than the user-set upper limit.  kdamond_merge_regions()
repeats merge regions until the number meets the limit, while doubling the
merge threshold up to the theoretical maximum threshold.  It is tried only
up to the theoretical maximum threshold because even the aggressive
merging can fail from reducing the number of regions under the
user-defined upper limit.  For example, there could be many user-defined
non-contiguous regions that cannot be merged.

The threshold based loop break condition is evaluated by comparing the
threshold for the next merging try against the theoretical maximum
threshold.  If max_thres is larger than UINT_MAX / 2, doubling the
threshold could make it overflow, and bypass the loop break condition.  In
the case, if the number of regions cannot be reduced under the upper limit
like explained above, the loop will run infinitely.

Prevent the case by doing the break condition check before doubling the
threshold.  Also, prevent the threshold exceeding the maximum threshold,
as it could overflow and apply the wrong merge threshold.

This issue is unlikely to occur in real world, since having the max_thres
higher than UINT_MAX / 2 require unrealistically large aggregation
intervals compared to the sampling interval.  Also, it requires an
unrealistically large number of uncontiguous regions setup.  Nonetheless,
the consequence is bad and the fix is simple.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260715031002.108504-1-sj@kernel.org
Link: https://lore.kernel.org/20260715031002.108504-2-sj@kernel.org
Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org [1]
Fixes: 310d6c15e910 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.10.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 123e4619ab6c8ab1c4cb1d7a58311a2af13929cd)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a9168a03b3402..6fa02025d2af1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2415,7 +2415,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 
 	max_thres = c->attrs.aggr_interval /
 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
-	do {
+	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
 			damon_merge_regions_of(t, threshold, sz_limit,
@@ -2423,9 +2423,14 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 			nr_regions += damon_nr_regions(t);
 		}
 		count_age = false;
-		threshold = max(1, threshold * 2);
-	} while (nr_regions > c->attrs.max_nr_regions &&
-			threshold / 2 < max_thres);
+		if (nr_regions <= c->attrs.max_nr_regions ||
+				max_thres <= threshold)
+			break;
+		if (threshold < max_thres / 2)
+			threshold = max(1, threshold * 2);
+		else
+			threshold = max_thres;
+	}
 }
 
 /*
-- 
2.47.3

