Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046704;
	b=1YCkrnhIlKU1qhqAO+dqOTO3v0BayIzmaFtHtNskV2lG5Qo/g+2/cV+d1Q/cVZddPvhs
	 /UnvnUmkexSNpMDSJy8Lo689l96x53r3dpTNXZAbxHjRLLZcuhow/lEJFstUclDVKHl/z
	 phLggdG1oMqFdEZyuKy9KwPER74Nrdl9yShShHve4lbu9A/Eqyc8PKvmMiWWbayTfdefQ
	 +YE4mrBWmP7O+xUvISbbucLRAzhaiqE/9DMmSi/pALtACmvwLkXZ8WI+MyB/qEQ3hJNH1
	 TFamRZRSCuexlVX7cwI1BwcXsAGHCwfQlhL2iw6qSBToyQ2WLCGsTx00eQCaymJnv5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046704;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kfotkdc4WZh3oFBvTGAMo68EGqByMM9wyYDxRG/45aU=;
	b=AicE3Ktg409nWygyX7VvyD/4fk1YqolUPQPhXBVdnXiI8yiazdT0qKfsxUmeHmdja/ah
	 tIgBZAz3OXBnGyjkpENJ0qBbxihiXya9H6FjtL3SJdpOT0hZSB9tx1u+BJxQQVJS49yRb
	 45SkxVEu8lEKhuzItFag28+13JEqa7KV+u1DNXkSaXw9x0rLAQ++vppmaEyl82T7GzyiE
	 U2sPWXkhbM/a2laEFa/CUQd9i2Leod/zOvAH/aozQrE+KYAEuHaV0pFsWmuAioFKViObD
	 isXfj1ITCuZNUTWhOuTZAJ6wm7RUJU3F/naqQdIYWbXgcRA6l8J20xP9vlvtwlFmwSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4nEPLGJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63604606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4nEPLGJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6901F008A2;
	Sat,  7 Nov 2026 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046703;
	bh=kfotkdc4WZh3oFBvTGAMo68EGqByMM9wyYDxRG/45aU=;
	h=From:To:Cc:Subject:Date;
	b=D4nEPLGJvamGUSZpXDREqD0kQAcjYsoKpNlqWNaVNGRQWX+2k1HqqXustuc2Inv/H
	 6hZSFbqulvLirNhxsNmU8UIlbW0Hw61ffrjS+hhrOOrkiNpDc+ueHzHNs6UCDI9s6h
	 ImFODRiR/7WG3UZ4bpDod2mN8Rxsmd60hA73ZM/tfQHGFd7Ylxh6vzNNzDEK0TEXvf
	 kOS5eg+pdHSbT9NkPmmP1EGHHs2J7A0U5zhGu+/7CDvF+U6AILFl8UPguR4sSz16jE
	 1m4mxHZHz1frveayVmQv8tYpb03Njr1dX1z5nnN0RrFlpQZVS/WNNKrZ807lWhmyQZ
	 50OUdo3drMjCw==
From: Sasha Levin <sashal@kernel.org>
To: gbatra@linux.ibm.com,
	ritesh.list@gmail.com,
	maddy@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:22 -0500
Message-ID: <20261107051822-failed-6.12-0b8b0c17a899@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0b8b0c17a8998709ecb2852d56442ea981102941
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051822-failed-6.12-0b8b0c17a899@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0b8b0c17a8998709ecb2852d56442ea981102941 Mon Sep 17 00:00:00 2001
From: Gaurav Batra <gbatra@linux.ibm.com>
Date: Thu, 6 Aug 2026 15:50:27 -0500
Subject: [PATCH] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is
 pre-mapped

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
---
 arch/powerpc/platforms/pseries/iommu.c | 67 +++++++++++++++++---------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 272e9aab66d4f..32d414c2cb843 100644
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
@@ -1284,15 +1286,19 @@ struct failed_ddw_pdn {
 
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
@@ -1447,7 +1453,7 @@ static struct property *ddw_property_create(const char *propname, u32 liobn, u64
 static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mask)
 {
 	int len = 0, ret;
-	int max_ram_len = order_base_2(ddw_memory_hotplug_max());
+	int max_ram_len = order_base_2(pseries_ddw_max_ram);
 	struct ddw_query_response query;
 	struct ddw_create_response create;
 	int page_shift;
@@ -1617,12 +1623,12 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
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
@@ -1669,7 +1675,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
 
 	if (direct_mapping) {
 		/* DDW maps the whole partition, so enable direct DMA mapping */
-		ret = walk_system_ram_range(0, ddw_memory_hotplug_max() >> PAGE_SHIFT,
+		ret = walk_system_ram_range(0, pseries_ddw_max_ram >> PAGE_SHIFT,
 					    win64->value, tce_setrange_multi_pSeriesLP_walk);
 		if (ret) {
 			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
@@ -1772,8 +1778,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
 
 	/* For pre-mapped memory, set bus_dma_limit to the max RAM */
 	if (direct_mapping)
-		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset +
-						(1ULL << max_ram_len);
+		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset + pseries_ddw_max_ram;
 
 	dev_info(&dev->dev, "lsa_required: %x, lsa_enabled: %x, direct mapping: %x\n",
 			limited_addr_req, limited_addr_enabled, direct_mapping);
@@ -2420,23 +2425,35 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
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
@@ -2444,12 +2461,10 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
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
@@ -2533,6 +2548,14 @@ void __init iommu_init_early_pSeries(void)
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




