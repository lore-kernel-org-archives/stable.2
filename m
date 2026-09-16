Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593072DC792
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570029; cv=none; b=p7WLH7yMKLdhfDA5QfMidLNhJ1CBYaL3LGg/p2KVsxTogWQB8FhkJlvJ59He0C53+wN1NR0A5x/SmEu7n1NBRkuP6+ussT2QWi+04MP8GxP39fr9R6I5S+gK58BTo2JnBhShT11/RoDLUKNipYIV2HlE8dABhDz3drWIrD4d86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570029; c=relaxed/simple;
	bh=ZyEgeqrmj/4VPpxeZQ8HanuvLx83KqmUKGlFYw610XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfkSvYqMXrHdVCFIZe5nb14khuyNVg0ua/iurYaAvKItp+yC6/o9hnyrqLumdmP0qDRwpYMewu5ENv6tMdmfwNBgnVinr1cefuxnW+lnxFqqxz6Hw1hyPdcEiGoqTF0i+ixtyRflrDW6Jqfclf9n4wcPPWF1Dg4auY1DbkbgHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+HDR9Xo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+HDR9Xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577F51F000FF;
	Wed, 16 Sep 2026 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789570027;
	bh=Z2rQ1L7Sb25HTZUvitDHbpcMKj8TuSQcOS0QQcKde74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+HDR9XoFv+Z0Oct42oeB8Vef8SL94+fQkTsdj9qptiWvb3gSjnFAViacaxt+GcKq
	 FjPaCYLucgQThchEAv4wYk81TUZXsHX1OhoGJWx0Z+uLBHXFYaW9tgcRsbRYygMMnW
	 H164nmk/pDR+Duup16G98jjcDHxsoUyMzR1S6DdJ7tPIjbU1//R73fZRdndSdQI1Vg
	 MmOcAEgVnu3yH4o32LkG9UM1Fi/H0FqLNNdv2m86GfRkqfbNrAsS/Z5dXa3Y7q8Rzs
	 0EMXwja6slrPf0l+NVnFosDe8ebJlbtDTtWT82pTGd3iTpITrytQMNKs0Ioud+6zW+
	 Qc18aSN/EOmYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] x86/mm/pat: Convert split_large_page() to use ptdescs
Date: Wed, 16 Sep 2026 10:47:03 -0400
Message-ID: <20260916144705.3627256-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091615-lankiness-vowed-5e5d@gregkh>
References: <2026091615-lankiness-vowed-5e5d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

[ Upstream commit e751303e0ad2e998f421d104193f6904df3516d1 ]

Use the ptdesc APIs for all page table allocation and free sites to
allow their separate allocation from struct page in the future.

Update split_large_page() to allocate a ptdesc instead of allocating a
page for use as a page table.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Link: https://patch.msgid.link/20260303194828.1406905-5-vishal.moola@gmail.com
Stable-dep-of: d5d8b8662e6e ("x86/mm/pat: Acquire init_mm read lock on attribute changes to avoid UAF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index de74be2e69bf7..3621532fccb61 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1125,9 +1125,10 @@ static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
 
 static int
 __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
-		   struct page *base)
+		   struct ptdesc *ptdesc)
 {
 	unsigned long lpaddr, lpinc, ref_pfn, pfn, pfninc = 1;
+	struct page *base = ptdesc_page(ptdesc);
 	pte_t *pbase = (pte_t *)page_address(base);
 	unsigned int i, level;
 	pgprot_t ref_prot;
@@ -1232,18 +1233,18 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 			    unsigned long address)
 {
-	struct page *base;
+	struct ptdesc *ptdesc;
 
 	if (!debug_pagealloc_enabled())
 		spin_unlock(&cpa_lock);
-	base = alloc_pages(GFP_KERNEL, 0);
+	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 	if (!debug_pagealloc_enabled())
 		spin_lock(&cpa_lock);
-	if (!base)
+	if (!ptdesc)
 		return -ENOMEM;
 
-	if (__split_large_page(cpa, kpte, address, base))
-		__free_page(base);
+	if (__split_large_page(cpa, kpte, address, ptdesc))
+		pagetable_free(ptdesc);
 
 	return 0;
 }
-- 
2.53.0

