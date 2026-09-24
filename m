Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE171340A6F;
	Thu, 24 Sep 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259480; cv=none; b=qtIJWVHOeUiU2TyE6UT8ENkipMYwFsd75ab787hOcBKCw8o65K2WX/ugkklmLY4QXIyE7yHuOMBchsfZambIoJLxcs+tQCW3agwx9HtVy/8q7Cf7lrsIXrs3Pi1YyrXfmiRresIMFlexx5Z1IW4VizYSbf4qe+b3+oLVrSolKI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259480; c=relaxed/simple;
	bh=/lTWMClLlWUDvF9AS83RY53KcuOhgNuj2fCFO++D+cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+NWQbe2+EEKYWBUVXuanSTrZ07c7MQkLggZUz5dFHv1IPxi3q931+Nz+dUehxl4pm+R7vmPDQIvuXPocOW5TpOB5tdHSJAyd+89dXTprqQYW1RQXjJdsMs6YaEQJgIvqqXEThAdnZjE85oXs4MDG/GFfH9+3iiyuZjRD3WYFWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yz63Rlyt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yz63Rlyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790259479; x=1821795479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/lTWMClLlWUDvF9AS83RY53KcuOhgNuj2fCFO++D+cs=;
  b=Yz63RlytNKt1LL4k282KhoOn29hLSsjWS0BsMkWU+uctM+n1Hn/J//tB
   6y0rAP803RK6F+tqB3d/IqQ0SDjbyypefCLYB1/M/WMm9y9G3Hx8G88qg
   CFhjRJZnzUjO1KAgvkNcHm4NolRt/opdekPwFj6Ug3MqG7iqU5Kdkbi5H
   ImUJTGIUgJJFHCdPnpL9OyKvXA3MviGj9dp82LrJ936d8SxfCmtwBuxqK
   NzO4bQAD2+XMS27i5h0w9jLxe6kDzk6kgQS2n+2D8PpJrvOk4ZhP/KaRW
   wnQ4VbwjXsAIXliuVeQNxl7sbPolpG5UK14k7osvhGHYynH6gKeBa9jYC
   g==;
X-CSE-ConnectionGUID: WUmJnqNcSk+PfmbU6YJJwg==
X-CSE-MsgGUID: Z5W7ubtGTpW8T6Iqfvz2Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101204359"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101204359"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:17:58 -0700
X-CSE-ConnectionGUID: LkDUeKIKSjK/lr1ZHcJ49A==
X-CSE-MsgGUID: /pGwi7efQKm1fn7ZVlevBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="278782506"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:17:57 -0700
Message-ID: <bbca9c13-c0d6-4d86-8e55-bf9d1074c599@intel.com>
Date: Thu, 24 Sep 2026 07:17:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/acpi: Check ACPI companion before use
To: Jiale Yao <yaojiale02@163.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260924125404.923551-1-yaojiale02@163.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260924125404.923551-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/24/26 5:54 AM, Jiale Yao wrote:
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
> ---
>  drivers/cxl/acpi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3b818adbd38b..2b67138013a9 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -893,6 +893,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	struct acpi_device *adev = ACPI_COMPANION(host);

Can you move the assignment down to just before it checks the pointer? Please make sure to adjust the variable declaration to conform to reverse christmas tree layout when you do. thanks

DJ

>  	struct cxl_cfmws_context ctx;
>  
> +	if (!adev)
> +		return -ENODEV;
> +
>  	device_lock_set_class(&pdev->dev, &cxl_root_key);
>  	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
>  				      &pdev->dev);

