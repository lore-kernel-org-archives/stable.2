Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60D4B0486
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786246102; cv=none; b=KlPN7hUAAmbSd0tajgwLGFUnhpy59rwJVWRHom8HsAsrqimhyYUbPzWO+r4e9eByWR94HRG18W8geA8sWYjqIUYPM6kZhvNTeTP+Et/k8Zj0FF5d7VfJg1G0EIt2H0jlBpkcBDlbpS/vo51T3Yu2YN02Dj+BtivMYLpW6H8lAwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786246102; c=relaxed/simple;
	bh=m9jOM3JnwxnOHunHY32HFFU1VBtGt8WDJlIYoxsl8DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRXPFnxM3PduiudbvtpwM5luYZDmbbnD7citrJUhiMaI/r3qCEiIQGxH9yKOjLEixkGdovlam8Z9Njo5WVl1q1ucBlQSiIn2s18es7p9JqkK96PR6cLoXkZacSj4uIL6TMu+qmQWB+rN628E1gHPoSfTq+DyqhdqU94jrbP+9WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duZPvk7f; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duZPvk7f"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacb8416a1so7403375ad.1
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786246099; x=1786850899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEHO0Y8VayIiQ9EQdeJUip1ZA/P378h7uR1P3EclUFk=;
        b=duZPvk7fFeqwS7cV+/NO9f6wfoJaOIz5JOzUS/4wuEPkjEYfQjpNW+lfEt3WFLnlGF
         L2emRLD+JjozGeg2WkViLcuHtMWDxurd17uYeDTh5eH02V8P/ld2MUvA00CmJROSGk/I
         EnNPZvhmSCOd8i47mIVIjYVG4Xcn2ozV6/UpxXWeSEKdxp3tbkhkFepoVVWzWMhpOV+x
         FC2g+sshV5W7O8TKj+AknH+YJiZUotjYWOHAbBDvOyDzcBoKdej/W7+qKU8wDY2tXc0R
         t320zCoIKrXkr/oTSghA5unej6tO3qyBu6Wx+fT84iCNfQ8GrxxYtS+lYBPHNrH3O+hn
         UDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786246099; x=1786850899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JEHO0Y8VayIiQ9EQdeJUip1ZA/P378h7uR1P3EclUFk=;
        b=lalYchdXz2aSkknYJC4xFhVUCgcfAbiSB76HbrE+sgftV+P7F2t2yuKUJdoB/EftVr
         vi2bhAGKvavfXsUrwy9NI6rOUebRuhR7ZK72s6PZcd/HgBPiqAhSCESRT0Gz6/20LKSt
         bN8lsWY3eenVKD01f8JltQ42oTA9Tzk2BpcV98ZDlAsLCFjoLcmN1oCaVquLPnAYkPj7
         ooYfZfObRH1eCwVwzh7wz/72yVR5QHazcLWW2v8CFunEKt196havh0oYsHPJI/yulVbU
         X+lqoQIb6VaPnTBVLT0ywJSOFaSItOCpIsmNw5EhK6diQGeKX5coxr1SEbsBdn4ZIER7
         6Ebw==
X-Forwarded-Encrypted: i=1; AHgh+RpMg9FRuQ/9IhIO0LIo5x8iyTl8cOjO20Cvti8Dr2DTc7ZyvKPd/7WaSdTGmZGP88r/+FR0Sbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xAmtqIKETM2HteJjT3ITgS8jufNSgr1tV7CMHWzRk407NafK
	vB+p5Z3htL5QdEjdv1j197r2/H40Xcs3A74740UP4bwRxnTvFLC34r0DJzY+D38lgXQ=
X-Gm-Gg: AR+sD12UOfD6QfJp29F+pfCWh4jkdXKHNQ0UuVC1ICtnDrkXjTKvGLSsLjQRjQvC5Mx
	n/TzRXK2HsT6vYRS89mvLgoCOhVjtVrtokEp3gg0itC8qe5oPzDRVRuF/4dlkBhGPsPq9JfW9ta
	dtOnoURYzOrMddZjIa+1muzfonwqVLmnspMP2pDr6gprQg00i+SAeDbpdmNHCRuSCuWMQolr2/J
	oC0gSVAB/K2gUDdIBGdySgn/6LXyLGxla2Fci1vf06NHJF4seYBKiOe1jiHsEug46cmhg9N++p6
	uvB4q1bhDHUNhUv5zu/viNFVeEA4gcRYFv1+zgH/X5IbGzxOi5FMSRBW/NOM3L25o2gx+kkMsRg
	J2gb+U1MO04soIf72hq5WE+WMTEZXjX3QFsv/UMKtLstJYulI+S68K0AcavU9sRF2YNojibiRAZ
	C200L8BHhL0XjMDclhGcmzm6iQcXqJjdtaY4M0KKw2I3K8w9V/nSzESYvptkbld6r2EkT48Omia
	uyNkwztMGXH1akm6XTHx5eoltthyUtxw408muLOtNpst9ZPXOl74n7Vgo6xkbI=
X-Received: by 2002:a17:90b:4c45:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-392822b7b78mr8987373a91.8.1786246098978;
        Sat, 08 Aug 2026 20:28:18 -0700 (PDT)
