Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC1423E9F;
	Fri, 25 Sep 2026 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336641; cv=none; b=J17V9qcaDVT+/LU2wOAAT0dH5IU6bAc01BHpRHZfboa/0urTSRlWwsATESgqonNcBqlGVibSiNM2KOWfei7nCyo1jOxxDWYS90bnA4WRam4XIS72r4K/Dq7BcKHTXHLHAIr5VZlQvG8q0rqMarpY79WnOI2KPsaEiKtYgki9ZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336641; c=relaxed/simple;
	bh=xSCzSQa9vpv7fTrpe4D6eJEWhOskC3i34wNAy1rzkek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnkiJXSYQZU5E8KPwgE5+TVuuv9pxMVf0/TL0CUAk5acWZgOB1R78wNO8il6KBHnLjZziYJ1td55qtd2VCVEFGrY1DYODI3/5/TBox5snsD8hnCw3a3Qr+7w1b7p09gkiP7/OMnqPj4+Vg8uTefV0/skwbSk+jsQGzb+VO51GUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw3RTHAf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw3RTHAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790336639; x=1821872639;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xSCzSQa9vpv7fTrpe4D6eJEWhOskC3i34wNAy1rzkek=;
  b=Iw3RTHAfe7sw9ahOQqHAK8b3sKpHUFqOT5Isq8TTEFEuWYVoBCqOw9Tq
   oM5nGcK0f+iqnNPl+g60HRE8fet4tKrlf3Imp35FjSMBAwQelIWqD5/j2
   6z0j9kFG0XEyUJT+defvMjjPSiVWFyBg9eW/DYpHGOUH+G8Hp5OgcEVW8
   sjFNHHgooYX1tBc/dfO3bu3yiYXfARHSDZ+2RpmXKY0JoG+o/ZUWi5fCJ
   Pb21JWcdrDnt28XKzNEFh7axjbzgazgaE068L2tFOBeVqRFm99gepVAKa
   wO10AWbzhAVTZUqhhb4C1cG/tWuc7kqoQuSrSPUbeb7BOh84khtt+8GDj
   g==;
X-CSE-ConnectionGUID: xXgE0HWESwCGmUWys7M+jg==
X-CSE-MsgGUID: d6h5kYFGQRuAEa/NbdhR/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93839867"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="93839867"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 04:43:22 -0700
X-CSE-ConnectionGUID: /daeCRXrS4WRpBjCCG+/fw==
X-CSE-MsgGUID: rpOFlsItSKaRR05dJQ3aaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="312238006"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [10.102.89.94]) ([10.102.89.94])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 04:43:16 -0700
Message-ID: <edc255b9-4537-4542-bfa8-6f004bcbe6b7@linux.intel.com>
Date: Fri, 25 Sep 2026 13:43:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Fix IOVA offset when linking phys vecs to sgt
To: Yili Zhang <zhangyili01@baidu.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260924065508.27245-1-zhangyili01@baidu.com>
Content-Language: en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260924065508.27245-1-zhangyili01@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-24 8:55 AM, Yili Zhang wrote:
> The dma_buf_phys_vec_to_sgt() routine links every physical range into
> the allocated IOVA space at offset zero instead of advancing the offset
> by the already mapped length. This breaks the THRU_HOST_BRIDGE flow
> whenever phys_vec contains more than one entry: the second and
> subsequent dma_iova_link() calls try to install mappings on top of
> PTEs that already exist, which fails and makes the whole conversion
> return an error.
> 
> Fix it by passing the accumulated mapped_len as the IOVA offset. This
> matches the pattern used by all other dma_iova_link() callers and is
> consistent with the rest of the function: dma_iova_sync() and the
> error path in dma_iova_destroy() both operate on the [0, mapped_len)
> prefix of the IOVA space, which assumes that the ranges were linked
> contiguously starting at offset 0.
> 
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Cc: stable@vger.kernel.org

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

> Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
> ---
>   drivers/dma-buf/dma-buf-mapping.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
> index 833be519e1e6..ef0f22854d01 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -156,7 +156,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
>   						       phys_vec[i].paddr);
>   		} else if (dma_use_iova(dma->state)) {
>   			ret = dma_iova_link(attach->dev, dma->state,
> -					    phys_vec[i].paddr, 0,
> +					    phys_vec[i].paddr, mapped_len,
>   					    phys_vec[i].len, dir,
>   					    DMA_ATTR_MMIO);
>   			if (ret)

