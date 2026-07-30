Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9836167E
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785377779; cv=none; b=INCGE5NmRxawcUCoZOaAVjvCwlUXSQxyz+/l+m2e0poirl81sAw1WQGC/YB+dvtOR14qauqTWUMgHIltvHNE+GV/xhoaoALKn05OH4OU3sjeAAilM3ga0Ah+TiHoDNkTxY3jJ45Hm2xgvK2/wWWG+c41nMJyLCvTd9UIKJsE/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785377779; c=relaxed/simple;
	bh=aUkHmwPIsmSDtaIWayTSiyA/9IwkK/v2OD7YJufVcCY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=eoI1CATel5fTFlHZClXVjPs+E6GvEGBQ23b+0SuNCnVFv3nEUYai2bFE2fV27ZqgaAIQ6MOMXE0/JE8KIXFCj3PGMDSyKa0gU3ksYhrtoZdO96mKc6mgfGJrCFoJtf/UNynXg0q+5snHSoUjDK78qPQjWO6kh17L2IZGjjGwiZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA2ewlRO; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA2ewlRO"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-caf45fc5202so1318824a12.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785377772; x=1785982572; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Kpk2V6RUucxH6gkGYwDAJ6VjIvLcQZVLrKPxJU8G8/Q=;
        b=LA2ewlROxjik05Fq2XFpQZnMzDsnXigCgovXn9esWOZu7ROBsXwMZ35Tyzgv5bieAz
         7IOAYnUd6+7tYqhS87ubx+6t+jyMK3iSG/aQAcoOIsMe3ynwda30ktV+88uuYp9rY4S0
         WVxilBkqp5YclTO9K7+0Bq+BUTC9v4pKkEU0ShPmZsun2yJLABV1fOxZFm3TWbebuhH9
         fvAIKeOghSFNDtYiLEv+WQcp2IuabuK7h7hcv8ffVylzPHGl1uduQPFexE8j6yBHdYR7
         PLdCfCxiHZ37RRU1DH/gTQRk6hFjSLeVgGtVMWctXYtr3ubUMJA6jTxo5zDWSRB9dH54
         bIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785377772; x=1785982572;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kpk2V6RUucxH6gkGYwDAJ6VjIvLcQZVLrKPxJU8G8/Q=;
        b=n+JEoyWNFCG2P1I0rV9zefqrz9QqevM03ryFXGzpKU+aVUdRTX/sf7W4M4TBQ4jRcg
         AD08B4p9HnERXk6vwt+epvwWjb+xOOIZJpUEObfMFjEOk5pbDD8xNQ3RYku3l3d+wEqP
         xIWTOW1ChlGrd9rrh+LwjESQ4tXvuEcck1vFKwQFWjDhrtwbz3brMwb0KuxG2c1nyHwi
         jadIZPvnb5b3UPt3+EkN+mkysr+jJajrfzkDrNytWOYLXaglh3utY9uCAujT4vw8OQfp
         Nc8O7qSHGqfgNwFuZjphQLqJuN2tZ6NNdOno7jFwkod0eTzJJdB90WffVEKxA7/wHj1A
         RSOw==
X-Forwarded-Encrypted: i=1; AHgh+Roh8C/iUmECZx6Ij0ohX/BvvlLzYD40PoYC3VvF8NAIYnrfTM4I/cob406QFHoIW89XdO+AI8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7TVv+J/64GLtcHGoLX6YmOJxhV14z+xqDMo2ZeK4GonEPuzB2
	qRooCT0v9ofNpJ48heCSA48nw3S1FRz/H/MpXU+2ad6lr1CaDIa4ppknKvPxVKbR
