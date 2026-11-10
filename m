Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273418;
	b=1NEkxCzDhXg/06jMkvKwm0F1kDKWrEACFjTte+6a3hcdfgwIt4490TIqi7jLmjsk5VRI
	 0cjj/KvVF5gyz9qoxDUyhSh+18nvD8JEZekXZcc930j+odvhNz+S0V03xc066bdCfij0k
	 C0FZ7WvEGi354CjCii1gsOEimtBRkvbMajUCGrArIQ8JMJI6OyZtucup0uzTqG74YRyaN
	 V3e/A5B6BgvZzc172EN/dVT9QX0OGLPNURBwTZ9up8CGu0Pwf0Bx0oGSDACe7Tsa4ptA6
	 DI6zpsQnGvE60p0Rvzf0h6pA9NVIZjzdAftitjR3iWh9lObNSPLYirRWmhDTNqXsDPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273418;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f8TgK5pn3+yajVL20FWgJBjxSyG83wn4UUJrYTm4c7s=;
	b=hsOnUSwfnNdbObEG9nfIGkS0gUg0FJvt4EWN2bK5nAaFgJJ7ZB3TdSBhuf/H3BNND6Vv
	 QO7i7c3QVcwQRNRizWusJtYLNFtOFNq9QSr2+oiSH914EBp8Ay6Hb1EgsXQOesQeYlWQT
	 cldf8rxNixQpXpWrJjJVYllkdQCrXjGIGKPrMSLZmP3xH6zwvOslP+CW0z4jrcNfMO1lN
	 mcb3FU1ZPPALkBRkW70CA6RMgfq2peNRiLs4UsXsbSAr2vSzvEnFppbZ9ydSz5R/px366
	 JMjqCYoYAH7OyIAkBMGdyKuAyxl7HlRm3ND25GM0lNLIhUKRCXuSz+3oT0GnDMa9nCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jx80Ohdl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF74606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jx80Ohdl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334641F0089F;
	Tue, 10 Nov 2026 01:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273418;
	bh=f8TgK5pn3+yajVL20FWgJBjxSyG83wn4UUJrYTm4c7s=;
	h=From:To:Cc:Subject:Date;
	b=Jx80OhdlhqEqvmZxg1Lo9i7D6OHBF4f38jEN4ZidpHKARhs0DUgnCoN3G2cD3LSQn
	 SAnzWYC8gxGaZcYAwbcSq47Mp+R7Bds/A22S9seTc4tIsrx6TjDpzjrS/pue3HkpyV
	 KixsvPTXUvO7sR5fWXib7/XfDFw6q46W+xvKrfl6XyQvlPeenGc8TQVM5clGyMTpJN
	 sH+3VfgpxDDOkzrRyKR3dRjuO6Q1zH6wTWYAyHXKu8mX0pwCmsab2kI6KL7QkTW1lL
	 OQdMR33LAhIJPFPCfORhRlSHNK6iWtmyIvA/1f2qBVPA6C8pvIiY4NyQCyTHiqPYfc
	 HZWMiolRow1PA==
From: Sasha Levin <sashal@kernel.org>
To: lizhe.67@bytedance.com,
	david@kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	peterx@redhat.com,
	rppt@kernel.org,
	azpijr@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix mremap deadlock when PMD sharing is possible" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:16:55 -0500
Message-ID: <20261109201655-failed-6.1-92daa8652f88@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 92daa8652f88c8cfc05f4899a8408a04b02f211e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201655-failed-6.1-92daa8652f88@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 92daa8652f88c8cfc05f4899a8408a04b02f211e Mon Sep 17 00:00:00 2001
From: Li Zhe <lizhe.67@bytedance.com>
Date: Thu, 22 Oct 2026 11:45:43 +0800
Subject: [PATCH] mm/hugetlb: fix mremap deadlock when PMD sharing is possible

move_hugetlb_page_tables() holds the mapping's i_mmap_rwsem for
write while moving hugetlb PTEs. This prevents races with truncation
and protects huge_pmd_unshare(), but the move loop must not call
helpers that can acquire the same rwsem for read.

