Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD2391E4E
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590325; cv=none; b=IS171sreIVSIykPM1f/5H/SigxcUBEEP0obnAxphb3wNVfIbG9aog0NOwKgOES7AVaZcv0fxY7QDUJfzTv3Mtc7bTM7mSAi9Pqa4fU//bX8the4fGwQZBEl5plE5zdLuU64A823y7k9STOEI8ErncVY6pq7emkbpRaG/VF4opkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590325; c=relaxed/simple;
	bh=DSolsTJGzHgc/OGPLnKXWHYDHDOGwzlUJFKfR8ob8ns=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=e8y28nEb1+HJFQpgXu2fEGbemvVup8BtNgPRdtFmxZhkCA5MBgbS9jRGkSOHkRHMiOB52muH/2EF4b5fl8t6xJGPgIcIX1nGbGIqTX2QNhwBB1oiYt1uJ0YlZxZ3WFsiW08u35Pwd7YKtpry+j3Y0NMIpyJiSEIWwgp3a46gxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcm/KU9U; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcm/KU9U"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b7612475so14273265e9.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 02:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590321; x=1784195121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tFZF/5PoasW+xKTZ1VUPfW3HZ74KzO/QxbfEs8dmJ+k=;
        b=qcm/KU9UE+VOTOcF7wvldStiEGVtg9x/CX4MhNRhwv4MI2TfvHKcL7d0fC5sSW0s84
         ho6opbIYA3I1w6z5c3Xfgw5e4e545uM8PIB+hUhYmxYRDZ1AKaX2nOuSqIi+mQE5uOjk
         4vwf66JaWcz1AQocC1OmRsQ68LzXwsXWgD8s+cfv9wYicou0v6LVftV0nHnzDxGl/Vk5
         0jUGZQtEBtmM+6zNdaLETWz/aUcQbttZJwMYgxRlYIrUR3zC0ixJd+V2EB5qyOEP7m7K
         xtw9BIGPzXP5jFSX0iVV/JvuGlyD6qB6ROCiEi5xY+pKVgpyPB1yPidseMQFFSbUQwuw
         M4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590321; x=1784195121;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tFZF/5PoasW+xKTZ1VUPfW3HZ74KzO/QxbfEs8dmJ+k=;
        b=RRWkvWttcVB5x6TWUci5Ezg3bcmB9IlBcLjhRn8tGrJpeR0O9ZXRHl0ljN1J41aEdG
         sc2d2rpAomyfFclZbVWmqCDeQvBbHpfJZLNFSXDFDhNZW3u0b6ceaHYiXALJ8dK47PE1
         LKoqzx9NbUxGlaG1o/7Fv1sLlGhI7dRX9emAzFLOMIIK37tz2jRwPAm6BPmYq0dtnI4p
         8uFykh1dyAEkEpCm4VBoSk3XNRgXsXTQQJ1CqYs/2HkRUu7YOPMqCM0uIjzu8KAoeHyv
         Z4fQJIEH3VnS6KF4bfe+MI0wpkvSCLTO69iI8K4S9HRMGj/lKGNEzXUDuQqmsUMpt7/G
         z5rA==
X-Forwarded-Encrypted: i=1; AHgh+RpBlXAvSJCQS7A/DsDSHobNm/AD2H/VfEt51i8duzbkJALDveXe8IYIuOsEoH4LWzpJ0JNIBy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEot1xS1yLy37WhRirTMBxWHzUSo8Prp9RFjES9v9vgk8AoqQ
	Nz8jYQBXYrWg7OTIVmf0PNrHhvZ7YI6dM0VxMrePUYe+86fjMsRh1Bgd
X-Gm-Gg: AfdE7cmq0VMfRZLHHmY4uP8uBuv2qN7GlN+Jukw/f5/zdB5wwMN/u+n2Khek07+7p5E
	8tJBQRwsqXxroiRFXUbb5UqlKtKN85EErhOiovcTrHE/JJjmd+c6z4X/kqV/x2AFPkbG/veIQe4
	pnO3AEDJ5pEtofeOt/TzdD8EgOD6jk5xI1+FJ/2XMx48u5V25WbfqGu5P4kUtLS7/DLhQ+VxUp4
	HAb5oG/nfMg5yry1w6ozRuxU34PgpuAf7ukfa3w+Ox33TgzDKm7l2WRJRoFJKqWcWh5GZ+Hl6XY
	ICI1ZDuNceWTM1xAuzx/EpsUC8jmAZyngrKDvJlGi/dEpijtvq/F9pxl4/YzRmSXbErf1Jk9Uq5
	s/vD2vSR4j4GqewlKuoF3biPvzk+eDXPqH17sEtKmAeeSvipYXg2hULG31L0lquAj3GObzl+4To
	buIXTFLArFqlf1WCRJV6/Z/SE+j2LY7/ULVa8vAAbXhX7HA0iQW4Yrsvy0++ulDhlCjLbyGDVP
X-Received: by 2002:a05:600d:6454:20b0:493:cc01:807b with SMTP id 5b1f17b1804b1-493e68815cbmr47157235e9.38.1783590321156;
        Thu, 09 Jul 2026 02:45:21 -0700 (PDT)
Received: from [192.168.0.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e89eac4csm50367185e9.0.2026.07.09.02.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:45:19 -0700 (PDT)
Message-ID: <34b7e26f-df63-4523-b4d2-5de13c192a8c@gmail.com>
Date: Thu, 9 Jul 2026 11:45:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.6 000/175] 6.6.144-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260702155115.766838875@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/2/2026 6:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.144 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.144-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, same build failure 
as 6.1 for MIPS:

arch/mips/kernel/smp.c: In function 'stop_this_cpu':
arch/mips/kernel/smp.c:396:2: error: implicit declaration of function 
'rcutree_report_cpu_dead'; did you mean 'rcutree_prepare_cpu'? 
[-Werror=implicit-function-declaration]
   rcutree_report_cpu_dead();
   ^~~~~~~~~~~~~~~~~~~~~~~
   rcutree_prepare_cpu


Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

