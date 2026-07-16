Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE743E09C
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223048; cv=none; b=B6Hin2lJJaaurBK/d97A5+yx194MPDS+/n3K6zwII9abT/PTiwtxtrUMSUGBZa2sEuxYybvCjLs90q6XaGcYYQbJzdJ1As5mvwQYhurf4RBVWid6wA8hUPxhLsC1Dqr8csasFPvEDSeOG727Zs9myI/YBlGixF+/LIv4JtJYAjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223048; c=relaxed/simple;
	bh=voFa2xNUGsehUNPrXUXNg5NODZ1yCBEHbrIFo4sGZeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lM6SnJutSOH0i6CfhHhXdhZ//WpnMEO9u2ToWv0CcDqH3yTz5vuTRrarajuB8QoJGCiD0YWluWLXck/JOXO+2M7gNGu265C6UWVrFqIzGfn/Sv1PhMKE7U+b8ju9aIzcZiTVNR54Ofc94L7Gx2UABW3ATOhpe42Bz/oQ+ZA3K8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLEFGbli; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLEFGbli"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-902fc790cd5so68264656d6.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223044; x=1784827844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCWV22I+W09c//Y2bdGU6hl+mnkh7Gm9VSdVidV0tfE=;
        b=NLEFGbli2u6FHqk2ldAslyZaJz/Y+K+MVzrwOkLxJ2lLPkpIAko08Hsm69fP2akHv6
         17WCzoobu+amOmM4qg8QnoQZcC97xREJ43Lr+nEur768DoksI+d0jhauxdCf5mGWs495
         mvIuiKYYJTNiqthqaT5L6AqZc3/nz9PsFF4/G74YfTE0AeJG8AhzVTS+d+7FPCE8r/e2
         1/OztZywCvlH76Lo7JLd5OTpqTN3e9o4Raynsta2BWUJLmgtbvVRvZMbWx5NYqbw7gA9
         w7Fq75ZS3zz6tPeOVqu+XQ46WbuGf2ewey0pg08wFf6+qq7OO+HRy8PMLyjK0VDSsHLq
         6ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223044; x=1784827844;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UCWV22I+W09c//Y2bdGU6hl+mnkh7Gm9VSdVidV0tfE=;
        b=PjFQ4cfYZafUGxzypgFz8aEoRO3RKaJmM2BsU1QDtAQr11P10opeoTo8cVDtDReB8b
         wJ3JnGklekP7NcY8I/FkPQ2VmAa6xIrezMXP3J4U3lHX46lH9cOSiLu1wPJj6e/tS7N/
         f7MxnPAaIXCrbCz/oNN4kXVKmksXUnqzJFe97KKXpzail/t4338K5Vx/rlwWdKXbeNrL
         +0xZqwsGa/IgVqDNL6o1K/mHASBRn1XHdYlW/h3oMF33tWFZ3V91UZxaa3LVXIPsjdw8
         w6gVKyFTEgKu5yOw1SjqrTWhKPpDdZD8gnnPwQiIvcmaWALi4oN9eXOzrg+6CNgxgwnu
         x6lQ==
X-Forwarded-Encrypted: i=1; AHgh+RpT65YpbTuxgQHXcwaF7UnYhNM2+E3/fbOkOnZSX1my+WGwDCf6sxZzMWEwjolDQSDT0TA6n88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5djVXkogN6+sOiNN1Z7nrEvpdOPhJMDyJVeERAM8q2D+L47s
	uV6EFMugiBcwWPeKND8i4zK61JiHy8tsf2g59qgb+CpGJPA8jF0foR+p
X-Gm-Gg: AfdE7cmExC3L+SVFDLiUnrVdJUcApG000FSdy+8NULTMdDkTGykpg3FhAc45xr4tEZV
	Ei68K/5sG3IBD7kTeAibzh6+bkzwWFy0d/6pRO8CPUwOA8dsfXIHeZWiYEaySTZbUFg14JgiPKg
	PyA/wY2N/mtFp2K7iA7+OMGVg+Hd7tWH9VHYxk1RmfCVImJdgFDKNPmvwoe44Kt09Sk6Cur4CfV
	kA6apOZwQSZ31AgjWfI4EWKkFGb9TXVQhhl0eabediJAR+WWOulY/F3EHcXB8EB2zGowFPiUMBu
	q3+JO7KxD8aGbeKVT0MOYmum42m+soqPhqbma4E7QF02Q/KYv2y4QxLUItNQoiBPIoVnhRhzaQ2
	cWlx7/JwRYFrMs72KV+J5gqEs5Iw7aul3FGH9UWBFI6b/w9Lng0F1Xq1Q0ykBQXHh+JEwb2HPTo
	wuPdkSqMku/8/drlSWTJTQgFNDfdMx
X-Received: by 2002:ad4:5d43:0:b0:8ef:db4:d85f with SMTP id 6a1803df08f44-90747cd4f16mr163706796d6.41.1784223044027;
        Thu, 16 Jul 2026 10:30:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90749b913absm85264156d6.10.2026.07.16.10.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 10:30:43 -0700 (PDT)
Message-ID: <4d165c10-f527-433b-9d67-3acddff6cfb1@gmail.com>
Date: Thu, 16 Jul 2026 10:30:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/518] 7.1.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260716133047.772246337@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260716133047.772246337@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 06:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.4 release.
> There are 518 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Jul 2026 13:30:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
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
