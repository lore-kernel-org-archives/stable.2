Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC43C108E;
	Wed, 10 Jun 2026 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103102; cv=none; b=ItETbLv0RrSKk0dr8zBPTGoMQPDX4vQEI7mj+kmTXN9Qqiac+DA1HoB7e9w+idfdi2Dx9GuGGXPZOAnOqyojzIWEZsoc508LAx0R7cH21WUXDTTf3pPx/uQar7P8KFzDddnDinNW6yN22N8dagz5IRNukZhXC2PxxPg6XOMqD98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103102; c=relaxed/simple;
	bh=HFh5kB1cQc0Ev/DqfGJyvwVLOFq7WiYA51Ix5yg0qf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CITEbfpQjmUQMfYTWMtri9mjBFyUEgsrAPO1PVK3fMVzhdzHRdCKn3kbey6M9Bm0N97BNelAEosKKF5HH6TBzOUkbwREomMfZBjMVeFnKd3fbrSP5uOHQoR3D3XD2X+ZNLibwqlEd7TNusBl1WXY2b7NCslYthsnTeiPeQB5xvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmLqCG1M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmLqCG1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE88C1F0089A;
	Wed, 10 Jun 2026 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781103101;
	bh=Yc90Dom9wY8Yal5buGVpykllWk+BE5S3JL6sU5FxvL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fmLqCG1MnAUD2g5wh8x4qq7SNXWnR2p7DWKWyq8Rjg1l3t5woLEvMJrKXex0/WcTI
	 3Gi7HI4TdAv1OONNuUtOhmPS/OcdkSaef+LzXlZpRo1BH21GGyg+nzdrjw60yJ8xkz
	 F/eEVERLinsVT1W+6Oe9yiCYO0JGfg35ACpJ/faDGMG9hhLwMUDqBSD4ZTJdG85MNO
	 M9PIEimV+c5dGWNLvYOnkpzWOtEGdSQPmXlX10s65w/+Eb6M1q6vkorMtoqdYJ0e4R
	 TQXkEzG0UhpS+iQkiQcOndLf473vPQqY0Fon8g2gmUCKf9d181lBhNanfhPH/PTfb9
	 p/r8iQ5lxhXBg==
Message-ID: <485b82b0-1091-462b-80c9-73a94ac00076@kernel.org>
Date: Wed, 10 Jun 2026 09:51:39 -0500
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
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Daniel Gibson <daniel@gibson.sh>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Sindre Henriksen <sindrehenriksen93@gmail.com>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>, stable@vger.kernel.org
References: <20260609105756.2813669-1-daniel@gibson.sh>
 <20260609105756.2813669-3-daniel@gibson.sh>
 <2fbb4d9d-7ad5-d4e7-b510-d7c75f399d97@linux.intel.com>
 <6b6ce9ce-5bda-4924-b2d2-933736cfad9c@gibson.sh>
 <cecea384-7af9-4fc6-b315-84d4ac8fb31d@kernel.org>
 <3b49ba16-d318-4905-bfe0-ebcc7ef374c5@gibson.sh>
 <5b684d9c-2477-488d-a89b-323ca3e51207@gibson.sh>
 <91af1da1-e2d0-40c1-87b0-452b48f4a2b6@kernel.org>
 <ded3840d-fa7d-d6dd-a265-daca1e9df7a0@linux.intel.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <ded3840d-fa7d-d6dd-a265-daca1e9df7a0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/26 03:21, Ilpo Järvinen wrote:
