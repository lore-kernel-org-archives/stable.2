Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250053;
	b=E8SSFRUwLru6DDNYLMNHjAt3A4XeTzc4fyISxyu7LBj9fuAjrJHRZIid1bxQ0mZKU3qP
	 HzKwyIwxFTRR2Wfg0nCB0Az9yyUUbdBnPD7hgjgIuLylb5Shu2oi5DsGZ425OpvikHrLj
	 T92/TtVBe/13a+L3QOZqi1UCR2AEr8WoC0w7o061/5APii7lA2oB9oJvyQEkNSAJXhNoS
	 Lf5BH6EDkSqjlHkN403MhuhTLQsi3UItNfseieD1ap9MvVlT0MLwSKSSwweZVRDHPbaTp
	 eveMIIbGgQ1fd9+JWD5LWy8JD0Jx7AwWZiG1/Etkol4yVYiqYHJPEdCGW7EZKUjIRQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0FmQ940rulC16JggvuZSFuarwnsVy2/MOkII+LL+oxs=;
	b=RNVaGcYqG0NT25/qf2QsTh+qSRsULMnst+Z3094805vlNVL0JR9NUjNOAH82XjtUTJ+7
	 lWZsDm8A3TKUVn6PHlsMKfR82mAXli4+5zYG1N0bZqGgITxwc6wMlw17MV4Yg98MyyGpq
	 FRXeyxmfKPpwFYu+yefleahHxxSfwTfFVcX6VCUvdOtpEwcLQepCmQDIMF1z9Sd6WUJad
	 kUissFdCpEORDrymYZFxEiedkFfGWQ1nEXu057QjOP4nho6yU/JlGQrKXZNOTFYAwoDov
	 46A7zQvQxcfgJQyWK6zftE4G0dpo1Ki+sRlGWj3xGxjOaEbm7/rAY5tOsmpcJRl3ebw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=SxkzgZhv;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31405606A321
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 05:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31405606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=SxkzgZhv
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso1064077f8f.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793250051; x=1793854851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0FmQ940rulC16JggvuZSFuarwnsVy2/MOkII+LL+oxs=;
        b=SxkzgZhvYBb/yZWPQWT+3J5RHBu4CldVxTn1snxGcnxWrEBqbxkfeR//h/Jn3vSIHy
         MJaT5o6rpOwM5rmtq8bMV8Wc6hCStf52ID3V1erADFkk8DygglIYayVamKxmZkr2HdBS
         n6DLf0JW1R3ksebPiVqT/qFBZNuU5RI1OqeH7pP25rsl4pITDI2v+JWB6OB/Fdv4Vy0c
         xtL/tp/JYbRddBDmmttyjL2fB0ovyJbFviYmsCCOQYv1UX+V5Zj9o3gTyGDo773C26S5
         EFoppS6fP2lqFtu9i4gj0jW7Jt+7z3j3EkR2S2KVWzWkOmxZoNh5oQRoaoSgjXkxPlqY
         6QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250051; x=1793854851;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0FmQ940rulC16JggvuZSFuarwnsVy2/MOkII+LL+oxs=;
        b=SFxK0uVV/OaVaEOrMNa8cXfMrlUV205Al2A/rAHt/Pw0Xrv6b6LV6k0EYgv7sDyhIE
         iOdz3sgAnncMOU5chC1f1zZpZLBGYC0tLmXazhjEVMKyq4BrNLoUfV4xFLFgydyxQYOk
         d5tLziUdg+/EKG0l9xpZXte9OxA5eHXCf6jp1b+sVUhIjVTZyTyGoLqKTpGZ6LI+HZFX
         k24r20/ejNwnHVJUBMhJpJ0yEjs5ZzqWEWquujNNBIsUwo67PaMaoM82yk8/7MxQvom2
         i3ZOm5eEOAJC3Bq1rkp9rXZivlSFCrEWZUTw0u0a9iE9q6eq31d5ric3pCMLZ7MO0YkA
         2yDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwLml7z0dPPWqUWa+lZySdsRS4lyvIKB4SryLnlOCFixxIk2i6gfsnkpGZJ4wm9B/ezSJ0GXE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxnbVfCYQctHudUA6Yznw2cQETaut6mJg8QzAzwu21ZbJBeujX
	ZTLkWDg2MZmlCGwmDWW+tncKvPtrlg6mpf4F+0hvKTaylO+b0Scj4dc=
X-Gm-Gg: AYBFou3TrA+wfiyKM0ibm5h0tKoxjyb8MvyKp+VuJL6zbvLIhsboCnark8kurk1CPDg
	rOWBwR/KlZjhFrZzKHtA24EdqzodWsfNIyRyazZfGD1hwAMhy2rWgf9yfZjl+++A080yNETjX8u
	5csk1NML9GJXVOFFzUQPOLBJT5Ol9UiPunNPPwzdQ3zyMncZJp9xYgfqzB+VkCLlB2o2f6S8WnR
	r2WD3btx0x33cZr79GaJajJQSR7MfdMPV+/Eh+N5YMyOauyv0ccXXWhAC3F7DuNoH5cY3+ML+ZT
	BZq3S0rgFBz2282/fuiVTGJXbDGpAodjfWR1iLtu5rVIelD6nVORsy7GtxYgH4bLHT+9eg+gVFZ
	QDVjGc/kPnh5Yt+iqxIQC4+YxdiAccYcCodw6bbsdUTZIgHrsFb5JJ4xtJIGpeusqUHFWd/rUcU
	QsFNBm+N+YjI38IViJKUExbiKC5xalhE0DdHOOF6oHfg6JuopkkFByuIvaPtWEsZm+euFDUokWD
	mJDwcizAV9G1xIQMRUXDAzMCfvN+ttSUUycI8y4yMdHSOxGtgaBcxDeD2GL4hwjXW0YUp+yEh3e
	0vrvA4igkWm2NNCIABQqMY5Gyy4d4aZ1GuFwXWRJh9+prpIRcStPA5p0HmQmUyMg+JyAdMYRc2W
	iPXd0K1vZdgvqYzLqPjuOZRpVa7A=
X-Received: by 2002:a05:600c:6209:b0:4aa:15b1:d4fa with SMTP id 5b1f17b1804b1-4aa15b1d512mr72370735e9.5.1793250051594;
        Wed, 28 Oct 2026 22:00:51 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac3f1.dip0.t-ipconnect.de. [91.42.195.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm33329612f8f.18.2026.10.28.22.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 22:00:51 -0700 (PDT)
Message-ID: <786d7ae7-b713-49da-9e28-0f276da7e6b5@googlemail.com>
Date: Thu, 29 Oct 2026 06:00:50 +0100
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
Subject: Re: [PATCH 7.3 00/38] 7.3.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261028165940.394092994@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261028165940.394092994@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.10.2026 um 17:59 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.3.1 release.
> There are 38 patches in this series, all will be posted as a response
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
