Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994FA3C942B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093616; cv=none; b=eYb8pKSFIg+eaNfH6EqB2ejcFv3Kn1U04Zh3nXhGg1A7UkuLiKX4vyP6jWoe6eVtDMXtisX6OgUGDPXkPVxVPo4yAaUJCdmsKH+nvXSFfl2bBe6fWi18MB3jyZ/39vyYVfzBEtnaLiHtVRmFqh7rCahpLnoSnzIf7JnhHKVBCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093616; c=relaxed/simple;
	bh=6N4odhVzO9ZREsJkNvzCq+lJzrzH+3lj2HxmIuJU5K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMSBC4wYb8z8oMPFKtPOWW73wQ7IopBJHPR9V/rhxDxyQb4I3juMKJskvBcaXs3dE8dEXtPyCJimmvER/pgJWWg+MvyUtqD3fDz/25YZWMFLiWuebLW8pYXi8lyEhy+cY0SQCrZgTaVl1/DuKrwZJTAioReA7P6Xj0heQUrIp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WivogikR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WivogikR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B4F1F000FF;
	Tue, 22 Sep 2026 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093614;
	bh=tBNlRA8+vBg8bvSix7zJ6HE6X959gSnjSXVf4ZFSquk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WivogikR4j5Vxo2C7X/DgwjcnIbGlI/xrorzz1n/G8soVM6oXG0s9B13Itfwz3hIP
	 joef7kAasOPkSmdAHgcXeGqeWX7NNVwHt7pLHypyqHQog675rgyEvIq/sSJZDqERvL
	 jPv1JawhE4xtXjw9XYAE0Do2ZPnvIqPHjNvE9CpWNLh8Ijn/mWev7hHrJ0UZaka5/r
	 K+SqNj5vLyXf6xcQDiWt/rgiSflKPSbcQQIGCrS3dKLxbFmOr3IPB6993KJHNfSs6C
	 3UAAMwoaRnT1J5oqgq8cOzKPQ0+vUW9TqpmMUXg9qyaUfSQFZpJZrm0m3egubH3JmO
	 ON+hG4Z+nP+Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] IB/hfi1: Use dma_mmap_coherent for matching buffers
Date: Tue, 22 Sep 2026 12:13:31 -0400
Message-ID: <20260922161332.2979388-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092206-enjoyably-shrapnel-5c31@gregkh>
References: <2026092206-enjoyably-shrapnel-5c31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dean Luick <dean.luick@cornelisnetworks.com>

[ Upstream commit 1ec82317a1daac78c04b0c15af89018ccf9fa2b7 ]

For memory allocated with dma_alloc_coherent(), use
dma_mmap_coherent() to mmap it into user space.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Link: https://lore.kernel.org/r/167329107460.1472990.9090255834533222032.stgit@awfm-02.cornelisnetworks.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 975396b9e5a4 ("IB/hfi1: Resolve the credit-return buffer through the send context's node")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/file_ops.c | 81 +++++++++++++++++++--------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 1c1172aeb36e9..a02a90a9606cf 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -306,6 +306,17 @@ static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 	return reqs;
 }
 
+static inline void mmap_cdbg(u16 ctxt, u8 subctxt, u8 type, u8 mapio, u8 vmf,
+			     u64 memaddr, void *memvirt, dma_addr_t memdma,
+			     ssize_t memlen, struct vm_area_struct *vma)
+{
+	hfi1_cdbg(PROC,
+		  "%u:%u type:%u io/vf/dma:%d/%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%lx",
+		  ctxt, subctxt, type, mapio, vmf, !!memdma,
+		  memaddr ?: (u64)memvirt, memlen,
+		  vma->vm_end - vma->vm_start, vma->vm_flags);
+}
+
 static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 {
 	struct hfi1_filedata *fd = fp->private_data;
@@ -315,6 +326,7 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 	u64 token = vma->vm_pgoff << PAGE_SHIFT,
 		memaddr = 0;
 	void *memvirt = NULL;
+	dma_addr_t memdma = 0;
 	u8 subctxt, mapio = 0, vmf = 0, type;
 	ssize_t memlen = 0;
 	int ret = 0;
@@ -334,6 +346,11 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		goto done;
 	}
 
