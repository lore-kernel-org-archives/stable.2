Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBDD383333;
	Tue,  1 Sep 2026 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268741; cv=none; b=rAL13M/b/fiovYTFCn96nS2yMEKozF8NT3q8OsSz0W9w/HOMoqXvtJAK+AV3L3cw/hWRSNn27u7axfB9hWGG2u2gJ4mOcCjoZMFq4MKKoNmD0ayxPFsH0gnH2mb7lcDLosKYD9QFJUp+0QeAHhi/khZjkHumfrspR0Qg688OPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268741; c=relaxed/simple;
	bh=N1KBGs6KkVkV/x2mLI1/4fnLqUNGtZ17HUviv2uk9kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKoppCvR4apAAFd2O3NmnNqxtpSqDCt9Y0kD1BemJsOn+FGjyArdPO4sERvbLmb/CFoou4fEZwQphnYE6sZY3XBX9uKGzdWb0ZtIn6eRhVrDbrqYJcADNEqmdnHW/312mn5PVugyareE7ok4Pu1HpPNa5A5dLRaSRMbp2uXnd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImCXP+vL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImCXP+vL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BB21F00A3E;
	Tue,  1 Sep 2026 13:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268738;
	bh=GOwz6J3a1XnteJ/KkvbDIvrqBi7xM/5c9ntF246FqLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ImCXP+vLdIt+iBu9YhsGSFkDJzHMPqdAqvr1BGs2r9lzIHNWddp/ldzgzxqepVC7A
	 2LsHoK3DeY3UZppt+5reS8KRckSjTSfrSFZsl3+z3oVIU6HmQfUsERKoNVn00SSqQS
	 thSg0yttFoUN9fDERmEMcsZoKyK8+rTI/JDQ+lCcZc3qL0APgOeBGri9kdng0STkdT
	 e78a61s2obsl2fuCLIfFgHWvU9OhmKQo5k9wK1A4WVn1gPMRhv9upfk+kBSYH3U/ZO
	 3CVedT1y6R8cchECkrprWBo6Tm/MA4EkIbREbDyAoW1JqD3ZBZ6wCEoBwELIcob3Nw
	 IVChnrKHCBBzQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] mm/damon/core: skip applying scheme if region split for quota fails
Date: Tue,  1 Sep 2026 06:18:42 -0700
Message-ID: <20260901131850.98037-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901131850.98037-1-sj@kernel.org>
References: <20260901131850.98037-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_apply_scheme() splits a region and apply the action to the
subregion if it is needed for not violating the quota.  The split
operation (damon_split_region_at()) could fail for allocation failure.
In the case, the quota could be violated.  From the user's perspective,
DAMOS becomes more aggressive than expected under the extreme situation.
Handle the failure.

The user impact is not critical.  The failure of damon_split_region_at()
is unlikely since it is arguably too small to fail.  Also DAMOS being
aggressive is limited to the single region.  Users can set
min_nr_regions to set the maximum size of each region.  If it is
reasonably set, the transient overhead shouldn't be critical.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org

Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3f89cfdf5f022..a6fdb3068262d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2604,7 +2604,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 					c->min_region_sz);
 			if (!sz)
 				goto update_stat;
-			damon_split_region_at(t, r, sz);
+			if (damon_split_region_at(t, r, sz))
+				goto update_stat;
 		}
 		if (damos_core_filter_out(c, t, r, s))
 			return;
-- 
2.47.3
