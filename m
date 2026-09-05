Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15110345729
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597737; cv=none; b=HTu50SSq2EcpIP/Ww3WHu9FkYRe3rKZ/or8+joNV9mAhkYcaoP9p8xiM1bIxkh6OW3LNwKic0Gti6nGPQW7HHD9HoFIFZzzwI/VKm8gVdi9fl7B84sf4VNat8CjZ/iZSNVESWyL2kCecGCtOwmlfroAMCL2hY46h+0M7B3CZQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597737; c=relaxed/simple;
	bh=9j6NYG0hkRG6PdUmh1zEaxVWk06YE1JQZ514CGCZKkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAlTL4uG37FyWU9aZgz3qIz4lFkzXZDF0n40bqz3ZPN8ZRWzj5IaWZmonE1sjElNFPIwJP7vjzPyMvWZSyUxsHLGnLbwvXlO6M7G1ckv083kmHGdtotocahV7LB2vRa2uhsHYtv+nI2bMvUtJSijhtA1EbggfohNSxmNKRwCH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJnKMGXg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJnKMGXg"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2caced6038eso19055805ad.0
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788597735; x=1789202535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+VobeyYxIxVOojjPHLkwwdR8KDg6vnqQTELSH5lLU28=;
        b=kJnKMGXgQXUk3UznzxtffWTr1ihEsZvnCJfKOpn0M7Nfa20sf4NkfsNBDMZr04QhR5
         P4F8Dd8Q+s0EN0msLAWO0w9+XV1C1Ur+sPyVVohe2P6pNxX2Ou5XHikPy6n1B9mEe+3R
         9fny0b70X2PeV2xMFOSIov0qKVinXnIedCfSpf4g6rs7Cq91K0+EWSlwTMZhXn/Zmmpy
         Urxax1maoB+gzR8QBM5a4AqREzACx109kRmCspfvOU2ZM4skxiadO+j1ZGCbxK6aa+PZ
         Bsz9rL8RvsD7VQhHd0Ha2Ex3ZOVoTmomA2h6PaSvh+5JmT0gnr/LTXE0lobisgzfNhEM
         C80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788597735; x=1789202535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+VobeyYxIxVOojjPHLkwwdR8KDg6vnqQTELSH5lLU28=;
        b=aChJgZvP3BlVLgncIgMWIUn4JgwXfI6/eKvYSokT5MOdxMaT7SBgXHlzBuLlxtP3G1
         2IkUH3gQpV7Mq2UPa8cXWEk/g8ThEtorsS6lpEqv6R263NhZzDWb53Si2SOpoLChVyhx
         vUVGKMTo0suKXyFPeq1VRmuXsEoCf1793aQSQP3/BYcToNGlay+bomSIoTQFnAvs3e4N
         JgqXFyQaQmp1jI9UShU+/yQgdP59qk7Rgat/LQ4eVzypjFmY+keA57mLEVS533Ckrkpv
         y+BWG2X7y3vxqb713pb5NcZUm2TPmu2RPx02sxO9gme4TR6JBLNwvx2RrLM3SurtGJZc
         3I+g==
X-Forwarded-Encrypted: i=1; AKwUvBwUVPvpQAVLLHOZzX8Xvx6x6T6gqSWjEwsioKyLPXBZQwxhMH9t8nmzzXLbJ+QsXtwOsRiDwMQ=@vger.kernel.org
X-Gm-Message-State: AFuF++niaNXba1HRpKps4jUSn1QveggcqXTfi/ekzS+xD65/AKpObOeS
	byMrHxnZCtgJ/PWMH4fFkgswiI9ScDhhnej9FxnwwRNtAQ1reDpBg4U=
X-Gm-Gg: AYBFou37bKMbiPjHtnsODQE1RNmYEQLC9y66fl5q6YIrR4NkwgHC2Lnes39mByVAeDx
	3/TXjff3RAWNeifPDSpnYHL4PBYAewmPN11KCe/snmLNaeZtXJ93Un0/2JxQGwKrwOa5zBU1iyR
	LIUMM63hgW6gxynEk8nQ2YYO0SR2QVyYyNJMh2EoWZvuB3DZeoW+oDSIxlBDmLePZx0bQOqksPv
	0gcWAzvZ3oyETUV8oGSf4vvTd1LP9ui/rZoyYalqIj+lhuL01oU1dgMN/2NrwvTQ+gidqC78k/z
	eio5QDiSjSrO9+TWz2ZX5ZpeopMMk4n4OMxj8L5MYdO0pNwZ0sYxpLD2lDcCG3VtSzRDmHmSeSk
	SwCMCyafk8k9iRmslWZxtVYN31o2q/E3VqIDl8mxzimCH+FD5AzhvqDVtuOM9PWV35l92zrNdcL
	h1ReqF9AsOviRM8DZe7BTkAvGDgu77rUfAt1z0SIZ5MCRX21D2B+hUuMMgBzLY8LYm5cbIs8Be2
	vuwscEAwhRQeA==
X-Received: by 2002:a17:90b:4d91:b0:398:c6e8:3fc2 with SMTP id 98e67ed59e1d1-39b27c42b89mr7855112a91.4.1788597735226;
        Sat, 05 Sep 2026 01:42:15 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25f8d2c5sm9079660a91.2.2026.09.05.01.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 01:42:14 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Chanho Park <chanho61.park@samsung.com>,
	Bumyong Lee <bumyong.lee@samsung.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] swiotlb: use the adjusted address for the highmem page lookup
Date: Sat,  5 Sep 2026 17:42:10 +0900
Message-ID: <20260905084210.148255-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Reproduced under QEMU (qemu-system-arm -M virt, 2G) with a 32-bit ARM
kernel built from multi_v7_defconfig plus CONFIG_ARM_LPAE=y and
CONFIG_HIGHMEM=y, which brings in CONFIG_SWIOTLB, booted with
swiotlb=force. A test module maps two highmem pages at page offset 3840,
writes a pattern into the bounce buffer 500 bytes in and calls
dma_sync_single_range_for_cpu() over that range, so that 3840 + 500
crosses into the second page:

  before: swbug: pages pfn=700d4 highmem=1
          swbug: orig phys=700d4f00 (page off 3840)
          swbug: RESULT page0_off=244 page1_off=-1
  after:  swbug: RESULT page0_off=-1 page1_off=244

The pattern lands one page below its intended location without the
change and in the right place with it.

 kernel/dma/swiotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.53.0

