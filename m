Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101420;
	b=ZzGeZJgPFQiwo7q00yJKE8HCv86OijhxetWb+MptQErr3VRfxPjWZ6T3ih+Ks9Xk2g3X
	 sms2dUuAUm+lMFr3Y41QRs5BM3CpI+4L7tcUYF729TtjfKatCevXEstwVKbGHfAPZhV2Q
	 pXyZjxSqLNSztg4ZILco+09AD+Po1qjcsrg7Ayva7p9fp7avxypooQA/h1c+JroB1UR36
	 1+k7amaST3knXtZ9ZHWWkUnXYJiCuNcsjEylRT/HlWMjBMtcb2ZAkC7BC+VLQK21Db9Ia
	 3Z52ftKYeACZAds926HLLTmNWdqrZiMFOnwZCFoNb/tIY6ig9NuakSJPisG5tP9mJDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9Mc5tpEd+rEFEriA57HIWZrFdKcU8gh5hZIGJp5Pbms=;
	b=mE7l/g/BZmSKqM4G366pKFVoz1rwa+VPO/kEsSfzo7G7SLt6XOT7BOK3pHqNGa2xCLsE
	 2Akkm+s+PQ+RbDdfppgBCMYPKVM2/SV/rrMUBrIftuI8XBfPdHsfEI5zknrEIaO4vTawZ
	 9EPA7BNk6f6OiPihzp1EKjeL7x2avupcqXIkUTYi4YWCECOxzNS3wiSeYc2vZGLyykGV1
	 pyjeRQZAibehxze/VvsTrB31WfBC321I0QNIXbtvppEbWsd1lwkIk+FjpztW4D3wOn5wc
	 Ax8Ho308PqFwRkjgutVIOgeylMKQR6/a9nN82UaMvrK3bqSJEvTPETP4UW9aH1v0VuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WwNXGmIH;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B1A606A332
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 01:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06B1A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WwNXGmIH
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a070755c8cso27526b3a.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 17:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794101419; x=1794706219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Mc5tpEd+rEFEriA57HIWZrFdKcU8gh5hZIGJp5Pbms=;
        b=WwNXGmIHeHCL/N2qIhu8gHpS6ymm0Zrq+W0L4sYZrzZ41mGOpuRfn1rJO1Hm47L/pT
         JUBOtSK/za481mdHL7y0dq7zrqdATG+ePfE5AX9EYg0lcY/0BKkvJPZwYwMFrw1GZY20
         qn915JnCdrSaaXrv0ITy38fgQL5iEwsp39WvpNNzgGIcMRardQfX/HkmgiwIWlwnLh/2
         oqGzPq+E9LBMlY1UnIGK3dMKkRCqm0dhSvKMUfOriv90JdXOI+i7bEkwn/shmsGqujy4
         dnu8ir/HGDB5vyhwcpM4jtkN/afVjtPlDEjJNO12TTCLkcb8i9FUQLqqPesUaWv5ncCi
         +cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794101419; x=1794706219;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Mc5tpEd+rEFEriA57HIWZrFdKcU8gh5hZIGJp5Pbms=;
        b=JDIScaAnoUMKh3SLsJbMO5DG2aKTUKoG6o9EDxpmJlSYBse/m1IkhIZsw+K+Hu3VWm
         WPaZnG7KrTtmroqmgImiiiAZtGmnBXehyVFOSd5Os8vZSaYudyAn/ReTiU4pFQfXaEvh
         PHCw1VwG8yjc97WWiT4ZYI4JEycqdr+qDk7tJVrnapN13jqA2duOoMtop2QJ9ddO3Oqv
         S/wAkt1D/X9KyYHEtj02+kMvBZOOkupmFgDvXXpQdLDL5qYLB4yT2MXiPln4b4hfpfYW
         eetm5M3gyiA8ZBlNO4MOwpFA+pl9FpRPwd7CTB85wThJuGvBfjanoChp8c/gr9h00sjA
         cx2w==
X-Forwarded-Encrypted: i=1; AL+hErGQBaavFnMH/rwDhqcJBd/qSBiCdQK8CkHGFpB+Zgq6SoKsHe1assV2Wx3OqQN4zffyulODYzo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wJtRAcPZpTT2MKWxzDLb+RF2IGHTPV2bRHsZttnZ36QZyW65r
	IVNQRGRPSn6L3hTkrz+G3jtI2eaN9Rm6Lw9JXeBfKPywmprcJ/Hy/+jV
X-Gm-Gg: AYBFou1StQ/3YCF9vYwZd/yETUMwzumDATBqIrapFiU3hqv2Ia9fcro0DBzcQQuPVjM
	Gn0waTVlnU/G8KeLeRjzC1/1Marr8COSN+iWIsPW2QLd3i97wyWtrk3dANShIjK+e9CHaNxHo/O
	AI8H6uISq7k6157aYbjmpTWTNl+e9PEfAOIp729bU1klHiVxyOzvrnV5/kZ7ayYUxCfTg1uUttp
	sTSB7ayAfl5oJVuta6sse3M+lzAlQLOwZuAD+9UpbYXcncz5kCYDGHo3N0SkL5rf/RxAIObGL8W
	dzN4/Wluwr03E72VLwe0gAShsMAEL325li6gNC4TxuFSlBWv/+HC5TbeIP9JxlrcZozrxKEpo1e
	j6ocLu5w+ElPrqw0DhSLpaTqxsr0gLbPC67WuJxfMLqp8Y+rhjrcPb2E35T9WKSiwpLmM6Em7zb
	wLku9isvi3WpVsu+JU7mWxwa58XWejl4Jv9NM1/GhL/+HEh3rE7fETCG37RxlL0HjyEzqhScAOg
	Rp3AAeFBU/cq5mzASR0fizLHJReupHsBLCoRaeu/sY1txx8v1625lUA4Gx1DU/YoGoKUbba8VMx
	kaE3+Y2y3Wr490wWAPUbTXQp7g8io8qc
X-Received: by 2002:a17:90b:4a89:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3b12d6071a9mr171719a91.64.1794101419251;
        Sat, 07 Nov 2026 17:30:19 -0800 (PST)
Received: from [192.168.100.6] ([121.144.254.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b103472903sm2888812a91.4.2026.11.07.17.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 17:30:18 -0800 (PST)
Message-ID: <68e291d9-4696-498f-a7ea-087d87febe8c@gmail.com>
Date: Sun, 8 Nov 2026 10:30:15 +0900
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
Subject: Re: [PATCH 7.3 0000/1257] 7.3.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261107134939.434104957@linuxfoundation.org>
Content-Language: en-US
From: Joungmin Lee <leejm516@gmail.com>
In-Reply-To: <20261107134939.434104957@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 10:38 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.4 release.
> There are 1257 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Hi, Greg:

7.3.4-rc1 successfully built and booted in my system once the commit
1564da6afd7ce5297ba24f2d1e61d6a79a9ff6db was reverted.

The error Barry encountered was not noticed.

Distribution: Gentoo Linux
Architecture: x86_64 (ASUS Zenbook UM3504DA)
CPU: AMD Ryzen 7 7735U
iGPU: AMD Radeon 680M

[    0.000000] Linux version 7.3.4-rc1-900-myllvm+
(user1@gentoo-zenbook) (clang version 23.1.5, LLD 23.1.5) #1 SMP
PREEMPT_DYNAMIC Sun Nov  8 10:04:35 KST 2026

Tested-by: Joungmin Lee <leejm516@gmail.com>
