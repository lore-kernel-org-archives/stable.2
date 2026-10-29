Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287291;
	b=IWSKszI8l5Y2/wKys4t6qEl/8AmRBTFp+G8nT6Pfy/E5mJtRVeuQf0+sJygqrA+yq97a
	 dp9BexMC5kcVn0do+NezJZu8tl9BKbnPi4Bf5gCndhTeCGBv0q6RxaeLVTqg/gTmtZ9vx
	 zWCKqD/JG36i2bArTzJ3RPgnSu1ClzWWB43IyZxuzj5qaGUXL4tKGReHsDzl68i7q6PMm
	 en9HNLZQj5Ruq9f5BZjuFZkqL2/jqRua/jfxGsw/x3HB7tX5Oo0Fvp0aUCQqJ6XdRls+w
	 Rw6zF8ARxpk4SZGDcQI86NHgJjzRh7BISFkMT4b4EuUulRfE8XkXZgl3NzDuJ1DR9+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6BGV7yfySv9YIO2Ud9WZxlpBcZd34hv06GQf4K+p8/M=;
	b=ziUbBqa7DFAC8gJC/FhITwjv9TcGPEKuk6gck1rXRXGd3pi/Aqda53FT8nyDoi+6/GqY
	 RG/PwKjpYGvT8B+U2QtcG0y87I9cCvrClfikhxbayi7XoivM4rclQBt0DV7FA0YOfmL/S
	 ROLdlQCCnLDsEjzopVB0SbQZSBqJ/WlZUuPLo65EZLqEIO70FHEkheyifKx3/L0ydPnaZ
	 4xTl8RfLpGTjM4Jp+QoyrpWEPIRa9wuEg5Rz9YDJSJoIvYrQFe/G0ZnDtV0KsGGRlguAc
	 TKt+ELdYlLu/4Rf8y0pgYnHVRtrEgpn/wTvdOmKUC5BQtqruat9t+gZy8rhlVPk7KZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Sd2Ig+jR;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7AB606A322
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D7AB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Sd2Ig+jR
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-49e1251674cso970419fac.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793287289; x=1793892089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6BGV7yfySv9YIO2Ud9WZxlpBcZd34hv06GQf4K+p8/M=;
        b=Sd2Ig+jRlj0gwJiZf9tIz9kq5GBJN19m4AKJzvz4b/KgC676Pp+Xvo0fFYCgbjGpMD
         q3vd/j+3VBCDQsqhMAgMQKVIE+jIg65CcmQKQHadG9hO7c3gx9p9ciSeeZOGKEnxyBGy
         +XRggzEQQncfkYoRVVm5p9UwPN1ZJeiHz/Bw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793287289; x=1793892089;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6BGV7yfySv9YIO2Ud9WZxlpBcZd34hv06GQf4K+p8/M=;
        b=k1Za4N1e7ZvRvc6k5HO/wAbGtHLRjNeH7ZJhgE+g8bOby6lsfDfQEO527eSmjHtEyP
         ILgDMSAsCgVk0n3Jft4iz1uXJmotbpe/9Xh41ho8SCs3O+Rlp/25jwjpJJUbwb0GlRxc
         7UFy6vcQkjANKv3jad/fUm9Y15MPrHAoUTUjrboH25IQeFGZWQVgvwvGmpL9Q68aUC5u
         XhiwScELl7MvmmEAxrQovLLq9P3kzbHozU4GcI3Dq6W6t5Qah5277xuifUqTsjfl/HTY
         IZZfU2qNcJt2qQr5MKDoXvYdZn6w/TipjbHbkzO2kT4UQlSiYDGMHgbMCPlRmCoMUiIu
         +hfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxR49qBJTD2c6Vvlc7XvaI/QBSdjtjtser4jrcN6ok9tRTHF5jSxyQpE6fAoaB74wjiRA1zwi8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPhN4v8wGSrtm/dqqY17xVC1ldpo8SUg9LUtoZEpmn1+bc92+A
	vqFhSggBFIezw+cnU65BHhQSoj8rzF/O6OQpDmVcA+zgxW9S3n1YJqWLAgHFSsl58U0=
X-Gm-Gg: AYBFou0ZggcIRuJH+Ut+GkDS9U6CpGzKpRIXtYbgxi1UWe2nW6D6Pmi/xaUREoObcfs
	J1O9liUemJjbjjVCz0BK8os53gfH7BFZnoDwkpD98H1hW0ZI6YYLaW37gzfGgVuCvahiXOtcHLk
	/i+65z3e7f+aX3RwtRdvUnZ3A7ScAn0Iy+Mq2DBPdvmw+NZuEOSZRL8xw+Ad2SmvQWS/L88mnfg
	ypIiaAbFbB+u6ztjhF/kiKo25iwyFgOcJarcIQ0KuYdtwFWuT9fwQWZUi/PsWVTX+6eK+5ACLMr
	sywjr2abdp9JclQTYr8fiNvuDzIGSmlTglByuSPUcViIj9UhCmfiqvRqrVPY7mF4u2MVF1iRgsC
	OX619ET/eKk37WWLlHNuofZcPLM4E66J1sEaEeUYga9CiMZWJM1Ced0ivpH/VinNaKeNXoiZInp
	OrFTLB4Chb6JSgnaZlT54/F3r7JvT+DAjuHLx3XNeRv6gi4KrXsCAiLUb2Qi7z9txwqYbZkhTQW
	nvoB9u07hLcCHaVA6PuXh+wBjhJME0aIk/9Avh2BhbDCvnaUzeur9PF3Afox67fNhmFVn5BgHd5
	F4qGXi4YVMomtIuhHk6+T/AgETbHKM5S2mCVVCM=
X-Received: by 2002:a05:6870:314:b0:47d:b8a7:40f5 with SMTP id 586e51a60fabf-4a8bb9f0b69mr3976866fac.22.1793287285561;
        Thu, 29 Oct 2026 08:21:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a901ff3779sm1006fac.4.2026.10.29.08.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:21:24 -0700 (PDT)
Message-ID: <111e33a2-72a8-43a9-8a10-a065339c3ca0@linuxfoundation.org>
Date: Thu, 29 Oct 2026 09:21:21 -0600
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
Subject: Re: [PATCH 6.18 000/109] 6.18.60-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261028165942.357251485@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261028165942.357251485@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 10:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.60 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.60-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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
