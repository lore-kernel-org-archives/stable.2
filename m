Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1A3B841D
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359458; cv=none; b=CKdmIgq4HyzbleL1xUcNxcD8gqWDDGguRKhVUiXiXrt7F3CQi3m+qylKIo46nbwCqWsdjgLgq97u1xCVHm4uwYjmUa4qNt2ZU4F5VoHI25owmJMCeJ6VCV9qlbyyE7rZRzYaITQ4H/k57CY206egNI72AvDY/FqmUmxSDS4JEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359458; c=relaxed/simple;
	bh=i4KRn2+XlaDHI45c4JJXWBK6/G0g3A8mIBQUJFCD020=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAlgAofWqlqfa3SjuZmcAtIDChE+kIyzz9PvyPiyM3QmTSGwwQ7qkAwY9TL40LKtX0ixXVeOJcMkuwgNIFJX74i3QDygFhkrbJR9cBMnBQ2wmEqNjkxtz16OrhxhJX8P18/uOnxUbDp7F4GrfWoyzU8w4NYfz7tJRBomdKuRGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaR0pqjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaR0pqjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26C51F00A3A;
	Mon, 10 Aug 2026 10:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359456;
	bh=LUy8EmCsqlozXgVjSiRGUpmrIjCGXKDgsZKMgC6pSL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZaR0pqjfoTm1R9I5GKN5r1VanIEpGb1eCbeUmFh4iuF8gDUrWZd2o+vyC8qOxboIf
	 aFhApIdZxSZNkkjILao1K4Zy+ABHemV+hwLMHRwtSgfnmRflZBGHRLfhOSOu6xriI4
	 b8CZ55alVX3hrazqmTwFgPPvvR3R+g4h6xS/EKzt1OuipJx+ZOlP1Ql6tkTi6yTjR/
	 HRyPJnwGphxNXRa36In4L/d85BzO4zUoDmhpw5eJFl3fsl0bIQXimMKZyTs2SPBU9K
	 N5u56p4J9JMU7lYGVPtnWkzlfn4TT+2XZ+Dja+Xpz9HPfgs6aeuMwAr5YIg9nXNyqe
	 QGNz1pWh2hrPg==
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
Subject: [PATCH 6.1.y 2/2] mm: migrate_device: fix pte_pfn/pte_dirty called on non-present PTE
Date: Mon, 10 Aug 2026 06:57:30 -0400
Message-ID: <20260810105730.578433-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810105730.578433-1-sashal@kernel.org>
References: <2026080539-snowsuit-kept-385b@gregkh>
 <20260810105730.578433-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index e198569bb3324..cd7248a2c8c23 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -203,7 +203,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			bool anon_exclusive;
 			pte_t swp_pte;
 
-			flush_cache_page(vma, addr, pte_pfn(pte));
+			if (pte_present(pte))
+				flush_cache_page(vma, addr, pte_pfn(pte));
 			anon_exclusive = folio_test_anon(folio) &&
 					  PageAnonExclusive(page);
 			if (anon_exclusive) {
@@ -223,7 +224,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			migrate->cpages++;
 
 			/* Set the dirty flag on the folio now the pte is gone. */
-			if (pte_dirty(pte))
+			if (pte_present(pte) && pte_dirty(pte))
 				folio_mark_dirty(folio);
 
 			/* Setup special migration page table entry */
-- 
2.53.0

