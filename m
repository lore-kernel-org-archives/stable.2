Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C091A680B;
	Wed,  9 Sep 2026 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931630; cv=none; b=rMQiDZJILAzFUFYsy/H3H9f3jZOIFA+DcgMFAa7xLZn7qJ9+HmcoPpZR8uIRdI4Pxet6pZtcPoBmcMoOcJmAMjArFelvpDztkikZPnbDdE5bZSjLMGCiJMvZ/s0PfvI/WWcjLu4enXLw/y+YtfDeLMRvYb18+689CI/iWKe86ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931630; c=relaxed/simple;
	bh=mxpYAIqJU62gIW3z9AhRv6JgDEi6ZowNVkkPPI5vGpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACNdkojoELAPKhN6WO62r6sXeTQN4Ula/kDikZIDGwY52V/0KbxA4Llgb32oWA+VieWUWpqVeEPNOECfu6pVD4YPHYsg4hUEop8TcXrSSl6cjLxuilnJasMcBb5XPl3arualSey0p+Mp9+GK8vYnyaRyNDvhIdQRhTGYVqURdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPPlUIYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPPlUIYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34361F00A3A;
	Wed,  9 Sep 2026 05:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788931629;
	bh=WptrNirdhbP3mEMN+HhcAmKhx4WSuBEH9nP59iAD7pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VPPlUIYL4ElTn+jg6HcGJ3yXosZLnoRg3sZLspkH+EJCUTgHiNNvf1xpi1dp/1RnA
	 eQqkQtkBSYWVkHcYkOJfY7NYKqVk3zTj7r7LTwXKM2G/snxbmdbQIxiHfKa93BbFvx
	 Uy4xK5PeubaI6iF3HUqXGydGcdNQLbtVnFp4s0y+bBknySI3tGt/IuO/d/93/nG76X
	 z1iZaIpmhmfWSJeaDPXv3YfcctFzJw+2RgCHTR2prlPGXVyULrGB6nJgj+MSxsP2ti
	 78FMa7Os4vMkhh+9DXEuPNtg+dFbi2ICRHvjpf5hIgcQ7bG7Dtt630wEVBx0fXhY4c
	 ELGo4rpTxW2Zg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/ops-common: use nr_accesses moving sum for quota score
Date: Tue,  8 Sep 2026 22:27:00 -0700
Message-ID: <20260909052700.238595-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090847-penknife-trout-eb12@gregkh>
References: <2026090847-penknife-trout-eb12@gregkh>
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
index 4b5638bbe0614..dea662a6747ce 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -80,8 +80,9 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
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

