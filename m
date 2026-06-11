Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDAD40683D
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187622; cv=none; b=aHHOjFShMJXE//rMFWfODmHznsjMnYXC0OQyaXXiLRDsD/twgm23Tmq1qtXT3SEXsnx4yt/1tkQvfwEUSpUhJwdQqpcee/Fk3wefs8w6pew+/O0QAtCrMcNbBydusixzhMh+AQmoD9SuCq+mWtGK06CCozKCogYPeohLNUzp+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187622; c=relaxed/simple;
	bh=brkNIuGpLgiXdVlMrRBDOd1Hl5+Wk3ZdSGY2cHZbQQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZ7ec/kf/mx39CpTzOIC+V98ZHBhi4IMnP49cihB/7UehPBNfAeUBLTpuZZpkfCwOGxopc4cHLY6CBWvkOnLurnuY+svs0itofACOcW5St4AyM48oSBdIUFDEKMRlRIVInzpjN4Uw71cmFqz9QUh2dTNQKPJQUCOHiQBy63iwRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=OUhWreUH; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="OUhWreUH"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gblCw3g3YzDnN;
	Thu, 11 Jun 2026 16:20:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1781187612;
	bh=tPxdcxLEy6pAalTNE6zjKloyxL4UuKa+Sj/8bGNM4Z0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OUhWreUH2gZ7J00ndoMDmbTXNUrKFKb0W6I2KU/gVQtVnc75o6r2EWSe+YbYek4y2
	 sEeuElYGpyidp/qEiYwoz1Kp+XUb3S0h0PjSpN4/siqC7L1z9L+g4ASy8aCAaRIxxT
	 yjsNnU7ejMbz2pD+W8sGUvMDRkCDDAMqSQJRwd7rs7jU9tNiFs1dRCqZ6eoGIQjSP6
	 4GQYjSupTlQXvfzmADED4cb6wvX+/UwqZqiIKl2rVZcU23YfwM34ao4YBA25kKpyGq
	 muag9VOXEdHduKepyksjKEOvjByUz4z2pbSljL+XsNiICHQSwB5ZTTfBds+7vVJSZg
	 9KPyJ9WqoG3yg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gblCv3Mtmz7fZ;
	Thu, 11 Jun 2026 16:20:11 +0200 (CEST)
Message-ID: <d522d2c1-5058-421b-97b9-bb106b7efd06@gibson.sh>
Date: Thu, 11 Jun 2026 16:20:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] platform/x86/amd/pmc: Don't log during
 intermediate wakeups
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>, stable@vger.kernel.org
References: <20260609105756.2813669-1-daniel@gibson.sh>
 <20260609105756.2813669-5-daniel@gibson.sh>
 <4bc20ca2-8544-e36e-70af-a19364e59eba@linux.intel.com>
Content-Language: de-DE, en-GB
From: Daniel Gibson <daniel@gibson.sh>
In-Reply-To: <4bc20ca2-8544-e36e-70af-a19364e59eba@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

