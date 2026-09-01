Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A03392807
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281107; cv=none; b=R/W8GE97qVfYvjai7GRpDQNC/EVf910AnY2ybNKfGva+FlZGVQRr+d2hJACMJI43NaifPjBxSSMWZ7zDUBuVw7dmmoMEMeVU3WHCSHbLIDiLpe2EAmhgwocMh0zW5Kibpa0xnkrr4uc1H20TXWofhWh8102y8P2jwBCibu9lQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281107; c=relaxed/simple;
	bh=+cWilfnQ/mR+0hb4VBv4GItJT+g95OWow+vJ1CeRz9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUqIcXHDay2+jUa+1V5gDGrVym/KL8LBgliknnDmTzrXqwDZzdc4LkbzfRZssVRWIITLkR2KSIjdSTlhdFltvWWT0R7MkNn2FLYlg3UosPJsgFCVp2YyJuSrYP1lns6RjTmT4XrNzHmDbYDHhu4q5DnLkeVYcZJCva2SYNkGxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KnNOV/4s; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnNOV/4s"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-46a3a8001cfso45176fac.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788281105; x=1788885905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1KdrPp5VH0W2M2cwjXR0uBfZIVa68tdnukc7QI0Ndt0=;
        b=KnNOV/4sM3Z0U/Q2fYYTLXQQyF/HI5iBZoZuoa5t5uYdCw77rpt6foOff+hKWyHB1S
         coogfdC4rUY+coEvdyFtNPMlVRYKYYSftbVuQ+QzMZ7/FxtygZjJwgv8kV/UocBA8YaI
         PcXn9UE+W7EwiyXxEc+5bobRkKM3OiZaN/X9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281105; x=1788885905;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1KdrPp5VH0W2M2cwjXR0uBfZIVa68tdnukc7QI0Ndt0=;
        b=YfJr4jitUemeLrPuo8Wc8tPgVJdJPpmjoGQM5LIRct/LUc/PGbkApxUzRVYhdoiQSG
         b/27JZK/kxRk77RgaNYdNkzwtS5ZNKtZsWTdkGCHXJbxHLmg4lMCn4TA6gbCovnPYkiy
         dXmmwE0DjbExd+GemVCc2OPTQgQvo+gkQu9v4Xt9J83XOYZGZkLHLAtM9YemCr1HMkad
         5uPakMrxObXoqiQk7ECmJyC6J59SYuNV/K+MG8mjGlO3VJ++CrHQ50FE9eEkRY4TCBJt
         cyaHCauqFQXJI/T6E4fNIOSAaOhtydbjwtLhiqKHm+39F9QPFg8hg6HhhL5qx8/K3COz
         zpiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwPO0IW0D1m9OgN9ce1td6QCCYrOkIhKiUoRp4wm09GXIeMUs4Mfz0ciNK7f5KazLHT71MyUU=@vger.kernel.org
X-Gm-Message-State: AFuF++mjkvEPz8QSyIFlWU2Rcsm+8HS7yvW0THGjnnhYy5KtspWFeIYD
	/1u/R+EheCe1TVCshUAeNvd2yLmcCR0EB6UEiNGks0MMNKOVEQArnwjV42kiHNz6qjo=
X-Gm-Gg: AR+sD11kpMEDENqm83RcSnhyEfZ9ogRw4LD//Rb85JUcYIKQBjvuud/R5+1yI7R5yz2
	+UTmcoGbeJOllslrfdOTHg+uG7kMNrJ7/85P7AY5ZeVz/HWbQsMUfQ/pwo/b3/Tk8QvyT6BGUjn
	rBFSWwj87pMMnQeZuu6ztIz4iKMx9XSUls1kiJmR92BeskIHo/Fm6do0i7sUjestkIN65NrUh0W
	iny9ZbxVMwGRCRshV+lzvFYjvjC0CzMqhkG7wb49cVtfFnLt24CT94qzjhXYUfFZF46G4YsxERi
	x8meChInVZmMRJawzh+p5cbRz4389ZMtuaaLcANJHed5nr+woLQrKnrO3yOFhxzaFwyt14aJWnA
	cSMidGKVzEI2jE2T5VMb2ClN7gFzlXro8ZCeFJcbY7WmpTZCZkylmnh+UI+oib2WlitHPn4Yt+s
	ML6g3jcCSkZ2/qy6tVn/JV5dOdGvhRgLh81LgzTX5EECFtKzoPFnGd5zm/zQukBIgoFaVG
X-Received: by 2002:a05:6870:1652:b0:46a:ed7a:e632 with SMTP id 586e51a60fabf-46aed7aeb61mr10900715fac.14.1788281104747;
        Tue, 01 Sep 2026 09:45:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f30cb5a17sm189702fac.8.2026.09.01.09.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 09:45:04 -0700 (PDT)
Message-ID: <304db74d-2a7a-4fb2-afd5-e21489619c83@linuxfoundation.org>
Date: Tue, 1 Sep 2026 10:44:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/83] 6.18.49-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260831133359.207714926@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260831133359.207714926@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.49 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.49-rc1.gz
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
