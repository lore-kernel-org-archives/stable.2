Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0747F783
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049437; cv=none; b=YSbXMJiTKDh8oaYI2B7IyQxcE87Ob5DgiodnljzNKwxY6FnxuaETteJcxVstwMxITkQoKU4c1mkH9ZMGYKuW9FMSUQdzs1KShKyamXG5i50kc91cuDi6/HBmHURknm5pOgvBKymfRiW2L9KRJhkvmRZYt5DRuxROy1tGvwAg3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049437; c=relaxed/simple;
	bh=EQF7GNk6tiPN/HkOB6VAbe9iFsOBWJXjGQEctQ2UaPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IX+5ke+2EGusq9+Mz57lQxJ5A8rMz6de0hxipL8DtMxA4osMohw4SxTlJgO1rpdTglPSDCX12FGnBy6yH8SZ+uYDxg7rZaLuc9uCut6KtPifKayJnKlUCLRW8xHZt9fFxWkq5kJMHUV+KpsCP1wQ0ELs6HvTSABizW6cYgyctQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BLif2XcO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BLif2XcO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676II4VD3397345;
	Thu, 6 Aug 2026 20:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gbrq6nwxK+oZnoy2ZRGW+SZU9m5lNJw0I8nZJay57
	OE=; b=BLif2XcOL4skiOHiJl5ftudA0Ba8r8Ye63gfO9RlEywIjriIMW55CrWYW
	YqXWcZqBug/CLg6W85n5GlfUOBpUkPbCbONCRocyduC798/scAWHqLFj5S9OwB7C
	a9DZg9vGs1ZuoS/w3MiI9Vh9zn8hH/9YbvA1blJHc7xMfyACH2YQknXk+JE6//gz
	1Ya9rt2BjXUsJcs8gMf+n5xTAbu9NgaJSKpljhq8ngrLCnHXwosD0XmzLoxOZC+F
	6b8v00NrUXNe7253R9KSuA46yZjsJ7DKKQ9CByCD7ZpWOJU7PkTy2VtJo1ifAsII
	eXFav97sUKe/HiFHfT1LKMcFIykFg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy040rmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 20:50:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676KfLvb018639;
	Thu, 6 Aug 2026 20:50:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyvq8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 20:50:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676KoTmD26608174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 20:50:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B44F858055;
	Thu,  6 Aug 2026 20:50:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADECF58043;
	Thu,  6 Aug 2026 20:50:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.5.100])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 20:50:28 +0000 (GMT)
From: Gaurav Batra <gbatra@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: ltc-dev@lists.linux.ibm.com, sbhat@linux.ibm.com, ritesh.list@gmail.com,
        vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, donettom@linux.ibm.com,
        Gaurav Batra <gbatra@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v5] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
Date: Thu,  6 Aug 2026 15:50:27 -0500
Message-ID: <20260806205027.86428-1-gbatra@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2MiBTYWx0ZWRfXyBAiEvs1NmRy
 muc+EkdNBBg37RPDJv+qerX00vrPfDD9JLt6qq5eGptDgIPpW6nkJ0PMh8ElvpsmJttDS60+wou
 VxJGD6mdGE7l5jRhNpKWWgkCyP7ODt1qEn0So462NdwqTYS18PiemUsLtHiLl+yZFWfScPEPcD1
 aknWWIH7vR1CoR6EpKGodugtVoyoDbY3zvrzjJKcypZhPVP0FckCafrgC2ejq4Nq2lwJKwQJaLk
 VDylwLwU23yUkExXsW4I8QorRldbtv1HslMdCeqG/KEbwqnpM09/EvGRgnsWbi9r+W8Q59Xvvbc
 66KXeh1oyfG1Rj3+v6AlKz/i7k201WM4LowfQL0ELu+Q4IEgwO5r/Qe2WRgpNSjL+bnNXfuKbKV
 SNrvpXvTKc+FY6e2/nIkANqBUYl6Rs5JNHY9niT9qpfMsvk0BBPfXgJwSHeTMtb4Ctnlp1mwfFN
 +CSOYXvN5dg5xB130tQ==
X-Proofpoint-ORIG-GUID: t9ypXVUFN_hc1uRU8Ts92howsyLH19FF
X-Proofpoint-GUID: ZYCm2wCffpcea7G0ThL9VFo9njnJww4-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2MiBTYWx0ZWRfX5UE7ooadjLq5
 GR3G82WWYsagjXqpEPOrYmf+jWOWdlgexZq99mTo0ddvTvbo6UF2LbmqeKhxwMTkx1kc3aRO0DY
 Ipv8K7UhJo5xE+MPJwIQY8dZUS9rQG4=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a74f398 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WekxTMVww-InBI13NycA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060162

