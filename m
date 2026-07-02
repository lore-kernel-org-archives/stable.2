Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BC35E929
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783023489; cv=none; b=ASBmlw5F8MAQo52dHjbyUS8nBcFAFQRzjCALyu+nzhb3zeH4w1QNgr0zSJTCyzsEjWsJIe+jKTP1sW+roFfckMOIhTEnK5ZN3JXLgHSe/KZAmTL9wkrFoBQTw2uDd3NE6/cH+Ml0dto7n/s80WAkXYDclHv7go6VkiFFj3jCWrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783023489; c=relaxed/simple;
	bh=SkElOmdjimEVDG9if3msE0Md43LetI4ECNME1NI6CSw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AJieQ7UcKVgL5ofR49+/SZLZweINGqC2mlZ/Qu7Wh7n2Ymlwg6IN4iRlz0xsK3i7MbfEvHZrALlUzsek2K6Pa2rAbeAv364EUPiolGVWF5IsPkqvi+7p1XAjr6z6gSEefftPHmEEhfNQGbIX2a9QQ5rhP2b/VBSzje6qhZ0w8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwdFUdqq; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwdFUdqq"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44cb68d549fso428285fac.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 13:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783023487; x=1783628287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF7n7bcUMpvGgguhuXDMND355JS/AC8zTZapBPi/s0E=;
        b=dwdFUdqqrJQAqBIRYJvdsiNLNro5KL2hTDhedaeQDkvzE1WD8K29e1HpdWF6xSr+Uw
         VKqIf1gOO/dND3mUONEcaRoFvZEIH96NXj97lffkvrQxYM5kDb07lPhutuyt4k4Xi3o9
         AS5AkfrMqCDLBYEyMckkCLYuCwjlqvunB+HZZJODTceVRea6Nlu6/RTXMw/YU/krpjky
         RvesQP5haNJ+wusap66bKCh16WKFMA8XXdnvpmfPU0cVME1OSmPNpQyYX2+WfbZ9LsJh
         No9WUY2am79qLbqQfpbbSWz2jAoy32przxf9zEpgLGPs/GcMzqO0kAdQ4cPQhKUP/qDF
         jt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783023487; x=1783628287;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dF7n7bcUMpvGgguhuXDMND355JS/AC8zTZapBPi/s0E=;
        b=lBCbZk5KgsbKqGcYoGAZXMptUf4CxEmgjxP60rThUYSM0ofRtFvOwRVurNgGLnwQ8I
         hlIrWGC/XcisSfBYFbDfdY42tunLlfZxWiGoOfTNUtxQz7d3XIwKRH8W0GN4zsDQCJfe
         ftlqUrUw3r2zianH/v2l1ctqJ+5+2Vw7Y09yzYY7X7BMERMn9qHr7oQoGmJjEFpBEXfd
         9EclkWGdY4a3z4I06Sx74gb+z4gaDmAhAPY90Qv11Q2W1i8kDDTW04Nug4wxa0IAYL2X
         OFaE0M8NDr8goNJC7WV427ND6p8+W1GxIR9aM/Xn719lFuvYLJQpax6envYZPuGUyx8M
         7BSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KBqDg6F8vco+UxyBPAX4roSWFtdSSm57nsBTx9MnJAyEphiuAWy7XZGeLInIK6cySPyrOcoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlIhJB1AvXJxbCooxY0exMgZLNySAyGK0w1jTSb0TztQ9arCz9
	PsDxyO5VwqfHIy6wYWMB+pf7Z6097+GpdLTdowKavP8C21Sp+3B0t8I=
X-Gm-Gg: AfdE7cltCGROsTCF3gDPMpmhYD8deH/gf3LqcbToeVF6b6tTJdJ2zlkk58UQ/KSJPQc
	ABLDSUoGuV+SQl6viCoOlT9cA8RQ20fd9SHtQ7VKHMyxFVHVpDDz9ZygIQTNtiVL7yEaMOzQzZL
	8WCvp8MUC7ePb1qnWGWafncj15wtmXCReRKX95As9Orbe/i8fyt2nxVqwXrFuFJUGPctgDOCArr
	GtUf/WyLLlzGanlbKU7amh0YIJrPvD7FChleG0h5XnRZBHs9NjPovDBQA8KFyrbBG80t5fLCN2/
	05QxCQPaPWrCVMXAtmdLzvZe8JvaSPMF9xnbUJ+ujxrENSo4uSnGw8Yie6Gx/CFBXHtTqkRm/YY
	HO4ctzRCOIAgx0Q/MUT8TMCKm3FLWGRScFMj+luveuy1nbEalfxXGH1AifmaeEpwszYxjQjJeRA
	yJGPnEY6VUfZGLvfbNqbTqDZW8bwIRtsj3Y0vRhlR1
X-Received: by 2002:a05:6870:5348:10b0:42f:f3b2:e2c9 with SMTP id 586e51a60fabf-44ce9b12300mr627785fac.0.1783023487335;
        Thu, 02 Jul 2026 13:18:07 -0700 (PDT)
Received: from [120.7.1.23] (135-23-94-154.cpe.pppoe.ca. [135.23.94.154])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbe84f609sm4052650fac.1.2026.07.02.13.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 13:18:06 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/96] 5.10.260-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260702155108.949633242@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <cd648774-2a64-e5c2-a120-e4253d72cd1e@gmail.com>
Date: Thu, 2 Jul 2026 16:18:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260702155108.949633242@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.260 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.260-rc1.gz
>
Problem with the kernel.org web site? I am getting

https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/


  404 Not Found

Same for v6.x and v7.x..
https://www.kernel.org/pub/linux/kernel/ seems OK???

Woody