On 11.06.26 16:02, Ilpo Järvinen wrote:
> On Tue, 9 Jun 2026, Daniel Gibson wrote:
> 
>> The ECs in the IdeaPads that need the delay_suspend quirk send lots
>> of messages when charging, which not only causes intermediate wakeups
>> when suspended, but also prevents the device from reaching the deepest
>> suspend state.
>>
>> Because of this amd_pmc_intermediate_wakeup_need_delay() returns false
>> during intermediate wakeups and amd_pmc_want_suspend_delay() is called.
>> So far it always logged its "Delaying suspend by 2.5s ..." messages
>> then, which spams dmesg. This commit makes sure that those messages are
>> only logged once per suspend.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221383
>> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> Signed-off-by: Daniel Gibson <daniel@gibson.sh>
>> Cc: stable@vger.kernel.org
>> ---
>>  drivers/platform/x86/amd/pmc/pmc.c | 39 ++++++++++++++++++++++++------
>>  drivers/platform/x86/amd/pmc/pmc.h |  1 +
>>  2 files changed, 32 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
>> index 2d3d180c15d2..7d772ccd17a6 100644
>> --- a/drivers/platform/x86/amd/pmc/pmc.c
>> +++ b/drivers/platform/x86/amd/pmc/pmc.c
>> @@ -619,6 +619,20 @@ static bool amd_pmc_intermediate_wakeup_need_delay(struct amd_pmc_dev *pdev)
>>  
>>  static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
>>  {
>> +	/*
>> +	 * intermediate_wakeup implies that the machine didn't get to deepest sleep
>> +	 * state before - otherwise this function isn't called in amd_pmc_s2idle_check()
>> +	 * because amd_pmc_intermediate_wakeup_need_delay() returns true first.
>> +	 * On some IdeaPads that happens when charging, because the EC seems
>> +	 * to send lots of messages then that wake the machine.
>> +	 *
>> +	 * But even in that case, the sleep here is necessary (on those IdeaPads),
>> +	 * otherwise they wake up completely (resume) after a few seconds.
>> +	 * So this variable is only used to avoid spamming dmesg on each
>> +	 * intermediate wakeup.
>> +	 */
>> +	bool intermediate_wakeup = !pdev->is_first_check_after_suspend;
>> +
>>  	/*
>>  	 * Some Lenovo Laptops (like different IdeaPad 3 Slims) need some
>>  	 * me-time before sleeping or they get uncooperative after waking
>> @@ -637,17 +651,20 @@ static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
>>  		 * disabled with disable_workarounds or delay_suspend=0
>>  		 */
>>  		if (delay_suspend == 1 || (delay_suspend == -1 && !disable_workarounds)) {
>> -			dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
>> +			if (!intermediate_wakeup)
>> +				dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
>>  			return true;
>>  		}
>> -		dev_info(pdev->dev, "Not delaying suspend because of module parameter, even though your device is assumed to need it!\n");
>> +		if (!intermediate_wakeup)
>> +			dev_info(pdev->dev, "Not delaying suspend because of module parameter, even though your device is assumed to need it!\n");
>>  	} else if (delay_suspend == 1) {
>> -		dev_info(pdev->dev, "Delaying suspend by 2.5s because delay_suspend=1. If this solves problems on your machine, please report this whole line to: platform-driver-x86@vger.kernel.org so it can be automatically detected as affected in the future. System Vendor: \"%s\" Product Name: \"%s\" Product Family: \"%s\" Board Vendor: \"%s\" Board Name: \"%s\"\n",
>> -			 dmi_get_system_info(DMI_SYS_VENDOR),
>> -			 dmi_get_system_info(DMI_PRODUCT_NAME),
>> -			 dmi_get_system_info(DMI_PRODUCT_FAMILY),
>> -			 dmi_get_system_info(DMI_BOARD_VENDOR),
>> -			 dmi_get_system_info(DMI_BOARD_NAME));
>> +		if (!intermediate_wakeup)
>> +			dev_info(pdev->dev, "Delaying suspend by 2.5s because delay_suspend=1. If this solves problems on your machine, please report this whole line to: platform-driver-x86@vger.kernel.org so it can be automatically detected as affected in the future. System Vendor: \"%s\" Product Name: \"%s\" Product Family: \"%s\" Board Vendor: \"%s\" Board Name: \"%s\"\n",
>> +				 dmi_get_system_info(DMI_SYS_VENDOR),
>> +				 dmi_get_system_info(DMI_PRODUCT_NAME),
>> +				 dmi_get_system_info(DMI_PRODUCT_FAMILY),
>> +				 dmi_get_system_info(DMI_BOARD_VENDOR),
>> +				 dmi_get_system_info(DMI_BOARD_NAME));
>>  		return true;
>>  	}
>>  	return false;
>> @@ -660,6 +677,9 @@ static void amd_pmc_s2idle_prepare(void)
>>  	u8 msg;
>>  	u32 arg = 1;
>>  
>> +	/* Reset this variable because this is a fresh suspend */
>> +	pdev->is_first_check_after_suspend = true;
>> +
>>  	/* Reset and Start SMU logging - to monitor the s0i3 stats */
>>  	amd_pmc_setup_smu_logging(pdev);
>>  
>> @@ -699,6 +719,9 @@ static void amd_pmc_s2idle_check(void)
>>  	rc = amd_stb_write(pdev, AMD_PMC_STB_S2IDLE_CHECK);
>>  	if (rc)
>>  		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
>> +
>> +	/* remember that first check after suspend is done (until next prepare) */
>> +	pdev->is_first_check_after_suspend = false;
>>  }
>>  
>>  static int amd_pmc_dump_data(struct amd_pmc_dev *pdev)
>> diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
>> index f5257e47b8c4..8aa7073ed09f 100644
>> --- a/drivers/platform/x86/amd/pmc/pmc.h
>> +++ b/drivers/platform/x86/amd/pmc/pmc.h
>> @@ -114,6 +114,7 @@ struct amd_pmc_dev {
>>  	struct dentry *dbgfs_dir;
>>  	struct quirk_entry *quirks;
>>  	bool disable_8042_wakeup;
>> +	bool is_first_check_after_suspend;
>>  	struct amd_mp2_dev *mp2;
>>  	struct stb_arg stb_arg;
>>  };
>>
> 
> Hi,
> 
> This fails to apply to the review-ilpo-next branch and I don't want to 
> spend time at this point to figure it out so please send v6 which is 
> based on the for-next or review-ilpo-next branch:
> 
> Applying: platform/x86/amd/pmc: Check for intermediate wakeup in function
> Applying: platform/x86/amd/pmc: Delay suspend for some Lenovo Laptops
> Applying: platform/x86/amd/pmc: Add delay_suspend module parameter
> Applying: platform/x86/amd/pmc: Don't log during intermediate wakeups
> error: patch failed: drivers/platform/x86/amd/pmc/pmc.c:660
> error: drivers/platform/x86/amd/pmc/pmc.c: patch does not apply
> error: patch failed: drivers/platform/x86/amd/pmc/pmc.h:114
> error: drivers/platform/x86/amd/pmc/pmc.h: patch does not apply
> Patch failed at 0004 platform/x86/amd/pmc: Don't log during intermediate wakeups
> 
> 

Hi,

is the review-ilpo-next branch on
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/?h=review-ilpo-next
up-to-date?
I checked it out and cherry-picked my patches from my original branch
and all applied without conflicts, so I wonder if I'm missing commits
introducing conflicts.

