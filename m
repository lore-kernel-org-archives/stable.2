Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7251FCBF
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546938; cv=none; b=MDtttvM8P1b6DqE6if1z5APGxsFQxRtc/+AEvOX6Z8/9/DnFx2XQbB1le5eiT+PVyG4urY+Eveeo99KRtnFpzpwEenlaoUk5WDUNvAmXWgY3y0WmTDgDIJyco7GzbXeRXvYmdriDM2ZOlwJYCLxe4Tl7aGN+1nqinEjUuMbteWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546938; c=relaxed/simple;
	bh=edcinFq0RJtKC0lx3aMpJEXiSTCZrmZr/1XmZHta0ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+OmP6j7k8RsC2GlErd54xxbrVXziElipMvdn/p3B5hKnQLFcEm06VnwfC5rrayOWuf/MXehSJ1RQMs4zmq/pKB4u8fNd/AG794PArNUW4THf4HRnBbe3RP2aUyCmdgXex8D5HH1Ahw9ULlKljWj48YKF9Vx8HXz+yNib5xYub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLjMKucF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLjMKucF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641251F00A3E;
	Fri,  4 Sep 2026 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546929;
	bh=HxuRhjJvQyMoYF7eFetg5twNaKvoLk16DViePmIV6dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HLjMKucF7IZa/BbO6qLq6oCCLpUzDg+4ET+4ukn3qIftKIALF63B/CyfZ0rFilzAS
	 d16kHLP5olR2hxlyC0bbX2TLg3WzsdYkks1+7o/YsjJEihzrT5iGC0iyKdZjm0wYPQ
	 v7Z5ehbqvkjuLrxrLLtHlzZWhA/Mq2cmvGBHf9No/X83wKhvnQ+Jwe0BCQC09dzzsN
	 M+pYmTboIYoJkUs/ysFED4pgQtHHHqKK9Q6pIrNdCtLLXBkioIbUMC5dl7cXOSLqHm
	 0W+DZGRxZ+0+Sm7EmSxyQTJxG0L1ppaOocivXY2nQ9q20XWvz36AmCSePBTnFUz9kU
	 POofMQhKfRIhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	Muchun Song <muchun.song@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
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
Subject: [PATCH 5.15.y] mm/rmap: use huge_ptep_get() in try_to_migrate_one()
Date: Fri,  4 Sep 2026 14:35:24 -0400
Message-ID: <20260904183524.1324443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090300-awry-struggle-b110@gregkh>
References: <2026090300-awry-struggle-b110@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dev Jain <dev.jain@arm.com>

[ Upstream commit 9be12ffa78cd087d41086f937a156435d4e588e9 ]

try_to_migrate_one() is used by folio migration to replace a present
mapping with a migration entry. For hugetlb folios, page_vma_mapped_walk()
returns the pte pointer to the hugetlb folio in pvmw.pte, but the code
reads the huge pte entry with ptep_get().

On arches which provide their own huge_ptep_get() to dereference a huge
pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
etc to misbehave.

It is not clear whether this has a trivially visible effect to userspace.

Use huge_ptep_get() to dereference a huge pte pointer.

Commit a98a2f0c8ce1 copied the bug from try_to_unmap_one into
try_to_migrate_one.

[akpm@linux-foundation.org: coding-style cleanups]
Link: https://lore.kernel.org/20260703114202.365553-4-dev.jain@arm.com
Fixes: a98a2f0c8ce1 ("mm/rmap: split migration into its own function")
Signed-off-by: Dev Jain <dev.jain@arm.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
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
[ guarded huge_ptep_get() usage with CONFIG_HUGETLB_PAGE for HugeTLB-disabled builds. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/rmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index c103e01d22327..9fd5422672805 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1784,7 +1784,11 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_PAGE(!pvmw.pte, page);
 
-		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
+		if (PageHuge(page))
+			pteval = huge_ptep_get(pvmw.pte);
+		else
+			pteval = *pvmw.pte;
+		subpage = page - page_to_pfn(page) + pte_pfn(pteval);
 		address = pvmw.address;
 
 		if (PageHuge(page) && !PageAnon(page)) {
-- 
2.53.0

