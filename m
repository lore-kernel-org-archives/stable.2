Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CE51AFC6
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082648; cv=none; b=oGptnGhn/K2RO9XzByosGh2z5P4gy2qXruI7C79KPaY4bEggOSIUlwJZTAokYJcQExXATmcPnb7wuvt+2ksFIUbkZtaBBuqlWudQkV5Mx8G3lgVRMfKazoFHd/dVfAcICpbJC7SG59NjIDn4SdX1Z6IY3K96jPgoNpjHq9KnSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082648; c=relaxed/simple;
	bh=y8xpDcUkqgIEezvZv5RCP9BeJqCH19XKvhuSgaaRm6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqDjCH+afBjM0kffZDO4N6x5r4zDLhbfA0PW0FZJdNseQNprl23/RbmmTo+sd7iCaUG0Gzphh/0VuNGgiO1oqKQfXHhAEvff5pumQ1xGfpSR/iImq9996qHic6Yzw6Zaj0VziSDui0x9of5Q23J+hufSy6/3bGHAoEh94nGb9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hsp0NVYK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hsp0NVYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F271F000FF;
	Tue, 22 Sep 2026 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082647;
	bh=069s09UiimGs0EDd19SlHVtR8Q8ocwORXz2CVOTeFOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hsp0NVYKBRYGVy5CowuSrqgfqDuyP3x92vRJlo8UezX62V7ICqk4BSvRvvMr1Dop0
	 wKr3E+H8Zii9gkuEz+i5WPX2GAXDLQEDZg8UKsXhykvujWS3lG/urvda+pTDb0CQly
	 vhwu1ih0O11gisf9zVhNqRoVbt0e1lp688MoLrD28AT8fLTt3yPRJOe4pA5/YrEUrX
	 4pBA9jQq+nmH8KUjhslAoorup0gitOy50XiYcjj0kuwxMVKvRdhVe4FU1ng5RvTJyI
	 svW7rOoGYcRWqsJlDYKNXGvEQq49pne/6iGzYiKLXMlaZICJ/Y+QHEBZdM+L5pVEO+
	 5qTIwjYY6JC1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] swiotlb: use the adjusted address for the highmem page lookup
Date: Tue, 22 Sep 2026 09:10:45 -0400
Message-ID: <20260922131045.2409656-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092244-diocese-pointing-0bdd@gregkh>
References: <2026092244-diocese-pointing-0bdd@gregkh>
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
[ replaced unavailable PhysHighMem(orig_addr) with PageHighMem(pfn_to_page(PFN_DOWN(orig_addr))). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ffb7b021e2fb9..90651d535a923 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -869,7 +869,6 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
-	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
 	int tlb_offset;
 
@@ -899,7 +898,8 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
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

