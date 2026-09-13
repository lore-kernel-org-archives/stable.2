Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4ED3E1D16
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294475; cv=none; b=Tk3Y8PL9beQN4fUAIDSCnHGmPCRAMZkgVmv+kfPkJI7mmeJjeLgRG/XH4zQoz01yNgZI7LlWR0ZRACNTUJ9ttRby+j4cRpkoE8lT+y80oGqNzj+xuwkkDkJnu8o+VLJ7CsU0Vm1Nj+inX/6azO+k1F7t7pkGvZCB+5TgBAx883k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294475; c=relaxed/simple;
	bh=1kt6d8FnC0B98nCUGE+SmlFlqx1hfYRjftBJJGy4rKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJPrK7/k4YwcJxghzaTuJVoempAH4JfYuVvUyIQYrgUxx7TtpFGWbz0gW2bdQrh5VtXeqkJlO4QMBXMvcxeX3WQs4auEHpEbf6biK0OYeIOnFNKdAuYx46u27PulxzBX739zf+ZPOWuzicywwuHZEBVEVn1hQr6sqV72K6Ygs2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Clqx9GX3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Clqx9GX3"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-485888b3c3dso2212548f8f.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 03:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1789294465; x=1789899265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wBMZeq61/F4p0+3rD8e6cPnmdSCExohBg4rHJSwrdv4=;
        b=Clqx9GX30nQfRdw13CbQdmyLJ3EhK4HvwkoYZTGLzSR3/Mtk2Ew+ckNz4qmxddu1Pg
         huqnoBcf6fEDZ1tlmBxF5TxW4woeVdBrDAtRJmf24ha5dyFkNu6sFC+baMU/gbKlEG1b
         xAgCuRePr7lZ8n1R8bnVfiuZ/5+jXWgbdZNsSmbIpLMI83sgGVCgQTnNEAlcMuA6bQYG
         2pUhbELxb5j1/cJ2qaUX7lQSCI0Mdu967gXzufRcWRbLxjqr8+IcDPJismyE01wayKhk
         vNK1sDKxtRagtK0w6neB8Ii9vS7PwcPK0VxY1ArDGXgblBYkCjJHurPHAw1oh39Oc5MS
         HJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789294465; x=1789899265;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wBMZeq61/F4p0+3rD8e6cPnmdSCExohBg4rHJSwrdv4=;
        b=nw/eJyjcCSgCurEJT+wTXQwQ4McINr2/Ew51QyCKpVyF1ikSX4RztiwsnluGHRhEFQ
         fwVxWXHhAorZ0LfNY56hFOghtU0oIaBFbv+1WjM5GKbCwtcFd6bOruPF5Yqmu2M7RUvj
         VZhtPJFIQVWsDoqoMMedo8vBXMyMtJvKjOaFJWUTjrZtVXtODPELItWXG5mwSIMrlVC7
         4wVqU4KjrcnBFR818NKmTpF/u/uaQ09a+1F/gnKg8Wip8RpPpBBQWuRfeWvebpAkD/8c
         IUyuKIqh9VwunqQq4cXLKzm51j/v93PPKPKkwXmlM1E90hoUFa2OkcU5sNRcnKfisiKJ
         ONoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdISpt9+NJS1d4IeVSavsoVPfMy1W1aP1E0VsMpiQNzRG8HDH/wsVzstFgdh6ciaVC/uR5DKY=@vger.kernel.org
X-Gm-Message-State: AFuF++ldSDgJFRLHQ2T5EGGVJnLc7BoX145PKHOUFanqNDPBb+Uwdbvu
	X+rq4YHxiO+hDhnt7hOZdPqRQbZXb2xq2kdB8qTqYC3x5gZagPXlCws=
X-Gm-Gg: AYBFou1uDByM2RglfkxAUtAesX/TEqveVTYywqqJGCdVujG/pjEXUcho8FOtFcs5arZ
	s20LhZ88toldmJHzr79ZeRZiIOtrzhFEnUSanNvIhJ5CE7VY76/U4y/C0TzUlEWL5cGniypfe7I
	B3a8lVmKO/EisOV8DsWTw9Hn+ZWX/VKMLE6twA5rxtXsIj+gBRZGVrfmkyAo4gIFqo2Lg32EzMI
	WpbA6rW/05mReppOJw5JYRZVq14hiAmUNC7UTvB0rYIqB0Qg2JaSP4Av3tnHuPwkGEJBv7yduKp
	Fd46mfQ2U350xsneawMwXnFRR7QUdBvOMTEYIXFuqcPd5wpv31Cb6V5JCo8iGPoKOwl6xXF5nwC
	R2m4Q4iZ4i1xC4JhUe58hWAUImxk64gBIAtjZw8U5Flf+gEk1DOxLxYpXp5Sj+wZmHC1IXfIteG
	secyZZl5IdxW2CaxqB1/o1INzFL0zFBHtRzkwcFrplVPUXqziouUpqWz+GiXD81SW9lGR9PwYWt
	0Xo0zxVTyKSMazVpxR/hDW034jnjjQphPOGC9SDLYitHF5q
X-Received: by 2002:a05:6000:420f:b0:485:8c16:5eed with SMTP id ffacd0b85a97d-486eb2f99fbmr13029738f8f.39.1789294464781;
        Sun, 13 Sep 2026 03:14:24 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4716.dip0.t-ipconnect.de. [91.43.71.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33e020sm19329616f8f.18.2026.09.13.03.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 03:14:24 -0700 (PDT)
Message-ID: <b8982310-19ea-4ae4-a849-537af8950117@googlemail.com>
Date: Sun, 13 Sep 2026 12:14:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 0000/1191] 6.1.188-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260912065548.086904252@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260912065548.086904252@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.09.2026 um 08:45 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.188 release.
> There are 1191 patches in this series, all will be posted as a response
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
