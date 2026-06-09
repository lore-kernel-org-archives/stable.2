Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4243C05B
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017607; cv=none; b=UCz+EH8DBAz/3Pds9g2sq6FabuGq7uKak+fFb+AFtkMKHAF9fSZ5uO/9j0VxP+cv2U6R+VQsOC3uL5aH+Bn6LHev61CfP2S2BC3+UbmmRitcGkiQ6Qf/eYBN/1L6nXNDduoproc6NbpfRuFXujSwdX0nk48key0gEAVaSNHRlWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017607; c=relaxed/simple;
	bh=tUof00E/4eGeTJ0fxfQ3RqAHOYUmkJbxu5Db6L4zYvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cr/rg5/cojvN4CWtRiqZxxK5Vw0wWwfgvjE5ruQKs+k0nJgdV/m74TMuqO6xTRgLRUuy9fBjEsa5Epm7WVSVQCK3IZo0PhFkuaJ+lzWrxOAlHd3H9vh3X71ZfBHECbbNHL9/HlJOJtCg3eALIuuTKn4QWCHO/wZVnRCqgZoFZJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=cB9Aw314; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="cB9Aw314"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gZXLV5hZJzlLt;
	Tue,  9 Jun 2026 17:06:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1781017602;
	bh=TA4KPgpHQC1dVgM2FwpBUGpPM0kof2GvY/pJzKY1geg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cB9Aw314FORGNXzrbL88vt55C3tiDy/izofeRoGJ7kVXAERKYtrzWGZikiht+uUSX
	 egYB0oIj/fU+lIhrE1B5rEs2r1ZoXcptkZMaAmd+ZDwj3dWOpsAZd+/hDaV7+qRgIL
	 TfC6Dq1Ih0SHPKCzFVTwxnJFrY9If3LZvnfTePTc8uhgkmS1rrDfp4vggGj9yVOdAr
	 mHPjxkllO3DF0vIK76nyWk9UL2MNWtWn+KkwPN9rWojTfWlkmjpd+STX5a09sYofSw
	 81gXxm8z7rZ4jzvE8/OHYk+KS9iWSLdTtxARZaeGpEkQoGgiuqV4GtpaQIEUwkFgss
	 MyxIveZEM7zOQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gZXLT0QmdzB0L;
	Tue,  9 Jun 2026 17:06:40 +0200 (CEST)
Message-ID: <3b49ba16-d318-4905-bfe0-ebcc7ef374c5@gibson.sh>
Date: Tue, 9 Jun 2026 17:06:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] platform/x86/amd/pmc: Delay suspend for some
 Lenovo Laptops
To: Mario Limonciello <superm1@kernel.org>,
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
 <cecea384-7af9-4fc6-b315-84d4ac8fb31d@kernel.org>
Content-Language: de-DE, en-GB
From: Daniel Gibson <daniel@gibson.sh>
In-Reply-To: <cecea384-7af9-4fc6-b315-84d4ac8fb31d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

