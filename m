Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71892E040E
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019410; cv=none; b=YGGN1G2HxDKEapqo+JoMJfPayECYeIl+3PZCqozm5LANY6Yc6t9qOv1/wfIJQ+jeo3s5Jel/7vlCoCPdAQChH5w4kjQX6BfAuV0I+7CNqjcN3tXoZBnj+VHbC6FbhujVL9UROrfvP4iba4ch08S2/q4EaFnndSajj+SXvF9irls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019410; c=relaxed/simple;
	bh=U6odCp490eP+FKoFRdSEMQKJYQePm9OGnlqNZ8HV0aE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dzhsH6R40IRnvZI9KwuSz5iHoXjbddOKID+8oscUNnd0Njy+FzQfhRBdWZw3pSplacl+DXwlSSy0g1Re6PKwequyjeBdfsOkvX/1eZMjlsmammf6AD0Z6eZ4xqjZ4pwcOrNaOjwQQx7CQKPk1xO928SYHYEZJ9Dv3zBD2kQdPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=gaPPoV64; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="gaPPoV64"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gZY1B1YpNz3KS;
	Tue,  9 Jun 2026 17:36:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1781019406;
	bh=Tfpacp/lMFRT4kQRNe1XZ8GeAjoEakUIKMpMmUTLXdQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=gaPPoV64+W19jbHDlDYaXpOsP8S1e+rmPgIgEew3oo6s1jhGcvbBoUtgyIKC8u595
	 8xaSczlJqVMeA9CeaOSqvpzGHqRDZF1CZOQS7Z+mFJl24fRuJYxpboOf23Tv7kiGqx
	 DswAXpqwIA4iZl0K1/y13YZBpTg/b9mio6nrWy96eFgTrwPNKLtxZgw1czjrqGvVDd
	 RroY5jm276nhxK14XS64o+om8u7WeowKpHk9Ny9yEJ7xZ+VOjI2ROhpPEUYgaRovAm
	 9UOyNZ+PVkK3HQpSjytID4fep/+Y2KW7TBPDGjN6JvNc4EobfvLEN3KUHXHL2B6gGf
	 3xD4bAkJmPm0A==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gZY183brTzqLC;
	Tue,  9 Jun 2026 17:36:44 +0200 (CEST)
Message-ID: <5b684d9c-2477-488d-a89b-323ca3e51207@gibson.sh>
Date: Tue, 9 Jun 2026 17:36:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] platform/x86/amd/pmc: Delay suspend for some
 Lenovo Laptops
From: Daniel Gibson <daniel@gibson.sh>
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
 <3b49ba16-d318-4905-bfe0-ebcc7ef374c5@gibson.sh>
Content-Language: de-DE, en-GB
In-Reply-To: <3b49ba16-d318-4905-bfe0-ebcc7ef374c5@gibson.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

On 09.06.26 17:06, Daniel Gibson wrote:
> On 09.06.26 16:40, Mario Limonciello wrote:
>> On 6/9/26 07:07, Daniel Gibson wrote:
>>> On 09.06.26 13:46, Ilpo Järvinen wrote:
>>>> On Tue, 9 Jun 2026, Daniel Gibson wrote:
>>>>>       },
>>>>> +    /* https://bugzilla.kernel.org/show_bug.cgi?id=221383 */
>>>>> +    {
>>>>> +        .ident = "Zen3-based IdeaPad Slim and similar",
>>>>> +        .driver_data = &quirk_s2idle_need_suspend_delay,
>>>>
>>>> Hi,
>>>>
>>>> One more question.
>>>>
>>>> Sashiko noted, that amd_pmc_quirks_init() can overwrite
>>>> disable_8042_wakeup from the AMD_CPU_ID_CZN check when .driver_data
>>>> provides quirks. Is it okay in this case to not have .spurious_8042?
>>>>
>>>
>>> Good question.
>>> So far I haven't had complaints that sounded like they'd be related to
>>> this quirk not being active.
>>>
>>> (The only report about things not working as expected on detected
>>> devices was something about "ACPI event storms" after resume:
>>> https://github.com/DanielGibson/amd_pmc-ideapad/issues/3 - but no one
>>> else with similar devices could reproduce that, so no idea what's going
>>> on there, and it doesn't sound like that IRQ1 issue)
>>>
>>> I can test if explicitly enabling .spurious_8042 in
>>> quirk_s2idle_need_suspend_delay breaks anything on my device, if you
>>> think that enabling it by default makes more sense?
>>
>> Famous last words - but we haven't had a need for spurious 8042 on
>> recent hardware so I think this is unlikely to be a big problem.
> 
> FWIW enabling .spurious_8042 didn't break anything on my machine, but
> didn't improve anything either - only visible difference is that when
> resuming by pressing a key without that quirk both IRQ1 and IRQ7 are
> reported as having triggered the resume, and with the quirk only IRQ7 is
> reported. But it didn't seem like IRQ1 triggers a resume when it shouldn't.
> 
> OTOH I have a the latest BIOS (from this year), so it's likely fixed
> there - maybe people with older BIOS versions still need the
> .spurious_8042 quirk?
> 
> As these devices are relatively recent and still sold I hope that
> everyone affected can get a new BIOS (which they should do either way).

Anyway, overall I'd say that the patches can be merged as they are - the
affected devices are known to have serious (-ly annoying) suspend
issues, so it's unlikely that a currently matched devices has working
suspend that breaks with them, so things at least shouldn't get any
worse for their users?

The patches have gotten some testing already on different devices (from
my out-of-tree patched amd_pmc module on Github) and so far it looks
like the spurious_8042 quirk isn't needed.
If reports of needing both quirks turn up after all, that can still be
easily added in a few lines of code (maybe even just one).

Cheers,
Daniel
