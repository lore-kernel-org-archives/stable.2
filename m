Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B0D52ED31
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556247; cv=none; b=SYWN0P1cO+ORHF/omrdZRDIcCoc6i2M/dYYXFdM/g5wGvSsaUMcpzAN/EdK2UjI0I/GGNEn0YKQksUhSiho8v7TceqhQwl3T5CVxrh3JDG6Adx5hu4opofhz8Y06DnsCb3oUJpS/rsAWntuvKyJzQYV3lUZ1V3nufDYomBBVBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556247; c=relaxed/simple;
	bh=AIzN88yObhLJ7zH0xiBeiavZN8KhADkVakFvDUmpWMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwQs5klUqeOq4LVfTsfFyEYM+nzawFkKWWH5tAJWDQUYwyDS0TgLgvX7RtHr1vS4o9B5M4YaZD89YN30QDcvFx+e/snkt4GZQ91DM2SzHno+3HS7+fANPexHU5S//HxNcw5Z6RjmDT7t3FxPOpRTOFE7DTyBGTiXbBgRAFR+k7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JXO9wsxp; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JXO9wsxp"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b1a1a442c1so962402eaf.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 14:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788556241; x=1789161041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZQ3f33CzKvQ9e9UVdtviBIiGT2nRTtAw71SUlTm2xw=;
        b=JXO9wsxp4fbZlJSu6V6k8HKdWVc2vK/PkMYCre+zETrnBZI5e5SUo2eYV/7G+hdGAG
         Lrf1aAp/DBA/9RTF7SrNboYCafDzyORLo0aJKOeoWaqUYa4Ckz2DSTjKw9BXAGadYobQ
         qLMmEC8jhPMMoYfwDUijLOsX59gciuG6l/kxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556241; x=1789161041;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zZQ3f33CzKvQ9e9UVdtviBIiGT2nRTtAw71SUlTm2xw=;
        b=h/PHJFbzUGWOl5h+MUf8AdOoZeWhCdelNrsJMZ9JXSdxV0u/Oo/YLwb1WGOgq1nFkm
         A0oXCGpfWDdJA+KuMtlS3i0/+LCgEMXKEe/VucGOxxv7rBvnyy5NSKLG5NXfRehgzBmL
         31F4V8tU7aPAsFmEMeMzmKr5lSoQsKtyL5yw/v1j3U84eqo2peRC42WmlmgPTRTlHiU5
         by+MS69nmg8ec9N1LN75YYJUuUTk3H8Fuo+OQTeSmTXOJy5EnP/yLq1tbVx0R9mzVLW6
         eZokFhDIhH8SbW4Exa5eEYPgKz8SU1p9E2MFX49tRP1tPbIS+QqoZIiEEUFWS75DdXxQ
         5OfA==
X-Forwarded-Encrypted: i=1; AKwUvBwiviKT6LtrFA6GTdIFZ7Tt7xQ/vxagOLjQ+WS3t4bV/d+SEPywNX4lxZjTU0/OxyVV8qpcO50=@vger.kernel.org
X-Gm-Message-State: AFuF++mpODcqOUgPPs8AK1sTrpiKB65mCA6r7ScbOoUrLf6uCnphygkh
	SxG1xHSJejVK6a4D9vOHyhV4gGN1f8d7bTviEgTPqwW2IVv6xLF25jMHdA7+EsM7xQU=
X-Gm-Gg: AYBFou2bzy2aQubYgERbwDsfYiS1zSzBVSVg4wcfRiDN8opM8wWGvC9s8yn3BxSyn9m
	YwbmcFqmbE9pzGLvpyD/ukCeio6fNCwhFoNFb0yNA5UW363zIJGbILJjGP3NWPzjAsV554acKe6
	LYtMs58oWGWOD7WsLLvDo0b/Cj3qht+UcOa+owAx5szaDrBKu3TS8CgmqE3qnpJhrvc3gtto/fv
	JLEJZhDqJcLku36ofymcARRmZTs1tOdFvbiUiJ3JwUrNUoAOPjYp0HvfSP7vp29BTp5a+phzKA1
	6+U+xZb6aiKAxMewSE6aIostDVfuSuo0lLaT9FbAEiQyuBM6QP/5qN+1aKI/NS6og9D3vKVXXTg
	rFHeRskRb11yjYx0V7lopkVRBMPn6pbyuGgIZqRGrrvKe3EJdSoD90/V5MVJIOj2mD4hIbP/MFS
	RQLMVkltMI108Cup2XkOmoRLOtmkwj2ZYM5J2/NQV27Z/3jG1w+4ALTuBxlx+Zk1AT4GYO
X-Received: by 2002:a05:6820:168f:b0:6b0:4199:3cc4 with SMTP id 006d021491bc7-6b6fea84e5dmr6631267eaf.27.1788556241315;
        Fri, 04 Sep 2026 14:10:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dcb85a61sm4575639eaf.8.2026.09.04.14.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:10:40 -0700 (PDT)
Message-ID: <6372cf4c-3bb7-48c9-81c5-cb828a1b2bf0@linuxfoundation.org>
Date: Fri, 4 Sep 2026 15:10:36 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/552] 6.18.50-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260904045747.813364717@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260904045747.813364717@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/26 22:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.50 release.
> There are 552 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 06 Sep 2026 04:56:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.50-rc1.gz
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

