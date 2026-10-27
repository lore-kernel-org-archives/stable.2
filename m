Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119383;
	b=5av7BXuAOgDK+pl5P7AZIkqMwe+ah4TRhwsdPhzgQViasf6hstQErrLBgsJ0VJbOcgZ7
	 O/q5qR6zPC9zANLO9G8wrYXXp6+svRIoemgL8TFgYBEvDg4wC1KyxBzgtyBgq6SlqzpsV
	 /Lc10v5eevEL4/8xNWnVuKF15GJYtDAX7WB6jBR0gzXDQwpz7pEbx9En5Tzv6Bf6flqbh
	 CPlPk/Ex5EhX0pE/bxvUcGwO4X97BIXyEN493zfT1y69lT3YukN2rzxSxj7/91lDjp9dd
	 69tulUgwinuaYJuHMu0zTkEfiJpvL4RIZZ851OGlhXqVRADEGSrZ8pMmlJBJasi9hOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119383;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=E1wXN/PUqUObJwX0JLlBqoqe7zckeMgtQBlkKAPsC4U=;
	b=ZEZhK+s2BBf8LxrDncdieKM46WFDlkQLZ1OuG9JGHzpJ/tmPZwwhptfKwziF9mAGEXB8
	 qc58Rxj4Wl/i4oA5Of8DGxMax0fACrmhNYluIHL+wzgiNFyucHkFb9bc9/B6ax8cqH31b
	 lFOZ+TeyvupRDNjTMidbCrT/BEqE7YqzMz3w5BR/BqUrvkV4GKaHt0O4wY5hmLZEdgXd9
	 w/KjOPR2z6FPQ6ORakWc66IymNBVBAN84tJm9j9o85nBvtd6lHhJaV2GViDW9c8wq/yCn
	 bURD7siNe4oMs5PcDK2pDjEJY7TO31dhAMCSPCyy3rJ2t8uz9LQc66Sdr8R2NOzq3TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P7/w1DUf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C752606A31D;
	Tue, 27 Oct 2026 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7/w1DUf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C931F01825;
	Tue, 27 Oct 2026 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793119382;
	bh=E1wXN/PUqUObJwX0JLlBqoqe7zckeMgtQBlkKAPsC4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P7/w1DUfoTRy34mWn1naIkcYYpGGZf47p5kFeCWFa/1Y4OT2v+jsQ/TU2gpN0/gKQ
	 ZLtpo/IZmUNFYbuDu2KHboM+lN+Lg/bo+Ni0AVu2JMZPYtIoSTdlGgFkuw+8QkL0Wz
	 BHHnWkf5x7W19zu/KZcI6Cl+2GrWf3GhqZEshbW6D/KZggHp5Gc7cTywv9fTDqMAvC
	 /KpeZDY4z2FlJb8ppioZr3XCI6rf5P3BZCzmqpgSoEql4ZVTvh6RxESLDLI9/pTtji
	 I8/Mf0B4AeIUE2HCwsPou/tluQRnbEaqImPlij51YhWMa0+81sHkGWxAYsqCVq/ahy
	 Bj9UWBENUVZWg==
Message-ID: <57142d18-fc5c-4b9f-97f0-27116d4bb154@kernel.org>
Date: Tue, 27 Oct 2026 17:42:58 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: hi655x-pmic: fix IRQ action memory leak on removal
To: Lee Jones <lee@kernel.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
 John Stultz <john.stultz@linaro.org>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261027024609.117371-1-lgs201920130244@gmail.com>
 <c04f2ba8-fc83-4118-a26a-76ea8cbee518@kernel.org>
 <20261027162324.GI2195460@google.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261027162324.GI2195460@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2026 17:23, Lee Jones wrote:
> On Tue, 27 Oct 2026, Krzysztof Kozlowski wrote:
> 
>> On 27/10/2026 03:46, Guangshuo Li wrote:
>>> hi655x_pmic_remove() currently removes the regmap IRQ chip before
>>> removing the MFD child devices. regmap_del_irq_chip() disposes the
>>> child IRQ mappings and removes their IRQ descriptors.
>>>
>>> The hi65xx-powerkey child registers interrupt handlers using
>>> devm_request_any_context_irq(). During child device removal, the
>>> device-managed cleanup calls free_irq(), but the corresponding IRQ
>>> descriptors are no longer available. As a result, the allocated
>>> struct irqaction objects referenced by irq_desc->action are not
>>> freed, causing a memory leak.
>>>
>>> Remove the MFD child devices first, allowing their device-managed
>>> IRQ handlers to be released while the IRQ mappings are still valid.
>>> Then remove the regmap IRQ chip and its IRQ domain.
>>>
>>> This issue was found by our static analysis tool under development.
>>
>> More of postings by bot ignoring any feedback.
> 
> What did I miss?
> 
> This person seems to be answering to my feedback:
> 
> https://lore.kernel.org/r/CANUHTR9B84LoCjOtS5N5qGO0KXSXUbZkrKZ3_GFTwXmVoPQ0SA@mail.gmail.com

To mine not really. This all is again spread patch-per-patch, exactly
like I asked to fix last time, more than once.

Best regards,
Krzysztof
