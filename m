Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48EC2F5468
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780717860; cv=none; b=mQObb4k0O5PemgmjPa9ZNU2avnwsn86gKESDI0dj6vf/TzymTJU3DOyYW5/7wQe4BVU0mGJT79J5Xl5vE71ajtDLYTQ7/8pxiUa/TpBJMrndVyGjUF9/4R2l3MPN7Nw+4dJVFN28FxI7l9QA5qz5NJawWncyA09aJdWXBs5t4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780717860; c=relaxed/simple;
	bh=NlNVutzsag3ubNZVQxraoUiwWoRXwj6MhDg93P424gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COlgpIWxiHtBvfuV20h1Eg942+ocDrDw04fTYBwpdfWZrCR3cw2miImaCdiqjwKBJuSvtRHnqJCscl82Ss9XE9fUZkxPG2XaeqeEm5Xct/RFtMify7Scaxd6hGxyVrOZQzsYPIijkaipDu+ZPTxicaJ+BEWYeAY6pK3T423k8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=JfGMWfm9; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="JfGMWfm9"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gXPM267dszPh5;
	Sat,  6 Jun 2026 05:44:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1780717486;
	bh=t15ITGxDTBskwzWjb37Aaq12xEBm+R6pct9XAVwTDDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JfGMWfm98tc3aExTWrv6QS3K+K2FigxzKy5d2BNGEg+kaJtzAOrAxjE+gmC6e3V/3
	 wQL0DiPxn1mdsxBdpWVg8gH+MB/IGz+tQaoTTYE5rBKlS3ImJGQAEynFrv4I8/TEjs
	 r+AzwS7eBLHgGymDlVlrwoNgSRXzEMerllXccoHgW9w2rjQFLuWif6sPbiMHx5K+tI
	 rN4Pvs7F8AUPPnZICEPVehEEtCuA117x5fgmazxuYRfZixnf3Q4nKVFRj1+L0n6147
	 u8moYHId6EQSkTI3PWCWRM1D9/Vqe209EdgAW6DJhGVeDvi4Ynak1RDyI0lZW9SvS1
	 NWqgsm7BZDgRw==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gXPM140Tcz952;
	Sat,  6 Jun 2026 05:44:45 +0200 (CEST)
Message-ID: <31cdaaa3-b430-4a34-b1d0-2021e722a775@gibson.sh>
Date: Sat, 6 Jun 2026 05:44:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND 3/5] platform/x86/amd/pmc: Add delay_suspend
 module parameter
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org
References: <20260603031110.345815-1-daniel@gibson.sh>
 <20260603031110.345815-4-daniel@gibson.sh>
Content-Language: de-DE, en-GB
From: Daniel Gibson <daniel@gibson.sh>
In-Reply-To: <20260603031110.345815-4-daniel@gibson.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha

On 03.06.26 05:11, Daniel Gibson wrote:
> Enabling the new delay_suspend module parameter delays suspend for
> 2.5 seconds which is known to help for some AMD-based Lenovo Laptops
> that otherwise failed to send/receive events for key presses or the
> lid switch after s2idle. Apparently the EC needs to do some things
> in the background before suspend or it gets into a bad state.
> 
> There are many reports of AMD-based laptops (mostly but not exclusively
> IdeaPads) about similar issues on the web; this parameter gives
> affected users an easy way to try out if their issues have the same
> root cause and to work around them until their specific device is added
> to the quirks list.
> 
> The parameter description has a note encouraging users to report
> their device so it can be added to the quirks list, inspired by a
> similar request in parameter descriptions of the ideapad-laptop module.
> 
> The module parameter can be set to "1" to explicitly enable it,
> "0" to disable it even on devices that are assumed to be affected,
> or -1 (the default) to enable it if the device is assumed to be affected
> (according to fwbug_list[])
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221383
> Signed-off-by: Daniel Gibson <daniel@gibson.sh>
> Cc: stable@vger.kernel.org
> ---
>  drivers/platform/x86/amd/pmc/pmc.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index 6bafd8661d68..2d3d180c15d2 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -16,6 +16,7 @@
>  #include <linux/bits.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> +#include <linux/dmi.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/limits.h>
> @@ -89,6 +90,11 @@ static bool disable_workarounds;
>  module_param(disable_workarounds, bool, 0644);
>  MODULE_PARM_DESC(disable_workarounds, "Disable workarounds for platform bugs");
>  
> +static int delay_suspend = -1;
> +module_param(delay_suspend, int, 0644);
> +MODULE_PARM_DESC(delay_suspend,
> +		 "Delays s2idle by 2.5 seconds to work around buggy ECs, often causing keyboard issues after suspend. 0: don't delay, 1: do delay, -1 (default): let amd_pmc decide. If you need this please report this to: platform-driver-x86@vger.kernel.org");
> +
>  static struct amd_pmc_dev pmc;
>  
>  static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
> @@ -625,8 +631,23 @@ static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
>  	 *
>  	 * See https://bugzilla.kernel.org/show_bug.cgi?id=221383
>  	 */
> -	if (!disable_workarounds && amd_pmc_quirk_need_suspend_delay(pdev)) {
> -		dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
> +	if (amd_pmc_quirk_need_suspend_delay(pdev)) {
> +		/*
> +		 * delay_suspend=1 force-enables this, otherwise it can be
> +		 * disabled with disable_workarounds or delay_suspend=0
> +		 */
> +		if (delay_suspend == 1 || (delay_suspend == -1 && !disable_workarounds)) {
> +			dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");

It turned out that these messages are logged *a lot* if this is an
intermediate wakeup and the deepest sleep state isn't reached, which
happens while these IdeaPads are charging.

Sleeping is still necessary in that case, otherwise the machine resumes
after a few seconds..

I'll add a commit that makes this function less chatty soon.

> +			return true;
> +		}
> +		dev_info(pdev->dev, "Not delaying suspend because of module parameter, even though your device is assumed to need it!\n");
> +	} else if (delay_suspend == 1) {
> +		dev_info(pdev->dev, "Delaying suspend by 2.5s because delay_suspend=1. If this solves problems on your machine, please report this whole line to: platform-driver-x86@vger.kernel.org so it can be automatically detected as affected in the future. System Vendor: \"%s\" Product Name: \"%s\" Product Family: \"%s\" Board Vendor: \"%s\" Board Name: \"%s\"\n",
> +			 dmi_get_system_info(DMI_SYS_VENDOR),
> +			 dmi_get_system_info(DMI_PRODUCT_NAME),
> +			 dmi_get_system_info(DMI_PRODUCT_FAMILY),
> +			 dmi_get_system_info(DMI_BOARD_VENDOR),
> +			 dmi_get_system_info(DMI_BOARD_NAME));
>  		return true;
>  	}
>  	return false;

