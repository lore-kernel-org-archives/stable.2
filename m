Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070646;
	b=hOiHl0ORIgfMxLJSeAlwdKtCXgF9tfVfliflTnW0vkP4ys04IPSCiHzhoHFCHO1/r0uG
	 Y6haFbci3zrA+BIqZYb8FEDeCIEoTrC5lvZe+z0T84w8b6RyBLMuayFWDlLBIKuY9DrhI
	 4VrW7otvcHH2ZKWJgxNJ0/s4AHn/yjedWLAJWURRrnyqM03o6s1T0vh61X/8RSr9yT3pP
	 dnrzb+vs+3qDwhanZFo3vYEbW2rx3tib161O15sFEh/iVJj3BAgzYN+qIdGwqJOM6EZ/6
	 QXsdNdS3f3RKU3x8g62Df6ZoDf/2zcb6vm7ZXZ/DzyBVe9WuW9y//CnPUxSuXxWwLYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dZ/CQYskRN0JeHdAleff1h6SJqJJZnuoROXlSHd1Wv8=;
	b=rj88TismhHM+54NgiFWslmzj2YY/UH7iQvpWUoNoPxwC9fFditmzv9qlUZpj0ZshLNBc
	 XMRDNEgeL8cVOpBfnS3JrEanAwKkpUlAGu+IJ2NtyWuiKt1LYxDjLVMjYblZ6alQ2294C
	 xS3G28dgBpYUV1t5AIvnp8mG17k1HZCA/0GF3NaUbs9+stFhx0nBw/ukdoGVmOrqvJane
	 dXMWiyeXV6wawJRd/nYDT9X0TvbBzhjaVV4tzq3O/v30EjdnjmKQqqfoQy169WnI/OuPT
	 63/A9Ii4Jagr2TWnCIYNTXySVb9BG11vHij7pzuACt1XfPn8QjWzI97hgCSvYTIZV/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=uB5u2QP6;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA59606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AA59606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=uB5u2QP6
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso15805765e9.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794070644; x=1794675444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZ/CQYskRN0JeHdAleff1h6SJqJJZnuoROXlSHd1Wv8=;
        b=uB5u2QP6Mwp4ctZ5zhTYwbQU2qqpke49+pV6yOEmi0MlyrNuBEEaOeY+e4xro8qYqe
         7XBUfH5SqJwUuLxf7T+7hfHB7kW2EZvy1/h2g3qW4x48z3bSlI+m+z9i7mD4UOf+BCym
         h98pTqgAJy02wQTrq4waY4CZJFF4zJDv4JqKTa4o/Z81pP1bkZ7IuqWhZ6qamdL5p2cR
         2vpXy1+JS+l80+u42DbA3jzuDhBxFvAX7apHIBOs/Jo/tzNBB47pI6DUVtCf/XtFn66T
         qxcXX3k6Ra7iOkmrLhgMdv9VHU6l/ws5Nl5Z9fLr4/YRPmGLPVxlezFC+CJsHAbOgmXG
         CCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794070644; x=1794675444;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZ/CQYskRN0JeHdAleff1h6SJqJJZnuoROXlSHd1Wv8=;
        b=SxDxQBNDcyUp38P4U2X/OrvnXJvsjxJ2E874bpzWYp8koXfY7dihmMqsoXDPHYeehe
         pHxjZDmq9SO9z6lQvPvNXBQqGWSgdqw4k6tLgXt3RGp2z/htvv4w994O38DY9h3havfX
         CWP41vqsIkbgk82hNRQN25QrnuN4fZQ0L3XGZbXo0dn1FGaKy4CkNWgfxQmsNThJetgJ
         dxaVqRwYj3/VjKAwFU57xZOTgC4IG4qcPFF7wUxDpcbwYEyEvUATOerWzpjqHk9K6ukp
         1V0xw8L81gpOGh6D6XikGBOzLgmMHGyCFa6l32pfuw0GTJ8SEna0mTlwJHaR05+wGGZY
         7ltg==
X-Forwarded-Encrypted: i=1; AKwUvByZ6Ngy5ewlkHud2ply7JnYI7vjBdC8XcENVtA2HfxiKNE7JEG+zptl5OQ6PFcqlxB/8j7gWrA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+Q8xzc9oIM+LiZ7crv0dumslzHJn7m2Bbl92i5f2039iVBx+S
	mWAH++TBupUwEWSX6oi2jUebxwrhjDQ2tUIG2taGB7BkbPNr4ehFZYw=
X-Gm-Gg: AYBFou0qK1AGsnLDvle9AcCVgC4CqxhAt5X8m+RjjJ/6xh85ialCoAhrswjhuxmhoJW
	JUlfH43bsMAYqC02vpCF6/UhtCg0PgwX3bj23wRB1ZrNVrWni3T/0lOXsPuNCJzKY00tOTcMl1U
	Kha/CiiCS0cKLL5b5rnJuDOJyiOEjBVUanDkBSUKqCm4056S7dYJnzHCIjN/1Oy7S52hite7124
	LxhTlAeJlSRo/0bbGrt6DLWlb9mHr7Ux+Yb3J2XxsmDQBBaQ2nnc3rxu73hV4oWYZuO7y2FTTeP
	z+yvqqCbPY+mWIcokYIj5lzX9UsNiI/aZ8MPzCOX87M6AQ+vOSvWk+7MolBl2IZmGwEDwmIPz1H
	dDU2BQkPVK6Mx4t8RsiP4NgXXr0HjWBIKGSJVS7tkhyOgRAjYRbJ2uZzyoiOLdVnmzL+TYgXfxK
	Sf8FPZI6ApV0lij7kvcTstADDxNhnJo6JpfUR7drANqg/DJw+SJ/ghlEUu8a/Vfpwsj8Bf1EDJ0
	tgjO69QFLG7PBeE5x/sQCG+F+yrU2h1oJO/zAexiueZryhHNUnenjk/DPIsF2JGwQrMCS0NYgxu
	tqkbsw5uZypn2xbRVvrxrVfHhKKK6HLK3P/KHykzIDIqMy7Cjx2tREuYEw1ENY4xHew4ky6vAop
	7uxo=
X-Received: by 2002:a05:600c:530f:b0:4a2:133:45e1 with SMTP id 5b1f17b1804b1-4b6dfbabcf9mr95721785e9.24.1794070644434;
        Sat, 07 Nov 2026 08:57:24 -0800 (PST)
Received: from [192.168.1.3] (p5b2acf48.dip0.t-ipconnect.de. [91.42.207.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1547fsm144188195e9.11.2026.11.07.08.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 08:57:24 -0800 (PST)
Message-ID: <2401f130-7358-4797-a872-592674a1888f@googlemail.com>
Date: Sat, 7 Nov 2026 17:57:23 +0100
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
Subject: Re: [PATCH 6.18 000/869] 6.18.63-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261107134852.069646174@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261107134852.069646174@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.11.2026 um 14:44 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.63 release.
> There are 869 patches in this series, all will be posted as a response
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
