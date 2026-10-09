Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24BB3D5C32
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582026; cv=none; b=FLrFPcuA8UI2TRIlloHnQi6dyEXTYlO8WPmZUH6aVTAcOnqXaFh6PL1BczyQ6UISQ655uADqTJjRmW6zW/qncZs1vq92XFQWdnGD7on4Nw2EnDLs3S5t27AggdMraYs/lHvAXNXFSWo01Swsoaa3srP/dK9iIDFhKBrJpj7podg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582026; c=relaxed/simple;
	bh=GEDqi6cQqEPhJR0cVLsj6fg4aKUXmns5XxXs2jZVVBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euaLkM77f6NjUv6oNglDGClGDQTWYQP9KVZw2hGij2S0/7JGM6fhkicfJi3tkHDsVrdig6nEzuJLiJVC25rLIVVlcPxhmqMDLY413MDi4v4AgvyFEDI+xTkh7RGIqFAQ3lrzqxWYINcrCNZ/Z6JoBzA//2788QOVyYHfnlaa/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZjI15pq9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZjI15pq9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so3416555e9.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1791582024; x=1792186824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XYNRxEaVrIcFOPoWfTYwk6GJOOGVb1oRxSuSiudg7mM=;
        b=ZjI15pq9ILESwcVmVsNj6ThEtCE1tv29V51LOzwKtEDsDmSEzUp4zoWYCHwvQK0mTQ
         2WCsSi2zQTc5Ntu0eCE/KLvXof0Pu/6xzgT+GocoKwMLtMTjBYC1pPOwGUcWLQJcv6co
         zfkv4go4kSp/E0fL4snBpwe2EodksJY7xRioyMZmjsuzwEX4jwlPqNZime8P+ACRDRQV
         8w8rCI2GMYJLhi1Htd5ZDjTpzVY2OxGtwRaLzHTIv5TOPqHGXSKAKZ2K17WibkhEZenJ
         r0rb0ew9nykZ8kk8OiFBmaSmOylbUZaWMAJde7GLzMHLEK+K26GQlxOpiZK790FsKriG
         dF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791582024; x=1792186824;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XYNRxEaVrIcFOPoWfTYwk6GJOOGVb1oRxSuSiudg7mM=;
        b=Z16pN4GUoB8mBA3qahtovwDNgZpymcihpvqIo0yuEJ8AQFEwUO3bQ+KV77Oq85npW3
         RAvjQywwbIhuIvbldlnKFYjTFLFs/aaNaHzNRUzstKN5GpmwlHg4cM1NypbMwOhUnOEK
         ZmBKuTZY2ElxN6k+o1kIu9+DbSf1+r8igSjJB1WAlxFJDlkP3MPxq5NS/WagKxkztugA
         Y0WilAffWBceLQh+tFRXBChKaA7DLFYuBil0al061c5lgivT3cb/og0OcHXrJNg4Busm
         Er0Y8LxhbMgT2r1kEXlhRK/FyOvJi94tYaKP/eLzd10wlM3pR9zQeW2WN0/Z8oEAtOg6
         Tzcg==
X-Forwarded-Encrypted: i=1; AKwUvByfXxFY8G8f6pr7h0a9nw2awhFX8FV9DM6gnPt3OeXqlZwbpFBqdZbMSbp7jd1/ewYCRfEeQjE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQyocuJmXNVVeNbzLKvPD7KdywyiUzV3C7SGfEYjWDxJfA/NiH
	u6Ba+4zWu0Cu+dORGquBar+9/bJYIhOfHwYHM++auKM4cFMK9B7z0Js=
X-Gm-Gg: AYBFou2hQrHzV6Ii4Fddc7bPET6+9bvlMsgkdJbCRVYGGFhB/TDB8Niuz0XQUXa1Rro
	2fyf+jtazS8TiiIo0y+xQ6mfEq7Lq8aH4sZaPllhtRobZYvAKisQFKqomStG2IDBEyzx7AB6kao
	37Ak+1YWy0imFhOHR1SjszB6eyIeLb0g+1f6lfJ/VW/9W42nOAGFBuEIdGJaKE1hWFJ+eBYYdti
	Qc0GMW/E9nlYImDmb3OD9LvMyRAVsgmpSWKAUCbFqWQuQxiHDt7vwh/QsFkZteWgXXyL9sVWMf3
	LmjKHfq+WPPpye8eeQJWGfC3DDrlCDjpdEiNJUA1HK8PNGQ5lYniKYy+EbS6bIY3gfxOpzKX4UU
	qxybDp0qTbOMDBt+Egngty0DgrkfI9tl3JWvKAjk+CCOgbvv8TOtCdOHmZ9Pqjh8KFPX1vB3oUt
	vXYX/qwaG9RaFUXjSV8DmWES4evMw7IRhuqd9/BQd8XDYajqQIuFr/Nc1tIrUA43b91HZTDxGwR
	mOCnUsk/r11dJM1mrvSISMxadyss5Ofuk2gr95WZtQtEquJOA==
X-Received: by 2002:a05:600c:8209:b0:4a0:2375:dc1a with SMTP id 5b1f17b1804b1-4a18e4cb771mr62672595e9.21.1791582023679;
        Fri, 09 Oct 2026 14:40:23 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4680.dip0.t-ipconnect.de. [91.43.70.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18f3b43efsm91051495e9.1.2026.10.09.14.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 14:40:23 -0700 (PDT)
Message-ID: <0f8c15f3-702f-407f-8c1d-e64627294ba8@googlemail.com>
Date: Fri, 9 Oct 2026 23:40:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/403] 6.18.56-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261009140952.119038291@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261009140952.119038291@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.10.2026 um 16:06 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.56 release.
> There are 403 patches in this series, all will be posted as a response
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
