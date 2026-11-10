Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316669;
	b=Sq6Hzn9GNX8Nj6cYoKFerNvjjRqjDfADaOc5CNHEvQDHJwELCkk8FqbdaUPDGRlW1nEu
	 Emg75Q0LzBEbOJzEgzS5K2EEfg9lXfbh0pQxOrvdMmYj9qUvVR3mWOJJh/Mf4530jHD78
	 EK/o9QyxO8FSPcSprxa7enW94KZlezHzQNcLyLUBziXHDJF9PJl/Bsw80UplhEJoFII44
	 FyI0No3w/q3rN19V6fS+lJ8a7XPOX3TUyLKxikM0HLMkgY4B9h2sAE2FwxTP6WCh8aovj
	 y3Tv0hwcQGcicnu1BGxdxrdejIIs8hNc1dox7XqNcLqLqvF/a1aeQw1kzPqDLWCDpOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GtPrA+tAN68ubf/Fz6tkH19D1mBjQsSSIqSIqeEV/LM=;
	b=Zf3zYrcGFYaEW6KNRs5LmPQqZMQmYUp6jS2D7386SMO9/Z/pI2jM41/t0nCvSMoBl97A
	 Q/AMFsoduQiEHszv+4srh1j+CSqnqqsPEB8wlngJbPsRj1kwRTTNjd693gC2vAtm+VTjv
	 s9aov8IYDkYR+yphFM8xcVUA9xFx+mkaYGdjUFzlPMgmw7NOxMz4UHJW9V91z1BbXjFmJ
	 8Zceavz12ea9V36oujGHYJT6ZVruc5ZXfa/PsHzkNeu3TjaGnw3Dd9YUnmFEhyPZ9bB/f
	 J1/Y6Fi4QU4TnnSntjhvr/C4186WCb3qMqOwmHugsKFWrRoErYVjh7kjl6nubFiWvlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRJZipcP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F95606B6D5
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRJZipcP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8DE1F008A1;
	Tue, 10 Nov 2026 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316669;
	bh=GtPrA+tAN68ubf/Fz6tkH19D1mBjQsSSIqSIqeEV/LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jRJZipcPIGEcN+Uy2xy5Xn3fKKqbIVLMRlZ3YPPSpOsf3LqZluR4VkXtjArU/lMkh
	 TNJiAwlnhaQijmuQCGltPOkPqNNs0omkGcmJUG09b50aHPC+8WGgtbBRcJN/md/fTV
	 knuJGuCDyMqgRRS++cRLoq38jyIp400cu0skW2Iw+73+oH0LkykjEHzaxaXslS2Rll
	 A/76Hkj6IsKsyxD25OjR6VurK7ghX2PtBd0hamUJGhciYS8+35QGy7zguhU8DxkKd+
	 ZvZ6qx7+eGBDx8lN14Ydqx21bEpFu0oR/vMJWCaLaz6RgGkobKkF8kA/NZkpo6LZhY
	 6o/CiAXTwWkwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gaurav Batra <gbatra@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
Date: Tue, 10 Nov 2026 08:17:47 -0500
Message-ID: <20261110131722.1663388-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053053-failed-6.6-0b8b0c17a899@kernel.org>
References: <20261107053053-failed-6.6-0b8b0c17a899@kernel.org>
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

From: Gaurav Batra <gbatra@linux.ibm.com>

[ Upstream commit 0b8b0c17a8998709ecb2852d56442ea981102941 ]

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
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260806205027.86428-1-gbatra@linux.ibm.com
[ sashal: Adapted DMA-window updates to code without hybrid-window support while preserving the existing DMA-limit condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/iommu.c | 62 ++++++++++++++++++--------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 6a45e3e86f79b..69d596aff0b27 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -118,6 +118,8 @@ static struct iommu_table *iommu_pseries_alloc_table(int node)
 	return tbl;
 }
 
+static phys_addr_t pseries_ddw_max_ram __ro_after_init;
+
 static struct iommu_table_group_ops spapr_tce_table_group_ops;
 
 static struct iommu_table_group *iommu_pseries_alloc_group(int node)
@@ -1235,15 +1237,19 @@ struct failed_ddw_pdn {
 
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
@@ -1350,7 +1356,7 @@ static struct property *ddw_property_create(const char *propname, u32 liobn, u64
 static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 {
 	int len = 0, ret;
-	int max_ram_len = order_base_2(ddw_memory_hotplug_max());
+	int max_ram_len = order_base_2(pseries_ddw_max_ram);
 	struct ddw_query_response query;
 	struct ddw_create_response create;
 	int page_shift;
@@ -1521,7 +1527,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		window->direct = true;
 
 		/* DDW maps the whole partition, so enable direct DMA mapping */
-		ret = walk_system_ram_range(0, ddw_memory_hotplug_max() >> PAGE_SHIFT,
+		ret = walk_system_ram_range(0, pseries_ddw_max_ram >> PAGE_SHIFT,
 					    win64->value, tce_setrange_multi_pSeriesLP_walk);
 		if (ret) {
 			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
@@ -1616,7 +1622,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * memory and need to set the DMA limit.
 	 */
 	if (pmem_present && direct_mapping && len == max_ram_len)
-		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset + (1ULL << len);
+		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset + pseries_ddw_max_ram;
 
 	return direct_mapping;
 }
@@ -1798,23 +1804,35 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
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
@@ -1822,12 +1840,10 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
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
@@ -1911,6 +1927,14 @@ void __init iommu_init_early_pSeries(void)
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
-- 
2.53.0

