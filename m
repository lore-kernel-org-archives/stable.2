Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667287;
	b=cE2ojsa+m99TD3yoZ1CSXTYcTUl64Uv1YyOkr8mpbJN8TfaQm+AGk5twFY46NxAB3upk
	 oY7z0cMlc++/dvpjrkla0eG5aIZX362e+INmvz9oN3jehC4cEPbP4GnVM+F18QKPqoOro
	 9VYXS24QA1sIm2QUi00gNGcTWuAgvezimWBwzgrNgsPqMlHpwD6wzvFxD8MyoNYkMix1k
	 BtLaCqd+/+i/HrwiMroLmH5lm23X9soMjQba7hl+nppLESE4C6X7X9lUU83Wp4u85o6ig
	 aZj0x+tg/HBtu1Uy64AeyxvOgfhebp2Kl8ZwJJJgZmlYwHpkty0onItWOmX0hsW/e2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=J0c7g32Vkst5ZTZD1D3dAok+IJ411KyHzBH0wWFTswU=;
	b=M19iDDqfg07wNV/M1GWGo2r41lVrKw/tvwfV8kXRQ/f3awiSvelzMY+3E5YU2VrIwtTI
	 AaBPhArF7Fy2IbYoe6qiE8Kn1EhNSmV2hzlgXlgX+6C9wtdI+hakqDr8wlzRUblJUuhBe
	 N3CdctAF13aWBlwVzD6eWKioF7TIZaqI13RzcrXzB/pqj4a8gfu8dz7eqZamL/TS4qbR3
	 hMBrh9KFEDkWdv7KD8Kjq9d9S9Mt1z3WvPx3FeKueMW9mAXVBFhiWPf/dn6WuB9FpyTDe
	 Gar9H3MheSfvO9RX1HgjMnlAxAdFXisZ9kolISDfGRLJR2Gz4xgSIhOCSymOmpp+3vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FeiS0zcq;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49544606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49544606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FeiS0zcq
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so9147634c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795667286; x=1796272086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0c7g32Vkst5ZTZD1D3dAok+IJ411KyHzBH0wWFTswU=;
        b=FeiS0zcqgoOFmLr56DCXuVS+WPZRG48AWzZCrtrSDLlcxUGMT5sMj0I3Fo2It/PlAJ
         VjilD4Vcwo0RjJY99WdRJlzHc3ihRmA9bzkY1iVhahC2V8baUNxe8pFcR0WjTFoIOhY6
         MSnppkX+xKNYOguAEXff9gHg0y3C01/d2VbNql42xneC8VCPAlCY84JT4R7Q1nnaDJCc
         Rm3FvpKOgz2tC87Hg23eu3BEuVIpmQ2BcvxlyzraxqaQi/0oumo3lmnaDMV/wJ3OGF+c
         Rauyxf/zxC5x0lNztAIGHiWzq+BuK/tDAvAbmDN2jeQUUwqHXVWZameqraWcwPqez6j8
         apRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795667286; x=1796272086;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J0c7g32Vkst5ZTZD1D3dAok+IJ411KyHzBH0wWFTswU=;
        b=ScDrNu9D5vBDOx7VmoG6718HJon9tthc9kSN/NUIZUHMB0Wh8wbWmKJXvWMdClFNq+
         LngSDplxWSbuuMH2JwsSXNCzrXKOmuECcfBYAgjlKe1aA5VR6DVLAhfXo0Phm6FAP8hb
         5L/a+XdUJFI8ouonFQOm08PY7docEguF5OphnDwr/4DOuM6YoWdRp/BgKIUAOpaOq79R
         VuFZRX73M6fD57Ng2DHj/R0T3OMTV5kMhR7rDhOMkqATTNrInwmvETLeb9wHfYZc4Hpa
         bgjNWDLxtTsHQ6wOM6URNLPqIxcca1g/9wHhbc6CgppObo9x2ynLzlt2WQVszqJR37+m
         Qusg==
X-Forwarded-Encrypted: i=1; AL+hErHrIryNDQ/nGXrJOuDNRwnYf86JT5CDqWbpQ07mACTCcfM9kiHllzHIWmDVV1ELMsSzejrDfT4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OTtS/XGx1KvAXeWV4Y8jCsOW5jFSsVD314PW1mnVsUqjBpVL9
	+d3WEGAh6SAWTvnAmpP7oh3C8+2DTWriFtsmHsdC1A1ShNXmsKIztClv
X-Gm-Gg: AZFdTZfElMCPHs5Jsx+F9Mwj64rT2kmIuKoRQ7KZ6QGIXDY21hbmR94B+/sGu/ZydlK
	6O6leA42o1jlzRDIvv8sjWp50lzL3wGrFIkarOinhHzkj7TclrSApT6XrmzaAPOfHlS5xYha0/K
	CdkZ5nHbg+JB6HnSeavAhTXzXkxdeKudNOiyEOnB1qnMrIpGLqLekkJtM/imy254JdNlnXDn6Wm
	yAfDgeT9P6ZVzXKvC1g6fRHVtBCtc0cIe3r+Hyp5pZT4D4hWZ4/3e53Zx3o33bdhTql19ylVbgT
	GMUkugutoYAwDmeOZ1R/l3MnTXrQM00qnj6FsHZAitNi+MA5lPzFcSJaElwOoL+gxBHqR82gsWd
	8DUenl7EnWaIDG7cz2Hot1uKZzsH2gWTx18Y9L+nI0iUUgwXlXPJTtFHEAp1eTIKm0+rbhmOpd+
	l0uIFF33Qiwg2xvAjpD87xIPFBMMzFtyz4oa8m072D3C1zNU62LFDgA3Pz3E1UTRp3TQGYc/ZBB
	6aFuvCB1vPjWdK+c1m8mJVtPZIpjCAInW59mGXimNdcgoIWzahDaQ86WlxpTthwxFrtnQX2g4b5
	qrUH80xzSBEzjf/194y1rx11SHDFCyt7RRMHAVpNnaKHqvwm65pnKdRMP+cr2QgycfcDzo1LwxP
	lnLSZSVaaTYQWXS9VmUbV4A==
X-Received: by 2002:a05:701a:cccb:10b0:179:a1d0:be39 with SMTP id a92af1059eb24-1b56b709cfbmr13685966c88.29.1795667286345;
        Wed, 25 Nov 2026 20:28:06 -0800 (PST)
Received: from [192.168.10.3] (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm51792405c88.13.2026.11.25.20.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 20:28:05 -0800 (PST)
Message-ID: <9e9f4aa1-7823-42dc-83b5-e9776096950e@gmail.com>
Date: Wed, 25 Nov 2026 20:28:06 -0800
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
Subject: Re: [PATCH 6.18 000/990] 6.18.66-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261125143822.072087159@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261125143822.072087159@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/2026 6:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.66 release.
> There are 990 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Nov 2026 14:36:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.66-rc1.gz
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

