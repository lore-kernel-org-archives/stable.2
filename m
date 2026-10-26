Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056881;
	b=rAhe7PRFggEJkG2Dw5O2D/KdMLUZYRGDSGjW9PJ4T7YxIK1HAKxVLIQWiE9jKOjgkyNP
	 pvt2X8XVxTaYf+OCvyz6khJogP4WGkloaXGAxRWdan40cWFIDTnPtHKiOAWjC4ulUyGsF
	 8aM2nosQ8SSc2oFcXzWZleAceILgFbRkM+1Uguxgb5gQmpRSHk7drxb4d0lEmH6PfJOua
	 gFf2W2glHqV2NBQDZKeQDjtkNAjB8zyPcRE1zE3CdCvU26+E5jVfmndmOHkOofp/rHVGr
	 P8x9MBq2lqmj0vSnbYj1RGTcZe+1Da5gA/ERaeIVZ+UNFM7Eigsgn6vwyoY/zp6mctw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056881;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Sa8tfvVw1l57KNfiSIe1Yios+sToK3uLi/AwjZJQ8/k=;
	b=KH8lhTf2Go+eStHcFLhGd9p9/3OzdVudxoGdLo0jsPnBprS/rAIIgxbJMJ80oKQmrFTF
	 ejmZY46A149p9IEvCcTinBaIx1ZqzG/1SprEP0aRynuKNVyNCUnVd8nvDzlWZ/p3vCKlk
	 zH5A3ntU7IK8TEN7VYBaZgUdI5bqZ5n3OTIJrBaPJUA4zepa2nNDVZH37swa+g6CEpLLi
	 xc2RRzq6f8TqtwrKYEDdwB1hhBb+IJcWWFgcmE6pCDVeGzu81fAOhwEvz/Cxs00oQon3w
	 Epqa/uCcWMq0KxillEh0dZobZ+3v4iC2OHtvfnkK9xoVaNSuMN8zzwHfmolSH4rPqOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="isKtS/2A";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CCB606A31A;
	Mon, 26 Oct 2026 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isKtS/2A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214011F01825;
	Mon, 26 Oct 2026 23:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056880;
	bh=Sa8tfvVw1l57KNfiSIe1Yios+sToK3uLi/AwjZJQ8/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=isKtS/2A5NeaRQguaTYvUDnrgIFDJ17wHL59PMobMO6g7ZHpMetE7kei1Ps/bb1A8
	 xu8Kim7UlEZy2SixWOhdZcUGjChz41ApzfH4YoyAhImQGE0gAIm7Ih+fV60o4n0lO4
	 au5Viyp2kQyAhWJ8Vf1IKb58qD8iTw3kTdFjKBT8sR2Qn0B1S5PGt7goGve+sPNjtw
	 PJ4vGRk87GzyiEoh+gCcqdKSkFh9uR9s0cjDeyAORlo3WZL+RRCPtskfA+aeNUSg9k
	 AVucltVdLCDF9pjdvNZU4izy3JOQFzSQyCkg23um0pmIDKdbJ5Pyi5i+GSDV1lXIV7
	 ryNKJIL0dRfkw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:31 +0100
Subject: [PATCH 11/46] mm/huge_memory: properly handle refcounted PUD
 mappings on fork
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
Message-Id: <20261027-fixes_core-v1-11-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4336; i=david@kernel.org;
 h=from:subject:message-id; bh=f7xOz6s1fqGaUW9pRJrQ/Dq0ncEqYAqNRmBLRgpR3rQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35+ikxnOfLW3cJ+r9Kcba3b/iP8n/sGm/rpQsk3ZI
 v3uKs/wjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACYSuZuR4UfI7J7vjVFP2mQ9
 Cr6e0DVaf80t323DefHZLZ6r7B+c3MjI8G7LP29Dx6glK793rG9a7879mFXy//+1eikfq5jXXZk
 YyQoA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

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
index 5d6d695675bce..0f4db5080e371 100644
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
2.43.0

