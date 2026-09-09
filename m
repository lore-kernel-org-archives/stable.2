Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F8319871;
	Wed,  9 Sep 2026 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788930330; cv=none; b=Cs27tj3lspmb2uCbTZSywzVfEK+OxsK0PknZ9Yo7SveAAPEjBkVDuboYvHPDK08dGfAkbjkzSo/2/iWOKqZyFTIf/skilP4VidT1pCgocQ+6an8zhRUyj1044OaURrcLYsfmoqnHBbPPnatkeO+4waS3DU2GMy+WT+BvTTAfwMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788930330; c=relaxed/simple;
	bh=2m3RnXggoutYyElQ44Y+SOEfADJnIcP67/KCPmQ69c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HV4HrfCg2NqbSvDJee1DyE+1Ni06QFWqGbOqagA9tglsxfXWWjw792vg/FS6RziRCkHp+GGR/6TqboZfH389AYyYGk6XVr1s/WyQ0mILz+of882URm3jLkODGhJXtK/bPA6OZNfqUBQIwyirjvhz8NXhcGzK9d4ccFDNrVl8y8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLk+orVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLk+orVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20461F00A3A;
	Wed,  9 Sep 2026 05:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788930329;
	bh=VHUvPRGtcMv4bUblSInyXoucW0/pTM/YvtBuq9gWU6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OLk+orVUXnvABUe50CRiMYsR8a0/qU0+FdbLID0TJetBaXqzCb3lBDGc/NJAtiTdF
	 wj3OgaeKBXGunS1u4ML/kblbVDamAUQiHjyw9Fju+fTAws1BijpejcS392jsObj2it
	 RFcXTIw2nT0mhM8ZDbzAcepZFpmmsb/ufyTdBNBywkRjjqTsAbKEvGWUOo7nt8CfZn
	 hmYebxBKUZYY7g+rr3vEJFuXv8ZLbS/sNbIVssUZq/V44+WvzHpO4uicIgb8KHkhrF
	 aiCkcx2me8xVPZWfL+7ubWEhXpgufLf3BS3achULGzU8MsYcP5nIPPOuObDnN3UARC
	 Q4lEGAzHM9VwQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/ops-common: use nr_accesses moving sum for quota score
Date: Tue,  8 Sep 2026 22:05:21 -0700
Message-ID: <20260909050521.225965-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090846-defendant-neglector-22c4@gregkh>
References: <2026090846-defendant-neglector-22c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 42f994b71404 ("mm/damon/core: implement scheme-specific apply
interval"), DAMOS scheme can be applied at any time.  At that time,
nr_accesses may not be fully aggregated.  But the quota prioritization
score is calculated using the not fully aggregated count.  As a result,
the performance of DAMOS could be degraded.  Fix by using
damon_nr_accesses_mvsum() instead.

The user impact of the issue is suboptimum DAMOS performance under certain
setups.  Nonetheless, the bug was there from the beginning of the setup
availability.  In other words, the suboptimum performance is the baseline
of the setup and hence it didn't cause regression.  Also the extent of the
suboptimality was not big enough to be found from users and testers.
Still, this is a clear bug that is better to be fixed, and can be easily
fixed.

Link: https://lore.kernel.org/20260719161136.90191-1-sj@kernel.org
Fixes: 42f994b71404 ("mm/damon/core: implement scheme-specific apply interval")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.7.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 6c25083f7ae7e2660d766169e5b4d3e96010503f)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index ceaa2a6e1c9a3..929aab600c745 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -101,8 +101,9 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	unsigned int age_weight = s->quota.weight_age;
 	int hotness;
 
-	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
-		damon_max_nr_accesses(&c->attrs);
+	freq_subscore = mult_frac(r->nr_accesses_bp / 10000,
+			DAMON_MAX_SUBSCORE,
+			damon_max_nr_accesses(&c->attrs));
 
 	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
 	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
-- 
2.47.3

