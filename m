Received: from mta1.migadu.com (out-236.mta1.migadu.com [95.215.58.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A72175A62
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786579553; cv=none; b=jMxtbiM9olD0MFr9Rxyrt7RgaHZSoKiwBSmATFaW6KE7FVcHDLe/fZJmUKDEwE0MmuES4FaC9WfzIWqt6z5Efynja9ugwBnvTkN4a9yHo6RxcodWuug5LLzF4HKufQUCB9l8kMjKjjxTty8BnqAj6pnsRLLwqGnZ9wd5d1lmBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786579553; c=relaxed/simple;
	bh=jhMAM9mv34g3Y7kZQBCLpUTuCyQVHcxm40WPa1yHLcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iGNwcrXpV0BX/wB/r4mq5jHMYTC/nZDwLChrmOGBleIXA4+cFP+ci2r0F9qhC0oEYjgoQkOof6E8SSDDkh70kh63qrLAJBlHBxkNDG75I02oueGF8lYIIiq0Na6XMQCngfzz7bONjUqkAatcsAEYrX7FFInyVaLRO1OyBIiuYko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dqjwZLU9; arc=none smtp.client-ip=95.215.58.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dqjwZLU9"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jhMAM9mv34g3Y7kZQBCLpUTuCyQVHcxm40WPa1yHLcs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786579547; v=1; x=1787184347;
 b=dqjwZLU9hKyBFDYSEog4qb3fidaM4ycZwN35mGWJj0XWNpXyQayk4ln7K9RRxzvaQku9Xrgj
 mhwI3U6ZvhU3EVywS+UVeGd9jns7jL/XJipOdNCUXDAoHbClHiUMO9KNOpmPaEHiRndBQiC3rhy
 FH2IOmJ6mXmbcn2H/rFdyYZE=
X-Envelope-To: stable@vger.kernel.org
Received: from coder-jfernandez-main-0.coder-jfernandez-main.remote-dev.svc.cluster.local (52.89.24.131)
	by smtp.migadu.com with ESMTPS id 10e9d07281b2870d;
	Thu, 13 Aug 2026 00:05:37 +0000
X-Migadu-Flow: FLOW_OUT
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Thu, 13 Aug 2026 00:05:26 +0000
Subject: [PATCH 6.18.y] iommu/vt-d: Gather the unmapped range before
 freeing its page tables
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-b4-vtd-unmap-gather-v1-1-4c52f4a7a1ac@linux.dev>
X-B4-Tracking: v=1; b=H4sIAEUKfWoC/12NSRKCMBBFr0L12gYSLQSvYrnI0JI4BKoDqEVxd
 wnuXP7p/RkisacIp2wGpslH34VViF0GxqnQEnq7apClrMpaSNQHnAaLY3iqHls1OGJsjlJb2zS
 lkHtYlz3T1b836hmqXNT5By4/P476RmZIyNTUKhJqVsG4ZD36wnSvju/ExRb9X8GyfAEIN5Cts
 wAAAA==
X-Change-ID: 20260812-b4-vtd-unmap-gather-972bdd990123
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Tom Murphy <murphyt7@tcd.ie>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Mohammed Almaroof <moh@anthropic.com>, 
 Ben Cressey <ben@cressey.dev>, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
X-Mailer: b4 0.15.2

In the 6.12 and 6.18 stable trees, when an unmapped range covers a
whole page table, intel_iommu_unmap() can free that table before the
range has been invalidated. The freed table goes on gather->freelist
before the range is added to the gather. If
iommu_iotlb_gather_add_page() syncs before adding it, that sync
flushes only the earlier ranges but frees the whole freelist, that
table included. The range itself is flushed later with an empty
freelist, which means the flush is sent with the invalidation hint set
and the IOMMU may keep its paging-structure cache entry for the freed
table. DMA to the next mapping at that IOVA is then translated through
whatever the freed page holds by then, which is usually a silent wrong
translation and sometimes a DMAR fault.

Under a userspace driver that maps and unmaps DMA buffers through VFIO
type1 continuously, this shows up as wrong data in device reads and
writes. An occasional DMAR fault on a mapped IOVA is the only thing in
the logs. With an Intel DSA engine assigned through vfio-pci, remapping
a 16 MiB buffer at a fixed IOVA and reading it through the device
returned data from the wrong pages in 280 of 400 iterations. With a
fresh IOVA per iteration it never did.

Add the range to the gather first and splice the freed tables into
gather->freelist afterwards, so that they are only freed by a sync that
also invalidates their range.

Mainline removed this code in v6.19 with commit d373449d8e97
("iommu/vt-d: Use the generic iommu page table") and is not affected.

Fixes: 2a2b8eaa5b25 ("iommu: Handle freelists when using deferred flushing in iommu drivers")
Cc: stable@vger.kernel.org # 6.12.y, 6.18.y
Reported-by: Mohammed Almaroof <moh@anthropic.com>
Reviewed-by: Ben Cressey <ben@cressey.dev>
Assisted-by: Claude:unspecified
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 drivers/iommu/intel/iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cee1851b69245..8b38c65f403b2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3620,6 +3620,7 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 				unsigned long iova, size_t size,
 				struct iommu_iotlb_gather *gather)
 {
+	struct iommu_pages_list freelist = IOMMU_PAGES_LIST_INIT(freelist);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	unsigned long start_pfn, last_pfn;
 	int level = 0;
@@ -3636,7 +3637,7 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	start_pfn = iova >> VTD_PAGE_SHIFT;
 	last_pfn = (iova + size - 1) >> VTD_PAGE_SHIFT;
 
-	domain_unmap(dmar_domain, start_pfn, last_pfn, &gather->freelist);
+	domain_unmap(dmar_domain, start_pfn, last_pfn, &freelist);
 
 	if (dmar_domain->max_addr == iova + size)
 		dmar_domain->max_addr = iova;
@@ -3648,6 +3649,14 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	if (!iommu_iotlb_gather_queued(gather))
 		iommu_iotlb_gather_add_page(domain, gather, iova, size);
 
+	/*
+	 * iommu_iotlb_gather_add_page() may have synced, which frees
+	 * gather->freelist. Hand this range's page tables over only after
+	 * that call. A queued gather frees them from the flush queue
+	 * instead.
+	 */
+	iommu_pages_list_splice(&freelist, &gather->freelist);
+
 	return size;
 }
 

---
base-commit: 1efe5d048a391de3ead2804b2e7f86376c356cc5
change-id: 20260812-b4-vtd-unmap-gather-972bdd990123

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