+	/*
+	 * vm_pgoff is used as a buffer selector cookie.  Always mmap from
+	 * the beginning.
+	 */ 
+	vma->vm_pgoff = 0;
 	flags = vma->vm_flags;
 
 	switch (type) {
@@ -355,7 +372,8 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 		mapio = 1;
 		break;
-	case PIO_CRED:
+	case PIO_CRED: {
+		u64 cr_page_offset;
 		if (flags & VM_WRITE) {
 			ret = -EPERM;
 			goto done;
@@ -365,10 +383,11 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		 * second or third page allocated for credit returns (if number
 		 * of enabled contexts > 64 and 128 respectively).
 		 */
-		memvirt = dd->cr_base[uctxt->numa_id].va;
-		memaddr = virt_to_phys(memvirt) +
-			(((u64)uctxt->sc->hw_free -
-			  (u64)dd->cr_base[uctxt->numa_id].va) & PAGE_MASK);
+		cr_page_offset = ((u64)uctxt->sc->hw_free -
+			  	     (u64)dd->cr_base[uctxt->numa_id].va) &
+				   PAGE_MASK;
+		memvirt = dd->cr_base[uctxt->numa_id].va + cr_page_offset;
+		memdma = dd->cr_base[uctxt->numa_id].dma + cr_page_offset;
 		memlen = PAGE_SIZE;
 		flags &= ~VM_MAYWRITE;
 		flags |= VM_DONTCOPY | VM_DONTEXPAND;
@@ -378,14 +397,16 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		 * memory been flagged as non-cached?
 		 */
 		/* vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot); */
-		mapio = 1;
 		break;
+	}
 	case RCV_HDRQ:
 		memlen = rcvhdrq_size(uctxt);
 		memvirt = uctxt->rcvhdrq;
+		memdma = uctxt->rcvhdrq_dma;
 		break;
 	case RCV_EGRBUF: {
-		unsigned long addr;
+		unsigned long vm_start_save;
+		unsigned long vm_end_save;
 		int i;
 		/*
 		 * The RcvEgr buffer need to be handled differently
@@ -404,24 +425,34 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 			goto done;
 		}
 		vma->vm_flags &= ~VM_MAYWRITE;
-		addr = vma->vm_start;
+		/*
+		 * Mmap multiple separate allocations into a single vma.  From
+		 * here, dma_mmap_coherent() calls dma_direct_mmap(), which
+		 * requires the mmap to exactly fill the vma starting at
+		 * vma_start.  Adjust the vma start and end for each eager
+		 * buffer segment mapped.  Restore the originals when done.
+		 */
+		vm_start_save = vma->vm_start;
+		vm_end_save = vma->vm_end;
+		vma->vm_end = vma->vm_start;
 		for (i = 0 ; i < uctxt->egrbufs.numbufs; i++) {
 			memlen = uctxt->egrbufs.buffers[i].len;
 			memvirt = uctxt->egrbufs.buffers[i].addr;
-			ret = remap_pfn_range(
-				vma, addr,
-				/*
-				 * virt_to_pfn() does the same, but
-				 * it's not available on x86_64
-				 * when CONFIG_MMU is enabled.
-				 */
-				PFN_DOWN(__pa(memvirt)),
-				memlen,
-				vma->vm_page_prot);
-			if (ret < 0)
+			memdma = uctxt->egrbufs.buffers[i].dma;
+			vma->vm_end += memlen;
+			mmap_cdbg(ctxt, subctxt, type, mapio, vmf, memaddr,
+				  memvirt, memdma, memlen, vma);
+			ret = dma_mmap_coherent(&dd->pcidev->dev, vma,
+						memvirt, memdma, memlen);
+			if (ret < 0) {
+				vma->vm_start = vm_start_save;
+				vma->vm_end = vm_end_save;
 				goto done;
-			addr += memlen;
+			}
+			vma->vm_start += memlen;
 		}
+		vma->vm_start = vm_start_save;
+		vma->vm_end = vm_end_save;
 		ret = 0;
 		goto done;
 	}
@@ -481,6 +512,7 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		}
 		memlen = PAGE_SIZE;
 		memvirt = (void *)hfi1_rcvhdrtail_kvaddr(uctxt);
+		memdma = uctxt->rcvhdrqtailaddr_dma;
 		flags &= ~VM_MAYWRITE;
 		break;
 	case SUBCTXT_UREGS:
@@ -529,14 +561,15 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 	}
 
 	vma->vm_flags = flags;
-	hfi1_cdbg(PROC,
-		  "%u:%u type:%u io/vf:%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%lx\n",
-		    ctxt, subctxt, type, mapio, vmf, memaddr, memlen,
-		    vma->vm_end - vma->vm_start, vma->vm_flags);
+	mmap_cdbg(ctxt, subctxt, type, mapio, vmf, memaddr, memvirt, memdma, 
+		  memlen, vma);
 	if (vmf) {
 		vma->vm_pgoff = PFN_DOWN(memaddr);
 		vma->vm_ops = &vm_ops;
 		ret = 0;
+	} else if (memdma) {
+		ret = dma_mmap_coherent(&dd->pcidev->dev, vma,
+					memvirt, memdma, memlen);
 	} else if (mapio) {
 		ret = io_remap_pfn_range(vma, vma->vm_start,
 					 PFN_DOWN(memaddr),
-- 
2.53.0

