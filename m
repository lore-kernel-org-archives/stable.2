Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103497;
	b=BFCNxomgFcSidoajpBlJYthKfkK5KZpeIzY9pKqzoJgC5/IQ0l2t59nUiS319kK+ocFx
	 EdNazUEWAtll8Ry5gRYUqCcpG7fB6ojvc2D7X3JuBpQoSz5R3ACtqoRrGenSYefU8ydpN
	 T0uGiF3H6s4wjukD5v6dVZqTs+4F15EeTalXZKdrJcpE2ixvJgw+99j4XMsQlI5cMAmVH
	 RohvmaQMl5oXyeKmseidh5nW7pQTfNpwWargDHNUeomyWevym5XJnrVo1UVHfKJy3HGeC
	 hSU5P0lFD2xK6TlA8ojwHD/ZfIzn3FCieX7cFD8YFBMzr9p3vBi2jaA7LieEpHKXfvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pwFAcpg5sRyeKkdxr9R3kiTvutc3HKeMb0lAkM/rhbk=;
	b=BWPAVDov5LdDvJ0QmJXwEWvXZHKmm7XLGXYQkWDMCc4M4j2urOn/sACevsD6tfqOOVw8
	 MlSVLtahjEO4kezS705BxiqY++KrhKFHnAyAsifHJTmrznCleiwplLhimwutNU93CCB23
	 r2N19Ci5QIJXUsUWOzQwXDuFNAED/w3U/LqmAKEF773zvZy8fKgD1idiamDwC9O6rKjr7
	 8G42OVSX9N2dix0Ommpxmy0DasjqDz/nOeXtL/VCkGrpPBJh8GjXwZ/M7gIBPP4q0Pl2+
	 Qs25BDRaTT38T1OwL+2AscHbkxNnhQ/qFzuZzii0QUgnjNccf3ZAg646HjdMMxrRZSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Dobx2qgR;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B7606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 206B7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Dobx2qgR
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-862aca1ed4dso1004126a34.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795103496; x=1795708296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pwFAcpg5sRyeKkdxr9R3kiTvutc3HKeMb0lAkM/rhbk=;
        b=Dobx2qgRzUoXCH0+k4Qr8WbacApIKNsmoM+BT0OFnGm+XFWlgslaJzdH3lcZJI+GbD
         HSfmuGNW5AprH5y9OKX47jspcvAlggOpbLdnq572KJcrlAep6JedkzAZdNJiX4hso8Sc
         Qa9hAS9NW/jFMHcFwaAai6gm4wApHto4Yp7MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103496; x=1795708296;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pwFAcpg5sRyeKkdxr9R3kiTvutc3HKeMb0lAkM/rhbk=;
        b=IYlEQ9mnd2X8O2PKG8BbC9UpiytCZ4f6UjWKwAdNr/GYAMvU6YYYTmIH2ELj3u6UpI
         /P7xAu3w9leOtMtP1rcCqOaUsKTZc/iGlLlFXC54zSjPd5nBax8n8dtppqc9h2N8VWoU
         8naHYZFvAp9tVuQe96ihwbDNxLxbAff5OgH4Kg7rnG3tDdpXFa1rKv/4G4mdhC8SXKfw
         NEc94YH0j1W3gz4aS5Pu83KXq4JCRkLB5u7DuGQJYikiSwXLplMhlyGOu08DuAIzszAe
         sSS1iLghv9ygp2GrIoNycJjWdPkbvR+ktEyEUjgzcp2YT1xi9zYNkOjvzSBfrZnifl4W
         Ln2w==
X-Forwarded-Encrypted: i=1; AL+hErGUolBH2FZPqIliG59gJP4isdBrkG1GktHmj+mNLFifD2oeW9AqlYzzNUTy2+0zJirAEPvSkJA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+26k2L7VHcDCfMbzgfdqWLEbdCa2QkgxPm84Fr3mkNeOfJvcxg
	T2qZZGm5+6lV8HyT10YOIGHZZ49k4ybAh/s0JFnm0Hoo/uE9oXsnQw0nkMW2y4GUN1o=
X-Gm-Gg: AYBFou20laya63VL+ynq7BUhJlegu0gdFZMEZMgXSJHO+otzooBLkTS+CrXmyPMb1wi
	zuIOEDPNk9rQe0s/eR4TCaMOII3nqPEp6FcJc55i5VPvqd2acl4DCIDYurKVODBXlJyl0SmED4W
	k9RvoR7M1tYviUI4DdqMvA6tw7K0TGiCA+8jhyRK7jDT1YuwF5WIQioHZrhcAmJsIXfM1xBJSBX
	Vnz3Iua+vf0ip1DDjeKuk1nx/nGY6+WyY46mzBV5fujP8Ymo5NXr3NL9qxSOmpc3fR7KWCzm5Ql
	m2bdmXGKH7QfmNwjOdhu2RQAtJdsqDucT3hq5iPR1fiDbtzn/F1+cdyHiwaXiGIh+F2pB5D4Scv
	daxAa6s2nXQ9meQMveTpmcTbJxypOyR1ZW7+PJgN17Gcl/YcF63xFw7SlqQFmTpngLL8g1nExmt
	SfvXRTHOT2e+lELjXEOOrO0GzmS/2UlJTqwAni4DLhjcfC3MQ05PBYCmyYOPBdJbCSKiDMAl4i3
	KdfQAv3kulQHezsm4ZCUGgPJb33+LJaycvgTeQhLe/HM5SRcod0By90ZvEDg+Wxkg8G0lSHgJZJ
	mT2NAo0jEQpD7qCsLpqXadt+CmVaD2JWwZ7TOQ==
X-Received: by 2002:a05:6830:348e:b0:81e:abb6:749f with SMTP id 46e09a7af769-86315490d2emr351905a34.8.1795103496017;
        Thu, 19 Nov 2026 07:51:36 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01d492dsm4792444a34.6.2026.11.19.07.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:51:35 -0800 (PST)
Message-ID: <aaa60c66-1cf8-4cff-9ba2-1d490fbd6673@linuxfoundation.org>
Date: Thu, 19 Nov 2026 08:51:31 -0700
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
Subject: Re: [PATCH 5.15 0000/2214] 5.15.226-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261118150009.797899913@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261118150009.797899913@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 07:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.226 release.
> There are 2214 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.226-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
