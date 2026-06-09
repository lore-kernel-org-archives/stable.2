Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD9E3E51F8;
	Tue,  9 Jun 2026 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000582; cv=none; b=Om1n5LjOJtNCJ/2aZ/9py4pUxy11In5T2IGxIkgGpS0TmaGBrLxD6ULyz6gUmC424ZC0Kz0m9EZwNGZCtCO5cgeG+bBUq3NsOjUNdjzD5Li8NV7cELAw1y5iToloo87krajyzs/93FgQEU1mm8B97n5YZRtpwEDt3OtYCbV1Xuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000582; c=relaxed/simple;
	bh=Ajh6vSMFe9OosdTju7MhzYoCTfhEnggFFu5Iyu+JvaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iY2ARndaJI3hEr1zCU26ioAnv/LfOwrkgkyegPqKkMwBOv/GGvF23OuFDkP7SD0j1k0QqS0WhKe4VDKsvnqFHEzTBexq4LFuO/D/Wgrfl9JdM0TnoKcwbiJFSPQDXG5bIDz1jnjOsDMV/U/AJcnP2V/9fkPtJnLsAfrIfSJpW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=YVl+t1Lq; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="YVl+t1Lq"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gZQ2z46l9z6x0;
	Tue,  9 Jun 2026 12:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1781000571;
	bh=yeMqVriOtLVHk3LxXpmJn2YqXFvAY9KPxJFyY7Fl80g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YVl+t1Lq/q3EJ4veMsT0eCjtnW1rOPGK+IL7uL/e9IBtgV832OlQViPQv3sD0S7Ys
	 mDdeWkmM6nWOotfqspiLCT09n5BQGRJl97EACf2D2d0XmPBBUqnLiWHxzsM0gW3ciy
	 rBq0ZhST1N9NY03vBRUV3A4c2u4tVUXuVUi6mlEtyIDoPopnUVRhluZQSEdvM5u5V4
	 ojZFe2Qwl1Ipnff6H119qM/ZKaWO2VjO3HzkoyVrJwclNwDPK1Ka/uJOZy5f/4rc5n
	 2lnqKHK17IKAC/TbPmGM11GVPi9jQnxHczrBuM/gwW/2XAPTx1SvXgl6I6qluYMDVp
	 WR7O/Oyibnfrg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gZQ2y0p7rzy2j;
	Tue,  9 Jun 2026 12:22:49 +0200 (CEST)
Message-ID: <f0ab78e8-7117-4ac1-bc31-ef9502a8ee42@gibson.sh>
Date: Tue, 9 Jun 2026 12:22:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] platform/x86/amd/pmc: Delay suspend for some
 Lenovo Laptops
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>,
 Sindre Henriksen <sindrehenriksen93@gmail.com>, stable@vger.kernel.org
References: <20260606044758.2213401-1-daniel@gibson.sh>
 <20260606044758.2213401-2-daniel@gibson.sh>
 <5f0dcb89-0e76-d6eb-a6b0-201a0ed1cd22@linux.intel.com>
Content-Language: de-DE, en-GB
From: Daniel Gibson <daniel@gibson.sh>
In-Reply-To: <5f0dcb89-0e76-d6eb-a6b0-201a0ed1cd22@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

