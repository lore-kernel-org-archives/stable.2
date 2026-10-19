Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792453960;
	b=I7Ka/bzJ+QZ3FfjJ7Uo/NjDRw4E2EF0o3/eoiJ+AGHdhHWSRKRY3+j7vRbTjhchUHJW3
	 QO/Dn86+W0lfnKJ9N+YFwmuRDtr0TuuQUZSLl3ZMGRaVdrpBdnU+6HH8nUIsD+WIP73Re
	 M8Zb5Ij53FbjjbDSTVnXvI9H+hJpJboazjPA6V5cKNc0XeZAOsOJ3pP/jZXsYjF8X6jrp
	 LpWPUeqDe25/rxo40kICuv2vtxI1VWIRmCznZ9q4P15/o0c+l/eUpNGOsq1sRmG4A1tpQ
	 Ptha1W2yOHMAGUQ5wKqTJFMD0sv2cueD/qDgjZ3HbDRIRzb+lj1kvGr4b40Kv9CtcSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ttyZRwyHx05poioOuaGhTlTLSeN4ZZB8Cywga9DS7rE=;
	b=vUbGVzLRaKHTs5rhgw1cMzqJ9EiF2lxqqKXhiDnd9jeDATS29D2h8NWoMVRIL3ABweW1
	 FSByKsmm0mH85bU8FcyAy1+Huc7xw1EHDYXOPuP3wq/k0jhNnR2Z71q2v7V1siWQAr/Ij
	 r99cunwvanwOVvNCJC+B4uRAxHUv/VhCIukMa9NoT72l6r8EWrNFZKSA+9pbtG0gTaUAs
	 sse+XkXgHyAkiPCG+Vya4G/9xUPyFQfSqzR8/CICD65pDWiQaqFVADAkgnbgxbDaU2iRj
	 U7MYCsyBmsKrUw+tLAE4xAFSFuK0onNEWTZFn99yTW/LahTV6VvrY08eIWJSRpOjKGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=E0GhOSPE;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79650606A31A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 23:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79650606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=E0GhOSPE
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7fccba9c675so266165a34.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 16:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792453958; x=1793058758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ttyZRwyHx05poioOuaGhTlTLSeN4ZZB8Cywga9DS7rE=;
        b=E0GhOSPEw4CVufvXJcUm/MzvnPHsf+6Nn4h31TKm9XkHR/q3Cyn9Ljd0MFY942ksY6
         YhGNWwanrbgMDFbBIoaSaPlqnifprzm02MqMPZmKrNEUB4OMzej8YztcDy2kkxIAcqC/
         nrF0/QYQiIqOWDjxwYi77cAdBEKFNXF81KDEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792453958; x=1793058758;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ttyZRwyHx05poioOuaGhTlTLSeN4ZZB8Cywga9DS7rE=;
        b=i1Fub9bM5nuu4KDNtTalmgPp7LzbkCfS90RIiD0Wx8iQCRDTOkLrsyL6KvMVIYJ5AI
         Fp2UOW31Qjp7jzypoJlAqwTYXNmBPRbPcrgKgzh2Agzx0zE1dWNpjhNN+X4sMK2JTGq2
         cShchFaXusxf1tLoSnU0ea8V/Ya+vmL2qNuupzbn3GFqu47NUzIHHpeE7zGKAQx5Ly4P
         TxdU9FjnP1K11com/35l6jLIaJWm1bskRv54CEd4PyNU2BmOZrD2YMeJTBzrEiApDwMq
         lwjMrIAqpKdlGYy4oUPCYFes3oX5THh0+0NgThrDqGeHlluM4ryfYeXsf9IsU7sUAw+5
         bECw==
X-Forwarded-Encrypted: i=1; AKwUvBwA/JpkiTJHRoDJGEj2VYUJxsNDP8yhCJPdh7v/LyAL1Mb7H9iPurTkB80eSJVN3Hcq0hKSWB4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdUwHfe4YQAzftiLVHloPb9BlLi076bSk4dZSkJbGSdDM6WMMv
	0QncCEZ5rJpq8ldx++aVok2Bt+FGv3DfykSvE7cCnzkWmTnysk8JlOjJK8rDh1Pj1DQ=
X-Gm-Gg: AYBFou3zXIiJrwZCdg26fy56VZP4tPnjpykgOnlZsqZ/l4Z5KyjIh1EjoK4HuPAMwQl
	tzqXhwbOC8IF2eFQ6XZEyLM6jMhHV2UTbC3rRxrTnLHjtFaapLQf9TuSajfE4C4I8flQk8klpBq
	ZdYe/+uKQ7OU76kswQNHzl5M16f8E+a2TkRn+miGSQn3cog/UNl+gH6sCp1JEkuS6qbMCM1Hz64
	RJcV8OjFWbvCif+AH55rw66d3aW/bzsvJ9C2HS9xMyM8S9CYEwwGgNM619O5vlsQTzALj8GIo33
	assXLElpAvqektSE7OFPlqkwGtFY6YruV9s/3eOuJFraTmDLyEDSBL+neEoo+g1ejmWlSTh6TTb
	DeaujaXduRbaVxEonCNLTllM/LntHcFSErLR5DaWH9g1Sp/OVFPpvDpEIQRQoFb6dCPP+QTFY6w
	tes1r8PEpTqFRFFnGPQ1MbWlPPuBr0CGNnWaIOsITF0b3GUiL8UY095DX9rRGgdw8RJgVv3o4Cg
	2HnXMJl
X-Received: by 2002:a05:6808:f0a:b0:4dd:f8bb:e1bd with SMTP id 5614622812f47-54d90fa2165mr420470b6e.13.1792453958309;
        Mon, 19 Oct 2026 16:52:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388c1654e9sm7801946b6e.8.2026.10.19.16.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 16:52:37 -0700 (PDT)
Message-ID: <0357c306-e1ab-4a66-91cb-2002c1f23f79@linuxfoundation.org>
Date: Mon, 19 Oct 2026 17:52:32 -0600
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
Subject: Re: [PATCH 6.6 0000/1674] 6.6.160-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261017160431.119607952@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261017160431.119607952@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/26 09:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.160 release.
> There are 1674 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 19 Oct 2026 16:02:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.160-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
