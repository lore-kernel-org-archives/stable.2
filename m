Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49123261B91
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341855; cv=none; b=pnhjv+8t6KeagqcJ+03Dwe1oAbBgA29Z1Vl0TxD5onj5juu5Bhv/OKWH50yRvtZcglgBZXrWKNgAULmdWv9XM6pDkXPSzEiXpNAEVOOAGI9JvY9TD3ORzx3OqYxYvpkRfBi0XNp4VEW7v7u6Pz2anXG32kVG7bq9P1GSN0eJGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341855; c=relaxed/simple;
	bh=96/NQgMuIUiAM5aW34TsMs8aBBGwn9GuUhMJ3ssBv+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7Ygql1xyRO0dlXlln4pD9CwZWkjN6ssiZHqt/zhiAwIUwpV+yOZvdPmOTrQasUAHVFU1vOItJGPdPuEk846ssWM54Pk1DIK8q1Qy8/bMLgiXzaeFpqQ+lgoJP3O6eBwUSRDy56EdenOxUxKyR2WT+m9h2RJ+kUXab1A79xSt9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Md4xSsYp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Md4xSsYp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so59023075e9.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784341852; x=1784946652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XxbtHvBwUB79Nj/7A4PM53e9/+EatJfE3PuQhJ7yn6M=;
        b=Md4xSsYpgBtbJfgYekl85aqjQCiXNrOfEj3Fl4iMDWJhSqUUdtbb5BT+4PNrv6npm8
         6bAQmLmsAm3B83Z9hTv+ztmJryjFmUf8ynFeceMPWMBv0FHQm0vd+Mg+0+wWonl8LT8b
         4nTisU/D5mF05N+DQ2MyW4ar5kqIHKAVuFvXFdgSsrrJOKHGrbqydnf5rUG1sEjWDRDq
         04aU4hejvGK9bwh685oyCF5L18TKxD23lxcArnwDXneXFzIT95GvzPRR10PQi0TOA1Y+
         oMvoAgXmxauAdOno28hXd0z6cexE5d3OkNSBv30JT8/0xUUtqhoQunFmdl4sbOM7aDVg
         eVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784341852; x=1784946652;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XxbtHvBwUB79Nj/7A4PM53e9/+EatJfE3PuQhJ7yn6M=;
        b=UGW9yyg39lUb9Pi5ZgNt3Cu+XDNFS6W2pzMpNyy2QDT8dEv4DxyhbzNxYdaoPij070
         9CoTFDAlRDZPEOHZJIfhiDlNv9SPJS5RlgZ3A5rDkflUpUzGFWtMFME1vjHvBybr1JPl
         r6fkALZ1g43TIM3W0qgyCok9DZRNs5vLSoKm6Nsj3AgrsmQuQnRBgvZ+prs8eGDHd7Jz
         1240ABHcWt6o6C/EViS06jFLTCrZyrOwvjLp+Xurd0oDy2fkzTpQCZFkgBNyRBIbbOLs
         gUZn19VLTxD4VAVSZb0dLZVuNzKsENwZ1dgWexQATme+GRdJMpMw2aUJcUeRAPpl5+w6
         nR1A==
X-Forwarded-Encrypted: i=1; AHgh+RpFITJ1t5xKwxGrFDn7czX2c+qOtRuGqnKRueQyx1w+dGIfpORKKYoTQmDhjuRxKECzGhMG1S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMo+1aDJZ+jII7+bAerFBVmN1VLpdsnuuof59u2rSwGe1LNuD+
	JKy9GWkCbr4sePQFwdc2fxagmYvgarvc/3QwvDQjdUb8+RKr0OJ9JRQc9Rn0d3Y=
X-Gm-Gg: AfdE7ckPCZaCl+ifRqtfSVsdrryjK+iKAsMHkqTF4oLlaGDZLGxYbtZ2le3/0rJTB2s
	WVpc+vpNsSCUxRrh0+cjBcEA4cIyXp8o7wOFFIGkrcriY9M7+DtDj8cgldm3DVS7ZNBsJTy6UNv
	wePO1JeWPd+sthbL7Rbe0zCo7EGqI76rWXD9elTqV2/20PHBj0xYGTL7gKiJcbt1smlP7j1Trzt
	IbRR/MwdEppvR1vjQniMH+WLumSWAcUSy7/gs4vJSyGs5wYUFRgXeaArEdMq2QHMER+ldIOq12e
	4xBk8djhHjsezyZPryI4MaSy5a+beDwrgJF0v/PsQe1mvjvCbYeIEhTvd1u4eeI5M6tpbPYjiBL
	aNZ0oOwGFYun26iiaQ7VAJSAhIyRifYO7Whz5qG3W3s96xSvtV4evj1DWIxZaqRsgA6ENqSWH0i
	/3piZjZnRXcY+nTwXLvwItJLPROruPaay/SicOwWGKBFQ+y1IhPURGHA==
X-Received: by 2002:a05:600c:45d3:b0:495:503f:cf9a with SMTP id 5b1f17b1804b1-495503fd2a0mr10440885e9.9.1784341851853;
        Fri, 17 Jul 2026 19:30:51 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4ae2.dip0.t-ipconnect.de. [91.43.74.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e496ffsm8993154f8f.3.2026.07.17.19.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 19:30:51 -0700 (PDT)
Message-ID: <119d2276-71d5-43a0-bded-a0a79ab68abd@googlemail.com>
Date: Sat, 18 Jul 2026 04:30:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/495] 6.18.39-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260717101904.922623678@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260717101904.922623678@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.07.2026 um 12:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.39 release.
> There are 495 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or 
regressions found.

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
