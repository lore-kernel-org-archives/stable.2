Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08A53D9E0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084465; cv=none; b=fQYYonjLfTfawT2Bk9zzsVVEc1mDzsBmjtPtyRF0xA6BMU5Zi2BGO1lkwQew6XCOJhH1FP0k3kZDq+55ecqgVZu4r3v+lbcjuzIgRqs7oyKeqBbVeEwKKkAKxWPylxLeqr1yVtM/fGTMnvbSOtb8nPuFe1FM2IfXd9xjyNoI7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084465; c=relaxed/simple;
	bh=VNd/w0rdWoKn4PiF1MmL6ep5QBYu27S1PybX5ZmzlNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwGvkDOKnF0zqYS4kkPc0hYJEocBE+ZYm0AQYh+17FRa2TJq/FgW33A683g90DJcBO4uqRD5Y619JFPnT0iuoZ5xoljvM9pn4LfCmn2VC8elXQPaqji/C8zwx81DI/kPYm66UnV2KYe7zJVqzU9TiPKWyTlLjKn6PCxXeQaRnjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omMSrqHH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omMSrqHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2159E1F00893;
	Tue, 22 Sep 2026 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084463;
	bh=DMTcbDWw70AEKi6yWKwBTs8LxZMBbakZ+xqLEaRRye8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=omMSrqHHMN9mpIK59Hhs9NJXjiNDb7CyQpAVaecQEh7rnkYL7L8huUtVvwWp7BtQe
	 x/fQyYem7E7G1unLUOdS+eHTQokcRcTZQXpkC32nt9kCC96467mfpKU/b9IP5w5M4m
	 HeSYW3CrYA1G5puAm23OUd5f31bOu4971vV8O3MJ2PzNcQGLEQqggBPOSCVsiQnZ+y
	 iPecPOCLfMfQ1kBBpIr1beuSPccH4MfJ6fQHiN+TcVYyikCEOij+Yq0NFk0OzVRGCE
	 UqfcAB/3fp8ZKwc/k5lCDhSkPm4Al4nhCroEvpacS9dH8aHWr5aHank+Nk7jMbrkG5
	 r8bCo3QKOghnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] swiotlb: use the adjusted address for the highmem page lookup
Date: Tue, 22 Sep 2026 09:41:01 -0400
Message-ID: <20260922134101.2504282-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092245-shallot-entrap-77a4@gregkh>
References: <2026092245-shallot-entrap-77a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

[ Upstream commit b7d7914a9ae3097e63d113007e4fb44d33d515b1 ]

swiotlb_bounce() reads the page frame number from the slot's recorded
orig_addr, then advances orig_addr by tlb_offset to reach the address
the caller asked about. The highmem branch mixes the two: the offset
within the page comes from the adjusted address, the page from the value
before it.

Once the adjustment crosses a page boundary the pair no longer describes
one location, and the whole copy lands one page below the intended one
for a positive tlb_offset, one above for a negative one. DMA_FROM_DEVICE
writes the device data over the wrong page and leaves the intended one
stale, DMA_TO_DEVICE feeds the device from a page the mapping may not
cover. Partial syncs through dma_sync_single_range_for_*() are what make
tlb_offset non-zero.

The branch test is picked the same way, so a slot recorded in lowmem can
be adjusted into highmem and the lowmem path then hands a highmem
address to phys_to_virt().

Take both from orig_addr once it is final and keep pfn in the branch
that uses it. PhysHighMem() asks the question straight from the address,
as dma-debug already does.

Fixes: 5f89468e2f06 ("swiotlb: manipulate orig_addr when tlb_addr has offset")
Cc: stable@vger.kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/20260905084210.148255-1-donggeunyoo.kernel@gmail.com
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
[ Replaced unavailable PhysHighMem(orig_addr) with PageHighMem(pfn_to_page(PFN_DOWN(orig_addr))). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0968155a638e3..d615d2ec47bae 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -868,7 +868,6 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
-	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
 	unsigned int tlb_offset, orig_addr_offset;
 
@@ -902,7 +901,8 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 		size = alloc_size;
 	}
 
-	if (PageHighMem(pfn_to_page(pfn))) {
+	if (PageHighMem(pfn_to_page(PFN_DOWN(orig_addr)))) {
+		unsigned long pfn = PFN_DOWN(orig_addr);
 		unsigned int offset = orig_addr & ~PAGE_MASK;
 		struct page *page;
 		unsigned int sz = 0;
-- 
2.53.0

