Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794714487;
	b=QZxo2uC/ztuJ3EqHzFtdbDQdZmlgnexDhbhO8cGYJJ8HtMHV1JzictkqfEjuIQQPeolu
	 9ux8qA2vJRqGovR75FjSTtRAhd18z0nL73f3tvbMPu3wiFwPe4ToBtQtysABlFj8DV+Wk
	 Xs7qCOdXb8Q//54t+xHlh1dZavb8mfMldlmsw0x5sKhumMXwt3rlsOWBBgCgAf6YFnhpW
	 0lFPddJaEcBjs70f2c4aJwZdWlhQ3uI7uCr3F3UZyrsI6ThDJ87hsiO9EJmMHcKtX1esF
	 YShBsLl2SswbXJstrPgEZZkfMkcP/BKpwFvQvQfyCTXkWBhfuLXnIaOHYDJgrUWZfcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794714487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=koJgHflpF8SlmhITyVQWyV+LPgkeAJc/hP06L9RsOYI=;
	b=3I9f6esG6mXf4l/N4cTQVNSCsbVTjHgEJDlIdtAiUpLeJ4TAyBQVji/afusYNICabeyG
	 UdGl+mLtfmB/TEtaivGMR2is6gYTnzd0Olfgup+Vv+GBJwCEwSEx9lKkpALQV0VG5tIvC
	 KoEwtB3i44OcocqxwWpU6wSfP80LPh3cDyB3GTL0kFAX8Iw73EIMCoFYCtnu5e6IrIDX4
	 9751EmgSib4FnOSbLd0CpSAtzCgWmF6MbJfOTH4SAbGBa1epQnrQnnkGyMROaDosrtl+L
	 IoJdS3ksDmzvKI2aRshb6hl5zhIszANd5Iv1K6UpHlXILTLM2Gg1FV/m7iE8K7QwD/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b183+LWr;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A030606A32E
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 03:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A030606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b183+LWr
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-37600b0db49so2996677eec.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794714485; x=1795319285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koJgHflpF8SlmhITyVQWyV+LPgkeAJc/hP06L9RsOYI=;
        b=b183+LWrZFM0bv0LIXdbfL6FW/5eUn2mEGH7ooYlP86N7E5uEfzcrKvKo4HKAKacxv
         GqV0dysJkB7meYrGx87aZE+fCxomVCXUMduyJD73Zgmcj0puzmcUhF0MzKt+RM8cE8u3
         /3szSVzA9HIR4/XE9TJh7h9/5vMbEMJLeweZtnrZfKdEGc2AWJZQF6XvYh1jee0OGNVP
         lSdaRpAbzDg4CCbLX71SNKq1wJzqX4tAwesTMwSbeo60lSD7M1Lqk6AP2QWG4W5ZIh6b
         pO9+2qonCSweRR7vdT+SZWk+WOSn/Wz6alFcj6r4EWTisZAITnDRhwDSI1XIOongLCYf
         yXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794714485; x=1795319285;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=koJgHflpF8SlmhITyVQWyV+LPgkeAJc/hP06L9RsOYI=;
        b=rGGY6QqPmxvFLbTrK95LyuFR3PqkqH7YlrZXfpn50yrWlAQe12v5z+r2QA4dtaWONn
         oU3AEOcSsitpa1c+/A0TGLos8Q9eW6hHgB2XCjatI08+qQtgyH7fHzi4vH7Cz7Ismi8K
         K4WqWyr27xIODgeWJ1ggg7P6QKsrIiLr/inlBsFAYYwSfXshTs6yt0VUWjdQVQjHTo1G
         ktYh4OwTwDRsEH+guzufkufdLDM7LDgmMW69BOQKqrPB0kAPEmk3Hl167s8BxUxezrIE
         GnCtRRJZJ/ItQbeQ/WdzKQgw8CrOBkv45yNS6kVzHayxio9/egp1qhSbBMlRGZfi0kXG
         GQtA==
X-Forwarded-Encrypted: i=1; AL+hErGTR45MWxZqRxpCYYzAZa5N6MXjPhila5VhFGpSXsFZv0UGdI0jwQIW7hanxZOGQq3wE9xfp/w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/l12rn3oY+6eRztNG/eoSg2WPocGgY2xHq+DE+mF77zgvOFnMf
	PEHes8bpBfFYQk3Bvzrim9gEmZzjq4QpLDV2fDiDGro21PZjt7Up92ga
X-Gm-Gg: AYBFou1z1hfkakBH3oB8Y7GwI52vYvRq8j23UL81g4PMcBsA6abuNXwmb+XRonKUAhI
	u0uH+f+Z+neGyltp7eZTPSno20uVQye3jCSrL7FwXlkWUk8sXt/S7WyyQC5y9sEYZ3HgQpm66K5
	xjQ/D+dxkIKRzpB9S7dTuDB0w9nCigCI5ld6y1XdHFqfevAQe7u7MN+weyaqYbx3t9+zXFnQ4St
	a5cwVh9Usj2XAGwFqXnd1ou04ClWbbcpMyqc8d8CCbzf7+jHwC2SfrH+lSjZYDqkQFGxQm1AlTI
	iLhTAUbm4oi4u9iQZ1gtFL3bqBHNV6NUXC5NZarZWvx5xu6WBtPnU91Pr/qMNhBCP8TIrLOE6+f
	hkLu3yo/DeIh8RWcRBiDTtxjxAfQExaiL00BGJa8AegCHdmYdl1Fbupm+fvnKYoizgovtcxUBy/
	HXX1RBii7A6enLgmve9ADTpn/syVCWK6ZDsekIcOCNizc+7LKJmrpITJj/9QWgzj9OVmYUTe8RA
	5zfFtodApj376xk7I6zGXgDaPCxGTUz6RT4ikC1jPUCockf89vp81Z1MjALx9n6PGqdW/xp3Av1
	ki1tSRpLTchBW7MMroPxS3nxAFijhc0T2Q==
X-Received: by 2002:a05:7300:c00b:10b0:36a:647b:2d7a with SMTP id 5a478bee46e88-377db7c8ac3mr10822333eec.0.1794714485325;
        Sat, 14 Nov 2026 19:48:05 -0800 (PST)
Received: from [192.168.100.6] ([121.144.254.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm37381434eec.21.2026.11.14.19.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 19:48:04 -0800 (PST)
Message-ID: <84aaed30-5259-47cc-88b2-437b81efc90f@gmail.com>
Date: Sun, 15 Nov 2026 12:48:00 +0900
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
Subject: Re: [PATCH 6.18 000/686] 6.18.64-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261113153820.902362109@linuxfoundation.org>
Content-Language: en-US
From: Joungmin Lee <leejm516@gmail.com>
In-Reply-To: <20261113153820.902362109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 12:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.64 release.
> There are 686 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Nov 2026 15:36:17 +0000.
> Anything received after that time might be too late.
> 

Hi, Greg:


6.18.64-rc1 successfully built and booted in my system without any notable
regressions.

Distribution: Gentoo Linux
Architecture: x86_64 (ASUS Zenbook UM3504DA)
CPU: AMD Ryzen 7 7735U
iGPU: AMD Radeon 680M

[    0.000000] Linux version 6.18.64-rc1-900-myllvm+
(user1@gentoo-zenbook) (clang version 23.1.5, LLD 23.1.5) #3 SMP
PREEMPT_DYNAMIC Sun Nov 15 12:36:52 KST 2026

Tested-by: Joungmin Lee <leejm516@gmail.com>

Best,
Joungmin

