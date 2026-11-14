Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633400;
	b=HR2LzSwPYn0fCbSZXVee5e7XD5TxkvvNGRbPniuSen2We2wFIFir+a0Rz8oVMR8Pev+O
	 itfPQ1Hx0S/HeSNmywhQc/MKMHTiOAqMCxAN6toZ/qyFtdmN1pft3yeleQo9ztmVaQpPd
	 IbKTmLefK9RTYG05qlfDcp6QJnzuHFzUHrXDV0WKTurC1AjdfIIzzMN8GgVlrG+sNMpbR
	 59hOjYT9Zx+2GN/mQHxTOSkDd2h9a8ZbHWp8BGS0SRfx/mOe3zrYrGe7UEXTVPN27YOq6
	 BlSxK83QmA3RV24fip1yk4WI0JWqqrvSaaV+L5eCk5fRY0V4sGoDkE46SRneozKa+XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633400;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pSMJfvXaskHo2X9v8Fbo7eLwVGzn6cwOuJDSszrhNOM=;
	b=0qHE8Bkov/7Z7qffBVpqBofsZZZC0QNzrBFF1QF+nJhoy3V39bDZ6BOEm0hKygAfRHGt
	 0s9U5eRTVEUrVLGR7k1n9EXn9vSiROSKlD5KpZjI3IYDPs2NmyYJVLll6dIVocaY8MblU
	 2m2aqZPgDwKZnHVAH8t7eeuGgW0Yv9xi+JqIEyv5j35eGtRbdlMBVI8w4IbfXskBUep3T
	 yJBQX04+yoS1IH5dPvtNKPfOkRDx/iRp45dvKvFGOkxirRIVJLBlEpEe5K7dtQT7zXrpR
	 HlBnKz7J8BNg81Hnlc7rd2PYK2bD5muLTzdKV1x5y0eiwbI6Jc9g8St23e9XUp/siyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDC2rCGz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4098606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDC2rCGz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF261F000C4;
	Sat, 14 Nov 2026 05:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633400;
	bh=pSMJfvXaskHo2X9v8Fbo7eLwVGzn6cwOuJDSszrhNOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FDC2rCGzeT6sRwqDdt7dPt2aF3yyckZJfH5eHrFgCZWtDVLXBdybfThu3kfguM/HB
	 37vMYfBiEeccZkKqwiZXV5vbFa/5eETmT1qCOi6zxpQhHQI+Ogttg/P7nkPfsOop3E
	 wAxxFyvRo/OEVfEqHWokRrtmx71GsnAX5nfC46knk5EKK7bRmZxZevGB1+Hf9dsNsb
	 x/3IrwxoCNUdIodRN7NSw9S6AtFYQjaS9TUoFyML4/G+kKuWq3JuO5u0Jha/PfPAKL
	 PUyfczXpgVnpBc54vt1EQWz6SqW26D79n8b+hXhsP+XoTdGd/2Is0kY+T/gZG7qr9b
	 NsS+mcqLXtkow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Lance Yang <lance.yang@linux.dev>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/huge_memory: properly handle refcounted PUD mappings on fork
Date: Sat, 14 Nov 2026 00:16:38 -0500
Message-ID: <20261114051621.3049515-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200317-failed-6.18-d90bdc02e36e@kernel.org>
References: <20261109200317-failed-6.18-d90bdc02e36e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit d90bdc02e36ec08d8248ebc6cdc52e12043eb28c ]

copy_huge_pud() copies device-DAX entries without taking a folio reference
or updating mapcounts and the child's RSS.

For example, MADV_GUARD_INSTALL sets VM_MAYBE_GUARD on a device-DAX VMA,
forcing copy_page_range() to traverse the whole VMA on fork. Any remaining
huge PUDs are then copied without accounting for the new mappings.
Unmapping them in the child decrements accounting that was never added.

Use vm_normal_page_pud() to identify refcounted mappings. Take a folio
reference and add the child's PUD rmap and RSS accounting before installing
the copied entry. Pass src and dst VMAs consistently instead of src and
dst MM. Move the TODO.

Fixes: aed877c2b4257 ("device/dax: properly refcount device dax pages when mapping")
Cc: stable@vger.kernel.org
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-11-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: changed vma_is_cow_mapping(src_vma) to is_cow_mapping(src_vma->vm_flags) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/huge_mm.h |  5 ++---
 mm/huge_memory.c        | 27 +++++++++++++++++++--------
 mm/memory.c             |  4 +---
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b55a4a342f578..c6befc9fddf12 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -12,9 +12,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
 void huge_pmd_set_accessed(struct vm_fault *vmf);
-int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
-		  struct vm_area_struct *vma);
+int copy_huge_pud(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+		pud_t *dst_pud, pud_t *src_pud, unsigned long addr);
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 24f5887eb48ee..73e7c6d4726e7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1911,11 +1911,13 @@ void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pud(vma, addr, pud);
 }
 
-int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
-		  struct vm_area_struct *vma)
+int copy_huge_pud(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+		pud_t *dst_pud, pud_t *src_pud, unsigned long addr)
 {
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
 	spinlock_t *dst_ptl, *src_ptl;
+	struct page *page;
 	pud_t pud;
 	int ret;
 
@@ -1928,11 +1930,20 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (unlikely(!pud_trans_huge(pud)))
 		goto out_unlock;
 
-	/*
-	 * TODO: once we support anonymous pages, use
-	 * folio_try_dup_anon_rmap_*() and split if duplicating fails.
-	 */
-	if (is_cow_mapping(vma->vm_flags) && pud_write(pud)) {
+	page = vm_normal_page_pud(src_vma, addr, pud);
+	if (page) {
+		struct folio *folio = page_folio(page);
+
+		folio_get(folio);
+		/*
+		 * TODO: once we support anonymous pages, use
+		 * folio_try_dup_anon_rmap_*() and split if duplicating fails.
+		 */
+		folio_add_file_rmap_pud(folio, page, dst_vma);
+		add_mm_counter(dst_mm, mm_counter_file(folio), HPAGE_PUD_NR);
+	}
+
+	if (is_cow_mapping(src_vma->vm_flags) && pud_write(pud)) {
 		pudp_set_wrprotect(src_mm, addr, src_pud);
 		pud = pud_wrprotect(pud);
 	}
diff --git a/mm/memory.c b/mm/memory.c
index e37ae367c8c19..a24e990583be1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1416,7 +1416,6 @@ copy_pud_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	       unsigned long end)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
-	struct mm_struct *src_mm = src_vma->vm_mm;
 	pud_t *src_pud, *dst_pud;
 	unsigned long next;
 
@@ -1430,8 +1429,7 @@ copy_pud_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, src_vma);
-			err = copy_huge_pud(dst_mm, src_mm,
-					    dst_pud, src_pud, addr, src_vma);
+			err = copy_huge_pud(dst_vma, src_vma, dst_pud, src_pud, addr);
 			if (err == -ENOMEM)
 				return -ENOMEM;
 			if (!err)
-- 
2.53.0

