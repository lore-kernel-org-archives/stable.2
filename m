Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621752;
	b=fOAyOoljOdBzCXD9BgKCn6irdSHdkmZ6IwqsvVELmFv/AGX80E69Eufp5XirPRQcFfXz
	 pki1GdSfB4W8kMTJzvJwG6CArQVrIVKY9dDr0zAiVuPH+5T7gJl00MotC53K+XanQuncT
	 vGMmVbJbPdrPIaLzt6tcFon8BbHLLcHWrjAxQdRTolTXuUkK/O4EgjeV9H6rxsFahSfkD
	 ACaKjSOZBvuCUhjjJwPzT6byM5kx9lmjkMcyB4AB4+mKQAqz2p+FyndvgVtCOOaw2l4ck
	 DbSarKEjOpMnyuTa8ZollWjvgdkO5bptYQOxgJWSxENI+Q65BCBKMjeOhMJ0zOksZrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621752;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JArOqiEtRII0TMVgOdCRi3ObeS3HL32v+b04cIgxYZ4=;
	b=iXkRoq69kA6TmDhchwJiniSjoCyCIjyBMbccjvZPT0WtNhm8GtV4CnNuGdFKaQENTPZx
	 kZBb1TB5L6fY0FNAAkpoM0rFQI0w8aE/sLbaoHOxjlPnZ2mJ6mtvJajo2t6abVBxXpTwZ
	 ugofFuEq6BoJIfZlCnej7adOC5z0xrdKu+jPOFGCjLDsU+zMLz9Y3TBnSsLUOr442JgOb
	 XStBv40vRy1mBmysF6vx7pZvSOMKAlhYbsvNYT7WQzEJom91oGcigrpW8o7YuWz5Y4SuD
	 6QTYb5NOGc3A+ccKCQ7kdFBRHDT1cefkhzbieH0CfO9MPwZbvi8jexwSQ6aT8of/+dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCXjI8iU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC4F606A321;
	Wed, 25 Nov 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCXjI8iU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5651F000C4;
	Wed, 25 Nov 2026 15:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621752;
	bh=JArOqiEtRII0TMVgOdCRi3ObeS3HL32v+b04cIgxYZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JCXjI8iUjpAWK4zdPu337qhqC8H0f1ZqfPxpKJAww3W9ULkEdWevSJvhB4YrxDqCe
	 8U+EHBXpSmg6dLunr3QAg5QtzO0c0EuVatpy+jSO8OINH3YCRpJ4yS9slTUhvepcZH
	 gWmNL/VAjraWgkh+mD4nzzR/G6XzIyNd1+sYKWzcMHASMY098ACTkAk1LHL5q4vfPe
	 X9E0Fxd7Op5bjVd3fiUZL1ZzQmalxdExbOlTJz/nM4vi6pEP4c5fNTLSt96KJBi4d6
	 qAI7JZ3jei2yDg/VgVm9JomO6MhH3uVK35nOGqsoakAQVm25RBMSHFSUgh6CtAgouL
	 nsfGzoujbUOjg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 25 Nov 2026 15:48:49 +0000
Subject: [PATCH v3 1/4] mm: update walk_to_pmd() to explicitly return an
 error
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-huge-pfnmap-fault-races-v3-1-bbc44489341b@kernel.org>
References: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
In-Reply-To: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
 Roman Kisel <romank@linux.microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Naman Jain <namjain@linux.microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>
Cc: ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 "T.J. Mercier" <tjmercier@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2608; i=ljs@kernel.org;
 h=from:subject:message-id; bh=exnJ13XewIuI40LjK8x5qure1OWqXB+8p5QwkZysSkk=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLZmTMjjj10T2n+lPzMc0r8Xt8HC2OP9Nv7nTncPu+ry
 gWTbn+NjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEykq5fhnzlrfKPVimen8q9u
 P6Xwpne1bVSz7gnleU4nel7uf1wgbcHwv46PudxmwvVDT1tql7sIRdx6FL53Z0vGUUHhHz4T1l7
 dxAQA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Rather than callers inferring an error from a NULL pmd return, explicitly
return error codes.

This allows different error codes to be returned for different failure
conditions.

No functional change intended.

This is a prerequisite for the fix to insert_pfn() which follows, as that
needs to be able to tell a failure to allocate a page table apart from a
race with a huge fault, so mark it for stable alongside that fix.

Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
Cc: stable@vger.kernel.org
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/memory.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3a20d64fd276..67ee25215ca5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2366,7 +2366,7 @@ void zap_special_vma_range(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL_GPL(zap_special_vma_range);
 
-static pmd_t *walk_to_pmd(struct mm_struct *mm, unsigned long addr)
+static int walk_to_pmd(struct mm_struct *mm, unsigned long addr, pmd_t **pmdp)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -2376,24 +2376,25 @@ static pmd_t *walk_to_pmd(struct mm_struct *mm, unsigned long addr)
 	pgd = pgd_offset(mm, addr);
 	p4d = p4d_alloc(mm, pgd, addr);
 	if (!p4d)
-		return NULL;
+		return -ENOMEM;
 	pud = pud_alloc(mm, p4d, addr);
 	if (!pud)
-		return NULL;
+		return -ENOMEM;
 	pmd = pmd_alloc(mm, pud, addr);
 	if (!pmd)
-		return NULL;
+		return -ENOMEM;
 
 	VM_BUG_ON(pmd_trans_huge(*pmd));
-	return pmd;
+	*pmdp = pmd;
+	return 0;
 }
 
 pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
 		      spinlock_t **ptl)
 {
-	pmd_t *pmd = walk_to_pmd(mm, addr);
+	pmd_t *pmd;
 
-	if (!pmd)
+	if (walk_to_pmd(mm, addr, &pmd))
 		return NULL;
 	return pte_alloc_map_lock(mm, pmd, addr, ptl);
 }
@@ -2532,13 +2533,11 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 	unsigned long curr_page_idx = 0;
 	unsigned long remaining_pages_total = *num;
 	unsigned long pages_to_write_in_pmd;
-	int err = 0;
+	int err;
 more:
-	pmd = walk_to_pmd(mm, addr);
-	if (!pmd) {
-		err = -ENOMEM;
+	err = walk_to_pmd(mm, addr, &pmd);
+	if (err)
 		goto out;
-	}
 
 	pages_to_write_in_pmd = min_t(unsigned long,
 		remaining_pages_total, PTRS_PER_PTE - pte_index(addr));

-- 
2.56.1

