Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D145119F40B
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149121; cv=none; b=Wv3Vy+JWcnLJ94L7Tb34COFD2Kg1hE78d3OjzEoxyoy+TsWEbVUthEKLZePF9Cp4ROb3Qe8mjGdvXLOycwuxynMEw7OLnSyl4xaSpDeIfa9fT8mGvaW2aIDkSe1t7eb6LP5HIdsddHs7QbYSTv3S1CdOrtuwA3Dh61J7uTmyqCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149121; c=relaxed/simple;
	bh=GwicImTJVl57xDBC3k+8BZf7Zh5Jg5n/dXvN7dGVD/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1hS5CYDDMPZ7WUjf0St6CrLcBe4rbeY5N7mjaEcte0LDFF/jM8zaSxgqwPbVaKwrh+Lb2hwWfOME8fbQ3RJwVTSlY/jhEzOeKPOsGUnOLRXhLYnrLj3qNosDqv0pnmJFRTubnnsK1omdAKRG614P8mSgEhLhIC3baDUf1DdIlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KQ6fN7tG; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KQ6fN7tG"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9ecd7216cso90405a34.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 17:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786149118; x=1786753918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9Q6wgg96tW/ysuHo9TVqBk9IK20Gh89rsTXRCAre9A=;
        b=KQ6fN7tGL8WbGZsh9eOLJKi9DORelen9i5yEztBUs1TVZf7iih9MsZB99iL5vDuf/u
         4gA3noJL1VG5lMUDxgxga9CdBcS3q6RA3VQrJazHiRVCzACE+FiBOm3xpDZximUl/Lov
         YEsMg120+KRaKF6KKdxBiWbXAZJIz8r0xSbm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149118; x=1786753918;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C9Q6wgg96tW/ysuHo9TVqBk9IK20Gh89rsTXRCAre9A=;
        b=rYFZ88xU3LDHk+3Bs2vT1H1P7eVvKhFWtUrAhNLp8mw73Ls96Y796csHmxZhtwjP2R
         JUSv7VYtXjC2ZIJhByBc9HF1zcUI3EF3+Bg8aUrOxUob4dh5GnWR4mq9f+3oY0mE65nc
         dl3Mog286KXegnTe+VV9WV9yi8o5omwjt+xXGwdcxZckIpwVjIybxK9RrAqAlB0lGdbS
         ldsWodwOOaJ+F1nlIFtds1b+k8ZpXK9HdziJjrSRn7KLFtuFMklrOyv85XYAbnCG1jIc
         w7Klpj9m9KTb4Rt/EImT67MJcIeVwPpWWZuaeE1+dRdh85buQ2AcAwrZBF4uEuIn3z3f
         uAJw==
X-Forwarded-Encrypted: i=1; AHgh+RqG03BTPV749c4HtVpVfDliEYDaGHcXW4BEu75AK/sBGTh6M9tXAAQxYa0QVssMI7JkLJBtxEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhQADTCHq97eBYK2w2PaLSjPDbX+PH+teLT86FU+pHXGKYCSio
	fy3btujFiEHu6bemx073xFwcmpBJumw6LL+BYj0pR5zIU58E41mSfXpy7vOB7lhlcOc=
X-Gm-Gg: AR+sD12eaiHZVLFXr08gvhajUyJlLiTCKvHcqa4KBU5u5ppEgPswsnnTPcrMowlefQ/
	hRhUD6UUqDm9vVvSJxkymat99Bz7ntbpInYyCGvyr/cDZAIMNK3mDRyRfgr8pBX1bAe3ZVSpe+B
	zr4Z6w/jIGoAR9CRteY2D+SJGM/Oh7oOgu8AiZiRaeFtKH9ChhTVMOhQ6Ff4tt37cIoeIDRnVAb
	8jZhqaqIKBZzCdJSWbUElY5vH7yzPwQSfMsOqmswPgwpc+3JVd8v1O7u0ypVSLGlEQPVkJYXBHl
	434oQ2SR8KR1pTntybgNd0UIPjyD4drMaaLbzJy4o12IGzqb2h2AgtX37Wf+bd3xhWaf8XXWeja
	x0dd8PxwlJGS/wmSxVN2g7wm48wpcf8mna2aSJSQxuvzTvMGhqZs7ARMaGL8fNEf+QhXFcO/8kl
	MThTHUnVj7xLKIKYlap4vroxbpq7DzPqXYGSfqiBgwDVZjeCsMY8oRePoov3HoJuo7ofERQw==
X-Received: by 2002:a05:6830:4425:b0:7eb:c8ed:71d5 with SMTP id 46e09a7af769-7f369371f06mr2788345a34.14.1786149118694;
        Fri, 07 Aug 2026 17:31:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b7c4c3bsm2256783a34.24.2026.08.07.17.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 17:31:57 -0700 (PDT)
Message-ID: <d310ee05-41f5-46d4-afdd-c28265d65723@linuxfoundation.org>
Date: Fri, 7 Aug 2026 18:31:54 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/396] 6.18.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260807143424.272339768@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260807143424.272339768@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 08:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.44 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 09 Aug 2026 14:33:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.44-rc1.gz
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
