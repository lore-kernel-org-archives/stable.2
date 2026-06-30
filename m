Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07177219A8A;
	Tue, 30 Jun 2026 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782791552; cv=none; b=e2QcRFbVSxa7sWQCJBi2MqfdDmykNs+oUvam4VIAe81PjANIINEQZ2DknnmZr8S1yXFJHgYnILv+JwbbKAnytr5LpsCmTjtmu2JJ4qxT2EBNWxxRh8sSsEw703+U/odCqcGhW0HxMu8/zYpGrkD1l0U/yFKnlSUk8oYc+y2AD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782791552; c=relaxed/simple;
	bh=w97OAoK3vAYojf+1DNyodckx2XQcsTLl+URCPzKVqOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHk2jjJea8ScFFNiShdC6AbPMaS9xYekpWD0eM8082IAfwNg0z8rqDxjUHGDR0SPCijSMK3potbX8ZICeQwV6I/HQLXgvK5xaasoYTLBImGkNYPLM/wIMdQLn4dwMycQjFWczmRaeHORhdfblo0UVRE9S9SuqfDB+NjmhxuHj4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQscV47n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQscV47n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667CB1F000E9;
	Tue, 30 Jun 2026 03:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782791550;
	bh=oWQGO6JAGeGVOvqhfdihogE5K82vJ74Pirejh7VlOVk=;
	h=From:To:Cc:Subject:Date;
	b=BQscV47nr6fwdYaNNmhl0m94aO6hG1wDTviAy8/A28ojaC/br9mLIo6ifH9zaXntd
	 sRq5nbTZQUJnxrBjnWd69s2L9mMytrsXomveu8oJ7EGI50EhiTfcugqeOf/7yPm+YL
	 kP6ZeD31uorveDYQfb/POcnWvqXttsvsjbs5temCSPbjXhsD7ThZxvPkQDjyKnxO1a
	 vGVdtQgBmweOL9aYPnXhmOPEh7ZZK3uvfsshU1mgRfghhzj2BdgIy/RkPz72yjYjrN
	 JYH8oPyv5qoHwCYK5glCAS+HxMUnhcUo8DAVbDzFq5PDWgZ8Zt/GVyj+kYVxLk0O0b
	 mGS4wq/S/VNwg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: validate ranges in damon_set_regions()
Date: Mon, 29 Jun 2026 20:52:19 -0700
Message-ID: <20260630035221.146458-1-sj@kernel.org>
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
Changes from RFC v1.2
- RFC v1.2: https://lore.kernel.org/20260628165447.86217-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.
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
index 027250e43c66f..3dd2750c2ef20 100644
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

base-commit: e861a804dfa410dde21e8d2d20179df9c66edd8d
-- 
2.47.3
