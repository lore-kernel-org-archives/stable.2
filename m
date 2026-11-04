Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769836;
	b=mKgrXJn2utrw4hx/w5iYaFt6e2q2KQa0CKE7FKqcB0xAnaLGSAudd1LAeSI9f1i8Tvzd
	 rfyTOXfAcGBo9e7p8ZTxTLpdE2iEnMTXoSdM0f7q3jzHHRCI2k/AupEQeKNYjML2f3MQn
	 3wE5K21ne/zBFiOhd55tAE/2+JvtCzrH11ODgd7uB1Na8iMj9p7sHVQOqFqslJvENUUOp
	 vqyZAq+YmLkhafhLeguDhs8+KZOULjuzA9PrE05x5Awp6RZFH865vjHc9aQHQHraafTLq
	 UhYxqtGbNL73yZuJcNLOBpS78IjLHxDzNvOtuoDY6rkX+Y9e255kYpKmDzuXUma3wmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769836;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e5mp3Z7Qbkp1AkYD1SY+os+264ojHvYErT5DxrRr9Dc=;
	b=N30uUSeJPT+oaDfGtTgBmg6CGDL1n83HIakZAzh+m9m95ucYQC89HIAOhz8cKsOrKgCt
	 /AVFEdTEwSsUYu85FsgYjGxTvSuFAdp+4I92aJdx/BwMa0HIWQoZB21FA+ngOxpt9sc25
	 v3hMKk9h07xUP7nGli3eGK4mtubKPwS6n2ZMWFtqHdBu3TctCYUDAlNlRPjTDCeQdfAWb
	 5wdTbVfRLrWiE2Hz+/PXO/fZHwRfJ7jIv/tFhKNQxfuUbjLoBMNcgL63B97Zei/zXt0bv
	 GNbj4s4afWPu9y2zHbaiFCB4eRBEorcbnykiytmu9Gs4+ovRGwtNSA2owq4rY9gegKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mftOCp9g;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB172606A32D;
	Wed,  4 Nov 2026 05:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB172606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mftOCp9g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793769835; x=1825305835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V26M15SyhQuylMRXls4jCtp9KIu0E6K7iC6rdNtr+mA=;
  b=mftOCp9g2c2dFlF2/Gmu75QHNWIrVQXLa08f9WXMnUqTWC3TWjzvYmgp
   TvvJkncP/B+OS5mu/+crfRTJlAQC/7pR9/1z2Ov/mv4a52lVugL40qqYP
   0XXEN27vDotPp4G1TzsSHU6MZa03oKqMPW78OZZnr6f+b4noyDU+lqUk0
   ZmLBlFWy6d5XpKmC4x2BFolOskE5YFFPIy1D/MigYOCwYaCPIMf5KiO6i
   jc60ESWVXem3y2b65lhEcI69zr0Jry9VsAhrfQTInV3lvYVBgRIpt/N5q
   Gtso9P+gjbzFHDpuUmqyqCAnYP53bD7YCNjPXeEsR/5WfquJb3Eeu66Bx
   g==;
X-CSE-ConnectionGUID: egyLlPpUQBiPLnQclrYABg==
X-CSE-MsgGUID: GgQEp3PRRBGIubyv86c0xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2414132"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2414132"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 21:23:55 -0800
X-CSE-ConnectionGUID: LYQNRniRSC6FZ8VF5vuJPg==
X-CSE-MsgGUID: 2YnP1nSHSEyWQhLQlempeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6777204"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 03 Nov 2026 21:23:52 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] iommu/vt-d: Set FPD when tearing down a PASID entry with fault_ignore
Date: Wed,  4 Nov 2026 13:10:57 +0800
Message-ID: <20261104051059.1345010-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104051059.1345010-1-baolu.lu@linux.intel.com>
References: <20261104051059.1345010-1-baolu.lu@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an SVA process exits, intel_mm_release() tears down its PASID entry
with fault_ignore=true. It does not drain the PRQ at that point. Instead,
it is supposed to leave the FPD bit set. Later, when the device is
unbound, the driver checks for this bit and drains the PRQ.

