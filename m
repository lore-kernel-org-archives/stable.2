Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7A36F918;
	Mon,  8 Jun 2026 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919558; cv=none; b=sQVOKaLSoRJYy9cOxClTLUgBP1gsH93NlLeuP8V6N8EWhOPqm4bKmdtQsIHftt2AbIcij1pjv+H6CN/SKeTYrH+Vm+mnlowIsYhSdV7/aqI9fsvPbK2Wmr6phBASlt/p8tLZFNtTFwa35fCM1+NnM/ZG6ETc9omtnfWb7u1r/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919558; c=relaxed/simple;
	bh=MRO9QKNq/mjoG+V7gIOcZLh1xd3xr2wHAIdbFI4CA/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOxwxQqWmN/CGnbW+L7Nv8pYVTc2n/sMact0upndF/TGAjoOCsD3Lrn1iqCFC40CzekhqPXM1+ZvDeIbbEoKn/8lXus5py4jfgJlj211xVIVS6RyIuCNrnDyES/k4lYsIuHNIyFOZmTnSeyBpAsrdqNNln/K7inyUitj9foQEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og8d/day; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og8d/day"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6531F00893;
	Mon,  8 Jun 2026 11:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780919557;
	bh=OUlTt1Dp84aHbBLcIdpUD4GSuRwl9Z61rP1pIPa0VeI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=og8d/dayMao9GKOndROs9F70XA+QYUf9p+dxyehPdpQHt5gD9KzfuT6ABlWoZHfpF
	 AEZ9LsnuKhrhXYl0YHRxFb+nOHsunoI9il5+oDnzaKF8d2NNssZ4cJhi3FwLT6Wnb2
	 fhsLCo448e3iMQIbVqf3AGmcBzDSsnnsc/ROO5/aKrFSyrRUxomSuka4+sFi13Bga+
	 WtaCy9sG9zB1ETYU7SMMsHTyEXol6cZRE919lpGlt16boK6kdGt10XL2SHCK2ewKMT
	 kqSIoT6U4Z7XbIOwPw9TF0f5Zb7WE4vzlQwIeVZiZjWicjcgzuDyIzyRNTAIlwmBfs
	 OuAVLFg8cxJJA==
Message-ID: <7d2daeec-fc33-4fb3-aded-bd709fccb8f5@kernel.org>
Date: Mon, 8 Jun 2026 13:52:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] platform/x86/amd/pmc: Add delay_suspend module
 parameter
To: Daniel Gibson <daniel@gibson.sh>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org
References: <20260606044758.2213401-1-daniel@gibson.sh>
 <20260606044758.2213401-3-daniel@gibson.sh>
 <5aaf8759-048b-4550-becb-e8686137d3da@kernel.org>
 <731fc18e-818b-4986-94fa-ff14e4db7892@gibson.sh>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <731fc18e-818b-4986-94fa-ff14e4db7892@gibson.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8-Jun-26 1:41 PM, Daniel Gibson wrote:
