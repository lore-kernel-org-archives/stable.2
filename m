Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0A23D7FB;
	Wed,  9 Sep 2026 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927979; cv=none; b=jAnyP9g0x/+nvY4zNFYokN0O3S4AAERt/hiuBWXhd2cxjdATE8zOgePKwzeIH3IwXkI4vHhvJacqejYr+7jgGKwcSI2zKcwh1U4JF9mVSX0uYLUbGAOERLeb85Qrht5sIFBiwYtH6145y91wLjNynuCYAxAOofAVhyqZSS0YPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927979; c=relaxed/simple;
	bh=X6/F9twl+mKdqAiMkyvUNB373OjGPL/2c7c6F4jGznk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mbo3Gk2z/8s2bHZFKQJvdwZFNVoFJD58dMvHf+XmJV/OzrRq6uBE//nB7QqNGZQ8e0FpNWptDFo1lenzCEk6p5hCuoVClesTbnqY9xMu0Nqy4T93GQIcQEqgsGPUNMnWCvqwfWTtGiuycAAuFc7t3QJeToAqpFbG3jTBJlbXHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN5/8Gvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN5/8Gvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535D91F00A3A;
	Wed,  9 Sep 2026 04:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788927977;
	bh=1Wg9y4URpIuejPf2yQZ6Jp+S2HhM3At8AY8fBGl1U9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QN5/8Gvbw5lvb99j2dM7fuOEsL8GZdtMkqSqmxFaPOIKEVBTWO0skRHOXEUjdS/7v
	 LDc7jKIvfQUzd5jCWHH0QXXQ8xye2VZmlnBfQjK6kb1pfoYadQAr8VXGLFvPchTZ3T
	 HWe9fi0AEQ+PEFZeRk0c3T5bEtzCvvaNk8UdCmWO10NpzgAp/VdU16Ur4j7a8eBjUV
	 w2H/DmzE9jdN8VpTN34aCLZyoLE3XLRINiNRK9eXvQ+3v8RVDtfae0A4pPXrLOtLcn
	 j6rMzbPuITxSoEhIO2HhbkOcd9b8kO4gj90UOF+rGznKdyi0pJxeo6WtVOygJNEx6R
	 bLo8eZuVEXb2g==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Tue,  8 Sep 2026 21:26:09 -0700
Message-ID: <20260909042610.203053-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090834-colonist-recital-c7f0@gregkh>
References: <2026090834-colonist-recital-c7f0@gregkh>
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
index dd4eafe8b9611..21c26a57c1d92 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -985,15 +985,20 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 
 	max_thres = c->attrs.aggr_interval /
 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
-	do {
+	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
 			damon_merge_regions_of(t, threshold, sz_limit);
 			nr_regions += damon_nr_regions(t);
 		}
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

