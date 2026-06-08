Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03327346FB5
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917289; cv=none; b=DAw1iIFEAAnmEE3Jge8Vj2KqqYTENpLq6UMiaKTHq15kzHG0d3FbtxiNDWNvmfwbng8WFG6veI43IfE4/+Ys1Xhd1uxlLw+fP9MY5v9J+vWKRD9Kq48ULsYDipxFFpYQSbGwAonbQ2jqnrXNkPBW3aIIJOXAIxTYMnn2KdMiUmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917289; c=relaxed/simple;
	bh=JCnhFBbhjyM9ZrSTljHLt/ThXEo19Bb1KFb5dj2QrHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPwePi61Il15sRU7ClJ/0WmlV7A/W2hRi6vaeqM4rMvW0Ch0/9Swf0eEHCquAPCqD+ztg0IOmOypXzeHckrX4DDlLJ8BLrgakNqx+NnsUAR10JQbcvdpCIU2WUjYnmErqWmDN7IkUFwoZYeRt4ZqOT2SMqSvjkKEayV1tVYenmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jorx3MWa; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jorx3MWa"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so1071349a12.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 04:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780917286; x=1781522086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AlrDLQ7/+KQQkyc0QSWiYFjNtmvk7yv1uaLVnyP4as8=;
        b=Jorx3MWarcDiA8SkiIcE5Yi0woDCegYd+FvI70eqqrnVxnSKyWkXZcymA9T6Ml9nGD
         ZRsIJNVQbIeQcOYax6CnCTY/V/+xJ1QeKavpfd8OltmjPdU6dCzWEv+IK86cNpcJWdTo
         vRBSHSMhE+1vnOc/hP4xhSWUY3IKCPLkvJxXR9aty9KgxoyLYYPh4Ippmj1fx8AOws3J
         4uqh76G1KmFCuvDgAoI4K9IqzXDOweiDtrZBYsF7ym9Lx031Zzygq+zwtEEbpVMY3Vet
         Vq8finXCQYofFBO0MNaH5GVVuUaynLzekFXLdhWhmDDqfoCzVXFZ9/oVsNz9zq14nkZ9
         bOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780917286; x=1781522086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlrDLQ7/+KQQkyc0QSWiYFjNtmvk7yv1uaLVnyP4as8=;
        b=kZF4IAr6jBoVNaAipzVnccq0We9moI3+oyCDmOufMA1i7KzJc+/25MyJR8LLzhotW/
         Pc7tyFipezPlZw+S22qFTIyevxtwAr/PnwwZP9yS0m7YKM6uC2hA0/KRRtIVVnLGT4NT
         rrn5swH9xpI6jXTQM1IpMmXl1u8dU8TQsjWVNarFLwnddRKb+mjaaqz5y8nRfl9/1tFL
         h44EXPuTfRo0Wsk16vs8mfQ8EI9h7+aGJO5ceAV5XXFbxVi8HE1J5BnNw27/cAFTGFWz
         rh8ECjUxgQTcT3gsepZTtOP/BjO3pzC9+WSsiLVkJs1v+0RSNbCpq2tHjD3gsi1GB20p
         04TQ==
X-Forwarded-Encrypted: i=1; AFNElJ98cDkFytg7szzptGJQnIIMjaN3CEa33dHj0jfZXNogsatmmWudXlEN0i7iHQx9MJw9Cav4T/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YySu5saL+9btW2dm6+dz9MwKmCyv7el/9Gw8D7SVEyA6DA754wr
	QyUhVQCTbq/REmYNde0dCbT40kljIn4sPBKF9630n+oeyPSEPRop9n1d
X-Gm-Gg: Acq92OELEbS3qGYaxlvbchQpXW+tjJG2rv3IKx7LvZdwCz1qxnfLdyIrsu19GCM74rW
	rvqodF1jmat/PbGpIdQ4PUMIlJ5JRclQEObfQ0Xv2V96S9FV0daHS9EXMvsC/oG57iGLkKrFRzl
	Aw92pQnw0IM0wszW2RUpM/20yfQMKgVSBdZF95MT0plrCntyCoweXiW39IvTGNNmxTZ1/CFcU4W
	wzAxlTIPBvi127ZsSMJDbg5ER9E8cjOG55Lb6d+bpxl1B51g+eK/1P/VCAxcc9sjzdJCceyaFGs
	HPOoqVxwLiHg7FACQqv0p1Bt/V23OjJ4mn6t/x+cWq470jCQAueTb9k9jGy1RyArmDchBXBctac
	JIcu4uXYNUSxw4NjRAhXOlr3XJ2kRBF/0Ws0MkkTRtnni6ZjYAAVAjjMi3u/4UoIIex+a9DDKpS
	zVmOvqfaGXuGEig30Y4yXZg3c4ombg9O4gNLVrIvJ8d27tGLLtcJswKHolppADufMMQiGnhEBX1
	LkRk3B6w6okpQYbE8KoUg==
X-Received: by 2002:a05:6402:2808:b0:68b:f026:f382 with SMTP id 4fb4d7f45d1cf-68fa4c00509mr7207707a12.2.1780917286260;
        Mon, 08 Jun 2026 04:14:46 -0700 (PDT)
Received: from [192.168.0.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e650287d9sm7167414a12.12.2026.06.08.04.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 04:14:45 -0700 (PDT)
Message-ID: <6faf06f5-541d-483d-a7d9-090fb0299154@gmail.com>
Date: Mon, 8 Jun 2026 04:14:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 000/332] 7.0.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260607095728.031258202@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/7/2026 2:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.12 release.
> There are 332 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Jun 2026 09:56:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
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

