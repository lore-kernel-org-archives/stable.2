Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B73BD63C
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786288875; cv=none; b=pr4AqolM5CE2htU1RIuDC/hc1CbTT6sRiproboPgIoDhPO9cXDfbMZegs2hO3j8wmxTT3LwMd89WoNoZPB0C9vfvub3skR1pnBz8MkkHGm2qX0SoB0AheXtjx8C2SZQOTKUPg3TF+FDK0KuAoH9aF9e52/2/1z7oWGk9TWoBJUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786288875; c=relaxed/simple;
	bh=9exluIOoYe/s5KVFYCLWFe61MOnZLfppIaH7/cQevIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rq7rzykqPi0ZEvb+NhSkYPLHZ1vBnbqxIp02dt4T9tu7uqNAjmYIO3SiT2MfLgZk6PyY481w0e5yu236JSDJMSxuAynMdUCbqGOQA7xTZ+HLuGRn8SkkxLDfZkQAv3CAE4LrfKLUaf83fTd5D+MzlmY+QxE/UMWd4wUPnU5+C8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db2lQ1mK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db2lQ1mK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEF61F000E9;
	Sun,  9 Aug 2026 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786288874;
	bh=1v94eLRIY3VuyKiYfvIbgyXUDvhf99d0ERnXRetDQRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=db2lQ1mKRekjdzE94w1BU9OHHtCdLYLmYzG6THBbibp5bVDAUhM8xbaWxQAoq9HGH
	 31LzzBmZacmBaJtEMni6KeVbZ+1lgxMEwCuc6oXzFOFV/sxyegicb2fqbL7fYqzETW
	 mJEVMr7HkSzvz1pRdYVGSEksfbmoqxYJ6I9OyAAGv2+erkItC1jen7wbWH5kdcdnOw
	 rHJKfSwJvYcYejFf3qFWxvKkOFPNXBsvM0BZFsDddDBzOQrLEs0tWO+QoKUnva5u9h
	 6D2H2bD+AZ73oOGNQj/4WOEa/yFLTZRj2U7PRhDukYu8IODKKTiMP4Jm8ECNemlmco
	 E2T+2O1nJazwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm: migrate_device: fix pte_pfn/pte_dirty called on non-present PTE
Date: Sun,  9 Aug 2026 11:21:10 -0400
Message-ID: <20260809152110.1967450-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080539-supremacy-prong-8fa9@gregkh>
References: <2026080539-supremacy-prong-8fa9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit 63867c82d0c0c2d182016a32b1cc0103116b0ea5 ]

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
[ adapted `folio_test_anon(folio)`/`folio_mark_dirty(folio)` context lines to 6.6's `PageAnon(page)`/`folio_mark_dirty(page_folio(page))` spelling since the `folio` local doesn't exist ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index f209dc512d821..d4ee7ab735a38 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -194,7 +194,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			bool anon_exclusive;
 			pte_t swp_pte;
 
-			flush_cache_page(vma, addr, pte_pfn(pte));
+			if (pte_present(pte))
+				flush_cache_page(vma, addr, pte_pfn(pte));
 			anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
 			if (anon_exclusive) {
 				pte = ptep_clear_flush(vma, addr, ptep);
@@ -213,7 +214,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			migrate->cpages++;
 
 			/* Set the dirty flag on the folio now the pte is gone. */
-			if (pte_dirty(pte))
+			if (pte_present(pte) && pte_dirty(pte))
 				folio_mark_dirty(page_folio(page));
 
 			/* Setup special migration page table entry */
-- 
2.53.0

