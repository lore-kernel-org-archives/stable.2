Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2E43C07C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099489; cv=none; b=vFTuLuFlkPg6jH2RJHYfJwNePnlENaPx6cDdujW7yrCZSSp1BF1VYhflVNB2LQ0xuunM2hjnAXVyUkcVFaET1nXiQni3HVjOHWBMJ7tabiqH7nXDXzSEF1mnpUmCcL8O3wzhzPU/Vt4eX0VoIbuXKXuuDv7Us+74w7w2F5J9mE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099489; c=relaxed/simple;
	bh=5kqRD95EA1h69MgHeEQ/GefzavkQdRkju+WCgwrtEB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldlYNZegJw0eTXjddzo1/fsQLFybjP6a4af1ClZq9TEnbUlJbRf+YRwnmwqFNnNwmKEDdfuep+5xw0OPB7vatyLVxk4lF+5uLSYX5jGEnrpHR8eGP6YeYoWUD8lrC8UYyNgiX6cUaPLC0mFsuOu9sWxhSu1zaUFo0utCEaX6TeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zfg3IlFO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zfg3IlFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7EB1F00893;
	Tue, 22 Sep 2026 17:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099487;
	bh=vmHim/L39nFIrdThFB4U9h4lrbfxde3Qn0qjc1NfTbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zfg3IlFODfi7fjoQIcYmsJU/IlzYZpVEleZbR8CjC7zc/yBIYt82ffeIYlX6SP+qv
	 tnmeU+Vgf4ToruoChKGGSTc+Rx7YjZfy/1qjuOEXvHYfu2SXUI0tjNcmAUIwr7Ahti
	 R7nD+//qHBISErYuecrXtCdDrMBE3bsIGc1Dy5Yp2pfd9gL0f8ksvBZIRO55lc5ncv
	 KzJs7GC3bMRzXeoTP203OZPgRtGR/Dkfp/avxnKTBeTE0igz7NB2rZSfzMh1CA9coC
	 v1ukF8Pp1PM0fV+9oDFVMNu/qwlA74O44x3Ey//0kwEk6KkbPn/LZmORGOLrTciYrv
	 XW1KGbpQhLR0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] swiotlb: use the adjusted address for the highmem page lookup
Date: Tue, 22 Sep 2026 13:51:25 -0400
Message-ID: <20260922175125.3309960-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922175125.3309960-1-sashal@kernel.org>
References: <2026092252-playlist-affected-d683@gregkh>
 <20260922175125.3309960-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 87e1e092c58a3..51f18ce8564a9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -371,7 +371,6 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
-	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
 	unsigned int tlb_offset, orig_addr_offset;
 
@@ -405,7 +404,8 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 		size = alloc_size;
 	}
 
-	if (PageHighMem(pfn_to_page(pfn))) {
+	if (PhysHighMem(orig_addr)) {
+		unsigned long pfn = PFN_DOWN(orig_addr);
 		unsigned int offset = orig_addr & ~PAGE_MASK;
 		char *buffer;
 		unsigned int sz = 0;
-- 
2.53.0

