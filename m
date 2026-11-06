Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990900;
	b=XfkymYkiSRu78MMI3OeXr+SmBT4A7my3gw7l18rVBV3GpAlaPqZqMURlcek1yxexec7+
	 9amoRKYeVcLFMwssRhf1wvFOcjz0I6axk5vQF0/9VBelxoGM/+HoVbxENMPKdrk0bJMIe
	 Wq7gbkPiLniZNK/Yi1+vUe01P0wJ6cOuEtvFH1yMCXDVFAp8xPAEWwSrR/P0zshASaUFl
	 rPiEyQ/xagjPQ2lBC34KjFqodzYCa3zwwSwdmPdR0Mzg+U081CgXojnx258YjiJX2VEQz
	 pR1QiIGhvU5eTmAdIRX+4imMdibnf/aCnjf3BoYuYvJF/RgudwIkuD4WLZzoX7zUqhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Lh7QAjeNlS39ktI+dlJIULFlvwkgAS1H1OKsWGYccyg=;
	b=FVTIApJaY225RfZR179u2hPgor8oO3UpHTpJ3n3XJK/GMTJ8ePf7SEgVcHO+gcc28kfN
	 WL4EqwKgemNvXSEKz/zNZ1fT89gSAtAiXx5iKZSPsjEhllgd1AzFjNDN120joZzPK8HxF
	 JDq2JzOU1N1nRiCv9mzLOlu+jTMPOXuC4EjrKSWfLghH1/oA23dHPoyweWFLRmN7JW/Fk
	 Yc0GJ1orZZBKqsUa3i9amDAEd/YRC/QSywsB7ONvfjEQNHHQYKjmHW9n2q2QqZ5a/oaeS
	 lmyTr0SGyMvTGJIyBXF0h8J0iCnc3vyPtpw6TGBlHssRxfHl7fNm78d/W3u9IAzExaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFFBC08W;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF20606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADF20606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFFBC08W
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a2761c69fbso2246830c88.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990899; x=1794595699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lh7QAjeNlS39ktI+dlJIULFlvwkgAS1H1OKsWGYccyg=;
        b=SFFBC08WcZtGzmZeMUwARd5K2V6POj20bd8u0XsZSWDzfnpZ3TMWQqLqV1Fx4HUWTd
         mr4mQRoJlC9AuJ2ReOuQ4l07U5SCIDdM2i2O2y79k5jLzNxcmKzO06Y+SxAeeFnTimax
         bPISaRFa37iAoDFl8Uo5DIuIlF4NATPqX5YIQD2MXwipjO2N0FNWoG537jXWrq+L/9dj
         usC0S5+y8c1fZYR0bhM5znk9tGwRABkXdWWowDA+RBzovAIXFgUr0q8soeLEcG7Jj2xc
         tqOR+VtEJCFbdjF+rvfvQRFbeGy2xCzhYMxItRi0bMslQ10TzG30XfwrZp4PixlZFJ/p
         Dk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990899; x=1794595699;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lh7QAjeNlS39ktI+dlJIULFlvwkgAS1H1OKsWGYccyg=;
        b=CsHr54YDSv/OSrnUcUoGgohDZitQoPEoV+/aniJPPvA3aon/NmAXOwdE/EW0klWkFb
         zhZFSJYqA8nOn4ChJYkuhBe1xLMTYCAPfHvt9J1B0zpUwkiByUYlF7+/6tCrHcDq/jWJ
         dmjot0JVWSwPTKJ3w24iY4K4X7HoYVymiXM7XTj1wez2kV2Gdt+YUrApUtqS0Ubzk3Tw
         F42WvLZz88/9hWYfJxJDZUJkXA+qs05T+r2i48mNi8yAmHb1CCXj+6h3pE58EGrJDeEQ
         gMVnHenhNPoXFd0b8BK81qJmqREDu9NbKn/XagsC0wHacqW6K0lA5Eiz0DGiniVAFhyI
         aBzA==
X-Forwarded-Encrypted: i=1; AKwUvBzL2Ej+tR42SstxqZk68CKzECzQdPDs332+bFcuS8Ql9EmHy+9Wei2Mq5XaHeZ7stTqib1IsJI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fhBgM1ZQsFd8Sb9FIqkXK0OcrdkxOaJkZ8Ajtm0zVDPGpQQZI
	v8ddZy+TehwiR4lhzpvS3Rnw1O7+UQFN8+bd3xDDBS93+PCgtXj02lgRP4b4Nvpc+xE=
X-Gm-Gg: AYBFou2onmXmJVGiSnz7Uij4gy+kVOIhQeGl86C8Jmp3d6fOw6ymAfQtPkPggRHVH5m
	joVO3b+NxZ8mKqkoxgjbQpwhb5Oxj7TcGLiCvbOn8ryuSR+2vsMD9ngeNEg2pUP7g+ABrz8cAok
	qd7vfIStCeBGfXOjBmbvPK+thPUj/sNFXGEViPhI3sv5ZIoXe9LyyBIzJlduNQTQS/G1ucwwE9k
	NO8YsKHZsTKiuqmoNAI5bMWmJKRM19qkPZ63/4+5knIzYlkOSMwNel/KGz6nJA1DwYmLPuGh29n
	VlOfaowB4tNHCpldZc4+isZXTzoSqGbckiVwcC7uJeJ+USldiM9qTUaNsiQvx5FqW7BrktWUHIv
	zf8QrAW09fZZ5LhRw31JmTKwN+47rzAr9E0xoudAXnhYTIh283e2rOJQn6gN/4K0kaaiOlJRNNC
	ynIly5w1BNXnjGb/NGUZBJ/VRV8281/B2ZVsocNm7J8Fo1MprwOz73T7WjkJqWs2a8XrmOuM31M
	SCBmq7qE+qh2PbvkzZTIcKZ98OvTJlS1+sVSTiklCaA2ng3G3x973eZLPijv9/RDbvdH3tYRbGN
	oX21kQ2kCSZY2+A9w9Z+Nrw4a/wQLiPV
X-Received: by 2002:a05:701b:4588:20b0:17d:7b45:f927 with SMTP id a92af1059eb24-1b25d3499d6mr4163431c88.33.1793990898558;
        Fri, 06 Nov 2026 10:48:18 -0800 (PST)
Received: from [192.168.100.6] ([121.144.254.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4879adsm8661940c88.6.2026.11.06.10.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 10:48:17 -0800 (PST)
Message-ID: <60362312-e40c-4d23-8476-1b554fee19da@gmail.com>
Date: Sat, 7 Nov 2026 03:48:11 +0900
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
Subject: Re: [PATCH 7.3 000/547] 7.3.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261104211038.406938024@linuxfoundation.org>
Content-Language: en-US
From: Joungmin Lee <leejm516@gmail.com>
In-Reply-To: <20261104211038.406938024@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/5/26 6:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.2 release.
> There are 547 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Nov 2026 21:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on my ASUS Zenbook UM3504DA running Gentoo Linux.

Kernel: Linux 7.3.2-rc1
Architecture: x86_64
CPU: AMD Ryzen 7 7735U
iGPU: AMD Radeon 680M
Compiler: Clang 23.1.5

The kernel builds and boots successfully.
No dmesg regressions observed compared to 7.3.1.

Tested:
- Video output: OK
- Wi-Fi: OK
- Audio: OK
- USB: OK

Tested-by: Joungmin Lee <leejm516@gmail.com>

P.S. This e-mail is sent again to all CCs as I first sent an email to
only Greg by mistake, sorry.

Best,
Joungmin

