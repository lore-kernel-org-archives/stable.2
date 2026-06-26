Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6B3F2118;
	Fri, 26 Jun 2026 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489047; cv=none; b=IHslA5KSZW833r7VIAZqVsCpCcm+BG1zdTw7gR8hJydrGPx1AX6UsHZofMnvtuXWDjFK122LoNZj4jaUwg5gHS48zG2pVAzQ3X/aMoF83WrevE6zrO8Gy/2HCP7Iufn5aiZ6F/6uIc+JYOnrBxImql8CIQPAOSRUtbKYLvq7iwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489047; c=relaxed/simple;
	bh=O5Ow04ThfQgKVd0s20nIu6kWvFvR6nyFgYGrtR+dK64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmN4jQyiMKrQSGmJmPmA8ILbznU1HaPysf4KBTrBNxpZ3hSrrUZO0BfKVuGAq85PhJZvgaJLhCLWdQDs9hULXK4/LLtUjCYnR0LwAOsTu4Vg5RKE702FQ10HRYvNsXB5jZOLSl3OBs2vlqBCGdm9ixKDHgVcFiLvm7exnRaTNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAgnI+1J; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAgnI+1J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782489046; x=1814025046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O5Ow04ThfQgKVd0s20nIu6kWvFvR6nyFgYGrtR+dK64=;
  b=OAgnI+1JgzujrCn7A22Kb9wfiylr8s+secFbgMgM+Sx9guuAwwAwMkNl
   lcNotfgVETr+b0h3LngJrV+qvAML+iXFbjkd/9K3I+0WMVFxMJRtC4DsX
   3M+0A98AJlYPY8T666g9G/i3QlTXtaofBItHBWaKYhAmalMM1TFkuV2xN
   ZhZEAKbDMrUOu/f/9yRxxL9Kg+fssJazWQxE0/sBNVeTgDjGz8UmtK6Ec
   WDBBAhogs0+EImQPTPEVNfSRNXuf98DFuhGM5jjOcwfDFbpoc3R1Ng89N
   8/tsHx7oWme9Sab2YnmLgiiH2YkfnsnqEowoYrnKyeBvyLt6rV7QMwj3s
   g==;
X-CSE-ConnectionGUID: j7GPlUQZTZiRDmZOOrl05A==
X-CSE-MsgGUID: Ln+ZSp6lS0uhnm+zO8E6ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="86962610"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="86962610"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 08:50:45 -0700
X-CSE-ConnectionGUID: PcwQfAFCTWieNtxVodj7TQ==
X-CSE-MsgGUID: WZhpPImmQweU5utaEkSGPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="251512698"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.96]) ([10.125.109.96])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 08:50:45 -0700
Message-ID: <0d8051f0-a753-4e84-81be-39256cc44eef@intel.com>
Date: Fri, 26 Jun 2026 08:50:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: ntb: perf_copy_chunk: fix tx descriptor and unmap
 kref leak on dmaengine_submit failure
To: WenTao Liang <vulab@iscas.ac.cn>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260626153917.53128-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260626153917.53128-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/26 8:39 AM, WenTao Liang wrote:
> When dmaengine_submit fails after dma_set_unmap has been called, the
>   unmap object has two references (one from dmaengine_get_unmap_data and
>   one from dma_set_unmap held by the tx descriptor). The error path
>   err_free_resource only calls dmaengine_unmap_put once, leaving the tx
>   descriptor's reference and the descriptor itself leaked.
> 
> Add dmaengine_desc_put(tx) in the err_free_resource path to properly
>   release the tx descriptor and its held unmap reference.
> 
> Cc: stable@vger.kernel.org
> Fixes: 282a2feeb9bf ("NTB: Use DMA Engine to Transmit and Receive")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Same comment. Please resend to ntb@lists.linux.dev.


> ---
>  drivers/ntb/test/ntb_perf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index dfd175f79e8f..64783bfa5a2c 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -851,6 +851,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
>  	return likely(atomic_read(&pthr->perf->tsync) > 0) ? 0 : -EINTR;
>  
>  err_free_resource:
> +	dmaengine_desc_put(tx);
>  	dmaengine_unmap_put(unmap);
>  
>  	return ret;

