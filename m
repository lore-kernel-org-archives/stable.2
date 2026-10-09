Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7D4DE71D;
	Fri,  9 Oct 2026 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553806; cv=none; b=N2DpECeyaLal+M4QCodUM1RWdQd/oR3+iAyMsz3FKPp/d+C99zsq5iqYeeMkM6bTDqJMzfXy/NPUgv+iaKecl+UnCnOhxmKp3EjlN4aI3StJrp2Uyg3voXbOMUkftU4qxV4fUZAF/v0acdVQieUP7R/IlPpdcfd94YBYiwMLQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553806; c=relaxed/simple;
	bh=UdB0ZDdzx7QsiC+l2+S+4b1iv4hhDjhMBBRHvM+1d1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8Nh2JnAZIOvqHWWXB1sAFuA3FfWVyZY6mLoxWTCJbv+qB7ISgI0cxWTtvv82b9rZRfM8we3eCVWh5YUqnLYksBSxaGOPU/fKUv9o81MDpkammisI0OGDoSD9Bb0gymDmDEZdCzghah2cxeLnST3RXWBrsYMqZnmsk6TDnTd4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idEqz+PT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idEqz+PT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC9F1F00893;
	Fri,  9 Oct 2026 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791553804;
	bh=BvoaN2WowxsRE7K+3VcTpzbAyQjGWsLbE5vPj3uvImw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=idEqz+PTh3o4YFh33xybLTkBPxha8umZ33l48sRfAN04sktAgU2LJDqKHnXMYRi1f
	 IIbml+KWNQIQjrc/LA8nd3XDx0trVFs8viE2VRzVerLAQFlmU43WMHX02xIh9B186T
	 vVUv09XNJXZm4F1qnK1pm7NW2Sl+XgMC6yzRMZNpSXc2NcjEgyhdu9dMGOlPBGUE8q
	 Ttk03fI8jNRcEe3LWpEfGsaBisTUHwC5BrdnVPi0nz7oswQnp3KsHd2iLFkHjrVt8I
	 Q+kdHQD17/hjxpnsfBIgCh7zGz/YgGmj6Y57mO7qm6ZEHRlbZpAUhOPz0sjLNxFyFV
	 jr0EBV8h4bSRA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.6.y v3 1/2] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Fri,  9 Oct 2026 06:49:48 -0700
Message-ID: <20261009134949.11507-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009134949.11507-1-sj@kernel.org>
References: <2026092948-moonrise-persecute-3597@gregkh>
 <20261009134949.11507-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

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
(cherry picked from commit 1745ccbd2907db2bdaa843e4abccde4fdaccbe5d)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index fe91b296f4c6..c86cac855b9b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -871,16 +871,17 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
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
+		struct damon_region *r, struct damos *s)
 {
-	struct damon_region *r = *rp;
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz_to_skip;
 
@@ -907,8 +908,7 @@ static bool damos_skip_charged_region(struct damon_target *t,
 				sz_to_skip = DAMON_MIN_REGION;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
-			r = damon_next_region(r);
-			*rp = r;
+			return true;
 		}
 		quota->charge_target_from = NULL;
 		quota->charge_addr_from = 0;
@@ -1045,7 +1045,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
 
-		if (damos_skip_charged_region(t, &r, s))
+		if (damos_skip_charged_region(t, r, s))
 			continue;
 
 		if (!damos_valid_target(c, t, r, s))
@@ -1134,7 +1134,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r, *next_r;
+	struct damon_region *r;
 	struct damos *s;
 	unsigned long sample_interval = c->attrs.sample_interval ?
 		c->attrs.sample_interval : 1;
@@ -1156,7 +1156,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		return;
 
 	damon_for_each_target(t, c) {
-		damon_for_each_region_safe(r, next_r, t)
+		damon_for_each_region(r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
 
-- 
2.47.3
