Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1258F4C0426
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001318; cv=none; b=BztcFYDczYJGOIL2qjHV47g/U8QPYJOrQN5PrPOJvTK5clz1TfNWltz8tP4EMlLuH2PUS+0kOa2KUQ+pmHwsaxjsjonCX2sIvd5rX7vfsXtQxItI+CLkbKnfHZDmYJpSc54IxXem02NLaZ+1mKtGIH/rnKbODlePrJAmyij828k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001318; c=relaxed/simple;
	bh=KGKYrEKHvAg3Vtw1imsI947pXp2NVHSgr3TwPABqJh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URKdoyeECfIuz0Otn7G3gLco5o7Xdx0tVOA4MmSX+/FG+3auPkjxMF99HGfDNfiARMacRcndkM2IBj5gJ3GmKbwOzRAAlwmZEcgGsD0rTnZPzn8THV3ImpdKixPI9Xm1vg0yZ9WuhD66fdVy+8MqcyrQRINzMwaPi3to3Yl6QwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmhHXUlF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmhHXUlF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783001317; x=1814537317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KGKYrEKHvAg3Vtw1imsI947pXp2NVHSgr3TwPABqJh0=;
  b=mmhHXUlFW7JK38z5x4OEbfzh+e5y/bpgBT/IIgn0C3TCBSsxhY4y+yhT
   DevY826efc1/pKy3PskxquC2q8MoHKGGmuqI+ZBqFi4GbbEs+YLCgnLqJ
   FNnv7sYgU8Y7npo4Su4x2wDOJ0oiARuGe6ID63tB72wPLG7Y8Siu4pm75
   8Z/5NXK64i/5AZmohwVJM35dirqTjPnJpQPFnw160Q/0NNPTh9h0ELV/G
   8hFq8IbulKjKl10S+dwxBV627yPUEsDDs/A+4IA1genGYko+gYf1O6Tk4
   FE5x3jPdZbU+WI3oA9D42Z2j7ak1hAozs5838HcTKe7FTER46ld5ZiKmv
   w==;
X-CSE-ConnectionGUID: DgpD4KJxRRivQ8TMMl2x9A==
X-CSE-MsgGUID: MD/pbZfRRHexn5Fv+Gmy6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94355861"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="94355861"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 07:08:36 -0700
X-CSE-ConnectionGUID: XQrbXyXkRxGqZEgJp1Y61Q==
X-CSE-MsgGUID: JZwZx76VSJ6EZ56DqMVFoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="257217570"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.244.242]) ([10.245.244.242])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 07:08:35 -0700
Message-ID: <bd1aab65-fa42-4540-af71-16dea211523d@intel.com>
Date: Thu, 2 Jul 2026 15:08:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Fix PTE index in xe_vm_populate_pgtable() for
 chunked binds
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20260702012434.3861171-1-matthew.brost@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260702012434.3861171-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/2026 02:24, Matthew Brost wrote:
> xe_vm_populate_pgtable() indexed the source PTE array (update->pt_entries)
> by the per-call loop counter, assuming each call starts at the first entry
> of the update. That holds for the CPU bind path
> (xe_migrate_update_pgtables_cpu), which populates a whole update in a single
> call, but not for the GPU bind path: write_pgtable() splits an update into
> MAX_PTE_PER_SDI (510) sized MI_STORE_DATA_IMM chunks, invoking the populate
> callback once per chunk with an advancing qword_ofs but a fresh command-
> buffer destination pointer.
> 
> As a result, every chunk after the first re-read pt_entries from index 0
> instead of from its true offset, so PTEs beyond the first 510 entries of a
> single update were programmed with the wrong physical pages, shifting the
> mapping by exactly MAX_PTE_PER_SDI pages.
> 
> This stayed latent because a single update only exceeds 510 qwords when a
> large (e.g. 2M) region is bound as individual 4K PTEs rather than a single
> huge-page entry, which happens when the backing store is sufficiently
> fragmented. It was surfaced by the BO defrag path, which deliberately
> rebinds such fragmented ranges via the GPU bind path, producing
> deterministic data corruption offset by 510 pages.
> 
> Index pt_entries by the chunk's absolute offset relative to update->ofs so
> both the CPU and GPU paths pick the correct entries.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub_Copilot:claude-opus-4.8

Missing sob.

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/xe/xe_pt.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 00cef6ff17cc..7970b4ed95b5 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1024,12 +1024,22 @@ xe_vm_populate_pgtable(struct xe_migrate_pt_update *pt_update, struct xe_tile *t
>   	u64 *ptr = data;
>   	u32 i;
>   
> +	/*
> +	 * @qword_ofs is the absolute entry offset within the page table, while
> +	 * @ptes is indexed relative to @update->ofs (its first entry). The GPU
> +	 * path (write_pgtable) splits a single update into MAX_PTE_PER_SDI-sized
> +	 * chunks, calling this with an advancing @qword_ofs but a fresh @data
> +	 * pointer per chunk, so translate back into a @ptes index rather than
> +	 * assuming the chunk starts at ptes[0].
> +	 */
>   	for (i = 0; i < num_qwords; i++) {
> +		u32 idx = qword_ofs - update->ofs + i;
> +
>   		if (map)
>   			xe_map_wr(tile_to_xe(tile), map, (qword_ofs + i) *
> -				  sizeof(u64), u64, ptes[i].pte);
> +				  sizeof(u64), u64, ptes[idx].pte);
>   		else
> -			ptr[i] = ptes[i].pte;
> +			ptr[i] = ptes[idx].pte;
>   	}
>   }
>   

