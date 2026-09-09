Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426032ED54;
	Wed,  9 Sep 2026 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929237; cv=none; b=pM36ds6wpng40yai7yJ3ofGlQEKEXCCXqPHeydm6qunjIhdmsL0MkGCuzO3YDw5rqwSOQv5iNg/X9fkl3q/kq45PdHbkGtCtINHlMSEyCLECli1yGdAlYBeUWgzAJ1QfQpqAW9/k2JCQjI35Y857ZLJ5QeBpKjDquxgdWuizwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929237; c=relaxed/simple;
	bh=G+8qT/JhhdMaSeXRwsuX3wDoFUUc+n7EXmtgIYUmpck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON4uoTIfxX94+IwncC+FzYJVe3/nt0BgLOoMokQmeCQ63hPQuLYucPTUjnxk/lNHYkz7U6WP4tsSZsIthlnjns3N7zSojGFqH1dRjAe086BkJ0UYE7+iyNElfF2nkiobonbUSzOoQuht19wq68dShY8pfFV8VXq/A8rlpVYwPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJIq+TXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJIq+TXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F33B1F00A3A;
	Wed,  9 Sep 2026 04:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788929235;
	bh=NJcqsU+Pbgnh9O1bONPLVmIXpScym7b80IxKOTJ+XnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cJIq+TXfgOjnwUsyW4PeiAQgk8QpD4FYxSbbddCAqldo/bv3NWNpqWl7C6rY1dfi3
	 AM0ebAzQsaiP6olFKZObBMpnATFZ0j8uCHCOkD+SJYr1vrWY7NLAqnYVEuiiOvhzyT
	 60uYXWzoF1me9GdHjz52jTSESFaFyuDsurFrQU5I8UBcGdFsBUu8WEVRpk/GUH9t6p
	 KEBHIslxwi4pIbS4gzrSZALUIlWdl6GOy3xy1+SiA0A4MiqXoUa0zwkDTd7V0VKg7h
	 aixp0v4aww2j6baIIZDTUCP/aKsoJeMu/rz7jHERJs9GX4SZ5pH+huaUFulDopZ+GD
	 /D5hUc/NiGtEA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/core: skip aging from repeated aggressive merging
Date: Tue,  8 Sep 2026 21:47:07 -0700
Message-ID: <20260909044707.221421-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090841-dingo-oxygen-6b88@gregkh>
References: <2026090841-dingo-oxygen-6b88@gregkh>
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
 mm/damon/core-test.h |  2 +-
 mm/damon/core.c      | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index a2aa410d6d0d0..1c8c64dbb6773 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -250,7 +250,7 @@ static void damon_test_merge_regions_of(struct kunit *test)
 		damon_add_region(r, t);
 	}
 
-	damon_merge_regions_of(t, 9, 9999);
+	damon_merge_regions_of(t, 9, 9999, true);
 	/* 0-112, 114-130, 130-156, 156-170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
 	for (i = 0; i < 5; i++) {
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 734ab958ec576..0713fda22682c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1192,15 +1192,17 @@ static void damon_merge_two_regions(struct damon_target *t,
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
-		else
-			r->age++;
+		if (count_age) {
+			if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
+				r->age = 0;
+			else
+				r->age++;
+		}
 
 		if (prev && prev->ar.end == r->ar.start &&
 		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
@@ -1234,15 +1236,18 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
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
-- 
2.47.3

