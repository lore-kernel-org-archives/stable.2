Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352614A4F0;
	Thu, 16 Jul 2026 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180893; cv=none; b=sFsYChwgf6TPJ56gaadQ3JfKXqqZRjIqBbdpWiN72mRW10b+QVs53t/mqMO1cXq0eoh38xO4/rYl00vg7eUYsHBqsMk9Z/3pyq6M/kLKYULnP5Kqfm+EMhkD8XR5tC4sVmP6MWQNLBhAYGKi6uikuULhGz/iNSOi4YQ9YOazSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180893; c=relaxed/simple;
	bh=QbUFyYi+EsTelhCpbmY3t0Th5ATBkJa6qvL4V4XKWd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uAp3Zl5JqO9OTEYxn2M9E8tVzUVl9bUOiEkGWRVdNmgYbASuo8nu35r1PaymJIzPBjAsDwsYKHT7vaqk3UpWmNLmfQjikM290Vrrbj+ht4cDjtA+3mvUYtxw7tunujbP0QyfYh7s7QvhrYlLrHuLxzq0jhwYGGt5KdmEmqlYqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsFed8My; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsFed8My"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784180892; x=1815716892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QbUFyYi+EsTelhCpbmY3t0Th5ATBkJa6qvL4V4XKWd8=;
  b=XsFed8My/AAobxOkPXssQ0xCKj12VFalVLFxsn7u4N4Z8mdvtLT0zhyk
   Z9oJWPaAasOLugMIBQYFNFdXXN6xAgTPWsmmq1UrD3/RtgbA2L1umqD2R
   TOEGJN4MlEps8NcJVtC6Hd9o+0ubIN8djy162KAzRMEug/9V192CRsW24
   7XfHTqH0ol7sgR0AY220qCVpjgtK1ifZacBzenU6TJ6eiSIiq6wAiQvil
   zhodxET4DJlef85ZDnNm5B80vnFYKp67Lc9SyiHFsyT7/pXIVPJee/Mo+
   lgofqoUxn/iKjolDXSzx7B/9ylQqvR4F5S93YjAu4VtgifWsQo5mzLkyO
   w==;
X-CSE-ConnectionGUID: oRvA3ckKSh2YaHnSokb/4w==
X-CSE-MsgGUID: rqCk4qkLRSCDBAGZCtcwCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84870518"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="84870518"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 22:48:11 -0700
X-CSE-ConnectionGUID: sLCXD+pMS0eVHv059TSHIA==
X-CSE-MsgGUID: gFZDL19LQ5yHLneEP+8HEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="261320008"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jul 2026 22:48:09 -0700
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
Subject: [PATCH 1/1] iommu/vt-d: Disallow SVA if page walk is not coherent
Date: Thu, 16 Jul 2026 13:35:53 +0800
Message-ID: <20260716053554.1642374-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardware implementations report Scalable-Mode Page-walk Coherency Support
via the SMPWCS field in the extended capability register. If the hardware
does not support page-walk coherency, a clflush is required every time
the page table entries (which are walked by the IOMMU hardware) are
updated.

In the SVA case, page tables are managed by the CPU mm core, not by the
IOMMU driver. Because the IOMMU driver has no way of knowing whether the
CPU page table management code has ensured coherency via clflush, the
driver must deny SVA if the hardware does not support coherent paging.

Fixes: ff3dc6521f78 ("iommu/vt-d: Fix CPU and IOMMU SVM feature matching checks")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0636987f03c8..432e35723ce9 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -27,7 +27,7 @@
 
 void intel_svm_check(struct intel_iommu *iommu)
 {
-	if (!pasid_supported(iommu))
+	if (!pasid_supported(iommu) || !ecap_smpwc(iommu->ecap))
 		return;
 
 	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
-- 
2.43.0

