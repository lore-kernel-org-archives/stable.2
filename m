Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243379;
	b=dGtcNTuP6NR2YjDYlvAUXC2NV2e8DYlqbNACv6MY9GLATbHNn92olHOEEXZ8lbkCJXUW
	 LFbIcgpGWCErmttB7Z6faMdiIPbppqZ5jYhZvR4xKWua2udxrqS2sL+oD0EZE9xhj0Eua
	 9F7LGFEP2VWZ3QTSgRLpXTUwqIwxJ4Wtk4JA2w23x5wO7Q7taM39QcyAjGLZRCvqWfjov
	 rwkpcKWDiNg645MTwez0IeJlO+GHQ10Irmsstxxj2T6OiB+y12W91R/c5dY3EpVdCoA0J
	 pwVo5s2OZs8bna9Ldc6CdOWRLfSYyRuy+biCGDbnWQip+uoe1Acqdq3c/W1AvVZJllQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CQ7TFwD1Lpl02yitbOOr/2bELAH5EFoPsdJfpMGK2e0=;
	b=OAUEfv4O8Zdz4pjOQbTxnvILsB86uhYZfzw2mHG0qdg6NIoGdW+FwWUfM72JYaa36w13
	 w+Nc8ZAcVcqZlG9duLxfdcB5Ptzb2jbM5vFopG1vipHV8usr+LEisSnKfsETIgVSCs9Cz
	 AzhX5VnpLhdPX6rBiLGS2Vgt0wKOiJjNlYGFZQPnxgQx4AkMnO0g/nQJNs+AGT/+7s+Pc
	 LA18BC4hNnPBc9Yimsvdt8UdnSf16vioJfaKuFsX5ePWS5jlB5V+GXUTecvjIIUXJJXcQ
	 h81PKWbeog9kKjwBT6nk2VIhIlUBuTNIyq6JK/a3x16qCPoq6dpUzdV/4bEEZ1QtBKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=WCIHzagR;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977B606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5977B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=WCIHzagR
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so12516485e9.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793243377; x=1793848177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQ7TFwD1Lpl02yitbOOr/2bELAH5EFoPsdJfpMGK2e0=;
        b=WCIHzagRdXZz36qzOOdHC78QWIYmoApPl1K6zO61+aVSLCtImrkPJEZWgTzvkRLkCV
         dsVu3YIh9u9NYrx5uA8L9BuorUIs3YuImeBXBzMxA/7bf/Av4zakwzr0Ig9vlE6+7pJL
         S6oi7tiOtbNC2FTLJ7GA29Z4g8bzPSEkmKuBKDrJt/yPtuNCxlrIm1NonxSGJORFr2St
         EOuPyLmPVgB5gg1AqWH1LYXrJFAOsId0v8ZRnQVZ5p5dNGySYCCHUHOXvn04K9a4lOe5
         055Wt/mrqlFDvfk+a/I6nXhU9OOx6+Ri1HG38/OcbshKObZuhLwjCFcI9sIorGzfBVu2
         AQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793243377; x=1793848177;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQ7TFwD1Lpl02yitbOOr/2bELAH5EFoPsdJfpMGK2e0=;
        b=mG3Hp8fSxIwkMcYKEuQ2iWyqePIEdLiz28h0NupBKZcTufzm7Oo9fI2H2h/qUnsTNa
         aa0YLWfQvFWuL4fzVaFHLnVPD9eocHMsr0toYE9LxnXEw7AKQZKHB9xNxWteb8kEhTs0
         EpNDgR0WwuLEHy2VO3/QsZk54BT9GUo9+ETvOD5wScSFxysyLcxNLdfywmKUWidZJfH0
         i9Uxs8xqH7qbs/0WQlLvw2mSTf/70bKZ094w7ZIvP9RUiC+cL9EIC5piQ550YW97JUUR
         0QBYUnAbOX/8n+H/nSP+t5bdPtMmguLb9kPdStS/ZZUr2hE7ej6LV3qWw+3OIRekbOBT
         o0Pg==
X-Forwarded-Encrypted: i=1; AKwUvBw0iWL8jKBLMWdMKfvpja7MnazfYiPgvVzVIHN6jm+XhhbwlRNxuqoELz1QWYAg1xlJWy3jV9w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcj+v1dSFGVrZN64jVJDcXtetQZwq46FOKoRrsw5LVamblvbQQ
	/o3h7IDUhwTMmm63wChqHwVg7+m+IW0YhO7TuA/zX7naaLXdb+xD3ek=
X-Gm-Gg: AYBFou3RtAPh0tb/ODDSXLmE1BQKkawNsNOPoRGDCcd8dXl0CygnvqcWLAbBkJEEbdN
	Fp+WlvL1pFGh2mTeh+KbMejlB1aVIw3kmM8UjWzP2ag6vgR4smDD1iEoS+IJHMS8K4RFMA32dyE
	vba3f24Q3zStT27ehAKLil2GFMisvPQ5cmkxcO9QsLcHKOdUxjUV2gObdkf49jJJSv0kCL6QZHK
	QFHi8IN41LaIBExqwgDzLS5drv2CDd/HfIUdOxNJM5gUl+dF6NBMMDINbb9oDiMfd861ygZaXAb
	sVPXCyyaYXDI6VGIna2+KqmLBnBmSIjb/biMNV1PeT3d3UBDAkXLLBr3CyfQlS/JZvoldW3aX/f
	pkhD1lH+Hb1g39tCtNoqamOOreUKODhPNctE0eqf2vF+x6sjw8Q4IbHL8kfWijFJHtR23icZCTz
	A/teEv7JWdmhDD3OX0QXVwlluddYMLdW5volS+uEpqEHPoE63Wbrcdyycpa7Dl/hDATOHordNCU
	4qwRAYJ7v+QiUhjW2vJ6Xlpc8ogHeCiW0wio9QJ2/oIgs+v3h8In/5DaCAvT+jSnFncvdJzxQjE
	ZlQGhY//1LO/UVIUV0ppHlkHh66hkxzEQBDkPBBr1OQrROPD8LzJX4owSzgpgL9BgRfcz44lk2z
	FYbn1VcxppB+U0Bk02EJMAX22L7s=
X-Received: by 2002:a05:600c:4593:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4a966d361dcmr93441975e9.21.1793243377152;
        Wed, 28 Oct 2026 20:09:37 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac3f1.dip0.t-ipconnect.de. [91.42.195.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f047bfsm31916595e9.3.2026.10.28.20.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 20:09:36 -0700 (PDT)
Message-ID: <fc3f6065-a3f8-4a4f-a7af-4c46ab58072d@googlemail.com>
Date: Thu, 29 Oct 2026 04:09:35 +0100
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
Subject: Re: [PATCH 6.18 000/109] 6.18.60-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261028165942.357251485@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261028165942.357251485@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.10.2026 um 17:59 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.60 release.
> There are 109 patches in this series, all will be posted as a response
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
