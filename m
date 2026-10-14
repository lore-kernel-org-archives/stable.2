Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE13FE652
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006476; cv=none; b=g+T17goTrcUxXiLu8uymT7hhF9Y6B+CZRGxSoNY+YwWkVUopKYgfkoQUwv5UQ5d6lzw16IkboNE1do4NOaLFIi4JXANpIEi8Xl/wNEIVjmPbMX3lNGki6IY5lo8B5VHPOoC0+KA27ewKD6MY+SgCWWpA5uQoZ8KltiXLZMSpvaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006476; c=relaxed/simple;
	bh=MOW6D0kMBn3vCsCufgeAMRP4i0amK/GMfVl/UCveKu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWyJUbsXla9Gv3s+ra+yie2n+EccEEl33UVJmj68yOaQIRi7RTeK7NRc31BCwEMsBMgRediEduCDrzX2tg85eCAyFrxNKoSWW8y5nUNLtTSrmhlh1atN7AlDEIRcVRjM4c0EAw4XLdsuYQ3qKW/aYKCmYoWqJxBMXy9boPBShHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EbeEMR0K; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EbeEMR0K"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so27688725e9.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792006473; x=1792611273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NU8LV9dpKx/X09ybSNY/HI7ZWl3/GON7UI3V5fKSxxQ=;
        b=EbeEMR0KkvZ1EGdVXA20XmAma570taEXmEGCuPp5F1N7HNyGe19nd6xDBFOwH6G2cN
         S1Cm6gI+DA+m98fPw70Q2CfOnhAr/HTcEuWDn1JojJmX+aPtG0oytaCHsFFwJmowEhKy
         raOgI75lyxVxTNaohH1PhQdhd+hnbvQTYJPnbJxO/e50dBbS39ElfUDETNwrItKXzS/w
         Eduv3hOLGx//pEtuBP/cA0yyI1Qfuy1ULxYaNuyTEZG8b6oVPRTDjW/2r/o8eeqhSlvc
         xh7xpZSppTYeIf6/jNO7OcXhQIoIKQLAPIgPuoo48d3sUxSe76ZwYmv/lZZ4uKNLOsZM
         xyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792006473; x=1792611273;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NU8LV9dpKx/X09ybSNY/HI7ZWl3/GON7UI3V5fKSxxQ=;
        b=LgpqsqOEnpoyMxbRS0VEL0IYakewgyoD+TQDCJVzzHACHzWdQeiaOr9yYlXOy2+LJe
         LVkTlnQRZEiEayDVrvwVNIxfEWCRdrjMdkJrw6QPnLf3ILS1/lZXzZjV9+Vpal2+2kJq
         Qs3LoTxZWqQZ4fGDO84nACbSy/mmrF8RD19RA4oyydXCzRIaiqhahzhywAgyz6xeTlPg
         VToaHbKumX0kkd4e8at81eYrilRc5y0xDnRYU9iOvxE0ybUo1J3ZKKVW1RVHx/y+/X+H
         W0GqNfQm/OKaDshvBUmYfqy7djvo2iitgfvhg5ESzSUOcKL4vT7DWwpU8YXHMw6BfJZE
         ahRw==
X-Forwarded-Encrypted: i=1; AKwUvBySiWwXvH288793gIBJct4v++WsHvYEzOBGE1+vj15U6vSWbxemjo1B1BBdCTRZHct5CsBy6D8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvTz4UymMcybuGWEin157XDO8rwFpPugI1kxYLHa3YKJEjkKnq
	I8XZVHhgqzWK++nm2fEtBnDO1u8ww7Xv10C51rO2guSdg+64nkDcvgc=
X-Gm-Gg: AYBFou1uH4qe47z69X6PDjOkp8GbYTblUp8CKwoxVSyTop/0dZey8gNnYYxDMX7ZsDa
	qPTGIf80dD5zw13EZxOw4sX+eLEVMVouX3F8eXNm2KQ7BazM5Pxq44I5Ix9CFpnJGzATKKtxGLQ
	2bL3ZQqvBSfBY6BpmTwWDow5GFeX+1TKrQioZuZ7oCqdlgt7oOfXd8X25a11DsT+CYhWOAll8G3
	wkGj/yTDTZMZ7tYcg8SL0bpOGaIWWf71hkxU1xTE6UMeEZn3G8dXFdgNkbIabW0kSunFeYq/5hs
	cOeu5e3CrE40q6RarSYYSrNJGPUucu+yup7VWT5eVw/WKuEqugOV+/+/y0HFAVRAeptQyHqbro/
	Z3LMIBkOM1yYT5Xz7hIQ6mOkbbQ2wjnm1cBLzAY99Rh35QcrMUxeqWHUC7J/yVS1emNNzIpx/Te
	FtB36GsZvC8AXu0FeuugbCZYz3N/2Lf1kDVU7IHJYqzW2bi9HXH6WbuNGBCTYYh2dVm758xrTyg
	iQmdel/v+K857+evHMDiCB4tuYpQPK1VpPgBx9aBZ26FGWHXNY=
X-Received: by 2002:a05:600c:6208:b0:4a1:698d:3042 with SMTP id 5b1f17b1804b1-4a18e493143mr311724465e9.6.1792006472931;
        Wed, 14 Oct 2026 12:34:32 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acf7e.dip0.t-ipconnect.de. [91.42.207.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd66c5e6sm9984825e9.2.2026.10.14.12.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 12:34:32 -0700 (PDT)
Message-ID: <628066be-fc84-492c-8b03-1aedaefad4ca@googlemail.com>
Date: Wed, 14 Oct 2026 21:34:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/632] 6.18.57-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20261014123820.008483134@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261014123820.008483134@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

Am 14.10.2026 um 14:50 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.57 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server.

However, I do see the same warning message again that we already had in
6.18.52-rc1, and where you finally dropped the patch causing it.

[   83.881266] Driver 'ses' needs updating - please use bus_type methods

That patch was "scsi: core: sysfs: Make use of bus callbacks", and it is now in here again?! Was this intended?
Please see https://lore.kernel.org/stable/2026091451-gauging-grumbly-41dc@gregkh/

I guess it is not a big deal though...

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