Commit 75ed00055c05 ("iommu/vt-d: Clear Present bit before tearing down
PASID entry") changed the teardown order. It clears the Present bit
before calling intel_pasid_clear_entry(), which sets the FPD bit only
if the entry is still present. As a result, FPD is not set and the
entire entry is cleared, so the PRQ is not drained for that PASID
during unbind:

  intel_mm_release()
    intel_pasid_tear_down_entry(fault_ignore=true)
      pasid_clear_present()
      intel_pasid_clear_entry()       <- P=0, so FPD is not set
  ...
  iommu_sva_unbind_device()
    iommu_detach_device_pasid()
      blocking_domain_set_dev_pasid()
        intel_pasid_tear_down_entry(fault_ignore=false)
          !present && !FPD            <- return, no PRQ drain
        intel_iommu_disable_iopf()
          iopf_queue_remove_device()  <- groups still queued
  kfree(handle)                       <- handle still used by iopf work

Page requests queued before process exit may later be handled by
iommu_sva_handle_iopf() after the SVA attach handle has been freed,
causing a use-after-free. Fix this by setting FPD in the same write
that clears the Present bit when fault_ignore is requested.

Fixes: 75ed00055c05 ("iommu/vt-d: Clear Present bit before tearing down PASID entry")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h | 11 +++++++++++
 drivers/iommu/intel/pasid.c | 28 ++++++++++------------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 48d3bb6b68de..af798a6ee121 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -251,6 +251,17 @@ static inline void pasid_clear_present(struct pasid_entry *pe)
 	dma_wmb();
 }
 
+/*
+ * Clear the Present bit and set the FPD bit in a single write, so that
+ * hardware never sees the entry non-present without FPD.
+ */
+static inline void pasid_clear_present_set_fpd(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[0], PASID_PTE_PRESENT | PASID_PTE_FPD,
+		       PASID_PTE_FPD);
+	dma_wmb();
+}
+
 /*
  * Setup Page Walk Snoop bit (Bit 87) of a scalable mode PASID
  * entry.
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index e4f24d3f19a6..d1c08d180788 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -178,21 +178,6 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 /*
  * Interfaces for PASID table entry manipulation:
  */
-static void
-intel_pasid_clear_entry(struct device *dev, u32 pasid, bool fault_ignore)
-{
-	struct pasid_entry *pe;
-
-	pe = intel_pasid_get_entry(dev, pasid);
-	if (WARN_ON(!pe))
-		return;
-
-	if (fault_ignore && pasid_pte_is_present(pe))
-		pasid_clear_entry_with_fpd(pe);
-	else
-		pasid_clear_entry(pe);
-}
-
 static void
 pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 				    u16 did, u32 pasid)
@@ -253,7 +238,6 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 
 	if (!pasid_pte_is_present(pte)) {
 		if (!pasid_pte_is_fault_disabled(pte)) {
-			WARN_ON(READ_ONCE(pte->val[0]) != 0);
 			spin_unlock(&iommu->lock);
 			return;
 		}
@@ -266,6 +250,8 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 		 */
 		pasid_clear_entry(pte);
 		spin_unlock(&iommu->lock);
+		if (!ecap_coherent(iommu->ecap))
+			clflush_cache_range(pte, sizeof(*pte));
 		intel_iommu_drain_pasid_prq(dev, pasid);
 
 		return;
@@ -273,7 +259,10 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 
 	did = pasid_get_domain_id(pte);
 	pgtt = pasid_pte_get_pgtt(pte);
-	pasid_clear_present(pte);
+	if (fault_ignore)
+		pasid_clear_present_set_fpd(pte);
+	else
+		pasid_clear_present(pte);
 	spin_unlock(&iommu->lock);
 
 	if (!ecap_coherent(iommu->ecap))
@@ -287,7 +276,10 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
 	devtlb_invalidation_with_pasid(iommu, dev, pasid);
-	intel_pasid_clear_entry(dev, pasid, fault_ignore);
+	if (fault_ignore)
+		pasid_clear_entry_with_fpd(pte);
+	else
+		pasid_clear_entry(pte);
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(pte, sizeof(*pte));
 
-- 
2.43.0

