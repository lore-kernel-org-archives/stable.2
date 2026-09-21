Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A14489FC0;
	Mon, 21 Sep 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998216; cv=none; b=fEbPbKYSU0849hlHaL1I+ewzdfVD3/VBEEYoED6fCCuMYJ+V2tsVglALWn8VFIi1IOJTzokGFwKrwSHE4dfwlgn+5z/Kmc6+bFo3mVQQh0Mm8g+e/uY1NiFigxgyKqQ9hWibt3uXOQmZ4qztffU4WYqpjxMSVHGBJfCrkXAjiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998216; c=relaxed/simple;
	bh=z6GXpVUOIolbv6op5mUTLouphlPpgs+Daf5RUJl/7Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRktQC7kNo3EcDHU+w+seHIXP0DzIbPWd0K6kvMSXySj0MzMwOPBRNjZPVOXxkMscG6BWtFtuL/5i/3wLlZTbXmrrMnjyIGlH1JTwO6VTlX2oB3yd4Vzqy/c1N3XDvHPCdbyTyufbe/PefoGoI3UYOGD75KRYCknowt7Tr5pLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofXNvX/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofXNvX/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91BE1F000FF;
	Mon, 21 Sep 2026 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998215;
	bh=OPMCj1O9GfQ79/EIaX3D3WpPzFtAZfDF8PGCRQy9UUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ofXNvX/JK+qywD6hx7nOICFrThBZGiRyFK7rNxsuXeik+RkXTY2s4+RaLRuIOixH8
	 agzKLey2VFfZKVRLGOejjFSuPCBJyiIVpFjdnpTdx9EQ9sF0iYgntKvdxxlzeEFbJY
	 o7bMA2yTxRnKPscZObENvK5ibwnTyqz3RNZ/IWVZhoDwSvIBxxXR+q7/vdcqMpgOh1
	 0AwZikH6gGn8nMJRanzqejxb8PiFc3+qHKqKv/I8Znd3l5Vf/T9rdQwesrRDnKcppq
	 MKrwzmjso3w3tUVPYsxajLbgNsMFSkb14Svy/kkiQ+qDBfdHHkW6UmqmR9e4u2JzML
	 gXm7xXCM+Dtxg==
Message-ID: <ebdcd24a-dbca-4195-a9f1-ba224596b7d7@kernel.org>
Date: Mon, 21 Sep 2026 08:43:32 -0500
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
To: Guangshuo Li <lgs201920130244@gmail.com>, Perry Yuan
 <perry.yuan@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260921082609.244774-1-lgs201920130244@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260921082609.244774-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/26 03:26, Guangshuo Li wrote:
> amd_hfi_init() registers the HFI platform device before registering
> the platform driver. If platform_driver_register() fails, the function
> returns the error without unregistering the already registered platform
> device.
> 
> Since the failed init path does not run amd_hfi_exit(), the platform
> device remains registered and its reference is never dropped, preventing
> the associated platform object from being released.
> 
> Unregister the platform device when platform driver registration fails
> to properly unwind the successful device registration.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: 5d902ee5609a ("platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/platform/x86/amd/hfi/hfi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index e0ebcb0c4acd..449aad914ad1 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -530,8 +530,10 @@ static int __init amd_hfi_init(void)
>   	}
>   
>   	ret = platform_driver_register(&amd_hfi_driver);
> -	if (ret)
> +	if (ret) {
>   		pr_err("failed to register HFI driver\n");
> +		platform_device_unregister(device);
> +	}
>   
>   	return ret;
>   }
