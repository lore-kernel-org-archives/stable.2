Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F703FF1BB
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922407; cv=none; b=boFoJIbSGPBYj68bL/P5HdIBHh9DAj9rsMZCJNCd1mShnuWhYE3rHbCxkZIgrFgexhJQbiDR2Wg8dWLwP0tXr9CsA3DrqaJtJlxXNzhAqDrw1IYXHU0lvqNz3gUfDsHI8EmlaWJw0iN/wcBwGT+Tlu3gI/hmTJs19iha8veaMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922407; c=relaxed/simple;
	bh=3hXpFXIKOcBdOVn+a+I8+5HriA7gbEYTGZ6mZzY2Elc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZAnLSAqYE4O1XBP1Q2sTXefNDhBM7HoEYkEW6uov2WleW0F15UuXayw0kHQZ/6JvZeNDLuNOUaTZgH7T0jROlxYmmnLvmVUY38Zdct6GlGnKoUkifHeZ+qvsrr2R72GenVY6JJwzGhg02dbtKeh01y7/ct5UXynfJV6VsIu8Hek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y3W9YzW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y3W9YzW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F051F00A3A;
	Wed,  5 Aug 2026 09:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922401;
	bh=Pjx2xd0pwa/jIiwO0qBmMxdFNBA6Qss2hhoFeoHmrpI=;
	h=Subject:To:Cc:From:Date;
	b=Y3W9YzW+yLlaGqdFxCDt5gZsyCZQlgT0vYsRRE5eVilRXyZI3SojgWfPgsCyeF63Y
	 8+j9hZuQiEiX/s7jDaj9h432efnzG3Sl/4FCCORexYg2ruvLJIE3+d5J4zj0HDNhAO
	 YF7AV8JYsZVKve5EMs5W9EfgriV6ptFPythVxe+0=
Subject: FAILED: patch "[PATCH] mm: migrate_device: fix pte_pfn/pte_dirty called on" failed to apply to 6.6-stable tree
To: wangkefeng.wang@huawei.com,akpm@linux-foundation.org,apopple@nvidia.com,balbirs@nvidia.com,byungchul@sk.com,david@kernel.org,gourry@gourry.net,joshua.hahnjy@gmail.com,matthew.brost@intel.com,rakie.kim@sk.com,stable@vger.kernel.org,ying.huang@linux.alibaba.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:32:39 +0200
Message-ID: <2026080539-supremacy-prong-8fa9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 63867c82d0c0c2d182016a32b1cc0103116b0ea5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080539-supremacy-prong-8fa9@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63867c82d0c0c2d182016a32b1cc0103116b0ea5 Mon Sep 17 00:00:00 2001
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Mon, 6 Jul 2026 19:19:58 +0800
Subject: [PATCH] mm: migrate_device: fix pte_pfn/pte_dirty called on
 non-present PTE

pte_pfn() and pte_dirty() have undefined behaviour when called on a
non-present PTE. In migrate_vma_collect_pmd(), these functions may be
invoked on non-present entries (e.g., device-private entries), leading
to potential crashes from pte_pfn() or incorrect dirty folio accounting
from pte_dirty(). Fix both by guarding with pte_present() checks.

Link: https://lore.kernel.org/20260708003955.4024340-1-wangkefeng.wang@huawei.com
Link: https://lore.kernel.org/20260706111958.3649651-1-wangkefeng.wang@huawei.com
Fixes: fd35ca3d12cc ("mm/migrate_device.c: copy pte dirty bit to page")
Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 554754eb26ff..908d2d4ec43a 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -401,7 +401,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			bool anon_exclusive;
 			pte_t swp_pte;
 
-			flush_cache_page(vma, addr, pte_pfn(pte));
+			if (pte_present(pte))
+				flush_cache_page(vma, addr, pte_pfn(pte));
 			anon_exclusive = folio_test_anon(folio) &&
 					  PageAnonExclusive(page);
 			if (anon_exclusive) {
@@ -422,7 +423,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			migrate->cpages++;
 
 			/* Set the dirty flag on the folio now the pte is gone. */
-			if (pte_dirty(pte))
+			if (pte_present(pte) && pte_dirty(pte))
 				folio_mark_dirty(folio);
 
 			/* Setup special migration page table entry */

