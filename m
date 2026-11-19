Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103073;
	b=pbx8u8R50Cyo+EdwRziOTrA//svtW3gLGyEldTYTFL0c3xUuGewM6WBjQksryd1tyTDD
	 JW87XBrxOhBcmAjWxApmDuH/I7CiTKIpNHDlEtSV4Yv/8FErUNrhm2dzI/QvDbomM6o4L
	 MFV5mhUFSA+bfRMzpG2eA0s+bwdpj/AM9SHar9WBnt9TOVHUUjZPEjjcuBOcNB+dFN93E
	 1bO3xQPNH0WUCcEtAbWE3MlaXGzcW6Qnn7H4XHSxNnIx4ev50U7WJTUtnkIgd7xT0xfQj
	 s4M9XT325DZmG+pPJqgfN5M/yhymqGDQwG0+UvM/2vGD8AsPEaX7lVdWy79ZllwafGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8zz110iQMhXJ1p3ftg+9uhn6MYhCBFktVfT0q9rAKSU=;
	b=sFMik4Nkk2gjCLRF7OATfoSP1aN8ZI6tN3Mi1uJjOYMhqPuZBz4S5jMHLxqM9eklxnR/
	 rtwNRqmGTL5ep3y3yTLEOU+7Nx2KWd2kwlr2B2czpmreUz587OoTmSuBL3K7nTwdF1Qa/
	 GHYyTHhAJSzvTC7oNJvJ8UiSV1tyZ/cGQVJEr57bMq1bVZNOWIHZtVHWzhG3FjhlN+XGS
	 VbEWgMhgoFLwcYY9Pu5zf6eorvtNqqFnelw3YaMil2o1hMVQclyUnLfjbunNL+fDYQpWa
	 hoc6y3zoZwYQkq/WEeSEBPdgvXg2MEKynjhAarTXj+u87BdBJ/LHB5nO3CWGawVnWsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b="ZziUpL/f";
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5257606A32F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5257606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=ZziUpL/f
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-71b0d330acfso768600eaf.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795103072; x=1795707872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zz110iQMhXJ1p3ftg+9uhn6MYhCBFktVfT0q9rAKSU=;
        b=ZziUpL/fkvYzYVKzWdoT6ZitQMrIeuxLlz91Ydw9nkpOjAnw8PsULeLhO4RUIk28ak
         YtmISQsJxLR+g8/kMYpQyCsyKAJKdDWjHcSmjgyrhZKwpiur5SUbFd6OP3t31+O51pCo
         fqBWtGKz2zY6f/XFBHkMsf5b+F+Xkgsoz3sG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103072; x=1795707872;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8zz110iQMhXJ1p3ftg+9uhn6MYhCBFktVfT0q9rAKSU=;
        b=fBjL3s12DZnI/XKKQHNvKNjc40X47061gqePs5ZWID6M/m4a2LtiseQSRBdlz/QkpB
         ZKCTeF7BbQwebsA7A2PST/UY8ZPIkWEEtrssGP7xhRS+DTbPLhReIw6xtaxVHhvmhMOX
         JojyTZAFDt9v2ib4MOdNzvwiCuwfwSvij9MQm4HGP2+fgyFNZNX5r0wdAr7BS0Wd6t/3
         ov+q/j8SObcdH1OdM7y2cObofTbXsn65/PKxwIgeFyDIKJVeM/PCLNNlCEBhHll21VNd
         qcNOJkz+ij1XqvM5KP6BSOCH+gIFaMV7FMOay47A2IrWizbD3x9B02q1XYGjSuK67zaV
         oDxA==
X-Forwarded-Encrypted: i=1; AL+hErEjLt7UGaVTWRa8hkGUmGLutXZaiSsWPmTcioY9N9zEyfo9A/HvJDBcNS/Tv8uKQ9Q1JqWoQJE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+L8k4MrDFblmiP7cQXpipllMM6XvjwAN8HqPQpN7xr01rkNB0Q
	APJOygkG2KLUGh5PRHqvdW754fSCunsjFI2SM/cBerPfojthwZsvQfX3qQLJtJNnI1E=
X-Gm-Gg: AYBFou2WE+orseU6gKGORV75kVLEDqlIVytP2clK57AOFwi58WXOhEzJZHJhvWTyNe6
	Z03UuobwxDiYX9a1aXEanZ0Xm0cvn0kOfsGz1Tc/PrrXkh+mcxKVUNXQ5a2Xpuj5CpUsCfjQDU6
	U9EeGw+m7xwIQdtcJyrXVg3XGrpOAqzRpfPI8XugLKV2jlkn++RX/uiEOqP27GftopK2HuX3X0X
	HS7XN1Gn99XNSBSwDBrbcU8iuErIl1gDIF3JNmWuaaMzV6Pqb1NEUW1cMmbQq1mrd6g/9AQxwOZ
	JEgU6+brEk4QwLndRGL0TaOtl2vU85liz52rkDL0z2+gB/rQhvuDBvgnDaDfGILuEa3fBnsZy/8
	uftwFJnj1WP/AmigaOts2j9+40OI6J63Hytuwi5OUB7m13nApHl1eSrkLI3oTcUHovibmri7cn4
	CkVqTYL7q6YheeVrJCokI7zNnKOALrJ+i2eT1BVRKBhXF9wpra7SnDG8KnVP0ipdGNRALjS1Di6
	O0r91x2d/Fbz41OFpkldKgfSWzEFXi3rZSOYrj4wRIbIE0WAxB/gpkKGxpWeZys9nm0spgwucz0
	LIff7eJbRjs6DtqRHTbWsSUFvhRYeU8qktV+R9U=
X-Received: by 2002:a05:6820:55d0:20b0:71a:f98b:3be7 with SMTP id 006d021491bc7-71b325f7287mr642104eaf.26.1795103071796;
        Thu, 19 Nov 2026 07:44:31 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380b6f82sm182937eaf.10.2026.11.19.07.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:44:31 -0800 (PST)
Message-ID: <7d2bb21c-f8a1-45c4-91ac-55c77112a8ee@linuxfoundation.org>
Date: Thu, 19 Nov 2026 08:44:27 -0700
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
Subject: Re: [PATCH 6.12 0000/1756] 6.12.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261118150007.957976754@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261118150007.957976754@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 07:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.119 release.
> There are 1756 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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
