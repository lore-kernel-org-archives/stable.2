Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB1275870;
	Thu, 30 Jul 2026 00:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373167; cv=none; b=gN37d/nS2xhFyLQUmzbGb/XAKyRBRWmC6No6xxVHHn4zw1BNB2BXXiQgjjuOpHxhQvj1x6Pe+UuKtB/PKsIBzKP5IoMeVXqrE4cQf4CbUVzxqUQhViuGvFKcUeyp0Nf5dfDWFoNTSMeCc82YfJRjMGoHuf1be6QptNs0bKRky3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373167; c=relaxed/simple;
	bh=5+cYsASVRh2uLBQTCYu+3wxiDdOSO1Zvl+UX68Gxqo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rN1oNBUS9/1zJELiWC1eyb2ZQcUdO3Qqarxi3k1ueVGYk4TWEdSr2LvJJHDwY8ruvdYpL2sQ+I7+2U2SjZrQVPmgKyZAdwz0k/7zRt0aK7BXvZmv/ivD35jVNifGO/1NJwG1eoCDnLZEcEwpebFYXBROa441od2EPWSTjgLGego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AD/B4nfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AD/B4nfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5701F000E9;
	Thu, 30 Jul 2026 00:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373165;
	bh=He/ha+AKaBGNbMo5KBtIDX7c4iKcLwK62YpnNkglYUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AD/B4nfwcgL3Itt3WHZvtuOOvZUTpkORXKeX+R9qopwgJQgBjnk+mTfS0uQecVgR1
	 y+PPtzvn0ZztKE6KjvxFNgEyIfeP5jFnehelWt1ubkNc7XMloC3IYunIcO6MHJp0kc
	 I4C88RP/BM8xFXy1oNwYP4QLJaPs6c6r8j/nYFK10igD8nzF8KND+Pkf9uJzs8dTcv
	 P6FM+c82rSlPRgBEpmd3GmOESkGYyCodxox6sxkyz9uztG7iR1zD9jKRafoF15Qa0r
	 DD0i0UBnJ5nQ3D6usAKuA1/LfDf+Gh+h3LktN65TAa3plVfwk1n4mCufZhEccav8wI
	 dJjNx7aC8ngHw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Yang yingliang <yangyingliang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/core: validate ranges in damon_set_regions()
Date: Wed, 29 Jul 2026 17:59:17 -0700
Message-ID: <20260730005917.112632-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072901-unmarked-salvage-c2a5@gregkh>
References: <2026072901-unmarked-salvage-c2a5@gregkh>
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
index 46600265d7ffc..437a52fd6e0ee 100644
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

