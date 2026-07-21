Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406D3D9027
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653408; cv=none; b=oUnDe0meuE85KyH0qteZsp64GRI6c0MEXTEhaMXGx6a/7o0Sl3sdzZ1nVVWoHoKgbiTinckQxybYkkErz7lxxAzxo18acXg7sDAl0wpN0rspA0QmnC/AGVTF+vUKLHGI4QLsYGDYUudTkILfFo0evW4kHfKk0koiikzgB846bK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653408; c=relaxed/simple;
	bh=lurmzPoLJrWOsUKkVpyMjP3Qj2JTzkzYcplq6TTBFug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUifZxVKyST7qDKi0y9ka25bKaRyOsfco7N+dlGzl2h4asUcaTEHLI6IQPfnxg5yEztIsReQZ7oc0HnQrGku9GUraZOgJ2h4nhRfXH9aOV2eCWNdnqCTwG/xZijcclEI52zM/4moNpmPHXw2YxBQ7Nap21Otv8i33byhjHrgdic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHmf2Hzq; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHmf2Hzq"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-668296d0ff3so6158920d50.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784653406; x=1785258206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgQDEa5QCTugxYPUBMFU3uD0FXt+JeXLzmMnYYBodTM=;
        b=MHmf2HzquBYJYJd4mV7BvIjW3Ge+gsRD3nlnXn6u6rgGByBJUX2Tp/MhWIQCyD6Vd1
         DmHvCCHZ/UmDMZoOijFT3bS/7HAC9Swyqrn9f4kYFY9NGRIuj+iSnQ7jX12UHtywNG1J
         W70+XAmrIieY9FOH6C4RzCsirGC10pIFuznaEszCGdEH0pyxUCsJ67p7rHcfS0SpnGX5
         727vZ3AhU8LEt6gI7QtoVsXJR7IwZnoMigEIHeL49KFt9IMGMnLGOCX/7OUCbxjUxL/6
         c+MNjV6oBpSJ40aiBwv3dNY0oUJ8N6AcTKnk2ubGe14XlAKNUb6ZKMF/7t6EK2c2yGg+
         nLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653406; x=1785258206;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IgQDEa5QCTugxYPUBMFU3uD0FXt+JeXLzmMnYYBodTM=;
        b=cvCyhl658ZDBh9IdHhM3b1XHIrGl/9FXDC+HSzn5kF/P+fCIu+jVcFUNN9Bj7UfeiD
         YTPTum6QkeLvVUytrBVof/ev1RqZT7t6e8SNeUAVDVNjWezj9H59wzQkW/S6FrYLmPfv
         pwtbQLGuo1bE6A3u2TF6UfCpasgYkr5k3xFacNUxQGvCAp9YM5NRmGrJUFu6aztms/PT
         4FK0hv+w45QfWpN6XRCtNwDddlXX2DH7KtD5JDSlh2fcMSUYIZJ2nScUOb+c7xcl0mak
         NAsXhGB1vr68/z1HZqRWl3oORJosqXykTTLlALFAL39puAa+DWaiS7TgjOyP9IzFLK4l
         q43g==
X-Forwarded-Encrypted: i=1; AHgh+Rpc9QOBBFt0Qu7JQHQCdcC/UGtax370EqUu8IqevyU3Xez8nc9YPzLaRVry08pq2A9b6lR5mPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsfnoysJPd9wS8xY2qcbtmC69S5+a+iF1emZ/Fr2lGZ/ynoiyS
	jUK9SAZCNi8rqmM2uBsfvQ8z9Ecou1ATkOcdc9+2qD03GgV6QYIxFYMx
X-Gm-Gg: AR+sD11CiAv02HYKYpegpExOk/mTx068dOaibtBGvnofAHvRPe1QcM+oeHl49Gu17vE
	n9JCgK6wCMzEfl/x6E6u1GuVBBy0CzGDU7dHU0/y21+a20fM5mMYUzjBTL/a8+X47BxO+yM0QK0
	c2z2njAGOXp0e0yLo+sqZsskbsB9anHM3vMl5uVZZ6px+ZdhlvN6dS2sl6A+LEOsHzLmgg7LG8K
	KJjfqBMRxaecVfnDO24hPAlJfHj+6veEAvlJrmHXwzya0uvKWIQLuyfrzuQk8WLtUPtqXGawUHA
	It1M5Q5MA0qqxU+W4jnNDz4UaybV5TIRDPjAqA3YD80yCNx9He+hRUWVvPNrao8qpf6atereiyl
	Ce2EJhnTgksOj81h0Fj+oZz9NcygEP+bXOudCpFfoaLL8/EetLM4tj2oev0EpSWK//OqiGMYSY9
	3Y9ZRRA63CV5bAWq+LCQjI8orXrLGM
X-Received: by 2002:a53:edcc:0:b0:667:b503:4d2e with SMTP id 956f58d0204a3-6683bb0bb22mr4168069d50.37.1784653406212;
        Tue, 21 Jul 2026 10:03:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6683b880cc3sm7342186d50.17.2026.07.21.10.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 10:03:25 -0700 (PDT)
Message-ID: <0a509c62-850a-4d42-b484-0ef13401b663@gmail.com>
Date: Tue, 21 Jul 2026 10:03:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 0000/1067] 6.1.178-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260721152424.521567757@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260721152424.521567757@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 08:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.178 release.
> There are 1067 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.178-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf also fails to build with:

In file included from builtin-sched.c:28:
builtin-sched.c: In function 'latency_switch_event':
builtin-sched.c:1182:34: error: 'struct perf_sample' has no member named 
'file_offset'
  1182 |                            sample->file_offset, cpu);
       |                                  ^~
util/debug.h:24:44: note: in definition of macro 'pr_warning'
    24 |         eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
       |                                            ^~~~~~~~~~~
builtin-sched.c: In function 'latency_runtime_event':
builtin-sched.c:1260:34: error: 'struct perf_sample' has no member named 
'file_offset'
  1260 |                            sample->file_offset, cpu);
       |                                  ^~
util/debug.h:24:44: note: in definition of macro 'pr_warning'
    24 |         eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
       |                                            ^~~~~~~~~~~
builtin-sched.c: In function 'map_switch_event':
builtin-sched.c:1622:34: error: 'struct perf_sample' has no member named 
'file_offset'
  1622 |                            sample->file_offset, this_cpu.cpu);
       |                                  ^~
util/debug.h:24:44: note: in definition of macro 'pr_warning'
    24 |         eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
       |                                            ^~~~~~~~~~~
make[5]: *** 
[/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:96: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/builtin-sched.o] 
Error 1

It looks like we need to backport 7a490187f22b ("perf sample: Add 
file_offset field to struct perf_sample") and pay attention to struct 
perf_sample being defined in tools/perf/util/event.h in this older 
kernel version, whereas the upstream commit modifies 
tools/perf/util/sample.h (which was introduced later).
-- 
Florian
