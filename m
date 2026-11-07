Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045520;
	b=jvJqh01Xd+Uz8C7SK/Cg8uSLSCXXt4+Ibs2sRRVqphT79sJJAvEp4267TNWWwJDhbG2A
	 +9bFKzV6bYZ8WoNEnWX5V2fGcdamCLxGGnJcbzG3adfGYewx5fcsSKRc07RP8DTXVguRi
	 aXQTxzQxgPUDMrbDMP1geEy9N1ZRza/Dcf75M+WSY7JAggjlz29G8Mibf/SL2HF4HWBC+
	 LlQBsDqR37WkdraMYC3WQ08g8BaUA2UGnmGbuiEeV6DYwn1SUSF3Slxy50WP/yIlNU7iX
	 aC9uqA1L4ncj1gvgR/eUSyoBrB6sN3oYchOqN1iDCahP5G5gwxiFxunNHg/aF/S/OSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045520;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=IgMSlsD7DyAJC88dH9PzbWGMxD8cM5My6CHNDmAT3YQ=;
	b=bVezuG0+9PGWYoklbsW292tR5Vt8pVLQx3ZHsMFc6K+/DvzEMiuXUk+7Satr3CXuCQMT
	 f/hid50jNnvKHxnqbx8INN9hPqTEbfDx1q4uJvNpaeEbZFMIt0oezMuXcDm6G9n4FWe8e
	 8XJQ3/4TUuDkq+sMSO87vHJDxYMWrRRy+6O8Q4T5MBcC0OQBcMHInNgrVbSWxM1+1ZwPg
	 gCeYn6EyXsImpFWaWqDywsP9X/eTuU0XF6VUb8Em26pWtad+s6rhHTGGuh36mEOQISnLo
	 QyCg7OP1iRZ+Uj/3VBoY24k2cZS96mcssrC2htPseJxjskSQcwU/HpDs2yvm2IJuBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdEiO3B7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE7606A32C;
	Sat,  7 Nov 2026 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdEiO3B7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD771F0089F;
	Sat,  7 Nov 2026 09:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045519;
	bh=IgMSlsD7DyAJC88dH9PzbWGMxD8cM5My6CHNDmAT3YQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AdEiO3B7L7OaprmRE07LXwWw7Gbx0ctG+hUaJhP2lkGsMq6V82O6bo4LaamLJU6Lh
	 /gnawExoGY8wTgjnvglrly/DJ/+bra4KJSniM00on4UWx/poIDTiS+g3nhyU9PwFV2
	 DJcuAImOmfFelmoVCkxAwljLJNaaxs4nhbTzNrx9oWXVtuxLZsbqSh9ad7raF8Kad6
	 gstdEfEWFW6Cqgq3TQPITWkpiLT2wvSorU2VL3uuL71EEotIx8LmO4mw5y+Xr3mW2y
	 gPsCmEEsHnzlKMH+2IBMQZpfXiR++gbBNf3Uo+VSOmS9JpAueBh+hDg8/EN/6OkQG5
	 q6vjOMo6AD+hQ==
Message-ID: <b1e6aa27-4a2b-43d2-91c1-2addb528dcab@kernel.org>
Date: Sat, 7 Nov 2026 10:58:35 +0100
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
Subject: Re: [PATCH] soc: microchip: mpfs: Fix flash leak in
 mpfs_sys_controller_probe()
To: Wentao Liang <vulab@iscas.ac.cn>, Conor Dooley <conor@kernel.org>
Cc: conor.dooley@microchip.com, daire.mcnamara@microchip.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 stable@vger.kernel.org
References: <20260917153550.2160672-1-vulab@iscas.ac.cn>
 <20261002-garnish-president-6e8abfdacf4c@spud>
 <20261008-47741881fb032091ea3d7f0c@squawk>
 <179393668487.2060453.14381920142402581273@iscas.ac.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <179393668487.2060453.14381920142402581273@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2026 04:44, Wentao Liang wrote:
> Hi Krzysztof, Conor,
> 
> Thank you both for the detailed review.
> 
> Sorry for the late reply, and for the mess it caused.
> 
> This is a v2 of the earlier patch, but I sent it without the v2 prefix,
> without a changelog, and without referring back to Conor's review from
> 8 October:
> 
>   https://lore.kernel.org/all/20261008-47741881fb032091ea3d7f0c@squawk/
> 
> You are also right that the patches were sent in bulk across unrelated
> subsystems, without being grouped into patchsets, without running checkpatch
> on them, and without documenting what was and was not tested. I am sorry for
> the extra work this has caused you.
> 
> In particular, thank you for pointing me to the kernel documentation on
> subsystem identification, patchset organization and testing, and for the
> guidance on how this work should be submitted. This is an important lesson
> for me, and from now on I will go through all the remaining feedback
> manually, one by one, and reply in a timely manner.
> 
> Going forward, I will also not send patches in large batches, so that I do
> not exceed my own capacity to respond.

If it sends patches like a bot, if it ignored feeedback like a bot 100
times and then finally if it responds like a bot, it is probably a bot.

https://en.wikipedia.org/wiki/Duck_test

Best regards,
Krzysztof
