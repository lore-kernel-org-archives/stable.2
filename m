Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F953F1AD5
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809026; cv=none; b=nKN5VI64v4zEoST+GlFpWngwdfFSMfpKDGX8VrwROw4PRL6IPfoygCp0S5pK8gd+JdsNjFrjLNaCs70A7y0pCGzd+IpR5yZ48VcvXFdDm7QihOIYjHVcVLIYeWA6i74sVgxLNO+kCfbprRC3I/JaEwlzLkWxB1Iv4FXsNcooaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809026; c=relaxed/simple;
	bh=Hke2G+4Wij2r2NahZT9DM+vUuFtMN323JUACpTjNzGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rS42rIOoaV8yOwLEj8uqJnpxOUS/5CiIrlNreFgEk6wvoveeRfKoTS4FtPOfeSeqjEdc8IjNmkixL7V5lmkqR5YYJ+brW6zwcEFx874TkcMFH2F4xtYtp8O/z94qJHgJx2mtiaxRcolPriO9W9d8QK4Y1/GsB+avMR2osV4MVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=D92YSpCu; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="D92YSpCu"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so37732395e9.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1790809019; x=1791413819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lBtOSawkeFkXP42NM1qSxi/aAPisSJdBIxTS7Qmx0XQ=;
        b=D92YSpCueqj9+rmxrOFHIcZ6rUQxdBrcGnCjtgJlKS76lQGCLi5Na1wyPoteJJ/4WB
         u+wrSyCRKJVKX1sT+WJfi4qeXnw3mX3eYVC6gzaQH9uclZ7Azc9BpRp464rmaOJL5vvM
         DZVYz5hOdOPKrVz6B8erJQj84q+QkwAWgiYjlPUjqZscfYpVhdus1kjxSYvSVkwkrOQ/
         80b+34HDtur7JIxQibcWtesnRcxuERqpUIG22RP4IJ/o2lWWmGurX03m+vkecINGnFL4
         EbIXUKdHU5V3eyJ+/eAcxScH3VpSADcGC6j0Yg0MhJSKfMEebIarqrppV7i0Vw/r7QG+
         n1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790809019; x=1791413819;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lBtOSawkeFkXP42NM1qSxi/aAPisSJdBIxTS7Qmx0XQ=;
        b=c9Tf+7EUzN1NzD/laQLLIlwh4zN1bgGEZeXbMxlBxXvwNE4C58/sd6zVb1Jiqagp/n
         Dujvnh5hI+4xLD/OJOPJma90HBIjqZ/JOUVKBgLdYdjVjfqHGSyqqnEjfKjKA+jRUhZL
         izzDibsKtCpfiZqbTadWID0wmy3dvwOvMwzc2VqcR1XtxgI4SY3ZCHgH4pk/e9hcxmUY
         wxiMutSZCO5peVDMKluOsF3C0bBbDeBXxvPd3XtQms/o53PYtg6FqTqsPzwJW5uAomIa
         kiAUDeojEZ1u+/2+W9mqb4fqQ8eJAjqmDcPYGpKzFY1tJxkOnPZcJMBWeaDevV7TjzBP
         R4NA==
X-Forwarded-Encrypted: i=1; AKwUvBw4tYcgxFc/XjuAG76nNSZNxS9OhYRTwAnz13du5JY0oEEAM42pE1UOByzTbaNczcXUvv0KR4k=@vger.kernel.org
X-Gm-Message-State: AFuF++kLh/Viiij41exzdPDqMwJpf1OscDVUY/w2ooeP3LqdyMqTJbgQ
	7rd4eTw8XafptbOwIky3uWdsnD0zC58KpgHgUAiOq9Om7fSVMJ4cX0o=
X-Gm-Gg: AYBFou0az+IteP5Up3Nz3tPr07ye6JksorsWfJmKO/9oHir/0e9DNenCERJWicEUGy/
	aOzg6tAy3+Ym6Mc+ZGlHgaj99P2cGM3FMjzFFsxRp0sabtDBjiNTdzt59y2x138NwVL/Tg7lbfc
	oB31q6QonOeP2P+imttS6YMQ2iowQk5Ei7N8cBTfSlz7k6AzrWOMJm9CgNIDKRuI84kKYxKQQ1G
	62GYd/k2/qYnK6+BtF5v7WEOhfnNNsJQI+AfKKfAOBOtPNZ7r8YG+92SDXDSbvR2xxWjsVwW56b
	InOd33R+Z/nz6xhXnKHBB2gtDuyLVIwNaKsZAz9qlDHufmBGSqtILTCaqaRDymu4Kg0njN7ZGOC
	sARGEgKn543sw64/4PW2+TqBKL3aRZ7zsBy0t7J25NjB8HSo5Hw9pUhKsvWjDSQT/woC8es2r3j
	t0Qsis+GFyz2gIBtUda/S8Nka1a7yX5Z/89H158v2sgZmD0VzYYXZ+MnzgjcimrmbbhkzGSs5u0
	eSRG5cKBdCCWlCYDhZ1uelVlzMZkE5H7ffXpFI8pb3LL7TmEA==
X-Received: by 2002:a05:600c:628b:b0:49d:1cc7:5ec3 with SMTP id 5b1f17b1804b1-4a01afe7ed5mr45606825e9.9.1790809019416;
        Wed, 30 Sep 2026 15:56:59 -0700 (PDT)
Received: from [192.168.1.3] (p5b057568.dip0.t-ipconnect.de. [91.5.117.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f922ac4sm16784975e9.6.2026.09.30.15.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 15:56:59 -0700 (PDT)
Message-ID: <d3f4f4bf-9839-45f6-a3fd-e8b0062ad032@googlemail.com>
Date: Thu, 1 Oct 2026 00:56:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.2 000/457] 7.2.9-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260930152346.024115587@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260930152346.024115587@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.09.2026 um 17:21 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.9 release.
> There are 457 patches in this series, all will be posted as a response
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
