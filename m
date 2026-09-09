Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720F472558
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992591; cv=none; b=TsC2L4dTGCjn4Ou5iZ5oVkDEjoT1hTfhXoiW/Jjz3y3+LLOaspuVjRfcoIZtjoBCSx/VuBbkU2Al1KwWkoSDsJ7BHQIDSoz/6TCsshrCJ82GKyAScDKshIqeD5y4V7QxAzgUAW09ARiPPAjq/pGl5Jya8kiOABD+R1xCfkxZvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992591; c=relaxed/simple;
	bh=EE93P9JaUK/IWvFQ7DBmgLnl1nyw464WW68C5E/9MDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYl607lj07wrEV3xb3NBZtSuo47R1YNYv1vKEB84NEBRRdHuUXWl8Cdqf96kRpDxffJ4zZwlR6vJvV48EiHjW5vy0dcuKz4q/bHm7ldEFykAj8HF9Gsi7tvMx6y2vzX54+aduh1Ohpgl7HEq88c63LRv50TCHYmpHhGfV5dHoMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QcNuPi9n; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QcNuPi9n"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso3866510a34.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 15:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788992586; x=1789597386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+UF9QqPpTGZ3kEfYDBVlbL9sc6DciTd1OvmLrZ0VC4=;
        b=QcNuPi9ngw4Irf9ZCsKnuW6eIi3rDctWzJNadjDfevNk9mGtasgX/WqpNenp9LajVi
         ypf15a/xw8omEzOJWUeuX1KqJHoCqXHrt7GYaWDR+KlCV3tAHPkgU2rJQ5y1aN2j0ZEx
         iM12GV0rv/Bfxri+PvJjQ7hpQNlcmUqHD8n0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992586; x=1789597386;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P+UF9QqPpTGZ3kEfYDBVlbL9sc6DciTd1OvmLrZ0VC4=;
        b=YWbYApyydXNHR9SJPfb8uZcr4qjfeOERZYlX27yDzneEWTbWOfjtSO0rpYl30nuD3j
         pu7TJuFx51i9MpwMydg2AeUlzGz/CiphOgfbH5CUhuoGXus9qceCzOKI6awBD7h0Qnnw
         zthLntlnLBaey/BcsSVtSeKKhvaSGCl2NB2aHtozk4WLUlesgXDuTWxdjibxQjJ0ZBNu
         b6UMVNQ/5rIOLOla9Sy109Yaxr2hmen/YASCYuFWagxuyBK30/KClIC3SfSfKCWt15GQ
         15DDehTGQmcU4/F26VjMbV3Zkl4rVQqSDe/bDlqBU7gQe23uwcpba6GT7U11pLEp0/mC
         UfRQ==
X-Forwarded-Encrypted: i=1; AKwUvByp69BLg7NpyqvWnJa/lA8/pdGiZLNZf9X/HdqxCNTWbHCN0KwbQPEivDYzCnedL0//3vSg/dg=@vger.kernel.org
X-Gm-Message-State: AFuF++k1aQXM7SYOchEj/AHsKa6zC3iMNDP26QPUag/iDVBdl8uPX9qB
	f9tBMi6P8JMuyvnVCs9nmeKhbolDqODM/9PZeM3FUFbGtTtG0VP7fb/+hB5Srvhva2A=
X-Gm-Gg: AYBFou2yvNdmM+4P4/xXmTiUgvgpUAi0zHJICIlJ4DcYONEqqwmc+J61r5v6HcdsHux
	BjCZZjVpSjIWa3BWYFpH9fQb1bcjC66spodvSD9+hisrUMjbiWqgMnBVYNejYZPZwJ8aEnryF6g
	7Xmfb7HJA+bnPVwv92wXjGXN2BRStHo50oiM5hh5BgtODCi2m+3tnmLZg/o9pzR+irz2Nh1Houm
	4wkHsxgdL7IIdJrOmDgi3XaBWD6oRuu1pxou9CeMFMEWWU6BD8/dSeEPbTTA9UDRoGk/m0IUy+l
	KcpRjS4FTDv1Ij1L4sFZTLRSpC3H/BRYvCsWqzhGH02ckw6TSrJeJLigY7zn4UDIJSZLY21yCsy
	0i++VCfu/8LF9U76bwObndPbqrc7gyAc7zhpxTzDwvFuWWtxvIf6xsESeZq9zN2qHNVHLY8G804
	zRAlljwc/dqX+sP2DN9hvMc6qEe4Jez0QVhlprQ2tYKlOP40tF4mSWYJQ9JmEySoi5rVFloVfdK
	40ry2R9
X-Received: by 2002:a05:6830:3989:b0:7e6:d54e:8fe3 with SMTP id 46e09a7af769-7fa1f92c50dmr23754536a34.9.1788992586339;
        Wed, 09 Sep 2026 15:23:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6794e22sm17892719a34.7.2026.09.09.15.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 15:23:04 -0700 (PDT)
Message-ID: <a312900c-9de7-40b9-8687-82ecd18bd563@linuxfoundation.org>
Date: Wed, 9 Sep 2026 16:23:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/556] 7.2.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260909134230.441546314@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260909134230.441546314@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 07:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.5 release.
> There are 556 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Sep 2026 13:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.5-rc1.gz
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
