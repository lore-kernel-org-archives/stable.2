Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72B32E121;
	Mon, 28 Sep 2026 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790639420; cv=none; b=XBwASZMsAAFu3OUHxrGQ9lnlmrrbpkyPV8K3q9Sb5d2jQppG4FcQSlxUkmPmGT+77JV/+NOY36xVC8TQ/2kA+e86FIbhCqMCfLnRQBiO8L7rCcz1GPdoyCTIYuF9278mQTkLRfI3nepPlWIOSI/f1aSiKxVNtOfv1h1Xagb4rUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790639420; c=relaxed/simple;
	bh=yeLWxwyJTsE4BCXrz9QiRVhSSjNSbYW82lmQRE02QaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1etuYMUw0JzXwYmIsSatOBoRVMMOJVHgDfOXzs3QTtVV9l9HigzY8HARzT2xEKlRWg9llS8PP7mRP0/XRegAFHAgYYgD6DrzGPBCWDLMJenAbKDb7iFZZiTBna7pd4wUFsHG5RkhDujgnagR1umYsBT/PYrjk8+VgSOfxrmdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaf2k4nM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaf2k4nM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790639418; x=1822175418;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yeLWxwyJTsE4BCXrz9QiRVhSSjNSbYW82lmQRE02QaM=;
  b=eaf2k4nMaGihudGkHzjSbFs1Q945ENSoLSzEyJjnWxkRKvKXjskIgFTH
   KTl/1/IL8Cv5SNwsB+hYz8YKBukjzIwPa4RKDQHL8jFFPjWaPoqa/duYg
   itepGVnyzeAvNiOGidm8T44BYO3QEgpX28AW8aEmX3d0kIpun8aXWXo/g
   ZR0WGp+N3Gx90Z1GlOYzaWoQwJtOaJMvTGXvz22fmuJzEfdRyV3B3efEe
   b1sMk6j/zNPkSQ8OZ8B/7s5x6sZdrQPc/0cA+wtatjozSytpuLD6i0HGL
   pHmkWWKLHHiz5tE92q/jQg5oW/X0MKTBK96g4Hyw93IkYV1sEQanN1Lp/
   Q==;
X-CSE-ConnectionGUID: eJLnP4JSTXeE/LULi7o/Eg==
X-CSE-MsgGUID: bc09Lup2TbaisDqxSSqZGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="93841819"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="93841819"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:50:18 -0700
X-CSE-ConnectionGUID: uJU6kZrTQUiVicpQRe1w5w==
X-CSE-MsgGUID: zaz9qr0ZTPaGUoHUQd6epQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="283273529"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.79]) ([10.125.111.79])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:50:16 -0700
Message-ID: <73faab54-a9df-4053-8012-1ee28f0b2330@intel.com>
Date: Mon, 28 Sep 2026 16:50:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/acpi: Check ACPI companion before use
To: Jiale Yao <yaojiale02@163.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260926071605.3013893-1-yaojiale02@163.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260926071605.3013893-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/26/26 12:16 AM, Jiale Yao wrote:
> Platform drivers can be forced to match devices outside their ID tables
> through driver_override.  cxl_acpi_probe() assumes that every bound device
> has an ACPI companion and dereferences adev->dev.bus without checking the
> result of ACPI_COMPANION().  Force-binding cxl_acpi to a platform device
> without a companion therefore causes a NULL pointer dereference.
> 
> This was reproduced by setting the driver override for the pcspkr platform
> device to cxl_acpi and binding it through sysfs:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000280
>   #PF: supervisor read access in kernel mode
>   RIP: cxl_acpi_probe+0xf4/0x220
>   Call Trace:
>    platform_probe+0x4d/0x80
>    really_probe+0x106/0x370
>    device_driver_attach+0x4c/0xa0
>    bind_store+0xd0/0x100
> 
> Commit 2b3a5dabe89e ("platform/surface: acpi-notify: Check ACPI
> companion before use") fixed the same force-binding issue in another
> platform driver.  Check the companion before setting up the CXL root and
> return -ENODEV when it is absent.
> 
> Fixes: 7d4b5ca2e2cb ("cxl/acpi: Add downstream port data to cxl_port instances")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Applied to cxl/next:
371c2ad16242

> ---
> 
> Notes:
>     Changes in v2:
>     - Move the ACPI companion assignment immediately before its NULL check.
>     - Reorder local declarations in reverse Christmas tree order.
> 
>  drivers/cxl/acpi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3b818adbd38b..fb09a5ff48c1 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -885,13 +885,17 @@ static int pair_cxl_resource(struct device *dev, void *data)
>  
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
> -	int rc;
> +	struct cxl_cfmws_context ctx;
> +	struct acpi_device *adev;
>  	struct resource *cxl_res;
>  	struct cxl_root *cxl_root;
>  	struct cxl_port *root_port;
>  	struct device *host = &pdev->dev;
> -	struct acpi_device *adev = ACPI_COMPANION(host);
> -	struct cxl_cfmws_context ctx;
> +	int rc;
> +
> +	adev = ACPI_COMPANION(host);
> +	if (!adev)
> +		return -ENODEV;
>  
>  	device_lock_set_class(&pdev->dev, &cxl_root_key);
>  	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,

