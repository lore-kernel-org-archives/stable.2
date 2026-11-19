Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050149;
	b=wiXcvDDXHxK3UhHPdK4v+TXMM71UNLG0TXb1QLNyITHlHNSIUttk9+ij42SrM8wIg35+
	 pj79tUD/LXT5v2kqpiPDbalGpgns9InVAa3Q4yeNkZRpOI86xfUmMoaCGif0N1ayl8//B
	 BhnBo5ncdeTf3MrguC7qy3e3p+syyfHARfVD8ZeoH3WHecjNKcVeBmQOA+RNCKvtqfyvr
	 qnVA6LBg1K3IPIoDT6INZG7i4AvCCH53dHa7+XAbaQhtsrFLU4+h4q9TcpGjzRWfBelR4
	 RdocxKZD7wumSqx+++oTLUj6qMBX+bRfD4XwbVyS3ueR9J3HEj3R0Ot+meEeL+1sPPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0C8lnJ2RZbzuiNletdGOfX0PhTEr69qDL1g+/y+UTJw=;
	b=XMjExh0MBHZ1odHf34sMZrrvROszcfPm62gFF8H23FinUfCKT+kLPJXgH1NjCOiBNuV3
	 0VAziM7LO/18xKjueYYamzbIkj2Fly1z9m6TvfbhdXy4+aNdecFywHTGkMBHGB5dINkjc
	 AtCcVkzZRZa/OB58ePs7PAnBBug5ewpfpLTdr3T+RCeiNjMpOZ6MRjnEfWVNjcT48Ics1
	 d06uZzVgqNWIcRA8KVH3lPLWnHXyfSGzAxa+9qoEL95c3OQSxsYi5eVERye+T1sUaH50K
	 2agwW8DL1uaSMEYH89Kfrs2v7kXIsTr/F+MRdvCKG1FUy8qAPLqmgUHld3KY9AMz1aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=AcFLliy0;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF5606A31C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 01:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88AF5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=AcFLliy0
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4adf4431ca0so515581fac.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 17:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795050147; x=1795654947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0C8lnJ2RZbzuiNletdGOfX0PhTEr69qDL1g+/y+UTJw=;
        b=AcFLliy0vMdVeba/L83H2MqHW0vnU1dM/bLcGD0emfOrWQWAl5jE38IMhh2T6Ih93Y
         +YplPcD2gxewyt682rx5QIfBDSyh23R7xgnFVtPELtJUuBMC5MSFdtLhFrRA8umcU9DZ
         b0j+JfgmRkZ0jrUG4/ghl4dVWDZyfPBkZfMZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795050147; x=1795654947;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0C8lnJ2RZbzuiNletdGOfX0PhTEr69qDL1g+/y+UTJw=;
        b=MHrybtBDXTgV6qaM8PRrMpB/90T/7ngN7Sfn8O19TyjRA5WMfvXIUmTWKLrAifdrJz
         lxd8wdu9z7ZIvgTF2AxzqzGkb2i71463MB0rX5mRePGyAuTOLShH+V/uDztTW7j/2Hpi
         SnQKloy9YMQZkko5YQyRXpbb3OqUdnBdi44DSr6SPAEwvNEXZesIclv9Bfqi6HXHbhTc
         cIITEJYOVeo57F2BX8dmBT96evMcJTRUA2kmjKsu3gYWidFgnJKQQy4sh2BqOzl4Ke5r
         vbxykyrgsOZnysJbR+z1yd5cEHBeRRs3dk1Qzg6ivEdvUJR66wm1AqsI+aiwSVvOPtng
         IQDQ==
X-Forwarded-Encrypted: i=1; AL+hErEvbO9prl+ELi5QR+uoI7894YaV7ICsYg98xuCCMFLT/xB7rKfkx3C5DUIlO9MKX2D6sT5eydE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9N5KHioW150syfOlqkB5fKfEYZzJrBU4nlIF6fufiVu1BWJsIg
	fvZrd4lvW8T8516xvqU/nGOR8zKLkwVbLnFKNc6/2umFZMLzuqqWzgiCQeF2xUDBMJ0v1rz2Xwn
	RQwIc0OY=
X-Gm-Gg: AYBFou0ICWaQiXiJcL6PeIzWm/yGNpI5S5jbBZSu9ShW9q0UGwNlanSaCcScwsFvcE8
	GxGMxVWp2eKyLXOcfK3q6MEB1zltz3Z07+6tAro2m2enPEwRZ/ZEmpWUcP0BF6T4t4HhCyvwSYH
	571rJShfcugrRM4ZIN4F2i1JTg8dbEVYms4EyEXeuZ0akldmM/Zlis0sU/sKg9VbcZ7kfTLnu/7
	ngccGK0+4fApSLbdZgRHihipgkg4urCzN9G/BmqNYhLvRepIaBZxZ+AZIglyoOwbxVXEcFLvs5I
	SdcNJwVL/nFWacIWCyJQf7AnbZoxWEmE39jbhgv4FAmls1FVp66rPjYOe5rAlWr7L3+ED0cMdyd
	tTTNmE5OTx3lHSfKqbyWVI6St4gHvNP1IAfFN3HuqrnIw5ZOQvajvZVl7zvdw0jrow0S27htMRV
	kNjWqfDgkDYwWjlMRNpS3EsyU5Dr1GXBlHDY43d+X3WKXSBAGGGEVNnScov8o06jfFVesfNB0bH
	UQL1p0PXfCrAFFt2kiR61G4QtU3uona06CyG/2aflsxyWooSLsXyUM3FRX9fM3jW/8n0BUZxdzk
	CRXmN3n2yAjhwZAbMUSebymbtxp8i+mh3mxPn/8=
X-Received: by 2002:a05:6808:4fc9:b0:567:cac4:f1c3 with SMTP id 5614622812f47-5773c12b74cmr6176202b6e.23.1795050147505;
        Wed, 18 Nov 2026 17:02:27 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5777a8a5b72sm2705076b6e.7.2026.11.18.17.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:02:26 -0800 (PST)
Message-ID: <2cc4e958-33bc-45f7-bbd9-c6763fa3a8d0@linuxfoundation.org>
Date: Wed, 18 Nov 2026 18:02:21 -0700
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
Subject: Re: [PATCH 5.10 0000/1848] 5.10.275-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261118145911.150052362@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261118145911.150052362@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/26 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.275 release.
> There are 1848 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.275-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
Build failed on my system.


net/core/filter.c: In function ‘bpf_update_srh_state’:
net/core/filter.c:5867:26: error: implicit declaration of function ‘seg6_get_srh
’ [-Werror=implicit-function-declaration]
  5867 |         srh_state->srh = seg6_get_srh(skb, 0);
       |                          ^~~~~~~~~~~~

I haven't isolated the commit yet.

thanks,
-- Shuah
