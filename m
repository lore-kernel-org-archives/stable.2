Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAB2931FE;
	Wed,  9 Sep 2026 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788930482; cv=none; b=R39+DizK5CeEgLejRaoQrGVPsiuy7mv3LBNLyvXc99U/oEl+k68EoL/WbhVknofLNK/bVWCEgZR52uz0rW71wHaV6TID0WJgEa4pyJ0iVjpv7kxPjydGFUuCFeXFD9kvEr3Gl78cbhaFIzIZwPRt7d4SzpA58/5deI+9enmJU4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788930482; c=relaxed/simple;
	bh=yxyCtlXZryrpANBaTXHTQ7JagPYx9B118GCuMkERp/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s17pA/TZsK+boCokv/osh/ho0QjBRbHH1f/v/4TxsOu73X7UKKuC61VFxuUNqSK26zWl7x9xz6pLjgPtFZnmrfoU4QUz3HxyfAZQCAGljAmrNsdAaaG+wT1g1e6kHNt8Reqv3tkXezt7hD2OqNnVtRk237I88UBCBqrip/t7Zxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJEmE1Bo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJEmE1Bo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87471F00A3A;
	Wed,  9 Sep 2026 05:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788930480;
	bh=seXS5XTS+FPlWs6Hrjlu5q9H7f9qaWnrbuwB3zY33Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JJEmE1Bo0GTSzcE+r1bK4jkE/VF84XZ3LVu2Abs8HZf/4RrWiOqj3/YqiYstNV1Ik
	 lEWkU9PcfOnFxVP0vUzIKbIWqkVnpSyOcAr8OCLgwiRkb2Hck53Fgwnrp7aqCAfvbB
	 lK5M4gk/3DVd19/r2g/v0lsrrvHakJ5x/UEmdK6uC+ZZ9hEHatLGwS2OLxtPLDDB+3
	 SDAGk+17JGktPB8o6lxWK1JGIoJpeP0dFT1LEuI55+zNSuYwyuKVbBEPsdrPd7VFzg
	 JLacEO6BTQk+OLsJa2s9moUdD+xekLggy768ooDNXnFUTf0EHih+2GNj+chEXr/B+v
	 SzMeAcc0kbTww==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.2.y] mm/damon/ops-common: use nr_accesses moving sum for quota score
Date: Tue,  8 Sep 2026 22:07:53 -0700
Message-ID: <20260909050753.232078-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090846-diffusive-headfirst-c45d@gregkh>
References: <2026090846-diffusive-headfirst-c45d@gregkh>
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
index 0bcad6b1e5b9e..6a969b1d29871 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -111,8 +111,9 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	unsigned int age_weight = s->quota.weight_age;
 	int hotness;
 
-	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
-		damon_max_nr_accesses(&c->attrs);
+	freq_subscore = mult_frac(r->nr_accesses_bp / 10000,
+			DAMON_MAX_SUBSCORE,
+			damon_max_nr_accesses(&c->attrs));
 
 	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
 	if (age_in_sec)
-- 
2.47.3

