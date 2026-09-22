Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B655C1B2
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091123; cv=none; b=EpJuGcb1H1v8GFEZ3uLtit/BSda9zxVRcOUXWsMp+X3BHmyjI35is8JdQ/FR7Tw5E1QiEiNEafQ6BNSt0axjjTTo0TEKIpU4wmSg4sNuUr7BBJYH5hoXMKkEAo6VJQfgTmg0O9OgYvWGt7rm8YwIbKWVJiqct9s9mlqXx44R+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091123; c=relaxed/simple;
	bh=b9uZy9YhzddP/HTgEWtFrbL4xCbZADYLoQzzZ/vkCZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMxp+LPkO27id+Xqxfz1FyCsEdZmWGidOUdOJNYK59AWzunoXGmo3c60v1HHaPOwEPrFa3UHGIFBZv0NPwFN0xIP85lKuaQvb1mV+b4Qu4xkEK4dCWMbNU1XHZEfad413M9b54+refU6Z04M6IXbZanmslu+CBFPvySnzhQE3zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTCHcyvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTCHcyvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C321F00893;
	Tue, 22 Sep 2026 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091121;
	bh=Ryo+8+KjinduyTNzXmQiPvKcdJ52BE0AuWMXJ34GF9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kTCHcyvcQl0Ef9tT6oFva8DxzEVeuHUhLbKQXHeDAnmguK8yGLsUSo5FzJwlRK6CZ
	 daO9lHCLwZyZENrbCbIChebQF8QbbTc+uhurl9wQGzU5oSiGsylAGT9JePKtQnP7XE
	 oyMSHGUlrtzetVGNDaFizQQzCmajA8p/I7xDuJwTuiIFKIg3mTJksKsGUbafK49ccj
	 A7VLfkUUhX9ISYkNSqZwY9F7hBgY0Alnnyg2129rIl23RRjzbsbzgO4yt5pH5H5yuB
	 Phh8E5wagBY1itz9YheCRH+q4kl8IMYKXuBTvxkjkVbAlnb8cUG3LtWkiKDeLnhqZi
	 5EZpMC18DYUZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] swiotlb: use the adjusted address for the highmem page lookup
Date: Tue, 22 Sep 2026 11:31:59 -0400
Message-ID: <20260922153159.2820668-1-sashal@kernel.org>
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
index 59d44d8f6161d..904a646fefc6a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -370,7 +370,6 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
-	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = phys_to_virt(tlb_addr);
 	unsigned int tlb_offset, orig_addr_offset;
 
@@ -404,8 +403,9 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 		size = alloc_size;
 	}
 
-	if (PageHighMem(pfn_to_page(pfn))) {
+	if (PageHighMem(pfn_to_page(PFN_DOWN(orig_addr)))) {
 		/* The buffer does not have a mapping.  Map it in and copy */
+		unsigned long pfn = PFN_DOWN(orig_addr);
 		unsigned int offset = orig_addr & ~PAGE_MASK;
 		char *buffer;
 		unsigned int sz = 0;
-- 
2.53.0