huge_pte_alloc() can do that when the destination can use PMD
sharing: it may call huge_pmd_share(), which takes i_mmap_rwsem for
read while searching for a shareable PMD table. Calling it while the
move path already holds i_mmap_rwsem for write can deadlock.

Avoid that path for PMD-sized hugetlb mappings that can use PMD
sharing. Instead of allocating or sharing the destination page table
while moving, zap the source range and let the destination fault path
populate or share the PMD lazily.

Reuse the hugetlb unmap logic for the source-side zap by splitting
the core loop out of __unmap_hugepage_range(). The wrapper keeps the
existing tlb_start_vma(), tlb_end_vma() and huge_pmd_unshare_flush()
behavior, while move_hugetlb_page_tables() can reuse the unmap loop
with its existing mmu_gather.

Link: https://lore.kernel.org/20261022034543.51226-4-lizhe.67@bytedance.com
Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/hugetlb.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8995f4cc4e65d..ec05e8c1d1f85 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -137,6 +137,10 @@ static int __huge_pmd_unshare(struct mmu_gather *tlb,
 		bool check_locks);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, bool take_locks);
+static void hugetlb_unmap_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, unsigned long start,
+				unsigned long end, struct folio *folio,
+				zap_flags_t zap_flags);
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
@@ -5227,6 +5231,8 @@ unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
 		const unsigned long offset_to_last_entry =
 			(old_addr | last_addr_mask) - old_addr;
+		const unsigned long offset_to_last_dst_entry =
+			(new_addr | last_addr_mask) - new_addr;
 
 		src_pte = hugetlb_walk(vma, old_addr, sz);
 		if (!src_pte) {
@@ -5243,6 +5249,24 @@ unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
 			continue;
 		}
 
+		/*
+		 * Avoid entering the destination PMD sharing path while holding
+		 * i_mmap_rwsem for write. Leave destination page table
+		 * population to the fault path, which can share the PMD lazily.
+		 */
+		if (sz == PMD_SIZE && want_pmd_share(new_vma, new_addr)) {
+			const unsigned long unmap_size =
+				min(old_end - old_addr,
+				    offset_to_last_dst_entry + sz);
+
+			hugetlb_unmap_range(&tlb, vma, old_addr,
+					    old_addr + unmap_size, NULL,
+					    ZAP_FLAG_DROP_MARKER);
+			old_addr += unmap_size - sz;
+			new_addr += unmap_size - sz;
+			continue;
+		}
+
 		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
 		if (!dst_pte)
 			break;
@@ -5262,9 +5286,10 @@ unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
 	return len + old_addr - old_end;
 }
 
-void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-			    unsigned long start, unsigned long end,
-			    struct folio *folio, zap_flags_t zap_flags)
+static void hugetlb_unmap_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, unsigned long start,
+				unsigned long end, struct folio *folio,
+				zap_flags_t zap_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	const bool folio_provided = !!folio;
@@ -5282,13 +5307,6 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	BUG_ON(start & ~huge_page_mask(h));
 	BUG_ON(end & ~huge_page_mask(h));
 
-	/*
-	 * This is a hugetlb vma, all the pte entries should point
-	 * to huge page.
-	 */
-	tlb_change_page_size(tlb, sz);
-	tlb_start_vma(tlb, vma);
-
 	last_addr_mask = hugetlb_mask_last_page(h);
 	address = start;
 	for (; address < end; address += sz) {
@@ -5417,6 +5435,15 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		if (folio_provided)
 			break;
 	}
+}
+
+void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end,
+			    struct folio *folio, zap_flags_t zap_flags)
+{
+	tlb_change_page_size(tlb, huge_page_size(hstate_vma(vma)));
+	tlb_start_vma(tlb, vma);
+	hugetlb_unmap_range(tlb, vma, start, end, folio, zap_flags);
 	tlb_end_vma(tlb, vma);
 
 	huge_pmd_unshare_flush(tlb, vma);
-- 
2.53.0




