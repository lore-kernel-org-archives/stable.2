Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9329F35DA7B;
	Fri, 31 Jul 2026 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477285; cv=none; b=XxpSNuvJ3LHbCbnG36JWU3hoaFNB5phRqpyMX9TR/IrGSNJ43pea5vxXtS74RRAmKJ6W0jrgQPLomoAuUDkiiUwtrCMvbnoWUXxHjLqNQTleEkIMgf3c+0a2nHPUFUTf38hz4swX9+n2VtftnCY5QoTYQip7Cnh3sjodYM0l0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477285; c=relaxed/simple;
	bh=AGmLDLYM3hd8Bo5EwLYvV6ZcLEieM+g057QtIEdzj/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1af7Dia0KGvxM5Lh2DOSAx4bcL12tCS1OINerdoxyYPDBWmIMF/ElSwwNpGWqnMCm15BcCpRWGoU6FTe5nLA3qrnxGqN7X17OjpN19Fy64CRM1AMiP5qEen1yTIu77UeKdVG2H3k0pdiWsaJTCjAtf3go36bAy+hbf07z5DZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2L5zu/g; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2L5zu/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785477283; x=1817013283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AGmLDLYM3hd8Bo5EwLYvV6ZcLEieM+g057QtIEdzj/o=;
  b=X2L5zu/g3LztpZJ03orYa5gue0gGo9krrNm9YDkjYF/Slocyu03JMnwy
   lOBIRFh83g18Y3ufO60SkbWRCGCgtr0lsR8iQb+9xM3DT288wXonRwfTm
   iHoWWJ7v0LkII020ZgSKnf2TOkNhJNSwVtJqkihHmH2gYc/q/90MT33h8
   b0jIxPY3hRK4RCcCmbXAhy2yHgwxj4eNRzRT0biVrt43Jvyw+67YMwtS+
   6qvOq0Hr6pTT6Vy/kNh4mVFWdzUBV55rtlbMlEkeshXtq2hHDH+6bTpSA
   jZDt67SbL/3os/9nLLdQFB6hIuQQ2i08ExAZ4l5sR+3ebwRLIY69UsYVc
   Q==;
X-CSE-ConnectionGUID: nXF+Nar8Sim1uJItLJ8ZjQ==
X-CSE-MsgGUID: vEB329K/RpatOAp3dhyeHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="97615874"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="97615874"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 22:54:43 -0700
X-CSE-ConnectionGUID: jDbFrx7VQlC0nfth6zHrqQ==
X-CSE-MsgGUID: VifPtfz+QFmq6S2ejdXP/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="298695467"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 30 Jul 2026 22:54:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 1/5] iommu/vt-d: Fix shift overflow in qi_desc_dev_iotlb_pasid()
Date: Fri, 31 Jul 2026 13:43:25 +0800
Message-ID: <20260731054329.2948252-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
References: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers request a full Device-TLB flush by passing MAX_AGAW_PFN_WIDTH
(64 - VTD_PAGE_SHIFT == 52) as @size_order.  Two shifts in
qi_desc_dev_iotlb_pasid() are not prepared for a value that large:

  unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
  ...
  if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order))

The first evaluates to 1UL << 63.  On 32-bit builds this is undefined
behaviour; in practice x86 masks the shift count to 5 bits, so the
expression yields 1UL << 31 and ~mask becomes 0x7fffffff.  That value is
zero-extended when it is applied to the 64-bit descriptor, so

  desc->qw1 &= ~mask;

clears qw1[63:32] as well as bit 31.  The ADDR field, which had just been
filled with ones to request the widest possible range, collapses to
0x7ffff000.  As the S bit remains set, hardware decodes the least
significant zero bit of ADDR and invalidates only 2GiB instead of the
entire address space.  Device-TLB entries above that boundary survive the
unmap, leaving an ATS-capable device able to keep accessing memory that
has already been freed.

The second shift, VTD_PAGE_SIZE << size_order, is 1UL << 64 and is
therefore undefined on 64-bit builds too.  On x86_64 the shift count
masks to zero, IS_ALIGNED(addr, 1) is trivially true and the sanity check
silently degrades into a no-op.

Compute both quantities in 64-bit and clamp @size_order to the largest
range the ADDR field can encode.  Capping at 63 - VTD_PAGE_SHIFT keeps
the intended "flush everything" behaviour: qw1[62:12] is set, bit 62 is
cleared as the size indicator and the S bit is set.  The non-PASID
variant qi_desc_dev_iotlb() already uses 1ULL and is unaffected.

Fixes: f701c9f36bcb7 ("iommu/vt-d: Factor out invalidation descriptor composition")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260623060122.3796325-1-guanghuifeng%40linux.alibaba.com
Assisted-by: Claude:claude-opus-5
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index c00f44db0020..8a59c7c9d0a6 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1105,12 +1105,20 @@ static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
 					   unsigned int size_order,
 					   struct qi_desc *desc)
 {
-	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
-
 	desc->qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
 		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
 		QI_DEV_IOTLB_PFSID(pfsid);
 
+	/*
+	 * The invalidation range is encoded in the ADDR field, which only
+	 * covers bits 63:12.  Clamp @size_order so that callers asking for a
+	 * full flush (e.g. with MAX_AGAW_PFN_WIDTH) do not overflow the
+	 * shifts below.  The clamped value still spans the whole range that
+	 * the descriptor is able to express.
+	 */
+	if (size_order > 63 - VTD_PAGE_SHIFT)
+		size_order = 63 - VTD_PAGE_SHIFT;
+
 	/*
 	 * If S bit is 0, we only flush a single page. If S bit is set,
 	 * The least significant zero bit indicates the invalidation address
@@ -1120,7 +1128,7 @@ static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
 	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
 	 * ECAP.
 	 */
-	if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order))
+	if (!IS_ALIGNED(addr, BIT_ULL(VTD_PAGE_SHIFT + size_order)))
 		pr_warn_ratelimited("Invalidate non-aligned address %llx, order %d\n",
 				    addr, size_order);
 
@@ -1136,7 +1144,7 @@ static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
 		desc->qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT - 1,
 					VTD_PAGE_SHIFT);
 		/* Clear size_order bit to indicate size */
-		desc->qw1 &= ~mask;
+		desc->qw1 &= ~BIT_ULL(VTD_PAGE_SHIFT + size_order - 1);
 		/* Set the S bit to indicate flushing more than 1 page */
 		desc->qw1 |= QI_DEV_EIOTLB_SIZE;
 	}
-- 
2.43.0

