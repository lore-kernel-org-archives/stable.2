Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DD73FBB6B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439571; cv=none; b=HeTS8a03ZO2EzI2CnsZduDOMq7LqBM6/IultiBJ36XzDw4tH3P6ebaXjy6Y+v/IyFPPfMHBhjm6JwOYVUgep8E27mBi8zY4UUiYtbWIEwHmF0xXClLPX/GRC40dYbGUOmYpz9sRoo9hsTwn09jB+s/oDshwMzkdL0Q/zThkFXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439571; c=relaxed/simple;
	bh=tRqyF16fedts9LipPiRs1IdPkff2d/TvPy7KShgq1vY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n4XAInGT8DQRRFDrFpQRHmNwVgqWE9pKlD/IARNxs+/47CC9rNv1qf9yAu+yvuSb1a00KmLQaZXYdMILWVUNLBqmq2j6dLvXUvlZlJy5+GKtIQy3NgxGR3HbH8tEwpzJUqH70p+filTwVL4VBjePf/E7MsqiaZ7zNSgvmWpwYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zkaRxMm9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zkaRxMm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AB81F000E9;
	Thu,  3 Sep 2026 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439570;
	bh=7TKQmsSc13+wMocXF8105oLVZjV0BuwVLfxRe5HTQ00=;
	h=Subject:To:Cc:From:Date;
	b=zkaRxMm9Ipj6Gfk89crLcQOQq+FGcksX8owpaTxzf3gk/Wad/R+IM9BRwaInwoeS2
	 k4UuxhymV0v03QS0vE2AE9oDQ+4I5YSTtD5LA7kKYX0m/49faYJuXSFoC25j1YBryw
	 ayq1eQWfih3BCJTab/ndijzUa68VzAr5lmLhPAQU=
Subject: FAILED: patch "[PATCH] mm/migrate_device: clear stale mapping after freeing" failed to apply to 6.12-stable tree
To: arvind.yadav@intel.com,akpm@linux-foundation.org,apopple@nvidia.com,balbirs@nvidia.com,byungchul@sk.com,david@kernel.org,gourry@gourry.net,joshua.hahnjy@gmail.com,matthew.brost@intel.com,rakie.kim@sk.com,stable@vger.kernel.org,ying.huang@linux.alibaba.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:48:43 +0200
Message-ID: <2026090343-uncolored-jester-bfc2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 34a00895d032a414830d41106a09329ae6c251b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090343-uncolored-jester-bfc2@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 34a00895d032a414830d41106a09329ae6c251b6 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav@intel.com>
Date: Tue, 28 Jul 2026 11:58:32 +0530
Subject: [PATCH] mm/migrate_device: clear stale mapping after freeing
 swapcache

__migrate_device_pages() reads the folio mapping before calling
folio_free_swap().  When folio_free_swap() succeeds, the folio is removed
from the swap cache, but the saved mapping still points to swap_space.

Passing the stale mapping to folio_migrate_mapping() makes it use the
mapped-folio path for a folio that is no longer in swapcache.  It can then
operate on swap_space.i_pages with invalid reference accounting,
eventually triggering a folio reference count BUG.

After a successful split, nr still contains the number of pages in the
original large folio, although each resulting page is now a separate
order-0 folio.  Reset nr to 1 so each split folio is processed separately,
including its own swapcache removal and mapping lookup.

Refresh the saved mapping after folio_free_swap() so the current folio
state is used during migration.

Link: https://lore.kernel.org/20260728062832.1107127-1-arvind.yadav@intel.com
Fixes: df263d9a7dff ("mm/migrate_device: try to handle swapcache pages")
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 18d097c38853..9a346162c688 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1193,6 +1193,13 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 							 MIGRATE_PFN_COMPOUND);
 					goto next;
 				}
+
+				/*
+				 * reset nr so that only first after-split folio
+				 * is processed below
+				 */
+				VM_WARN_ON_ONCE(folio_test_large(folio));
+				nr = 1;
 			} else if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
 				(dst_pfns[i] & MIGRATE_PFN_COMPOUND) &&
 				!(src_pfns[i] & MIGRATE_PFN_COMPOUND)) {
@@ -1232,6 +1239,12 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 			folio = page_folio(migrate_pfn_to_page(src_pfns[i+j]));
 			newfolio = page_folio(migrate_pfn_to_page(dst_pfns[i+j]));
 
+			/*
+			 * folio_free_swap() removed the folio from the swap
+			 * cache. Refresh the saved mapping before migration.
+			 */
+			mapping = folio_mapping(folio);
+
 			r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
 			if (r)
 				src_pfns[i+j] &= ~MIGRATE_PFN_MIGRATE;

