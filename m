Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246A45D935
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992624; cv=none; b=I0YYF9aF6LOpPcEIzNMqcZ7GYk8x6fQ7NVjEP3loWSL3DuQM2MeAmtO8H6lowFsNTB8bfKlRwZcVffg+q17C2BIN9jU69W9IV6mevFzM9OSWrjPABN2XCUuyQPntvhZE9NPLtoOCkLxY9mdn96hxNC8UbS8C9AvqPhnPV7quqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992624; c=relaxed/simple;
	bh=jyZXnNk97yXcYJ3VFSCOyUv/maueSIIrc4Yrg9UCJBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeVNYdbGk+DDNjdZDSNuw5krmSlnboBmdqhqlUYJWcCrh8JojHfQ1hixTNAKi+MD9xyp2vc7xR0NzN5a57HymWqD3j8e12lWF9WCZQwcyrTuYeUOquUamlvw0PR6RbvFg7AcJ0/eRBbBMZu4PKqBSNSTBe4jvgYsBPIel2R+Jdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SbZNK0tG; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SbZNK0tG"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0c89e34so572172a34.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788992620; x=1789597420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ij5mdruxx0QOfzgtgcdh5/VG5w9myB0k3AU4Kebg3MY=;
        b=SbZNK0tGOr0mkEihQpUVT551NacfPI2gDSI8ecrr4zsgIfOBwhTUhsMBGdceq7dRVu
         y3SDnmipxj5OTZyf5hNH/WTVxETgAhdOnaDi/ojJCv4vSF6XpRHVFuJIOsUlBYRu094Z
         /XJFjuTksuwGMM/HHsrqvlN1Q4bZljZaNpeqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992620; x=1789597420;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ij5mdruxx0QOfzgtgcdh5/VG5w9myB0k3AU4Kebg3MY=;
        b=JbQQMk8gnq44MRL4t824d/oa8vvxe89BJFGLrpi7vDX1nUgiITiX/iB/19pzKm98dS
         CGaklBUzoMuomFl/ytxtaHeq9BedlFQsQdaHojuUmez3RiCwmUUnJS5GchqDNl2Tx0kS
         38nXg69AE5X7buYE1nLEUBcT+tytGIos6qGOdrJFd6U8ksg0ylWaLwDUjQxFDbICM4me
         NPF8AwemMBDgOY+hWGJ0HPUNCHL8q01qg4xc2aMxj4Zm/XS0FeabZMJ4aVejQZbf+IFl
         /3Z7Ki8bvADVDGCUw55ZZCVVobHApXHWwmaxFoK0CfCybrryEBY6YegiuioAX1RTAZ/R
         osCQ==
X-Forwarded-Encrypted: i=1; AKwUvByqB7o/GoClQH5LvyfPkBBi9SglwIXvqnOSHT47U5cs5bj8NLI7N/Na2BA/IXgdnbsa0xajZOU=@vger.kernel.org
X-Gm-Message-State: AFuF++mVoUOxbCJ5I1Tt1GLm6pv7Mcca1WzeStvNLC/nXnFsMbI4Zdqm
	NXE0f7a0izZtRGXykhbOWp3RisjIuWbw+N3CKGknXxPT3mJcBx26isOXlzxJ62AePTI=
X-Gm-Gg: AYBFou3h1YNGurP36BAUrlJ6QO8A9BJZzQv2uez6fKx6/wu0+Un+Is9Mfg7ngGOvS8A
	4CdceQcIo+4NNEyNdNLYqtrx9kSiBb/3dCe2JQ3h+E4jiG+4Jr6ppVAF9msXtm8y7EU2wkEZfBZ
	gBYFzSL8RiyoOXJc1kp0AbaRrn2NTNVfXcDeG7W29ephvCc/gP3oYV+Lxu12aFq0f6g08CB7wm6
	f2O7iaqk7x+icKWvZMyhz4cHArR7A9TU5hfZS2hNIhXDb/+5S443mS1PlNZ+YLcOx4esTf3R6d1
	el45GNDxi2CdrAqKpz6rmZ2npu+xMyGYwqJtKLvmy1kwP6ZDb+nzWtHCBTtNirbgBP+DjRkt5cp
	e2wBRgonBgaYo2r2Fs14vkVTFBZkrm3p8jSlHJ1uR3rl1Zdc9vA8YReeXZaw8DIXc5me+mR/LEj
	nmiLT8O0L+vXIjiOrmO1EqpoJrkIiOBELk+QoC+IbuTPTAjOzk1jpuHht3VEEmFWKbN+XY9G44/
	PftEiSU
X-Received: by 2002:a05:6830:6404:b0:7eb:3af8:8c09 with SMTP id 46e09a7af769-8020daad7b4mr3472081a34.3.1788992620614;
        Wed, 09 Sep 2026 15:23:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fcef193dc2sm12594318a34.19.2026.09.09.15.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 15:23:40 -0700 (PDT)
Message-ID: <8b138fb3-a5c6-45b9-b881-1c4d76bd1921@linuxfoundation.org>
Date: Wed, 9 Sep 2026 16:23:36 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/583] 6.18.51-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260909134237.773280130@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260909134237.773280130@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 07:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.51 release.
> There are 583 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Sep 2026 13:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.51-rc1.gz
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
