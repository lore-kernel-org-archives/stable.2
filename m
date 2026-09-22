Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCDA474263
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099489; cv=none; b=XMcbfYNHyEor8RnwanBAru8p1ycmnQGcNnG5Kp3n4HD5UA2CXbiAXNFvPlDvUYasYSRMe2bSnFLokIBwSo1XVmpUnd7s7XlWks+Ly+LM1T9U+xbrVwOO7Mo30VuQpBexrBK1rC/g2YzA0OzoEzO3oJ6MDSobPak7BWoX/4+zkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099489; c=relaxed/simple;
	bh=d2QipPiY+f8bW+gNF/XK4oUXaRotUgnnfobteaGwyak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZmCq7NZipI6WqFs13kcmUqPfcK9ZrEVN03DzEgqGZMMmz4K8ExUuX9IA2FGFDt9+TJVB3VqVuXzxfombm9ml9PuxfVIHJjBHOfNyg8iQYLZn3DCuQt1NJCdgd//QBtSVpe1COBLOkmBBNZJuX7JuN9MksV0EIJco3WJUoRP61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCkLG2wI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCkLG2wI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9A81F000FF;
	Tue, 22 Sep 2026 17:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099487;
	bh=Br4icqGibpVgNbl30N8eKWJ2aJdXrQ/KM2yzBFb0isY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UCkLG2wI7ahrjmnwLuzL5Kz3D8UlV6TNeY3N9UGztbw1bGXbDrq21D+oP+J+ZPZ6M
	 ygAIsgl0ng+5ECYk+GadzYwPnco1927sKPTNLFs4XUIHHgt1iWJX+pyGirgONfaHed
	 OiR6gVxhlhhxUtF3W0hJibB/vNcaMmjrel9ihrj+2wpUiof6SSxVhcip23r0hUBNEP
	 8JALsm8iqW+cXn4FKHr5V8xnh4hl2Gd7A4slCNVaz8sgtvUGv6HbtGLkKTeAJcasy2
	 aN0cfmITqbBqqVscKt03f/NqU/c0J9f/DUqmMWsD7RB84FNHJZiWUrPxVrjA5eTkYt
	 NOzoBAE5uu9TA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] dma-debug: refactor to use physical addresses for page mapping
Date: Tue, 22 Sep 2026 13:51:24 -0400
Message-ID: <20260922175125.3309960-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092252-playlist-affected-d683@gregkh>
References: <2026092252-playlist-affected-d683@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit e9e81d86fee63c6d5757841ab557019ddf73786f ]

Convert the DMA debug infrastructure from page-based to physical address-based
mapping as a preparation to rely on physical address for DMA mapping routines.

The refactoring renames debug_dma_map_page() to debug_dma_map_phys() and
changes its signature to accept a phys_addr_t parameter instead of struct page
and offset. Similarly, debug_dma_unmap_page() becomes debug_dma_unmap_phys().
A new dma_debug_phy type is introduced to distinguish physical address mappings
from other debug entry types. All callers throughout the codebase are updated
to pass physical addresses directly, eliminating the need for page-to-physical
conversion in the debug layer.

This refactoring eliminates the need to convert between page pointers and
physical addresses in the debug layer, making the code more efficient and
consistent with the DMA mapping API's physical address focus.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
[mszyprow: added a fixup]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/56d1a6769b68dfcbf8b26a75a7329aeb8e3c3b6a.1757423202.git.leonro@nvidia.com
Link: https://lore.kernel.org/all/20250910052618.GH341237@unreal/

[5.15 dependency adaptation]
Keep only the PhysHighMem helper needed by b7d7914a9ae3. Use
pfn_to_page(PHYS_PFN(addr)) because this tree has no generic phys_to_page.
Drop the DMA-debug refactor, its declarations, callers and documentation:
5.15 still stores pfn/offset and lacks DMA_ATTR_MMIO, the noncoherent debug
entry type, and the newer DMA mapping instrumentation. None is needed by
the target's swiotlb fix.

Prepare the target's overlapping swiotlb context by caching the existing
linear pool address in io_tlb_mem.vaddr during the common initialization
path and using the upstream pool-relative expression in swiotlb_bounce.
Move the highmem-copy comment below the declarations. These changes
preserve the existing mappings and let the unmodified target cherry-pick
cleanly without pulling in the newer swiotlb pool infrastructure.
No functions are added; the adjusted-address fix remains in the target.

[ sashal: Reduced backport -- upstream e9e81d86fee63 touches 5 file(s), this
  backport carries 3. Not backported here:
  Documentation/core-api/dma-api.rst
  kernel/dma/debug.c
  kernel/dma/debug.h
  kernel/dma/mapping.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: b7d7914a9ae3 ("swiotlb: use the adjusted address for the highmem page lookup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/page-flags.h | 1 +
 include/linux/swiotlb.h    | 2 ++
 kernel/dma/swiotlb.c       | 5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fbfd3fad48f21..57491cbd641b3 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -405,6 +405,7 @@ PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
 #else
 PAGEFLAG_FALSE(HighMem)
 #endif
+#define PhysHighMem(__p) (PageHighMem(pfn_to_page(PHYS_PFN(__p))))
 
 #ifdef CONFIG_SWAP
 static __always_inline int PageSwapCache(struct page *page)
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 569272871375c..4696681115820 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -73,6 +73,7 @@ extern enum swiotlb_force swiotlb_force;
  * @end:	The end address of the swiotlb memory pool. Used to do a quick
  *		range check to see if the memory was in fact allocated by this
  *		API.
+ * @vaddr:	The virtual start address of the swiotlb memory pool.
  * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
  *		@end. For default swiotlb, this is command line adjustable via
  *		setup_io_tlb_npages.
@@ -92,6 +93,7 @@ extern enum swiotlb_force swiotlb_force;
 struct io_tlb_mem {
 	phys_addr_t start;
 	phys_addr_t end;
+	void *vaddr;
 	unsigned long nslabs;
 	unsigned long used;
 	unsigned int index;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 59d44d8f6161d..87e1e092c58a3 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -184,6 +184,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	mem->nslabs = nslabs;
 	mem->start = start;
 	mem->end = mem->start + bytes;
+	mem->vaddr = vaddr;
 	mem->index = 0;
 	mem->late_alloc = late_alloc;
 
@@ -371,7 +372,7 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
-	unsigned char *vaddr = phys_to_virt(tlb_addr);
+	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
 	unsigned int tlb_offset, orig_addr_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
@@ -405,12 +406,12 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	}
 
 	if (PageHighMem(pfn_to_page(pfn))) {
-		/* The buffer does not have a mapping.  Map it in and copy */
 		unsigned int offset = orig_addr & ~PAGE_MASK;
 		char *buffer;
 		unsigned int sz = 0;
 		unsigned long flags;
 
+		/* The buffer does not have a mapping.  Map it in and copy */
 		while (size) {
 			sz = min_t(size_t, PAGE_SIZE - offset, size);
 
-- 
2.53.0