> On Tue, 9 Jun 2026, Mario Limonciello wrote:
>> On 6/9/26 10:36, Daniel Gibson wrote:
>>> On 09.06.26 17:06, Daniel Gibson wrote:
>>>> On 09.06.26 16:40, Mario Limonciello wrote:
>>>>> On 6/9/26 07:07, Daniel Gibson wrote:
>>>>>> On 09.06.26 13:46, Ilpo Järvinen wrote:
>>>>>>> On Tue, 9 Jun 2026, Daniel Gibson wrote:
>>>>>>>>         },
>>>>>>>> +    /* https://bugzilla.kernel.org/show_bug.cgi?id=221383 */
>>>>>>>> +    {
>>>>>>>> +        .ident = "Zen3-based IdeaPad Slim and similar",
>>>>>>>> +        .driver_data = &quirk_s2idle_need_suspend_delay,
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> One more question.
>>>>>>>
>>>>>>> Sashiko noted, that amd_pmc_quirks_init() can overwrite
>>>>>>> disable_8042_wakeup from the AMD_CPU_ID_CZN check when .driver_data
>>>>>>> provides quirks. Is it okay in this case to not have .spurious_8042?
>>>>>>>
>>>>>>
>>>>>> Good question.
>>>>>> So far I haven't had complaints that sounded like they'd be related to
>>>>>> this quirk not being active.
>>>>>>
>>>>>> (The only report about things not working as expected on detected
>>>>>> devices was something about "ACPI event storms" after resume:
>>>>>> https://github.com/DanielGibson/amd_pmc-ideapad/issues/3 - but no one
>>>>>> else with similar devices could reproduce that, so no idea what's
>>>>>> going
>>>>>> on there, and it doesn't sound like that IRQ1 issue)
>>>>>>
>>>>>> I can test if explicitly enabling .spurious_8042 in
>>>>>> quirk_s2idle_need_suspend_delay breaks anything on my device, if you
>>>>>> think that enabling it by default makes more sense?
>>>>>
>>>>> Famous last words - but we haven't had a need for spurious 8042 on
>>>>> recent hardware so I think this is unlikely to be a big problem.
>>>>
>>>> FWIW enabling .spurious_8042 didn't break anything on my machine, but
>>>> didn't improve anything either - only visible difference is that when
>>>> resuming by pressing a key without that quirk both IRQ1 and IRQ7 are
>>>> reported as having triggered the resume, and with the quirk only IRQ7 is
>>>> reported. But it didn't seem like IRQ1 triggers a resume when it
>>>> shouldn't.
>>>>
>>>> OTOH I have a the latest BIOS (from this year), so it's likely fixed
>>>> there - maybe people with older BIOS versions still need the
>>>> .spurious_8042 quirk?
>>>>
>>>> As these devices are relatively recent and still sold I hope that
>>>> everyone affected can get a new BIOS (which they should do either way).
>>>
>>> Anyway, overall I'd say that the patches can be merged as they are - the
>>> affected devices are known to have serious (-ly annoying) suspend
>>> issues, so it's unlikely that a currently matched devices has working
>>> suspend that breaks with them, so things at least shouldn't get any
>>> worse for their users?
>>>
>>> The patches have gotten some testing already on different devices (from
>>> my out-of-tree patched amd_pmc module on Github) and so far it looks
>>> like the spurious_8042 quirk isn't needed.
>>> If reports of needing both quirks turn up after all, that can still be
>>> easily added in a few lines of code (maybe even just one).
>>>
>>> Cheers,
>>> Daniel
>>
>> Even with all that testing; it's only on hardware with problems.
>> We don't want to have issues exposed by these patches for people that didn't
>> need the patches.
>>
>> So my 2c:
>> * It's "too risky" to pick up for 7.1 final
> 
> Definitely it won't be happening.
> 
> Also, Linus effectively only allows regression fixes during -rc phase
> anymore (he stated his policy change around -rc5 timeframe). I therefore
> moved even some of queued new HW support patches from the pdx86 fixes
> branch into for-next.
> 
>> * It's a "bit late" in the cycle for 7.2-rc1 (usually new content stops being
>> added around rc6).
> 
> I usually only stop accepting large series around that time, with some
> exceptions. (We've one such exception ATM because I was a week away and
> couldn't process patches, it would feel unfair to penalize other devs
> because of that so for the series which have been around for awhile, I
> still try to process them during this week, this one included).
> 
>> * This isn't "risky enough" to wait until 7.3 (basically after 7.2-rc1 merge
>> window is done)
>>
>> But this has been on the list for a while now, so I would say this makes sense
>> to put in for 7.2-rc1 and we should all make sure we test well once the RCs
>> are posted.
> 
> My plan is to take this into for-next during this cycle.
> 
> We can always take a timeout and revert it during -rc phase if problems
> appear because of it (and even after 7.2 release, if situation requires
> it).

Sounds good to me, thanks.

