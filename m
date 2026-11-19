Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049506;
	b=5p8lyNu4DwVKFJo4WZUbwud3Eq30eDqfsMPnXHqT25+DF/iuE/YS2JneNBZgCH6jjCvw
	 P1M78kGQn1G3bjaQTLJTFi4HpUr46qcluvq4xFDhxFf12j2/5i+bAKBM9CzQwABhPyvix
	 nf96mSjSjnEo9lwiqSrAncEScWhzTjnkvqYwAn1AvtbjLvpgR44pEeCdgh+es1CpmnCkT
	 y56mTUVnz1uAorEYGByM8gNKr1BXHExbvm2YSInshzVXJAJHJMOypVE44kkf2Bq/Iic+G
	 7G+CHUt9FaWqQJTeORY2G0afMeMCfEaeJOW4CoNC1D1ESuKVVP4o82Hq8VYyLPJia0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ya32YBMmsW8Ze+/UEBRzxYHvc+64tNFlziG219hEuQ0=;
	b=5bzHYdXsQH1EkYvATVxzgOOBqHFX1o5gsYjEpqeAas3U7meJBT/ne+OYU1gsX7R069E1
	 Yerhl8MbbkFd+CkCZQoxyaGbaQZesrWi/7m7XPrxbZCZWE/9y9QPG3uFI+Lk3s5T+VYye
	 T/sZGEjComorQPI2fl17HTgbKfvhWXFUXkfio37tpb1KHVhABtiRm+T6kkEKD/sYIMmzP
	 DjVEq9bVEphpqKpGj6GzaozEH/i3XLRxS1pYOKKIkiB7cBFrIqCv8r7SuFeEBD4vN/BCC
	 6uFeaHyoR8V2oGZbSxzFTrTcuTAKIpOAsaQHxYfonG2L7d6uc3fsdClVFBlS0bLrFAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=dqFekl+8;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DAE606A333
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77DAE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=dqFekl+8
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e47347279so1007552f8f.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795049505; x=1795654305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ya32YBMmsW8Ze+/UEBRzxYHvc+64tNFlziG219hEuQ0=;
        b=dqFekl+8A1vtYbwxBLsBIuT8BHV3yJy0PAqLGYIrHkaOqRyivGS8Ysi+WuInLupOzn
         3WAy7RONq2rlsJMsR8n1j45AIfxJQI3nht1LJ4C5A8VSUiq/QXuonHJT5w99T+fMLfie
         DhyKXey85k4ZclPMB0+9jftg6tsUsOcffHMv/ijC9q8GF5GsV/uIKESbKtZ+HkUZWy7a
         oKQsKBQI3BZlEKd8FdbW0rk+VFvKkIB/gXS6v1wCrzF+xS9YLPGC45KOdJxjNFerJiZ8
         I5TefHL3JvBSsSYxX/QdEuWawkmitrPyAGH7WDt+n9JO0zL/7l3tU8PiX4xK0d78dOkT
         YeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049505; x=1795654305;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ya32YBMmsW8Ze+/UEBRzxYHvc+64tNFlziG219hEuQ0=;
        b=tKicIb0sNPHlldnH+xBhzRByj+qtk7j91ee8a66nmID39gzBcRFyCJnLNxNvCp8asl
         hdkgyejggo66z+cFTIrV7n1GGeZQfr4nKeWccN4joZ3Q8a9F8fhCtz0rWeQEe0l2MY3B
         jaC4mgS5GfQEFwQIIIqXj9zPQ+2VDrFZWfs6QJiC7cHqtcb1HwT9RTAg+dTgkOXYPuYg
         x7F7LtTf1GSLKOK2BeZL/TvDay1DJDJjtjeFt7JPAga5jt1PFwkCXkRcQd8hm69HfPww
         Asf3f6a9YGzZqGN8Nne5ccdF2t8mJ2DBPm5vLASOMKoRN6LBQjX6JCYyw9TCBq8xbUtw
         ojqQ==
X-Forwarded-Encrypted: i=1; AL+hErFOsRRAuLYDsVfAmJ2zpXWaQu2iG3KzVymnV4z3TaiAHPfZBXXX1KIp08ScL8GlJeSLP9dGTzc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UwRppjDyZ2tygZUDtGOhKKeMv+VzYVT7mgXx5EvEJNJzWZtOu
	YjWCZSUBJZ6Y20GEON37EQim4w5CZIsIlsVMRFNC3pruXHYQWBJuBxE=
X-Gm-Gg: AYBFou0cvVpo02K1b5iBZjDm0Q1JqqEl8Y5NImVakxR76o4XQlLAUXnOjRWuJz9U0rh
	FeMYfZ0B/wk4TOsJEPu8pHDgqPl7KAgwPOUVt2M43GIOpQ+jXpjW8y/VRbiR4eag/o3CNoAKiUp
	a6+KBWAo5Cq8/glndrVGkLpnJAbcLKac8M8o4TPCqkIs4OtxAOEVXXO7/b0/Vzvr/61J9NToop2
	CC2EZ/JwlzIMpObchZec+Kh0xkwFPDjac7ayTxU2Dn+rh8jK64xcFBQSjl3FpIoJ5sQZTqytRV1
	t1fh1Qf2oZcnxNe97LFDLIg2Mvlqka7Ve4XKZbWm+d82UKDaAhoNHq/FDzwcPA+aBY1KmnNV/oG
	+qmcfu9BZhHpFIxtODf/NQ0age5Y3An3Ni9qvkw97PuqcBhTWb1eeTYrSU0zkuD8SQFDEN5+Mas
	Wi2QoUBeMjID83DMqSE+NOyfzLWHvtNVn72h6fKTWB75RJ/gKPRo8i7iVOWqR0NtlcpMnKMwyd8
	vaRRtv7VQee8jdPYGmDQHeGIQoknpwlI2LTVFkR9xLA25ZuXG6A8srYmwV67ToAAEM2XPm82wPu
	rjd/xLt2b3Ii7+k+qmoEwMIlc2K1oMX5FelSjJsYSD00N8/bG1c5qHOMG7PRSvGL6t+xfU7xiBA
	5cLOdYQ==
X-Received: by 2002:a05:600c:4504:b0:4ba:7e6:53d6 with SMTP id 5b1f17b1804b1-4bb7da52ad6mr78902545e9.33.1795049504793;
        Wed, 18 Nov 2026 16:51:44 -0800 (PST)
Received: from [192.168.1.3] (p5b2acb64.dip0.t-ipconnect.de. [91.42.203.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb842f9348sm10626015e9.8.2026.11.18.16.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 16:51:44 -0800 (PST)
Message-ID: <a67ab2fd-505a-47d2-9689-fb4086377da2@googlemail.com>
Date: Thu, 19 Nov 2026 01:51:43 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 0000/1756] 6.12.119-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261118150007.957976754@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261118150007.957976754@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 18.11.2026 um 15:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.119 release.
> There are 1756 patches in this series, all will be posted as a response
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
