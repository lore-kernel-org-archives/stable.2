Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD1517BCE;
	Mon, 21 Sep 2026 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028220; cv=none; b=IQ1k9aLi7wW2aHNJVjKLxp6qzPjFylhkYF632o101f4IYHJtORtMG8nXeGJTpZ329ZcO3lPbHqu5SDOTZJcLWRRm/IrbH5wdZzFaod/kTzuDyYqN2bT/apXUz4GWqXVVwyXsp+lZy9NcqI+3QNNFtOKtPgPfHT7YlKiyBuX30Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028220; c=relaxed/simple;
	bh=atZD9PYqUOfld+t9ZT0dYZjgsntJLtpo2bL+7HsEta8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GFDJ0D3mpQcgIT2Ao0MfagbDnyRMc6THr+h+lOup31D5/jvaGaFHsujyLke1CuD/hiPswIUZ1FYcqXnd70ljsm80Hj5hUU0+irw+Keqj0SK6WLqLY7YPkctHeKyenoOMkpOF0QtLovnZRRUCi/jHY1WjVpVIE6vC0YYfttxi80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2WKnIpl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2WKnIpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33C51F000FF;
	Mon, 21 Sep 2026 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790028218;
	bh=PxC2P1OHmJF7+liP5fu7bB0fbSApw0Vhthd3InucT+c=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=o2WKnIpl3LKnk0vO4Q8z175sDehrIaJGbVCRtob3l2v3J9bQt1PEMLHE4ETcC0Sf4
	 ZSRsOSN0wd87jHxN/CZGHHojH3TAQe0cX1YmlgSZ/AYRHFIPrA9BjvuLt1UKLsYIel
	 gqflpzVyA4DlS3r5DIy4dApDhmUc1+QJo6lFOwyLAVMpKtq+wUB4wz6tO9aYb3YSmk
	 gmki6TLjqRSUmJe3eknVdh28RuX3SigbmwH5OXxG3Dd2fV9sVQWb595Fo/YTUkaUTW
	 t7yBBcy2di98c4ck6JZaGfQsioRyZx3Sf7O+Jr6ZppLFV4pCkZiczCtlwy6xCbFnKh
	 TV/kdnFYRG79A==
Message-ID: <89bd2593-e0ef-4b9b-8c9b-833aff327a3e@kernel.org>
Date: Tue, 22 Sep 2026 00:03:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/hfi: fix platform device leak on init
 failure
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Hans de Goede <hansg@kernel.org>
References: <20260921082609.244774-1-lgs201920130244@gmail.com>
 <arFKFmkpldopUIMI@quoll>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <arFKFmkpldopUIMI@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/09/2026 17:15, krzk@kernel.org wrote:
> 
> On Mon, 21 Sep 2026 16:26:09 +0800, Guangshuo Li wrote:
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
>> Fixes: 5d902ee5609a ("platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>> ---
>>  drivers/platform/x86/amd/hfi/hfi.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
> 
> 
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
> 
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
> 
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.
> 
> Please read kernel documentation BEFORE posting more work. It will
> explain you how to identify subsystems, how to organize your work per
> subsystem, how to document usage of LLM and how what you should not
> do if this was posted in a good faith.


Apologies for spamming here, mistake on my side.

I guess the OpenClaw on the other side did not even notice...


Best regards,
Krzysztof