In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
This OF property dictates what is the max size of RAM an LPAR can have,
including DR added memory.

In PowerPC, 16GB pages can be allocated at machine level and then
assigned to LPARs. These 16GB pages are added to LPAR memory at the time
of boot. The address range for these 16GB pages is above MAX RAM an LPAR
can have (ibm,lrdr-capacity). In the current implementation, these 16GB
pages are being excluded from pre-mapped TCEs. A driver can have DMA
buffers allocated from 16GB pages. This results in platform to raise an
EEH when DMA is attempted on buffers in 16GB memory range.

commit 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly
adds TCEs for pmemory")

Prior to the above patch, memblock_end_of_DRAM() was being used to
determine the MAX memory of an LPAR. This included 16GB pages as well.
The issue with using memblock_end_of_DRAM() is that when pmemory is
converted to RAM via daxctl command, the DDW engine will incorrectly try
to add TCEs for pmemory as well.

Below is the address distribution of RAM, 16GB pages and pmemory for an
LPAR with max memory of 256GB, memory allocated 64GB, 2 16GB pages and
assigned pmemory of 8GB.

RANGE                                 SIZE  STATE REMOVABLE     BLOCK
0x0000000000000000-0x0000000fffffffff  64G online       yes     0-255
0x0000004000000000-0x00000047ffffffff  32G online       yes 1024-1151

cat /sys/bus/nd/devices/region0/resource
0x40100000000
cat /sys/bus/nd/devices/region0/size
8589934592

The approach to fix this problem is to revert back the code changes
introduced by the above patch and to stash away the MAX memory of an
LPAR, including 16GB pages, at the LPAR boot time. This value is then
used whenever TCEs are needed to be pre-mapped - enable_DDW() or,
iommu_mem_notifier()

Fixes: 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly adds TCEs for pmemory")
Cc: stable@vger.kernel.org
Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
---

Change log:

V4 -> V5

1. Ritesh: Change device bus_dma_limit to pseries_ddw_max_ram

   Response: Incorporated changes

V3 -> V4

1. Ritesh: Change pseries_ddw_max_ram to __ro_after_init;

   Response: Incorporated changes

2. Ritesh: Mark function ddw_memory_hotplug_max() as __init function

   Response: Incorporated changes

3. Ritesh: This patch was made in v6.15. Since we want this to be backported, I
   would suggested add a CC stable tag as well.

   Response: Incorporated changes

V2 -> V3

1. Harsh: Remove R-b tags from the change log

   Response: Incorporated changes

2. Harsh: Change WARN_ON() to WARN_ONCE()

   Response: Incorporated changes

3. Harsh: Fix indendation

   Response: Incorporated changes

4. Harsh: Replace comment with a log if limit < arg->nr_pages ? 

   Response: Doesn't seems to be needed since the WARN_ONCE() will log this
   scenario. I removed the comment instead.

V1 -> V2

1. Harsh: Not only start_pfn, but end_pfn also needs to be within allowed
   range, which may require clamping arg->nr_pages if crossing the limits.

   Response: Incorporated changes.

 arch/powerpc/platforms/pseries/iommu.c | 67 +++++++++++++++++---------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3e1f915fe4f6..1eef4b671a7c 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -69,6 +69,8 @@ static struct iommu_table *iommu_pseries_alloc_table(int node)
 	return tbl;
 }
 
+static phys_addr_t pseries_ddw_max_ram __ro_after_init;
+
 #ifdef CONFIG_IOMMU_API
 static struct iommu_table_group_ops spapr_tce_table_group_ops;
 #endif
