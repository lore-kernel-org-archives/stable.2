Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEDC4A13A8
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333626; cv=none; b=cgKWMX8ievjnpFes0I1eTzmQCYCdSv4ouKbTgk+EhsBHyWkb/MWZbNlzgZA1sF2epMBQH6bqFgfM9nn/QU4iBcg9i+Poc+E/SNvROyfP7ou0E7F+qXvRDxo0x2/hO3FuK30qvcvwtRl/9O3RQqLy3BbCgsgftjDUcAT7zeRvpLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333626; c=relaxed/simple;
	bh=NbirSzMWX7h3Le2nm1kRGiaPxqVJY0mmZIkKKgZGX/k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sTb2zpPB+wlApdIUC9mCwlyS4ZEZTPH3D7J65hl+6ZVbeIa73T9M+YLCRTzChphZPvcgvaWxQRivCMLYkeb/ZvqKNOezuSOajkvBMxyjuGlEhJ7nM0DvguVww2j4l621I6qBZA7wxnBhlbtqlvJL9eI8skpAcFOV3Sh3qpZ2+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QXL9td9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QXL9td9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C361F000E9;
	Wed, 29 Jul 2026 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333622;
	bh=/IEtbdz0ORhs6tNoUDcMPa88lFV32RT9Iyjsz+j9o9Y=;
	h=Subject:To:Cc:From:Date;
	b=QXL9td9FsxLaz1YQJQqVOCzBOpuWvBzHSPygqwnW6tBQdm02fgEcOOGQ9jchygdOy
	 L98wIo9wOywFSoZ9ROx1K0mBzUMToeIxyG7uZFiwWgi1BKeWo4TwGgYzpb1VBTCRaI
	 XS7CCI2TqNkgoXH3D6kzJDIaG370YCkc5D0VkXjw=
Subject: FAILED: patch "[PATCH] mm/damon/core: validate ranges in damon_set_regions()" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org,yangyingliang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:58:01 +0200
Message-ID: <2026072901-stapling-parkway-4887@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1292c0ecb1caefb8ca064a3639d5673991e8810c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072901-stapling-parkway-4887@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1292c0ecb1caefb8ca064a3639d5673991e8810c Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 29 Jun 2026 20:52:19 -0700
Subject: [PATCH] mm/damon/core: validate ranges in damon_set_regions()

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

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d99f7a297fdd..949d5309d54d 100644
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

