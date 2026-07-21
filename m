Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920EE2D3A7C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651571; cv=none; b=BG8CQ4/ScNVkEpTpIuSx5hVbFy2l3NE3a9ewmB+0Uq+b2V32AOrGWh4i1u2FZQYWO3frs7iZpTGIB1PgTJk9/77R3Hxq/ae1VO4kjm64xJVJ/8wtgTaHj2gFC6QSZcj3sjl+3SJcYPXnjs69BqOrFMznbwguyZnyfeC9NAqXmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651571; c=relaxed/simple;
	bh=HmWR9QEkurh9by8p+XQNBkuAhyZ6c/KcKvYRTvnDJGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXsPWqbldP0gdXO7+Fdrp8YmSDorkDrd1vs4MEjfafQzL0dJfayNKY2fQbSDPtg9q97McV1RnDHikKst7bqNtApFqHmS8GyQHcd7u/6Pk0O06teLJESvRZeIpA7Inhz7YBU834KZ21inZC7Mt9GlF5hpl0Gnvp1NUCPAlGWNlxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL8fD1C/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL8fD1C/"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so6621035b3a.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784651570; x=1785256370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rojvLStlOa8TuKO/DtD3fsmX3MSIIpt1yWUNLbmNaiQ=;
        b=bL8fD1C/8fLlhx1uG7m45nY4OYiXb6KzWE/XgGonfQQrGFhICLSoBwEWO694Oi1hml
         rmez2DK0BjP5+pJlLBYYerprkHkQN/zhqd4DZd/LsbEt16Ytl35DX0OZg81jj5SpH1fC
         HqRBmco+YAjhVcLe7svyD8O6OdfYbp8C2rykl5OLZK+HvpqGM6QZctbT7pDIiWYF/t5A
         k0BUmWK5/ezDUZuaBXlW/xrdfOElQUg/OYQalqm58jDCdPq7jFfgw4Ch7mluUhb8TI3O
         I+SRrC/bvvkKwmiTUJ9DUD+uOSSfQ/2IjXJCqAB63H3I8ZzXr0K5gyG4xG8MYWtvpylP
         04+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651570; x=1785256370;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rojvLStlOa8TuKO/DtD3fsmX3MSIIpt1yWUNLbmNaiQ=;
        b=WrGrZOIrFcQzyfAANKE52rwras/45yk9EKQvoyl5H/Tn4axugORtC7tWrpy0tPg2/q
         tQwMIrffmIGNIDxDx0k44T+Dp4RzxwBb/vIMOy8d2W1aLXvpqrjzECLuu9Er7h9i7quX
         aph4TZN00zEgAN5tPDEVvLKvN31zRrNHTtEcIoaKJaMSTMLF3S3qoDKZWSxIZpPoXgju
         20NEhSOAuVpGqfx7lJHB/L2Pn4i3Hko/y5QxeAw4285yL3XhrydRmCO7vpUhrmm8pniU
         X6jzoAJluhGrPhc+L6laqIRKZ1fu6r4EgRlVRxyOJTIYQ60DHwvgtCYAEHmHblz5XHUk
         mHqA==
X-Forwarded-Encrypted: i=1; AHgh+RrIv7muFmO6IUwycyFLGR72ED3vPr/YZ4CJxgBQzhxGFhjzV1B6FuRkKt+jsNvnRLgqSVohnZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDrq3N1f8EXb0oGGDvjUJzlJDA3tPKIXGGWTPhd+1DDlxFdVQ
	YdiWd46RJGnjIYrALNQjijefgS2PqPpe73jbNMY9y6BVZoleSaZTn/Li
X-Gm-Gg: AfdE7clBvPI+vbRi5j+cWTgI/sxMbKtH/0yOpoS+c1mMXYTkESWAtB6rqbBpTfJRbKx
	EMRwGUZT1p8EF4n3EA2ooSEAXc/ifjtMkDrBn9nmR7h4cdRxGeNevEZJVMAdI0rm+iioEvS3Pep
	QjuciWFlz/pSCWa1NKs2xui/rko5InXiqb9B7VRJOBC4aT9BJoNnyWkjNtw/0hWB6KVHoF8nUfH
	alEBF+muTfTGwMgkX+hs4PqbNnEVGmvcRV4lkRF5Klarbm6Q4aopOB28Ts3+J6+46zBdT8rDCuU
	WE3VsRcEKgtSTJw+WjTmhrDYogzHErx3UZtrHH0d/kAUHFkBlh1pspGLilqr5N7+hl3j1Hv00Gv
	7wgmhFyMg7ZGuM+VG2BrQewVhuXGGDSSWXm15dolbIci15a7qxPrTLY8TwTpYzOG8IMnMnRU7us
	/XJ6zmgqa+Y2nDOSCYR5sKHSMJiWgY
X-Received: by 2002:a05:6300:7105:b0:3c4:1c9f:d91 with SMTP id adf61e73a8af0-3c41c9f2e52mr1788962637.59.1784651569833;
        Tue, 21 Jul 2026 09:32:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29ffb13sm42467604c88.6.2026.07.21.09.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 09:32:48 -0700 (PDT)
Message-ID: <c0138a17-5653-48ec-87c2-4da1d3354306@gmail.com>
Date: Tue, 21 Jul 2026 09:32:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/699] 5.10.261-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260721152355.667394603@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260721152355.667394603@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 08:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.261 release.
> There are 699 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.261-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


perf fails to build with this error:

util/event.c: In function 'machine__resolve':
util/event.c:668:32: warning: implicit declaration of function 
'perf_env__get_cpu_topology'; did you mean 
'perf_env__read_cpu_topology_map'? [-Wimplicit-function-declaration]
   668 |                         topo = perf_env__get_cpu_topology(env, 
(struct perf_cpu){ al->cpu });
       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
       |                                perf_env__read_cpu_topology_map
util/event.c:668:83: warning: excess elements in struct initializer
   668 |                         topo = perf_env__get_cpu_topology(env, 
(struct perf_cpu){ al->cpu });
       | 
                   ^~
util/event.c:668:83: note: (near initialization for '(anonymous)')
util/event.c:668:81: error: invalid use of undefined type 'struct perf_cpu'
   668 |                         topo = perf_env__get_cpu_topology(env, 
(struct perf_cpu){ al->cpu });
       | 
                 ^
make[6]: *** 
[/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:97: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/event.o] 
Error 1
make[6]: *** Waiting for unfinished jobs....

which is due to commit 07511f3c23cdaf1dbb44802f026fcc476351dfe2 ("perf 
tools: Use perf_env__get_cpu_topology() in machine__resolve()"), it 
looks like we need to also backport those commits:

751835c57632006232bf30405cd7201dceb0b8e0 ("perf stat: Introduce 
perf_env__get_cpu_topology() to guard NULL env->cpu")

6d18804b963b78dcd53851f11e9080408b3d85c2 ("perf cpumap: Give CPUs their 
own type")

c760174401f605cf63314d3817069a40945f0e0b ("perf cpumap: Reduce cpu size 
from int to int16_t")
-- 
Florian
