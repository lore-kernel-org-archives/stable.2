Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468230F95C
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438930; cv=none; b=DcjVfvvKkKgFBUsnkxe69YxPvXT/Uc30Xjj2GewP3pxQltbDASv04SNO+YMM7ESCgD0UE+NhpZZSj01GyWVjpkWZytLdfI9b1SCSSYEaZQt2YljlJ2DwDUJjV5Ka1zMNGS7FA6cTLbeqrNJ9DufVKUduBTLde9oI08AsGclPPUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438930; c=relaxed/simple;
	bh=lojbZy1RwbOgF4vPX/jUdyX82yx8NEKiG06onugIRgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHIpU0aRegX8gLXkXJdWWOsZARYc3ey00vtz7dBLTQOx3bJe9LRPtNjo6Vv8bO/5iTbZTUJTHLJLv6dW2x1+BphKgl6Gb5YVLLWqs0PZvcgOp9WghMNna91xu5bmJCieosm0GsclVebucWQXK27Yi8IDXQe7nlPmzt8NXlObJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FLHtYqq+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FLHtYqq+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f7854678bso33600f8f.3
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1785438919; x=1786043719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b10f7zQkiK/pqILj1qVkqYpjCdKGmpebJhDPH6RMsaU=;
        b=FLHtYqq+gDcoqhiPITmq2o6/5aA2SoDiEeOTaOS9Tdm1TKMiiQ6xdWvAy/AzpHPWYz
         e8r6kCGOWTEbeXihmuHaJoiilrwPHPoU+HgBIWi81ckAu4RqGIKJQpfeeRlvAfV3XRYy
         LES0V8LOqt9qCO+tCQrPtIX0VUjit1wuOSpLBXeVenTEyf8Mrz2sms71gU1FGCP4rPTF
         1oO0XkrBXXQN4/KIEsx9QVtugXVKegH5mDmenklp4q4KUidYwK6bjrOlMxtpLEzxLEiM
         xYIm0mcpFND2KnJcjlywYxIBsBbFCIy+4us37lLhSWQLHIuW/TZTWV2uBKWY/9XcdRAb
         CbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785438919; x=1786043719;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b10f7zQkiK/pqILj1qVkqYpjCdKGmpebJhDPH6RMsaU=;
        b=af7bEQyoMtWT5FjU0JauoEompr6BknXP0CUdw9UyxsJEQLnl4zGUWIS1aW7fw/4uj6
         738q85/R8DFwLwMsy63h8A3RlDvyI13dQVEKBvuVoBaABjnn1wKvkYvTMKXBfW5wzImm
         GjBvl52WO9FmWGk0Lv1EHgTHnxXDz+4JemlWlTGgRlvpHpFH286IfUS3DPW70Wnn8nyt
         VSsn/JiIkIErB7VNYDYNDoiabEi6kiC76FY/gmPCoFusFICp0VxlDgIRhd/tBf0R8vIO
         eZVFyNdWYBiw5h3XcVWTRdPQsC4RyrAWc/1vmn84adFySEsa0vjfeaB5FmWPXj6er5LQ
         35hw==
X-Forwarded-Encrypted: i=1; AHgh+RrMPQUbSVANBwAiKDvrjXOrZrZ7kPisqL3wgoKoPSc1oRed3ZLYn6z2C9uqI/2dtdFNiZDfhvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyoD8uuHldJslZN70ttGNSzbtCbQ9qHdnnymoIUula2FpGeVJD
	5UZMgWxjcWvMrcmr0Um7vo3QFKod1SkKyRuY3GdTuh38feH42MrkwtM=
X-Gm-Gg: AR+sD12MFMoqVOn3pxcCIL0zERHAgHI0jwAd7GOcsKPGP1Xn9tYug8SO2W0rFv57nEz
	QezUD3vXK4Xbd/OFUX6gqEeOQGT2QRtwHj5mGWWszE2JM/HTm04siBB6lMK+rxYCPCfpB8sglRC
	FbqL460SlSoNG5rwYg/fqa+eIsuWrr454IHKhl9NYHpWmPfcVBj3EPhONzc2MhqzO9u+KqYS8HP
	VScVYe6oMP9H12bGFQVJYMPE/r4PGTxJqPJv3lwY1fJWApEMg3kEbnP+t8c4cJQEH7mwlMeG95N
	X32/Qq9fERW5ECn2XgZIiHYF22UkxnBm+5A+9Tji65rKTi1CphqzZmZjVhSJJ/m3xxAkYadzg1x
	GQkp8QjUoib5cVF5MyBfl+3q/4o7c5WxpP2ZsaySYKI7jNJTF/kZRcdL660daLqOcqB819G0jcu
	xAF8QR6PWs+3zRlS26CJeprf8CnkuxEVg1GWVmwccT0FVKoXyu6ThRDvH2w/89RdF8pEoxHN3N1
	3kb8QMPOvsk6URXG8llJMo1LV+llaTIoke/ETUD4KCq2BT2zrRh
X-Received: by 2002:a05:6000:2910:b0:474:530:9d with SMTP id ffacd0b85a97d-47fc81f5604mr6403589f8f.13.1785438919286;
        Thu, 30 Jul 2026 12:15:19 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca7f.dip0.t-ipconnect.de. [91.42.202.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e3c73sm9028629f8f.10.2026.07.30.12.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 12:15:19 -0700 (PDT)
Message-ID: <d0831438-a21a-4eb1-9b97-13e0f2678a6b@googlemail.com>
Date: Thu, 30 Jul 2026 21:15:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/602] 6.12.101-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260730141435.976815864@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260730141435.976815864@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.07.2026 um 16:06 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.101 release.
> There are 602 patches in this series, all will be posted as a response
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
