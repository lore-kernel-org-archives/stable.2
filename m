Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D31456DE2
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790069260; cv=none; b=ABJNn7r4Sepp98ir5+UfBLARPZFyNv31KmteBHQKcLhIdU6yLfHMBngQRs5+OowlxKdIM5LXi0GXugXyKX0420JxpbtTNR7JZSjcjf2KW7lhvzFflDEr5yvJKBi0g1x5WzZC/YSJaUKs3TG4gEEGq2S5n3yyW7/AwIuml0wuwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790069260; c=relaxed/simple;
	bh=Lu1P4CmsAun4LA6iKXWQBv+KgHj8yjNoStxCOcZo/To=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h2mYoUMzSYhTDAR0tVqzQNEzQdTl8/YH1IjWtD3PN9rD1SO8AYTX/90xwo4uN57/eH1ZkQqT/koEDi2aGU+gRzngGU4EDepqEh+4Sz3RNvTELyuWUuCvKnJJIcY/bf0jjnJTxhLCgliGnTIX0o136f1Lm2q2wE7qJvAcXK6x8jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MVcZsDKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MVcZsDKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABBD1F000FF;
	Tue, 22 Sep 2026 09:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790069258;
	bh=JRh9GCUpz56QnZD6Qlyg8SotjCP8MYQORf2MydNCjEQ=;
	h=Subject:To:Cc:From:Date;
	b=MVcZsDKDg5yxTuIgc15SkHzGxIqKhmfl1Z+UlNQH3Sh7bXBpEB2tdL0PZIN9sN5Tl
	 eR7KSKIhaYbQUFic/TLHzygxR73CNMRKnvLWbAgDc4bH/X2iRGOdD6867N36rWm01w
	 9Ev606uPt6x0MRBEDQ1D64jOVZIAg7xtaRUONOKo=
Subject: FAILED: patch "[PATCH] swiotlb: use the adjusted address for the highmem page lookup" failed to apply to 6.1-stable tree
To: donggeunyoo.kernel@gmail.com,m.szyprowski@samsung.com,mhklinux@outlook.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:26:45 +0200
Message-ID: <2026092245-pry-stinky-86f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b7d7914a9ae3097e63d113007e4fb44d33d515b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092245-pry-stinky-86f2@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

