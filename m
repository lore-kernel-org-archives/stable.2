Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90475437EC
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872240; cv=none; b=Ho6/HXlu61F2lGjFVdDEieJQDZine0gSRoVtodtwKDR/6295RATB/THM7M40Wh7QFtFvOqCq88V/DzQlEFjmz1oCOp5eKXgvEuuRo8YDaudk42wSWLaQAw6+I/3s2Mw1PJP9tWLSmsSsItY3BVwruWEkLpFPjjs5Sno71X7KLeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872240; c=relaxed/simple;
	bh=5poo7QGoRFC8Gql0b1/ZBpp000/2T/CefGnx1gv3f3M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JEd9VTwo/x0xdQYppD3TxNmW1u1TnRtBuSK/ywPr/F/y7HUcDKFgtK7i8jHrzb7fhOK32BfDZDhgCkbYZc+HUz8rM2rC/X5vdCajhHIr6SaHgx82zasfuyRN58U1BfGbzuM7JTWab8NDoZ27H/sTg6ozLLQh+TXhdIYlVIBnuNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E7A1F00A3A;
	Tue,  8 Sep 2026 12:57:17 +0000 (UTC)
Subject: FAILED: patch "[PATCH] mm/damon/core: avoid infinite kdamond_merge_regions()" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:52:34 +0200
Message-ID: <2026090834-colonist-recital-c7f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 123e4619ab6c8ab1c4cb1d7a58311a2af13929cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090834-colonist-recital-c7f0@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 123e4619ab6c8ab1c4cb1d7a58311a2af13929cd Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Tue, 14 Jul 2026 20:09:56 -0700
Subject: [PATCH] mm/damon/core: avoid infinite kdamond_merge_regions()
 internal loop

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

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6c4215cc809e..603b102ff80f 100644
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

