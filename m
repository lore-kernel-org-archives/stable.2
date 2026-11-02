Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632110;
	b=nK1gbHGNf98bYIZ/0D+Xouprxmh6K6rYM0jqajoaEvm+oCo51z/7lRZqitZuzzyHoJHK
	 nZJhV10kKjfWU5WU7itJwOC9JDLnKbOqoCU8jCY8TvU48hrplyJqgm8CkmvEU42KDPwMz
	 TEPLFfXjqOjqsmW9bt2RWedqyEGjjmFQPhz4zXfcs2Oe6ecml1t2gTaMzxHK4QtHKYM5o
	 RJ2OAKlMfCLbtTcQlAwEuZ+Z0WVlWcIvOnU//ToPf5jy84dfrnnRuzUl4Zu0mcVcHniee
	 pkvprCETFY9miKXrlBBSTX/4kDNJF/X1XdzkJc9BGGGQEqcMhXHhfzqI2vIoRLLuOyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632110;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=7Vjo7GooGGeFPFyAChgoItAoFMtiFUpjChD6wbXGdAg=;
	b=JJucxO+GH6YVJp2tsqRjEfQ3fQUx0S7ylwBMpmfiCNlVreYOnWQKWBdfAn84iL9LbPCd
	 Gf12TdzridcWkbmbYTOQ9OJX5TljLiH3R8FS6m3PekhneFF4b3ZkfFshkHtJ6aCyCXW2+
	 KkLO47I4gzDlNU1oXh6WP7OiNTk6rXAfdb34rYCPgKsbbIlfMnL6+T6mi+kT2Z5hORLuV
	 EjC4es8YWE51K91au109b71arOPflnUcl/icIOx9O2r+mdqLKLwEFjkhJKp9KdbT+mKI6
	 yXtr01oiuQyyTyngXIcMuvBDjpaqzDTKqJqcj+SBkEMLxZ0QtLKmw75Ltv83qoxMtsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCPmLVM0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C78606B1CD;
	Mon,  2 Nov 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCPmLVM0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DEB1F00A17;
	Mon,  2 Nov 2026 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632110;
	bh=7Vjo7GooGGeFPFyAChgoItAoFMtiFUpjChD6wbXGdAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dCPmLVM0kVwQHI/jSrtPgrnQS/2KHw+pWiLThc5bRcG0bWd6vLm3LIgIR0eTP9mhP
	 zcOjYI2ZBACsBE6KwZoJmIGY7NnnrReLl6uAQbt41cFu/KmLEYsxGYGkwwDfzxV+0D
	 3eF77I6yL32AwD9SkI63U0t2DHFCTIGPpTXcWqhQ64DHwYBj/Dxy/yOsGaIAXIizZ/
	 h+0h/2W04GWsA/HhqX/s1NWTMVzUr7mXf/asghCt41yhDTKFqh7hRaLaFHkE/GkaDF
	 wc+pA5PLvPiKO1PLddwzujwTrKb+UjDjxXPHFucr0GgjZHCePxWkOWFCw9ys58rQyF
	 KgUJDcyrQSNdA==
Message-ID: <d6e16fc8-b471-485b-a05c-a545adb0a1a2@kernel.org>
Date: Mon, 2 Nov 2026 09:08:26 -0600
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
Subject: Re: [PATCH] platform/x86/amd/pmc: Fix S2D message ID on Rembrandt
Content-Language: en-US
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc: Sanket Goswami <Sanket.Goswami@amd.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261102053503.102598-1-christian.aurichzm@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261102053503.102598-1-christian.aurichzm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/1/26 23:35, Christian Aurich Zanettini Martins wrote:
> Commit 382fe403dc31 ("platform/x86/amd/pmc: Add STB support for AMD
> Desktop variants") added S2D message ID 0x9B for Granite Ridge (family
> 1Ah, model 44h), but only checks the model. Rembrandt is family 19h,
> model 44h and goes through the same AMD_CPU_ID_YC case, so it sends 0x9B
> instead of 0xBE. The firmware then reports a telemetry size of 1 instead
> of 0x100000 and amd_stb_s2d_init() fails with -EIO.
> 
> amd_stb_update_args() already checks for Zen 5 before using the Granite
> Ridge registers. Do the same for the message ID.
> 
> Fixes: 382fe403dc31 ("platform/x86/amd/pmc: Add STB support for AMD Desktop variants")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
> ---
> 
> Notes:
>      Tested on a Lenovo IdeaPad Slim 3 15ARP10 (Ryzen 7 7735HS), with this
>      driver built out of tree for a 7.0 kernel. The size query returns 1 with
>      0x9B and 0x100000 with 0xBE. This laptop's firmware then reports S2D
>      address 0, so init still ends in -ENXIO here and I couldn't test an
>      actual STB dump.
>      
>      Based on v7.4-rc1. Found in my own boot logs.
> 
>   drivers/platform/x86/amd/pmc/mp1_stb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
> index 8a33e75b71c3..af9ecec532f0 100644
> --- a/drivers/platform/x86/amd/pmc/mp1_stb.c
> +++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
> @@ -266,7 +266,7 @@ static bool amd_is_stb_supported(struct amd_pmc_dev *dev)
>   	switch (dev->cpu_id) {
>   	case AMD_CPU_ID_YC:
>   	case AMD_CPU_ID_CB:
> -		if (boot_cpu_data.x86_model == 0x44)
> +		if (cpu_feature_enabled(X86_FEATURE_ZEN5) && boot_cpu_data.x86_model == 0x44)
>   			dev->stb_arg.s2d_msg_id = 0x9B;
>   		else
>   			dev->stb_arg.s2d_msg_id = 0xBE;

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
