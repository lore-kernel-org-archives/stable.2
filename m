Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B947A883
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772833; cv=none; b=Hc4kEaWDS31rl7Z854W/EKoSTq1GffagKNvA3uR+4l9ThJ/LdhWiDDYiInzGX1uCmpu46kn5UP5YSuKjjYFsrVQ+ZOfL37c7d/ay3pNKZZB8GS2NGxJ/dxxsJjuHKt3zkJGPE5ecgBHNx+zgFj3VpbVfxIwUua9kvuT2+CykQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772833; c=relaxed/simple;
	bh=5OoHPncp9QD6PL7OJKrlnuCelFdwbO5jF1abK4OZpKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/xfl4qNx0lHCmNOg/3n+5nzzsaldAZMt15ka3oekmY1KC8nnfN02Rq84/7BjpMkElQKSDTESCsGLbeeqO3byYmgnr9XIXt5AcOQ06fT8tSITcpW/KyZ5QUy8TnGac3/QO9pcu0w8AUXzr+OeavZfpTh2tRqb4z/iMZhvAjMVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Vz9Qlq1L; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Vz9Qlq1L"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1c52d920b8so174159266b.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1787772824; x=1788377624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+83bvx92ZvGFRFIAdgfKyFZQ/ks4CIryMAh2oO7ljc=;
        b=Vz9Qlq1L+EsVYYP1MgMhYEADMEJGBcHVeH8M0dQnI2amK1zZU3mge9WcDAc7ZQreIx
         L2kABrXNoXWyaXmrjQgBrS2Oml6thhDNECdDBuFlkemD9ZCRlGtgB4He3Gk9WtN64s9n
         vevV9NBGpPE2UYU7z+Zcl53d3bWbmDfakbZknQ0uoyvzsbPYaiYMDM7vyKGDnE99Ec8p
         hR6ZApJrhI1FICd3RnnlEYEMD28QchmPUmC1esuSsYBRkaUcOTmdZSa6DksSbiOcmYgB
         O0xPwMbkUjkLKpZRfjXlg6BFbENxwLxE7hulIGEzRnnORv0KC2uGL5saicZQIdBz6MgK
         aqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787772824; x=1788377624;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+83bvx92ZvGFRFIAdgfKyFZQ/ks4CIryMAh2oO7ljc=;
        b=eI7gcuiqcUFSDy8y/52hU9gdpcVvUC9lCXWwy4/YHpUtWTuXB2othlJ9Jet4rcXRIg
         S3/rs+oswmrP9oVq5EUo494Vl3WZkeuALUpoDMNybvGmwm+koyzfS/YmJxPV1wp3g1w7
         92RThcSB7/JW74JPWh93AD4dHG/x2Gt/D0BdYokqhDRPwfH4Zy2shKDUoXx0AvkK6jUa
         M4KMTrQtyZKoqJgp841x8gTICaW5NLr1O7rm+5VQX1+lRTH4bJ9ZvMzLBnjZQvx0/86O
         8241LEt8SAdF7hhHsft//YPK/XrWBC01WzgWlwv3F6Um3QfIIMLbmmdmPp7M4cvM32+8
         F1Kw==
X-Forwarded-Encrypted: i=1; AHgh+RrBRYWJlMgl0yIXJ7Cix8MvvWL1vmQIUE40Kjd6gi//6kEpgYkkdydylaOnLrAcWdCDWb2ksqA=@vger.kernel.org
X-Gm-Message-State: AFuF++lJQckZKxHJSteuzxj2mcDJUCqZXm3LD7S2JzUPokyPDPEXMncr
	wArksvKmFzZXV7t+Q+wDC7A2dNtQ94iiKxbQuxdEWdCrnJM9O0Q5GCw=
X-Gm-Gg: AR+sD121haElzUJwvIOKUl2QhoaN/w65Q1a9arRTwN71Mvvv0e6vsxX3pZtYq+ut+l3
	SUgnly2SLYZiTiwMxHloruHqOqJgeZZtj3//igOMhwctu612/eaf08oREv1ihS0NFvAMOCg/nyH
	PEL2fCSB33nVeWmnipmo3Yyot0sjOVr7FfX7D7ElfQg6e62nbvEQFb9/Sqjx+tEJaqkFX3IQbsI
	qyV2+zqKTSrvOuNeQ0NUNeGSKR3/4jYZD9/CGtT3nHj2eSAkHKYx3cuqHxleR6gvrOwSDh4zCuf
	nztQdrvpZ9dK7xQL/JSoaNJDJitv4sQ9lnxFEbPw+GlODHiBmHBJfPo3KoeyouQ/yRx3MZVx/p7
	NRTVrvhnNTVRR/soXDXnI+FmNqSUPE8H1lnATjqunW2sRNtPzmEM8j6CYIRwshR3swtYqhYwyOv
	b/lQy4o1Qc+muRIaJu/3PsjfN+wDM8KOwDIUfBbMFyXa/KbIMjeeWyI50kUAOQSB4JHmuL+9u+S
	s8DkxomkvAo2joU07cL8Iv04UN9mvC9vw1kytU=
X-Received: by 2002:a17:907:84e:b0:c24:c24f:e176 with SMTP id a640c23a62f3a-c250bc30e7fmr984052566b.15.1787772823754;
        Wed, 26 Aug 2026 12:33:43 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace5e.dip0.t-ipconnect.de. [91.42.206.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a88ae4dsm842539766b.39.2026.08.26.12.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 12:33:43 -0700 (PDT)
Message-ID: <2ed27071-4636-44af-9b7d-bed4d5035732@googlemail.com>
Date: Wed, 26 Aug 2026 21:33:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.2 00/82] 7.2.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260825132541.560541185@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260825132541.560541185@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.08.2026 um 15:24 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.1 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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
