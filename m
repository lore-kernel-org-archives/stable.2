Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434578;
	b=Myrye4HGWAmm9hDYzGg0t7vZoYexGZz4P8N/QrTLSRVR2+K2mSh6z0h3KblAL8DW+Tea
	 EXGp9tbeKjnzR8CUclahMSpInbJbqhAOBIEeO4f7JojnZRXC1bBPw8/tAMJ28Uz2x/k1j
	 +335gbMzHp5FS5qIjCxOFsyYiVzJVEERAyRK8d9S4pEloGSzZwrleD/8ghVNkbJ1m/JEl
	 P8WS1Jsu1JfQ3PNyPhq474akMbU8DqhR//+f6wY1UglO+S/U/YTbCfZW6y9uaBPc5KCZ4
	 JSFW+9j9nnkmbMM0ioFsLs1k6WuafRYASEhlbK/hQw8a8R35GT9G2+X538yBbmgd+Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jSBiV7ul+0Ul9MLE/H5BpAaYAk0aqMfUljP7X5tbwpw=;
	b=FHbEp/GRSdGHdYJwJGhUBk7zvXAmqWC5VYd/RrqQAOVBXCj7igLu2kwJZGWcADQBX/Zl
	 +mPGxTC6dWSISY0px/wHKzMOJ6e7TU6eiJuTw1V4q0EYLkISNnp/p13uehjqxv8tgAQkn
	 /HKqkTCu5+axiDTrNYS2e6H/H1zN9ZWOyBT43lTc1AdBKzR10YULS1kqQv1XBPY3aQ45E
	 aJJY4IttK9XARc1RRHkiNTFB1sw3isUjZ7gqaKyIZDA7VpXbOmRehmnrtRmxb2jHAhG+Y
	 Zjj4fk14kbL18uiamzjSp1RfCjGUTDMkR9mBe9n6blSvN2N3Othbon3rirFdydSoPhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YKfHipk3;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92966606A31D
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92966606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YKfHipk3
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e985106c0cso16251535ad.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792434578; x=1793039378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSBiV7ul+0Ul9MLE/H5BpAaYAk0aqMfUljP7X5tbwpw=;
        b=YKfHipk3Wi83rizz/EWO30DPPheCuy9J9OmvthKmNGtuEoK8Pb+EucZUTJGGRn4dmP
         XQjRPbdI79HzDEzEQkBXytw17phqWORjxadrbkdTHmtJfjIryM2ouBGzm61Lw0Y0l7D4
         +hRsjXIILWMmTh2dolAE6rytJuZiWp4IuxQFnzkX34dgvJc/sCiNJxG6PNHpWtnJb3IH
         /2T1R4UcYnCqkTL6boWGXAn/0fVLsHc7F1q6p9Mj7J53QitfvH3J+TanMP2+ZaO6amd9
         t7Q6dwkDbulWee5RHD7pLmxGEu9nVLtlOawdRhjKYD9BV4ZWOuzz1Aq8L7lZ5zJXRxAS
         EcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792434578; x=1793039378;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jSBiV7ul+0Ul9MLE/H5BpAaYAk0aqMfUljP7X5tbwpw=;
        b=Azbk1Mw+RNTboaMXDO9dupb8LTs2u1g8aTK6y2EFkGBVd74HtaU6BIbq/K4TlN+0bi
         h3SNE/+g3MXKNvhHKfnfcSGmGz8Cp5mRWfj6jHAdHDYKZ1EqeZ8xM2BTTxMCruivUbIV
         cTKQ/1EQxrtEs2swcSuPhg7DRNOQdaYovm585MUsA0n0B0Yd5h6eZjHRUfZBiZ0yLW6O
         buK68L6fK5JyJh5BBwn3SCiGG+fmvcFvXhqybK/zMDi9DTf/5YgPY8lQr5qmiPLGSyqd
         VjjZMt5xktRkqUGDZm9T3Ucy+zDUaRm8fHk5k1oURAEiHgJKIlrvUEFpis7yf8iJrKLl
         xOCg==
X-Forwarded-Encrypted: i=1; AKwUvBwPqqVmuV559fNTcCoIbXaCyjLIMz3I4YLzjDML8ey1/h27sapSzS6d5NKvVNz7DlQZbTd1aUg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjaEMVgMIao0YMGnx7AWxD8l6SIsACvHRcZyjAweTSBMyW+uJO
	uzUusef6XvKpYvnSkhhoVKcv80cYTdFxNJdXHUKsxlbgc7O7zS0H0ltF
X-Gm-Gg: AYBFou0e83BZ6X5Y/SCVxvIiPbSyIGlLKxcHccX0rFH+ImuNv4TZo5pA81noCu792uR
	/draDbUcI88oMtTPPG31O6qxk9FrE2RFkjLJw322c8GWdb9J6dlxGfx8UeKEWxa0+/GDP4S+xZx
	IuOvmaAUsVq3Sr45q4Ch91I4pUFuy1LrNXMH2exdUpyQH4c6BnecqELgJPb4B13lMedIWFaXzRS
	eQ7UJ31z9kfwcli6F2ONx3/hxsZm/rLaLh2HTVf4CviRphFZ3HpOZ1nB+rNvtSooitpQM84lJG5
	ORCSC9qXuju3Z3T5HVR9BC81PWUkKfRJh9/ycHaXNPPuBLg0j35RkZ2wxDXCo7x74P7hIke3aXV
	3vKUZyrhGov9FJ7w2vy152iATAKEJUWE9wwUn9uU8u/B2+zzLX3R4S655cMDGNMLtepMXkOT/O1
	gLBmTH2ZTaEYuJuzw3YPNsuIH3Imt4fWcht9ylHq+cJ7W3RHqis+APHY9zdFYOcdZMgfCkRm2Qx
	fBuFHtKL3cxg46uhf/ZfRwB
X-Received: by 2002:a17:902:f546:b0:2dd:ad73:c938 with SMTP id d9443c01a7336-2e9a6d40f02mr71830455ad.25.1792434577572;
        Mon, 19 Oct 2026 11:29:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea13c7ddc9sm5303515ad.0.2026.10.19.11.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 11:29:36 -0700 (PDT)
Message-ID: <8bef225d-f3aa-403c-aab4-f629aa197b3a@gmail.com>
Date: Mon, 19 Oct 2026 11:29:34 -0700
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
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261017155104.830766652@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261017155104.830766652@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/26 08:54, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
