Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0F31197C
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006850; cv=none; b=iz3bi77AmpeBKebcv+rXzveCetUxZqKrW1x3GOM6R9zTmXKrpzXedB3K/hheBewnBvg/mzEXdk+oa3OZHTk9OibX0LV3F8d4NPvl5u7GWWMz+jR/FG3413luuKeV9/Ku5v254UYghrtVzQ/6zAvssgVI7uEhW6ztf6TKgI5OFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006850; c=relaxed/simple;
	bh=tiRjr/pdfVRRlc25RE64J4c1WFk+pBce+gPeSbAprzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXO3FhgrGXnflINMw1fUXEABMP94gFDN9qQYaLDZPo4t+Q5NSKvQIXfkbyhqVvBb1msavP94ej7YSbfuP2qzEckDRTRX6ME5Op6c7n0ftvP/jJ3M3sIye8x/pkLLE/YFDTBHl79L9VDGA1mY1nKmkeYxjb1wwNhGBiPUjfx9/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=lrBF5a+T; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="lrBF5a+T"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gZSMd6lLBz25k;
	Tue,  9 Jun 2026 14:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1781006845;
	bh=/A8CBVe4YNr9ebWgTbpqBt1LFrM9ZwtwHeyvgtrwjKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lrBF5a+TzGZYcJDQsgnYFOwmSsy2CivDT3hcAcBwcfDvFgtmcwk47a2cqMvJJMMdD
	 IuZRrWaOBVDqzEg+tUALqMTW2WxvRme4j22MoX3G9zYS41UJ7g/iGC5qwSC0MM3YVa
	 CroDW1OIpAs6NtH6NuzryU3phTiVecMkAaljd158L5eRMcjs3WbRTGoK4WmH0S67Sf
	 kNKGvqzLmK4XRX+9LDBWjDmAZM11oPW9rdD6gguN0quqsv8p2TYeDxaGa1NaZx5Jx3
	 016p6QlRYBexGFBoBdHZ5ESirw78MJDC5r4BWG09W+7FanROKUn6roaF4g6aQsc7qe
	 lhkdEtIf6/TcQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gZSMc3B8lznLh;
	Tue,  9 Jun 2026 14:07:24 +0200 (CEST)
Message-ID: <6b6ce9ce-5bda-4924-b2d2-933736cfad9c@gibson.sh>
Date: Tue, 9 Jun 2026 14:07:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] platform/x86/amd/pmc: Delay suspend for some
 Lenovo Laptops
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>,
 Sindre Henriksen <sindrehenriksen93@gmail.com>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>, stable@vger.kernel.org
References: <20260609105756.2813669-1-daniel@gibson.sh>
 <20260609105756.2813669-3-daniel@gibson.sh>
 <2fbb4d9d-7ad5-d4e7-b510-d7c75f399d97@linux.intel.com>
Content-Language: de-DE, en-GB
From: Daniel Gibson <daniel@gibson.sh>
In-Reply-To: <2fbb4d9d-7ad5-d4e7-b510-d7c75f399d97@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

On 09.06.26 13:46, Ilpo Järvinen wrote:
> On Tue, 9 Jun 2026, Daniel Gibson wrote:
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
>> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
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
> 
> Hi,
> 
> One more question.
> 
> Sashiko noted, that amd_pmc_quirks_init() can overwrite 
> disable_8042_wakeup from the AMD_CPU_ID_CZN check when .driver_data 
> provides quirks. Is it okay in this case to not have .spurious_8042?
> 

Good question.
So far I haven't had complaints that sounded like they'd be related to
this quirk not being active.

(The only report about things not working as expected on detected
devices was something about "ACPI event storms" after resume:
https://github.com/DanielGibson/amd_pmc-ideapad/issues/3 - but no one
else with similar devices could reproduce that, so no idea what's going
on there, and it doesn't sound like that IRQ1 issue)

I can test if explicitly enabling .spurious_8042 in
quirk_s2idle_need_suspend_delay breaks anything on my device, if you
think that enabling it by default makes more sense?
