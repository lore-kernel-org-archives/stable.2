Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269F3AD52D
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589087; cv=none; b=psnPsW6JMudj3HEKF7NmTrKnzvRgV+Wj7eqdjvUsxHGijdB142VqPvIPL6J+sEwt8hVCHQWcpkgTTA3FjQl09tLYMu3FOYxoEi2B3ZQroBqo8PaG0km660Us+SARvibCaGKH4VnM+ioaa1uRAE87FI6O7KZaqw+wRn3mr8gSOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589087; c=relaxed/simple;
	bh=CyRGUnL/glmmjF33KlopSetVt16IiT5LwvVSGVv4SJI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sGdLXKNhjD4Y8Kmrp9Yb16SOjIvhHktSm65rZIkiv7uyUEWNkE6fcjQDIAsKC4ZwjfWxV8VeRl3fmG02YOcdkFIwoD4xrSvJcn4PR83NvPw5+1oyn58M1fv8f3cvGPv01eNhNTJ2aRoCeeRiY3LpB4SE/52WZhABzs0q26qSQ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c79Fuzju; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c79Fuzju"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c1950518so4307385e9.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783589085; x=1784193885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MKZMe0/wt8dPAc36BMO9qSsLEtJCrLevE84kprfUPEc=;
        b=c79FuzjudHErQxgIlmlbXJKzql0xP1ELb82YTaJTp8QXU4WVUOys3UDy4VNNio2DQq
         AXr8oGxtzpSJIsS89cjZ4isjLdH2RtgyvTZ29S+HbGcFAiP+Oe38FKe6bKr37lfqyYy+
         cgxblxlImGETQ/rOudJrmCRATSdBJRV0NMwP1AGOctHgodPL7DquXfP0vBfqZqbZXwX7
         5JTT7NfONOT0C4WLlsXocqEx+BLb5OAh107+rFchpPBEVMmCi5mxvpY3xC1QBnuXO0mA
         BQ1v91t9nsiqQJ8ZoGZA/hlK2xY2VL7+BM7vM2fMKrzoe33g84n0rPSD3OIcgen2DiB8
         Wnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783589085; x=1784193885;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKZMe0/wt8dPAc36BMO9qSsLEtJCrLevE84kprfUPEc=;
        b=VWCzmyPC2jxhYrGv8rudZ7mjSSJJFqkD/TN71D+fCeZjdeqSvGCcunRW7lVnaE6fP0
         DqJmYfVeiIZIM5c/d+lMwKDC9bwumKF1f7dExEuF7ElqA9rMqUGjiuuic072Wxbt3UGl
         PEAsvknD+6/EdNoBrQWZjSAKLrYOABL2ru5KrMHHnwfXxne8ZzDQOYdVOOkVsDA6uAGC
         tGphp+d5yr6ya4z7QeoD895Jcc9pAPZLXEPkPjqqZ9exhyhSDX+BR16gsEsykJmg1MhI
         +NLObXm5+CevMnQikyHr/tu5x/+j0LvgkKyth9keON1j/5Hd213q9NuoqkFejPHiwtAH
         XN3g==
X-Forwarded-Encrypted: i=1; AHgh+Ro/CjQpCWZRIvrteby8OifPCUzC30jFNhGEuSyXGEB/N8gRedKgMS04HMe01ex8WXuHUTc4oMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+yHNwewM+CJRUQ9SDFhMFaADfyaioNAzHtaeDmTXwdFfwy3U
	0gfUgpOonzHEaaFT9fppz7CbU2BkjdY+q22RoHjDFVfH0La92ugiOVNG
X-Gm-Gg: AfdE7clad+KaORwc+4hCxZI5Tl+fmLfvqlaav+/XOiYbOr+EQBJnjlgix56JOjy8x1N
	0jtI0CewXGkxMX80cYkqKWcxMnIEQIpVrXNwIQLsaJ0pnupDM/XrtE4YwEROY3zJiQy1kcK3BOr
	NVdjjiFhoN3qxnocwpQCJVy82WfN4DZy3l2cFUlHjYRQeZFhv8aH3ZUx8MN1vi/PVS0FKibkZ/x
	aoSXpxkx8C46wUt5zWq4xRgwwAk2SytDmpEMnU0plwB/KrDWj8XicNug/mvPlIP/HTI7hqdiSyc
	SiXPNX5aQiVU39cWkBx70H2cdkQ8TORTxwh2Sq7zxIfUonDvzAY7wB5YFrwHoIUS7jOzw1HNlOg
	HSGAMlPOZGx/YNf0xqKMhm/mlMlGDqtuPLmJDEtNTWCh3x3uujbMYA3atSHCOJD7rD3rRQPgzac
	6bfC1msBhaLtn7CEIkNvBuA+uegqyLFqY1q4FcepJt6mR/STVjq+dAfyHqYk0now==
X-Received: by 2002:a05:600c:8885:b0:492:7025:13fd with SMTP id 5b1f17b1804b1-493ec32a1a9mr14033375e9.0.1783589084775;
        Thu, 09 Jul 2026 02:24:44 -0700 (PDT)
Received: from [192.168.0.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e580cc6asm101789795e9.1.2026.07.09.02.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:24:43 -0700 (PDT)
Message-ID: <5110c357-45db-4a5b-9498-5f5607d0b37c@gmail.com>
Date: Thu, 9 Jul 2026 11:24:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.15 00/95] 5.15.211-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260702155109.196223802@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260702155109.196223802@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/2/2026 6:19 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.211 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.211-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

