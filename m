Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ECC3FF885
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349513; cv=none; b=T7q8oV4jTmLmftqWp5zd4t56cWU0MHtPPcLEyeJgYtCOTyd+JFOQjoEsBga79U4TRk88Paov1K5+brBHx8boVVoKHkXkOCIzGKT0L0qAAY+gyZYxIgoV3BE0XLqFTxuKNGVAh6WHI6vx387lUfFLtnES7jRZfmmNCphaLr4wWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349513; c=relaxed/simple;
	bh=sq7xbhnc9EjRi0Ay1bR2dO6JbTROjVeGnProqyAUdg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KatITw4hDBtiT9F0EP2UUSTCdwnHSsntn/nuKLdkOcVPpnuLoosfKon7lpP81iOZokJa0s304+sL7byY+eVwCHGVPxsHA0vIZH2r/KtFlAS8//eV07DcDedPsaMN3VggfyklqxswNj5E+rhIXKkOnh6og3+5ZjgMgfMoDNFVYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VW0TMTbr; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VW0TMTbr"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a31b9a492aso1691616eaf.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1783349507; x=1783954307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wkpr02sORILsW4RehBg9onx4laNz5hB035kvA5lQmY=;
        b=VW0TMTbrDFMJOXYpG9y/Vwohpo/dZv5DdA1SvtLeBAo6y4o5y002jjfo2Ioo0FZHHy
         DoOoI4VfSWdjcB8DPv26xZbU6MzIZpHVYs9nNeruSFxqLfcdfuhc7JN3jqpptM/Y0RNc
         ZbULoxFV5OMsymikemShtlp/UQ6Zwm+Lu0zV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349507; x=1783954307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wkpr02sORILsW4RehBg9onx4laNz5hB035kvA5lQmY=;
        b=padRPTCT9QdtOa/lwneE6BVNvSCCa+CdGD3PrI0Lu3saPxoUpvms9rp8gbEcYg5tyP
         kkiPJhvdrsMrtNCDzQJ3I2GvNVIQIn1WQMfk5B5PhP0nG61vENCFNB+b4NY2zDRQwbUu
         c3XKJ6U8fIPh+tDMc/hK3XsxrSnx9xn2AeSVjib5HJi+BP7G+z7RSyJqzDUoi9tPWv9u
         2zX4uf5Ua0vl4N0bgFHfSQROJu6D2sq5fAOHTdrmmuFPFyXLXpFc8kOkt9KkN1h9H4yB
         slF3wlQuCUhhjRmk2CMvM7/fhj21aGWyolijE5AgkjdjQMGghCTz8yookFi/RXknZg+F
         149Q==
X-Forwarded-Encrypted: i=1; AFNElJ/UXSfnuy4kz/FsQO2M776VfjcA0OAXS0lE0MM59cHFHI/lKqQ4e37Rxeuaxlqhylk72MoRLCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDPrhZC0sz+1RSzS0/py0+2kJDf5IlNJLdHrQaWLja/jLSBif
	C2NvZdUd3ApshcKLTlfMJxmOQtj6NLt2oe10yht+tUmhU8ETC6pRPyyYQOZgJlA3EKk=
X-Gm-Gg: AfdE7cmEoTHTQLgpYVqOgLs7fxX8hOPgTf+1vIV/WnnOBdhAmfrckoF0IjbRhTLj21W
	h4EKtABgg5c9u6sy6IGhiTDNLP1f6OAb19Zo+SN5NM6HtrONZ8hPla8QFU/sWzxo9Q8V22WOuVB
	CjRXMD7j41TXgS30SVcEx5RcdiZO4cXX2Wg9bqM2yWh5d73SGUmV9lfC5bbQgHXVvZagfolzsI1
	JiIu2SbU5nfWkZASQBBqkIQNgfCj1JoonRSbNgub+f28hUuGPP2LwyDSWz5kD04KXupNLCe930u
	wg2oFNc67Z3OL3ZDSz2cU/yMUe9gcHACYIK1mZjKxgk6tfdGieCL1e+qYeHOzrY0AASLyniDp/j
	7D952X3NArN+LLijwLrsImtUiuW3jc7cj7DOToCY9yfSebaK2EyqKHq/zws4pH3l7YJ1YOp7bnu
	RhfTgeYoP1tQTIE/eaBM9R
X-Received: by 2002:a05:6820:6ac9:b0:6a1:50eb:d4fb with SMTP id 006d021491bc7-6a3553d9de9mr521946eaf.60.1783349506968;
        Mon, 06 Jul 2026 07:51:46 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb13e15esm11222998fac.3.2026.07.06.07.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 07:51:46 -0700 (PDT)
Message-ID: <8ca09aa7-7ab2-4ce2-8484-ebb2aa0e8cde@linuxfoundation.org>
Date: Mon, 6 Jul 2026 08:51:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/120] 7.1.3-rc1 review
To: Peter Schneider <pschneider1968@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
 <0585b5ab-f9a1-4922-b2f4-167d0402758c@linuxfoundation.org>
 <075e465d-bd07-4fd9-8641-30066e966d07@googlemail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <075e465d-bd07-4fd9-8641-30066e966d07@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/2/26 17:12, Peter Schneider wrote:
> Am 02.07.2026 um 19:44 schrieb Shuah Khan:
>> On 7/2/26 10:19, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 7.1.3 release.
>>> There are 120 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>     https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.3-rc1.gz
>>
>> I am seeing 404 on this link. Maybe I will it more time for it to show up on
>> kernel.org
>>
>> Same with 6.18 link - haven't tried the others.
>>
>> thanks,
>> -- Shuah
> 
> LWN has the story that there was a mirroring issue due to a misconfiguration which led to the deletion of everything under /pub on the public mirrors only, and that Konstantin is working on restoring everything.
> 
> https://lwn.net/Articles/1081015/
> 
> This is the ticket status at Linux Foundation:
> 
> https://status.linuxfoundation.org/incidents/3y1k8b4ky71t
> 

Thank you.

-- Shuah
