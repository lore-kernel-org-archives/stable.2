Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792453515;
	b=J2XMhtzdvROfMa/lY1CzDw+nqQIofFnxVuADymYp0XsufE9K1DVV8BaIOib3yc2gNL4I
	 2m5zClkQF8Imle0N9VBcB9P4gdtX1lvsJrQirp1ud9fq8NY5t/GmzGYpFsAm2O1cWmyg7
	 IJGkDQFTFXS/071KoiN8yMOP/Ate7bB/9R24sGWBDyrTzEuNrq73bMv6m/6ubKGIseSNJ
	 iGHgHFSJUNVGjJxg07m1tr0LlTL9Kj+YUgGsurzwliHLD2SyWpzAjvu/0LMeHMeHhP9Cv
	 c8E7GjrF5ngVLV54wO9xl1KBg+aYuCMMLf+8ZvVcXgd8HFZLi7lFWWZadLmh7EUQZZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=L+dMPBvak1er1V+6J06MJbguYRMeFQgiyOwZtRIbZB4=;
	b=R2PVkXdRns8yx8f58Oan2V1cZw37HImqNqSVk9VeAAjfy+VYIj14Z2xKRh6qDLtJEpLc
	 wymGwoysby1O/CNyJj9cwzynXh0kt02uXG88xAzJCMQNR8/UFWwbF0WP0PX3I9z8NAAd8
	 Jy0IKgBSfoctXt9wud+S45zCGme+3WtP/vVK5fVuWuWJO/neu9NeAWpxKyiIAniiqnBch
	 0XX7DFZVwyUTrvVraBjs2bXA+vCZTqYitccbJvRQKwH+YgDFhxjQsDgMFn3xiuQa0zKOh
	 n4slX33xPJ9/znEeOeLWoiXuGOQyHTViOIgj9Lpsx9sF8MPvKcGCN/K0uMFe0BejEfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b="IPCxG7f/";
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD79606A31D
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 23:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADD79606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=IPCxG7f/
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4f48d91ba7dso1651674b6e.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 16:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792453512; x=1793058312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L+dMPBvak1er1V+6J06MJbguYRMeFQgiyOwZtRIbZB4=;
        b=IPCxG7f/fn7yzrJoGtOxwWQox53CKy8jYBxBOEVQxz87XwK3rQnw9eotO6Nc3CWAIT
         CWqi4ncgjN9vJ2Y+tWEeHXtGLvCnG1Z2EMtycJKVsM8aaHwjdUjvdK6z8Q37OHkgi4I0
         1+znvuDGzLJ9dn3Oh5OOw0gz/IXkgVbQs14J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792453512; x=1793058312;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L+dMPBvak1er1V+6J06MJbguYRMeFQgiyOwZtRIbZB4=;
        b=TwfNJQTR8zTjPRyN0b/4SRZleHspsgt0iplTX2MiKjzUwJVeF7oO2TsyXaEJZ7gESI
         luCfzUF3v9ueSZQQvY9uHCc9PYZ9Ye+COrmrgjXRpxGiT6hruCf0fZVX82bnAPe6DgFJ
         HifYry3UdVU0aEskW70D3TO0guAaWievIzXAytBAyG0Ggykl1RE8td7Q4Q1BQvIZpzpU
         Rg3S+1oKmoBZNbrIL7yFF1cevPPkyt0MJwMsxkCWUp+y58ilgZ650eRlhfjNRsPnJAvg
         wPAhuz+ukDk/SBoohvrQYXCBv0H52UtV1dLeMTwZm/r1tUSZLdo78GxX02PM9eFXW/Xf
         JDOA==
X-Forwarded-Encrypted: i=1; AKwUvBy647X4DLaflfY0hJpSuZsxrZrQINjoOKIoT1/hfWwbcqoq0x14c2BDXiJpyuoRf3hBk9mOUDA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUyIll5zizTDqlReIl5vo7Mo/sE9dEt7/fTOsaSs8245iKiPYx
	ZyxTpG2ld/Dy1x9IfjgeMBy7+CGW2hSctWUAhbCrzX3tNLK/YwnOYu8m5XgS5R+URjw=
X-Gm-Gg: AYBFou1I6yTw2x76Powd9ZSf0FUWMKNIs4tQ9lipMozce/diBgswV91YRlzRk7+TSbO
	ZdS/cYGwZbUMUYBonk64TElbrOm4DyUSp3FNCThJBY7TREUNFvhYY3ThPAeA8nVsZLjuXajAIjV
	o/Z+5SPF5oziz9zpEKOUn8aF51xFxP2QjGqLhAbQC9VnCkrmKHdwzUiH/mzqhoLAMj8TB6p9Fod
	slqw70c64divELJFh6Yc3N/YtNtO2DXohOFPwoCIp1LgpO0n7yCuEqpO4ahZtoh4tWB/dB0tLtS
	Exn603Svs2BvM4tOBicV5hr4mmCixMvA72qeLNavIQcwWk48qbVV/7ZbWwt2FhEUsY8PyaCQsGx
	tO4kmtyflPp/NT5inZ3U6M6HS8gOZL8qlS39sjGEHl727JB32WAGrEpdzlWrSDHv6JIY/GZWOsi
	qfAHHbeDcNUp0oqOHtTOgi//e/Wpc2IYXJ1GbY9+kb+SP9TBI/TdgF87bwpNMAp/RzYCZ41Di06
	vCOQ1M=
X-Received: by 2002:a05:6808:220d:b0:4a3:fefb:899b with SMTP id 5614622812f47-53cc5b5bc4cmr8945280b6e.7.1792453512583;
        Mon, 19 Oct 2026 16:45:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-54481784097sm3856223b6e.3.2026.10.19.16.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 16:45:11 -0700 (PDT)
Message-ID: <aba623e5-01d2-4822-bba1-48133bbbea65@linuxfoundation.org>
Date: Mon, 19 Oct 2026 17:45:07 -0600
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
Subject: Re: [PATCH 7.2 00/10] 7.2.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261017155059.698368299@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261017155059.698368299@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/26 09:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.12 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 19 Oct 2026 15:50:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.12-rc1.gz
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
