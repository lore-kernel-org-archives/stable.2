Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28394542805
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872225; cv=none; b=egGRRr9iLpNEZZN6QDENxxrSv9Gn3oAz3pmwGFuiTWH5/4nmuPvaliVuyrConz3inLDxCT3NoMMq3MsQjUs7ET4eTtuN6yFSI7naMGFDHlp1Waqskkgqp6VH5MVjWPzDK6DMhRygQ4M+6OMd+avpnoqTEcEWf7w8LVUg/V6dxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872225; c=relaxed/simple;
	bh=M9D9oWhfv7xD1tNyyiFmg3KKEj2NuEycCa/ngDpJr0I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OkP0ecCSh9oELigoeUu70MBXwR+CwFBu4CzzDB37+hUs6/mgI5cVAC7pEAATFvizscykc83qfOF4cITnvZ0VhK5rVc6bezm03K+IPh9nrZF0rBpMkgO2ZgLiLTMNBGxhQNq3msG77Qep7uUg0zOy1eED8JFz9ixItrxTzhUwqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A9DPAPgZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A9DPAPgZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AA31F00A3A;
	Tue,  8 Sep 2026 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872224;
	bh=HGleCmUVm2fGOxq52g4XYJJT4CcMtlKxc2LKInYx/rA=;
	h=Subject:To:Cc:From:Date;
	b=A9DPAPgZyn0I7xtroNwLboQZ2mYgwQj94miKMMUPxhP1N8sAQ1TbLQYxhrvdbOlv3
	 lzRckv+EG2QRlhOa8bgvKuuCI3HND5GPYrspmTAdfSlE0mGErz0GQN212EO3DtpR62
	 KriAAmNIxW2UnjAnQ4sbUKiGsdmDlLThzmN2TGgE=
Subject: FAILED: patch "[PATCH] mm/damon/core: avoid infinite kdamond_merge_regions()" failed to apply to 7.2-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:52:31 +0200
Message-ID: <2026090831-desecrate-cheddar-be5a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 123e4619ab6c8ab1c4cb1d7a58311a2af13929cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090831-desecrate-cheddar-be5a@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

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

