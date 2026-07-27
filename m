Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C183CF670
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190489; cv=none; b=b4/PC1ccG1Se8bbJSbWqQQBE1xdsD3FSt98gFJlPTQ7o/JcQBbuRvtFsXP7Ocv2JleIU+E9eFygNhFw0oEhN7BQ8vV3hYQQgrXyfAKWh+UKqI4WSMaw2x2IWwEyn5vfqoh8Ggx4fP2FRmN/mgOyOIXNYOKkLMneSGMMNUDoekVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190489; c=relaxed/simple;
	bh=Ni3hamzJJWEd5X9yHMx+pG+9S7Tb3LgLipUZQeA/KQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQ2VUYw+P5vQZX04f4Yzz+fLsE45fbXdKhbuH8aRCqDQTXVxn+lN/3rDpZqVMIpAGyZximthGiOEfYuG4qrtWbnufH8SqzxhfhjmMuhgL39HrOxSJXINJ9XrQAI6+dlf3tXMEPQRzW9lcZVe8Kjoxwo8mOIDXyPCTrdHBUNZlFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DyJDdQ7v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DyJDdQ7v"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RLlrwP3428395;
	Mon, 27 Jul 2026 22:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=t5WS2Sr3ZzaP17DD3RQ75t1AqOceck68XCxyw7+kn
	v8=; b=DyJDdQ7vQgiB8LLyQGe54Vk4KKQv17wuLc7V2/RxYG7buzOIZZZC7PZOl
	ZnCLFARTCVRJtExAcPY7jLbMiuZfeDMxbDmq27pJsQ0D+3pE02s+9u8M/MyXb8iN
	B0ot6HvvHCzw68QiYO6gqcRQkR0WS2Inecz4QTukwnr9Wox9k2In81EGv9oWE3LY
	mF5D+gsK5ws1xihANvXCu9S4d+BTlAWEOSRLTtRlNyQQir/v0ciOymNAPseLR4fs
	P4rRX36hzj5w+13T/xZEGLJC8F8ECj+vCPIOMT9a6wg3AZv+VYYPzJhtdlkO6kol
	NZj4vpfcVpLdPzNN/oR0anx+GehNA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xjb35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 22:14:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RMBLQq029692;
	Mon, 27 Jul 2026 22:14:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh752y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 22:14:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RMEeAM61604120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 22:14:40 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BAF15804E;
	Mon, 27 Jul 2026 22:14:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 032C15803F;
	Mon, 27 Jul 2026 22:14:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.58.71])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 22:14:38 +0000 (GMT)
From: Gaurav Batra <gbatra@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
        donettom@linux.ibm.com, harshpb@linux.ibm.com, ritesh.list@gmail.com,
        Gaurav Batra <gbatra@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v4] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
Date: Mon, 27 Jul 2026 17:14:37 -0500
Message-ID: <20260727221437.89644-1-gbatra@linux.ibm.com>
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
X-Proofpoint-GUID: 1iqzccp7tQN0hMVg8xK72F7hYwBYZcKG
X-Proofpoint-ORIG-GUID: HqCsRPemVYGtfvyZcDzktM-nClHVACfD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE5NiBTYWx0ZWRfX3smkMy+2owH7
 C/sOrgfBtVkn3vvrjUBYb1Q7SdQYUj8CqKxagE2GomznAvscKMspqvtlotRUX39KfiELyIf7vE5
 G/cf1teojQq1e54zKIoIRfSiZuYuD5w=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a67d853 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8VRwuDZYO3urSD4AI04A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE5NiBTYWx0ZWRfX5BUvknVPogCG
 qi68Loj4oVNZ6wCsLafHhlz0/McX6fNPrF/KWkmEXQ7sawIG3u9UJMmq8tYXu4hnN+k+AYfnjMM
 pMNda+nuh8S4pO9ClbaGF0r8Iu9PIecqsTJSZfYJBbq73XQFFh9EOyCozX9AGaltkcn2NM1oO0S
 CTId2jRIIleWNyz90fqWl0JqoU3xfimAe1KewGRXi9Rd1xEcrw4N2tn02yN87iNFd9zcfrVxVe5
 /HAcy8BG/n4v/5WE5uZN5BRfKcphSpYjnzlGaJwM9Yh4VC1gPy/hWAhHFDbiQ/9fDpJzQH7W7iJ
 3Zolh4t4UyCl6YjwdDC+M8NiueRZRj7Vp8CEVsT4UjnWqkBBtkdqWQIpaEF1GJH+PuJIQAXo1Dq
 hp7dAmj8Sbz3RKZT+pxPiKadECYHH+l2Y+JAghgVebK01P3EsaKeKHdlM6bgHdzRV9Ayj4PKTIC
 C6IWjjSyTVn+za5tYQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_06,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270196

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


 arch/powerpc/platforms/pseries/iommu.c | 60 ++++++++++++++++++--------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3e1f915fe4f6..7f63adafaf91 100644
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
@@ -1668,7 +1674,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
 
 	if (direct_mapping) {
 		/* DDW maps the whole partition, so enable direct DMA mapping */
-		ret = walk_system_ram_range(0, ddw_memory_hotplug_max() >> PAGE_SHIFT,
+		ret = walk_system_ram_range(0, pseries_ddw_max_ram >> PAGE_SHIFT,
 					    win64->value, tce_setrange_multi_pSeriesLP_walk);
 		if (ret) {
 			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
@@ -2419,23 +2425,35 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
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
@@ -2443,12 +2461,10 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
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
@@ -2532,6 +2548,14 @@ void __init iommu_init_early_pSeries(void)
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
2.39.3