Received: from homelab1-WRX80-Creator.localdomain (p790255fa.sitmnt01.ap.so-net.ne.jp. [121.2.85.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3926254ee45sm7587626a91.2.2026.08.08.20.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 20:28:18 -0700 (PDT)
From: Shuhei Takeshita <jyohuku.alterego@gmail.com>
To: dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dean.luick@cornelisnetworks.com,
	Shuhei Takeshita <jyohuku.alterego@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] IB/hfi1: Fix the PIO_CRED credit-return mmap
Date: Sun,  9 Aug 2026 12:27:43 +0900
Message-ID: <20260809032743.2671579-3-jyohuku.alterego@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809032743.2671579-1-jyohuku.alterego@gmail.com>
References: <20260809032743.2671579-1-jyohuku.alterego@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfi1_file_mmap()'s PIO_CRED case must hand user space the single
credit-return page that holds this context's entry.  That page is the
second or third page of the per-node credit-return allocation once the
hardware send context index reaches 64 or 128, so the failure below is
intermittent: when the entry lands on the first page the offset is zero
and everything works.

Two things are wrong.

First, cr_page_offset is a byte offset but .va is a struct
credit_return *, so adding it is pointer arithmetic and scales the offset
by sizeof(struct credit_return) == 64.  memvirt then lands 256 KiB or
512 KiB past a 10240-byte allocation.  With an IOMMU translating, that
address is inside the vmalloc range but in no vm_area, so
dma_mmap_coherent() -> iommu_dma_mmap() finds no pages, vmalloc_to_pfn()
returns page_to_pfn(NULL), and remap_pfn_range() installs a frame above
MAXPHYADDR.  The first user read then takes:

  psm2_ep_open_pr: Corrupted page table at address 7a14d007e000
  PGD 800000013886a067 P4D 800000013886a067 PUD 13886b067 PMD 13886c067
                                            PTE 800049168e911235
  Oops: Bad pagetable: 000d [#1] SMP PTI

Second, and still wrong once the arithmetic is corrected,
dma_mmap_coherent() describes a whole coherent buffer and selects the
page within it with vma->vm_pgoff.  Offsetting cpu_addr has no effect:
for a vmap'd allocation iommu_dma_mmap() uses cpu_addr only to locate the
vm_area and then maps pages[vm_pgoff], which hfi1_file_mmap() has just
set to 0.  User space therefore always receives the first credit-return
page, every credit read is for the wrong context, and send PIO stalls
forever.

Use the DMA API as intended: pass the base of the allocation with its
full length and select the page with vm_pgoff.  A separate length is
needed because memlen must keep describing the VMA for the existing size
check.  The dma-direct path stays correct as well, since dma_direct_mmap()
adds the same vm_pgoff to the base pfn.

Tested on a Dell T7610 (Xeon E5-2650 v2, Intel IOMMU in DMA-FQ mode)
against a Threadripper PRO 3995WX peer, both Omni-Path 100.  Before this
change psm2_ep_open() Oopses the kernel; with only the arithmetic
corrected psm2_ep_open() succeeds but any transfer that uses send PIO
hangs, PSM2_SDMA=2 (send PIO disabled) completing normally while
PSM2_SDMA=0 (send PIO only) hangs every time.  With this change send PIO,
send DMA and the default mixed mode all work.

Fixes: 1ec82317a1da ("IB/hfi1: Use dma_mmap_coherent for matching buffers")
Cc: stable@vger.kernel.org
Signed-off-by: Shuhei Takeshita <jyohuku.alterego@gmail.com>
---
 drivers/infiniband/hw/hfi1/file_ops.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index e05f3c255..ad2044d1f 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -326,6 +326,7 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 	void *memvirt = NULL;
 	dma_addr_t memdma = 0;
 	u8 subctxt, mapio = 0, vmf = 0, type;
+	size_t memdmalen = 0;
 	ssize_t memlen = 0;
 	int ret = 0;
 	u16 ctxt;
@@ -371,7 +372,9 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		mapio = 1;
 		break;
 	case PIO_CRED: {
+		struct credit_return_base *cr = &dd->cr_base[uctxt->sc->node];
 		u64 cr_page_offset;
+
 		if (flags & VM_WRITE) {
 			ret = -EPERM;
 			goto done;
@@ -381,11 +384,18 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		 * second or third page allocated for credit returns (if number
 		 * of enabled contexts > 64 and 128 respectively).
 		 */
-		cr_page_offset = ((u64)uctxt->sc->hw_free -
-				  (u64)dd->cr_base[uctxt->sc->node].va) &
+		cr_page_offset = ((u64)uctxt->sc->hw_free - (u64)cr->va) &
 				 PAGE_MASK;
-		memvirt = dd->cr_base[uctxt->sc->node].va + cr_page_offset;
-		memdma = dd->cr_base[uctxt->sc->node].dma + cr_page_offset;
+		/*
+		 * dma_mmap_coherent() describes the whole coherent buffer and
+		 * selects the page within it with vma->vm_pgoff, so pass the
+		 * base of the allocation and its length and let vm_pgoff pick
+		 * the page.
+		 */
+		vma->vm_pgoff = cr_page_offset >> PAGE_SHIFT;
+		memvirt = cr->va;
+		memdma = cr->dma;
+		memdmalen = TXE_NUM_CONTEXTS * sizeof(struct credit_return);
 		memlen = PAGE_SIZE;
 		flags &= ~VM_MAYWRITE;
 		flags |= VM_DONTCOPY | VM_DONTEXPAND;
@@ -567,7 +577,8 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		ret = 0;
 	} else if (memdma) {
 		ret = dma_mmap_coherent(&dd->pcidev->dev, vma,
-					memvirt, memdma, memlen);
+					memvirt, memdma,
+					memdmalen ? memdmalen : memlen);
 	} else if (mapio) {
 		ret = io_remap_pfn_range(vma, vma->vm_start,
 					 PFN_DOWN(memaddr),
-- 
2.43.0

