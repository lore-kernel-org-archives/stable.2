Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBD74968FC
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333625; cv=none; b=cOXETbDp+PbRVkXeAIv8E5Sugh04r/JuahpXYyn7FDCohq7QroVkjmfse7aWjYaxNwIvY6oGhPFkyEAXqD2/iXvgbMN21ZYdC5FobSBoHgkBgU3sp4BfPyIDsZTIWThRTP57ZD+Jrc+eCNNu29IX3FrGrFmyK9YTkEU1Ierb84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333625; c=relaxed/simple;
	bh=eyit25qzYs6NYrECeaLOt01Bj6kNisp83tAqfWKr4q8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k4CMmAv6k35H7Uj+gDGCTz5UphwYY478vZFgzyIwEoBQASb9twkJjVFSIPRY0PB8px+EZM6E9cewUFV33wbCFqClQ741I06Qu9W3p0e59p8jwmgdmAcvIn1j9Mq+N2DlAWTHJrWHedAtipxMjhEyJQUbtfYNByOTGllEdA1n5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qWa3NOcX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qWa3NOcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505E21F00A3A;
	Wed, 29 Jul 2026 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333619;
	bh=0PLZSK3PezPF3X8giwcX5AxnOMTRyWoGAEM3KCc1AnE=;
	h=Subject:To:Cc:From:Date;
	b=qWa3NOcXSmr/DN7ODMAvfR8j2Sf/zBX71y+GINa0/TbAwlPZHETYlt3jMh/6bAn5U
	 6v/5dIDX54zm2NLx71Nsy5V0Zy3ZT02jbmUU2LoPMjo2WiEzUAsTP4uLWHMfobcjBI
	 n70DloTFIwt+PzLHpi788HoZ7hr6LvlN2Dsp+9Sg=
Subject: FAILED: patch "[PATCH] mm/damon/core: validate ranges in damon_set_regions()" failed to apply to 6.18-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org,yangyingliang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:58:00 +0200
Message-ID: <2026072900-remedial-nectar-f412@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1292c0ecb1caefb8ca064a3639d5673991e8810c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072900-remedial-nectar-f412@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

