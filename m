Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0504C653B
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573758; cv=none; b=ZHbw4zRkIe+WTU6frfBQF2wKRTbuhZwYs5FBIDRLk7wD3w5wmdBu2SosouqEFfqt1H/yQfe7++V+1Ybl6ix52zCy96abJhKuAYSDawhbMM+x/mqrGM7S4hGg7YVL+jnpHBDncmjpj9HUsA04WwTKiPEC/eet8sTrgVh4lwex0cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573758; c=relaxed/simple;
	bh=YHinZzZsfhMdfgzKVEQFY+LDP71NRaiqKe3049c5/vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOO5tZaH1fsPZEPxlssoB6SxF73je43KRe9MZZG+ZByFLScb1f/f5Eks09d4cHLTEZLFii1EXoZp7eSGHq0xEcf0ZoyDfKH4ohUoYQ7TrpMoPlPoX/Y+gXfQJhRZkgks1dl5Yt4uznsQxMKwoFOMwGbymNF2FpXZyaRGRHOEC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLlDTOV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLlDTOV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E661F00893;
	Wed, 16 Sep 2026 15:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573756;
	bh=aW3vBBIIrQSU/JYCBqEZtFU6bGCTt1sIyenICZJOs9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fLlDTOV2Kkr09US7VFzLZbH525j9cZrrgiE+f4PFZiWo/q9vYQ8xPMtCrib4wPpx1
	 qIhGMEMgXq607xge9VhfqhgjF3Jez1pwZHlt1E1AHI1B4mUPAxBshkwYorNL8puQda
	 N/jF+7SfmsSCaY8QJf/tpTxnBPO0RRXwn9gzdRVCoSaNZjqO+YMIA006i+nMzFQ8B8
	 r9wUb+0Ltqu6m//tg2W8vP5BNdDcxd6f4HltW5qtkBAc+6ssYSLjXa/wRwlw6qtIqP
	 mK8V59dw9S51fgf83BekRfa1TML3e9Bx61kbjHryv11l1UcIknHP7X6RcoZzc1SW3Q
	 NvYlT6kX0hxEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] x86/mm/pat: Convert split_large_page() to use ptdescs
Date: Wed, 16 Sep 2026 11:49:11 -0400
Message-ID: <20260916154914.4167599-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091605-rehire-self-1650@gregkh>
References: <2026091605-rehire-self-1650@gregkh>
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
Stable-dep-of: 9e4a3ec3411b ("x86/mm/pat: Allocate split page tables as kernel page tables")
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

