Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4335AC2C;
	Tue,  9 Jun 2026 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016036; cv=none; b=TNw+UwfIbkiAIBLgr3Pdrhb+i6NzujyJoTxqFbIw2HvsaYAS3olhHtdY3G/kTaJVG2UToMnrX3HJs9Hlv4gfXAl78wxsauM7wp14cqTQA/cDKFY2glCCX64qdwzgiFs68WctSwvoNLLTJ9yeJP2TseEYmNzof1RCdvlO+D5xjhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016036; c=relaxed/simple;
	bh=gud4DDZEH7pvBJ7uqWTBeJ2g6BPSPKBUBO/9q0FM9vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM/TZMSBRP5vglVsdyWutofgjbMmwI2uy6GrW2+VqSdvvUXLkb/q27jc8qC/n0xAMoKTuRzCOmzIIBAJPjJEhWzfW6q4mCyISwG7v2uF3yHFsjSxlWj0r2UiYArqn4J9AcgjjV2LpqApYjkCI+buy6cJVhcBcaRhXyUt142smDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixPbDtgO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixPbDtgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE771F0089A;
	Tue,  9 Jun 2026 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781016035;
	bh=wjngsSFP8J0pmDmN4E90fo6HpoYO1A3+FL7Hc2KUjfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ixPbDtgOqKQOUYm3b2EdO8M4yLMqpGa2uwmoexibNjA3loAH1L1bZUkTm5soysqmT
	 YBXr+hAEJHK42OF7rXddMV5ja6nUnS2hfRrI7ASvkDPOdzqIJRiXFvg9PbNslYv2N9
	 bI/RkO1/Mto2ip11VDwgvNTjHYmfv33jHr1q09JC7axfyd28527zlSb9UpEg53FfJD
	 pRK0FrSfebkVMXIX3JZxoKy/aWQzs8nwd+Be391JbAwimyrl3l85uudOOBKXnTk6tx
	 NCwtaMKNkHY72DzVXlO0ByQ1MMewX659QnIs9UOGwYY8yreqPT612028SWpHh5f8jV
	 qgnxBFxT9ykoQ==
Message-ID: <cecea384-7af9-4fc6-b315-84d4ac8fb31d@kernel.org>
Date: Tue, 9 Jun 2026 09:40:33 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] platform/x86/amd/pmc: Delay suspend for some
 Lenovo Laptops
Content-Language: en-US
To: Daniel Gibson <daniel@gibson.sh>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Sindre Henriksen <sindrehenriksen93@gmail.com>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>, stable@vger.kernel.org
References: <20260609105756.2813669-1-daniel@gibson.sh>
 <20260609105756.2813669-3-daniel@gibson.sh>
 <2fbb4d9d-7ad5-d4e7-b510-d7c75f399d97@linux.intel.com>
 <6b6ce9ce-5bda-4924-b2d2-933736cfad9c@gibson.sh>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <6b6ce9ce-5bda-4924-b2d2-933736cfad9c@gibson.sh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/9/26 07:07, Daniel Gibson wrote:
> On 09.06.26 13:46, Ilpo Järvinen wrote:
>> On Tue, 9 Jun 2026, Daniel Gibson wrote:
>>
>>> Some IdeaPad Slim 3 devices and similar with AMD CPUs have a
>>> nonfunctional keyboard and lid switch after s2idle.
>>>
>>> It helps to delay suspend by 2.5 seconds so the EC has some time
>>> to do whatever it needs to get done before suspend - unfortunately
>>> at least on my 16ABR8 waking it with a timer (wakealarm) still
>>> triggers the issue, but at least normal resume via keypress or
>>> lid works fine. On the 14ARP10 wakealarm has been reported to also
>>> work fine with this patch.
>>>
>>> This issue has been reported for many different devices, this patch
>>> has been tested with the Zen3-based IdeaPad Slim 3 16ABR8 (82XR)
>>> and the Zen3+-based IdeaPad Slim 3 14ARP10 (83K6) and IdeaPad Slim 3
>>> 15ARP10 (83MM).
>>>
>>> Reported-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221383
>>> Tested-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
>>> Suggested-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>>> Signed-off-by: Daniel Gibson <daniel@gibson.sh>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   drivers/platform/x86/amd/pmc/pmc-quirks.c | 39 +++++++++++++++++++++++
>>>   drivers/platform/x86/amd/pmc/pmc.c        | 24 +++++++++++++-
>>>   drivers/platform/x86/amd/pmc/pmc.h        |  1 +
>>>   3 files changed, 63 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
>>> index 24506e342943..74ddf1d8289a 100644
>>> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
>>> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
>>> @@ -18,6 +18,7 @@
>>>   struct quirk_entry {
>>>   	u32 s2idle_bug_mmio;
>>>   	bool spurious_8042;
>>> +	bool need_suspend_delay;
>>>   };
>>>   
>>>   static struct quirk_entry quirk_s2idle_bug = {
>>> @@ -33,6 +34,10 @@ static struct quirk_entry quirk_s2idle_spurious_8042 = {
>>>   	.spurious_8042 = true,
>>>   };
>>>   
>>> +static struct quirk_entry quirk_s2idle_need_suspend_delay = {
>>> +	.need_suspend_delay = true,
>>> +};
>>> +
>>>   static const struct dmi_system_id fwbug_list[] = {
>>>   	{
>>>   		.ident = "L14 Gen2 AMD",
>>> @@ -203,6 +208,35 @@ static const struct dmi_system_id fwbug_list[] = {
>>>   			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
>>>   		}
>>>   	},
>>> +	/* https://bugzilla.kernel.org/show_bug.cgi?id=221383 */
>>> +	{
>>> +		.ident = "Zen3-based IdeaPad Slim and similar",
>>> +		.driver_data = &quirk_s2idle_need_suspend_delay,
>>
>> Hi,
>>
>> One more question.
>>
>> Sashiko noted, that amd_pmc_quirks_init() can overwrite
>> disable_8042_wakeup from the AMD_CPU_ID_CZN check when .driver_data
>> provides quirks. Is it okay in this case to not have .spurious_8042?
>>
> 
> Good question.
> So far I haven't had complaints that sounded like they'd be related to
> this quirk not being active.
> 
> (The only report about things not working as expected on detected
> devices was something about "ACPI event storms" after resume:
> https://github.com/DanielGibson/amd_pmc-ideapad/issues/3 - but no one
> else with similar devices could reproduce that, so no idea what's going
> on there, and it doesn't sound like that IRQ1 issue)
> 
> I can test if explicitly enabling .spurious_8042 in
> quirk_s2idle_need_suspend_delay breaks anything on my device, if you
> think that enabling it by default makes more sense?

Famous last words - but we haven't had a need for spurious 8042 on 
recent hardware so I think this is unlikely to be a big problem.
