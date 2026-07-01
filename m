Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27277153BE9;
	Wed,  1 Jul 2026 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877766; cv=none; b=lWI80VVWS0A+Q9/Gnhb7sH2tOwBpNBxCeRrzPSgx/m5hczkeVjoM9svgelJHfwzc4F6G6edWmF1F8doW2oFHwjCw1hPml7CXxHYUI8gIksOYffFbcqQjEA5NR0Llze+OjO4p46e3oHO5NZLHYnqNGiajVHfmh/El+xuOFE1/0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877766; c=relaxed/simple;
	bh=HzrrCs8h6iLWxsQVSConV5FaL92OEu3gjLyX+IPW5vU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oV/nXzbewfJmE6nON3Y/ZNzQSFY0eANwmX+xwSaKibSkB60d9QjPlKtNsmBD/me+JOq7tz8iEP1p2ZT7Bw+wir37PTQ1N20SzAJEOpMANr4R+7MmFgdUMu7UI7yyrGZGHUO44YIH15LhZrW1zRrKTsYs0SGGVZ2HBohhuyl4BQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7UyyaqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7UyyaqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D981F000E9;
	Wed,  1 Jul 2026 03:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782877764;
	bh=DSsNvKEhBE5WjxBTWWMLlI7db6DTdt9TNuLjxtRycHA=;
	h=From:To:Cc:Subject:Date;
	b=m7UyyaqMGmKsZsCAJyJQIIEUp67RIhDIq9y+b8ac8fOpQA5Qk0uxhOTa8cdStG01z
	 /1Tdb0AIOaZupv744SiazIjaDztqrQ2zGJ3PxkGL1c93AXu50nQt36EWsCkbB1h8y9
	 q4GwLsFj+XmGhSKW1eWE+z5Bv1RZKD6YBk/+8zHzhfovpNWLTZW3BDpf9vsofZcxUP
	 k/mdIcYiR3kAQon4kkcDeYF3gsMWqqXHYpir9Muy2eGe3V31w432OUZZlISooK5UIB
	 b9/wK++cYeuakV225wYzRCgQWKnbYrwjEMPQ4DZfjKWVtiUv+gtVKvYRQtdqwGp5zQ
	 YAFh32ZeTaarg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/core: disallow overlapping input ranges for damon_set_regions()
Date: Tue, 30 Jun 2026 20:49:18 -0700
Message-ID: <20260701034921.99179-1-sj@kernel.org>
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

Fix the problems by checking the assumption and returning an error if
the input ranges don't meet the assumption.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260630041806.151124-1-sj@kernel.org

Fixes: 97d482f4592f ("mm/damon/sysfs: reuse damon_set_regions() for regions setting")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
Note that some of the consequences including the WARN_ONCE() and the
divide by zero depend on commits that were introduced after the original
broken commit.

 mm/damon/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 972a19fcee3ec..a99458c578518 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -354,12 +354,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
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

base-commit: 81c085116d080d3f35279353cdec773e02f43fe1
-- 
2.47.3
