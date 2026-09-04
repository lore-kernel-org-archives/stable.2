Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4B51E43F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546922; cv=none; b=g3tJkBYHm2JTFWHePgriO0D8kU0OFHQ4nn9PRzhXIRn/ubUIxL6jHPO7Xi0QIA8S0SloqtvLi6qj3RWtjSrynwo6Wm3CU+yF/ub+0Ucs3A+MYMnQ1Hwtja91R/+dlQtFXOSpOLFUVYIPf5Ty0buSgEnEZaRdyEFwMVNhZiSjf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546922; c=relaxed/simple;
	bh=SwB5XgCNwZBZphq1fUqPaSUe3DwbNAy3L97ncGtq5ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtykZU2RYlLOyjNAOEG1HNpuUs90Fz8LX59EHMHd66FsjAsnQlCRbC4CNDmu1TcoUGub8lxSXAJM4s2tVbQlkHNXM62AeUq7kE0MJwnjHq/LGhFXDF7TiD4VIM8O3G/aJNKkmifHppm6M5oZ2ERGssLyZ8qetsqU6eFYnjeJ1mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq5oj68G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq5oj68G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459341F00A3F;
	Fri,  4 Sep 2026 18:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546908;
	bh=fp63aQ2sKP0Ix60opvhlrR66crkLY0dNLr90wEWC/ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hq5oj68GsQxd44Dwy7wqpicBt6N2Feze+0IgJRLOWWZe8ddEuZDSUbJ/6aZuvz0nY
	 ZAWVXl04Vp33V9KHwGDa/CL4i63RH7Ag1pIQMzwriLTUoydYzkReddTmp+JoCANki7
	 YoczAXdvzo8Ro8aoZCNgNmXHj9HjXW90I7fKw2XPKeQWmli8phEkPs+fyzx99QgQm5
	 8oHbJHLMrojpjhhALa5IeGU1hqbpZDRLOO3z1WzPxtN9F89rK2Nbk5rdJ7JNZAhSPD
	 lk87jLCWQxvNdoDoyifpKmLcOLF4hAJZjet5v3/MXZVrYMXixZiKZobLlMfKVNxxmd
	 yBrUAyzyq4v3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Alistair Popple <apopple@nvidia.com>,
	Andi Kleen <ak@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Byungchul Park <byungchul@sk.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Gregory Price <gourry@gourry.net>,
	Harry Yoo <harry@kernel.org>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Jann Horn <jannh@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Mel Gorman <mel@csn.ul.ie>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Pedro Falcato <pfalcato@suse.de>,
	Rakie Kim <rakie.kim@sk.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Rik van Riel <riel@surriel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
Date: Fri,  4 Sep 2026 14:35:02 -0400
Message-ID: <20260904183502.1323253-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904183502.1323253-1-sashal@kernel.org>
References: <2026090326-clutch-freeness-d94a@gregkh>
 <20260904183502.1323253-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dev Jain <dev.jain@arm.com>

[ Upstream commit e87df0d5d6962bde50f55f6d02b779daa394f894 ]

check_pte() is the final validation step in page_vma_mapped_walk().  It
reads pvmw->pte with ptep_get() to decide whether the entry maps the PFN
range being walked.  For hugetlb VMAs, that pointer refers to a hugetlb
entry.

On arches which provide their own huge_ptep_get() to dereference a huge
pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
etc to misbehave.

It is not clear whether this has a trivially visible effect to userspace.

Use huge_ptep_get() to dereference a huge pte pointer.

Link: https://lore.kernel.org/20260703114202.365553-6-dev.jain@arm.com
Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
Signed-off-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Harry Yoo <harry@kernel.org>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Jann Horn <jannh@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Jun'ichi "Nick" Nomura <j-nomura@ce.jp.nec.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Mel Gorman <mel@csn.ul.ie>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_vma_mapped.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 3f003623eef45..e07f4b80d44b1 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -87,7 +87,13 @@ static inline bool pfn_is_match(struct page *page, unsigned long pfn)
 static bool check_pte(struct page_vma_mapped_walk *pvmw)
 {
 	unsigned long pfn;
-	pte_t ptent = ptep_get(pvmw->pte);
+	pte_t ptent;
+
+	if (is_vm_hugetlb_page(pvmw->vma))
+		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
+				      pvmw->pte);
+	else
+		ptent = ptep_get(pvmw->pte);
 
 	if (pvmw->flags & PVMW_MIGRATION) {
 		swp_entry_t entry;
-- 
2.53.0

