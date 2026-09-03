Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838DA4A0F0D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454770; cv=none; b=l2dPWxGJPzL7t+/wkWze9cNBR8bgw4sBiXpqKgRMgdLrkolUbnvBwsAczHzoSAE843A/0AVjrBWSGOH7kAZSoP6U50alU1miW+t0r53s1s/Pt9Z6RYUD6q6YU5OfgwNRwoV6Xh+oGNWJOGw9N+z3sN5SbOnQ9jSArUwYsgVJkzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454770; c=relaxed/simple;
	bh=uFwyPrMw+wg63FARYv+aKemuKy65rBTozFyoK4nXqtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0tGOYO6dlMf/EWpaBvGyPnYO2KHfvKwbli72jeqOLEs9dsNjPVjgWEde8BDynmfTzsQjA31t8o/RZBud7r44MqoR5bNv+ydOeoD9kpH9FqAgrmx+MCXtoG0Ho5EGfmd9CmWJabnwFGJgvCrpRvda8pVTU7IyqCsgmec0KgrxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3rZ3Rz+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3rZ3Rz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9931F000E9;
	Thu,  3 Sep 2026 16:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788454769;
	bh=L+u4Dj38mBfWpdCmqi/7NMOVH4Xq3lE6fPMrPoqbWTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3rZ3Rz++o1UOdqSxY6D7MGQ2JKwCEOS1JKAd7PkLpNYYEhbqtHQP7nY2+sTbffXA
	 C5EtOfKXyu1D4t98oOLuhKE3iDnxSPJuHpPpj+Tn6UMCXXIkKs+Wq1za3WK/nK1BoJ
	 yb21CvAhM60kEGhj0LY/toajyaHLytcZYmDP/DalN9MfZWCc8lPO728bU8l+s0T7lR
	 Ol+38ttVIv2zyEN+VO8mCc1a7oST5LxMI4ZI86lZnJnNz2MA3UFgRZx5gOnXSBIxId
	 4tNX/1tbdypqtnfroxGhGbm2KaRPnoMrDfLTIYkongwtsnxFZ2vuuD9Ye5eDObuyNv
	 aKCdAMPrECaLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muchun Song <songmuchun@bytedance.com>,
	Oscar Salvador <osalvador@suse.de>,
	Frank van der Linden <fvdl@google.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Oscar Salvador (SUSE)" <osalvador@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] mm/hugetlb_vmemmap: fix __hugetlb_vmemmap_optimize_folios()
Date: Thu,  3 Sep 2026 12:59:14 -0400
Message-ID: <20260903165914.1085906-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903165914.1085906-1-sashal@kernel.org>
References: <2026090320-cufflink-ambitious-4582@gregkh>
 <20260903165914.1085906-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muchun Song <songmuchun@bytedance.com>

[ Upstream commit 6e25c6a9c7eff141ecfc966ecdb7801db2a8810e ]

__hugetlb_vmemmap_optimize_folios() uses incorrect arguments when handling
bootmem HugeTLB folios.

The section number passed to register_page_bootmem_memmap() is derived
from the vmemmap virtual address of folio->page instead of the folio PFN,
so the bootmem memmap metadata can be registered against the wrong
section.  The helper is also given HUGETLB_VMEMMAP_RESERVE_SIZE even
though it expects a page count, not a size in bytes.  In addition, the
write-protect range is based on pages_per_huge_page(h), which does not
cover the full HugeTLB vmemmap area and can leave part of the shared tail
vmemmap mapping writable.

Fix the section lookup to use folio_pfn(folio), use
HUGETLB_VMEMMAP_RESERVE_PAGES when registering the reserved memmap pages,
and use hugetlb_vmemmap_size(h) for the write-protect range.

Link: https://lore.kernel.org/20260612035903.2468601-3-songmuchun@bytedance.com
Fixes: 752fe17af693 ("mm/hugetlb: add pre-HVO framework")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Frank van der Linden <fvdl@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Oscar Salvador (SUSE) <osalvador@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb_vmemmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index f96d00a3ef2ee..0afacf93ca4cd 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -615,12 +615,12 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 			 * mirrored tail page structs RO.
 			 */
 			spfn = (unsigned long)&folio->page;
-			epfn = spfn + pages_per_huge_page(h);
+			epfn = spfn + hugetlb_vmemmap_size(h);
 			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
 					HUGETLB_VMEMMAP_RESERVE_SIZE);
-			register_page_bootmem_memmap(pfn_to_section_nr(spfn),
+			register_page_bootmem_memmap(pfn_to_section_nr(folio_pfn(folio)),
 					&folio->page,
-					HUGETLB_VMEMMAP_RESERVE_SIZE);
+					HUGETLB_VMEMMAP_RESERVE_PAGES);
 			continue;
 		}
 
-- 
2.53.0

