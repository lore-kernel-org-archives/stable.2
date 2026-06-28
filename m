Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D5148850;
	Sun, 28 Jun 2026 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665706; cv=none; b=MRqptSVVU+8ZMUlhDJqdKT8VgE24HUT9htM4mEoPy+YXypDj1iwOOjDl8ffajXhemwwKaYrIrVIzt9Qty8xBD8qrd0e3yv47im5EwFvK2wgZCiJgt9JkfGIU7VDxe1+2MP3mvtETpQuVla4g9ZlweImHjgb8xabl6xYr0kLjHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665706; c=relaxed/simple;
	bh=amVSJ/GVsC1ebNfCxl39jJ2vXx6oRDIzstnIJPSgnHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d8XZhnJCPwALRzzpNSAYK4jQDClXrn1RuwGxWVRzOhNyHqp8x81ynHGuqQiHdliP+eiPhx6PO6qhZ9x2IEbmLeM+gkCr/Z5llqMYHDWH7PVAAdZjNBN11j1FeG5hPf5pBMDlSBg0x+p1PLAm/Em6rsN2x76yPpiYft7uxN2wirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvUnhp7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvUnhp7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CA61F000E9;
	Sun, 28 Jun 2026 16:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782665705;
	bh=WnNx7JGiiiPZrlprnXcKYwyKhDFTWq0vvPCdgz5lwaQ=;
	h=From:To:Cc:Subject:Date;
	b=IvUnhp7nb/iw/yn1ckX19zJmPsB3c5cYpg6Or5AuCQnNUIccZVZJcrYXoAPHVo9we
	 ZWcXaoKKiGXDgUva+BaJ8w807AdfgsE+NaPBclzG8+8+nXoMa8ZucaZJXbcQqVqcGp
	 p8OBzAgpAr3NYVFoDe+Xlxw8xajgJ4BVduxORZQJO1Z/UI0CB25jUlxQ5/zT4eVcnn
	 n9ereCDbVxOukVLLp0CJxVpFn/7sjnPLKkX1DFO7FtBPqH+1ObU4GXbPh3cP8iH1G9
	 xByqjDst/Ky+ElD5Xq6NLB/z/VV5j3C6dRxme201bs9XCaiR5GURBlYypn8X3q3QkR
	 MgyGI9ZY5T32A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [RFC PATCH v1.2] mm/damon/core: validate ranges in damon_set_regions()
Date: Sun, 28 Jun 2026 09:54:41 -0700
Message-ID: <20260628165447.86217-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core logic assumes zero length regions don't exist.  However, a
few DAMON API callers including DAMON_SYSFS, DAMON_RECLAIM and
DAMON_LRU_SORT allow users to set empty monitoring target regions.  This
could result in WARN_ONCE() on CONFIG_DAMON_DEBUG_SANITY enabled kernel,
and divide-by-zero from damon_merge_two_regions().

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

Fixes: 43b0536cb471 ("mm/damon: introduce DAMON-based Reclamation (DAMON_RECLAIM)")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260628005723.28549-1-sj@kernel.org
- Use ALIGN() for end address.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260627170057.1867-1-sj@kernel.org
- Fixup the commit message for how the fix is made.
- Do the validation with min_region_sz-aligned addresses.

FYI, this fix cannot be applied as is to the commit that introduced this
class of bugs, because damon_set_regions() was introduced after the bug.
I considered making three fixes for each caller to make the backporting
on the old kernels easy.  However, the first LTS kernel having the bug
is 6.1.y, which has damon_set_regions() and all the callers are using
it.  So porting this to necessary stable kernels should be easy enough.

 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d99f7a297fdde..949d5309d54d3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -356,6 +356,12 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	unsigned int i;
 	int err;
 
+	for (i = 0; i < nr_ranges; i++) {
+		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=
+				ALIGN(ranges[i].end, min_region_sz))
+			return -EINVAL;
+	}
+
 	/* Remove regions which are not in the new ranges */
 	damon_for_each_region_safe(r, next, t) {
 		for (i = 0; i < nr_ranges; i++) {

base-commit: a5e5bb743e4c174689e5d57b25fa8c78c49546e8
-- 
2.47.3