On 09.06.26 12:07, Ilpo Järvinen wrote:
> On Sat, 6 Jun 2026, Daniel Gibson wrote:
> 
>> Some IdeaPad Slim 3 devices and similar with AMD CPUs have a
>> nonfunctional keyboard and lid switch after s2idle.
>>
>> It helps to delay suspend by 2.5 seconds so the EC has some time
>> to do whatever it needs to get done before suspend - unfortunately
>> at least on my 16ABR8 waking it with a timer (wakealarm) still
>> triggers the issue, but at least normal resume via keypress or
>> lid works fine. On the 14ARP10 wakealarm has been reported to also
>> work fine with this patch.
>>
>> This issue has been reported for many different devices, this patch
>> has been tested with the Zen3-based IdeaPad Slim 3 16ABR8 (82XR)
>> and the Zen3+-based IdeaPad Slim 3 14ARP10 (83K6) and IdeaPad Slim 3
>> 15ARP10 (83MM).
>>
>> Reported-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221383
>> Tested-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
>> Suggested-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Daniel Gibson <daniel@gibson.sh>
>> Cc: stable@vger.kernel.org
>> ---
>>  drivers/platform/x86/amd/pmc/pmc-quirks.c | 39 +++++++++++++++++++++++
>>  drivers/platform/x86/amd/pmc/pmc.c        | 24 +++++++++++++-
>>  drivers/platform/x86/amd/pmc/pmc.h        |  1 +
>>  3 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
>> index 24506e342943..74ddf1d8289a 100644
>> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
>> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
>> @@ -18,6 +18,7 @@
>>  struct quirk_entry {
>>  	u32 s2idle_bug_mmio;
>>  	bool spurious_8042;
>> +	bool need_suspend_delay;
>>  };
>>  
>>  static struct quirk_entry quirk_s2idle_bug = {
>> @@ -33,6 +34,10 @@ static struct quirk_entry quirk_s2idle_spurious_8042 = {
>>  	.spurious_8042 = true,
>>  };
>>  
>> +static struct quirk_entry quirk_s2idle_need_suspend_delay = {
>> +	.need_suspend_delay = true,
>> +};
>> +
>>  static const struct dmi_system_id fwbug_list[] = {
>>  	{
>>  		.ident = "L14 Gen2 AMD",
>> @@ -203,6 +208,35 @@ static const struct dmi_system_id fwbug_list[] = {
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
>>  		}
>>  	},
>> +	/* https://bugzilla.kernel.org/show_bug.cgi?id=221383 */
>> +	{
>> +		.ident = "Zen3-based IdeaPad Slim and similar",
>> +		.driver_data = &quirk_s2idle_need_suspend_delay,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			/*
>> +			 * Note: there are also some Zen2-based 82X* devices that
>> +			 * need different quirks, they're already handled above
>> +			 */
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "82X"),
>> +		}
>> +	},
>> +	{
>> +		.ident = "Zen3+-based IdeaPad Slim and similar",
>> +		.driver_data = &quirk_s2idle_need_suspend_delay,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "83K"),
>> +		}
>> +	},
>> +	{
>> +		.ident = "IdeaPad Slim 3 15ARP10 (83MM)",
>> +		.driver_data = &quirk_s2idle_need_suspend_delay,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "83MM"),
>> +		}
>> +	},
>>  	/* https://bugzilla.kernel.org/show_bug.cgi?id=221273 */
>>  	{
>>  		.ident = "Thinkpad L14 Gen3",
>> @@ -356,6 +390,11 @@ void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev)
>>  		amd_pmc_skip_nvme_smi_handler(dev->quirks->s2idle_bug_mmio);
>>  }
>>  
>> +bool amd_pmc_quirk_need_suspend_delay(struct amd_pmc_dev *dev)
>> +{
>> +	return dev->quirks && dev->quirks->need_suspend_delay;
>> +}
>> +
>>  void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
>>  {
>>  	const struct dmi_system_id *dmi_id;
>> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
>> index 2b9e5730170a..6bafd8661d68 100644
>> --- a/drivers/platform/x86/amd/pmc/pmc.c
>> +++ b/drivers/platform/x86/amd/pmc/pmc.c
>> @@ -611,6 +611,27 @@ static bool amd_pmc_intermediate_wakeup_need_delay(struct amd_pmc_dev *pdev)
>>  	return get_metrics_table(pdev, &table) == 0 && table.s0i3_last_entry_status;
>>  }
>>  
>> +static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
>> +{
>> +	/*
>> +	 * Some Lenovo Laptops (like different IdeaPad 3 Slims) need some
>> +	 * me-time before sleeping or they get uncooperative after waking
>> +	 * up and don't send events for keyboard and lid switch anymore.
>> +	 *
>> +	 * Unfortunately this doesn't entirely fix the problem: It can still
>> +	 * happen when resuming with a timer (wakealarm), but at least the
>> +	 * more common usecases (wakeup by opening lid or pressing a key)
>> +	 * work fine with this workaround.
>> +	 *
>> +	 * See https://bugzilla.kernel.org/show_bug.cgi?id=221383
>> +	 */
>> +	if (!disable_workarounds && amd_pmc_quirk_need_suspend_delay(pdev)) {
>> +		dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>>  static void amd_pmc_s2idle_prepare(void)
>>  {
>>  	struct amd_pmc_dev *pdev = &pmc;
>> @@ -647,7 +668,8 @@ static void amd_pmc_s2idle_check(void)
>>  	struct amd_pmc_dev *pdev = &pmc;
>>  	int rc;
>>  
>> -	if (amd_pmc_intermediate_wakeup_need_delay(pdev))
>> +	if (amd_pmc_intermediate_wakeup_need_delay(pdev) ||
>> +	    amd_pmc_want_suspend_delay(pdev))
> 
> This doesn't seem to apply to the review-ilpo-next branch. You might have 
> left the first patch of the series out from this v4?
> 
> Please send v5 to correct the problem.
> 

Damn, how did this happen..
You're right of course, sorry for this, will send v5!

