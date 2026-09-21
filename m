Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D714A093C;
	Mon, 21 Sep 2026 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011802; cv=none; b=S9qlOW0m6sO1+bPrhnCl0McKc+n8WxkoS9TAj8r4ulHQVIbsVHYXONEpR4I2SYjZ/jikh6bqZ+9IAyLXQ3+ArLFxqCdKoEBlIKrm4eZEiuIINjwmVb34/YUpHcuwXDY25osmp7rqjnAyW+x3NwK96IUgXHlKoZYckpy6F92zJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011802; c=relaxed/simple;
	bh=cRcTe6DfsUDj6e5eJEvDjRsWdjYmaaJw5Je6Yt729fk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sQhJ+uYIaL6Xu7e+pfLM/qXVF4m2IJzTXiUayFO/Rd4q84oCz0M2AaCpyfD0yDDfqtK9TgkuJt2sTwrHzBH78c18NSqrqt8T9h5Wj5/qhg77T3BgBGtwiZxvFSXeCwmuL7hM1KWnXawT/IRGj4bwg06p2sC5aNO2n7YoqP1LrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLYu5Dbc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLYu5Dbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7E21F000FF;
	Mon, 21 Sep 2026 17:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790011800;
	bh=o1hFskbOL1sYEXUMybVqmFZBZ3D1zde94z1P4+K/ntE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=kLYu5DbckN4rIK7EYgs4RHjWMHkkAxtw+Y0jEzo67oAqbpmjQ1KFMqAKZR0e78Q9p
	 C5/IqG5Y4IBtqQP3C/HILhCtnChB35vECGmjDqwcGHH32EwaM3PalD6kP9+KMSCkSR
	 JcrTnOs63c5wbKE3z+CIAHXpHKkY/VhOxube/aH/46ZX6WZYK/2RgPdiwf2GIXBTU9
	 o0Guf1gv+Su/R2cGUVW/cMZtSDallIgjQK0G+2lINBz+e1tsYxnd6YVwbTZpc3vLrT
	 7Zpgp2j+XDJzW65s5GqDTwV0BDsGPaRVNueVaM/rDhIHCj5b+3JViYrLeSOzcVUooQ
	 iDW989+FjFVlA==
Message-ID: <652e3b3b-0f56-4d01-8fd8-e4a9ddedabfe@kernel.org>
Date: Mon, 21 Sep 2026 12:29:57 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/hfi: fix platform device leak on init
 failure
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>, Perry Yuan
 <perry.yuan@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260921082609.244774-1-lgs201920130244@gmail.com>
 <ebdcd24a-dbca-4195-a9f1-ba224596b7d7@kernel.org>
In-Reply-To: <ebdcd24a-dbca-4195-a9f1-ba224596b7d7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/26 08:43, Mario Limonciello wrote:
> 
> 
> On 9/21/26 03:26, Guangshuo Li wrote:
>> amd_hfi_init() registers the HFI platform device before registering
>> the platform driver. If platform_driver_register() fails, the function
>> returns the error without unregistering the already registered platform
>> device.
>>
>> Since the failed init path does not run amd_hfi_exit(), the platform
>> device remains registered and its reference is never dropped, preventing
>> the associated platform object from being released.
>>
>> Unregister the platform device when platform driver registration fails
>> to properly unwind the successful device registration.
>>
>> The issue was identified by a static analysis tool I developed and
>> confirmed by manual review.
>>
>> Fixes: 5d902ee5609a ("platform/x86: hfi: Introduce AMD Hardware 
>> Feedback Interface Driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/platform/x86/amd/hfi/hfi.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/ 
>> x86/amd/hfi/hfi.c
>> index e0ebcb0c4acd..449aad914ad1 100644
>> --- a/drivers/platform/x86/amd/hfi/hfi.c
>> +++ b/drivers/platform/x86/amd/hfi/hfi.c
>> @@ -530,8 +530,10 @@ static int __init amd_hfi_init(void)
>>       }
>>       ret = platform_driver_register(&amd_hfi_driver);
>> -    if (ret)
>> +    if (ret) {
>>           pr_err("failed to register HFI driver\n");
>> +        platform_device_unregister(device);
>> +    }
>>       return ret;
>>   }

When I was reviewing some other bug reports I came to the realization 
this patch is unnecessary.  Instead we can just drop platform driver 
registration.

https://lore.kernel.org/platform-driver-x86/20260921170411.1149960-4-mario.limonciello@amd.com/
