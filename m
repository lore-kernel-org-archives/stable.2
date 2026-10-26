Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033998;
	b=hWu9oNr8VRrvbuB6W3+TUtUYUVPREv/9wjXHrHMQWAV9pwS5q9f5Z6KKn31RuIkB4rwn
	 SUf3BccPKeWHKgbfoulsd1pwqTbb8Y+xRKxfN5gf2IVVuTQUjUdErL/q9eFFCvTfi9g+O
	 w+mOVQPkw1DAmo9JmaijBImrQ+8qooIvl0b3cqgSDUXjOYdxpvXJOtcw6W0wdkL35EtES
	 /sW9JPaH71ksRqqi5Y1IDKARWpWLs8hZ4hM05fGRLqdr03mxWpLszwvhgaUdtC0wi+2y/
	 09qxb7grAhaO22ahMr8jI9wwtE4GRIdF06tdLOjqfQp+QzhnBkA1n9QTzcIQSUEoHmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tz9jpCHJuuihYoFsJHjUWPfDZzHDI+xFwdCkQ387VRI=;
	b=oupjmOjWrUOCjrSfMrkNqQfFVBw++VDfG5FCuh+EjqMmYjJ38VxLI3jlNtaqcb6fu0QS
	 ir4Tj634GhkD6EJEgmi/QrFZRt/lC0s6IthpVOG5LTqDPHadWn5HiUgHIMPxcQU/m7Nhs
	 NfWwqfrQeYtW/YTzKVwwOaln/DUL8rV7H6MxadZMKet9MqCno3HeCuFwHoGyPsZ7p6qZt
	 DzIrF9jyKZ2WlkVpp4Y9hIHkZ1qm+KJ8TldkvsXxBv5VSlghTu1JRNpGs4kJb+jnSCyaz
	 mhG/JSFlhQ8eTqwlcsUEY/lmTKXxZtJvr0D9hS8i1JIj9XcEOMRgrjPhz2WvBU5IVuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qafq3Lke;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1941606A31F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1941606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qafq3Lke
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso1137965a12.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793033997; x=1793638797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tz9jpCHJuuihYoFsJHjUWPfDZzHDI+xFwdCkQ387VRI=;
        b=qafq3LkeHnyOINw5rQ2/rqLBP154JO0BfwUIFdzu5xROQ2AcHWKQufHGzhn4ZmdL7N
         RjdIy1SFQtZbkION6WPUWq/U53tz0aRowVFSicvPvybpJxXi7jZTQqZwUdEsATmiVEF3
         +E0fjpT559dz2DS4dyFzzEf4WoYiX83WyVeRG62vb7pp19f4tIUUVoXGHmGhP7iRW49u
         YDfWxkhY5CDdcHlz6ErF8yWMJMI/61yBr3n/+Y7AhabO87SsSBvduKenAVUr4WJmzylk
         XwF3Zpd0TJeK7yA/AO3ac/6vIY02SPkiBqhZJlOLub6HvmAzIiY0Ydx9TiKh89Ee1oL6
         KZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033997; x=1793638797;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tz9jpCHJuuihYoFsJHjUWPfDZzHDI+xFwdCkQ387VRI=;
        b=Dp4ZFTlyDO3U7sIHtFkle/5idfGiK1tFw+ZMpzzAZscFJMwgnssoIbu9aDAtR79HYB
         e/PnulB6xJYL5BY9hTBrlCOhltb985/eldBtY6NdmWf3GZLfVHIhyJ5jKOTuKaFMVcbw
         TFoVoC40aUD3kMbKEavGk9u7Or4MXOTakkpKdjbyDjAVJFi9EkSShTg98NqnHNHEbMqQ
         ZJNf6PeFMzu2K76vEJCLLtdpFJvOIma7rQYxNzqeUVJBvesSwa31wuwvG7N7aBihb+0/
         aB4Db238vlNaEm1/3YyYZQOW2wQXF5JqR+Dahd+qf+r5VoRky0cyqgkNP8KvhtHzkWZ1
         PoMA==
X-Forwarded-Encrypted: i=1; AKwUvBxZucvaKVjc7OoFc5+ukPYH2gO2ZZRkLZp+e12jp2fpI2XBh7UAhTplUMxxGWtZSBus6MwPx3k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsJ6WjF5nut6k/6Nw8mlKm/JLACzbhFD2vMAbI6lczNVc45XpH
	fhkjdjS6y0LxZXDqIZGpRQ+w8zr2nhY2ncY8pinHsZ6xSHGeFXiTARcq
X-Gm-Gg: AYBFou0/dogsp+TmzutZvaBE1qhAPqCo++M8P3Ny/NmolFwa7eXcoO+96MZnryW7Q/g
	hn+1DpczNOXOiN62o1ZJrKXwGqHxLazASurCuVqi1XG8RlZ4QTDO4sy4oLhNCI33ga4w3VFjaPn
	Bxw4/e1yybAQpHDTBpZJYzlh0aVZEiVa21TStOFnOPNl3tb4yvgi1F/Krf84p8Lx5yV/mqFCRKJ
	VTjJC5S+aG8HVolK67bt6ByWZGpmFyx2Or1bwr9pc3nSEO60RSBwziEm7Ru7dUJ2Yyaalj0nrIq
	5tdRA2DpNq4RZpm48Hl/bbzZchWlclyVg0FL7jUFpz0ttLP15w8CTM+C2R7/m23etDgJ5TauxvQ
	xoIMSFQqC5g9k+GJkcUbLc/odeQja0Bd+JNwqglsfKC0B5QkORQi2KumKf/pD6J7BFVZjuFFgyI
	ph0Q91IkM9hmMaU9AgzGKMyD7E+/4/D+6Y6gI136BifbGSzdJy8SislDb3HZECkOYOt03ODd2fI
	Ck0FZGneBa4AKCKicGQ8XqS150G0JjmsEoC358l5A1Co2xBD/FKVTWwMtG26CprBlq/+PJT06tZ
	NcBETWs=
X-Received: by 2002:a17:90b:3ec2:b0:3a8:1a1a:7895 with SMTP id 98e67ed59e1d1-3adeae6d30bmr5210154a91.18.1793033996922;
        Mon, 26 Oct 2026 09:59:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4066aec8sm173335a91.15.2026.10.26.09.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 09:59:56 -0700 (PDT)
Message-ID: <17e72e8e-42ba-4d81-9249-e02ecb1ef695@gmail.com>
Date: Mon, 26 Oct 2026 09:59:54 -0700
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
Subject: Re: [PATCH 7.2 000/231] 7.2.13-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261025125805.309934791@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261025125805.309934791@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 05:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.13 release.
> There are 231 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 27 Oct 2026 12:57:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.13-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
