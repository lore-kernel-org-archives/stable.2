Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991515278E
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784302268; cv=none; b=VZmZGl99BNXruawjDDAf68NB9Nk5HTgoMKANCvBYmHojL44RihqvwjHufB/lgoHLpiBtFob+NOZqUDVwwQNZ2Ljg9Kz/8cM0O93gAjPEWjzwqk2J/e5c9G1I1gKaaQtTizGlmHvr/W0kWLDxjAbLNy0lFZ/z7UbBhxqlJkIj9rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784302268; c=relaxed/simple;
	bh=pK4XXBR+u90/6CIhCuYQsfAmhWhgqVxseBHb4pQVOPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WO27tXb5ohK8rBvz7N+1QtX0y2TQewRuKzUqTMYWpVhL5lOrA27tWrPnUZzJY5VWUW9HJuKJum4+5NpvHUxmLQOVDGTHIC/QNTJC+cBskijaHrvLK1Bv51m65ahzLoe2rhmVutZXpbBJ/yb0mewgAIZyCjvzMnMdpaONY5qx7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MTERsQo/; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MTERsQo/"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6a39a267d34so2435810eaf.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784302266; x=1784907066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RKK5xINrVK66ISMnlbs7FLVeWDScDkulOp15v8I+8+Y=;
        b=MTERsQo/0EOFiOCRvgjRB/DB1w2xymmtU3BagTuUTyWT8bTqPRfy+P4LsCLibGlvLH
         NCpRCWwyWA8zOI9tQSjTgVHRn8iXAu9oXroYh+IAAKzTnZnSeUDOCXf6uknvgWKI1xXc
         PvCr/f6Rwv1Ly+6pT/ogyPYXX4Wzri9EnziLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784302266; x=1784907066;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RKK5xINrVK66ISMnlbs7FLVeWDScDkulOp15v8I+8+Y=;
        b=GfTCYtSf1qDyqSN2rSXOLDAY8kH4mWnlg0nD5/seFKOBr7vwrS/gSy1oiA8TbY+7kw
         4aneRuIowXQ3xV574SahIqGcyIXZR4WgF0x4Y0wSYHnWNX3emwq3Bqea7bvsrFonqjbg
         qW/HGyq3MJrhCJzdaf9PFWXmu1QyKJukWGiV8a3s+8aSMNyF9LzOqh/BlglyntSIop9h
         w3CvF/YmES/YW24UO6zkOp/P71ncrMBvRAnerBj2U+WFlPNARrMhpn2pK1f4ZsLgJyv2
         y4fCblrmpc8XvV+7gAt1WKACWkAiB1R+5nqWwEfT10EBUNkjCRY2rZR2ewWPR42/qBxP
         Hhmg==
X-Forwarded-Encrypted: i=1; AHgh+RqRU5XamlV6E9ScNCqoaH3l0Oo9O8jLFVdNI+UnGwWuCjV7UWI34M6gSYax+cdNKuJHeUNhEoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3jZXRskyqsYffh6GRUcKSGsYisSAd7EJjQRY7TTUi6O7Zt9u
	anEggdHv33WgMyDCI0ZS9sXA85D217rxsU1mydOvnJ/mCJDsUitEIMgwttLHkmPE14w=
X-Gm-Gg: AfdE7cmcUxJWpWCeDLh08QeaAVi4z5PKWuV4YRyMO65i6R3rEPL4PPY2rHw+B6LQaWI
	dfsqWnqgrCZ2LB3NC+3jB6KIXkZYUyTAlBxzOTTS5xdg8BxP3XLRdlfn5RPOe05FebiixN8A6dU
	5AxIoCOY2xLvPiK0jpZmUdV3/VdcBReCrdf0SaHIlUE4Be7HadrluU3MMkiJJdWMTDdMkC1zs3Q
	7M1QnyjZwNxrVoxkwstH0tvqh0zmCG28ZqQ6N3whRpLo6dRH9DR0IkvSIvcmzojIRnjZmC/y3EC
	k7hjWZbPEYBoeR7J0eV2eISMVslCWLG/n9wJykJ/WxxpgCUrX61MLM3SMKzpcR/q8c6dOjCX98P
	eRjT1vbNr4CfwehKdzkjCyFVw9zGWcrXa8B+tSCxvmhCs+ltmYNDgw8ORJHbdfc/+rqsg4auVID
	NXahVl7j0PBNA5ZciZIO9eAw==
X-Received: by 2002:a05:6820:4d01:b0:6a1:5756:10e1 with SMTP id 006d021491bc7-6a53686e043mr1286853eaf.55.1784302265869;
        Fri, 17 Jul 2026 08:31:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4568e141e9esm1471256fac.5.2026.07.17.08.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 08:31:04 -0700 (PDT)
Message-ID: <089b8b1e-a546-421f-bfb3-8c3728f580ab@linuxfoundation.org>
Date: Fri, 17 Jul 2026 09:30:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/349] 6.12.96-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260716133033.287196923@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260716133033.287196923@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 07:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.96 release.
> There are 349 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Jul 2026 13:30:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.96-rc1.gz
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
