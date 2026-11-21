Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231071;
	b=hnjYarsZj3Cl3J6ddIMrGCbqAsSGIv3I1/N9szNZLdV/on6rmC5iLJXIJUkuPLCkHcG0
	 xOv5Yk2XPjes1KezncDaOsifRZc27nB9jeM5kY7msvPs1Vvu7c5yjgQENTI068FdjQZPO
	 grZ6kglwFjhcxWF7EdR+hn1W4rYeAvR+joMCS26Lin31EusNnxfsQSZodcd0gk5Ra0B3y
	 H2v4iFZDAG5P2EcVTZjlxIzky9MV5Po+kn+/mCwgNuGhP3QQeLT0nygEj+W40P+QzKfmD
	 OytsU2oAKAqTSuzd/d0ajru9mlKf/+Iu1UJdu7zep9YTN9KffOdZdEnqJRMwCZ6vZpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ARUUOXphysUaIVQ+Q3NSspxOkVH0D/WM7AIA+6teiM8=;
	b=nImBG+DQHJNNH7KfJ7r5q4UY/q1dW29Luo0IMjP+dU6uTqJg8v8FUiYMZM//CibQFNAd
	 +NL+HYYd24sr41fj3J+6KJ8ElIfi/Zm8K3F68mUKB9dnM2w2RVZRGBHYa70XtyWECEOba
	 x8E6l+KLK5HBM1vseH63TU349AdtQ8cXL/Q371QfCWkZgiPVosTfK/COAgTjhR8SDy577
	 M6DP4TA84A9QqPzDp41X+jdlU/2gnGf5oiclOrI1/Tsr1HKDVqwupMkw47d+TbeoJBQIc
	 Vjlif4ujmAw15Sq/e8+kJub0OfJZVmQy5PYp1UBi3FujwIhjVYZMRhszDdVfZbZACgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=C9qEfKwD;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF73606A6B9
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 03:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BF73606A6B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=C9qEfKwD
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so16705905e9.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795231067; x=1795835867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ARUUOXphysUaIVQ+Q3NSspxOkVH0D/WM7AIA+6teiM8=;
        b=C9qEfKwD4HVCc/5D/CQqSCvz+J9O+o6fTN0LnPGGh+iT/rtv/+vYjMLMCLT5iXpsDL
         LpuB13BnVJl1VHDdUoiGKm/iHTb/iH5lbEBGnI/4ChFArRxr5XFjR/zkCuOGJlk9TBEy
         2zLqJrEppt85m8VK5KHzEr9QTzaY6DTLzAMUaWKkVtTXlQPPi4KhE9sRfc+lVGth5Ch0
         pZMxhflbbAlrWy3Bjov2Zt7SFNEWwjszNG0hfROaB2SYXYLzX4t4tKk0T9zzWea+NnR7
         YDmwukKXLQvVfE9aKuXK0HTjtZqKwI4V/s7fvXC5UqOUSHfjvOvPnWxPNtAT5ojjKodM
         X37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795231067; x=1795835867;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ARUUOXphysUaIVQ+Q3NSspxOkVH0D/WM7AIA+6teiM8=;
        b=UmeFhzA2j4Ja3pukEVefTFew9utNWthDSpZFLq4/yA+UynYDRft5GSeSuRWq6eK7Y1
         UzdWGAZHBEO/wyRrr419vRmn75fyi6ozr8JIwl2k/4oTxkZRFqMtp2skujXI4RJCCQqj
         iNgE1rAJQBUxA4snDBgIkKMLMg4vOp+2vUxeLFpWTP7t5ewfdeY92LX97YjYx7jc8qkC
         CFIoYZhdA5Y2S2VCXpJ0cQ+S5iLWKnCo8B30SOCvt+3NiO4a2zV6sxuufhpLb0VH32T4
         1w+Wz6I47P8rMCwcj6TpYX/iN2G0GIp1+MN7QdhcfmNrpIokwD29CXFrPU/FaIBHK1S9
         RI4g==
X-Forwarded-Encrypted: i=1; AL+hErHIY4QFShxNX//K+2eUv5Us1ZEuWjMqnnmHNi74rjwM3Lpa6Bm8B6TkWIJEvNsDRvAQKtH0HCc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ohr/Ja+qK/nWV+louEf8Pi4Y4s3Z59SiRmc9DZQQ0RnEsWyfC
	A/EuN09VzmqRhh6vHRqaU0CedqbP5xWmiAQUvh6Dvy1+lRZ28M4V1os=
X-Gm-Gg: AZFdTZeyexmOLBNqjhR+b81MNf/xVEH/xCBSV1B0dF9+QkTie+UqLQM/F3ppmtO2RVJ
	CSEjK7bTi8dgNLgfHOfU6o8Kxn8NwsQ9LTLG8WwemwB+qi3URdw0fnfDvp5OiYyEx9wvMx9oNrh
	BlAwfADXY5gZ3IN7beAfir8Jrr01kZLI/dGGdRFw9trbIVhQc/oL1LFPPYOzRzypxG8N9b5RAs2
	ahFx051dAA+ri19H4MKZxQqQeS+m2OBjV9XjQ8tFrK21CP/ZgYG/6SpnQRO3sLODLAPfFnr1TTe
	GzsORqlWNfwH5H2Rdab5/3dzWT+Znn2fm325goWSmt0c9KWezrEa+ZQNMwRxnimbyu4T2Gh8bZu
	DtciT0nsp7tk9S++g7bK2OiEwpBrANW7SDA+63VAIxe2Ov7NegeRJp41p6JG+IEltT6ih3wH1Qu
	YZ6w15fM+CE3B9sKZusaG3H/yB0AG3yUEYBrbuwRzJFpxoiSl1VBkJbP4YX9flaCJhPCb8Ia1Lp
	1b53iMM50bXGcU9FPlXWTj67WciDAHC2yBWxensU9uix+10aMyrJx4jBNL6Psw0J0PqcQnzdGsF
	WlYPhLqWLDSvZhOsQhwIhGoeX4rWSxBqB0mAmplGP7Yrozu640f1LgSUnt4OuUOGNWmbDln2LeU
	8FmStGWALHsbsuuto7dhDZldvTg==
X-Received: by 2002:a05:600c:a08e:b0:4a1:fae5:f2e2 with SMTP id 5b1f17b1804b1-4bb887e0682mr116990495e9.4.1795231066634;
        Fri, 20 Nov 2026 19:17:46 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac65d.dip0.t-ipconnect.de. [91.42.198.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm143683365e9.2.2026.11.20.19.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 19:17:46 -0800 (PST)
Message-ID: <72361086-b932-4fbc-b9d3-eca7df52af82@googlemail.com>
Date: Sat, 21 Nov 2026 04:17:45 +0100
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
Subject: Re: [PATCH 6.12 0000/1736] 6.12.119-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261120054951.366579794@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261120054951.366579794@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.11.2026 um 06:57 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.119 release.
> There are 1736 patches in this series, all will be posted as a response
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
