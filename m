Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD62EBBAF;
	Fri,  9 Oct 2026 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557302; cv=none; b=oSsuSkyA3iNEqUQ7L3TroPSbc+Qd8AALL/XaELYJFjSij3yLW+JEn2N8Y9jQOTmRhI8LNThO0J6+ysCNC9y8rVS5B3INh1Z0vzYa9qT0KPtM8KppWhP8ezkTLEtVp9Xr13HpMPlTxYlW6fv2vB3no18TM0ccX+OwQK5vyozxCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557302; c=relaxed/simple;
	bh=t+vWU1bGqMnH33cFkKpvUv9qyvY9Q8PAtqOYxHCygww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbWo5S3oImXIDwXSjxJcwFIgmwWTG7jGs0QyLvNGUSTw0e5DkrOXjkKTsqgY+NxPw1kaNTVrVO73c+VgX1JQqtokkapkGUUVoAFfkbVxQVvZTZ3AghCTwfsJ+rGefBDYpClP+bPsHelzK0MyqWIQoQ3AgrC0HsYcL62YGiJTylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I45jDs8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I45jDs8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478A71F00898;
	Fri,  9 Oct 2026 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791557301;
	bh=8/6BMd6YHWfD43iTNLmfCL9vbVOX4eDCpfrdP6izaRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I45jDs8cFF5+8RTsODCHZCwmhYfs4bKmISxNdL6WziY5JrFmA/j8Pt2ZHmVC93bxB
	 95T9obtEyddAO3mj7NILoeHPnBPOABjRTakBZL0+VT7aAYisP38SG/vn+GEpBKP74i
	 3MjzjPCKMO79+AiFYGTyqxLHhPq3Qjpjnn2O1zyXJenfnsHUz3huVInTtoEu2TntXi
	 qwvjO0UEvQ1F2KLbWA+e48DY8VnKXpcC2gWcl+PI3fxScDabef/NlTWg0sMNNmu76f
	 zzf3lw2APA1l+kNf68PiPOoxgemWjgxUdXaMmzb+KeFSF336NcyjuMdz1CnvePJnE2
	 LRrCrGBrwNHaA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y v2 1/2] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Fri,  9 Oct 2026 07:48:07 -0700
Message-ID: <20261009144808.18317-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009144808.18317-1-sj@kernel.org>
References: <2026092949-surpass-thimble-02a8@gregkh>
 <20261009144808.18317-1-sj@kernel.org>
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
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7afbc20833ea..c65d2cbeea6b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -858,7 +858,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r, *next_r;
+	struct damon_region *r;
 	struct damos *s;
 
 	damon_for_each_scheme(s, c) {
@@ -912,7 +912,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	}
 
 	damon_for_each_target(t, c) {
-		damon_for_each_region_safe(r, next_r, t)
+		damon_for_each_region(r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
 }
-- 
2.47.3
