Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9393E25B084;
	Wed,  9 Sep 2026 04:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928468; cv=none; b=cCf3jPfr4O2E1H9CNJAtD8crzmbyhr3A4iDErZ/3BeM7mMN6oW4L/0aEPkb3+Qn1U9RYmTjJOOEUdJbYBR55UT3aqlXmla9iOpIkFQj7KFIKjZG+7qq/hccon+/GOSiok+i8yOKqstncFKwU+dViav1zGZ+XDabKVlEbjJvFzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928468; c=relaxed/simple;
	bh=RjftUTkqIxjwLjREn9IqN/n/aNgGyWgDT7zDOE53bwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cq7vSOMgTOPDKinKBUDiBYJHaj+CCC4C5zP0LZq0TsiJV3ACqpBoCjffaoJVLwOfwNEEiEjHH0lveKP9aJ8hNXG3dXqERlmiDH6pzAuGqlozbZey3wZonJe76XHcDdeigl7AVnq/geq1TYyHokoktbOxIOVQ9I93TvMtk0kDohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLnDse9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLnDse9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105281F00A3A;
	Wed,  9 Sep 2026 04:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788928467;
	bh=CLwnfJIcOyNd4QgTYzaN0BAv4tdUSsqor/S59NnMt/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aLnDse9I78OeKOGfqTVJZRL4nzdv+8drb4VQ/SMrrRQNZJROpcm0vaO+qH8n3kVLA
	 ks0Dt4mA1/PSGqvQV94tt+MP6/plGKH6f+PK1fKa9jSodr/NPvGWS99eLGKLDRoahp
	 QWfVJJ6wfXQ5k5/JBy5v73gWMNUzot4ng/TXx6p/v1bKKrUlnXG0mrLh2MPH2Mu+pQ
	 m26dwOhajhvwVot9jrg9a/trAQImRPrjhIkHsvdX05DI/NKI8IQJIeHFScqOzpn4gP
	 JWRkrvhAnDHcME2LrI0MdmzDfy6aspZm2nx6huni0GKSOym1tK2Hk9dbkfsuGVgklD
	 v0zYPAULmYorw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.2.y] mm/damon/core: skip aging from repeated aggressive merging
Date: Tue,  8 Sep 2026 21:34:19 -0700
Message-ID: <20260909043419.207354-1-sj@kernel.org>
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
index cff932b3317d0..024a3a185bfe8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3115,18 +3115,20 @@ static void damon_verify_merge_regions_of(struct damon_region *r)
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
@@ -3160,15 +3162,18 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
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
index fcf7c7fadb5fe..59bba0552d88c 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -256,7 +256,7 @@ static void damon_test_merge_regions_of(struct kunit *test)
 		damon_add_region(r, t);
 	}
 
-	damon_merge_regions_of(t, 9, 9999);
+	damon_merge_regions_of(t, 9, 9999, true);
 	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
 	for (i = 0; i < 6; i++) {
-- 
2.47.3

