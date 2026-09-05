Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C73AA4E8
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788631659; cv=none; b=ZAJvT4n2QfBcXA5CWVUByi1KKslk2bAyGaOVP0tXhNI4kGeTZk6NYkbTDhBqHs8hhH8V5ryNdD0nf87e2S88kL2UcdphHh+xA8RTjuCXm+MWP1og2O0TQjjqNH9mWgwCuuFZTUfrsheXi5LTq/MOuVVbXgIpSbACFLGltBdro8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788631659; c=relaxed/simple;
	bh=nbv1eKJuOAUMEOdTIAnaLZ6xXeW+UqMsJKrxTU2H3vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naJf5e9c/PDzYIagb7WhAt91Ltfx5LsMFOVeK3YlCbEWot5luPyX6QaV9q+4d+qvzaUUxQ3y2KyLZUJpv3BjWGD/NHGG80IOK0BrSZg4ZUI6ZXTdGbjFDAkSSr0iOKGdRvrtx0KO4PEKXA/T8ukm93mB95gW9GKPH/debFlXfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=j6zkrTDz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j6zkrTDz"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4858303de5dso2586572f8f.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1788631656; x=1789236456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/Ho2DAvKn3GLqPGoIYnpqH3AGeUo66hN6WndlrjAOs=;
        b=j6zkrTDzYtHEfR8SR5EcYXLIRaAgwUiUzONDPWHlk3pMrzHBqZ4mTVfw8QpcCKB5tN
         QY3kJplIEKggLU9IUSZ3UNNx45MbWis64ZhZUhiNXb7tPDuEzTozIg4eZyVwWm1GMoVw
         7PFozrdLF2Y7rjMUxQ/ds4vQHxypH3SDAIrPRyHzaaFJMF/YeNRARjGN9eHvNgU6y4xr
         3p+PyjyYGSPmmT8mDoXymti2fzwpEw+b1nHPeisViyyCmk3iGmsqkyLLeG4dvvYx6gKL
         cxBZ4aHb2wOc1vwoNlz0Xl553qiYRhXZfS6mn5JT4/rCcBXfyK8fXvCeYUiW4Uu1DETt
         EFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788631656; x=1789236456;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/Ho2DAvKn3GLqPGoIYnpqH3AGeUo66hN6WndlrjAOs=;
        b=SCBFexAeoMjKO8Zi3XSmRAwGWYo7CJAMk98ZN8FPfQLW30EVQCqS8s1t+6srd2RIlp
         sTNaPjMq4a857Afrj/e3LkvHcBvdVzbRgb7JicisM0oiz4sWjGFdYPaNKy2eKMWobkxg
         uhjyr3FDdx5l8qSKjGMQhIs12uNHV2u0Etj2vTHasScnYHLSmJ3QdOWArn7bMLbNXFSJ
         mHdMK42a2EkqK6dkJqqfbgwHBsYYQIW+o7N/oJzqr69aQH5SuslMpIJC3vaw9OBdCHZq
         qbuS/5NOH5LPJAW2BRWh93o+3RnMZaN64+fGLzYdKqnym5prEpIp2juYYDNF6Z+bPn6/
         cwLQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9vnLO17xV2cAJq8d7GfPURT9YwtMj/6XI+DGW/EuQMJwffyc9Ls1ustRuDIOvT3dcVzzdHn8=@vger.kernel.org
X-Gm-Message-State: AFuF++lCC0pu2cT/pEBBH0slWbP7OFenQUNsTerJUFW5QDQi8bZagsxB
	cxAiqzpB0OJZowlved3yLmH8rH7lssJpJUPegsWyB/puOXjs0UUBzGY=
X-Gm-Gg: AYBFou1EpPpHj2PziEyyjD+B6rzUYDmctTaQ1litXwRvoXtE3fUpcgIy3yNhCzi176C
	TMF4GjnYJCxZ5d0FfJgEh4rYg/rQcfYQ0xhEEf/WoiMgPaRxdCqI4Nk8GQ8cZSjjWFnJLZQKXEf
	24Ru8qraBwj6CPp2ZuMl8zYGnB7YUrMADSwjxe5u9oFyFy5DskzP3VjddH0v6TpbUeXS05lHz9g
	vWwLlvoaaGwiirsTcB/PjomdCLqO4DPUaWGkaHgBgyK8C77DZm5lDYhQU+UN4g25xWYSOtCJxqy
	qSKyCjFSInEQCHhc5bwlC9j/v3LryJHxgEeX+RMWS/i1E5iAL7YP3M/jlle0LUSFsxSxBMOaz6t
	Z9ZmA+Lopfss8qOd44FBiZ/1rcirLmF7WlazycxipFMgnrmdR0keV4qbYLT8/ovJmK+9AmDS/Kb
	bGPx+WfbA8w0vhSMsGIrnxenfRRItL89uWbd8NL4D4oMY3Ef1hngTAvzNWX+OwCC2OjRpEOXEk2
	sjky81S4wMA0H/6kjWJgkmpJsvZn4aMXgg/ML3Q
X-Received: by 2002:a05:6000:41ce:b0:485:8c16:a336 with SMTP id ffacd0b85a97d-4858c16a7b8mr11206275f8f.43.1788631655591;
        Sat, 05 Sep 2026 11:07:35 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acda4.dip0.t-ipconnect.de. [91.42.205.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9b49sm13044687f8f.17.2026.09.05.11.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 11:07:35 -0700 (PDT)
Message-ID: <2627e60e-7787-412b-bc45-ed5d831a6bec@googlemail.com>
Date: Sat, 5 Sep 2026 20:07:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.2 000/713] 7.2.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260904045803.810145556@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260904045803.810145556@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 04.09.2026 um 06:49 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.4 release.
> There are 713 patches in this series, all will be posted as a response
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
