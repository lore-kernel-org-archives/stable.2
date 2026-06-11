Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C982DA76C;
	Thu, 11 Jun 2026 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186559; cv=none; b=pHnuQZPdzeSUgtRyaYxEkO8K23uJ9JSVb/FHAY+YRKvkMheS5QI95N8hV1vsg0yP7l+EZlBut1OVDMbL9SBKT7A6N28NZvbGdCDhoHi8L2UxLCMAXTWNsVA7BE7mGalOh/R5IH6dZSnIrn/YeFO1y1z1r0bIHajMHbV5Zor07Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186559; c=relaxed/simple;
	bh=dwC/OVIBHtCi6hgFIg6ZG7LlkilEzUewlyQNM6UC8K0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uRCeKZUi9r51ByIXxj6CJnMBp5tI2IvYdUbmeoTDDW8dyLaJsahMRgvuWq+avJF1+azKHd2oehLkyA3/y+l5q/bPUKylwDzmUVVVlBVCSILTeAk/Pji1kVyj2ZidgrVPtDLRZpxBt6xZj5bUFYSkJio1jckV5YYCDzr0Bh/WBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qucg61Sh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qucg61Sh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781186558; x=1812722558;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dwC/OVIBHtCi6hgFIg6ZG7LlkilEzUewlyQNM6UC8K0=;
  b=Qucg61Sh4qQpnxgPeARYW/FwGYTZsEKEENQIJr04HIFkpsF1fyw2pN6b
   /6j8/SebmantLlnWuu5aY0Iz7Qm/gsR0/mXS2LOMgBTuDdUIMhmA+sVN3
   amARgGYBLVITT7eVRhxSIYSYqeVCKH2/VieMitdZ6ecwIaPlBcp2QirZ8
   RiJrQu/2ifj/28aRgg+yoovurlD6VXAz3MIpt+nyzFu1l1P46Luze5yiS
   VD3PXyt9TMOM3i1LQUBa0rbZAX6ral9V6dixV7ENzfGwv4iO+968v/YAk
   RxJ0Kv3aP54dnWF+NjzABwVZeAbT6MR/Th6Nt6BK17LLbpO4yRuztojSR
   w==;
X-CSE-ConnectionGUID: Yw6nhud8TDqvbSyaigjaMQ==
X-CSE-MsgGUID: aQuwLqPUSOuIZMLRXzK9Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82061616"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82061616"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 07:02:38 -0700
X-CSE-ConnectionGUID: yZxzYCqnTayi1H5/3gAx3A==
X-CSE-MsgGUID: FrGf48BPRs+VBPSGa1Jrrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="245376036"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 07:02:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jun 2026 17:02:30 +0300 (EEST)
To: Daniel Gibson <daniel@gibson.sh>
cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mario Limonciello <superm1@kernel.org>, 
    Hans de Goede <johannes.goede@oss.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 4/4] platform/x86/amd/pmc: Don't log during intermediate
 wakeups
In-Reply-To: <20260609105756.2813669-5-daniel@gibson.sh>
Message-ID: <4bc20ca2-8544-e36e-70af-a19364e59eba@linux.intel.com>
References: <20260609105756.2813669-1-daniel@gibson.sh> <20260609105756.2813669-5-daniel@gibson.sh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 9 Jun 2026, Daniel Gibson wrote:

