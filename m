Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C43C454F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089762; cv=none; b=V/PFvmECFO78dLM1E9VuLDIFS34O2FirqNRBk0qRM8vWSPobUPm7u6jDFv2fdYo9tyFrw1TA2soJZJOWwvSOpisrkhu9zAoInjOtFFLkTx7WDhwt0N8DAml5kBveqMRa5CJMJO5xdbN8qX3LNCGHYzY5fwVd5mVbY0zDBQ0xuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089762; c=relaxed/simple;
	bh=abKNX7cqlpAcks9ykFNkY65VMoj5EatSU0FIkanjUr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpztDHVpAU9G0t5B4y99rxtEm4WZXKnVASYlnZiO428nJH/NAUGMOFNmmK2GnPsaXn6nbX+P19JekN+rCBXuBK3B2UfC+/wPDbf3ByKjghKEMLDkWoNGabt2YSbfcThu9cKlNMTF7pZFS3hdH0i+4+vCS26QU33eQl6Q3qjZOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCizMDu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCizMDu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4610E1F000FF;
	Tue, 22 Sep 2026 15:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089756;
	bh=RpxJA4hiRcSAGpVZ7kP2DheoSiv3zHhW5sfbqzzWrqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCizMDu/3jIF/Qz58zT2Gcb5ou1KeJ6Zu7JIB8rth0kho2n4PSgqio/6VJxINq3ik
	 uA4M8W1+wqUkVLU61CFwfryvFaG0zscLbMC5XZ/vEn7PgscYUESkjiVsb6IGK4+N08
	 0PpAJMegTszMF0mUZ6qT0kAlNpVBetExcIbzPTFquGat5qj1tWwafrDre8DyJTDC+Z
	 uFOM0XvGb24Syj2I3ja12jn6zR/uQTeX+A07I3Bd3hBop6K0gpzi+iiXHeObkcfa1R
	 iVC9dirdNYOJuajSoPtHETBV5waixMjlvagx/brCw44+X4z4CgT3ihlJHz8yS9vNEl
	 J1eZO0NZ6GnjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] swiotlb: use the adjusted address for the highmem page lookup
Date: Tue, 22 Sep 2026 11:09:14 -0400
Message-ID: <20260922150914.2750787-1-sashal@kernel.org>
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
[ replaced unavailable PhysHighMem(orig_addr) with PageHighMem(pfn_to_page(PFN_DOWN(orig_addr))). ]
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

