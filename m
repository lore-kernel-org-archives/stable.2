Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E12352019
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788484147; cv=none; b=AtjOTXjulD1ZWu5eUkaFgWZ4fyFpsJ07+hyo2gh2wSQwBL9L5y6Ah8qbjF8f4g9HKsrextgKMYhfDIAzBxUJR5m4DsiQYwGXQ7Sz8+XJ5TSg/IbjF94+4fJ6E5eY9YlmOrzoJn9VboDbJku1y+ZoNoJkmpoiV3AQzeOBpKrTzTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788484147; c=relaxed/simple;
	bh=O/Jyjb5PC8QhEvJgG9lAc26SMhs3IV49Kvigvhmm63c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/CTbPc/ZRP4S9CwToyCNMVVbL8CTaVM74PEy72v4JXo5wVDvlAtoTbcugJwO9jvGaTft2FTgHe+TIgOSEpfRup0oGv6urNiV9RcGwk68hQwL3DMCEiQOZSynVCHcU7fSD427NmT7H0XDQA+YLJJw2Zn9w6+weyYuBZ4fbGQUUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP3CRInq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP3CRInq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054151F000E9;
	Fri,  4 Sep 2026 01:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788484145;
	bh=+wZejlV5UWHpJY+QpDSGyfKKbq2QnK9LyT7p3m7QBAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PP3CRInqyNyhegHK02+y73J91wOMm/wQfhV2b2FO6RxGSeNTU2DXR08UpZJ0REeEI
	 VfVm44Vtos0fV8S8dSjtimI1m/kIF7BpAqLXQwdMSt+uhLREY3kyPPweZBy2MdC7h2
	 ptCB5V1N4DAaDv0ZSxIoVwyUlOA0B3HZHpSipeD9OmcRtzBZn9M2aIh+YndlpC3HWv
	 5LC1BdofOeu4i3UOjoxu9GKJB3NbYJdg0taePSKb16MrKcaRN0++ycecM2eNUxnvIe
	 M56ieXwO7BEhNhO/WI0+5pDgYm6DUFtaPV8Ob5aGRWXp8xRLi89gnEkZIlCz+AxVkI
	 vvkZ3kPnEECkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arvind Yadav <arvind.yadav@intel.com>,
	Zi Yan <ziy@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/migrate_device: clear stale mapping after freeing swapcache
Date: Thu,  3 Sep 2026 21:09:02 -0400
Message-ID: <20260904010902.2141033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090343-uncolored-jester-bfc2@gregkh>
References: <2026090343-uncolored-jester-bfc2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arvind Yadav <arvind.yadav@intel.com>

[ Upstream commit 34a00895d032a414830d41106a09329ae6c251b6 ]

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
[ refreshed folio_mapping() after folio_free_swap() instead of resetting the not-yet-present THP-split nr/batching loop ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 94e0b33bd99cb..d655f3c0f3e76 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -746,6 +746,12 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 					continue;
 				}
+
+				/*
+				 * folio_free_swap() removed the folio from the swap
+				 * cache. Refresh the saved mapping before migration.
+				 */
+				mapping = folio_mapping(folio);
 			}
 		} else if (folio_is_zone_device(newfolio)) {
 			/*
-- 
2.53.0

