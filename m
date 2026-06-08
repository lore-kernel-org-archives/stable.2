Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1170D3659F9;
	Mon,  8 Jun 2026 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917877; cv=none; b=dI7PaADvd2BE5hhoQkam/TTYYXzlcxBjYWawc/uPzl44LN5cpo1GpehtYEMnSkpvmoZO64RI6PHpg5w7ORfiTU1zh7YER+pcpL4Iq+eqEaxF9e98AU6mbVMXxj5pPh9Txf7ZFPCZfKcRBdDaDKtOvvIIaNMCad9Y0rW4bpqiPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917877; c=relaxed/simple;
	bh=SB7hW2T6cfe7mQUO4yQhlSCQ1xZECH6y0kqEwyRIOd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0rbt6ttI2GfzIMZYDG+k/Vy0FYXGu1IiO4OUGFZJxVOJGqi6tl2pSrVdhnPqi3FoUDeONxJyVPB4J5XG+GBO+y0J0Jv66+UQIfb/zZ5fNyA8R6U7I9Rs4y3cUSAMR0mabqRfpe4Kp6UlCFsmI8Ns3DWJpgdqNr2+lk3Ij7JysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9/ayf7b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9/ayf7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98E91F00893;
	Mon,  8 Jun 2026 11:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917876;
	bh=fACkc0stbZIYQa+n/02cI3beAahD8rc2wpwfQM32TYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=X9/ayf7bJXAvmMYHuTZH3y9EW3Cc/gJtnhhlLx7eiT3Th0BtB8vHkHfsaGY7b6en7
	 J9fYURx9OyPyq4ykhw9PLwynr2K3oWeIOUIS5uEt9akljy8amML7OoZ4KI/yfbe34o
	 DF2a+gzxLS323+k5qoGeZMQ1iLgjehSqidtlyUlSuycvHQx/OfXk1hSvwtiH4BuNT4
	 OwvGHUlLCsC1aV//rPD+6Nd/wW1H8zO22p8rkZZLpJhWKc4MQJhX8LChfAnRPJuS1J
	 KrJ96oh/bU+G7RMdS/J3s4ffGkmcgGc/dc93L68Wi075D7NoQmwrKVQmeT/uVb4wxn
	 61qZEmnoQubDQ==
Message-ID: <d79bc39e-28fb-4775-ad3e-01ba0643b712@kernel.org>
Date: Mon, 8 Jun 2026 13:24:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] platform/x86/amd/pmc: Don't log during
 intermediate wakeups
To: Daniel Gibson <daniel@gibson.sh>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org
References: <20260606044758.2213401-1-daniel@gibson.sh>
 <20260606044758.2213401-4-daniel@gibson.sh>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260606044758.2213401-4-daniel@gibson.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6-Jun-26 6:47 AM, Daniel Gibson wrote:
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
> Signed-off-by: Daniel Gibson <daniel@gibson.sh>
> Cc: stable@vger.kernel.org

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



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

