Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118DB30F957
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784687185; cv=none; b=AQMPly4tYJEoU0P2RXuFuD2LumbetMn57QQ3LG52+ozi9op2QZOuxOxUPzYEjZTAFX2MR6OhOlIMZV2MhnYh+Vyl4l7BVwdCuxonJCve0s6FuD2qEyOI6ngePH5kypCoOVoE3CrV9QmVbRqfBY0Gi35JFGmB+xWrPX1/Zz62RJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784687185; c=relaxed/simple;
	bh=5l85ZaG3gSh7lkcuF4/Wkn/OxZFAptTtEKNq2yRA4xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vw7LEmPLjemt1UoEcOrFyvQgpXpC/bcd2UTV46uxL24QKhQDIrLW8tT1QEC7GclhKLIjFQCG8T5o4HUZviTJHsdL/6833He3SMG8vFsFHS3wtxXrkCkJbaRtCe6O1fQkt7WdrOvII5MExkzvIsHdroLZ5alqxY2gyp0giwjkj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=k6aMB9iS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="k6aMB9iS"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495635a85d2so20359925e9.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784687182; x=1785291982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HIRM78WOPCxeryq9jVbqu4g0ckz0IZtRVPHzU84Jm+M=;
        b=k6aMB9iS4xjvYfvXDHf2Hj2Xl1ttpH5ohWTjYSLBs8M4MtdZQmtPLgbAYzfCL/mYvy
         pLVfUS4h7YS4yB8ws4tqri5rPOXb5SLM2kqIjuSvrlY1C/7/Q0WyhTFPXT8Y27RNxUOS
         ktMUXSZwzdcmdikDMpSVHNxqkjMgKpqSOrX+S1i/6BExwrDiRkqFnExatiumY23q7ptV
         qMUaedCzCFMd1yMXjSOYBZQjYUtvlG28fg7ZtTN5CDWeZWv6/2m/7U2s5gwRwUxnascJ
         6iIySZMGaRgYPvcQ2rg/ysQ8WuDshiPOlh2hCWOlFsVzr5jA8N2X2WhD1Aj9NTIwtt4d
         Oz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784687182; x=1785291982;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HIRM78WOPCxeryq9jVbqu4g0ckz0IZtRVPHzU84Jm+M=;
        b=cmHhfcKV41RqqoBL/q844eYMuOeIt7UVsWEwE2MoLQXtL0b7BWrAi8SBHpoS0Kv4KC
         tSNqSflkfvS35GA7V24tguSci98Cwa1JcBhnj+kW7OcVtHJoGMgc1fnxyV2EdAvRYiMM
         tXpf/ASR2P9qRhhMg9xq/I5Vgk0dakH7OWgb5kofJYTWjUllCJEUoGeSB1xaMlz3BlS9
         yl5H9kB6xoA9KlGLpAdmpfMiWX9Eu6VSPpsiydKkwt5Q6N+UGVXRCheDKDOcvEQDmKOM
         4ecTaonENjgOQB1LykKl57IwUZJfTbywR/U1UUZg/AABqZCemxjTL0nTHVx9Jo8c8hoW
         KJ8w==
X-Forwarded-Encrypted: i=1; AHgh+RpkSo8491nigWFkJJ9ODM4AObqKFl8EibYohnaY4Hrs0aDXHUzpoqRYLeZqp5GXgihLv3J2Aic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1lvZoePvTYQq6tWZwuO4H8R7f81mL4ALKXaYHl/EnjaW7xsi0
	EUqAd56UB+JP+kqnR7mgdXl6Hg3URBdX9Rs8mwqTpwgrUy5YLJfV5nY=
X-Gm-Gg: AR+sD12CvEy8eQqKzArKiOCaVKIJWYoi5MBReSQc5ltdy9DcYYgFrCueJd3Y5M6pVRM
	0adMV1wJBn5rh4TLD8Q8G78B+pKMn0+YlQwzKrAIHarIROH7DgoOqA7dJ6FOn4c/6ptKIOer62R
	VJgYCFmjqXI3KrERs0sP9gZMQuJNsD2Q7L0RVNzhqduZLdtxzSoVY2RBPABmKN93I4Gux1xR7Xd
	f8d8G1hQ4yrgTL8a8fWQwzpZK3+cTqzi7SEWI9sYp+7gQe9T0YtHnbodfMNa4mpLh+g8acUYhFl
	x4YeE3Wq0UNZtyAQ6d1wK1GtpEvm2nfFnd+7IZLPpnWQWsgsjRSARIKUBLWWywtj6kamFBWv+89
	7sKPAMFTfoI55o1v1n4nxC7JSf078NLBqUNwUuG/6MDw+7L5BeKTOai6xxe+ur/qE7XSDVdZgT4
	6n5Ja5yjZyJfUqpBTC5eoLYLkSe6yZrTUQVZRJvXJ1igMw6I0x3iytMw==
X-Received: by 2002:a7b:c7c6:0:b0:493:f6f6:bcb1 with SMTP id 5b1f17b1804b1-4954a405ed1mr153557035e9.25.1784687182174;
        Tue, 21 Jul 2026 19:26:22 -0700 (PDT)
Received: from [192.168.1.3] (p5b0575c3.dip0.t-ipconnect.de. [91.5.117.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a6d7sm1634275f8f.2.2026.07.21.19.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 19:26:21 -0700 (PDT)
Message-ID: <9df55db9-841c-4588-add5-ec1d29441cac@googlemail.com>
Date: Wed, 22 Jul 2026 04:26:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 0000/1266] 6.6.145-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260721152441.786066624@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260721152441.786066624@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.07.2026 um 17:07 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.145 release.
> There are 1266 patches in this series, all will be posted as a response
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
