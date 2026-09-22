Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397F41D647
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790069262; cv=none; b=YVb86jPWW6UqHxjNwWrnG7w5/yZ0Psmq0oFvXfBQPwdG9Jo5/UUArZWO65yodahhf/smwlNPRGIhXvrIYisPmSdc8zrkNKz9rkSecXwBzMbcAHmKQmddiXUE1FD15DDnh7Yh5OPmvMS68GsmQGiXlnsHydEbE92SqmIUjP1WgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790069262; c=relaxed/simple;
	bh=hG/BYN4Sbv9lUkrgRf2xSBNVSSyK2o34Wv8S4lnZqHE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NRkm87R7Gw75rktRugL9SNEUbbqnXJj45SIzQcQmop8i37JWJNZ7j1VrRIqpADO6qQM1vOBRX3QRwWiZtx8AIkoHNGUPNUnv8Mi9CBm0OEwtBzZ8FMd9AdG0IDFcCN4zQSKbrWTKPTs8rTLqffof+jSDJEKdi5pJE1SUVEL4lwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lJzNQdvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lJzNQdvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31391F00893;
	Tue, 22 Sep 2026 09:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790069261;
	bh=HpKqXvHIfnFauAySwZCNqcyCQPVq/idwnrmBRGj4wc0=;
	h=Subject:To:Cc:From:Date;
	b=lJzNQdvjIxDPA154fulLREmiduIpVm0v5Cy7Jm2djUMZeAERQfIj1vz3XF4wlxTEg
	 9/KVu2TI3Mi+t3hdzDCa+1rrkMznFd6VYK0CEoLjkpFSLvt6TtNKsF5OXlrsRIb2IC
	 fCWdTq/q+ULWlZIYKj/rgmlc25Eh6mNaR0aKRFsI=
Subject: FAILED: patch "[PATCH] swiotlb: use the adjusted address for the highmem page lookup" failed to apply to 6.6-stable tree
To: donggeunyoo.kernel@gmail.com,m.szyprowski@samsung.com,mhklinux@outlook.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:26:45 +0200
Message-ID: <2026092245-shallot-entrap-77a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b7d7914a9ae3097e63d113007e4fb44d33d515b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092245-shallot-entrap-77a4@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b7d7914a9ae3097e63d113007e4fb44d33d515b1 Mon Sep 17 00:00:00 2001
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Date: Sat, 5 Sep 2026 17:42:10 +0900
Subject: [PATCH] swiotlb: use the adjusted address for the highmem page lookup

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

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ded7016a46a7..aa2f1c4588b9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1019,7 +1019,6 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
-	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
 	int tlb_offset;
 
@@ -1052,7 +1051,8 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 		size = alloc_size;
 	}
 
-	if (PageHighMem(pfn_to_page(pfn))) {
+	if (PhysHighMem(orig_addr)) {
+		unsigned long pfn = PFN_DOWN(orig_addr);
 		unsigned int offset = orig_addr & ~PAGE_MASK;
 		struct page *page;
 		unsigned int sz = 0;

