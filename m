Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701773;
	b=MjPKzr2lymC95Jbum9cNodpB1yrWTHUJ0ai86FUi5a8wekWaA7Sx97bc4gVgIcOOaTj0
	 nRR/RdHzuVy5Z9MxWT0Q4kDAwdpdWlY8Pk6kFQSHl8mHntuGb9XOnf21RyCayFxt1hsQ9
	 c4N/EGCX5g7iXLqAHNqtInwt5129//iAsoMgYqbH06tsg8fhjDTpQMEhbCa9g2nXJ5q2B
	 EmXYLFO/m/vSvPWD/zE2JmbZHLrXaMGKvD4GwzKai528QK9Ytyznqu/bpFBBOkIMegxZT
	 jwESV5DR7blAJCdMX8EUGfYvlUd6miqK/kJVLQH5ulUjsLt4EnMcqDbUyhXOEt3xAtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lHTP7tK3RH+sk4NPGUbDTRffLgmU1INyF5ZWw/2WVfQ=;
	b=2Gzb79Nze5CXve81TyMMupC5TE967ueWZ7oUqhdX5SfqFyvQFN4u3bjYKSiTaZcO05ek
	 SmFEuy+NvtkihX5BgwuVevmFqqmpo9uN2VkbT8osDVI1mJA/L3nKxwWWOUCEmvoeDDnKS
	 EPbTJzxgt2I4tFaY0UZCZE7uCWOSO2FXpW3wj/aWjCKWwa2QvMI6xv1B57aCfgVkn859/
	 P6FV/57LmwmT7zJvHMYky1S3OkBMkUtGcUkd+U1+LZK1M+RkTFgiL8zO7i/C6nFMUM13T
	 0V12mEzliqUBdR4e+Z4Ir63yJdM99LJkKt0mbyE1fznjh5AxLnVhZlJ18xHum+niksQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yAO41omo;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05356606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05356606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yAO41omo
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f07a960666so48583255ad.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795701772; x=1796306572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lHTP7tK3RH+sk4NPGUbDTRffLgmU1INyF5ZWw/2WVfQ=;
        b=yAO41omoyo06t9dQGvNRC8pLfFXIG1IAKVbkTCexoFwgzS9VLXSTszeobeX872pvhx
         8WLRgttgW4uVHXiUxgL+2tOVE+g5TGm1PEZxVuRvZlhpulwgSI2NDBNYCYgXrtym9v5n
         BB7cdgWF9l2VU1XjjkykyD+7/e5vm643T5INWil73a6srRfcjKzK4ZdMDeRQMy1Lia8G
         RyPEYPskRN3iYi0Rs8IsZ6nzuymr16n++XtgLOYqMu4Q6Cj+hMbArmFtpS9n+xn+AZiZ
         KDP9tla/Pzrd5D7EGcpukOlobGRd42f2Gahb2zk0SWf4ZzwqfU9U0vkvTm8oix4/8FUm
         +Hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795701772; x=1796306572;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lHTP7tK3RH+sk4NPGUbDTRffLgmU1INyF5ZWw/2WVfQ=;
        b=Dy2vyG3ZaqyiUAs2DMFMd2PrxHRdS3fQDQswEZr4vqWSIsN3hz9qPOTKSBdvevbo5k
         kFE9uUbz3KhH2jMulCnXHeQT2CkvMUH5c+BRgHUTm/XM1YrEq7MGm5hwCb2doN/S79hc
         LRDoVEWR68JPGDxONYJjazJ95xoJjLP3Lwspdw3oS6C0zWXJJEo+xZNNo7i3S5JhKikJ
         Lc2Qv2Wx4JPA4F913SD4kKbVPRdzCNdkINj9juXyRVJm1bpQmROgIxL1A9tUurq82Yeg
         Fq3rM+ahPdb9FZ74QxP713m2nf9ZF2ioGhBIdInsVunj6Hdi+zUHPSwyhdDVr2ugXdEk
         Ixxw==
X-Forwarded-Encrypted: i=1; AL+hErFDT4S8ziS13TV0WwrFKfb/Tr4iULUhD5D4Bk6JSTrPT8CmhnkIW1PHmpl4HoqaA1nZJlKAimw=@vger.kernel.org
X-Gm-Message-State: APuU4Z95Gi27LGnyPUw6n9TcgFH4AVPeejRhYQco4YoiKavf4OQxug4m
	MxKKx4/lbvBrISTS1d1NF6FJZq7Gaw5EKneCsfP07HJHC57b4w4Adzab
