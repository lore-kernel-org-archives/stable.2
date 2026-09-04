Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0A1DD0EF
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485991; cv=none; b=k2kTnyeAj/m9uyvGzWqscnKQHj4TI2xQ60QOEZRhdJdhdNChmt3RWio1mDHZucuC4eqbuGAO+6uCJ5n/Z8OOSqXQP2rSXiTuP0uVj6iY8oIejlxYTmBJzjYXiruwP5D5MRRcYFsgcfz2cvLfin/8/e/z7MxP3yzXwOdA0saRfcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485991; c=relaxed/simple;
	bh=KHyamgFXVTntcH8KI2tdDsfYKbGrBWWOa7wGNkS+Js4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COKDRfFHyrdDJONA83jh3xjGr1Z4NmCj4hfgFXXV77aZPpE6SjpZa4s6iuyYNM5Bfs8sV1Hk+ptm01axIQ+RHVLS4PRNeMnGBLzXLfAsKJlRHzeMLvnQaBlVU6FDCkb+OCCTla4oHVtJon5NnilQCI9tLTftDDggC4xzGFte7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idv+24sc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idv+24sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445941F000E9;
	Fri,  4 Sep 2026 01:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788485989;
	bh=wIGhtaTQCn2v5gW2LP5TE3Hjz+ZVZDwzFoUAJFdNdRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=idv+24sclr1SrokkmOdC8d3kJc5FwHWPm++NZYbb2jn/N6WNVxwOSAP0+4X4qm+rD
	 t5SNXxzwn6dmsa8xUVAF5ZKf6tKohxjwcPDm1jSTPr3XeROCZHslvzjN7DF50lg9UR
	 l0DEC15xbP+IgCpuwtA+QOYtVhF+DDKJ4GQUHWNNw8LjQEfc1IiJYbdFF8z7vFn1wB
	 xXh9m18394Knr/UtoZkdskwTphl2UxgYU32dzHWy/4vZxukLrmeFUb7DUlsQ5j8iFN
	 MvkFo3yNr5YPjQaX6mZS6YeD2c3Q59F2VaSrnD/z1UAVwbBJ3DNsTaCGMqj2EkgoTH
	 21ohYa6A+rk7w==
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
Subject: [PATCH 6.6.y] mm/migrate_device: clear stale mapping after freeing swapcache
Date: Thu,  3 Sep 2026 21:39:45 -0400
Message-ID: <20260904013945.2165551-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090343-paternity-outback-346f@gregkh>
References: <2026090343-paternity-outback-346f@gregkh>
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
index d4ee7ab735a38..1ec278a529b40 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -745,6 +745,12 @@ static void __migrate_device_pages(unsigned long *src_pfns,
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
 		} else if (is_zone_device_page(newpage)) {
 			/*
-- 
2.53.0