On 09.06.26 16:40, Mario Limonciello wrote:
> On 6/9/26 07:07, Daniel Gibson wrote:
>> On 09.06.26 13:46, Ilpo Järvinen wrote:
>>> On Tue, 9 Jun 2026, Daniel Gibson wrote:
>>>
>>>> Some IdeaPad Slim 3 devices and similar with AMD CPUs have a
>>>> nonfunctional keyboard and lid switch after s2idle.
>>>>
>>>> It helps to delay suspend by 2.5 seconds so the EC has some time
>>>> to do whatever it needs to get done before suspend - unfortunately
>>>> at least on my 16ABR8 waking it with a timer (wakealarm) still
>>>> triggers the issue, but at least normal resume via keypress or
>>>> lid works fine. On the 14ARP10 wakealarm has been reported to also
>>>> work fine with this patch.
>>>>
>>>> This issue has been reported for many different devices, this patch
>>>> has been tested with the Zen3-based IdeaPad Slim 3 16ABR8 (82XR)
>>>> and the Zen3+-based IdeaPad Slim 3 14ARP10 (83K6) and IdeaPad Slim 3
>>>> 15ARP10 (83MM).
>>>>
>>>> Reported-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221383
>>>> Tested-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
>>>> Suggested-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>>>> Signed-off-by: Daniel Gibson <daniel@gibson.sh>
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>>   drivers/platform/x86/amd/pmc/pmc-quirks.c | 39 +++++++++++++++++++
>>>> ++++
>>>>   drivers/platform/x86/amd/pmc/pmc.c        | 24 +++++++++++++-
>>>>   drivers/platform/x86/amd/pmc/pmc.h        |  1 +
>>>>   3 files changed, 63 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/
>>>> platform/x86/amd/pmc/pmc-quirks.c
>>>> index 24506e342943..74ddf1d8289a 100644
>>>> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
>>>> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
>>>> @@ -18,6 +18,7 @@
>>>>   struct quirk_entry {
>>>>       u32 s2idle_bug_mmio;
>>>>       bool spurious_8042;
>>>> +    bool need_suspend_delay;
>>>>   };
>>>>     static struct quirk_entry quirk_s2idle_bug = {
>>>> @@ -33,6 +34,10 @@ static struct quirk_entry
>>>> quirk_s2idle_spurious_8042 = {
>>>>       .spurious_8042 = true,
>>>>   };
>>>>   +static struct quirk_entry quirk_s2idle_need_suspend_delay = {
>>>> +    .need_suspend_delay = true,
>>>> +};
>>>> +
>>>>   static const struct dmi_system_id fwbug_list[] = {
>>>>       {
>>>>           .ident = "L14 Gen2 AMD",
>>>> @@ -203,6 +208,35 @@ static const struct dmi_system_id fwbug_list[] = {
>>>>               DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
>>>>           }
>>>>       },
>>>> +    /* https://bugzilla.kernel.org/show_bug.cgi?id=221383 */
>>>> +    {
>>>> +        .ident = "Zen3-based IdeaPad Slim and similar",
>>>> +        .driver_data = &quirk_s2idle_need_suspend_delay,
>>>
>>> Hi,
>>>
>>> One more question.
>>>
>>> Sashiko noted, that amd_pmc_quirks_init() can overwrite
>>> disable_8042_wakeup from the AMD_CPU_ID_CZN check when .driver_data
>>> provides quirks. Is it okay in this case to not have .spurious_8042?
>>>
>>
>> Good question.
>> So far I haven't had complaints that sounded like they'd be related to
>> this quirk not being active.
>>
>> (The only report about things not working as expected on detected
>> devices was something about "ACPI event storms" after resume:
>> https://github.com/DanielGibson/amd_pmc-ideapad/issues/3 - but no one
>> else with similar devices could reproduce that, so no idea what's going
>> on there, and it doesn't sound like that IRQ1 issue)
>>
>> I can test if explicitly enabling .spurious_8042 in
>> quirk_s2idle_need_suspend_delay breaks anything on my device, if you
>> think that enabling it by default makes more sense?
> 
> Famous last words - but we haven't had a need for spurious 8042 on
> recent hardware so I think this is unlikely to be a big problem.

FWIW enabling .spurious_8042 didn't break anything on my machine, but
didn't improve anything either - only visible difference is that when
resuming by pressing a key without that quirk both IRQ1 and IRQ7 are
reported as having triggered the resume, and with the quirk only IRQ7 is
reported. But it didn't seem like IRQ1 triggers a resume when it shouldn't.

OTOH I have a the latest BIOS (from this year), so it's likely fixed
there - maybe people with older BIOS versions still need the
.spurious_8042 quirk?

As these devices are relatively recent and still sold I hope that
everyone affected can get a new BIOS (which they should do either way).
