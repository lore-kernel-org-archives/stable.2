Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287081;
	b=Uyg23Tw33jFcS6E8zznIMMs+HIv9KoVxh+HJkG5L0kRImNoDxzsRkOrsXLvhpYekdhj5
	 6j3LtBAc6yqAqy8OUbZvGz8tlvJBvLSSzZIG7H+ub8ZpGVFD+eZbiHWJkJV6PLH58coZA
	 zvpDX2Bsw+cVee/XsGv8viGAgV0RVoYIT9a2PwhuNRazJWoBOOqQKpSbzpAnAdC2SV8ci
	 1uWVpSXVe0AbDAVDrsq1H1oYXQ/NtLztscpAzRdc8FjEJz+LMglRXTNazveviZJ/oc+D5
	 +ca+F+oqe3Q/hEejAaLmIOnM4E9DaXXkIo4KZg7LrnYa1sN6+BP14YPYy1oBC1BSycg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WhrGqebO51xfUsjiZH9anbqm9PSjMbH6Lkt6vVEX+10=;
	b=b8orJe0aM+F3bi54CQDhlPyVY+zhMJwgkgnPdSmCNMzRxWzfsuo4e4gAM3hGqh2z3f1Z
	 ZlFgxfZ6hylnNLsxaPtDP7vJ54lLUhyeqTkYeN/q0OYhg3I1foIx6PTMdjxJI7VrNjKND
	 b9e/C5DNS8FmbvaqkqsPpagB5jzCjuaj/vdLLm6NrZA/ozgAZH5913H7P5JyyfnF6O6KY
	 gTXjsXlh7iGDOyEmscOdGki2pPx7ntoP47iE4GTWEkRhCAtoan50pBqsmOo62L1pfrhC1
	 IzmqIJx+IeU7W8rz0rhNcOmFy3IZM3KCQnZ4+8Th877BzVmiRW8RypNnMI1IgTjjW7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=ZTGx4TPO;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32445606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32445606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=ZTGx4TPO
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-70059e4dab6so1478992eaf.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793287079; x=1793891879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhrGqebO51xfUsjiZH9anbqm9PSjMbH6Lkt6vVEX+10=;
        b=ZTGx4TPOuWLuSzFHhiQNuv4QSd3AN8jhqJ7w0iDeaFz0SkdqzU4pIw5IMSVSl1KbSX
         CuXmOh+nB623wfFmpWdgnlLljr8VPYeILyyooc31JLxStNHi1hXSjrRRf4tWEPquxq+h
         L2sTN5GD/GyQYrgKJl5/FhEHdVuFJ8HPgYwYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793287079; x=1793891879;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WhrGqebO51xfUsjiZH9anbqm9PSjMbH6Lkt6vVEX+10=;
        b=wFGKSwJHdtI/KVYwMsnVURUbcOttAmCBV5CV8bltlHogEu0eH4OB0zTc4HGBcX5i0T
         xHVWvkoWgWnCRoOZSyYsomPdnPal8Jw/KBxUy0ugDsB0W++Uhqe7qAPlCIBaCYzygUz7
         p0Jp96mHLpuZkMuspubek3n3b6h/J0CFs+RpM2ZFC+b4x+gPmsQ2J7YbDKfa20C3aB7g
         9i/sGLFgdmb6r72K+0WLwTHkNdU2XfmQ3oJKqU63p2GYLd6K1680fjNV/zNWOY4wCHWh
         6VsmqwY3FHKRLwvvK2WfY0u5DiSk3EJtoKXUnuaG3GMdH44elc8zCpE8d4f/oMEEYuob
         pyVA==
X-Forwarded-Encrypted: i=1; AKwUvByzKPfWEW/FfIKcJWb//CXgikCBxBaKELUliPdlqUyp2cAWfJmwse2DUynXMScOw0d4Gxnz1MI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJou/g4q302krQ3j1foNYdb18saKiLnXHOuQob8HchXWqFrtq0T
	LQZAyp5KVkpH7eRL2fQMNay3p146jcu7iJEty+gXWApF167CEO9mlC3yfNQxGR12HdE=
X-Gm-Gg: AYBFou2KEtxivtZGlBoAY0w+AM/vwQvee8sNWaX78ZDP+nljRhFlHreheOmj0S3CQRz
	6xmwM4nMuanQtYZPbaYVX2YFsfVhkl+Ua6cXwzA0G1PzOuDsDKX/AuEBYFXBXcazBX6Id6lrltJ
	UjmO/6maXB52XZd82Mp93lJrAOfGTONT5JY1bORylljzTEOmUk//VrDk/n9LXF95TDsnX6PjZfU
	VS+hq9he/3MYCzeih1gCeDdMbt4RFlilUtZObBPYSTDIxfDAC5zeHTvKrHiIo/drR3BoZSd/q5x
	4lIlBZSXKM5JD447cr9XPX0iQUDO2IeMsLoopVpCJo+0Y1Ryg2Do5SiPyAYyu0134tPuQA1w/ks
	x9teGaqMCOZ1N2YgXY/h1HR8jXce4VzI2o3N7DF4N/5Yc1vyZRbdSlz2aV/hl/bHGeUt0JqIfXr
	/jOl32XP3nzwI3LPd2rK5E4SEP8bvcZB5ZDueK6wkoW960Xz0aFGdkkLvcGpyCrUL4eSkNIAKns
	y2CmBl+lgGq6h4x238deI3HmFaNsonO62+14j9wHGMNIswAWRv5SRBTBqDEgWR48br2xic5nAEc
	GoX4o5GP0isORIUD3Cv1bMcqGPbdh/bVrqR+XslV
X-Received: by 2002:a05:6820:1343:b0:6c9:80d9:5f0 with SMTP id 006d021491bc7-713f195f778mr3311997eaf.49.1793287079139;
        Thu, 29 Oct 2026 08:17:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d33fdaad7sm43385a34.17.2026.10.29.08.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:17:57 -0700 (PDT)
Message-ID: <d61a42b6-b92f-485f-abc8-0808fb395a87@linuxfoundation.org>
Date: Thu, 29 Oct 2026 09:17:52 -0600
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
Subject: Re: [PATCH 7.3 00/38] 7.3.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261028165940.394092994@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261028165940.394092994@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 10:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.1 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
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
