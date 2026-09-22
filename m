Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860354CF48
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083849; cv=none; b=Px0we4BnYoVBJSmWDX94oxOBR4AWL/EiWc8eoi/y84BUogsXOM8CwIhAnUG5ZkfuhESzR7I/7hhE6EGJuUXx1Q5H0BICLcK0W5KewbBT9p0M5fB2+XVJDWFlg5p91zfEQWL6WpfrwQXVYvlGMZzUPsLbx8sVzE0hlaMsbnzk8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083849; c=relaxed/simple;
	bh=wXUf5BccZFVgfDBfvIlzXLvhc+NhsICUnKJDyJp3Gfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxgXmlW579iOWYO51zMn7gad66pJnWDSe7bqELvTRYOy7ixzOisE+xbfG9dyY3jt+8Z2D84eMaxn6ubeKcMzy30XNsTxi2vMSHHqX/uGDIB8glsZmqEfn3SZiWxXSBXibriVEbHCleuIKf/z1xR3q+8csIRuQIguEGqcNnGkrTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dhaknke6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dhaknke6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055501F000FF;
	Tue, 22 Sep 2026 13:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083847;
	bh=PL2T9Vj3kPjjCi0wrEIsbMIpqbD5l4li/r11wpDskak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dhaknke6XjfpPUSOKw4mYS88S9O3HI7raPzGAQTknBS17nZV3suZ6o3JoDgLzx/vt
	 5awqC7cD9tvH9e/xC4RHxVykrBBrjP9b+FtjZP1QPIa0ehYuAGT1MstvTFUGsvASFl
	 jhKBbKLHE1y3c3jcNYWMbYabBpvAt8rVevEixbbumP3Su0m1uSGw0FNLnKJsOVIwUm
	 kgtE1uT+z1YMqUL4ZZBzU/3fL8T9Ld597DeYIyDi3lE1PUKerG3j+Zs1OGRDt1GS0s
	 P22KKIsWc+HdXl94xOFs7gC8WyxI2R0BZKYk0xUeXe88QU76zDuoj8u4nY3sd44l5Z
	 LmWJrHtWcmovA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] swiotlb: use the adjusted address for the highmem page lookup
Date: Tue, 22 Sep 2026 09:30:45 -0400
Message-ID: <20260922133045.2479238-1-sashal@kernel.org>
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
[ Replaced unavailable PhysHighMem(orig_addr) with PageHighMem(pfn_to_page(PFN_DOWN(orig_addr))). ]
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

