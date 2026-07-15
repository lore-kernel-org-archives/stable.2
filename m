Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C5352021;
	Wed, 15 Jul 2026 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085013; cv=none; b=oI89p5RqFICx2VWUIa6fdoED9c/4r72MXl6I4buQY86/nkRr8yhWiuTwDTw5mHZD8zcZ8yjX/KXMLTSrM8cQXGSvYIIPWPPtAEdklrQBfIDHWjD00jidQ9E9PtZEH5DtBZv2rYLWAivuuo5/NXnlncpSSVV6ddSESkexRKsak/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085013; c=relaxed/simple;
	bh=uommVYjcgv1yUQymXHLWitvXUy8HlVyIq9wOy8obzmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR3pj4huNzOdlZCpk+pdRmqzZAKkj+8fg3/pHJc/DrHZ5Ck1Jv1Ij8IcEo7KgGzc6U7lQPD9l/MJDFjixL7na6diNe84srdvZnoEh08E6lwJ7Ow+mNHJUeUygPytgKg14mfwhId054ZPDeiSm1fyROsJRP9xm+7jRRu8X/h/WDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJVol9+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJVol9+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227411F00A3D;
	Wed, 15 Jul 2026 03:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784085012;
	bh=Q9KjTQrAluw9j+QP6j3O8xbCeroVnCVq06v65dUktLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EJVol9+hnUXr2MkTGjNeeTnr9zgtGiH5lhzdGvYd5zJCaySf6cSWxfS2J3u35p82W
	 aN7k6jW22+/k8MA0TjfYViaGj0UAvcbe6CKpmzA1dp9E3K6YhK2ZdiYbQ0X7OM0XuI
	 dl/ev0OzfVJ8SUjSrzFznTDRFzs+1NpfgomlPcRCKQO/u+Dh8IWCUwhA5ueQLIzG6L
	 5paLEU0Opf1bam6u3Q2eugM68ni7424Ag6gCP5C41ySgpo22WQZ3rGKa8y344o1L8Y
	 xvkVkSdvWNiU52kuxdqXM20DRFUDW71jWFix1mRQCU7heAgrJ2k910rqfYpb0g9ee5
	 cDRNSdDPvfA/Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 1/6] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Tue, 14 Jul 2026 20:09:56 -0700
Message-ID: <20260715031002.108504-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260715031002.108504-1-sj@kernel.org>
References: <20260715031002.108504-1-sj@kernel.org>
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
