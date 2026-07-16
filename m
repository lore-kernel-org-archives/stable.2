Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E337E5E9
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784235414; cv=none; b=WpJe7eg9AeTe9yankLRFaIEW52/T+eNrVCCgznA2qXOeC+AcYJrbo0z5vRrkDOFSZNRA6JVo3rDVIMImmTRyR2YTO3X0bZPqIDfkxL4aSFNW7x7dlvFiD1ipFweKNGU0Sj/buiumNSRRlRA9vJnIKkoByg1XHPZaGRZkfKFR9JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784235414; c=relaxed/simple;
	bh=OzPUmT5iaZU1b+BnKa0fn5eBg8gtXay07Y7zCPI/gnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHE76MCjPCw/qBoZhT8OmwldXRuq4TXendP/a3iUG40TmtcHvENycbQkw6dpXfwQFYThpfAunfo5pINkdECp/TRIYTzCD5Swv/ZOiO1cr9bblr/XwhUkL/lM4HqQxs0xLTYsKxrsnLsSl09rLxS2hfv8aSKWt5gp8RuF4+Tc5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Y/PEptcN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Y/PEptcN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493f4638f4aso31821445e9.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784235411; x=1784840211; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MDJbJlewyjq6vxesHaZ1UyIxdgRbYxt4PQHjBK/r5VY=;
        b=Y/PEptcNSmj7LqTpimB6cCvWuGy9GAsjUikllKaYu1/pJbrC5sy653HJHUGlqFOPmg
         W/U0D9a+ffhVu5ufGHeArYoZ54qUbvfjSRZ8fWUYh8I+zJUALO6XM+wJC0UrEjNsnsI9
         OZOULOrFCKhBZNrHKDOJQG8ip4QpcbbK8Usj439lGK763q+t7d0iBn8Ft9rkd/WGUMuH
         bWfKxehhPqsf5eWoou7w63SCjqES+jQTt6ejYXtt8rEIXT2Jmq2pQ/xDs7Io2KjB7+AC
         tHopgcCLaqtGAVuaSh2CtMln2zlrMUBvL2gboeb764Mz66R3kNr7m6/9nYrXgTYcCIE9
         CVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784235411; x=1784840211;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MDJbJlewyjq6vxesHaZ1UyIxdgRbYxt4PQHjBK/r5VY=;
        b=iLAU1OT4Pupy9H3+weDPNzKCqXicbUkW5ydWr5sdnPzlJe8M7572qoBWdwEMEWsGPA
         WUJ9GBG2SeCHrWa+w0QZFTyT1FU0FNog5odOGWfZh2Cfhsjwka5/E1zBY60tHWlHLldh
         is4vCKOsVofwmVKecxtSd6uqz0kTjostEoXhC9r17vm0COc/sfMPvR0TOr7Lbv4j8qix
         vRBu8aZmGYuXiHM9y22o4sUWXfKNNqvrRhAkwwkAjJMzPBBeOfYXh7jKE1onhqkQXQW3
         kc5Ja/I63z9FOL3GegyKsVfvmSPoJB36aZcQbyM3RjfvnJzmHUSeyNBc+LCiDuAXgdfL
         NpyA==
X-Forwarded-Encrypted: i=1; AHgh+Rpd0ZkOsKj+g6VZ+JBYXt8CBqJ6z3HM8iXTL/9RSUs1Cbtp1iLXzQJiA9MJWnaVLnEIFTW6uNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBmPGymmoqLz7woDWORUDG0el2z1uBWgQnFI92gpsbmwytt9h
	wTZUkTMmAynKKJ1hoAmCP6X/hr53y3In5DiNVjGwkuC0poUgtuAC4EY=
X-Gm-Gg: AfdE7cnV9lJavb2N0ADvfSjqHOvqXrGuK7Jt8DoA0Sp6XW4V+NYiYjCNAUwG2IPVH5w
	ENUF66sjZOLFYJV9B3FGj35pFMPhwDDpWb9cptGzuqwus/0BBttvJWBanwJpPIlpBEVHK6eirzW
	4/dXpB+OVToi6UwIdRHR+ain72j0G/9LiFIkOzoCA8VMxBFE+fURdCkKZloCLaUo6DH1vVEebP+
	IJnTcxUvI5JB0ROMCR2aCZdhedEwzc9NrnTXDYiZCwQrs7NSQ538nuHftCt1XS/vj1tVZzRE50M
	0h9cuJbvkdP0u1Zp4n+nEnI52ZFSbhIxcNsjo5o94uQF89LHkFz4oXfO+GcjfQ4yL19zzToFNma
	XSUPbNqX8r29JUtFGjAG5tWqbbntqoT3T5Y4a+u4IcX27d0AknG5N/Ni9GKeTICR9kO9c987jFX
	m4cZzstpsx8vF+Sl+7s5LH33MlGPt76vT+J/MV7ggq3jVpOWsKkiaPYg==
X-Received: by 2002:a05:600c:350f:b0:493:f7bc:26e4 with SMTP id 5b1f17b1804b1-495483bff09mr9132235e9.31.1784235410739;
        Thu, 16 Jul 2026 13:56:50 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b44d3.dip0.t-ipconnect.de. [91.43.68.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464caeffsm25298782f8f.36.2026.07.16.13.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 13:56:50 -0700 (PDT)
Message-ID: <dab0da1e-1e33-4414-932a-0c99c0a58318@googlemail.com>
Date: Thu, 16 Jul 2026 22:56:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 000/518] 7.1.4-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260716133047.772246337@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260716133047.772246337@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.07.2026 um 15:24 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.1.4 release.
> There are 518 patches in this series, all will be posted as a response
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
