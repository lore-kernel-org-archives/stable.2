Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9ED53ED15
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872261; cv=none; b=ICzQNrU0t8fDuFhmxD1HxuZuDOJfA/Mn+tcyAE6Iu9LtnBmpoZtIj1tidbpBePYlJO4uxdLmZBNqQU+YNfWLNN/qBIAncePsiIbzsfouOSA71D/v4KzcL8ZBn2E+ld160pxsqyOPneK1ZI6EzG74YG8HwuAHOPlhh1oo1/8e6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872261; c=relaxed/simple;
	bh=IQYxxDuweGRbi66enptMnO+ApTUhZ5Gf3J8O28C/hdI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T6rr1m3RMqq5qclTWyMC+RZ9uaIokFFc9BzWPPC2bpTMDy7smF9TXVpUl78lJfbnzqhrt5YKP5rO5/yZjr3cMqq09qB1wNtlxGsGlqN/t44MrEP68g0TusKZFIcA1TufnPfYir/2WShXl3VOP8ufUY/h+ANXksyvhefYrXmHcyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jJTrQ4Ij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jJTrQ4Ij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECB51F00A3A;
	Tue,  8 Sep 2026 12:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872260;
	bh=aVB9Av80SeHpc5cEogbmsyBGM5KQIE1VH6l4hU75Y+c=;
	h=Subject:To:Cc:From:Date;
	b=jJTrQ4IjKx2+w+cpxmyaDX2KV07rSUxNI8Ktu7hyKNjfpl0Z6fL+B+Yze0eciNqVd
	 jlsqAmqMORnWEc5BNUnzJBjzFFJEaNaQ0NQzD9OriJPcKL87cjEBOR339tSEIdsQy6
	 c2KkWdx9N0MvwaKB3zzJAdExqlHGPMTM6tosWqLc=
Subject: FAILED: patch "[PATCH] mm/damon/core: skip aging from repeated aggressive merging" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:52:41 +0200
Message-ID: <2026090841-dingo-oxygen-6b88@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0250dbe08c730d003ef9f484da56ae09a1ea0c4c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090841-dingo-oxygen-6b88@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0250dbe08c730d003ef9f484da56ae09a1ea0c4c Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Sun, 12 Jul 2026 09:54:30 -0700
Subject: [PATCH] mm/damon/core: skip aging from repeated aggressive merging

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

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 806a67d02a6e..6c4215cc809e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3308,7 +3308,7 @@ static unsigned int damon_merge_score(struct damon_region *r, bool last,
  * sz_limit	size upper limit of each region
  */
 static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
-		unsigned long sz_limit, struct damon_ctx *ctx)
+		unsigned long sz_limit, struct damon_ctx *ctx, bool count_age)
 {
 	struct damon_region *r, *prev = NULL, *next;
 	bool use_probe_hits = damon_has_probe_weights(ctx);
@@ -3319,12 +3319,14 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 		score = damon_merge_score(r, false, ctx, use_probe_hits);
 		last_score = damon_merge_score(r, true, ctx, use_probe_hits);
 
-		if (abs_diff(score, last_score) > thres)
-			r->age = 0;
-		else if ((score == 0) != (last_score == 0))
-			r->age = 0;
-		else
-			r->age++;
+		if (count_age) {
+			if (abs_diff(score, last_score) > thres)
+				r->age = 0;
+			else if ((score == 0) != (last_score == 0))
+				r->age = 0;
+			else
+				r->age++;
+		}
 
 		if (!prev)
 			goto set_prev_continue;
@@ -3366,15 +3368,18 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	struct damon_target *t;
 	unsigned int nr_regions;
 	unsigned int max_thres;
+	bool count_age = true;
 
 	max_thres = c->attrs.aggr_interval /
 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
 	do {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-			damon_merge_regions_of(t, threshold, sz_limit, c);
+			damon_merge_regions_of(t, threshold, sz_limit, c,
+					count_age);
 			nr_regions += damon_nr_regions(t);
 		}
+		count_age = false;
 		threshold = max(1, threshold * 2);
 	} while (nr_regions > c->attrs.max_nr_regions &&
 			threshold / 2 < max_thres);
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 73cb8fcdf07e..485472ddebd1 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -257,7 +257,7 @@ static void damon_test_merge_regions_of(struct kunit *test)
 		damon_add_region(r, t);
 	}
 
-	damon_merge_regions_of(t, 9, 9999, ctx);
+	damon_merge_regions_of(t, 9, 9999, ctx, true);
 	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
 	for (i = 0; i < 6; i++) {

