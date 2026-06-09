Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34999343894;
	Tue,  9 Jun 2026 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015685; cv=none; b=mQ3O8G6ZyVtYjNu3/GUZGdhY7zjVsDTATNrPp4GjDWcz0pVwl2fpdrXdkVq/PcGb3rTEQ57zmzzTp2o2ZX+aV9IG+1GEi8cYmWxLG62pZ0CwO33HvPEeVzR/vOfzIckLO34CkQqojcftZyp0r7C6zojS+evSEna+3yEJ+BndV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015685; c=relaxed/simple;
	bh=Bpkcx1YL7O2mqYq0oCQVlH06v+3lGb0zkmBTUlavrH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhWuSywt5Vk+pESLfEAcJK1peqTcY0jq3PLBVn+OQ3u3DTiXAhHwbzkU0fR5dc4q4cdKD9oW6ZrVCB+ShKFOgHhfEGl9+3TG4uIF9NiQS/r+JpyYmha4e1RES9Bx8Y31ubIaeZ4+ppl81jI4EzVO08qgisydQocmrz9vNicnaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWSYOT48; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWSYOT48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781015684; x=1812551684;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bpkcx1YL7O2mqYq0oCQVlH06v+3lGb0zkmBTUlavrH8=;
  b=PWSYOT48slr0UV4NmrZ0s/sk7IUJ5MHKW2+dAuil/nrd2tPHMLfFv8PC
   MRnN6UCh/ynA+34JnKULxysvBuBPErMnLAJr7DHYdaTjqz+09qhlDs4Pc
   IeDouRWHKBqlIzAR/JhohZ6sZ8MCGgsPyv+52u56amM7t3Qr/dTqHHeOQ
   T3glGg2Pk48nOLTjDRuWU7r72S6oqNLxeSDb9Rll7Lo8W2pfLL9j7cBp8
   ySItgEpYUwu8tjblqan8qyUVeK4bXUQZ9vBdvgmpA/MBblYGYBolBY0lQ
   9RJwwvvEqvjsH0xzcJCLqegozUdEoPG9ExujRTP/rsPlpIV7Wa16ZmPHS
   Q==;
X-CSE-ConnectionGUID: sH53CpT6Rz6n37bHHy4QNg==
X-CSE-MsgGUID: 1gnWxIZ7Sne9SferfFQyNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92451216"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="92451216"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:34:25 -0700
X-CSE-ConnectionGUID: v9VMlKsETQiK1VPMMq0g5Q==
X-CSE-MsgGUID: Ul8JGqBxTvWjRYMfmjsI2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245920464"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.206]) ([10.125.109.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:34:24 -0700
Message-ID: <d07654a2-3b87-4f65-b67b-f0348fa17fe3@intel.com>
Date: Tue, 9 Jun 2026 07:34:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/ras: Fix match_memdev_by_parent() pointer type
 mismatch
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, ming.li@zohomail.com, rrichter@amd.com,
 Benjamin.Cheatham@amd.com
Cc: Smita.KoralahalliChannabasappa@amd.com, stable@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 PradeepVineshReddy.Kodamati@amd.com
References: <20260608224319.587614-1-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260608224319.587614-1-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/8/26 3:43 PM, Terry Bowman wrote:
> bus_find_device() passes its data argument directly to the match
> function as a const void *. match_memdev_by_parent() compares
> dev->parent against this pointer:
> 
>     dev->parent == uport
> 
> cxlmd->dev.parent is set in cxl_memdev_alloc() as:
> 
>     dev->parent = cxlds->dev;  /* cxlds->dev == &pdev->dev */
> 
> So cxlmd->dev.parent holds a struct device * pointing to &pdev->dev.
> However, bus_find_device() is called with pdev (struct pci_dev *)
> rather than &pdev->dev (struct device *). Since struct pci_dev does
> not begin with struct device, the two pointer values differ, causing
> the comparison to always evaluate false.
> 
> As a result, cxl_cper_handle_prot_err() silently drops every CPER
> error report for CXL endpoint devices -- bus_find_device() always
> returns NULL and the function returns early without emitting any
> kernel trace event.
> 
> Fix by passing &pdev->dev instead of pdev.
> 
> Fixes: 3c70ec71abda ("cxl/ras: Fix CPER handler device confusion")
> Reported-by: Sashiko <sashiko@linuxfoundation.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Probably good to keep the original line wrapping. I can fix that on apply.


> ---
>  drivers/cxl/core/ras.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 006c6ffc2f56..7ec2dab152a7 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -94,8 +94,7 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  	if (!pdev->dev.driver)
>  		return;
>  
> -	struct device *mem_dev __free(put_device) = bus_find_device(
> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> +	struct device *mem_dev __free(put_device) = bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_memdev_by_parent);
>  	if (!mem_dev)
>  		return;
>  

