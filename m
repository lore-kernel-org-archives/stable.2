Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61771DA60D;
	Thu, 30 Jul 2026 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373320; cv=none; b=UxkcGvTB6lPp7ZNW3IbgfB4sLCKF8Gx0Hw3w7QNvk9lE5g5AKrZPjiHL8SpdiLtvr7FAaPXq7cOwtGFPYYNJx7Y/rjW7RCSKbVqPBnq1rcAel2Mz0dSuNqiyg080X35v41+skBS5/mkyLc+Z6c2zzqzNPLt0ZduAOOZUh5YgkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373320; c=relaxed/simple;
	bh=in5uAiOXbsJP1wKXl9mMFAqFm7WKYKmHAuvfQFtQ4t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzCJdsPujuDfMLwM7dXHHVCMHyvttGWx5UHc1zkS9sOYDu+ZOZCwmT5tIgpcl0mAQRYq4CsJEAKjmg+p+MPRN7YouFaRNk7IeamPMv3QlfpAE+gEhmmhVzwT3Ogh4nz0sP21b95VzyDNWZtvOVBLWsrsSN0FYl07U510OFklY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjE983Mr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjE983Mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E1C1F000E9;
	Thu, 30 Jul 2026 01:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373319;
	bh=zYuz91UgyCzYVQ8zBQoN2VqqzGiog2ueSnd8uTbP1Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bjE983Mrp4zzgnIWT9zgHc4cMxz18KZHB81yeSZtQtl+TV5kQ1z9+rAmdMSKSYiJk
	 uKN/5tVTwEM0tQj1y8yalsS4LqWHQH1umNXbC/GeIHElmbuHWJ0RhKd6JQBbXmvJha
	 c2v6i7qZYjPq6C6MOFsSVjw8n+ah2aiJetR/G1AfetnKWNlNFhb2MJGkfTQYKTNXLM
	 Jjpf0PURAJiJYABWLoBWX3CDS4EL1RjaJraGPLveXWs8VSRikKA9A5ZXXDJ3ljbcK0
	 4kga8SdmaeyaJcTuOwv9NeqOqSS6An7anSyS+WGjaUwU059z1k5vvnqo43Yts1VIXX
	 WnQyMsy4JUh+Q==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Yang yingliang <yangyingliang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/core: validate ranges in damon_set_regions()
Date: Wed, 29 Jul 2026 18:01:51 -0700
Message-ID: <20260730010151.119009-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072901-stapling-parkway-4887@gregkh>
References: <2026072901-stapling-parkway-4887@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core logic assumes zero length regions don't exist.  However, a few
DAMON API callers including DAMON_SYSFS, DAMON_RECLAIM and DAMON_LRU_SORT
allow users to set empty monitoring target regions.  This could result in
WARN_ONCE() on CONFIG_DAMON_DEBUG_SANITY enabled kernel, and
divide-by-zero from damon_merge_two_regions().

For example, the WANR_ONCE() can be triggered like below.

    # grep DAMON_DEBUG_SANITY /boot/config-$(uname -r)
    # CONFIG_DAMON_DEBUG_SANITY=y
    # damo start
    # cd /sys/kernel/mm/damon/admin/kdamonds/0
    # echo 0 > contexts/0/targets/0/regions/0/start
    # echo 0 > contexts/0/targets/0/regions/0/end
    # echo commit > state
    # dmesg
    [....]
    [   73.705780] ------------[ cut here ]------------
    [   73.707552] start 0 >= end 0
    [   73.708452] WARNING: mm/damon/core.c:359 at damon_new_region+0x6e/0x80, CPU#1: kdamond.0/758
    [...]

All DAMON API callers eventually use damon_set_regions() to setup the
regions.  Add the validation logic in the function.

Link: https://lore.kernel.org/20260630035221.146458-1-sj@kernel.org
Fixes: 43b0536cb471 ("mm/damon: introduce DAMON-based Reclamation (DAMON_RECLAIM)")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: Yang yingliang <yangyingliang@huawei.com>
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 1292c0ecb1caefb8ca064a3639d5673991e8810c)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4b434ebd37c53..0a0bb033f28a4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -212,6 +212,12 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	unsigned int i;
 	int err;
 
+	for (i = 0; i < nr_ranges; i++) {
+		if (ALIGN_DOWN(ranges[i].start, DAMON_MIN_REGION) >=
+				ALIGN(ranges[i].end, DAMON_MIN_REGION))
+			return -EINVAL;
+	}
+
 	/* Remove regions which are not in the new ranges */
 	damon_for_each_region_safe(r, next, t) {
 		for (i = 0; i < nr_ranges; i++) {
-- 
2.47.3

