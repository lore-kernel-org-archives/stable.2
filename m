Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6D2931FE;
	Tue, 14 Jul 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784067702; cv=none; b=mBLojryxO4Y1RjZdxIoW9URIY+Y2tPabdbZon6MLRO0Gh1iCtEL+sX+aIFDaZqflJsDO6nsQsqreLBz36Q7pjTv2crBk8a9EFWsiHwxihmb3mpZQaTbtTxbZl95N0FRLTsYSzTe3jPF9qIbPlAM7sc4uq1gCqqpE/+Kk1X5gpDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784067702; c=relaxed/simple;
	bh=IaD5t0LBOWr6KMudIZ1Y148ufQxnJjDnaqzUil2vMrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F+X4Y/g5IIk33ueiUT5yPRr6maGjChiaCOr157oG8kbryapebHY4jyodU3OZBLCWZ8qOOAp4M+2z6PhU2ZRYRBhmSe9+WSBVhkcD8HigVtJ42siKk1SrW86dqqT9Klkp+Pqd5L+SD3Z2nr6enaCSyR2eDn6li3K+Hfia/DdA8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=mdJ4xqfR; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="mdJ4xqfR"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1784067684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0lt14j5LIzqlXoMtLk8NSNIDUzznDwimtXlMInsAM4A=;
	b=mdJ4xqfRbONBHqx5E8K/zKDQinIH1hHH4wC7JZUMwSVSkwWvhvb9nuvLYMurmxTBDTQAWB
	hdz9iHqbAuHnZa9h6b1/AxWH+ED9QlHRrJz5+bHJse+TnbguCVnNzev7yaMnxUBNyua4nR
	j/6pky+UnIcQ3Xb67WCjWkPV7/zXb54=
To: stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Adrian Bunk <bunk@stusta.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12.y] iommu/vt-d: Clear Present bit before tearing down context entry
Date: Wed, 15 Jul 2026 01:21:23 +0300
Message-ID: <20260714222124.1906678-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit c1e4f1dccbe9d7656d1c6872ebeadb5992d0aaa2 ]

When tearing down a context entry, the current implementation zeros the
entire 128-bit entry using multiple 64-bit writes. This creates a window
where the hardware can fetch a "torn" entry — where some fields are
already zeroed while the 'Present' bit is still set — leading to
unpredictable behavior or spurious faults.

While x86 provides strong write ordering, the compiler may reorder writes
to the two 64-bit halves of the context entry. Even without compiler
reordering, the hardware fetch is not guaranteed to be atomic with
respect to multiple CPU writes.

Align with the "Guidance to Software for Invalidations" in the VT-d spec
(Section 6.5.3.3) by implementing the recommended ownership handshake:

1. Clear only the 'Present' (P) bit of the context entry first to
   signal the transition of ownership from hardware to software.
2. Use dma_wmb() to ensure the cleared bit is visible to the IOMMU.
3. Perform the required cache and context-cache invalidation to ensure
   hardware no longer has cached references to the entry.
4. Fully zero out the entry only after the invalidation is complete.

Also, add a dma_wmb() to context_set_present() to ensure the entry
is fully initialized before the 'Present' bit becomes visible.

Fixes: ba39592764ed2 ("Intel IOMMU: Intel IOMMU driver")
Reported-by: Dmytro Maluka <dmaluka@chromium.org>
Closes: https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Dmytro Maluka <dmaluka@chromium.org>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260120061816.2132558-3-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
Backport of the CVE-2026-45944 fix to 6.12.y LTS
The fix first appeared in mainline v7.0-rc1,
then was backported to 6.19.y stable and 6.18 LTS branches,
but was not backported to earlier LTS kernels.

Probably, upstream commit was not backported to 6.12.y
as it does not apply cleanly due to minor diff context change.

The patch applies on top of linux-6.12.y tag v6.12.95

 drivers/iommu/intel/iommu.c |  4 +++-
 drivers/iommu/intel/iommu.h | 21 ++++++++++++++++++++-
 drivers/iommu/intel/pasid.c |  5 ++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cce5a19b5d33..18022d17c492 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1914,10 +1914,12 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	}
 
 	did = context_domain_id(context);
-	context_clear_entry(context);
+	context_clear_present(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
 	intel_context_flush_present(info, context, did, true);
+	context_clear_entry(context);
+	__iommu_flush_cache(iommu, context, sizeof(*context));
 }
 
 static int domain_setup_first_level(struct intel_iommu *iommu,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b33d8888d7eb..e46eb1d3fba2 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -958,7 +958,26 @@ static inline unsigned long virt_to_dma_pfn(void *p)
 
 static inline void context_set_present(struct context_entry *context)
 {
-	context->lo |= 1;
+	u64 val;
+
+	dma_wmb();
+	val = READ_ONCE(context->lo) | 1;
+	WRITE_ONCE(context->lo, val);
+}
+
+/*
+ * Clear the Present (P) bit (bit 0) of a context table entry. This initiates
+ * the transition of the entry's ownership from hardware to software. The
+ * caller is responsible for fulfilling the invalidation handshake recommended
+ * by the VT-d spec, Section 6.5.3.3 (Guidance to Software for Invalidations).
+ */
+static inline void context_clear_present(struct context_entry *context)
+{
+	u64 val;
+
+	val = READ_ONCE(context->lo) & GENMASK_ULL(63, 1);
+	WRITE_ONCE(context->lo, val);
+	dma_wmb();
 }
 
 static inline void context_set_fault_enable(struct context_entry *context)
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 74be6b547fc0..5e63b5d4577f 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -804,7 +804,7 @@ static int device_pasid_table_setup(struct device *dev, u8 bus, u8 devfn)
 	}
 
 	if (context_copied(iommu, bus, devfn)) {
-		context_clear_entry(context);
+		context_clear_present(context);
 		__iommu_flush_cache(iommu, context, sizeof(*context));
 
 		/*
@@ -824,6 +824,9 @@ static int device_pasid_table_setup(struct device *dev, u8 bus, u8 devfn)
 		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 		devtlb_invalidation_with_pasid(iommu, dev, IOMMU_NO_PASID);
 
+		context_clear_entry(context);
+		__iommu_flush_cache(iommu, context, sizeof(*context));
+
 		/*
 		 * At this point, the device is supposed to finish reset at
 		 * its driver probe stage, so no in-flight DMA will exist,
-- 
2.47.3

