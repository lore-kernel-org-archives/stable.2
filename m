Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246961;
	b=nLDh4IrpLJS0/UKVpKum0vmNXr4+xwFJG6joA1jtLcdjc9aBTtXiU934IdCGI1HGvsv3
	 w/nDHH+y0HrLZfPhDzS0SucEwoIScOuklmxxW+jh9laQZkdTdAy0CENFYS92V0U1gIdVH
	 8gFbRh1cWjFu2+acY9+tTw80rJ85nFLVrJkDhAl9mXvSnf4F/E8l0/Zc/pXLxTVRmk9q0
	 olL7ZuJ7epdPM14naxvy1gifYN6MrekAlqbmiiZdnRjVSZ5TVJck+S6/OcR8oSzJAYvbz
	 pXkz+K7rCSVYia8HN9l39G64MC7NrgvTSVMExf9lmRB7VNtlzcTLU9/bFApsrQHIbrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hO5E56BpVRLZeIlxDPKo4f1e0ELUqpBl2C419IjueaI=;
	b=WO+BR5UKFw6N6aMl53jxgCPlDWZx57EcSiZuwTrzLUQiH/RUZydumH0bdegI2NsFy67F
	 H7gpa/DXwGyfJ9GoipsrxnnQOlN1JmcRdBU8O6rSeeTDkPI4LTfKyRxNo6PxYwbtL+Rjo
	 O/s6wLxaQSHZXHcXLZ02QxV0kjx7TYBx6LACILdjZfCwGxHKggbYk+DjEYqfkyv0OBfEF
	 9VZhl2JeJo8cwhvFrHALpemICpiiqwmkZ37QYBGqO1qRQ/jQHkOMfCxYP0nGR8h3IqBgg
	 oRIXobf4WxQXMNBFRVvc0ghkNukce+IwNjIpCg5qvJPUan+mJ3R3wbMEHN1VDps6dNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=ywGRiHsr;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2E2606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED2E2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=ywGRiHsr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so13191135e9.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793246959; x=1793851759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hO5E56BpVRLZeIlxDPKo4f1e0ELUqpBl2C419IjueaI=;
        b=ywGRiHsrdDOqbAi0eoB5ZKhtCHR4Av5xyohTJaf3SAFJjcKlDTzQqsHW46/K0DSdfR
         FGTfwdRjVIGySzwQ9zZrVRTag8+0MSgOtNBkVR0zgugh+StgPcTMrkPmZjTI16wRrWHm
         S3JRBRDo645vFAFXQ4G9T2MhioPBDnUJs5ditCr5wZQZFHZIM8kDIBxVLG0lfQd7gGdE
         NrLsbW5vZeWlvGEeTARum8Gct/obGoqWyOSL7Axn4v/bV8YkWGYgoUFRsUcmxwSMsYZ1
         vaA32lIqoEX01mpaXidtSzfhLYdjqJH0nAtuj/azfB1Pcp02k/ufU2SYPdyC5INkmNxo
         e3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793246959; x=1793851759;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hO5E56BpVRLZeIlxDPKo4f1e0ELUqpBl2C419IjueaI=;
        b=l2WjO1SpZgaV5xo6EzCwN8cI7sKvjfaiekWvEqo0KbWEIAqVh39T2J0LT7Ne1exCSG
         YgLRUIpzndk+Mnpvbd1zm60gQYZi0vOJfdLHnI36aFVdQ/2dUBRylpLinK3hgLd7Q+tk
         5OgmFBcsmYsK0nk5p19iS4x7dSTkhDFindBkY46SNPY0bYj2kjnBP8p19Rc+hGxLF0jg
         INWdjW54qhMAqNX5c6qf2W63pXynFnzm93MTW8a4B/UYY4DLmFtX0LSDnwTBVidf1I3K
         352y7WUhKyOz91ul5XZToluKwTvSF7njte2iHkmk8TPN3ZYpgQT5dEGdzPVPO1B54S73
         R0aA==
X-Forwarded-Encrypted: i=1; AKwUvBwsBISVa08n2RG2SfwvIeWYB0N7DiOA3jPCecxV8RN7N9DH9EIVITKCfEC/eMyNGGfoYnHQeQE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqG+SK3MrKX7G4QrYf+wH5DEEhF6T0gV8xsrdNdGg6o7GwqBd/
	ehHoSFTJswv4B1BNDX6B4YKdQC12a3PSX3H8pOQyGL1f3clcmp6Igvs=
X-Gm-Gg: AYBFou01XA0MtmQDb5vg5nrwSJWnDFzUo2yXJwJnwFuqzmN1ITXEo3s+LJ/3dAftlwP
	sM3c3Ojag8H4ngj8+jTiuFxEMYjV5ZwduCyT95bt4joewoRPvJ0BLVusLDw9N2Vw+GrqdBB02+v
	+BaGzHE6BbAB/KIkNJIsgwvzuhkjuCZl+hlPn91Ac+DMMVX/xdDDZIXXVbgJVGSPXXDg90RnP8a
	HeC/5BSOKIpKKHFMVIxoBbrE6xIIuQMB1Hckcwb3ubRN/dR/2IokNPMcoAaFqpOewnG8tqC+Nca
	HQKjY3xJErTdO23TRmPtQmFO+vCshbec/Cc5d+UliAXxylDcP2xNDw10FQu8HuxVVG3N05Ue6dV
	X+dzbBzcodf8Z4kRuC9j8tKTX7uZ1tyLQLJXQ5V4iFbE5pIeBO82bfQkgLA4kF9veEDPLWozoBU
	upUGsTHsTduCzBiuSmBUAG19rzKAPzowXEbu/1D8OjCNuF7ui+i49CboNwUdN6ZmPQ8CoinOJ/z
	4VFEr7el7i6tc9Kw+cEDTuCc316OLcqV+9rH/GzunUatIaCG0oxxO3rXWNlZcMypQwNBz/jif2t
	ITq1txhjbbeFQoGStFNn1YKX+1wkYS2ZxPRYF6/H3SDImF+yXFMVhLcKx3pwoUhBRhi29PjVLhf
	XcAyfLE07a0rS27YLfSXsT/BhN6s=
X-Received: by 2002:a05:600c:1f84:b0:4a2:9cda:57b6 with SMTP id 5b1f17b1804b1-4a966f20b54mr95998195e9.22.1793246959195;
        Wed, 28 Oct 2026 21:09:19 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac3f1.dip0.t-ipconnect.de. [91.42.195.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdf9bdsm30656919f8f.55.2026.10.28.21.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 21:09:18 -0700 (PDT)
Message-ID: <6be3fa06-c2c0-47b1-8a0c-cc96e5a38647@googlemail.com>
Date: Thu, 29 Oct 2026 05:09:17 +0100
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
Subject: Re: [PATCH 7.2 00/88] 7.2.14-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261028165942.107695352@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261028165942.107695352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.10.2026 um 17:59 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.14 release.
> There are 88 patches in this series, all will be posted as a response
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
