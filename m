Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B124022B8AB;
	Fri,  3 Jul 2026 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097780; cv=none; b=jaiKcnmQ6sBjBGkWk81xKZKCP2SIrqZUJiQmHAfiDM6YGziXq6hhwHBiWE+RTbYoN5Rd+ZsyT+X8R7PDafJYXNXvOQexZlx3Q75/UBmxiRWiu2BiTxPVo3KonYsfN8StYPFUfk6fLxFX+mvFf4Rsp9ZWKuRX8lV2giOqu35+3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097780; c=relaxed/simple;
	bh=iW7+hYgs75f54/dTRx/A4bPMyBKMlxVhQ+fI6EZLwGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKU9SLaDyWhTwrtGbAf8WW7v57U1JKYZ3alx0Vx40blp+fZzJoS+2nO6D1va/TtNSYawzVubmsal5ZiH/TbkGwBN9lMjmrTtz4TMnRAFk63zxnEAWeeL9MpUHB3kQY9QVBFRRFyVU3JbMBfAGz494hDznfhgbun+bynAd54D0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvhY5qHn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvhY5qHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1131F000E9;
	Fri,  3 Jul 2026 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783097779;
	bh=d8Fu0LoPjMdgfenH4nsnTkiBTDtpH+E6tfmdEIE/iDI=;
	h=From:To:Cc:Subject:Date;
	b=DvhY5qHnFGn2Dni7hV6Z6DToBHEQ4RtbpWP13BQ1U+IJOykwuBw7AdajTzI0l+UUb
	 oVykTxPjHdTjMwgax1sNUoGgNU47w4Id/dTWMFaQLl40+naxIuBxrsvvREKiUPBJY+
	 y9UX3d4y7WM7QYahilmTc/nLZAau3lOqEyTzVmhP+sWwREnY9ad5rTyshJT3rPhWOx
	 w9SnrBeq+mYy0TOYv34Jmz44cKLP3FAf/xwZMO4enfLgnKZ4zHRwr52FHse2tBZ1K+
	 SxakAADI6IWOAmRD6SSNXdUIHsmXLJe3Ax0VW5OKmibwPmZQ9m3R3zeNP+/pZpI9Ip
	 3U7kn2biOOcqg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: disallow overlapping input ranges for damon_set_regions()
Date: Fri,  3 Jul 2026 09:56:08 -0700
Message-ID: <20260703165610.92894-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_regions() assumes the input ranges are sorted by the address
and don't overlap each other.  Hence the assumption was initially to be
explicitly validated.  But commit 97d482f4592f ("mm/damon/sysfs: reuse
damon_set_regions() for regions setting") has mistakenly removed the
validation.

This can make DAMON behave in unexpected ways.  At the best, the
monitoring results snapshot will just look weird since there will be
overlapping regions.  DAMOS will also work weirdly, applying the same
action multiple times for overlapping regions, and make DAMOS quota
weird. More seriously, depending on the setup and regions updates
sequence, negative size regions can be made.  It will trigger
WARN_ONCE() if the kernel is built with CONFIG_DAMON_DEBUG_SANITY=y.
Depending on the monitoring results, the negative size region can
further trigger division by zero in damon_merge_two_regions().

Note that some of the consequences including the WARN_ONCE() and the
divide by zero depend on commits that were introduced after the root
cause commit 97d482f4592f ("mm/damon/sysfs: reuse damon_set_regions()
for regions setting").

Fix the problems by checking the assumption and returning an error if
the input ranges don't meet the assumption.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260630041806.151124-1-sj@kernel.org

Fixes: 97d482f4592f ("mm/damon/sysfs: reuse damon_set_regions() for regions setting")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260702170326.87255-1-sj@kernel.org
- Drop RFC tag.
- rebase to latest mm-new.
Changes from RFC v1
- RFC v1: https://lore.keernel.org/20260701034921.99179-1-sj@kernel.org
- Move consequences divergence note to body of the commit message.
- Rebase to the latest mm-new.

 mm/damon/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c6fc35be633b3..b2fc15a3804ff 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -418,12 +418,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 {
 	struct damon_region *r, *next;
 	unsigned int i;
+	unsigned long last_end;
 	int err;
 
 	for (i = 0; i < nr_ranges; i++) {
-		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=
-				ALIGN(ranges[i].end, min_region_sz))
+		unsigned long start, end;
+
+		start = ALIGN_DOWN(ranges[i].start, min_region_sz);
+		end = ALIGN(ranges[i].end, min_region_sz);
+		if (start >= end)
+			return -EINVAL;
+		if (i > 0 && last_end > start)
 			return -EINVAL;
+		last_end = end;
 	}
 
 	/* Remove regions which are not in the new ranges */

base-commit: af0487ccfb044dd7d9418c06c6718af630e16311
-- 
2.47.3
