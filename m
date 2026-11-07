Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047186;
	b=dTWEjrcCo7ozKxdlyNd2xx3U7TTLGgFOb1lMlFplkgdX9fA1p3VsZrLcoA2avCGsiJRb
	 pkoKUf7fZdQ+1PcpEvXBGlfpwdEOao/ehwa3LNqIwHH7gnhId7SlblqbDjMAQss43knih
	 OO/Tf3BEY8xD1a07tivoKXW/Dpj/Kl83iXcgkkNeMddERkPCxhOOcQO1qqT4TBzIX1GDB
	 60X4nhsYUXNkYsBkKlI7pABgohZTA5abupko2dotPI3OWdnc1miFd5zmRv2BQVhPJUTs+
	 uKUS0bOhYH9swKJViuqxqPhQIp7gKZaM09JhaJv8/Th22lDxt2Pc9mzE/ZaTXUEUbEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047186;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qSfItSSzVxDT4hI8FzDacd/zMEbPGpKdUOt1ajVYhyg=;
	b=1KusACbscRWZu66dmae68JgwkdCO4SmThD12uFTiIbyFmGB69FxQimR2a7B3Q8PGsiie
	 rvlTHELcYoMAqjruCycA2Vc26x2Vw85A5md4XjDBXWAMuTU+pE9OjgC2aGj0mlUNQoyJs
	 XNRWik0/WZxQC3/iue8tcZ2UOW2Z1b6PzepQyJO90Tl+1URGCrowjtpF+uyw2YOTxV6/e
	 pf1cyTJTGlb8hZFKiIoMAtIX3DZDNGszvf8Kfh+2kEDmBDVjYnK0H8dbjXN2NSROln3SD
	 SCit07PTxfxSbNXp8mBR7DWZZdURK1i/jJFxBxtB/EIFaMnR3AfaZgnc/0OxGmo+jmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d/ug8S2x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB56606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/ug8S2x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74801F0089F;
	Sat,  7 Nov 2026 10:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047186;
	bh=qSfItSSzVxDT4hI8FzDacd/zMEbPGpKdUOt1ajVYhyg=;
	h=From:To:Cc:Subject:Date;
	b=d/ug8S2xBBSyQUfiV+SIXC/oEKVfWDVWcU/pxNK71F/zg6BWh8MSLw9mbxno3KVz3
	 qkODm6drhZ5JFJdOJerXMyxBIT0NpeciI9nX6gjaNprlP9s2cXKGu+xamcKujbNH1F
	 NcsOSF7n7qI1LQgEudHzIn3nO9V/4Eky6jB+HF805xUwl4hBAcAFhkoXEwrDaSFe0O
	 1uN0naFZa4NiVUot99CmdeSpn/aWf5T8fgDRzWby1SWtAQljDgqZct5in46AShcvc7
	 RvzYV+uWqEM9gB8j2ar67g8BRJCEe4/OZM2PPuNnrufHqmLblxvBio7xXbXikj5cbW
	 A0o7MG62l6qHg==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: filter out damos address filter-split failed region" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:24 -0500
Message-ID: <20261107052624-failed-6.12-bbeec2d8324d@kernel.org>
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
git cherry-pick -x bbeec2d8324d7aac438bb12dd2d22b184e0a8d43
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052624-failed-6.12-bbeec2d8324d@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bbeec2d8324d7aac438bb12dd2d22b184e0a8d43 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 19 Oct 2026 17:41:18 -0700
Subject: [PATCH] mm/damon/core: filter out damos address filter-split failed
 region

When an address type DAMOS filter is configured, DAMOS tries to split the
region for the filter range, and apply DAMOS action to the filter-in
region.  The split operation (damon_split_region_at()) could fail from
allocation failure under extreme memory pressure.  In the case, DAMOS
action could be applied more or less than expected, ignoring the address
filter.

The issue only rarely happens under extreme memory pressure.  No crash or
leak happens.  Occasionally not applying the action to a few regions
shouldn't be a real problem.  But applying the action to a region that the
user has excluded via address filter could be a surprise depending on the
use case.  It is only theoretical.  No such real case is found yet.

Filter out the entire region if the split is failed.  Update
damos_filter_match() signature to receive the error from split.  Also
update kunit tests for the updated signature.

The issue was discovered [1] by sashiko.

Link: https://lore.kernel.org/20261020004119.106690-1-sj@kernel.org
Link: https://lore.kernel.org/20260801203121.117449-1-sj@kernel.org [1]
Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos filter")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org> # 6.6.x
---
 mm/damon/core.c             | 16 ++++++++++++----
 mm/damon/tests/core-kunit.h | 11 ++++++-----
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b63e60ef89901..479169dc9ac75 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2551,13 +2551,14 @@ static void damos_update_stat(struct damos *s,
 
 static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos_filter *filter,
-		unsigned long min_region_sz)
+		unsigned long min_region_sz, int *err)
 {
 	bool matched = false;
 	struct damon_target *ti;
 	int target_idx = 0;
 	unsigned long start, end, wsum;
 
+	*err = 0;
 	switch (filter->type) {
 	case DAMOS_FILTER_TYPE_TARGET:
 		damon_for_each_target(ti, ctx) {
@@ -2583,12 +2584,13 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		}
 		/* start before the range and overlap */
 		if (r->ar.start < start) {
-			damon_split_region_at(t, r, start - r->ar.start);
+			*err = damon_split_region_at(t, r,
+					start - r->ar.start);
 			matched = false;
 			break;
 		}
 		/* start inside the range */
-		damon_split_region_at(t, r, end - r->ar.start);
+		*err = damon_split_region_at(t, r, end - r->ar.start);
 		matched = true;
 		break;
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
@@ -2607,10 +2609,16 @@ static bool damos_core_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
 	struct damos_filter *filter;
+	bool matching;
+	int err;
 
 	s->core_filters_allowed = false;
 	damos_for_each_core_filter(filter, s) {
-		if (damos_filter_match(ctx, t, r, filter, ctx->min_region_sz)) {
+		matching = damos_filter_match(ctx, t, r, filter,
+				ctx->min_region_sz, &err);
+		if (err)
+			return true;
+		if (matching) {
 			if (filter->allow)
 				s->core_filters_allowed = true;
 			return !filter->allow;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 3fbb4e4e36fac..43e2f950f8ff4 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1783,6 +1783,7 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r, *r2;
 	struct damos_filter *f;
+	int err;
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
 	if (!f)
@@ -1803,27 +1804,27 @@ static void damos_test_filter_out(struct kunit *test)
 	damon_add_region(r, t);
 
 	/* region in the range */
-	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f, 1));
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f, 1, &err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region before the range */
 	r->ar.start = 1;
 	r->ar.end = 2;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, 1));
+			damos_filter_match(NULL, t, r, f, 1, &err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region after the range */
 	r->ar.start = 6;
 	r->ar.end = 8;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, 1));
+			damos_filter_match(NULL, t, r, f, 1, &err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region started before the range */
 	r->ar.start = 1;
 	r->ar.end = 4;
-	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f, 1));
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f, 1, &err));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
@@ -1839,7 +1840,7 @@ static void damos_test_filter_out(struct kunit *test)
 	r->ar.start = 2;
 	r->ar.end = 8;
 	KUNIT_EXPECT_TRUE(test,
-			damos_filter_match(NULL, t, r, f, 1));
+			damos_filter_match(NULL, t, r, f, 1, &err));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 6);
-- 
2.53.0




