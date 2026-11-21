Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795234153;
	b=AD7G/IKU8unjimcf0K/f4g7EdZ6mUCE8Nee/SDAmzMm6QOb5mZ6wtv7722Z8CoGjZv8b
	 fkQQFZ3kSu/JBJvmy6okY6oe5B5apKttAbvwsTNuZOvMOj3ZxjBlu4cC8G8qorqA2Ag6l
	 riwHUyS4jNzqH1F4NJX8wP3N63Ed76VwOQf5apoe/mzR0ZhW+ezcNhEjTKfVmCdxdaGJ/
	 1jbZVbrGQTj9Y0FYg+NhS+V6SeoIfJtcIshtQQVHPrAb1usm9I+eJ3aIXo0KCaIVB8Qpj
	 HUR8AbaPQz+uT6XcvPfVw37jFixal3bnIZ66C1a0dHQt8aU7agH/RUrN1sOAT9zDZeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795234153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DU6QRI6/2rr3VH1bLHYHYKsx9+9ItmZMgLCzsJ11Jok=;
	b=bQv9JREbWQLp/9M+vDNb8ewfbl6q14+q5JYOMM4D89CloclnBWoD4zKsyc/M46omxya4
	 R9qumT9zmsX2f1Vpc8UUQnwJPMq3BYoKevNqKKVACUo3BuVLnPUaXWKHYWkxLYGHKCh6o
	 95uBQU7VttuASYCpNuugn2HVLZ56SX9YYmGYQuqNZ3lsvYDplybrdIcZDRwzznBRaDqHV
	 Ddy2TCJG+ER+NLm2qCBXif0OzVqytuc9d4grB8KYb640noK6UIUuTZLp5nkn4/6igN6kE
	 WsGluw316eIOiKGsl80Y6vW5kcfuFiHx9jJ1BKpcw8CY2R9uxUK1gnfR9zw/kpq+Srw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=Sb+VHum7;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A920606A68B
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 04:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A920606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=Sb+VHum7
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so15714945e9.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795234151; x=1795838951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DU6QRI6/2rr3VH1bLHYHYKsx9+9ItmZMgLCzsJ11Jok=;
        b=Sb+VHum7IR2VgBoWc83rqtqGedJ9zA8U0Oc0NoW2l9ttt3VS5mB0cGuVlWE1VYtuZb
         ZkV1sSnJ1SJZ+4LVDdqlZ4X8kS3MV7+Z5GdVKF+zy4aijKILNigtkJTC5w0w5Z7lL6+y
         S9DwIQ65K80vSSnHZtjSVeIRddMU+4FIk+YvPwlCkD82+KJAQtWdlgxoFU3IXS9AdVH+
         3W0sNCsmBiypLDeV5gPXbmw0XFUUhg170walv9AVC7vXxIS69AL7KfytH6DEWtbv0hfe
         Vuni0nEk/KGmf6WRdY05ROfK/bwZRO63/eAMbVuEpnTW3+ZnC/9UNL0O0C4VzgjlDbD2
         Wm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795234152; x=1795838952;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DU6QRI6/2rr3VH1bLHYHYKsx9+9ItmZMgLCzsJ11Jok=;
        b=SYZvu+haloITcwfTwsN/SGdsqJM1KGhZs85xMXmJEUePyXfsQ+ULd+vsJJbgVjJzc8
         tEkzQmSCU4X69K7oV+hyqkPRYgGVfySCMo91jd9twhdIeEG7hq22f54EcIAgOtvqhEZC
         gseo752QExtz2AlNqLjQKlsuwNOQNeXdaiIVfzTGSqPS/f/CX70HGPB1NIFy//KRrBtQ
         3EPw68tMDxZyRqoIVzMJrB8klNq3uTEVfMSuVM6qleOhedOm8ZKIeRsxKCh54eUUjG0m
         A2RUkKwobyQVjV2IUhE4HT1JObRw3FLMjnlH9mUEtLzzJl31pfeLJ79VvhHd3ynhgd+D
         QBnQ==
X-Forwarded-Encrypted: i=1; AL+hErFSLd6kSgGmocgJ2CY7Pd3f4FkcCbv/aGErsT6e6/Q6WvU9ZH+JBw4B6XhGOpBRHci9oaflcAk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QXGhbleNTLkt52nhRjSimYZn3GI2RFrHu8rbfztd8t8hvCay4
	4TPI2lRASfLdFE1YE4AYXpw6peu0/6m40sJe/exa7y3nXR4U1HlwA38=
X-Gm-Gg: AZFdTZe1MY1nFK4KSzKRlRLaNlJmf1YLq8/LUIQC7dgimiRHWYE0hBpDz2ChzITCVSz
	wrQVx3TKZIiqNj68106aujkFVUm3LqFcFGUQHI1QUedvtmibGWe10pQYMZTxPsjythW9tiKRQbG
	sKqdIIdFjyZV86UzwQHS9ZKfuTNCZLUYzOSWWkZzg5Y+4uNWDqBg7yQlx9aXwSPbBWICSW7uPkY
	5PffknQ+za4rvKjTijRfqYVg60oCzCepfiBYqHJlmKoE99RfLobMsjs5xGC3p7npmjEH7NhYUT6
	eyjRBiD2a8HLoztwMgbBDtUkSA87aumtr2DmXb+6PJdR7pikyv5DAs+Zs0si4YRfdsguy4gUkBi
	3QY3fck8rmBk6jMkjhrePQBIVS9HNO0Fzj9qMtYLxiuwdurm7J0DrFVxAOTMX2wI3iQdnSOIyOX
	CE+QUuxLp3erx0j2yg5La++c/K4Fdv1260L6E8lr87lG9Jt6W4yieKvcH0sBlarQM7RKZpFHmhq
	7ykQHv5zmGGWdsHJpu2Zy+kZUkWC/6km+S3hjh7YA+0E6znefG9eWwE+R6ztEXcK5cf20atooPk
	lCvkR0i4qotEau6pGSpQqaTpGjbJ7j7j8LadSC/Hzrcler58yU4fb8gvrLtgfp+mBeC4d/A/YFR
	0zLNVe0v1X7vz41/uqVS5tipZWA==
X-Received: by 2002:a05:600c:674b:b0:4bb:6847:791f with SMTP id 5b1f17b1804b1-4bb8880f267mr111709805e9.7.1795234151518;
        Fri, 20 Nov 2026 20:09:11 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac65d.dip0.t-ipconnect.de. [91.42.198.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865a2sm143043445e9.3.2026.11.20.20.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 20:09:11 -0800 (PST)
Message-ID: <c1f584db-61e6-4dc7-b84a-6d3c630c0023@googlemail.com>
Date: Sat, 21 Nov 2026 05:09:10 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 0000/2144] 6.18.65-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261120055114.182757740@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261120055114.182757740@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.11.2026 um 06:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.65 release.
> There are 2144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
