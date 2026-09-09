Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E82BB13;
	Wed,  9 Sep 2026 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927867; cv=none; b=ounrOZxLkVdjyDXo30Ktksjou5/0IWHKf+2WefdA0bPp+A5u3YNnnGrrJQxzPIuHhad7kaLLN/dPwxPxjduRYAIgr8hfK9/Idk/HiM0NaAF7s9vcfErGFpTlHN8uCmsStpMaThcMEQHqk/HaHHXWtLa2jJWtr5X5zISUn5sz8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927867; c=relaxed/simple;
	bh=H4Ir0v5x9i/tTjN18OjAKE0j7ASipgaAdGJLNPzs7Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP9UxpjvjLaTHIEPxQIHgz0Zti9atlr+vusfR+a6vHjo9vZfDMZpWCBQf9WkmNDRB3VS6xZOWBHEgpuWfJkCcB297Ri8ASuxK5SsPXT7Bu3ssdx2wpoX2A/IMIPyQaDs4rY8wgFBu5YCupCyPI+8IdkuWE9+8dmCZoK3MLMs0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAd8baAr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAd8baAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383731F00A3A;
	Wed,  9 Sep 2026 04:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788927865;
	bh=7TkOzltSDQx1zP5alXOwFJ/Z9hM/2rFgGnNUrZykawg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GAd8baArSTU3EtqwzWVZnV/xJWhUAJKEHlsjAfK/ul9FJdGGWX0d2b4g0WHGpUg/F
	 X4PUjA9sHh9SVm0I3DDnXGDw0Vhh1rqv8XpPtQjFAeatSb8QLFxi0wr2dGlD0OEdia
	 Pvd0bw9C/ask9HzTQeqKzBrqjoI6tSmKDerqxx3jASzEmqUGFgzKhOAtvu6v8vBy/U
	 RAoVaYrym9VUlGrXrFhYZz3f9sew6LZl2Hc6d6szWo1EXEZqj6a89C7HDmqKUrdIGy
	 LyQhcZ8p1WzIHzDDgJgnwcPaWy6WDataHE3Q0yJwIRRyX/CR/H8JtZVEEvuM7b0Xn1
	 FQD2VgI6qG50w==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Tue,  8 Sep 2026 21:24:17 -0700
Message-ID: <20260909042418.198028-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090834-entourage-unwound-48d4@gregkh>
References: <2026090834-entourage-unwound-48d4@gregkh>
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
index 4f031412f65cc..3a50ced2efc0f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -523,15 +523,20 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 
 	max_thres = c->aggr_interval /
 		(c->sample_interval ?  c->sample_interval : 1);
-	do {
+	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
 			damon_merge_regions_of(t, threshold, sz_limit);
 			nr_regions += damon_nr_regions(t);
 		}
-		threshold = max(1, threshold * 2);
-	} while (nr_regions > c->max_nr_regions &&
-			threshold / 2 < max_thres);
+		if (nr_regions <= c->max_nr_regions ||
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

