Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521010;
	b=p8LGZ+iHvkholllt5WJF+UPZI21RPjXZuIduJOCeUg2wIbKEWV9gN+bpaSeSRTTw2Pib
	 4EQ4LmfhABsgrJ5ef9A9ylVh8QkIx1H8w/UhrWcVZPDTosCys1Rb2UYjDlBVlk51LjgqU
	 WxJlexq2BnNM/qBqa1yDhyxbE79b2pd4QhAy51O+SCOpkF7drSdD4np/R18NKe3Q5zVjL
	 2FekPw/AGeQ0TuSpwwOGAjnTehOKTB/zII5dHhBOqYU0Ikq5ZDIH6GBxUIg10MiwIvRrU
	 LkOaDhP8VQosD7mgUgUEHmYNlu/LAI4TYQS6hD7yA3RzodQfr8VnD43wbr1IzDPldHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=g9NG/WDjidNQ/9hryLb6uUMucaHueMCbu4TKIHP0Lys=;
	b=49a2vWBGD7iTtZot4kmbcfxXODIfT2PlR5aUHXn9EgVUqV50kBjh4UOxcsz5OdFompic
	 Rvre1lNdqU8Ojtk1s9PK0A0A6ka2b8bBoPsvSO2pNp3SWRlsfrc+dmNazFBVYw532Iwc3
	 I1+5dn6xAs+CsKCUVBB83opF9m6y+wE1wn8BbZNwdmMID6/AepqP4H3sc/m/JAwAnWS7U
	 uDANwBkF6HC5iqj9hzLwRjcmKKEghRIvpFgeLEqGGj7cspnbAy4w58eHHye3dZ0Dja2v4
	 70M1N42lSmX/gLfIZ7o1PaaI4khgT3kAvEznnwjIarn3mTbvEZRGB+jqY/E05/HGJ+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=DCsV4hKB;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3C606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 18:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDD3C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=DCsV4hKB
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so1306445e9.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792521008; x=1793125808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g9NG/WDjidNQ/9hryLb6uUMucaHueMCbu4TKIHP0Lys=;
        b=DCsV4hKBrIEgvj1O1/38beMuf+pcqPGEw0deiniy6x+kl5ArcJWvS71DPUBEg3Vgfr
         fPQ5Sa6KAe1VNi70nLR7sg51252tdJo4e/2nTLmqCeU3kcnxVe8SxMt0OM3brcTj2MWm
         5Ry6BMh9GU0g0PX8WPaVdZLOvBwJeduXgt3RkJPUlDpjTsDJswy2vprLDuOET9bK0vA+
         vCVzS1XT6B1jaixSu73/j7ODrso7QIlF1FDMHgsllLX6/GpX+9CzesmIGSl5K+ui45nL
         pvAr7F8a/S55lrYQnf+Rvt5wZnWc7tm0aWVprsDMAGAB8IRasdXVyIbxXOB8ztRX7UC9
         Qwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792521008; x=1793125808;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9NG/WDjidNQ/9hryLb6uUMucaHueMCbu4TKIHP0Lys=;
        b=Ux7ehW9o6S3J3fvIIcICFCP9ne2L196o4LFlNbTatDhl++bOqcO1LLmkQB/WLlwfth
         wpxvgRkuoX6SU8rurn+WLLmOe74y8kIAs+TNBbgWkRIulBjz6cJhU9pzCVf6LpLURM51
         WnNAwY5ovVH+hFM4CU0w9XgA5y0ia2mvaxL9rIoSd21D5YacuxwY7QJMl5eaLDWFrQyv
         ygXJVV1Lz2OZS47x5lJYndMCGmQOHf711jFSIotDLWIvPbd8OVYMcyXvCPiJvU/NVuKD
         WNXga+Lc3fVsya3pCHknyLAVuB2Volb+cWy6Gzct3TP/JSFjxatizSLl5sw6fxls5HXn
         sfYg==
X-Forwarded-Encrypted: i=1; AKwUvBwq1vw6CQ2+Gqmdrlx6gkOC+WGXEUeSxNjIDeI1r5hiW/DK6LYATXwadchOqqFuA+KV/U4NXSM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTNu1G1lX7V0NsSJVRTM5M8ae3x/4D+ED+fSChkRQ8U42SnQ9B
	YafFSm025w/DE3PSk7eIpi7xM2ipiyBlA14qcGPpDAZuZMMQ06cpzIg=
X-Gm-Gg: AYBFou2fb2xsjRxUjtNT3GESN4xIGRJoBcRRA9mouYJ0hYPbh7Q7NeCheDIAk225xRV
	ia7Pfj/F8kthoVbmmfFSimhWDAkTuSCIqFxLupR0MjNH4PeMYQWbibSw304Y6fCqSWu687rR69r
	BnL9wPXINi/5l/7z4C2dP6yFmewA2gYsUyDE1P3StDcyDf3p4tvWIJ8Mok0J7aa8REcbivjIPUy
	JqHtRJMN9fmXSqij6uuc4GRUk2grGkeMzHV8k4G09Pwy1e3H46hW8twcaPhCdozeiLtZtFoljPH
	O8tJKQjuOp4xAczst33HGaOBW+d7KsVGEtKH/R2/SnMKAmaexNGldPv8iyVywzV6wZMG69KK8ZL
	u4Rp/nPC9gvtMvStu1MROu2yZvynFFM4MxLFlS0nzMIbHKTACY5v0y4o5MZhLpHe6SkDBPQBumo
	5fKi463K6hAyuAbO8EOWp91gVsMEz8+Iu0rYVGd3tF1GXRGdUaP7CBEGzZYW9vsmTYiXky4xeNj
	pOqnc7SZikyedRErumTnzpUg5nPdRf+uUjzlRAz3iBvXUrxMXH5iliVL/itgvs=
X-Received: by 2002:a05:600c:6298:b0:4a1:96cd:2f60 with SMTP id 5b1f17b1804b1-4a1d75ce285mr240610515e9.3.1792521007772;
        Tue, 20 Oct 2026 11:30:07 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace83.dip0.t-ipconnect.de. [91.42.206.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc12491asm2902185e9.3.2026.10.20.11.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 11:30:06 -0700 (PDT)
Message-ID: <5ab8054e-c6e2-4073-a92d-0cd971a7269f@googlemail.com>
Date: Tue, 20 Oct 2026 20:30:05 +0200
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
Subject: Re: [PATCH 6.12 000/858] 6.12.114-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261020075246.861837975@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261020075246.861837975@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.10.2026 um 09:57 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.114 release.
> There are 858 patches in this series, all will be posted as a response
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
