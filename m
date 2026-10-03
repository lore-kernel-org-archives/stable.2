Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799042F7F00;
	Sat,  3 Oct 2026 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791045076; cv=none; b=b8Hn9Af9H/+5R6UIm1Qfnt9IKAaAzNE+oHL3OZFh1URoVG5svjVBtu4EUaKGr1LfC7hHd/bnIT0h5SZMNmHbcbzN8FpKptaJc1NJzjrrywEgvCn4/L0Dl2nvpT16tlVZUG/N+F1RvxbxmWOUu6TpRIj/N8sFhmGfWnvCgM430c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791045076; c=relaxed/simple;
	bh=1mHeVxmwHBsMgp/RMF8YO4d6tyjH7sytbYkmU57Cw4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZxF7mwS0/Ze9e1f6hCNGqq+v/Ct2LnzN23ch/j2igEOTkDcM1LEvyt3bVR8fShbfUdJGFvHsGssB5HKvBWYn0iDVX7CTxYP4oC5BYEcueXAgmk5zsMHmrZhyAbD2mq/hmHIhAgFP98ZUXPN0vFmKRk+fHLHetFknkm6JVts7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6PTMKnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6PTMKnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3707B1F0089B;
	Sat,  3 Oct 2026 16:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791045075;
	bh=XCyny3B2srnav2sb5q6ky6z5bzDB3U7gyMRKfr4JYoo=;
	h=From:To:Cc:Subject:Date;
	b=l6PTMKncN2AdK3qmyObuV56RS0qZ++31spD8WofI+q7yNQtMsc6IWF1VR28dCKTAd
	 oXesbMPTu77/SOuv4TK6o2Q72Ypu1aMeJ3nuKa11J2vDlg57sb9UbyE+f4h1xTG2eu
	 nYlpjysDdNHMNKePPLD2fWQYb9JoR7KSxZLRDSyeq/s0HjsMSo8BqCwOmyF875la60
	 qHpidLofufxi1w+mfd2XBnxd/egnlXOaJQvydJvvws/FE1J4sycJTfWFFVQXxBexIK
	 9hqPzanLO2qfU9QcuAVeEVlCaOH7XWtX4n2T3H4ZR+kgrrdDBy2phGQlQrAaD35V3/
	 oeiw35sST1KDQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Sat,  3 Oct 2026 09:31:00 -0700
Message-ID: <20261003163101.32739-1-sj@kernel.org>
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

 mm/damon/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c0dcb190b06e..8217815de898 100644
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
+			return true;
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