X-Gm-Gg: AR+sD120BfArJY1gOsLg1BOvp0H91GF/yG8Y5FO00Rg+uueeg6Yni5B8Onzla3YJGFS
	0lUQeczHEp2wuiioIayA56MlIzljxlS+cZoFiYbkK/ZrEfvlJ9LkAI6MsM39qn1TwB0k4EmAJiX
	V3X4j9frbz3LJhYyKIyjpj6zIjSH1DR4c0Q4A2JNfExa5DQta7ocZSDBnlRnpNU4P+jR19b5ndL
	CSPlAcM0RPgCkusk1LzodqlYOnOdS3zc8ES3C9gE5YF1B8F/eIUjO5Nmk7WcQe5jDl0zX0U+Xgh
	O0rc9/Asjp/MHk405On3GP/8zY32dk1fvS3rJpS/wfWuY/lEavYdaNfAlD+sqSW4mCKZev2oD4i
	OlwplOanDFv0M4IduT44dHwxOlavh6YO3o5+wyW0aoPRiZEhF4iyLrh9s0PRte+Q1YsyBzd4Jjo
	m5SLozQHWVdM5NWYt5yfZLQImPpspFJXfpvLR5Clguu4amR269Ba+MHvk5aF3kKSt5Gv2+YQ==
X-Received: by 2002:a05:6a20:7f90:b0:3c3:954d:278d with SMTP id adf61e73a8af0-3c90060e58amr669783637.9.1785377772324;
        Wed, 29 Jul 2026 19:16:12 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d3250asm13525091eec.20.2026.07.29.19.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 19:16:11 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com, vaibhav@linux.ibm.com, donettom@linux.ibm.com, harshpb@linux.ibm.com, Gaurav Batra <gbatra@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
In-Reply-To: <20260727221437.89644-1-gbatra@linux.ibm.com>
Date: Thu, 30 Jul 2026 07:05:16 +0530
Message-ID: <a4r9mf8r.ritesh.list@gmail.com>
References: <20260727221437.89644-1-gbatra@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


Hi Gaurav,

Gaurav Batra <gbatra@linux.ibm.com> writes:

> In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
> determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
> This OF property dictates what is the max size of RAM an LPAR can have,
> including DR added memory.
>
> In PowerPC, 16GB pages can be allocated at machine level and then
> assigned to LPARs. These 16GB pages are added to LPAR memory at the time
> of boot. The address range for these 16GB pages is above MAX RAM an LPAR
> can have (ibm,lrdr-capacity). In the current implementation, these 16GB

So these 16GB pages must be apperaing as "memory" nodes, because that's
how the code must be detecting them above "ibm,lrdr-capacity"?
Do you have the device node example for the same?


> pages are being excluded from pre-mapped TCEs. A driver can have DMA
> buffers allocated from 16GB pages. This results in platform to raise an
> EEH when DMA is attempted on buffers in 16GB memory range.
>
> commit 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly
> adds TCEs for pmemory")
>
> Prior to the above patch, memblock_end_of_DRAM() was being used to
> determine the MAX memory of an LPAR. This included 16GB pages as well.
> The issue with using memblock_end_of_DRAM() is that when pmemory is
> converted to RAM via daxctl command, the DDW engine will incorrectly try
> to add TCEs for pmemory as well.
>
> Below is the address distribution of RAM, 16GB pages and pmemory for an
> LPAR with max memory of 256GB, memory allocated 64GB, 2 16GB pages and
> assigned pmemory of 8GB.
>
> RANGE                                 SIZE  STATE REMOVABLE     BLOCK
> 0x0000000000000000-0x0000000fffffffff  64G online       yes     0-255
> 0x0000004000000000-0x00000047ffffffff  32G online       yes 1024-1151
>
> cat /sys/bus/nd/devices/region0/resource
> 0x40100000000
> cat /sys/bus/nd/devices/region0/size
> 8589934592

Is there any formal placement contract in the PAPR which tells where
would PMEM appear in the logical real address range for LPAR?

>
> The approach to fix this problem is to revert back the code changes
> introduced by the above patch and to stash away the MAX memory of an
> LPAR, including 16GB pages, at the LPAR boot time. This value is then
> used whenever TCEs are needed to be pre-mapped - enable_DDW() or,
> iommu_mem_notifier()

So, can it appear for e.g. in above case from 288G to 512G? In your
example we see pmem coming at 4TB, but what if the system DRAM was above
4TB? In that case, could vPMEM appear at non-power-of-2 address just
above ibm,lrdr-capacity+16G?

