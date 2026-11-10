Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272600;
	b=vXAyR2zOFd1Y4Aos0TXl6P6JNNeN6oAF62c9JTf1LBRloDvjN8EG77biu+H0o89Kb1fc
	 Mp+yh4mVl04CNKGP4HCP0fl56+uKRUM78DvKGicHWIxD/+Z7+6Rbp8A037XWXrtLIJJyM
	 BM9KoO3QdYrDbQCZGIjnFXvQJpasKDo0ZqrGuoS0alBGWjBU/fNFdJwV3/7SRCYblN/qO
	 G0s8QhhUWcXrJXjQ5WamuX8JrA0Yoztwz0bdiVcIMN7Pcpffxz3rhyl4Nnj84UK3NxnrH
	 GWLhdUDGIEOyBmuCZXCJP98r2As1ojuwN5Ht8gNLajSH2VW/eDqy2NefZeNSSc4uSOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272600;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0+l6X2gGRtdLNqXILPJFkHjAxkkXOumnt6rxwpVC0Ug=;
	b=a0mxhFWmOk+W+RUlT4HGlfK4uPmg6DzV2eWzqXi9Cro12I5yQyV72B7xgstRYXI9Dpwp
	 w0rMFgUsP0w45qX1btApOGqWKh/E8tgLN2y6iULTAmDG9XKy0TdEHd2u0LJYcYGbQzcXT
	 fUMe3L0CwBUUY7HJq3CoU0w84N5BFJ/4aVXVOX2zvqvGA5ED7Z1JeHnS9mDcmDXmGohuF
	 QujvzcCukqIUVBe2qe0zd55Qr4ymEbcLCXZWaeUcQkwlXFGBDReOVnYYv4G75sJeEqsKn
	 w64t7YyVOLaD4jjkzmJN6V15rwf+XL2W7sN9UNwgKxDz9YQrgLfEVFuixeYze//yzxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pvhpq3md;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B82606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pvhpq3md
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093901F0089F;
	Tue, 10 Nov 2026 01:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272599;
	bh=0+l6X2gGRtdLNqXILPJFkHjAxkkXOumnt6rxwpVC0Ug=;
	h=From:To:Cc:Subject:Date;
	b=Pvhpq3mdTPoOdLsO6f154BEn4xFiRyVSuagxhhLFh9ouS6vyzJYOjKiJWSf5M1DTq
	 rYFcGvqEgNFz//EILHvUh3mKgoVjgxC0HtNIms5khh1z0VnyZvywvHTtrVmJmc06vD
	 sZGyqtCmbZ6w8xTxd2jrrBkWBAJ3gpWK/cAA9EABy0fosjTOasuq34OYM+Dke8biFi
	 rJaYdxYrEkGcPMI02f5oszakMLvdcZnKieD+NwGWT+3FYiASrWDnTl/88iUGOfD5Hl
	 fxvrYgLtsVI8k6dirnKwt3f1uuTlR4yha//gNDciUkaoqjFIQ20DcLMYuwW2sQpz8x
	 axkOcAgrSDH4w==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	ziy@nvidia.com,
	pfalcato@suse.de,
	lance.yang@linux.dev,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/huge_memory: properly handle refcounted PUD mappings on fork" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:17 -0500
Message-ID: <20261109200317-failed-6.18-d90bdc02e36e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d90bdc02e36ec08d8248ebc6cdc52e12043eb28c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200317-failed-6.18-d90bdc02e36e@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d90bdc02e36ec08d8248ebc6cdc52e12043eb28c Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:40 +0100
Subject: [PATCH] mm/huge_memory: properly handle refcounted PUD mappings on
 fork

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
---
 include/linux/huge_mm.h |  5 ++---
 mm/huge_memory.c        | 27 +++++++++++++++++++--------
 mm/memory.c             |  4 +---
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c745f7ad22987..fac05120ab774 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -12,9 +12,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
 bool huge_pmd_set_accessed(struct vm_fault *vmf);
-int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
-		  struct vm_area_struct *vma);
+int copy_huge_pud(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+		pud_t *dst_pud, pud_t *src_pud, unsigned long addr);
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4c0194af9016d..283c4bc8b927c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2072,11 +2072,13 @@ void touch_pud(struct vm_area_struct *vma, unsigned long addr,
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
 
@@ -2089,11 +2091,20 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (unlikely(!pud_trans_huge(pud)))
 		goto out_unlock;
 
-	/*
-	 * TODO: once we support anonymous pages, use
-	 * folio_try_dup_anon_rmap_*() and split if duplicating fails.
-	 */
-	if (vma_is_cow_mapping(vma) && pud_write(pud)) {
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
+	if (vma_is_cow_mapping(src_vma) && pud_write(pud)) {
 		pudp_set_wrprotect(src_mm, addr, src_pud);
 		pud = pud_wrprotect(pud);
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 0fb676dd2bd63..5392bcb1d24d6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1463,7 +1463,6 @@ copy_pud_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	       unsigned long end)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
-	struct mm_struct *src_mm = src_vma->vm_mm;
 	pud_t *src_pud, *dst_pud;
 	unsigned long next;
 
@@ -1477,8 +1476,7 @@ copy_pud_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
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




