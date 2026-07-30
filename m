Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58DF34A799;
	Thu, 30 Jul 2026 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374469; cv=none; b=AiygoZqecKsHgDjXLK/7nhQT5VZhUw7R7BFUw/jBV1t4ZZ30t/xDvbW8P5xpQa65R/3wfbKpj9j/DYEBvA/Bngb29tsfXZDoaNJq38fnWlzFbCU63tn7hhajBBuyoXFiDAu4kkrXy74Ii44e9LkitnmIo6rw1hLXzNtTHeF3d4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374469; c=relaxed/simple;
	bh=W8LAUQTKhzQlwMERF3J+9WW7bpnCbuCBBkt7eaqhAJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sE/7PkqxKhZRWBBmr3/odPQnYzc/s+FNrN7a3i8T5i0+RhraL1PFw/O1OCTOnXwfmdBkdLyLhev0gorpRp3LnTo9WVctDJtoq+vsz57bJ8enmnm71NZTsrmr8FYkUY+txzhcUVpHzaXBV/7C/BUpQjn1KrF83aBT7+2LnJ1MdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1y/25vn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1y/25vn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2961F000E9;
	Thu, 30 Jul 2026 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785374467;
	bh=ZLjUXHvRJ7nDT2d1jnTK/WbFQsOhu3hY2whoDJ5YrZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R1y/25vnoTCVqWMRXauDUI0wXaiYNs/APa8KJcqazrLZbOLlSpIiGK9bWPKSfWOXf
	 g659WZetfWGql1wUBua5ZSVBaVE1L2jrZz5z8JqmMArz6KFhOjN7oBAqp7YSRyY66r
	 Sy7/UU5alRTibeeTLAm1aVg/mT8bWXw5SiOjNe6hW0WWeiQZIKZPyOIINwTK1nOE5P
	 NqwEtmYBHSQ7hIOCeiPihdIqdYa1/MtXnA+8iftdpCk7pccqcGjKZBC+o4blEOTyMb
	 ca7gx906ci/mr15dbRuiRCSuGnArgWHDQByjZeOmWDAfRmAy7aq5fZsocSwOYM3ScS
	 PotGtnbgE0nmw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/core: disallow overlapping input ranges for damon_set_regions()
Date: Wed, 29 Jul 2026 18:20:58 -0700
Message-ID: <20260730012100.139829-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072945-freezable-opossum-1bd2@gregkh>
References: <2026072945-freezable-opossum-1bd2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_regions() assumes the input ranges are sorted by the address and
don't overlap each other.  Hence the assumption was initially to be
explicitly validated.  But commit 97d482f4592f ("mm/damon/sysfs: reuse
damon_set_regions() for regions setting") has mistakenly removed the
validation.

This can make DAMON behave in unexpected ways.  At the best, the
monitoring results snapshot will just look weird since there will be
overlapping regions.  DAMOS will also work weirdly, applying the same
action multiple times for overlapping regions, and make DAMOS quota weird.
More seriously, depending on the setup and regions updates sequence,
negative size regions can be made.  It will trigger WARN_ONCE() if the
kernel is built with CONFIG_DAMON_DEBUG_SANITY=y.  Depending on the
monitoring results, the negative size region can further trigger division
by zero in damon_merge_two_regions().

Note that some of the consequences including the WARN_ONCE() and the
divide by zero depend on commits that were introduced after the root cause
commit 97d482f4592f ("mm/damon/sysfs: reuse damon_set_regions() for
regions setting").

Fix the problems by checking the assumption and returning an error if
the input ranges don't meet the assumption.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260703165610.92894-1-sj@kernel.org
Link: https://lore.kernel.org/20260630041806.151124-1-sj@kernel.org [1]
Fixes: 97d482f4592f ("mm/damon/sysfs: reuse damon_set_regions() for regions setting")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 954157679ec34661c2e87e7eb796104a797c32db)
Signed-off-by: SJ Park <sj@kernel.org>
---
NOTE: This should be applied after
https://lore.kernel.org/20260730010151.119009-1-sj@kernel.org

 mm/damon/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0a0bb033f28a4..dd4eafe8b9611 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -210,12 +210,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 {
 	struct damon_region *r, *next;
 	unsigned int i;
+	unsigned long last_end;
 	int err;
 
 	for (i = 0; i < nr_ranges; i++) {
-		if (ALIGN_DOWN(ranges[i].start, DAMON_MIN_REGION) >=
-				ALIGN(ranges[i].end, DAMON_MIN_REGION))
+		unsigned long start, end;
+
+		start = ALIGN_DOWN(ranges[i].start, DAMON_MIN_REGION);
+		end = ALIGN(ranges[i].end, DAMON_MIN_REGION);
+		if (start >= end)
+			return -EINVAL;
+		if (i > 0 && last_end > start)
 			return -EINVAL;
+		last_end = end;
 	}
 
 	/* Remove regions which are not in the new ranges */
-- 
2.47.3