The reason for the ask is, I see a small window where we don't have any
direct pre-mappings, but we do allow for core dma mapping apis to use the
direct-mapping window.

Here...

In the current code we check for:

@@ -2419,23 +2425,35 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 {
+	unsigned long max_ram_pages = pseries_ddw_max_ram >> PAGE_SHIFT;
 	int ret = 0;
<...> 
+	if (arg->start_pfn >= max_ram_pages)
+		return NOTIFY_OK;

& but in enable_ddw() {
    <...>
	int max_ram_len = order_base_2(pseries_ddw_max_ram);
    <...>
	/* For pre-mapped memory, set bus_dma_limit to the max RAM */
	if (direct_mapping)
		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset +
						(1ULL << max_ram_len);

So, we don't pre-map anything above pseries_ddw_max_ram in the
iommu_notifier() but we allow for dma_mapping to use direct map until
order_base_2(pseries_ddw_max_ram). 
So it looks like that, there is a small gap left in direct_mapping
window for e.g. in above case between 288G to 512G (because of
order_base_2()), where there are no pre-mapped TCE entries but if the
PMEM is added within that range, then we do allow to use the
direct-mapping path (due to bus_dma_limit) - which means an EEH could
occur.

Could you please check this claim?

-ritesh


>
> Fixes: 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly adds TCEs for pmemory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
> ---
>
> Change log:
>
> V3 -> V4
>
> 1. Ritesh: Change pseries_ddw_max_ram to __ro_after_init;
>
>    Response: Incorporated changes
>
> 2. Ritesh: Mark function ddw_memory_hotplug_max() as __init function
>
>    Response: Incorporated changes
>
> 3. Ritesh: This patch was made in v6.15. Since we want this to be backported, I
>    would suggested add a CC stable tag as well.
>
>    Response: Incorporated changes
>
> V2 -> V3
>
> 1. Harsh: Remove R-b tags from the change log
>
>    Response: Incorporated changes
>
> 2. Harsh: Change WARN_ON() to WARN_ONCE()
>
>    Response: Incorporated changes
>
> 3. Harsh: Fix indendation
>
>    Response: Incorporated changes
>
> 4. Harsh: Replace comment with a log if limit < arg->nr_pages ? 
>
>    Response: Doesn't seems to be needed since the WARN_ONCE() will log this
>    scenario. I removed the comment instead.
>
> V1 -> V2
>
> 1. Harsh: Not only start_pfn, but end_pfn also needs to be within allowed
>    range, which may require clamping arg->nr_pages if crossing the limits.
>
>    Response: Incorporated changes.
>
>
>  arch/powerpc/platforms/pseries/iommu.c | 60 ++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 3e1f915fe4f6..7f63adafaf91 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -69,6 +69,8 @@ static struct iommu_table *iommu_pseries_alloc_table(int node)
>  	return tbl;
>  }
>  
> +static phys_addr_t pseries_ddw_max_ram __ro_after_init;
> +
>  #ifdef CONFIG_IOMMU_API
>  static struct iommu_table_group_ops spapr_tce_table_group_ops;
>  #endif
> @@ -1283,15 +1285,19 @@ struct failed_ddw_pdn {
>  
>  static LIST_HEAD(failed_ddw_pdn_list);
>  
> -static phys_addr_t ddw_memory_hotplug_max(void)
> +static phys_addr_t __init ddw_memory_hotplug_max(void)
>  {
> -	resource_size_t max_addr;
> +	resource_size_t max_addr = memory_hotplug_max();
> +	struct device_node *memory;
>  
> -#if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
> -	max_addr = hot_add_drconf_memory_max();
> -#else
> -	max_addr = memblock_end_of_DRAM();
> -#endif
> +	for_each_node_by_type(memory, "memory") {
> +		struct resource res;
> +
> +		if (of_address_to_resource(memory, 0, &res))
> +			continue;
> +
> +		max_addr = max_t(resource_size_t, max_addr, res.end + 1);
> +	}
>  
>  	return max_addr;
>  }
> @@ -1446,7 +1452,7 @@ static struct property *ddw_property_create(const char *propname, u32 liobn, u64
>  static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mask)
>  {
>  	int len = 0, ret;
> -	int max_ram_len = order_base_2(ddw_memory_hotplug_max());
> +	int max_ram_len = order_base_2(pseries_ddw_max_ram);
>  	struct ddw_query_response query;
>  	struct ddw_create_response create;
>  	int page_shift;
> @@ -1668,7 +1674,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
>  
>  	if (direct_mapping) {
>  		/* DDW maps the whole partition, so enable direct DMA mapping */
> -		ret = walk_system_ram_range(0, ddw_memory_hotplug_max() >> PAGE_SHIFT,
> +		ret = walk_system_ram_range(0, pseries_ddw_max_ram >> PAGE_SHIFT,
>  					    win64->value, tce_setrange_multi_pSeriesLP_walk);
>  		if (ret) {
>  			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
> @@ -2419,23 +2425,35 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
>  {
>  	struct dma_win *window;
>  	struct memory_notify *arg = data;
> +	unsigned long limit = arg->nr_pages;
> +	unsigned long max_ram_pages = pseries_ddw_max_ram >> PAGE_SHIFT;
>  	int ret = 0;
>  
>  	/* This notifier can get called when onlining persistent memory as well.
>  	 * TCEs are not pre-mapped for persistent memory. Persistent memory will
> -	 * always be above ddw_memory_hotplug_max()
> +	 * always be above pseries_ddw_max_ram
>  	 */
> +	if (arg->start_pfn >= max_ram_pages)
> +		return NOTIFY_OK;
> +
> +	/* RAM is being DLPAR'ed. The range should never exceed max ram.
> +	 * Just in case, clamp the range and throw a warning.
> +	 */
> +	if (arg->start_pfn + limit > max_ram_pages) {
> +		limit = max_ram_pages - arg->start_pfn;
> +		WARN_ONCE(1, "Limiting Page Range %lx - %lx to Max Mem Pages: %lx\n",
> +					arg->start_pfn, arg->start_pfn + arg->nr_pages,
> +					max_ram_pages);
> +	}
>  
>  	switch (action) {
>  	case MEM_GOING_ONLINE:
>  		spin_lock(&dma_win_list_lock);
>  		list_for_each_entry(window, &dma_win_list, list) {
> -			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
> -				ddw_memory_hotplug_max()) {
> +			if (window->direct) {
>  				ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
> -						arg->nr_pages, window->prop);
> +						limit, window->prop);
>  			}
> -			/* XXX log error */
>  		}
>  		spin_unlock(&dma_win_list_lock);
>  		break;
> @@ -2443,12 +2461,10 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
>  	case MEM_OFFLINE:
>  		spin_lock(&dma_win_list_lock);
>  		list_for_each_entry(window, &dma_win_list, list) {
> -			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
> -				ddw_memory_hotplug_max()) {
> +			if (window->direct) {
>  				ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
> -						arg->nr_pages, window->prop);
> +						limit, window->prop);
>  			}
> -			/* XXX log error */
>  		}
>  		spin_unlock(&dma_win_list_lock);
>  		break;
> @@ -2532,6 +2548,14 @@ void __init iommu_init_early_pSeries(void)
>  	register_memory_notifier(&iommu_mem_nb);
>  
>  	set_pci_dma_ops(&dma_iommu_ops);
> +
> +	/* During init determine the max memory an LPAR can have and set it. This
> +	 * will be used for pre-mapping RAM in DDW. memblock_end_of_DRAM() can
> +	 * change during the running of LPAR - daxctl can add pmemory as
> +	 * "system-ram". This memory range should not be pre-mapped in DDW since
> +	 * the address of pmemory can be much higher than the DDW size.
> +	 */
> +	pseries_ddw_max_ram = ddw_memory_hotplug_max();
>  }
>  
>  static int __init disable_multitce(char *str)
>
> base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
> -- 
> 2.39.3
