Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0064B66C2;
	Mon, 21 Sep 2026 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004293; cv=none; b=gDtBjJ1Ytj0SSkaKMHH+kKZHX25OAuGonJ8sAKAZT7POp+wTB8gvnKwyvZCEH2e2MvhLlWLQUYGLzWAz9tvRf8kphwBpGJHn8RR1r0Z4P0oFH6y6hbbNoy1yleOV0TX27lqvgnNV4PpCgMlDHzpr7OuFjoqeUHgPUzcyZ23+qD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004293; c=relaxed/simple;
	bh=BoXoNj7iWXe4GhIAFX6wcc7SgGaQC7uegRD3ZFkwIyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVtD0y1t4JkCd6sfjz1N4UhiZoD17HRZD8kXCWFkqKLO0BI62kUA4NG1WNk1w6b+NwZd7raix2L+q5tA0sPishcllXPPet8gYdrXmt8eBle2s6PeKAH3CQjiBzcBTbHwgASL+2+tyoklnFarrATa2R4pTxYuTiO8VFqipUdzb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYuNaofm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYuNaofm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD611F00893;
	Mon, 21 Sep 2026 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790004291;
	bh=lhYZozQNlJ+OrzQg2fSGExZ1q1RyH+RT/pmgwytGQEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SYuNaofmP9J/SPxw18OqPmlkKyGRAXDtPJwkLz2ge4Zt4g73J1V+L8QQbBE3zxTl1
	 mzN/DcuVT9m2uTdBhhMCTQYbc/oeYG41Qspbm2xjDNfvKbSmNpl3voMqE4Cl3pPSzq
	 HivvICv7TDF/CgK3KyLQMlMj7U0V3JslI+Nb+lHh/qLfXSECHfRWbm0zxwI+BVwlKm
	 PoHGxbQrKVRuvBLyHb2/r8gedFlZAfrBlfodvXLA/s0B/2wZu16UB2dJGtszWXHX9p
	 JV/xiDbGnIjztmy6rl48urDy4DSDr9He/mw6iZAzoR2rrZQWL+J0/Bzdy3Mi5A4Knc
	 mMbiQEXCszn8Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	stable@vger.kernel.org,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/2] mm/damon/core: charge only the part of a region the filter left
Date: Mon, 21 Sep 2026 08:24:41 -0700
Message-ID: <20260921152443.80132-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921152443.80132-1-sj@kernel.org>
References: <20260921152443.80132-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

An address range DAMOS filter that partially overlaps a monitoring
region splits the region at the filter boundary, so the scheme action is
applied to only one side of it.  damos_apply_scheme() reads the region
size once on entry, before damos_core_filter_out() performs that split.

The quota charge and the statistics update therefore account for the
region as it was before the trim.  schemes/<S>/stats/sz_tried counts
memory the filter excluded, which Documentation/mm/damon/design.rst says
is not counted as tried, and with quotas/bytes set the excluded part is
charged against the budget, throttling the scheme to a fraction of what
was configured.

User impact is that DAMOS could unexpectedly slowly run, due to
over-charged quota.  DAMOS stat could also be confusing.  No critical
events such as crashes or leask happen.

Re-read the region size after the core filters have run.

Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos filter")
Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Reviewee-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0aa5d0ea8ebc..4687b909d42c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2784,6 +2784,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		}
 		if (damos_core_filter_out(c, t, r, s))
 			return;
+		sz = damon_sz_region(r);
 		ktime_get_coarse_ts64(&begin);
 		trace_damos_before_apply(cidx, sidx, tidx, r, nr_accesses,
 				damon_nr_regions(t), do_trace);
-- 
2.47.3
