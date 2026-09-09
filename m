Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67F21CFE0;
	Wed,  9 Sep 2026 04:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927659; cv=none; b=OvRc+IHcBF5aw15LCwnnZ5kD+UrJobU/5GbN/kAu3hgtUPeb8t+pvS0zJiJBvQ2GSlt/C6jd8jP/qk0Hz+eDCRWYVh6Qy1rhckmjk/OoREQ0xb88BuTq8R1H4gm14wrJTAIWVY0tFG1cp/2JrOWrTELSWTShnjnNKStscqIbUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927659; c=relaxed/simple;
	bh=DNaaQAfikZd387Z1gZFhTXiIEGFzu85yOr1d6SrKrA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQCTAlrjfmwwGG1TOm16yKfSHy+AEpZf1YdXgAV7MvQA0OsZxLqlYgn+52qmkVDra3KMOmyLDQTrgaEMyx1e70K0WJ60+HafLXgE+DY4Yo5gqDHvpbDpVIMt3Z6qUT7F0aqi/vzmTjxVzWwgY3h2z4eLCCewHcef5JXYHhodhBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C66zq7s/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C66zq7s/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179F71F00A3A;
	Wed,  9 Sep 2026 04:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788927656;
	bh=UFEC4xsosUO8drrQzh8cZu4b4CoiwiDfvvlbpePW48E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C66zq7s/YueZJeBn+1ZiLmSjAI+/m8jc1QRj0iDXtNLZBdEwVjW/NEbCCLnhmEoy6
	 9SxKvCLjvx2BblZVh2Tf9Aff9ZBI7uvI7qqFJ/ohYgqUewqYYE1c3WtFk0jq8y43y+
	 ph2zNSTyWQLFG9OI8KOTz9vrlmjaIdMcePv/7KGY2DL88LbFt0C/gJaPHIZx/uBuaZ
	 jnLm2Yr27eL7JU3msvYL4VTtIjiU8LYljSKb19/p4qcZ8H7EZJhmpMh1FL5V0Uqja1
	 seHxO0J90iDcHDB9LMdoDmpb3xXpJ8XSuGdVDYqtukyjXgBWxQ72q+HTBmmWfGg/Wi
	 YcXE9n6jORnjg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Tue,  8 Sep 2026 21:20:48 -0700
Message-ID: <20260909042048.192255-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090833-alumni-omit-f8a4@gregkh>
References: <2026090833-alumni-omit-f8a4@gregkh>
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
index 734ab958ec576..0114b4a20d27a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1237,15 +1237,20 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 
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

