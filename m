Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792453655;
	b=1ffsKPSjd5sw5AfZyGzN3j6Ty2H0RW5L5xYqHxbnSIR8b5k+OAqtrW5gOLdK6Dhg/kr0
	 DfbSoSAqhTbmQsovbK4JgjzOUoaLL+JzzNNmvaq748UJFKe8mH5zpGXg4/KTgRulJfNO+
	 jU2JNM4MHVmoWDYXxRbXqfaCP+7ACBk9MF2HkBUv4iOqBoYuZgZuL7BlZXLzT5tU+pJna
	 3KvUO4BK6g22lwhCt6qJGFUD5ZOFKnDbXBxPTQ83Nf/2qvrFAEOWBfAMGhJLad7jmGOz9
	 PKlQ6fukJUmkH4NZ+ILANOKZn9hsQ9/r0nO2mFUs2jR4sbVo7NTX+KUcIyhRi4EFurQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lLQd+nNRjjQK1gHuHRMSTNd9Ep3awT51rCIPEqdoOwU=;
	b=lL8Ity9JiYjhNd/auVfAjwmbEfwWoOSFavswmc3TAYSJyhFxbrk7xydFjgih0R2rvzTm
	 PxKSEwjquRTGKBpUwkL/WnDGM+n6FpRlvUkJXXFlU0GYGv6FbZJ1ClcO0uXbofkTXQTo6
	 TP8cBTl/shbD6V1T6hejCBN5RFyKS/Ve+ypHy1H9lxNwByaLxIPCC6ng3grkP7dJhNqHw
	 5ADaTrK6F9KCg3dB/qMmAhq7+vv8xHxu8EiZ7PMau7xgbkXzMuvkiimjcBPp07O/YnMHK
	 Rxa4zVh+tuxBp0U/R8+DzS5MxjZOTRbdnVYGrWOZMumZoWk50XHCojL50zi0WQjzF5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b="Y/jD3FPy";
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FB8606A319
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 23:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06FB8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Y/jD3FPy
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43bf9548df4so2462058fac.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 16:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792453653; x=1793058453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lLQd+nNRjjQK1gHuHRMSTNd9Ep3awT51rCIPEqdoOwU=;
        b=Y/jD3FPylWjjHvpYVkAntC5BIW5CE/zvq0KO48i+MtJnE0jvRu3R3f8A4uY4GEcc1G
         9T1sggxqOhZXHC+eivG8C0X3Dz3OEvTLRlCC5ZSuT0Ic2+hAOPex4akbpX/mQDVc8lI4
         u7g/fbKZp0sxbkcP2bxtzMMhgV6TIqFuEGV9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792453653; x=1793058453;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lLQd+nNRjjQK1gHuHRMSTNd9Ep3awT51rCIPEqdoOwU=;
        b=U/oWOVwvUotj2sQO1chMsF1micZ8mXQpu4IpEBLdDm0smiFD5SyZJGtipCZzEAUj9+
         qJuNaK9Vre/CFKt8YIFlmgnevW3QeLgic7argSqSkY0YRsWUlNK9w3z+6M2iVLcK7yGr
         6VelXFIOSY2LOVX6bPtolvXFKj/7QsV+OTxU7cqmg1VoqfKn97kiVXwGweXwiaVZ+PUo
         +d4cQOHX/yPDT95YOIbPJCTGDQ/dXwOftYF1uSGyPFlaTrFSG0LvQf6vIBdypmm6y8Bu
         MzanGi218+mrh4+rb3nCj9yTbeDE5jerlLCY81PhZJdSmZQOADTVuKzclNeOAy7CKoqH
         S7ug==
X-Forwarded-Encrypted: i=1; AKwUvBxVAbjBr17M4e8eVdj6HTn8dAiNcIQyulxV/XSfB46qPG2ebaIop5v0VENxV1o8DB2S8oyazOI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKJc1+Vnk3YdzNt4dKg26FGVhwYyNTPtcSq2TXlVRrjgQDruaj
	0yrKX+XwFv4VN0YcPL7UVeioz+8JASXeREcdG2y0tAGUdpvHrCuiJFCB5ymMnHI95xA=
X-Gm-Gg: AYBFou1y7ti66S/u7apYaf4iYcESV0CaqQ8w8heZU+CSKlVBbWY2qXsu6pCBvNUbI+v
	Ng12dsQHQnfcOSJKMo5ASyucU83augLq336lL3Zq0sDlabIVnuz9rsQjqpY8H9X5L3ISVrTnPg9
	/6Vxl04NqnIIIIAE8G9xVbhKwJLDxoIkpbBxJcjWCuhHHYInzcB+zGDcheeZ5U92rSoU0YCNJR/
	UFftFqzTj/P8d/csvBLVaZB6OipvC3Tz9GmDc6kgCFEhdJLm0hnRlB7gVvxdnEzulC+9AySuANX
	h2bYkTWLw/U/MrralzpaZFRdfQYv0QYKvEKDsixlf66JXYrXR09ssKK0orEOqQ8yudQtgAThFvK
	q29+YmnvTOkww5mDqiDYjnlbpqOLXRsY31bzT/30OgpmjupWSaYnU05lyxMXmJU5+jAtx6bjF7k
	T2PMbFDCGay9icuEL4VvTNSaSdObqrlnc9fT7aFuYOS0s2qEM61/7TixGbngMz5rbno43u8NFc3
	XqaFAifjHNT2Hay3JBXg5qWEQ9P2SMWm+s4VpC5G6KG1esx2oTyWiAi1ACIrraIAEzpwRvlWo9b
	7CYrZGT4W4k=
X-Received: by 2002:a05:6870:6b95:b0:4a2:4c6c:c9d5 with SMTP id 586e51a60fabf-4a7575d32dcmr6867719fac.7.1792453652907;
        Mon, 19 Oct 2026 16:47:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b2dc57dsm9724967fac.1.2026.10.19.16.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 16:47:32 -0700 (PDT)
Message-ID: <3f8954f1-7a06-4901-add5-fe81b3e0ae8f@linuxfoundation.org>
Date: Mon, 19 Oct 2026 17:47:27 -0600
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
Subject: Re: [PATCH 6.18 00/52] 6.18.58-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261017155104.830766652@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261017155104.830766652@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/26 09:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.58 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 19 Oct 2026 15:50:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.58-rc1.gz
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