@@ -1283,15 +1285,19 @@ struct failed_ddw_pdn {
 
 static LIST_HEAD(failed_ddw_pdn_list);
 
-static phys_addr_t ddw_memory_hotplug_max(void)
+static phys_addr_t __init ddw_memory_hotplug_max(void)
 {
-	resource_size_t max_addr;
+	resource_size_t max_addr = memory_hotplug_max();
+	struct device_node *memory;
 
-#if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
-	max_addr = hot_add_drconf_memory_max();
-#else
-	max_addr = memblock_end_of_DRAM();
-#endif
+	for_each_node_by_type(memory, "memory") {
+		struct resource res;
+
+		if (of_address_to_resource(memory, 0, &res))
+			continue;
+
+		max_addr = max_t(resource_size_t, max_addr, res.end + 1);
+	}
 
 	return max_addr;
 }
@@ -1446,7 +1452,7 @@ static struct property *ddw_property_create(const char *propname, u32 liobn, u64
 static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mask)
 {
 	int len = 0, ret;
-	int max_ram_len = order_base_2(ddw_memory_hotplug_max());
+	int max_ram_len = order_base_2(pseries_ddw_max_ram);
 	struct ddw_query_response query;
 	struct ddw_create_response create;
 	int page_shift;
@@ -1616,12 +1622,12 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
 		if (default_win_removed && pmem_present && !direct_mapping) {
 			/* DDW is big enough to be split */
 			if ((1ULL << ddw_sz) >=
-			    MIN_DDW_VPMEM_DMA_WINDOW + (1ULL << max_ram_len)) {
+			    MIN_DDW_VPMEM_DMA_WINDOW + pseries_ddw_max_ram) {
 
 				direct_mapping = true;
 
 				/* offset of the Dynamic part of DDW */
-				dynamic_offset = 1ULL << max_ram_len;
+				dynamic_offset = pseries_ddw_max_ram;
 			}
 
 			/* DDW will at least have dynamic allocation */
@@ -1668,7 +1674,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
 
 	if (direct_mapping) {
 		/* DDW maps the whole partition, so enable direct DMA mapping */
-		ret = walk_system_ram_range(0, ddw_memory_hotplug_max() >> PAGE_SHIFT,
+		ret = walk_system_ram_range(0, pseries_ddw_max_ram >> PAGE_SHIFT,
 					    win64->value, tce_setrange_multi_pSeriesLP_walk);
 		if (ret) {
 			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
@@ -1771,8 +1777,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
 
 	/* For pre-mapped memory, set bus_dma_limit to the max RAM */
 	if (direct_mapping)
-		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset +
-						(1ULL << max_ram_len);
+		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset + pseries_ddw_max_ram;
 
 	dev_info(&dev->dev, "lsa_required: %x, lsa_enabled: %x, direct mapping: %x\n",
 			limited_addr_req, limited_addr_enabled, direct_mapping);
@@ -2419,23 +2424,35 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 {
 	struct dma_win *window;
 	struct memory_notify *arg = data;
+	unsigned long limit = arg->nr_pages;
+	unsigned long max_ram_pages = pseries_ddw_max_ram >> PAGE_SHIFT;
 	int ret = 0;
 
 	/* This notifier can get called when onlining persistent memory as well.
 	 * TCEs are not pre-mapped for persistent memory. Persistent memory will
-	 * always be above ddw_memory_hotplug_max()
+	 * always be above pseries_ddw_max_ram
 	 */
+	if (arg->start_pfn >= max_ram_pages)
+		return NOTIFY_OK;
+
+	/* RAM is being DLPAR'ed. The range should never exceed max ram.
+	 * Just in case, clamp the range and throw a warning.
+	 */
+	if (arg->start_pfn + limit > max_ram_pages) {
+		limit = max_ram_pages - arg->start_pfn;
+		WARN_ONCE(1, "Limiting Page Range %lx - %lx to Max Mem Pages: %lx\n",
+					arg->start_pfn, arg->start_pfn + arg->nr_pages,
+					max_ram_pages);
+	}
 
 	switch (action) {
 	case MEM_GOING_ONLINE:
 		spin_lock(&dma_win_list_lock);
 		list_for_each_entry(window, &dma_win_list, list) {
-			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
-				ddw_memory_hotplug_max()) {
+			if (window->direct) {
 				ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
-						arg->nr_pages, window->prop);
+						limit, window->prop);
 			}
-			/* XXX log error */
 		}
 		spin_unlock(&dma_win_list_lock);
 		break;
@@ -2443,12 +2460,10 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 	case MEM_OFFLINE:
 		spin_lock(&dma_win_list_lock);
 		list_for_each_entry(window, &dma_win_list, list) {
-			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
-				ddw_memory_hotplug_max()) {
+			if (window->direct) {
 				ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
-						arg->nr_pages, window->prop);
+						limit, window->prop);
 			}
-			/* XXX log error */
 		}
 		spin_unlock(&dma_win_list_lock);
 		break;
@@ -2532,6 +2547,14 @@ void __init iommu_init_early_pSeries(void)
 	register_memory_notifier(&iommu_mem_nb);
 
 	set_pci_dma_ops(&dma_iommu_ops);
+
+	/* During init determine the max memory an LPAR can have and set it. This
+	 * will be used for pre-mapping RAM in DDW. memblock_end_of_DRAM() can
+	 * change during the running of LPAR - daxctl can add pmemory as
+	 * "system-ram". This memory range should not be pre-mapped in DDW since
+	 * the address of pmemory can be much higher than the DDW size.
+	 */
+	pseries_ddw_max_ram = ddw_memory_hotplug_max();
 }
 
 static int __init disable_multitce(char *str)

base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
-- 
2.52.0

