Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148BB3BB9FE
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785444691; cv=none; b=J3pB7hUXGOpNGiTEQ9KAF8qM1cbT31u1WaXk/Pzy8MSqLdAgziWq4kYjZsbXoG+mio2ykLDEfcH38kumD5orrCSJmmw7CNNWPPLp/Lry/XByS6EtmiaLUIEbCoz6Q7pCSlgwcZKEOgk4Xo/QnxbjUjNgZtgexNADbja6XSx5io4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785444691; c=relaxed/simple;
	bh=3osKIOz71fEH7drKlZVQWfTV2HiUZP173OwTV9Tfi0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwYlikppOU1ae3XaIn0paVuj5DYdumX7a8QtCV9j44rWy5+3fqu/MCQxs8zcUKlUHBm6RQiZd3MPEtdgeIhmdYOzaHm9vCK1+7mizAoouOaKsxauunv3e5XcOqeq1YX/MaanOYIQLmgIF5lRr659W4o2m01iGbAQ0dg6zbvpyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Q+sXmvA+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Q+sXmvA+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-496b7622a83so1133465e9.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1785444688; x=1786049488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vT19L21SY3sGABPS5hjyBZGXr2hM71x9vS8xE1q/k5s=;
        b=Q+sXmvA+0UTPElvvQ+7SWZ0GRZqCDMuXRRnq23mxRNDam6p3xL9N7A57TkDOkHLnUm
         NL566xzBA9DTk9aPAf3qfbXVn5czX/PoShzzIYE8C07YbWEBuwfuhzY9ZcOLAODi87nx
         VwIpSLyBXSdqqvh2eBnY7qHayRFtUJgPmvpZhV90H4LJQn8qBKzn0wMirAUpNvJa1gbf
         D663BzlrZDbFN2g67DSWPa43odQ/xs0YDERacE3OAarYmHq5NXK7PplzpVWeouJi1BdL
         Yy0vMsobsAHMFtL5HMP2mzX8O7IHzM4ismjAvgCxvwsRlkdbYznNbS77h3M4OEN4yAxs
         zETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785444688; x=1786049488;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vT19L21SY3sGABPS5hjyBZGXr2hM71x9vS8xE1q/k5s=;
        b=oMBs48jE00elSmqXLFqbICQ2Aa82rUkrJ8aaxQQgkAanQwnwwoGJMQhMSYIQDSgMxS
         iVe60cPJBFZKqtHhiTrNsLxb5ISAhhpw5cErF4axb9OmFWv7YPVFi/mKqQBOfi1ZBOzU
         Kwb212qAZHuEVpZO6mi1xkmAQriWnuoldYVvf6jSqpltodeI/hJU+G7NoPdUM1ESX92L
         PSn2YMpbqgEKviW+eC4kAvNt++GYO9CuENqwopNkB2PcV48W7XXz5WZrxUhMBrWYo9lA
         0FHxY170QgEgaJo6vcDkN0QZbg25kOICDMjjBnYar/5VRFKJmNFWFZVD/w6yh8WhMP/S
         gDOw==
X-Forwarded-Encrypted: i=1; AHgh+Rq26VVkMYD6f+9y77YjQ4ecKJC+b/W89t0TethXF8Zc81xafxCuZdiq3Gi2hnEgLkmoo7m/Pmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMaNTvfs7CvoolBSCUKMSHC2WVdPwxxUbK1OLGL2L2mcipJwwy
	omIBsHSyB/vUnCyTcc+rqTPl8euuR1IAQg4Y95HH/zD+fHgo1nkdn/M=
X-Gm-Gg: AR+sD12L6VUmGUIM2QoEHfv8coq8hQcgOj8H0jKCTVpdm/2CshjBiabJgP9i7L8ZAwB
	TA8iithOs421k14ydM69P/F3Oe9tBBMesX0qJpqg6LNqNd+ZzUwSMMFl//xFllvsH6WHSzpnD1s
	J5et2eR2nyYci02i0+T0KxcXhOgnc9tMUp9yws/ioDAmtb2FwrTcrxZQfzbvLXU2gonlAMx7d6g
	Ky2iBLqJ6Afh3vuo9fJb8Yv4UVKjYfUZUeu8rDCaovxyGj8ou9YQjHVyJRGsyOD1DC9rucX40Pq
	ekXVuX28d9aSYWIlAKze9IgQNgGbduPYxRI4TEjDWCFjORz3AUN+1yYN4b+/MdbuHzwiUjm6P+G
	e6FchflEev4b4Hn4d9zupHWhxBQAhLrVWKrSNUgOvckmVt9erHGk/olDg66LkyS4DT8Plo7sO/o
	hVeTGTA3Lfy0RuRDOY/Gi2bHzJgvoJKuYTdkXZhOeZknJrqJFvBO3jsXVNToxNEwaxxTD7gaCyL
	eBVM4vNh9SyLvNbdXe8FoEBiGcEhwIv8F3umWL/uKclGbtOzXlAZA==
X-Received: by 2002:a05:600c:3b04:b0:495:4e12:6ae5 with SMTP id 5b1f17b1804b1-49800eae370mr58059455e9.26.1785444688145;
        Thu, 30 Jul 2026 13:51:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca7f.dip0.t-ipconnect.de. [91.42.202.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498010aae15sm91717105e9.13.2026.07.30.13.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 13:51:27 -0700 (PDT)
Message-ID: <2e8563eb-71e9-4487-a881-3792e791f47e@googlemail.com>
Date: Thu, 30 Jul 2026 22:51:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 000/744] 7.1.6-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260730141444.267951807@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260730141444.267951807@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.07.2026 um 16:04 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.1.6 release.
> There are 744 patches in this series, all will be posted as a response
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
