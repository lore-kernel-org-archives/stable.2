Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CBE3368B7
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749766; cv=none; b=Gso4+7XYb1hhRFWv9IIxSyqQlPyGNgPuG/0wKBNwtbDUucj8VGsSc7dtdkbd5Ydi8QpqW3GydlM/Iu03zPNENQlgTNRA0oIJ1JUZ1XJTIezxL+OOZdSDM3ZEzg1OokqmSVr+TY7mgFHNgZ13MyRpY2H4y6UWkWenaNWBBsjmTcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749766; c=relaxed/simple;
	bh=UQxkqTK3/1ZsLFibCpvCrUBH5dRiA4vZDvb8AlwtX3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xsx3Z6n4lltYs4uRe8MFMhE+vZG8ECY0giRSI2tAGzXKlMcVJFNlS0u+fs+rcVTLtO09NICn9nj9oQPAkRI0V8fwnx+lZge4hBKF3A3Ai/dbyGXEYjauhusIMz08INwgSxtq5IL8MNtH94jgLbSP8GQWkubSnYEmNCLH5pOxlpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CEARBxtI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CEARBxtI"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15e2dab83eso141398566b.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1787749764; x=1788354564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6JXi2pwwnfsDJ7n9zXvp9v+SjJvo9VFU+ep7dFFjZug=;
        b=CEARBxtI5JNQMbb8P4LCdSZdQJEDI4HCVUdJlQThGR4EcXn4CO9v+kGpGjwLWGZoB/
         ChD6FLhvGki3uK6OZVgij7MVSpYQhzB7XWNdA2smGrzRqRfdM7yAl1LMPvNhvOULVrKl
         4NVE8krQaX2DVg8Fo40hx5OxGKU6oZiT4QGQW1L7/b9l1zPKpnG1w0P2XvCA9rKCNWxR
         NuoMH8mQ7Sp2w3ThSGFVX4R4TiwsL/zYa8UH05FQ4eVxq6lZjwcgfrwM53fscV9TQrXh
         03f3b2kz6pGHrG9L0Av+4HlLLQnukC/Tx5tcmOHvVQNeE2ZLXDSrS1GrYc0CuW7YIxkX
         G2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787749764; x=1788354564;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6JXi2pwwnfsDJ7n9zXvp9v+SjJvo9VFU+ep7dFFjZug=;
        b=MMufMqtyYnkIQVZHO/lFYkkEh8zAgYEaJKa0U86B2mXfs1nNPTOA6ktN6Jv2wHPSLa
         s2sktt7qAsYtKsQ2KSjZSf6bjNmJGHqWfaYfx7TZP1dIVFWzUKUmURQaYNL/y78L1TEg
         TH7J7Zem1npeW4lKahMDxKpYaZQU/wFNEwcnvrV5ezILfki43AbJtDWQeCGaN6JpmxrZ
         Yg2W0uBJECkGiCLwQiUOKKp7L2ykoueHTgTI2Uxvq2/sJWarywouUp0akO6TwEGOIjbX
         QacdNpG1ImnedU6hhA5X3FX0q5ZZkbpon75a71z60XvHNXspNYi/Qmwdpw/xnSwwRhmG
         iK9A==
X-Forwarded-Encrypted: i=1; AHgh+RoTkszCnY9vVj76QEpZrjsDfmSJJgYesE8jtc0O+bUfFsoS9BANTc2s2OtF1g8jeOmIBfuYnzw=@vger.kernel.org
X-Gm-Message-State: AFuF++nd5rcJ2wv/J6bXouReyPFpPaJfydDx4VJBMH2VqjktCcfTHi0r
	16r+CNhLnDXQJqJ7ibtjsZ8rib+trk1JBprrH0hSrV7YiVo43neISNU=
X-Gm-Gg: AR+sD115hPR3QZayYsI/ZVThnl+ZPpGPBgpj1DFXl5hKc6sJGlfmW96EfhWEXMNg3KB
	pwUyQS2N3Nk4oWElIjxK8MQEckKPSsF/Xkox9O91+ssgjTb/8xi1B3TKlqqaHAaeDdQIe7aQw0t
	sLuGNV4nN9CbS9nBrxYtSaRxCwmtSCSJUVyB8hYDTDEvYhpC45veJDy3hrm/hU+X2rUsKgGnBLc
	bXQuTH/QXv00x0Yl9x/aU3ltqmFgPEwT6KYSdoSAkQp4gXWDO0FG6BC30oRNGdNxzkWKO1npYtb
	Qr/2K7td/bjH/TSd0a0+Pa90XnG/k7BbJuk1DuUmJsrUnGMzzKQT0BV9BZyVGCIlHGxXMDmzZ5a
	XAzHMfKU3dZVzs/5s33fleCwvUjGeOd/XujiT+dn2EBbsSUFUQr0Fp1dWwa+Vcvx5+jzh6f6J/T
	IfxZ1ILFu+TtHYDDVyaEbihcOEms2pE78djcT5AgX5Rk3ZVUf4oGAAG3aZvJALUMixi7UT+jx29
	NLFNDR1dPcGdWklAkFO542KzgxFnR1roXvh9+c=
X-Received: by 2002:a17:907:6091:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c250c408972mr942154366b.24.1787749763224;
        Wed, 26 Aug 2026 06:09:23 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace5e.dip0.t-ipconnect.de. [91.42.206.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2533945d0esm586566b.9.2026.08.26.06.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 06:09:22 -0700 (PDT)
Message-ID: <ed8a1a2b-c375-4504-9b5e-370b2ccd6e08@googlemail.com>
Date: Wed, 26 Aug 2026 15:09:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/77] 6.12.106-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260825132541.580275153@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260825132541.580275153@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.08.2026 um 15:25 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.106 release.
> There are 77 patches in this series, all will be posted as a response
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
