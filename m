Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B915B2D1F7B
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792302854; cv=none; b=nCnrqwG8iXfSK0Rv9GUX0Wr0VEGiWOrL4RxTbHBAvz9vcS7I7bFOCPk72w2h5AWBIE/SJ0dStS5TeAFYpHJMIXLEmdmd7Zm8Q/6ey0oqEn8km9EBeZG2OP6vZUY7bR+6IJNscJT6NWtKHFI2ze19qQC3UJPsVhi6HXVcfhaL+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792302854; c=relaxed/simple;
	bh=EdPcVm2BdnZo7LqxTWBGzpYFcYxn+421Yy2CZBIkVoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k87xTM4OVk2DrzI2vBpc1p2VDl2C6O32c6fCz96CNDONqUcHJU3+N4cDl8Bn6CJXPbmJ2cRfH98ZZ+HhyXMZdMSs8Y4Nky7vAqBE0DFWhZdQAKLvdT+MjG9GatY+RdLJe3yqOf1Gel09Y0OzEbMQS/p2tsWdGsC/rH2+Hr4g1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XjBjZ5fN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XjBjZ5fN"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48de6a62a4cso835551f8f.2
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 22:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792302851; x=1792907651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T4lMxErc8YOBMSPew3QfIeHbs46LEjg8tsqnaE0Su8c=;
        b=XjBjZ5fNLXBXWJjIYi5kBz9ETUeIXGwgw3ReThJIxmHtCro06cDkjo8wpkWlt+rH2T
         GKhTyXD/wKrqpK4ylljcq903dtSmVSmB8GnWPhc4UL13Wdu3oDqpq6DNn0awL3yi0ndH
         cavdVKrZ8rp1Ac1ESNds/z5VpHp9rEfPxioJ5q1ePniLNTEMh75QujMDzUw4g9bnR/ma
         Eqm/JkhxzBeamhdUFCAX3I1SxizdzOVALD4sa00wNzLjun+4NZzGO75evejUffjcmPTc
         Zo1hE7h5fCgwCckh0R69P1Or5RLluZwW8xCgyD36sTE4nAetT9zdqnpiqLheFbeT3QDm
         sSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792302851; x=1792907651;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4lMxErc8YOBMSPew3QfIeHbs46LEjg8tsqnaE0Su8c=;
        b=BnsFYnhcrf6hOWixtvhBIKnq5AzKo++w18G4vRNNOWU2G2tXGs6P9lCQrxaZnWZWFO
         GuJX3sMQ8/Uz0KySUSo8WGP2CrFPZa1TVUgm4vmxH4dNMXztHDZgmqhkal5baeuoWdFc
         t71j6mJeAEjNMYeW07VK+oesF4a9a98pOordbMZYFpBpw9knGnwEotavytuNb1Pjwqu+
         HseDLOoa6dt4vmkiC7egNDW26KG2YcLnP36W7/gS4S5N23TVWM6dt/UECQ3VLd/QvsKy
         08bulQJR7Oqim4pik3E9RsKGQiXo+1DvCf0pxVlNm8fx/xz5aQB85ZVBbqfIPc3qhurY
         YAbw==
X-Forwarded-Encrypted: i=1; AKwUvBywAV97uYHPZyjAnDxxKBTfILy2to+aIZiG/zQIeixrxELalEAEBzKyJ4K65eYSoULwJ1XhMiI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpa7GZDfucsBa5zZy13KszFYL/Kr+6n3O3Php9bCWvGecjUCWX
	6cbnRLLBqXbhg8w9ZhQ5A/45EHcLkz4XPjoL6Z5jQI6hhO32h/iwjME=
X-Gm-Gg: AYBFou1UXbHukt1g3k9xTUtUfelj4lMaR5PBDhjM/YGH/jIlMXAUdMfQEpwnBHVFEii
	YGK47bsJs8KFOIPX19f2AooOt5nbYvlkyGy6UHPmsRL4DEw8Y/YdPwunln3ve1hVj9U2S0ZRiUz
	eyH1ovEMG6GxzL4CLEfvi6ZeoteqJUqXaOwxV03lVkzTIB1vOJQ+cL9fDk20TnqGtk/stEKKAKS
	dbqOeLaElZjbPyos5mawzzTbAbV6t0ck293uWUA4edEmeWt7wDTYFJx8Z3JIQeZR2xKflLvJfYN
	Y+k3hbO3HoCioHygqfx1UO0NXCQZ0LbBPgR6q4MXaJTHeYZIdDPp0Vx3vVFvlU7oJbk4Zzy14aa
	2YjN7KMYRQbK45iYe7VTsOVfgTlVG5q4jBeAJxvWLBjnE9XAnPa6uvfBZvHpF+2PoeDaZwxeB9/
	a4WOCrqiGirxBuRNxf3tPv9VcWUC/U6c1aFxGanSMPLdHGSCZs0iT+E0hx4ML20jgnL63jcy02T
	yxzU2HK7wn3nLCcItV/1zEYrcbxKKDPkfvvcxUQ4yRlolfh
X-Received: by 2002:a05:6000:29c8:b0:48a:fcf9:acb5 with SMTP id ffacd0b85a97d-48e07988970mr4036344f8f.2.1792302850733;
        Sat, 17 Oct 2026 22:54:10 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b14.dip0.t-ipconnect.de. [91.5.123.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8bd9sm15448129f8f.35.2026.10.17.22.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 22:54:10 -0700 (PDT)
Message-ID: <827e9f8d-5654-4964-a999-5ce94bd98fd4@googlemail.com>
Date: Sun, 18 Oct 2026 07:54:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 0000/1674] 6.6.160-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261017160431.119607952@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261017160431.119607952@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.10.2026 um 17:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.160 release.
> There are 1674 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

This rc-Kernel crashes with a kernel panic on my 2-socket Ivy Bridge Xeon E5-2697v2 server, when I boot into it. Will 
bisect the issue, but unfortunately I have no time for this today, because I will be off for playing a chess team match 
in an hour, and that's about all I'll do today. Will hopefully do the bisect on Monday.


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
