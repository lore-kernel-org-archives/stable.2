Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70430372075;
	Sat, 11 Jul 2026 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783793061; cv=none; b=fMB2HKqzFtu1rRUArdtBKYv+Om88wQq1ZdFy3yGaNbhP9LB3vhz2I+55SRAjnm+XaiGgFQ/TU/4XMDdvgIifLHxNy8L5q3mRLQuWQFzwvhGvRsoCYEdVzmZTNOeF8q8EDIFEjWF58mAof5L7RRlZL9cCF2FkHPALKcrTFndDklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783793061; c=relaxed/simple;
	bh=uommVYjcgv1yUQymXHLWitvXUy8HlVyIq9wOy8obzmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDtAobO1eNQ9DG8kfQUbONZxhk53ObR7YbP2oUUaXcHjKACxq4a+QWzNv7+6sjAsHTrDUTpDJfrMA46Y+QVlJQmqpxxpmkgyM6uurEDLClsKWm3qXSEYMAVQwWZ+t3KaKqAuqoCzb87ZiUSSCh1e171ST2rAE2h0lJBHBfG2QoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM7JMyvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM7JMyvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D021F000E9;
	Sat, 11 Jul 2026 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783793060;
	bh=Q9KjTQrAluw9j+QP6j3O8xbCeroVnCVq06v65dUktLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZM7JMyvKDar39MxAxv9gEXqrrpdcMhCd0EaxaHFtTiOxwPWfh9E8aGiJ/Zw1mE65n
	 emJa9iHLBdDxaY3ZQwrs26X/ipMp+fiCY8QS9w56DtrrZVpFwjofAUN+FpytNFDXnp
	 aGklVVK7h5VtCqPemCJ5Jxgp1ygBuhPifJhNsvkeERtbspZeclMmU5W4X+bdLREpIm
	 KBAsjy6by68i1W6n5VtA1+8Y3eYoT8wmov3iLMtQX0pxutZo5+nTB8RAclaEsHZpK0
	 smYc+dxIOBy7zZOSiUNAwQLPQ+QmlH6kliZeYGU7XpMSvAs3Fw/AloPX8VwwjInK9a
	 BVFTK/0Rdbbsg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 10 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/5] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Sat, 11 Jul 2026 11:04:04 -0700
Message-ID: <20260711180409.82093-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711180409.82093-1-sj@kernel.org>
References: <20260711180409.82093-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to online parameter update like events, the number of DAMON regions
could be higher than the user-set upper limit.  kdamond_merge_regions()
repeats merge regions until the number meets the limit, while doubling
the merge threshold up to the theoretical maximum threshold.  It is
tried only up to the theoretical maximum threshold because even the
aggressive merging can fail from reducing the number of regions under
the user-defined upper limit.  For example, there could be many
user-defined non-contiguous regions that cannot be merged.

The threshold based loop break condition is evaluated by comparing the
threshold for the next merging try against the theoretical maximum
threshold.  If max_thres is larger than UINT_MAX / 2, doubling the
threshold could make it overflow, and bypass the loop break condition.
In the case, if the number of regions cannot be reduced under the upper
limit like explained above, the loop will run infinitely.

Prevent the case by doing the break condition check before doubling the
threshold.  Also, prevent the threshold exceeding the maximum threshold,
as it could overflow and apply the wrong merge threshold.

This issue is unlikely to occur in real world, since having the
max_thres higher than UINT_MAX / 2 require unrealistically large
aggregation intervals compared to the sampling interval.  Also, it
requires an unrealistically large number of uncontiguous regions setup.
Nonetheless, the consequence is bad and the fix is simple.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org

Fixes: 310d6c15e910 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet")
Cc: <stable@vger.kernel.org> # 6.10.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6c4215cc809ec..603b102ff80f9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3372,7 +3372,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 
 	max_thres = c->attrs.aggr_interval /
 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
-	do {
+	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
 			damon_merge_regions_of(t, threshold, sz_limit, c,
@@ -3380,9 +3380,14 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
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
 
 #ifdef CONFIG_DAMON_DEBUG_SANITY
-- 
2.47.3
