Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA62F8EAE
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766850; cv=none; b=ZvhRbFHmUpQ6gbRwd0pi1r6oZKXIeztnEtMaoG0TIuLQEfkaGNZXbO24BRQi6sHXmiOR0XJts7pDWIqBViMTcP5T3kuR2wbl9ZkvKPqRmVmvHk0lp1KV7Dw52ApPI3NIm1oARfU4viRHCvtYf9rMgNboBa5YXJFd73RazriNJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766850; c=relaxed/simple;
	bh=Y6Ep3gxOkxrpvzJydzvjQqmVuRjHlodpo9LY3KTQjjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRJBaR1n0uHMroJYS+Rh+ob+A1plMd33RBy0JuSGJm2DGNrUosHW5Hzb1uV03q7bUGcKSE8hklIX566iDCfsYWO0vWaoDdMQp94zIn7rHhm338dqzPUMBQnpI8nuh/4PtPXYtRbnseHtmg6E0Kq67q4dMDBTRyT9S1jr/OUvTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g815RFQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g815RFQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A381F00898;
	Wed, 30 Sep 2026 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766849;
	bh=+SvD8vsLp2wRWr6/2omv27pZ+iQKrYQ5ekeWvQW+dXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g815RFQCQHBV7HU5nML1ezwmWidDDQvRs7NqZtpExXlIRZ5wzPwpQHGTXpjr8Ol5G
	 K5MP9AbKW0hkI6S6yesoOJgI0EKOyKD1FNkuS0bOS78GMY7bg2PNQSpzy8YQYTM57H
	 znth6ePYY+wiPrXs7fu751Qd91MI2u0nDOdwSq7pFmjj5kQ4lz7Mo4EUlmWHtRM/wt
	 zUPeEpSyME0mx875wUqWVYlPQVIUrhWBcRSaVPowqR+YY9jNp+JVdfc39NwERp53ce
	 PQSK9elHvIhA3wwUD6J3+NLnLHEB/cPZutYsaQ2/PbBbPAP63v8tk5qV4kkBnuXUbF
	 Uu7jPlWfWCdCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Wed, 30 Sep 2026 07:14:05 -0400
Message-ID: <20260930111406.1206660-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111406.1206660-1-sashal@kernel.org>
References: <2026092948-moonrise-persecute-3597@gregkh>
 <20260930111406.1206660-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit 1745ccbd2907db2bdaa843e4abccde4fdaccbe5d ]

kdamond_apply_schemes() is using damon_for_each_region_safe(), which is
safe for deallocation of the region inside the loop.  However, the loop
internal logic does not deallocate regions.  Hence it is only wasting the
next pointer.  Also, it causes a problem.

When an address filter is applied, and there is a region that intersects
with the filter, the filter splits the region on the filter boundary.  The
intention is to let DAMOS apply action to only filtered-in address ranges.
However, it is using damon_for_each_region_safe(), which sets the next
region before the execution of the iteration.  Hence, the region that
split and now will be next to the previous region, is simply ignored.  As
a result, DAMOS applies the action to target regions bit slower than
expected, when the address filter is used.  Shouldn't be a big problem but
definitely better to be fixed.  damos_skip_charged_region() was working
around the issue using a double pointer hack.

Use damon_for_each_region(), which is safe for this use case.  And drop
the work around in damos_skip_charged_region().

Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[Stable backport: retain the min_region_sz argument of the existing
quota-skip helper and pass DAMON_MIN_REGION, since this tree has no
per-context minimum region size.  Use that argument for the helper's
alignment and split checks, preserving the stable minimum (including the
KUnit override) while matching the context required by b3723b596b54.
Update the helper's parameter documentation for the single region pointer.
No functions or context fields are added.]

Stable-dep-of: b3723b596b54 ("mm/damon/core: fix unconditionally skip last region")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/core.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2990367d849eb..d2ebfb6e34e3d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -859,8 +859,9 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
  * damos_skip_charged_region() - Check if the given region or starting part of
  * it is already charged for the DAMOS quota.
  * @t:	The target of the region.
- * @rp:	The pointer to the region.
+ * @r:	The region.
  * @s:	The scheme to be applied.
+ * @min_region_sz:	Minimum region size.
  *
  * If a quota of a scheme has exceeded in a quota charge window, the scheme's
  * action would applied to only a part of the target access pattern fulfilling
@@ -871,16 +872,18 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
  * This function checks if a given region should be skipped or not for the
  * reason.  If only the starting part of the region has previously charged,
  * this function splits the region into two so that the second one covers the
- * area that not charged in the previous charge widnow and saves the second
- * region in *rp and returns false, so that the caller can apply DAMON action
- * to the second one.
+ * area that not charged in the previous charge widnow, and return true.  The
+ * caller can see the second one on the next iteration of the region walk.
+ * Note that this means the caller should use damon_for_each_region() instead
+ * of damon_for_each_region_safe().  If damon_for_each_region_safe() is used,
+ * the second region will just be ignored.
  *
- * Return: true if the region should be entirely skipped, false otherwise.
+ * Return: true if the region should be skipped, false otherwise.
  */
 static bool damos_skip_charged_region(struct damon_target *t,
-		struct damon_region **rp, struct damos *s)
+		struct damon_region *r, struct damos *s,
+		unsigned long min_region_sz)
 {
-	struct damon_region *r = *rp;
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz_to_skip;
 
@@ -900,15 +903,14 @@ static bool damos_skip_charged_region(struct damon_target *t,
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
 			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
-					r->ar.start, DAMON_MIN_REGION);
+					r->ar.start, min_region_sz);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= DAMON_MIN_REGION)
+				if (damon_sz_region(r) <= min_region_sz)
 					return true;
-				sz_to_skip = DAMON_MIN_REGION;
+				sz_to_skip = min_region_sz;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
-			r = damon_next_region(r);
-			*rp = r;
+			return true;
 		}
 		quota->charge_target_from = NULL;
 		quota->charge_addr_from = 0;
@@ -1045,7 +1047,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
 
-		if (damos_skip_charged_region(t, &r, s))
+		if (damos_skip_charged_region(t, r, s, DAMON_MIN_REGION))
 			continue;
 
 		if (!damos_valid_target(c, t, r, s))
@@ -1134,7 +1136,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r, *next_r;
+	struct damon_region *r;
 	struct damos *s;
 	unsigned long sample_interval = c->attrs.sample_interval ?
 		c->attrs.sample_interval : 1;
@@ -1159,7 +1161,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		if (c->ops.target_valid && c->ops.target_valid(t) == false)
 			continue;
 
-		damon_for_each_region_safe(r, next_r, t)
+		damon_for_each_region(r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
 
-- 
2.53.0

