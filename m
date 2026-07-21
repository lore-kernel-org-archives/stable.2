Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142054652;
	Tue, 21 Jul 2026 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651545; cv=none; b=RJgTGUPtCyE4Oj8qxsvIOh5loXq0JfgIHHSQ1LGBMDOheBBiFHtGafVTOx/N6KCjRp6ntOurikpboK8B9f69kWEH5UGI4jL4IcLED9z7RRHGqJ9sYRYBvBHVeYjnzpd6fP07tiAixxedGSHkA2Fc/8K82vy00M6ubmAZ2YkIE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651545; c=relaxed/simple;
	bh=Uf0ltgVuATLeRHzYZT6Fh/0aClKe9O8x7HSafajDKHM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i4JMqXDwKnNeygy9ngVL1MlVk7Vg7TgUnB/6b8l4NhfcIj7U/OU93qSOlAtJMdgT2z74a0PNLo50ECa34VmZVXqy1G2Y80qREJ4jyJ+DOrNRZf8AMVG80idk5oTRXahJJMbyW5yMSoWf7Ee2y+8NhItJImHIBaXMaFJxD9tdy30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDXlTkvn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDXlTkvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784651544; x=1816187544;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Uf0ltgVuATLeRHzYZT6Fh/0aClKe9O8x7HSafajDKHM=;
  b=LDXlTkvnzEuBcgAqb06x0IqAyEtt8H0Yx49H7vx9xZUtfq6x2Un6anit
   cJF/P5BXbYcTUr6WyLoHAr7FTkxCQbvI72ToMs94GTuEmwnx2KcRPhRn+
   RhdiC2R3ePF/7tX2nRxeHPQXLzlLbBNjy35ckaQhtU+rNrmBx0iOvKgXn
   4TjWYul0kPvyxg4SLkzAiK1keUcMICOtLX3NVm+2bK24RBjlbpK0FCw2F
   IyEtG5xR//dZQiTkjQ1sXkv9/fTdh+68hKa8Yk0kDcFoWfYLkKTCa1Z9e
   NH7B/GUDrYkgIZJJeBW8Kl4FYFzQhWDmO4noi9YHGUjvjPVxA4Z7GEiVt
   g==;
X-CSE-ConnectionGUID: Ot+P+w6fSdukd9zLgEBKEg==
X-CSE-MsgGUID: HUpMIp+ASBGDVb1uxCgzJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85460599"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85460599"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:32:24 -0700
X-CSE-ConnectionGUID: vN68EUeITJ6AHAwMPVb3dA==
X-CSE-MsgGUID: pwviNDYxTamkCe5wPdAFBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="257885145"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:32:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jul 2026 19:32:17 +0300 (EEST)
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
cc: Shravan Sudhakar <s.shravan@intel.com>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 2/2] platform/x86: int1092: Fix info leak in
 parse_package()
In-Reply-To: <20260713-platx86-v1-2-c8991bff03a0@cse.iitm.ac.in>
Message-ID: <a41c1ab7-49a3-39c8-637c-6b3011ed4a2a@linux.intel.com>
References: <20260713-platx86-v1-0-c8991bff03a0@cse.iitm.ac.in> <20260713-platx86-v1-2-c8991bff03a0@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Jul 2026, Abdun Nihaal wrote:

> Sashiko reports a possible information leak due to a non-zeroized
> memory allocation for device_mode_info. Fix that by switching to use
> devm_kcalloc() for allocation.

Hi,

Please also explain here through which path the information is leaked to 
permanently record it into commit itself.

You can mostly base it on Sashiko's findings but please avoid making it 
too verbose (AI tends to be overly verbose about trivialities).

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260710052806.100107-1-nihaal%40cse.iitm.ac.in
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

--
 i.


> ---
> Newly added in v3
> ---
>  drivers/platform/x86/intel/int1092/intel_sar.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
> index 7263114f0b3d..f506155f35d4 100644
> --- a/drivers/platform/x86/intel/int1092/intel_sar.c
> +++ b/drivers/platform/x86/intel/int1092/intel_sar.c
> @@ -91,10 +91,10 @@ static acpi_status parse_package(struct wwan_sar_context *context, union acpi_ob
>  	    item->package.count <= data->total_dev_mode)
>  		return AE_ERROR;
>  
> -	data->device_mode_info = devm_kmalloc_array(&context->sar_device->dev,
> -						    data->total_dev_mode,
> -						    sizeof(*data->device_mode_info),
> -						    GFP_KERNEL);
> +	data->device_mode_info = devm_kcalloc(&context->sar_device->dev,
> +					      data->total_dev_mode,
> +					      sizeof(*data->device_mode_info),
> +					      GFP_KERNEL);
>  	if (!data->device_mode_info)
>  		return AE_ERROR;
>  
> 
> 