> The ECs in the IdeaPads that need the delay_suspend quirk send lots
> of messages when charging, which not only causes intermediate wakeups
> when suspended, but also prevents the device from reaching the deepest
> suspend state.
> 
> Because of this amd_pmc_intermediate_wakeup_need_delay() returns false
> during intermediate wakeups and amd_pmc_want_suspend_delay() is called.
> So far it always logged its "Delaying suspend by 2.5s ..." messages
> then, which spams dmesg. This commit makes sure that those messages are
> only logged once per suspend.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221383
> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> Signed-off-by: Daniel Gibson <daniel@gibson.sh>
> Cc: stable@vger.kernel.org
> ---
>  drivers/platform/x86/amd/pmc/pmc.c | 39 ++++++++++++++++++++++++------
>  drivers/platform/x86/amd/pmc/pmc.h |  1 +
>  2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index 2d3d180c15d2..7d772ccd17a6 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -619,6 +619,20 @@ static bool amd_pmc_intermediate_wakeup_need_delay(struct amd_pmc_dev *pdev)
>  
>  static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
>  {
> +	/*
> +	 * intermediate_wakeup implies that the machine didn't get to deepest sleep
> +	 * state before - otherwise this function isn't called in amd_pmc_s2idle_check()
> +	 * because amd_pmc_intermediate_wakeup_need_delay() returns true first.
> +	 * On some IdeaPads that happens when charging, because the EC seems
> +	 * to send lots of messages then that wake the machine.
> +	 *
> +	 * But even in that case, the sleep here is necessary (on those IdeaPads),
> +	 * otherwise they wake up completely (resume) after a few seconds.
> +	 * So this variable is only used to avoid spamming dmesg on each
> +	 * intermediate wakeup.
> +	 */
> +	bool intermediate_wakeup = !pdev->is_first_check_after_suspend;
> +
>  	/*
>  	 * Some Lenovo Laptops (like different IdeaPad 3 Slims) need some
>  	 * me-time before sleeping or they get uncooperative after waking
> @@ -637,17 +651,20 @@ static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
>  		 * disabled with disable_workarounds or delay_suspend=0
>  		 */
>  		if (delay_suspend == 1 || (delay_suspend == -1 && !disable_workarounds)) {
> -			dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
> +			if (!intermediate_wakeup)
> +				dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
>  			return true;
>  		}
> -		dev_info(pdev->dev, "Not delaying suspend because of module parameter, even though your device is assumed to need it!\n");
> +		if (!intermediate_wakeup)
> +			dev_info(pdev->dev, "Not delaying suspend because of module parameter, even though your device is assumed to need it!\n");
>  	} else if (delay_suspend == 1) {
> -		dev_info(pdev->dev, "Delaying suspend by 2.5s because delay_suspend=1. If this solves problems on your machine, please report this whole line to: platform-driver-x86@vger.kernel.org so it can be automatically detected as affected in the future. System Vendor: \"%s\" Product Name: \"%s\" Product Family: \"%s\" Board Vendor: \"%s\" Board Name: \"%s\"\n",
> -			 dmi_get_system_info(DMI_SYS_VENDOR),
> -			 dmi_get_system_info(DMI_PRODUCT_NAME),
> -			 dmi_get_system_info(DMI_PRODUCT_FAMILY),
> -			 dmi_get_system_info(DMI_BOARD_VENDOR),
> -			 dmi_get_system_info(DMI_BOARD_NAME));
> +		if (!intermediate_wakeup)
> +			dev_info(pdev->dev, "Delaying suspend by 2.5s because delay_suspend=1. If this solves problems on your machine, please report this whole line to: platform-driver-x86@vger.kernel.org so it can be automatically detected as affected in the future. System Vendor: \"%s\" Product Name: \"%s\" Product Family: \"%s\" Board Vendor: \"%s\" Board Name: \"%s\"\n",
> +				 dmi_get_system_info(DMI_SYS_VENDOR),
> +				 dmi_get_system_info(DMI_PRODUCT_NAME),
> +				 dmi_get_system_info(DMI_PRODUCT_FAMILY),
> +				 dmi_get_system_info(DMI_BOARD_VENDOR),
> +				 dmi_get_system_info(DMI_BOARD_NAME));
>  		return true;
>  	}
>  	return false;
> @@ -660,6 +677,9 @@ static void amd_pmc_s2idle_prepare(void)
>  	u8 msg;
>  	u32 arg = 1;
>  
> +	/* Reset this variable because this is a fresh suspend */
> +	pdev->is_first_check_after_suspend = true;
> +
>  	/* Reset and Start SMU logging - to monitor the s0i3 stats */
>  	amd_pmc_setup_smu_logging(pdev);
>  
> @@ -699,6 +719,9 @@ static void amd_pmc_s2idle_check(void)
>  	rc = amd_stb_write(pdev, AMD_PMC_STB_S2IDLE_CHECK);
>  	if (rc)
>  		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
> +
> +	/* remember that first check after suspend is done (until next prepare) */
> +	pdev->is_first_check_after_suspend = false;
>  }
>  
>  static int amd_pmc_dump_data(struct amd_pmc_dev *pdev)
> diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
> index f5257e47b8c4..8aa7073ed09f 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.h
> +++ b/drivers/platform/x86/amd/pmc/pmc.h
> @@ -114,6 +114,7 @@ struct amd_pmc_dev {
>  	struct dentry *dbgfs_dir;
>  	struct quirk_entry *quirks;
>  	bool disable_8042_wakeup;
> +	bool is_first_check_after_suspend;
>  	struct amd_mp2_dev *mp2;
>  	struct stb_arg stb_arg;
>  };
> 

Hi,

This fails to apply to the review-ilpo-next branch and I don't want to 
spend time at this point to figure it out so please send v6 which is 
based on the for-next or review-ilpo-next branch:

Applying: platform/x86/amd/pmc: Check for intermediate wakeup in function
Applying: platform/x86/amd/pmc: Delay suspend for some Lenovo Laptops
Applying: platform/x86/amd/pmc: Add delay_suspend module parameter
Applying: platform/x86/amd/pmc: Don't log during intermediate wakeups
error: patch failed: drivers/platform/x86/amd/pmc/pmc.c:660
error: drivers/platform/x86/amd/pmc/pmc.c: patch does not apply
error: patch failed: drivers/platform/x86/amd/pmc/pmc.h:114
error: drivers/platform/x86/amd/pmc/pmc.h: patch does not apply
Patch failed at 0004 platform/x86/amd/pmc: Don't log during intermediate wakeups


-- 
 i.

