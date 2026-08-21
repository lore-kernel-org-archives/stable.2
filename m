Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01A3446CA
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323873; cv=none; b=bj8ex8gVaARNq6DAfwHzdEo5SiQ52+5mVW8YGCtv2o24bfEoVoBttmQvbL5idmlI2wpDF4NawlqPXJJBnKpvUvnc97I3HBUQQPVCuK4IPDD4cz3iUjsI9brbRh2QCl8Rl2uTReE7y2j20NbPzWG6b4Xces5ugyVnXEh5BTy21L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323873; c=relaxed/simple;
	bh=CRp27lqDZgOXD4tiLjlZfyzg5q6jxbXWzIW/ojVkc4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5w/nAhEJxIR4OJ+z/jiARXH/+UDXSfYwWGIlxG3/f4cJ3BTCCOBpZKqNT59+JBNqa7tIJv4LN+fMOonlEaDTkHSAq8JgrLx68vbKYLuqKflwtkUnOjy/Z4Chp6ZcVYyjCTD6TEeyT0votmlvhfLGNt/q2vACvkC9PbAPMEmx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GrJvZq5P; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GrJvZq5P"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f432ac553fso998493a34.3
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787323865; x=1787928665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eh/QBlhCo/p3Xy0RDKBNUg2dR1LdfJY2hyz0GHgOcww=;
        b=GrJvZq5P18h1r/4dk922abrAYRGcyqgD3/GfNtJJGgW9R2wkvCIruusYZ8jsRELNLx
         M8Jtdm8tIk6e7UYWdnTOz//4Rhwha8mgNFVNR8H7XysXXSMhApVWkYuH8bBhWcx6tRb3
         QL0n7HQVbglP/VaoFGwWQ4fFNTvsk7YAkSnXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787323865; x=1787928665;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eh/QBlhCo/p3Xy0RDKBNUg2dR1LdfJY2hyz0GHgOcww=;
        b=fSoY3d/2hSsbJ76xMOA9pxW3+0tFfqsrvCB/hraekqs0jqyQ+PzCtE0MbTy/TtFCRA
         Rv5uNiUzkiLg/zNyV7YgTKl/f13729bA80QpuMbFHyHTiihq4l0XZUaQXtGsFyR6ejP8
         wRe67c8YVkO+hETrOIx6gm4v/2WseE29w8q68Qg9Hgne4mJwQvfQpi6oXWoVrm5Sqbs9
         5zcu9C1Yi/WxnkXvknD3w0M/+r+oi9+ws5Mbyv6CxgzRRW/t6DLi6oA3n3r8hwAGs7KA
         ZvTDIjBq3ZzmgpZMfC+3pEhwBrdhkTagDzd7hPelALTUKSOT5M9bv4OlLxkEbgpeXr3J
         I8aw==
X-Forwarded-Encrypted: i=1; AHgh+RoldfzxQNiZMSpaXAYxzNkVVMo7fYIn0Zab0l3hlBXfCTDh4zjOiE9k5DNYywbPHMr0f+yC1hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwktPC6WVIyzO9Gp7dElm6mmGd8Zeizzq4mG7If0SA5hc5t9Zrp
	R+dellslsTnIa95oR5BHlObo75lJcj0ia2h6A/tfv0ZlM+ItOQxaGD275+w4UQhUCpQ=
X-Gm-Gg: AR+sD11WuXqr01BDgPyQtnnBlhJj2MwfEK19qqta+Pc9Hvxu4W5qmqrx+wOOBlKZnn7
	c0YEjomf6sAlzYIdyYUPEvp0Y6kFQd6Z85JSnFLNompFICH8ZOD2SLXy1Ltk+H0vWQIzRqpNBxJ
	3doPnOOwafpqsW/sW0/pDxxKnmZa3OaKkGiB39phirFM7pcbpAbz3daMvIcvFprnAaSD8KgJJ4J
	IatpUympWM4bfi6DSU1fXGTSIx+sXNxpRj8udZC8f6FYXAh43ANB968f9Vy2AWSEOvEE4ZCYK9R
	2jLZvgwpJDA1PEg+cf+hgrQMxZsADtTVo7RWyHgvU7Gd+KblI8UmEd4huRqXYDOpar0kpBs0W8e
	Thj8ISz9FzkSDHuEGHgsBOcBOL2ikPI6BoR/XI6VpSgRYosSV95pwhOJnBVvPnyOF4ju32pvXdo
	2ztKitJ4qckeMwnZXLK0A5+y9/sANRd4MoHNKiEoQoHTzb50Rj4DPiCBiAkTHT7arKUMEMsQ==
X-Received: by 2002:a05:6830:4996:b0:7dd:9b19:a875 with SMTP id 46e09a7af769-7f4612f17abmr8760480a34.2.1787323865061;
        Fri, 21 Aug 2026 07:51:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe70721sm7528209a34.6.2026.08.21.07.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 07:51:04 -0700 (PDT)
Message-ID: <1cdded16-effa-4ea0-b012-eca77b7fb8b5@linuxfoundation.org>
Date: Fri, 21 Aug 2026 08:50:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/217] 6.18.46-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260820145237.531699751@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260820145237.531699751@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 08:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.46 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.46-rc1.gz
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
