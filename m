Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656D3EE1E4
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781782380; cv=none; b=LzYKB8mW7c+2D5JOlvo0bhuxxJ4ZDeld5T92hTvroCHiftwqXSimMWKepQLholJLVTs2I8eUqT68Z4wqD1/82aMbTUR6AxvGJDQgiKwMrxw0FqpjxemOfp+s6JPJNDq+NiHmwp8xL0CspFKikO9MRJzXe/9Euq4j7Blp/0N1ojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781782380; c=relaxed/simple;
	bh=0ocKBah7H7wSGcmRtvd8nVZX1kQbbiXVYJX7QrZ+W18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrFuofWdtvMdvaIgyoTMdi1xIv5+ETaxyCSODzQp9F5iinGw0gIWExbgiF+Nn0v1fop1ShpqXXWoB4rc/hglpQTz4LZC4WpzJqSTBHON0rv6HFRiSSOx9WpgsuvJ/5GxXSwQwJCxbAP0vrCWN07l5Z2lGbSEZSgblcyalIVqMTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmGhvew+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmGhvew+"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so8202395e9.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781782376; x=1782387176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rWjb3dkCCJpKMUvJjiozK+b/VXA/rC9ER59IM77iGM=;
        b=CmGhvew+wNQAf1Pr+Oh7/jN0872ijG2baKotdjw/3M/fQ/OiMbnm3uCK7mSsPJGGfE
         vVkLutgbeDiIBXIiyrE8LMDAtDXs1yPNVK61nVFEiwWbwMBZ/BeAKNASAqls7MGOwnxp
         LxDc2a1aI3HGSCcNS/J7GCI1eQcmn4dPTXMacpUtO+fhW3hxFWCvUUeV40z494Kjg858
         dAaQzSgmg+zlq+xAh5JKc+zeT41Eh1ZSEJe6Q7NhHbMW2r60l1g8BlqOpMdJmHH2RUzb
         90GhMpxklYeCuddslTTz4mk2uw4xEFgFmsayFE58Vu/tbNgWbgxHkWtRm6LLIwV6qPjc
         Ntmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781782376; x=1782387176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rWjb3dkCCJpKMUvJjiozK+b/VXA/rC9ER59IM77iGM=;
        b=cW/8xUBGUw/5WIjSgu54BlJG1AtySYtbjwBfVnQ4jCY8wM4nR1rkm2nE5ntiJIPQQB
         jcgAHnv9L2XvVRv+TeEW/T5VvPppoiJHJ8og6bhie+LuET8lpbPMfDigSTf3cQg6ezul
         Ma0mMc9ZicrLv1/Gzpbqhy15k48+JsoHlo1k6bv3r4MXm4h4HREKBCBYwLMXbiwM6Sqk
         rjZ3wHvhj7QcIevzIgH8+6FtyFgrkMg6Yn0H/5yRmD4dDeTHDQQ99t3HHyz6bnjabIKu
         tKq807pQSp1JWAe0pxflpwEoG8wrS+cS882zCfoGuaNZOFOPYBIllfRe9jd4+D82jCGK
         H6Qg==
X-Forwarded-Encrypted: i=1; AFNElJ9Tt/1AlNG9g8zY3g1SupU0Q9PPrMxcvEo8ysLdq4rAu3lrKtA31u+7Gb9zNTaI/jvrZPRLW+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jE2UPpjJhOkSBtqZNSdJCNM1xqDyr6Hp7lg50u5yJlxo2ejR
	k1SJSvUlTumecZEKayzJwMy2grTI9y9A11vnb9EnkzeiTtc4p9xyirQO
X-Gm-Gg: AfdE7cm38Ml/mqc1JaSgXeO8sjlDPuyn8v5pZ9g0J9ujuLpmFloPDoiv6AXMwrYUTl7
	dlDXErpPw0dGhPleu7y64RZ8HdD+sTOZ2z3aoJ+J9/NmOOLhMBj/MJwNC5MaDh2W+mM54yqSdvz
	xaRLyugJx8nj+uJ4HvYcVn9hc8D7wAepCLAa0h1+QYali4PMA/qW44AxdVxzDKfPJJfohre+t8d
	AQhTt0OAvMLbnQu69olVpjAnYzSUJqUZvqc7CapZNhxeeoGg7L49JChhTUa0F6JUGtteTCPOQub
	Dl50ISpOG0a9/1MpmpunE7QPfNUQTtWItibgSLfM0Wn+8db49dQLWXwDC/rOkAai7cO0ISimkOq
	7gAkfX4x1FktFcaTihufhGnlL3HtFxj6B4rE5X8PVvMwBLy8NISF3uMUAJDLLQCgDso6CJA8iXv
	MdRQJHnQkIOdTCp7NFYGbAfR0RugHitQ==
X-Received: by 2002:a05:600c:8b56:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-49234127e32mr112124015e9.19.1781782376153;
        Thu, 18 Jun 2026 04:32:56 -0700 (PDT)
Received: from [192.168.1.21] ([41.140.50.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47da9sm287756915e9.5.2026.06.18.04.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 04:32:55 -0700 (PDT)
Message-ID: <fd5283ba-4bce-4984-817c-ce6224e779a1@gmail.com>
Date: Thu, 18 Jun 2026 12:32:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/452] 6.6.143-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260616145117.796205997@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/16/2026 7:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.143 release.
> There are 452 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.143-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENEIRC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

