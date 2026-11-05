Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914072;
	b=ShB/zfHsUam8EDeBqRasbG/jXOIhf2KRsrwDODyXxdBXJ7CE0N9wApjzz8ynUg1L8tw4
	 T7OUbUV7FXn6mRo650FR7BMY+j93X3DyWEotHc1GpCqnFPFmL/zPJsQRbMVNtNO+QNmXH
	 PND2bxsoyB75nMCiUsEmspgcGbB0Mp3wn58zClPdywE2yxdX6xPrYc92IcstopKIqFPjp
	 5wfqbALbRteppz+kgrqDWnPokXPrN3e6/wcjtfAJkRi59Ru27e0nLAz8vWinVgmi2rWk1
	 q8GNWjY7ErEMZ0h66on3Bq6WpCuGA+ZpXoLWzHa5zksVD4hhkYNNP+lohoO/beaLfhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wX06EQOYjMy/aW6xZlZGYk/V5Xw9pqyAzAzdo7pf5JQ=;
	b=wS2e6mAoCAxYu/X9gjCF4QaizcyNwnznGhdCYgcKIniMbMn+HwW+Df92hw/576hO0vj7
	 k13ba/yqAf4C1tEFYfthgH1qPmis6hAcxHdS52mwyKp46K5rPsebpMQUBQvanp0M74Smy
	 Ir7+CqXxAcfkugQP8NU6ZK14S3EA9+rYmYcUDXGc1xhQgs3C2I25FV8P76LWFGUtkLdmW
	 FNpo5KdimGGZmcMUa+zNNISHuP3LvH2r6ANF975VA5tjdtDsxJkVJ6p7WW2mgFT5WcN0t
	 Ad074n+py4Cv7fz9K6TXhqPm1UahNernU9L1AaQtUgL3qp/zqU3EkgXw/FSO3VChZtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EELVhw4N;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C8A606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 21:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C8A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EELVhw4N
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35b2c599f43so148396eec.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793914071; x=1794518871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wX06EQOYjMy/aW6xZlZGYk/V5Xw9pqyAzAzdo7pf5JQ=;
        b=EELVhw4NwzpmsllJw3ppEndPr0Kp5G1Cb2qmC98OBb/yp1xyqlTgbB17fqaYyDCWkq
         JjYmNbdou7Nduf6zh8msHvBli0cAbihh3O8tTbt90NOGACNX17J5WiylNHcBvTukJ6za
         m/9rCaTrfCMbNkOEnkJM5r4p63Ha9msWBNYWmGNOlNz9Rx6mwdKTEI7AQ1MJSFcxdCdu
         /PzZemPVr8mI5xOn0Kw2mQhRIkZtcvJXj80mYT8u6uTimQCM2dwMvroS/a3X9hMZxFo4
         kLmLQpmNrsmqBYiVaPBz5HDR/zKrDgqdySqjDjvGFABVX/BNa2hvsENrhHMv9yiPZr6g
         bxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793914071; x=1794518871;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wX06EQOYjMy/aW6xZlZGYk/V5Xw9pqyAzAzdo7pf5JQ=;
        b=DjLph2IWSbxkW8u3iMIpeHztumiFkXDQ9w/19FytQSOgSMrs/H7I8dc0kulImKqXGM
         xcy9FSS+y8iX0BQi+m15utu9jjoeXqe3Lwbaa/K+X9xBC8gfQz72SC0xHSO7grD9Wp9m
         0Tk95yVtrLwE1eMtA8kvD4YZbDix+sCPkYr32FD6xifKYcBdv3SzmBTxiwdKvHyZyu6f
         hgklCeUk23ffz9Xt8RvI4gpCCXpjqp6c4etH4wAR4t290+7IFbjnlOAch3mC+pGHLPce
         xcguG+avjOd0HwQTzGZ7xns/KruxmRPGx5HqDisisFnlUt3YvZsHLjkpG5Ya4zQxR+n4
         N9Hg==
X-Forwarded-Encrypted: i=1; AKwUvBx8XGscNRTP7JLo9/aDhZq7aS3caZiA7E5A4TuJ2YXaVEm8TN/IhSzvy/c9kzw86FJ0coeTBGQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9r7I2MUdAJWCb30q2np2EfHygNgtrgrQc6/XNj0+xlVyvJusGB
	5KUcYqmRe+QC8nJUW5CclBbicurPvUyfXka1peMrf655J8QUGNgxqn1cbOobCA==
X-Gm-Gg: AYBFou2WKjtYUbqktdmUIaujhG8mgi8Zw0p5ADewWRDuNoa7axmTs8ezFQ4ZUGE1UOO
	bCNr0dTHJeckb3Rj229dS+G9ojynQ702cDokojsbYZgIwW5Tk54n3DuX6Fx7wqugmr6FfLzuwfO
	OoFUfs8HwKLXm1mUPf4JzqYl4P3hpt8EdBGM2XvbuNqJOywYUeuGmIdDeBvCEcrGLyO2uiOfM9y
	fqIHpimN+Isutr+z6HagyoKXl5uO5EZ5HzNW4E1VnGBKfViNGwOVKc61/tYo0vDnAa37TYDuFwH
	jt3/LKbMCm98IkhEp0vnuQR6WYV3mkTkwceY87IzF0RTA0ZYbmS5UkGyiu0YAZJW64DZbg9lWaV
	Rxn6glWco+FIU62T5agoFnc7QqyRg1TXvQa/8RuIb628hgVB24/vGXIF7F4dBW9AMGKIXbQrZ7c
	NIOkw1FItq7zLgTknpRXfxlpo8P/pD/AKAsWrMzNompmPKS/ih6tOBuMvq44NWCI2bRBwo4Y4L+
	6UdqKLpxkJS9bdgbr57gMe3Ne7jWJGEEWDm1Rs1Gijrz51youcv6lMOQWAEMaV6M6DGdmMI+2ZO
	vErZbkDk6lr8LS9RkDYUMoujpZpraNal4kvBjP32IveoRFiJUDfXR2g=
X-Received: by 2002:a05:7300:10d:b0:36c:c434:b6b5 with SMTP id 5a478bee46e88-36f76621095mr567569eec.17.1793914070609;
        Thu, 05 Nov 2026 13:27:50 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f72fbe241sm999556eec.10.2026.11.05.13.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 13:27:49 -0800 (PST)
Message-ID: <118849cc-6953-4f05-b1d0-22949f4cdec0@gmail.com>
Date: Thu, 5 Nov 2026 13:27:48 -0800
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
Subject: Re: [PATCH 6.18 0000/1005] 6.18.61-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261104211043.516122098@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261104211043.516122098@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 12:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.61 release.
> There are 1005 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Nov 2026 21:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.61-rc1.gz
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
