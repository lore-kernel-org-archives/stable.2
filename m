Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C74734F0
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831657; cv=none; b=L6dTzhbqgJPmRD0eum8LOAUX0+VLWG++rbtuzoQba9Ll0IcwJvT9OASv203t8oxo9+6r0hfsfORW6sg/XqtpSVyYDO2uqK1PxRzwgJTfctGSyaqkyqm3iZPzAjQbbIp9R4BhEdVepMp8/sVu3bIrQdAX11F64igr8fM2xohpwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831657; c=relaxed/simple;
	bh=6BYvR1xlmastehOVUnSWesvLDMiljL+lh/30A+8Qi0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYDXExSiUP/r2FBBGhnqxKA4PHRbSxxu7qQHfLjHhN31PtlEjACh8T5Br2lrmq7Gt0peLd0yGts0SwT3C2x1HLShpnvzOZNWPxdOO1FWO2jCPo9yjdZSZXLH42fdKGYZm8T1alPWH0MqSKzN5sxIJSPsgMYvJxkN9VpOQOYXDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=soApeegQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="soApeegQ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f365afc5aso612866f8f.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784831651; x=1785436451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EofdiDH+aqgzOU51jG+bu/UGsM0Cml3C5C1OY1sI1T8=;
        b=soApeegQJBiO9oNG5z1uuRGXfgfdGqUL2dP5WTwqQatHTZ/xMe13iM/1CO5IFqMhH8
         XLYg8efCuwc+dx49rDNj8nL4eCSFyoc+xnT7pPDHQl6M5Xl4W3PN3ZHbMTV/PUf5EgIL
         pDdXh0RHMjaHsoI496zKNrNDKhRzxeUcH5IQ1IMNrhGCWViwG/YVu2Po8jDRk+/jpsqQ
         DFedEzHNOZQm1yIGgWPZTfSx15sglXE4zJsbvJMJicHFAwFQnx2jwwfJsw1e91u5enpq
         9dtTlIl6HO9Gos0P+F22KP5kbw08wM0fv3E1aAEwpuOU0HtL1jrG/E/2tE92QepzyXr1
         lHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784831651; x=1785436451;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EofdiDH+aqgzOU51jG+bu/UGsM0Cml3C5C1OY1sI1T8=;
        b=d4N5WRiZcTr+E1wv5IMadax+W2UX5SzHjINWBX4QG+eSdCSMiCqrzA4fesBLLdIr2h
         QQfR9VA70Hlp/F6UoTKTMvr3A8TS7q2RhcSDnkiHjG1T0KL2oKpgac9HVl8jgLzSakl5
         w/qTR3oCavQaLu+Vaj8JTkSIciXNaLPNdveBDhSYzydGWx69LoBCCae1Bc85Mt0RTWYS
         M0D9oGD+75SknJORBYMKv9cfvUFWoymVYPZUK+czq1m8518M8ZzVpjKee+goZhXMSAB9
         GkA0Pl9K1b2tnGLG61AX/+9lkL44x6AYCU67/tRlO5/y3b4gRmksbz6bIsr+/NlP8uxP
         buVg==
X-Forwarded-Encrypted: i=1; AHgh+RpefuiY0vY2jpxN5ie5w85vdYbZIXvHXSMLEClp77Hj1shtkQenoa88QC4Xln9MFPzy5TRChEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgXd4yKNzl0XOz9NpJvL0MviUkxA+V52dNt5xlLpUEXs+Co+c5
	d2pViL5hjnIXhSAHxk1hREywuzuCAFzVFDK8rXBLhQ3IUXTcTWDipJQ=
X-Gm-Gg: AR+sD13N/UE2DuQ0cZT4h3CUgyTvIGq1hgncinx+byJn8GNKuMl8CxPbGHjMpwKrPg9
	oMLWkvuKSFdrtFcaiglCtRG7qKVZAGApme8pN7oBvDbC103mmxEutkT6epvXH91+7Aa47qrnCmv
	NC3a0g+02/js9ZfI2PCPbtoPYYOp1nEXwvVFUve7LbuPYmmjYUpO6h9eoaR0SKmVf5VARBHqu3C
	kzhsLbYiw4uBU0UBbh2oyE3qCKeznI43MrBhIczc3fmo4N0IAh2sjthFp4U/ntgGyPpyi15ewcP
	Gklax0PvfkT00Ik6ZD3RQnlWdmE0va1ejUkHCSUBZnkH+yes13OkhfPxVD1r2d3hKhvVCZ6aCfI
	TDP0WTgG1N4rSnvIY5KShSu6n+6FPAFYrUJC53wXqdTimMqtwnA+s7oDR/NidBfftgCgXkej8ht
	DNtbfJSkTswQ7tqdVWmn0RxTibuV2wss8snhOEmo/64QbEcpbJAXpTJkE=
X-Received: by 2002:a05:6000:603:b0:47f:81c6:5a38 with SMTP id ffacd0b85a97d-47f8da66b09mr5694327f8f.18.1784831650544;
        Thu, 23 Jul 2026 11:34:10 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acb97.dip0.t-ipconnect.de. [91.42.203.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a6d7sm19103319f8f.2.2026.07.23.11.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 11:34:10 -0700 (PDT)
Message-ID: <daab158d-ba4b-4e66-ac65-00ebcc3969ed@googlemail.com>
Date: Thu, 23 Jul 2026 20:34:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 0000/2079] 7.1.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260722142947.085426486@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260722142947.085426486@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.07.2026 um 16:32 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.1.5 release.
> There are 2079 patches in this series, all will be posted as a response
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