> Hi,
> 
> On 08.06.26 13:22, Hans de Goede wrote:
>> Hi,
>>
>> On 6-Jun-26 6:47 AM, Daniel Gibson wrote:
>>> Enabling the new delay_suspend module parameter delays suspend for
>>> 2.5 seconds which is known to help for some AMD-based Lenovo Laptops
>>> that otherwise failed to send/receive events for key presses or the
>>> lid switch after s2idle. Apparently the EC needs to do some things
>>> in the background before suspend or it gets into a bad state.
>>>
>>> There are many reports of AMD-based laptops (mostly but not exclusively
>>> IdeaPads) about similar issues on the web; this parameter gives
>>> affected users an easy way to try out if their issues have the same
>>> root cause and to work around them until their specific device is added
>>> to the quirks list.
>>>
>>> The parameter description has a note encouraging users to report
>>> their device so it can be added to the quirks list, inspired by a
>>> similar request in parameter descriptions of the ideapad-laptop module.
>>>
>>> The module parameter can be set to "1" to explicitly enable it,
>>> "0" to disable it even on devices that are assumed to be affected,
>>> or -1 (the default) to enable it if the device is assumed to be affected
>>> (according to fwbug_list[])
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221383
>>> Signed-off-by: Daniel Gibson <daniel@gibson.sh>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>  drivers/platform/x86/amd/pmc/pmc.c | 25 +++++++++++++++++++++++--
>>>  1 file changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
>>> index 6bafd8661d68..2d3d180c15d2 100644
>>> --- a/drivers/platform/x86/amd/pmc/pmc.c
>>> +++ b/drivers/platform/x86/amd/pmc/pmc.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/bits.h>
>>>  #include <linux/debugfs.h>
>>>  #include <linux/delay.h>
>>> +#include <linux/dmi.h>
>>>  #include <linux/io.h>
>>>  #include <linux/iopoll.h>
>>>  #include <linux/limits.h>
>>
>> This addition of including dmi.h seems unnecessary.
>>
> 
> It's for that dev_info() call in the case that someone has enforced the option, see below

Ah right, that makes sense. Never mind then :)

Regards,

Hans




> 
>>> @@ -89,6 +90,11 @@ static bool disable_workarounds;
>>>  module_param(disable_workarounds, bool, 0644);
>>>  MODULE_PARM_DESC(disable_workarounds, "Disable workarounds for platform bugs");
>>>  
>>> +static int delay_suspend = -1;
>>> +module_param(delay_suspend, int, 0644);
>>> +MODULE_PARM_DESC(delay_suspend,
>>> +		 "Delays s2idle by 2.5 seconds to work around buggy ECs, often causing keyboard issues after suspend. 0: don't delay, 1: do delay, -1 (default): let amd_pmc decide. If you need this please report this to: platform-driver-x86@vger.kernel.org");
>>> +
>>>  static struct amd_pmc_dev pmc;
>>>  
>>>  static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
>>> @@ -625,8 +631,23 @@ static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
>>>  	 *
>>>  	 * See https://bugzilla.kernel.org/show_bug.cgi?id=221383
>>>  	 */
>>> -	if (!disable_workarounds && amd_pmc_quirk_need_suspend_delay(pdev)) {
>>> -		dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
>>> +	if (amd_pmc_quirk_need_suspend_delay(pdev)) {
>>> +		/*
>>> +		 * delay_suspend=1 force-enables this, otherwise it can be
>>> +		 * disabled with disable_workarounds or delay_suspend=0
>>> +		 */
>>> +		if (delay_suspend == 1 || (delay_suspend == -1 && !disable_workarounds)) {
>>> +			dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
>>> +			return true;
>>> +		}
>>> +		dev_info(pdev->dev, "Not delaying suspend because of module parameter, even though your device is assumed to need it!\n");
>>> +	} else if (delay_suspend == 1) {
>>> +		dev_info(pdev->dev, "Delaying suspend by 2.5s because delay_suspend=1. If this solves problems on your machine, please report this whole line to: platform-driver-x86@vger.kernel.org so it can be automatically detected as affected in the future. System Vendor: \"%s\" Product Name: \"%s\" Product Family: \"%s\" Board Vendor: \"%s\" Board Name: \"%s\"\n",
>>> +			 dmi_get_system_info(DMI_SYS_VENDOR),
>>> +			 dmi_get_system_info(DMI_PRODUCT_NAME),
>>> +			 dmi_get_system_info(DMI_PRODUCT_FAMILY),
>>> +			 dmi_get_system_info(DMI_BOARD_VENDOR),
>>> +			 dmi_get_system_info(DMI_BOARD_NAME));
> 
> this one
> 
>>>  		return true;
>>>  	}
>>>  	return false;
>>
>> Otherwise this looks good to me:
>>
>> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> 
> Thank you very much for the reviews!
> 
>>
>> Regards,
>>
>> Hans
>>
> 
> Cheers,
> Daniel
> 

