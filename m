Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1BC35DD1C
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783023935; cv=none; b=AmZvFjxIypBDeYeDwQwEt+VG/Kc2gSa1+vMSKAojwYlJcrvuH/nPuR3cR351ofZN0Q8idrp4fGyoqMGHntXGxlaO2eUFVJ9A/SVf0eaNFnLo52GGneK5spkPeDzwItoBppZJpc9uPqpfCs0QC0kc4JrbQQyGPWQyUgI2FLc4v3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783023935; c=relaxed/simple;
	bh=vLz0RP/pwjcvD8700PkIjsBrjDT44NCOXMuN85WlfJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCteiv7qdfOXNiNQtMlZubq/xD2fKcsBOInvINtQgA6FvLAJOJTgoYtYywgDGBBSmWklXmoGJC16/Q2zTEl6rTJXeFSJmzNTuiN0rLgs3itSo7RXjbetjmUW3WBKZSRm76MLH8cJ8Sj70EYk6GqOA2Z9XlyEUzqKGINVajxVqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gj7V522d; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gj7V522d"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4758bd3731bso774649f8f.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783023933; x=1783628733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CE19y7mESN6tMsAW2lIFx+MqHczMs9gwLQhyQhGrzrk=;
        b=gj7V522dwAIhhuC43Me+cIDlZRtivZoAR6zg1F3sTXNg2MthI4S8Ww9sChNrs/GS4k
         e8lCY/5BkP113qEgoYA6dYOjmgyZLfnIcA2uZaS2+5lMxY1IuWHD0J9wH0gIwTDs+7f7
         MOTfHvBNetlOhuLW1ogMBO5V9lvJYgkMLQp02whkFVtrjui8Z+FCrEpdMSHwGbWvM/q8
         RdqTHUoFVnjIatBlGMnm3gAQzFKTrLnwy2zEj9gi+Io7yY8CPhAtFMvVMnHKK51FuSSf
         H9wzualvoT6C93XwtWJ5nzyULulEiRnC3KwplPcF2RX7ggGs+wvqAydBZ9RsoAJtIERm
         DKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783023933; x=1783628733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE19y7mESN6tMsAW2lIFx+MqHczMs9gwLQhyQhGrzrk=;
        b=GKzf0XY9O3HywwMQl5iaZTAe2PR2dbI/22GbyTdxWxMmrGxqvNxeRvJWvV2aLFATIo
         a4Q0sMB9JyRYpReacV6QcCl1P+2WNaIjXs8n8P+KbnlZOSgWuGIiBQltN8FcFeoCdaGF
         nXR6xntH7n4sbl6l/GAgtzyR+C9F1kJtUyGeJmUB+dKcaFhwnNowOMUAvWbVwgJlF7/U
         0ax7mNhyXSTMfvglFdvuwDXroXmzm0IbGvlaJdgW8knvrLd71dq6QUfhYqZGimvGQPpf
         OrWGfhcn+iQEghjYyQtwpRjou7vFjZVN48AiDnxNYjy6v1iIoJwTNGot3goUiGsDoN5W
         O58g==
X-Forwarded-Encrypted: i=1; AHgh+RqVP3qpkIjfkvJK0I2zMQxKfqw752OTaCQ/Jb1c7qHxSLWu9S5kjlWj7s7IqHPuyBfHqsVIZi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzltFbdLQs8E/YlybGhQUyikzEdBMvmJ4ABZ7cGwDOkOPKThwry
	+pFHA/XSufkQWKSHCbheoTkD4+SgyO97mMUwps3veZifAqU3OlX5yE0=
X-Gm-Gg: AfdE7cl+XQ5zNGMibyPI6pjeCmbBpP5rVxvCISVQUh3Yu84KlJDypRW6rWwmPumGh33
	lOOGVj8kRbpvqkt4s8y9OTWPK/+yiLTCe3EjwrUpA3sv+6QuUFJQQTbELr/4HSx6mIoIbUV+jDl
	nXM0LgLN5O+qNrUptoGK+LecJm1yscD89hm1Q8rDA9FJ+6BV/Gfe1Zhh1FJQKbP8FGD+vX2p4RF
	0O0dnMugI1Ut9fsOLv86AlWKYA3XRqQSdzvgWSsGPQ3xdwrC+vydyKOabLSe0A+3ANyhDbtWi4U
	dp8pHPEx+8wacGyWazTAVdgUJr1rm0yIYl6V4SqnL9rj+MVSaRgHIQOumY/VYrB/l2ycq+6bzoV
	WSpv5YL5uxT7OFBOrtwvcCREnOIL14KzbRl9k+PDJxxD1uK/uxRn+juYUShUL1kQtXtqPmIP0UA
	Eb3XbyeUQYkeAW7BZCqx61z4YAjHLpdpwBFLVgiMPeJy/AexkIG96MTDmgIhbZHAY=
X-Received: by 2002:a05:6000:188a:b0:474:88ef:cdec with SMTP id ffacd0b85a97d-479347abc89mr2414532f8f.6.1783023932557;
        Thu, 02 Jul 2026 13:25:32 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac307.dip0.t-ipconnect.de. [91.42.195.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94cb64sm12216643f8f.23.2026.07.02.13.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 13:25:32 -0700 (PDT)
Message-ID: <eb95ea8a-7a4d-4e04-83ca-67242a746a1b@googlemail.com>
Date: Thu, 2 Jul 2026 22:25:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/129] 6.1.177-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260702155112.163984240@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.07.2026 um 18:18 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.177 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

So while I'm watching the Spain vs Austria soccer match, I managed to do some kernel building and testing...

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