X-Gm-Gg: AZFdTZe3vMisIs0xiqry/bnYpBMXSa/I6eG6wRJpAm1D0I5Q0/+w2ieT2k68VWx9JWa
	Dqw2BcvC/lEobgjlAdjMDHH0ihroTZsr1kVmTJtddyBC1ZtsVEDAyMLVOuyS3euyqJ5vf/a1Nzz
	H9cL27TbFIf1NqrImnfwGfF9EydLgOMSt6/wtiA5iPxbBVSD3ouDbadWMDJdDnj2wI/NjzALC9c
	HDYFcCnF5la8a3cP9GK3cjLKWdAV14l0N5nq+3irl/wCnnuUpr+kPaXUjrMvesWxdM8rTEBTMAS
	ixl1gBFen+haNFKVDkoP+SzfvOeIOzBNCAC8/7y3oa5A0lpqPzBBfqsKhSrSPccBt8tr5YQABDI
	3E2VPH6RT8SperjgNqSO4uFrQvmy5HJsauwo3Txk/q1XB2VKzWeWs1i34HI4KH2wSqy5Om+Cow9
	AvXpPA5twPLOd0W8MzohpcVz/jP2plGC78QMOr/4oXuVmN3F7neFokfm5nN0u6MgmUKNJwK8MeP
	OQRj2U2iTeJ4uv1bt3/D9BhYBds5E4N+MGYFz5fA4gNc1KZMNBnl50vLB7H7pzxGAsNfceQRb+1
	y1TTzdsgBgoR9l7InrX8F9pRMNVZzi35uEc=
X-Received: by 2002:a17:902:ea0a:b0:2f0:7ba2:e9ed with SMTP id d9443c01a7336-2f07ba2ea9fmr155052575ad.44.1795701772176;
        Thu, 26 Nov 2026 06:02:52 -0800 (PST)
Received: from [192.168.100.6] ([121.144.254.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120282sm103130015ad.59.2026.11.26.06.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 06:02:51 -0800 (PST)
Message-ID: <e0cf6325-d280-46cc-a3ac-a44a8b5b1ce2@gmail.com>
Date: Thu, 26 Nov 2026 23:02:47 +0900
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
Subject: Re: [PATCH 6.18 000/990] 6.18.66-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261126105725.767748294@linuxfoundation.org>
Content-Language: en-US
From: Joungmin Lee <leejm516@gmail.com>
In-Reply-To: <20261126105725.767748294@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 19:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.66 release.
> There are 990 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 28 Nov 2026 10:55:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.66-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


Hi, Greg:

6.18.66-rc2 built and booted successfully on my system with no
regressions observed when compared to 6.18.65.

Note that the kernel was marked as dirty due to two
distribution-specific patches, which are required to build with
OpenMandriva's modified LLVM toolchain.
https://github.com/OpenMandrivaAssociation/kernel/blob/master/linux-6.18-clang.patch
https://github.com/OpenMandrivaAssociation/kernel/blob/master/linux-6.19-acpi-clang.patch

Distribution: OpenMandriva Lx Rome
Architecture: x86_64 (ASUS Zenbook UM3504DA)
CPU: AMD Ryzen 7 7735U
iGPU: AMD Radeon 680M

[    0.000000] Linux version 6.18.66-rc2-myllvm-gcdbd1b15b2ec-dirty
(user1@omv-zenbook) (OpenMandriva 23.1.5-1 clang version 23.1.5
(/builddir/build/BUILD/llvm-23.1.5-build/llvm-project-llvmorg-23.1.5/clang
0b5f47964323614ae2dc227f0b267ba43892bf06), OpenMandriva 23.1.5-1 LLD
23.1.5
(/builddir/build/BUILD/llvm-23.1.5-build/llvm-project-llvmorg-23.1.5/llvm
0b5f47964323614ae2dc227f0b267ba43892bf06)) #1 SMP PREEMPT_DYNAMIC Thu
Nov 26 22:31:08 KST 2026

Tested-by: Joungmin Lee <leejm516@gmail.com>

Best,
Joungmin


