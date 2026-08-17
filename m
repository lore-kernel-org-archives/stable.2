Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94B43BDA7
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987238; cv=none; b=YkQ0MrUvhvQNzR4JvkBEb/fetkVFtA0lPVxWqjhu4goWPqPa9oLHF9gCKey3wQbuLW/ZHzZRhIF9UB0brfzWzBslB7DjNABjK/Y4zqFjltHO5S3CNjEUy/A50930bUHR3DB6eLpUlf2L6QgDZCZeF/4en/TGtPftZCCrOVmhheU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987238; c=relaxed/simple;
	bh=FkzwyK3KPZZP37ixbuECgtmLOwoZSJSYgIIH4AGLFl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTR/Rwgh1Ksp7T0V8TYYt3w7RuzlVhluELp8szNRIREGdBNTVGgUL8LpPywXSk47By2F4iFntTb9offoo/u3ElDkOPo+ZV2D+5cI4+x8Q98u8nwc1VbpZ3TcWP2cSKbA7ts0Is6FkRmXJb6nP1Awg7CDLYCbGfUO+lP8PUPvNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YHJPUmxH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YHJPUmxH"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso1166542f8f.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1786987235; x=1787592035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q4v0BK/tyq0gTbl7z9GFhQ9Wm9CgOL+/eWmBB0CzgUE=;
        b=YHJPUmxHsSPXu39ac2KhItDRINrrbQsiOz5UojJPIgdpm9NM7KUlCR8xjFskTQeinh
         vrnJnDvZxgqY+QbvNBosDYlCt7PNGJakrHOASEzI2hi6G49GzoXnObHV+umM/l96OFrh
         LSSo8qgxDLi4YkGPuAEv1H3LgZzzPwPQP2bYoO4R1gQ+bm3i+hGnE/QxSvd6KhRlkVtl
         Ke6/Q2qL++S1ygjsA4KsAZovYne2iHyp3j6QjT2SHobVeCRYFPP05w+0XoCk8rNLHwuh
         X8IXpBlVxgVdCQkjVmMpV/YaL+IGQ/84pMKifhyh+xMyJzFAuk7iG4tDM9DIVBBz5h4G
         aS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786987235; x=1787592035;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4v0BK/tyq0gTbl7z9GFhQ9Wm9CgOL+/eWmBB0CzgUE=;
        b=DYERT3bjKWknRGj/UrEX5LfGBlWvHReO9wP7TSmWXBfsB8yD+9NRbPPgT6EvLDkpjL
         wcfltNU12iboktERDGgrVpFP3NjEoyzJ67jASPA4OsQoF8WbAboWu1mOEo6r8jCb371V
         mXgquSEtAPHIzvAoG/I48jCiaXGR4INLjqvVll9M5gEUD2+rYhgBmpj1WqRr2iwfM7Og
         qLkLryhr41WyAtpcVEcpC2G7nRNP5zDEEArw7J3ELotoWl/FWow4mwNcqicnw1q5959r
         8GEITPUFf8fmbgFdSA+RdMlpPqPY64IyPGOZU+15DOtEWdv9RDtfjs2s98zZEBbHlDgi
         aPEg==
X-Forwarded-Encrypted: i=1; AHgh+RrJLeXkrcoE3/vnOCbaH/McHieVfeXL0sW6QpCf9InMpjvr3Kq/vnrxAfjt85wG4JSMZt3gg3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7M9kxuEL7twNBPvknqpgMy3/kCeOgRvxb63a/hYEpJX7j9MO
	sx81HzIFbeoiFivzj2nJjtBG7N31QtRvjv0Hbx0Ed4FSI6NVABAcu9s=
X-Gm-Gg: AR+sD132KmpN45DcjM2nuP3DvkwzkdWO9IO09RA2kcGQ8PDeLiQ/04ApsIhicTf9fu1
	qlb28WVK/wPnRoIBpOBFW3ACos47axvRxLWpM192OduwxAXiQzMJV4FNXdV9zaNuiAXuy5h8NW0
	xfBu/zOzGIRdtdNVbO7Yseh6IrVoiPpLZ168j00VXl/zyc2oWW+1qnVP+iCrFdnmZfeoBRkzkRq
	MdrH19wXT58N8xHRNsW5Y5WP+RUgs73M6/53/UcuVSeJ7DAgAvl7lS91lNnFXiSKEZNrfduOx7Q
	3As1zWapz2DJ7syAsjpd2vdxVkCk3hz6Xiia/Y07DB2XJiBneHqFzx+ns/InWBQrKAvhJ1uoihD
	RHY9kjD7GRc37f3gxWpfFCBVZuzD4jH/RFDr6EVop681tYYOj3YtbO1h/Z05GH+7PEcDKI/K3Ea
	kwn71XDCte50y60TPCeHTvQx6rto5+PwVugFUQ1z3QyP8fyLjNlcC6aYfYOAB67elSLvjq7Rj2H
	jWfFMb68QjpdXsjewIQ/hP3CfjIuebjAESnpOKG
X-Received: by 2002:adf:e002:0:10b0:482:a610:7a27 with SMTP id ffacd0b85a97d-482a6107a55mr5847941f8f.20.1786987235375;
        Mon, 17 Aug 2026 10:20:35 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b466b.dip0.t-ipconnect.de. [91.43.70.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a315d3sm5510095f8f.6.2026.08.17.10.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 10:20:34 -0700 (PDT)
Message-ID: <8cee667a-adda-4d36-a865-c467a71dae71@googlemail.com>
Date: Mon, 17 Aug 2026 19:20:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/609] 6.1.183-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260817132543.039278408@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260817132543.039278408@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.08.2026 um 15:24 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.183 release.
> There are 609 patches in this series, all will be posted as a response
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
