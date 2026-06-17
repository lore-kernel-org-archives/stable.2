Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4E3C8C72
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728311; cv=none; b=nfcWZFhBkDQZJIUqYVdymBP5dpBfSrZ758blb28/JEBdw1js4QknXlonrXe2+ZOTB91RhfN4IAhhDzun5bD+hW6HxoIOwctyEVqaeFm56epHzc1F71lrWN+Aqigeakn2WDpT14sU9eLPp8eeveCX9PYUDX2OJ7YhxWKFqTKSOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728311; c=relaxed/simple;
	bh=ilHa6mBWU2AoqymTSuxCecFC/tP1FzoccoWuRJlRG8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwnpdbX/NxXJgbGzOP+5u3H4UZlvCe2TNiLbYlvIOkAZqg4USyIKNon9rTlj5MfuqzGo901in/uYsNmmM3c1sshxGl+KbGPtLiB2luiX6i6WsDmrVvwN7zwbuTiX05FHQc35R4XNV5UKRmAl25azZBphFRE32kNvg1vPFUBB/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kp8oM1Ab; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kp8oM1Ab"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45eeba68948so174791f8f.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1781728308; x=1782333108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJoFZAgDnFS7dzERXVYf3hL3VCTnc1Lf8VBBxmJqE2o=;
        b=kp8oM1AbrcdjZgeio9aTaPDZcJaM0rZdBeyEi9aLW5PlIJvlbQTDoJ+01oZ+2tszUr
         q5AqZz0P+G58tRKBFDPLj14zpKaYdXoyNrSxNgQQV6cDVXft72vsiPSpSDQyAC41OnqM
         wdGQjXcS8fJvzTNCMYiI+lazXNQhDJTLglzvaelC5/3QbqQqW/8DaFt2F/G/JEwhyh11
         I0vh5Fs8CeOFLC3TTdv6mJIPX3Eolp46ZsIpN3fbhK/U10ZMYr/3ZPRHb3HeXz4vHR1N
         vDrYctoNijEUj3VfHCuEHey70IirhjH9CfKnnvlSp1j8sbdoEghyImbkD06P2GsTZ8Aw
         5zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781728308; x=1782333108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJoFZAgDnFS7dzERXVYf3hL3VCTnc1Lf8VBBxmJqE2o=;
        b=cXFXonKmKRHzKbXbTZVNPXXJ/BSKpVE6QkI6i2THgdU0esY4dC6/vlyHc3MQqmHsrH
         Y8+Rms4TmK38r9VarXXsQ+xmhqiLxCm1llm3NjkjBnNilzP/TXWOiw6PgBUqbeXmTmLn
         4K4pfVCWEKQBSA8i7fGDmPI2ZmHfU5tb14p7/0qvhYiY4vGTTjksqnmvkkzYt6ajO7w8
         bMculyD7uNbs5NZhaGp627NwkOi++AfJy6P5skCzE1N9/cIqnRIsMZYvml3TF8RZqAp/
         c/lxIZaasjgzCwvQlX4/MRPxRbM5Gs1cUtwOyy6r7wliL2pgfz8Unm8XWWBGq7/QbcCK
         gZHw==
X-Forwarded-Encrypted: i=1; AFNElJ+UvMACRYGltS6bFDiKHeJBBqQZbz2BEor4l2+7iAqTgSlJJ6Lvnx+7p7ZX0nQ9BzCu2Ln5SOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8OlVUk/OkgSn0M8Q52osgzwQteM9jU7MW3tgNeiYxhUYK6H1Q
	k8WjxWq0H8XPg7zh874z3/6YmMwv2xy5ejAOESQ5EdIGaRg1NkBjpVg=
X-Gm-Gg: AfdE7cmzjVGtGuYhgI+fftbg65p6T9bnHk47bKlMJGiy3IdHwCDub/vfB7088vgWSa/
	y9TwXGNq9HjUanBxdD1i/ObzGMr7wBO2gXm6rQeIVkHatpP5Ra3ie46+fglxMnuN0eldw/NjRsq
	aAgJispNERcQH6Ti83J/gyRJIAp1gSGobwuQGK7D6lMWs33c++ZuhZdVgSfZDgKOKyLZeEsHg9p
	82qaylCbtTK7txdEOC6axNmyuHnA1jVpUVKIOYV1A65qnbagROI+3KQQfRNjGhDkNYkjuJPmUej
	0C7ZDc8D07CdaiGfSOor1H34/5qFnySVmvNB7+EPjossj+VMg0ZKHYmLk0jphlJi3dcQJvUYFfn
	L6fzB2btYJ+P7ZgsO6IkVYATYGRQ7XeziQCyx4x3Z4Yg9OfcJgC5XjC98Oo5mjSd51X0X4vM78U
	rKKPZdwsh6yOtLRrjUY99Wm5n9iiEMIAVKdI+2tOukm3Apv20bQRUKzADlpzePrdXQ
X-Received: by 2002:a05:6000:461e:b0:45e:f2bd:2b17 with SMTP id ffacd0b85a97d-46238acb523mr10028940f8f.21.1781728307522;
        Wed, 17 Jun 2026 13:31:47 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4777.dip0.t-ipconnect.de. [91.43.71.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-461eaa0d1c7sm13523403f8f.7.2026.06.17.13.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 13:31:47 -0700 (PDT)
Message-ID: <f93fa5d9-c2ed-4c83-a6f0-3d7b9c792051@googlemail.com>
Date: Wed, 17 Jun 2026 22:31:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/522] 6.1.176-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260616145125.307082728@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.06.2026 um 16:52 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.176 release.
> There are 522 patches in this series, all will be posted as a response
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
