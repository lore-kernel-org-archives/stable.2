Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213879;
	b=yAUBZctJI5MII1aPk7IXVaPrQ5k80WeZfxVoHxqSlVKexRmgIHUpYN59zrDMdPnJpcMQ
	 SbVI8KDB/CKhBE9ECryC1Dp6Q9nH+LakXE0tRSXTQL4BDwIKzhVV/3UFDhcwUVrkwhV2X
	 SFxSVcBMF6itxqCWWheJzN9yjvB7SQyCxV4JpQ3PcT0iXciT/oxWKkcxP4lfyyQwGZJGE
	 LlgpDV/oJa9Qm4BuKISSrmd4mqGaydSZEmp+3PI+IadBwd6fPQ3cXMQIhWyxQcB6q0tnx
	 5CnfH4ed26vVcAzT/BEKgWZxn0gU99S+mk4wep1WXW71D/dXA+lxDxfaRjZ/JYx7kRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UK3B3lWP4def/hq2HHCr0r2FkWoPUs+SuSypRY007Ic=;
	b=1VaCk9fKfONOXJarEddPeORxsh6P2rWXbcgGQn/JICzW10mRrdLLIkB0Ije8BZWNkezl
	 leLfeUghHnopUljW9kCwuuLcuqUO+T9miOwkNzv3KHAnCK+LfgjEjvpttH/2UrQACxwWE
	 ZQVleUOpeoiDPPTiRD7QRQM9IB5NHCsTs0hGy/IcvC34H/Cg6HUDr6x8cPHJadl0UlSPh
	 /WZ81h0WmBLIMayoVrmYH15Rs70Fkmm62KkBvkL53pHOufGg6NUZJA7iCht69fuBZbhho
	 Dg6kQ72V5lhH3gwDNI5wY6u5N+BnqLpeBQ/GNzGCGDJh+g9ZNqHHNrHSRZ0If8Uqw2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KHtzWbPQ;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550A606A68C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D550A606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KHtzWbPQ
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-382f4710a17so2317311eec.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795213874; x=1795818674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UK3B3lWP4def/hq2HHCr0r2FkWoPUs+SuSypRY007Ic=;
        b=KHtzWbPQca8q+BknspyuGJ7jM6NKIc0Af5imMDPXF3pryKcEUTqoslZghbkq7Hijf6
         5gEuBXj+d4/baA86ARD1ArNWE7bA9XqqoaviOThzmzfv/NT/sVfBh7EAukSFclBqrPx+
         l6hW+yCEEY79f3QChBeJoRaXSTIEb1DcxrHZWA0hcMPrnbjyYBEP/neTXeNY2rc3S12g
         q7tBy7MkNKQBrcnCxvyS/L9mqT1BOraVf33pxiNFSiKhC4l2DJfkRcEGdVbHjB1ILMGF
         ik2N7nwfJywXqsHrf+z3++9jHPA0IIcHF1D7AJ4vhwNyXMZZeh+bRIVyGsUPW8WFi5xL
         p0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213874; x=1795818674;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UK3B3lWP4def/hq2HHCr0r2FkWoPUs+SuSypRY007Ic=;
        b=N0REcG3XPTy/vGwYBNFm6dN7t0Qv/3yvlDNCu/pLQO7TQ7oEzYW6JGRNgDvCe62S1Y
         BQr+Ph7t9OHnHsnZ214BrLsB9N7i1LZHS8IIGuIctN7zLLQ5tDaYxxGUtCV7Xqn8uERW
         rYejZHC0/K6kSr3lyS2aPPbuD1tcv+ceaWQOoAuSg+Tx+Wf33xtFacSpXppIAY2lkE7q
         Zs4w/fC27V3jyWeCucm4C2LlN/3MAsHdph5w6wEcCRp9yIvL5Lt8zgMTYOI9MVEqCz2D
         sctDraeN0KXWrEUk/mWiCeOtAEFjsDJmi+JSx1QK5keBIaVStZHJn4kK5sw8o8IShWS7
         6CNQ==
X-Forwarded-Encrypted: i=1; AL+hErHmPVvZrHT8vIdRrDMgpPGRYeBsbECg+GNbRovSgudg9oO+wyqjyzoepbW+Gj4b4pw7h1Mzf+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fvwRdG7HUszoarBAzV9eibyyeqwcicpr6BpatsygkZqVT3/p2
	XLJQUu4nFF3iQeV1IMlQBx/5GyACPJDUaHSEogFAC2wE0Xuib7QsNhJ+
X-Gm-Gg: AZFdTZef4qZlcYPzdMIH+LiGXtk1bXKGNi3p95i/T1wB4eQDg7KLoj5BZfT3j3EJ2Jf
	TvUq2AGPv4u6lDYVBo14ubIOKe8NUKFiYzdemZ/7hEP+gXY5xo288sR4Fep8SmFmti47UmpGfOc
	bggpGfLCp8gOhkSE5ti/rl7MeP4WymtxCotA9BG4vCJHHzBA8oDA/tGD4kLQlcbXBP9ZOMIkbi+
	eXIVAvM8DK1DkEv7RbwCBlTx5bxAIxjp8c0kiMa4H51k45sR3vnG9s7o1jWK8MvogxdfuPuKB+h
	OOtosu/SLlB65U6xphF1d9I0MGe/pVOWQ/ieVSm4OgC1gEanKfA46Sy4bjB58AJOKHsU02bRv9b
	dSTK7w79p6jKhC4Xb4z5V3jKmwdM9ICjXFYvvQpxbQmguj2h7J/SYKqGvL/jCUK10bk0cAzeCWV
	blnIiXwlgoyv6LAnzNDUwntq3iCRHQ29c4B+6pbaoNAtyUqRVeR0pUaef3p7B4mAsdLQwNhpRMV
	yS5uZ3nNZFktzqAdbDSeCsx3u4d5ZOvWPfoU00YxudIWnU2K5loKK7laADoXo2T7X1dxOGwEcZ5
	g/iAadY4P17U2T28snL1gCPIEDdY+y3qwmh61CgV3mhM+iZ4Z7TkUxIr
X-Received: by 2002:a05:7301:6908:b0:381:1926:dba3 with SMTP id 5a478bee46e88-3856983c0ccmr3823683eec.0.1795213873842;
        Fri, 20 Nov 2026 14:31:13 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3856456e6c6sm10229177eec.2.2026.11.20.14.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 14:31:13 -0800 (PST)
Message-ID: <a7c43521-79cd-46d2-a82e-01f784cfc596@gmail.com>
Date: Fri, 20 Nov 2026 14:31:10 -0800
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
Subject: Re: [PATCH 6.12 0000/1736] 6.12.119-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261120054951.366579794@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261120054951.366579794@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 21:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.119 release.
> There are 1736 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.119-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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
