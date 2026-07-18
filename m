Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE029405;
	Sat, 18 Jul 2026 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784335393; cv=none; b=TmpohnV2/6eygscpBpuUPGDBMrHOWCEEUoqSoOCIixLGwuYbwMZrsJmkmx0hISEf+fCxlKZdX7Alq2JdvHsrrlu76gM+NM5hkI2yH2/cMCExguLtBGaVbW7TxLnm1bmXdL7aph6RaRO++OyuGcXrN7spRkdmxcTK6eJJeHsWX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784335393; c=relaxed/simple;
	bh=/bM+po3ltjAp5exvu2FapoZbfPSs/9VbDd2hiTZmDJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4P8EjPFDsaB6zRJriWPwx+WC5jKKTzgnCbS0QFUjV5GiGDKO+GTkoGCIGWTbnEU+I5haGgYGSSToa8wmwJ+kfKW3YgvNxX3da4fBdbZL9tRF+O3nI90wCtZwZnWf9v5NbhMsMvBxK0bxYjGhLi5FH3Kfo66bginnK8WQkQqdfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvkM1VId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvkM1VId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DDE1F000E9;
	Sat, 18 Jul 2026 00:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784335391;
	bh=JS3w3XL9lBOxCrsYXuWXGjRlToz81TO5Buc7T8lNzzk=;
	h=From:To:Cc:Subject:Date;
	b=LvkM1VIdulJi2+c+0scwEAUmj2pqW8aoeUDmMZEPZU6ZKsZCJHFa4bbEyM+qbUms0
	 6Dd3JxDWSukUnEKWo4BPk5ZymTF5LYoW4IjSBplN/MjPyiEO2qmnDCbIqH848Ho4Cz
	 DFfMjm5KndnKGGpGz0lrF0vVqwHpxi3f1AXNV5DMwf7H06+N/rCNhB0DEwn0Jn5cMr
	 tfjVMIOmfJdaHESnfbA/GhVfSvgJ63d5/XWHN2UY58e8l6luLK2ypsdA+0neZrNi/h
	 yaIk1NCyASQchdyFYIA47jp/0Aodsfzk0+W6H69hTFeGcSxITri7xGLARQwrbnTUpG
	 2yxTbeiHOm2Dg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/core: handle region split failure in apply_min_nr_regions()
Date: Fri, 17 Jul 2026 17:43:00 -0700
Message-ID: <20260718004301.88883-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_apply_min_nr_regions() repeatedly split each region until its size
becomes small enough to meet the user-defined low limit of the number of
regions.  The loop assumes the split operation (damon_split_region_at())
will always succeed and create the new region.  But the operation could
silently fail for memory allocation failures, for example.  If such
failure happens and the region was the last region, the linked
list-based next region fetching returns invalid pointer.  As a result,
invalid memory dereference and corruption could happen.  Fix by breaking
the loop in the corner case.

The allocation failure is unlikely since it is arguably too small to
fail.  But, it could still theoretically happen, and the consequence is
very bad.

This issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260717011834.120715-1-sj@kernel.org

Fixes: b1029f29eb1d ("mm/damon/core: split regions for min_nr_regions")
Cc: <stable@vger.kernel.org> # 7.1.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 603b102ff80f9..ce79918400cde 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1912,6 +1912,9 @@ static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
 		damon_for_each_region_safe(r, next, t) {
 			while (damon_sz_region(r) > max_region_sz) {
 				damon_split_region_at(t, r, max_region_sz);
+				/* split might failed */
+				if (r == damon_last_region(t))
+					break;
 				r = damon_next_region(r);
 			}
 		}

base-commit: 47263730d8de68a42ac020f8fcb9044f8c86e1b6
-- 
2.47.3
