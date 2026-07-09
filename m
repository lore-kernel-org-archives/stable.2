Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F561416122;
	Thu,  9 Jul 2026 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596692; cv=none; b=WJuYkyde3Cq0i3IaKn0RAsvMAAsyVKXknjguE2b9Q/Z3JmGDzqE1IFt4LALDrsukwnD4uBeaFNhCJdzhnKFoxmgqLd04tWDII2tCxASJaoLxE2x1Qxb8zEGcBsnpJEf/W4y6ZpTqyG38dIAwIKaV90qP/VTHE+0/f7h5F6TQafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596692; c=relaxed/simple;
	bh=yJ1uard9mXEZEcScZikBQrNzh5IB24NMJBc16EM5Q3o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GmYferNsd58j+iS9ElLZpM2d2OqnVo2scnvBh46g/xQr4jDLC36q3ITE3CdzMt6OBREDc1WgcRNABa7+lgXMMyRg1wbTcFRgLg+y8YOuVh6kPPht3GjVMUIBfJ5JIVJFI4yIkSI+Fl1dTR1q5OHiQVliHQfGHmdoWixo3MGsZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSEpk45c; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSEpk45c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783596687; x=1815132687;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yJ1uard9mXEZEcScZikBQrNzh5IB24NMJBc16EM5Q3o=;
  b=FSEpk45cHU89XSIbPWQjPtupjKh48whoAgJ9zK4+iS6fYD+ATaEqfOtS
   pE+WR70wvK1bHh6pKJvA7kFR58sVWWtvv7K3Hnifas2d2KfyhMu1XP6TH
   oqKpCLI1GgXLWbbXWU+mK6ZH438puDVfXpJD5AmRcFEpJKW2pHYET6l6E
   VuRBIyBgWyJY9fV8gAkn09v6XwjMGWiv04Jsruv0YWH7JkGbvtjbFXPVQ
   FFnHVTfoCBn0edRVoIQmsfQD6h/lLcqUxAB/9HT6lLGbeOXJT7q+cOr+v
   gSqhvP3XU0JCNmgWMQAdbsW1YAVSZB6xWGT9xCN4+NSPISnu/L3PEuQkD
   g==;
X-CSE-ConnectionGUID: g2QssXd/RduKW4uqUr+aSQ==
X-CSE-MsgGUID: RkuVoIRKRwy8HUR7GjWmEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94921205"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94921205"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 04:31:22 -0700
X-CSE-ConnectionGUID: aSVc60UpTpCIjuloSQY5Wg==
X-CSE-MsgGUID: aslByI6nQkqg0yYeRq7C5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="284676326"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.36])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 04:31:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 9 Jul 2026 14:31:15 +0300 (EEST)
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
cc: s.shravan@intel.com, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: int1092: Fix potential memory leak in
 sar_probe()
In-Reply-To: <20260707070524.953741-1-nihaal@cse.iitm.ac.in>
Message-ID: <7ae91c3c-4d52-a3ae-e9fb-542fa9002f57@linux.intel.com>
References: <20260707070524.953741-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 Jul 2026, Abdun Nihaal wrote:

> The memory allocated for device_mode_info in parse_package() called by
> sar_get_data() is not freed in some of the error paths in sar_probe().
> Fix that by adding the corresponding free in the error path.
> 
> Fixes: dcfbd31ef4bc ("platform/x86: BIOS SAR driver for Intel M.2 Modem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
>  drivers/platform/x86/intel/int1092/intel_sar.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
> index 849f7b415c1e..b27fc07c087a 100644
> --- a/drivers/platform/x86/intel/int1092/intel_sar.c
> +++ b/drivers/platform/x86/intel/int1092/intel_sar.c
> @@ -273,13 +273,13 @@ static int sar_probe(struct platform_device *device)
>  	if (sar_get_device_mode(device) != AE_OK) {
>  		dev_err(&device->dev, "Failed to get device mode\n");
>  		result = -EIO;
> -		goto r_free;
> +		goto r_sar;
>  	}
>  
>  	result = sysfs_create_group(&device->dev.kobj, &intcsar_group);
>  	if (result) {
>  		dev_err(&device->dev, "sysfs creation failed\n");
> -		goto r_free;
> +		goto r_sar;
>  	}
>  
>  	if (acpi_install_notify_handler(ACPI_HANDLE(&device->dev), ACPI_DEVICE_NOTIFY,
> @@ -292,6 +292,9 @@ static int sar_probe(struct platform_device *device)
>  
>  r_sys:
>  	sysfs_remove_group(&device->dev.kobj, &intcsar_group);
> +r_sar:
> +	for (reg = 0; reg < MAX_REGULATORY; reg++)
> +		kfree(context->config_data[reg].device_mode_info);
>  r_free:
>  	kfree(context);

How about try to do this with devm allocs instead (context itself 
included)? I think results would be much better with it.

-- 
 i.

