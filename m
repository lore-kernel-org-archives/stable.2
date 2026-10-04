Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90B35E92F;
	Sun,  4 Oct 2026 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791127057; cv=none; b=e9mNU3L++85ouOOxBuSUHBPOmAkuG8SnTycxHYfakRY5XQydgY75+xndcEz+wSmEhJtVqqRyX7o3fCvMwQbROQkSuhGNHcRTqi1is7cLVyErjZ9J3vOautJcqHvG+bPF11ur+JxLq/mWIMpxygEICvkNykDZsuhXB40tpIBaq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791127057; c=relaxed/simple;
	bh=eSF+NOK5225FF8mqqhAd8WISwcF2aNfvQx+lMIgmWqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TB4LY83K93Enh/YvFjV0/HEyGkhRjIxURsXXTjaUCl2wQofc91Z8TTvVrqAvzWjIOM17oyp8eglbxLF7tAKowJgPLtLwjMK7usieaG7n48LDIKvzHzujAzVZ3H0P3kxkxdTmf/k1JaymDXQzyNE3BJscxwOQj0jg4aPZvrD+vuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLht/tM5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLht/tM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489E01F000FF;
	Sun,  4 Oct 2026 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791127056;
	bh=XJAU8G4m6+mnNoBD5LhT4HZg8a5iTfwqXPkHr6mnUKY=;
	h=From:To:Cc:Subject:Date;
	b=RLht/tM5VZunK3yjbI68m9adxOl7g1umF+5+dLSoeMTpphzBWz4pSL44WjtHO6Aij
	 P48Cd5QuYPKny0jeE6OijzrdaSlGSiVj44mmRrNYIgecknRsMaHJuc9HYZEpC4f9ue
	 1p64Ts0DqZh33NlbjlaH4G7DeWeeYK/0RcTM/BHccnv0BHUVP1kd4HO4OoPcwdZUwQ
	 K3/yR2g25EJTMjtf/6/X51NcYw3khqO1vc6+d3tWKR4xmh9tUA2u2ljXNxlHyk+kwD
	 l1sjC8CCj9zerqr3oZVvhP+T+jbYlVxDnBbJcdwRIuwL3ti+1DajdbGjpsl4TUqyAR
	 Q/ZH5Z8QNpakA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y v2] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Sun,  4 Oct 2026 08:17:30 -0700
Message-ID: <20261004151730.4700-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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
This patch is required to fix a bug that is introduced by commit
500c9259f5a6, which is a backport of upstream commit b3723b596b54
("mm/damon/core: fix unconditionally skip last region").  The backport
allowed trying damon_split_region_at() of last region in
damon_skip_charged_region().  If damon_split_region() fails, following
line in damon_skip_charged_region() assigns wrong region pointer to the
variable 'r', and propagate that via 'rp' double pointer.  As a result,
silent memory corruption can happen.  damon_split_region_at() will fail
only under extremem memory pressure, but still theoretically could
happen.  This backport fix it by removing the damon_next_region() call.

Changes from v1
- v1: https://lore.kernel.org/20261003163101.32739-1-sj@kernel.org
- Fix wrong return skipping cleanup in damos_skip_charge_region()

 mm/damon/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c0dcb190b06e..02cc99aa6d3e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1734,16 +1734,18 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
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
-		struct damon_region **rp, struct damos *s, unsigned long min_sz_region)
+		struct damon_region *r, struct damos *s,
+		unsigned long min_sz_region)
 {
-	struct damon_region *r = *rp;
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz_to_skip;
 	bool skip = false;
@@ -1770,9 +1772,7 @@ static bool damos_skip_charged_region(struct damon_target *t,
 				sz_to_skip = min_sz_region;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
-			r = damon_next_region(r);
-			*rp = r;
-			skip = false;
+			skip = true;
 		}
 	}
 out:
@@ -2034,7 +2034,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
 
-		if (damos_skip_charged_region(t, &r, s, c->min_sz_region))
+		if (damos_skip_charged_region(t, r, s, c->min_sz_region))
 			continue;
 
 		if (!damos_valid_target(c, t, r, s))
@@ -2306,7 +2306,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r, *next_r;
+	struct damon_region *r;
 	struct damos *s;
 	unsigned long sample_interval = c->attrs.sample_interval ?
 		c->attrs.sample_interval : 1;
@@ -2329,7 +2329,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 
 	mutex_lock(&c->walk_control_lock);
 	damon_for_each_target(t, c) {
-		damon_for_each_region_safe(r, next_r, t)
+		damon_for_each_region(r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
 
-- 
2.47.3

