Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968603;
	b=bzjyO0NgDFt0HOOm5EYjsyMPhSuv5o6u5SgqUegnuQp9c3cSU6xeWTZyUxqyJiAm2gp5
	 bM2mBiwBLMJ1MHJUB/uSkMl/Yq6mdnLDP2GWVv7Ch7EN0DhhJgYnuxxc5Qzbgc4fDJPvX
	 tsySz9qiMxsXnB/m6CBuwoFqSQ5aZ79B6gR0+Knj1wG/+kFXfJfQ8g1nJ4EsTX3NlmN2T
	 nr7M84eR+EhOmfxV6zzklqitCIVZddSGTK3aEp6qn58K4xmEogi+f37yv3Wk0J65WVUvH
	 1eRgNIfOoUvf60Dw5MZ0ly7PspiuwX0xcS2llUXQjz9juROVxSVa2bUuvhU5EgI6ufA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968603;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=k0OJ5cOJhFxwKRWgLGHa4buWJAMOSgYsz1k8mWUWB34=;
	b=Pj1N2VP3EqrHP5zVqm6+ClGD1YiDsipdOPFOoMdvrxBE0aPRhHXh17ESYWcby9ZeQPlz
	 KD1HmHz9jLmU6p/fQ+Nfa7RKNq8ZF98owWjBH4TlWorImt5+D58792VnzHiHFyPoa+e38
	 6hulONYLcypw3i7ruD6YaP3rQWdGdnMU8VT+LD687w37BlUx+cd/C6gBnRNSUVXJKFXAL
	 jmkhb7KPEiErC48500gxyAqJFfnmlNmQPL24HasSoUZDlTQ1+xlA0gcx3ET+nH6v0XTGw
	 gKfEfmaY0zFxFv9xCgeFaLZnCO77AqZFsfiN3PFFvnyM1AWNBV7vmDFt6TNesl0PkIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCsFJVVW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D8606A326;
	Fri,  6 Nov 2026 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCsFJVVW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B3C1F0089F;
	Fri,  6 Nov 2026 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968603;
	bh=k0OJ5cOJhFxwKRWgLGHa4buWJAMOSgYsz1k8mWUWB34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MCsFJVVWl57i+t+M5XQAOw82JpUNPrrmCyAT97GYiSLGMNTof7En4bso9aSYFK+nh
	 grMauLv1Llt4mhQLU+mYgS7FDOeyfyqKe2tHIwdmWI6ZwDx84zQW0D00ocTfXo6FWB
	 YcVwgKMJslFIG+zqbAhZi+/4+Gi0ZVWi6/HhVd1eeAW1ab3nRFhdNuEuFp/zEFx120
	 BWxRwxRCJ2SuNg0+HnjM8Zs7syWTtl7v1Ue6dUC3kdHpPa5qcUt3fO+P99J7oUga/r
	 6xUABepAxWBkKK0kkJ9Qp2/XVhg4DGv8DgWebHd7TUBSJpMYjFOeYrwt1ojTK1aG/I
	 KQkI5XCQ2AS1Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 06 Nov 2026 13:36:13 +0100
Subject: [PATCH v2 2/2] mm: don't allocate a page table under RCU in
 do_set_pmd()
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
Message-Id: <20261106-khugepaged_set_pmd-v2-2-d2457b5e377a@kernel.org>
References: <20261106-khugepaged_set_pmd-v2-0-d2457b5e377a@kernel.org>
In-Reply-To: <20261106-khugepaged_set_pmd-v2-0-d2457b5e377a@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4428; i=david@kernel.org;
 h=from:subject:message-id; bh=lLTIq2694J3MjH85WnniQQmIlLYoYXSiDFLoKNVlvso=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLenjznuf6+6JY5LZVhOr8lgr60aDZldUyt+HJ3t45fc
 NMb75uFHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzEeBEjw42v63Tqn6+y7s6b
 HvHtprqP7btNIe4XUmx+ac1QVvGXX8vI8C7cw0j5PbNm4OIEj9JJofPjthTO+Zm78iNrWbrSvMd
 3OAE=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

do_fault_around() skips PTE table preallocation when the PMD already points
to a PTE table. A concurrent collapse can then retract that table and
clear the PMD before filemap_map_pages() locks the new PMD-sized folio.

filemap_map_pmd() can then call do_set_pmd() with an empty PMD and no
preallocated table. On PowerPC hash MMU, do_set_pmd() then tries
allocating a PTE table to deposit. But filemap_map_pmd() calls
do_set_pmd() under RCU, so allocating from that context is not good.

This race became possible when retract_page_tables() stopped taking the
mmap and VMA locks. Previously, those locks excluded retraction while
the fault was in progress.

Add a may_alloc argument to do_set_pmd() and pass false from
filemap_map_pmd(), so we can fail with VM_FAULT_FALLBACK instead of
trying to allocate.

This issue should be fairly hard to hit in practice.

Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h |  3 ++-
 mm/filemap.c       |  2 +-
 mm/khugepaged.c    |  2 +-
 mm/memory.c        | 10 +++++++---
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a2dd76cc5bbfe..bd144fec5f5da 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2156,7 +2156,8 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 	return pte;
 }
 
-vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page);
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page,
+		bool may_alloc);
 void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		struct page *page, unsigned int nr, unsigned long addr);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 86297841f9955..9871b4f32a916 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3745,7 +3745,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
 
 	if (pmd_none(*vmf->pmd) && folio_test_pmd_mappable(folio)) {
 		struct page *page = folio_file_page(folio, start);
-		vm_fault_t ret = do_set_pmd(vmf, folio, page);
+		vm_fault_t ret = do_set_pmd(vmf, folio, page, /* may_alloc= */ false);
 		if (!ret) {
 			/* The page is mapped successfully, reference consumed. */
 			folio_unlock(folio);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8d9f05a39afb3..5836e08abc984 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1826,7 +1826,7 @@ static enum scan_result set_huge_pmd(struct vm_area_struct *vma, unsigned long a
 	}
 
 	vmf.pmd = pmdp;
-	if (do_set_pmd(&vmf, folio, page))
+	if (do_set_pmd(&vmf, folio, page, /* may_alloc= */ true))
 		return SCAN_FAIL;
 
 	folio_get(folio);
diff --git a/mm/memory.c b/mm/memory.c
index 421064aef3cf0..6eeed43b05a19 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5682,7 +5682,8 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
 	vmf->prealloc_pte = NULL;
 }
 
-vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page)
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page,
+		bool may_alloc)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
@@ -5723,6 +5724,8 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	 * related to pte entry. Use the preallocated table for that.
 	 */
 	if (arch_needs_pgtable_deposit() && !vmf->prealloc_pte) {
+		if (!may_alloc)
+			return VM_FAULT_FALLBACK;
 		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
@@ -5764,7 +5767,8 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	return ret;
 }
 #else
-vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page)
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page,
+		bool may_alloc)
 {
 	return VM_FAULT_FALLBACK;
 }
@@ -5888,7 +5892,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
 	if (pmd_none(*vmf->pmd)) {
 		if (!needs_fallback && folio_test_pmd_mappable(folio)) {
-			ret = do_set_pmd(vmf, folio, page);
+			ret = do_set_pmd(vmf, folio, page, /* may_alloc= */ true);
 			if (ret != VM_FAULT_FALLBACK)
 				return ret;
 		}

-- 
2.43.0

