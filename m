Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0B235C681;
	Thu, 30 Jul 2026 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373930; cv=none; b=fcbqWXEwp1t/8/WjlAC+/bJxcIC/DD5dTz7m4X/UL93qST037BzvOvCT+E2R+hyD+AGrMvtSS++hYffKEwJoT5JjoqG+zNde624Gxe1uwhfvcnxLIhDn8KVCmPfGkb3qsRoYkkI3wx0XTE69ZXD+93JvHtOwVcDxgGrG4I41Pko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373930; c=relaxed/simple;
	bh=CtIisfV0Xd0I5iJ7TqgGfvWeV7QFkO+HLXmCtURlhhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrwYZSKP5GPBAyvhk7fM12YKOppVtYRs6w0X2EmNsgTPjDlCYAZCKTT0Cv85tYVQGS+pgzjCZf5BUuFIcKasxcbohCSlWAB9P2//nNg1mn5cVl7jnRyDw00dZJscBNaBkYsDR5nsaSnBnEUjJ1uEgequGZU1icA3jKgb7BlDF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enzKlCpd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enzKlCpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44FC1F000E9;
	Thu, 30 Jul 2026 01:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373929;
	bh=W6tByQazD2EeJM7AL/pW06OaVofqPGOXjAx9BLHwdto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=enzKlCpdksKmyRypt8e4JiwukskxfRU0ZgyZzFoqxdxOrXTFidLRvk0OiIfffYpNM
	 cP/H7eOGkXuzUiERd7JH+FJbi3A1a6s0kTTZZQuzQeoqrCHOe9ImGBHlRW66xTR00N
	 eF5cBJDyhItt99HXNGbJKuP+kY9ez7rqXfq9unNGz/r3XUQfkPCmsD1ZqTY3AFb48J
	 S9UjExAkZneLyHqDm0LS0M9X1cZnm6q/rAC540xmp03+FVcynuzL0Hnd3SgX24xDuQ
	 z/SAt+8PYzt3RmHlj2SBpa21ZUBFlQ4BdrnRHeYK1dfKiEVr5xxRS6RmReMoyLETyy
	 54Z5r3eaop21g==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/core: disallow overlapping input ranges for damon_set_regions()
Date: Wed, 29 Jul 2026 18:11:59 -0700
Message-ID: <20260730011201.125884-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072944-viability-rectangle-c5a5@gregkh>
References: <2026072944-viability-rectangle-c5a5@gregkh>
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
https://lore.kernel.org/20260730005639.108842-1-sj@kernel.org

 mm/damon/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7217bb2ef51ec..71264018cf2d1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -212,12 +212,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
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

