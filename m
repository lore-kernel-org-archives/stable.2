Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC2350A18
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556105; cv=none; b=EyM6G3o3MxPlto06U0gTXVbVpPl2/1FbV6UiG+EXswFQyaG6OT51L2oF3UiGp5jaWosiaIXUDHfjGIuFeyaEz2NuxPEstgtPY/0BSvHtd7cxoG389u65i0RZcLAbo9ijeoe/qMMnyX1HiDBbeMONRgbqbZQ5Q31GY/7SfadlzjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556105; c=relaxed/simple;
	bh=TLbkhy7UhS98+n2pJ1BtGLZtz1S+VYaSrwgfIluJQvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXtoOoRlNUdEDaWkRv9RP28gjNL61HFgsri4vlpKgi6Nlk72Bqda94WQZqGSB6ToU6wYRW3Z1uWCM175EjSHiZ2QK7uzs5mPyQkiwLZbZnLzEpdxMxPclv8zmCorXvj/KYXExoB6k/JdEdo09Y17rDmz/fgnlSV3vycMed+FxUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hKQB6+Ae; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hKQB6+Ae"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b21f09ec76so1189072b6e.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788556100; x=1789160900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WBcQO8IW5vaft9DEnj/gUzJmSXgNK0HzXFdKXlnG8Tw=;
        b=hKQB6+AeHcrv91DJJrKy/lpU0rfxaaj5ynT2KAELjDocSimnwmV2ArKafAUO93CCoq
         JCgGGfKSynjZ41PKBkOCzdDtoJbB9qkIh+dKj+N6RjEl+0x16RR5UIHgX2NzsyogZqYR
         HfUhmcFubkDuYcBSHz0yoDsT7CzhGqh4aevEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556100; x=1789160900;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBcQO8IW5vaft9DEnj/gUzJmSXgNK0HzXFdKXlnG8Tw=;
        b=kxtSFmZ2k7l3m8CVecepIkVdJxwdHj5zS61naIa9+zBCc1vXD3UPf2IRGVDilQ+NBV
         +NkaJdhj0/NPxuV7pZkxmBr3SMvQV2/uLi0StUVbpRv6cqg/7jw/nMX2+YGIGLlAkoDf
         T1lT75bTgUml/IMyDYOZ6jHyH/b+WI+P82mVdWbJPe5YAwlr44jTBQd5Gb63c62HpfjH
         3evtS+jJ6K/l34zTwIGep/0sDS5ZB+z8xsv8pboLPjZxAZ2xAMMP9WVaeNZ/X4op9RrN
         FS9QJgYynGuk64G/s7eNc/uWI6BBsKYKJA47MC5nSEHPMl7codI+R4W8q/YdM7pl8vm4
         U8Zg==
X-Forwarded-Encrypted: i=1; AKwUvByoczCjazUccvVSacS3025b44pDmdbBfDh9ixAwKFA3ng0EOK4VPr3xn2NPe085gWj9co9UtCY=@vger.kernel.org
X-Gm-Message-State: AFuF++mzJAEXS8c48mHZ7OiDYchVYe2RUAjyEuV7Ilb8gVh0T8F6AYid
	yaAQ9OnXo/FFIJx16p2K+NZHObu6QAhFoGdql4W10OiOcLD7R9XsgRIH2JmFIW9aHfaku9eDd+6
	kKXbfqQI=
X-Gm-Gg: AYBFou1htSqE3n2QHvV388YD9NZFXkSKJM4UeRHCE+jtxFTi/qzsKDHAtXghC6VqK+P
	GrPV4+6mi4qKPjo40f6+Ngw9Ys7+NG7gV8Kt+rQ1KuKg2ckHZSwT/Hve5ej10TTM0kLvpP1ATpX
	HGyciepXeCXMwXv2KRfBkZ9gJcSAy01pHeTffoR07PLw/umxZD1Dqjf6mfO5swPpg5PGV9tvB73
	MgivcuGTzG+xwBEFUgOx3IfkKegENYjEgCBrirqCaC8ys851ffY3N6Kkfs76Ptm7jV3pPObSDGR
	N57rhbfhYEyr4Z+gfS3SPDRn988bNSpUQvGspMbW8bvuvYYsuujTnraKmmygSvHTMUYckodXRIV
	IjuNvVuZ2XLFsVO1rCXbsZzaHAPk0e1G1UINS5bUUAeX/co1/moLQfoQe9RylByGt/oH1rMY6uf
	2zypCwiPT1UvQ9lGQlKEumjTY8L8KeEBZIXI5DYVgafM4VVc0ak0GqraeQmiQ44eVpBhnM
X-Received: by 2002:a05:6808:23c3:b0:4b3:7efc:e970 with SMTP id 5614622812f47-4b96026e6ecmr6951990b6e.5.1788556099903;
        Fri, 04 Sep 2026 14:08:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971b97c72sm3487810b6e.15.2026.09.04.14.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:08:19 -0700 (PDT)
Message-ID: <fe373fd0-6577-4f5c-8285-d8398d867797@linuxfoundation.org>
Date: Fri, 4 Sep 2026 15:08:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/713] 7.2.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260904045803.810145556@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260904045803.810145556@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/26 22:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.4 release.
> There are 713 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 06 Sep 2026 04:56:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
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
