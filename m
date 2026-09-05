Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE481A9F8C
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788641355; cv=none; b=qE/FCOEGUVLbciaKRk9CIXebxrXUZm16wHWppVB85SlEc83Oi4q2A+3LXrgdbgirTEgdXGP3x589cS3g/HnTA1Lx8Yc0CmjbBtjTHkgA07YH9PM4/+WKsqhtPrAQQfasxws1RcbRsiTWVDBI0xqGhP9OMqQiv+qoMmfEgyi40x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788641355; c=relaxed/simple;
	bh=r/z0/C5tMQT5HZYyEl4B0b4VC5XYi8OOIGchid41G5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xr7c6AJNEbcH9avHdR0bdyolB0G9xoGBFfKzhRHOPrXKGxS4pEj3yqj+olq4uhBqEv/PeufYCRqjsGHhEcw1AEjiqrpl//sjJKTuUsAvTbyXV/jUss40Szw8JILZJQ9Lt1DXgn9wdtdlJQ+zzJY8F8sS2r8RADHNrIfqjqnmWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eX0Mj5uQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eX0Mj5uQ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48586861639so1548617f8f.0
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1788641351; x=1789246151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c1EfKIGU/Jrr5zV5deWFk7RgEC9wFJWZJq9htaal6jY=;
        b=eX0Mj5uQVqD3VT/85ooqJ/R7nPJyEu+8dXwH7ChxSYeCBPsfPoO5iIZSNOSml3FJQn
         Wna0kiMrbpfweM+BEMqS11VoAQSskMgsBE6G0+QDXzo0m23Uow6cLgluZwnPYPiER2V/
         U3DTzm/42bqfAVpwZP7NlykXpwRILiLho49aBDKP5ktXnEb25WHXBJMdnJ4XgJouCIBM
         sk4Xkrtk0O0ouOHFLET54kg2xLqfGM5ckFrWXGkFQoJ5d9l4e9I1jAnvg+7vnLGkvIv5
         Kn911h62QllZpIEQZXUqknSHL2bDpj230fjC0VbZA1rD4jTrdZcuWN4AwOQYzYtRx3BR
         RmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788641351; x=1789246151;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c1EfKIGU/Jrr5zV5deWFk7RgEC9wFJWZJq9htaal6jY=;
        b=IyASq1OvOXj8S8E/wEjxiwPYOVXg8RoGgPdZ2t/D9vLO6JGG1eGI9YoLbeCc4M8CEg
         lJ00j7DBHJbI98guq1ABgohlnraevEu3PTng1hchsazAWObIX1qOj+su4ohHoQ6qXkD5
         Cndk903/NVzV3DLA59476Z4n5kRMw4qtCkF3xIFrl+ZrTE7cUh6/XXgKepiK7hh4raSx
         3NJnMNmoPbkC41V+Y3tePTYeC55xmBaHu73qfJfQZNOqIOGLabfUzjf3xSQ1Na2JYK+Q
         BwAvhPMDaSLeNlwJ/8a5HOkPnPs//8BFQerQnfEM5d7yDereM9LFZCmbJvlWBzIgWHUe
         NdMw==
X-Forwarded-Encrypted: i=1; AKwUvBzLYaE6iqo1DoH9W91lAhEmb0Aop4jqSrO8Y5TwPJg81LxlChrXuyxJ1vjrULm9swShjwdz6LE=@vger.kernel.org
X-Gm-Message-State: AFuF++kGc09vp9YBfYOpfUNc7xYRvX0CP2VO2mK3WQ2M2jYUH0LVqu7U
	jzHEdCFseIB525OXJt91YUpiYKK8ve4oUZcUB4mIKAYHrxkXuUlGd2k=
X-Gm-Gg: AYBFou2vY/+Xa7/z92vRZRXI+B86eyUvZKu7hisDPnYwahAwXqGLqXRB5ip4ExMToO/
	Q7mNwPCpgUmMFDTM8xbFSEKS6NeHkq9YHuHc36ugREON/u1euWXusXAOy8HsXjEuGlz8h+7JaIA
	l43g0dhlFS7LCOaaEgyHC/Ay2guBdqc6nrLPSAV9p9oENjfxhgMtDVoMMbZ9eENCVt89aGmZXi/
	qPaD7Q1rqc+RhcPU2DGS9VIsNZA8S5HsOsXq60Qx+RzFwMvuWgNrCrRsG7MYlaDgx3PfSPNla4p
	LUp1FgNXpqmOFU759QsLfPTIMhwLrJFSyQPmLiavndzwi7+tgV5zUcprwgdKxfL3CFwAlM+0gtY
	Ha5RB3iA64ZqNBK2/tiry74dmHNXtOyBaWcV4107e3hGhfj7hBlt2pcU4WboHDjIh3KyUp3TMJu
	7BDYmWq+1V6KBL02wdWkt82M3jpsW/Ebeksj+M5DBaF9OwpVcy6+M6LP7a+Jm/OLV6bjsqTAtt/
	PelR023Vn+9kxRFbBpGQeH9/iXuV/KIXwKKt4UW
X-Received: by 2002:a05:6000:2487:b0:485:8639:d58e with SMTP id ffacd0b85a97d-485891e752amr13186722f8f.8.1788641351327;
        Sat, 05 Sep 2026 13:49:11 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acda4.dip0.t-ipconnect.de. [91.42.205.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883959f0sm17241259f8f.10.2026.09.05.13.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 13:49:10 -0700 (PDT)
Message-ID: <840c2d45-400c-4540-8238-862aa54a87ce@googlemail.com>
Date: Sat, 5 Sep 2026 22:49:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/400] 6.12.109-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260905115627.670276262@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260905115627.670276262@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.09.2026 um 13:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.109 release.
> There are 400 patches in this series, all will be posted as a response
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
