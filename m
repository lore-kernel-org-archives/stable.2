Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630857;
	b=P61FnKS9MgXAsDzMFNo7geYu5QZByX9Bcws/5KdyMUWjrvuj53d7YhDhdHrRgmssScoA
	 Bm1Ro3fB6ZE0vAnDDvUjdjrL7VQjaUrP4ip2dBkEfCp757R9aWm9DCDlrK7V62wpXDTOy
	 +9byfErVgWcAG7PmjlVzK2kfgcaAzEjm0YQcbpD9bee5Ec6aiyOfwEybHi91Mu8oej8o6
	 4K/V3eIMRmG7SPlI74LGvZjTf2460ZdgT2EKATvUl+XxJGYTGDZ3/SXT5nIUWkp81+zCL
	 ZU60l7/hjAmrmIN5dLMiY0wEt2v3uKfzeFbxytcp+44DNh9fkvvWvtcGJVs9RvoO+0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Disposition-Notification-To:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=gFxWaAr4e8pvWdps+x1ea8YchRLnBYcg9irtyuiJvGM=;
	b=M+mD7em2Hp0x91sIeRxIU1xXfU169/KUvAF2c6B8yP5XK4UnR/kCmWN04XH09QkNZP6v
	 86TpVtCtiLqxnEsQ+/CxBTVUl7bMMZ3ZmKhdkofDPKfMIhk4z3xc4w8PMH1jiNdZlGYEh
	 OM1Zy13lt3VYhacfyNPNn9gVt5QOrCjPm1RHGBGMjSCVj1WrCbfHpnkphegc7m1XqyzhS
	 kIwdoryjZQqalfpNplK+o/3myEAJcUECNzrrO3LJgzFHaWjffBkQtzvwV/FozvEBeq7l7
	 njMqntPhETMGpQlbeo7pLz49t20VpGWHTJhIq0pakJENMaB3WDrBdsXSyHXJCgsgP7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vOOwiHKI;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505AE6083621
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 505AE6083621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vOOwiHKI
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c33700b6435so77775766b.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 06:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630856; x=1794235656; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gFxWaAr4e8pvWdps+x1ea8YchRLnBYcg9irtyuiJvGM=;
        b=vOOwiHKIig3GV4B3RMpyXaNnJvZaW5WHqMXuZALmn7YyIgw0aneM5TYWVq80XIixV8
         u6RJ5fNn41M/8veQNr5jwps5Ukj8gbzp+KDPFKohS+eLwVXBvdV2KgVdB2NE/Xr6mMEv
         IOSwnRj0EH2SiqK6YOcEsUKaKvoP7KgasR2XVmt47RJox7gaPctJublgkpgb5eWGZPFa
         VxRmjb/10Ns7IOqFCEZg4nXBN9kF+/fZ6DDi/FlUD74LsAHY6q4rm+kUcYUeVDdcDGKv
         KALPkMWB5q0tNLogDjZHsJVT4/wzvBadCiJKYDJhkt9pDx/aS29KY4Pwl1MNLVnUh65X
         o0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630856; x=1794235656;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gFxWaAr4e8pvWdps+x1ea8YchRLnBYcg9irtyuiJvGM=;
        b=zu/z3D/1EX2zyegMpXME2kPKA9q2NsoTllmyZZ+WACdFObTNDXm6bkjx3G0DSOxoDl
         WHVE5kA3w4J8o3wIexgQgGkqKtf4qUGwoSwIWpc6f7h2pucoGab33GM7BSCOMas0qvRC
         8FMAscL7m6xoGA3d9gQG/pQSb7xY6hXLXOgPVsxo2YnwbAIp3VTH1/tzt+KalGjLcDwf
         dVVy0l/GOXwudmrde1BRf/PRDIQyaSlXYG9Gu7PqN+TcvakyjFIVJX9Gt6Yw85a9dWgf
         aqt/A04pkzDdPsr2A3Lizdzv7wfYsgfNOSLJrBRUgZYIuHoep19xmFDpAUSSCJq5LqYh
         AECw==
X-Forwarded-Encrypted: i=1; AKwUvBwg0YozUemBDvk/mVB4XAZQNpPI4IoWdHrr/zggpVhukETkMkrBT7xIxQ1UBMRvcE/NPVwsOy8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/24WMzU8hvGxhQ2JeC3V+AsLUdNSs7xmtBkV2BSqjYIXoKkPtA
	nluYbVHQIC8tgIR6PUiyKGsMcZ0XpiHExov3vKvMfYwXxs4Ur6jeUe2B
X-Gm-Gg: AYBFou07ZcTJ3ZnvFUJTOpO49Yi9ulrsigFMPvqZ+x1AQvGlC7mjoacahCoS7trYifc
	/YEgJlh9lK06eoNoH1TntgYLEjgI2fo9BL+aj9J+91ONEOVUQm/vRI0NSTA0fN1mD2FKqjcy5qW
	NMzsBqYg4mNeflF0OaHYD4oaFmVSB/+aEpnwxRA2b9v9iy/nvvk47l7bA4mIz76BeLfl8/mPhTg
	dLZOXqMODUctjGVtsYviyWmyxLLiDWE+M1nMeEX4Ww6R8i4Y/4NBzdPPInSCYXDQwgqTIVSRxTb
	mkMoSNc3FbXne6M1RxQrjtV+wja+nBCvPmb9pWRTa3zxJnblRDaq/MHbjY03xnnzQlgMpyufR1t
	sFt4npxS0SAdauFMfVWNHrCbFNnz67/VdJCZ75jL4iDdPGc0IzyKFL/XQse3vokmFwjT13R5mNE
	kerghCf/KmJa/R8d6o9E7oO3jR4KHM/1t5Ha+18fQmg/h2/Mu8ARF09yUk9KOuUoaZNyhLoMF1b
	oVkRudob/KODwWlc2OOFOZ3APcA566aX4ukemx52lbpJsC4lcXM8vwgkyE17kofSqtSW2Dv6vyJ
	jv3KJsOakTt2PpQkpPSAQnyp/CvBRTA4egwEPjCgX6toGuNqiodd/9yVMuJPEe1QsI8gXDoB7SP
	773HskQXLJYIzXg==
X-Received: by 2002:a17:906:6a88:b0:c2e:3698:dbba with SMTP id a640c23a62f3a-c4ca7a72e75mr879925866b.4.1793630855489;
        Mon, 02 Nov 2026 06:47:35 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe4a9a1sm400030766b.58.2026.11.02.06.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:47:35 -0800 (PST)
Message-ID: <bb43e80f92a82e1a27077a45606a9c7f2678ddcf.camel@gmail.com>
Subject: Re: [PATCH] HID: pidff: bound the unit exponent rescaling loop
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>
Cc: Oleg Makarenko <oleg@makarenk.ooo>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires	 <bentiss@kernel.org>,
 =?UTF-8?Q?Micha=C5=82_Kope=C4=87?= <michal@nozomi.space>,  Paul Dino Jones
 <paul@spacefreak18.xyz>, linux-input@vger.kernel.org,
 linux-usb@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 02 Nov 2026 15:47:31 +0100
In-Reply-To: <auig8ARnvkEoAagA@kernel>
References: <20261029-b4-pidff-rescale-exponent-v1-1-3ba54accf767@cherr.cc>
	 <bbd1ec87a9fff50b189f74cbd21e1d5bddf41136.camel@gmail.com>
	 <auig8ARnvkEoAagA@kernel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-02 at 22:40 +0800, Shengzhuo Wei wrote:
> Hi Tomasz,
>=20
> Thanks for testing and reviewing the patch.
>=20
> > Should we maybe add a warning to the driver that the time exponent migh=
t
> > be out of a sane range? Sane range being, say, 10 to 0? This of course
> > would have to happen during init stage not to spam dmesg.
>=20
> For the initialization-time warning, would -8 to 0 be a reasonable
> exponent range?

Yes, I meant to say -10 (not positive 10 obviously) but -8 seems like a
better fit here.

> - -8 is the lowest exponent in the commonly used signed 4-bit HID
>   encoding.
> - 0 allows a time unit of one second.
> - Positive exponents 1 through 7 would give time units of ten seconds
>   or more, which seem unusually coarse for force-feedback effects.
>=20
> This would only be a warning threshold: the driver would still accept
> the device and leave the rescaling behavior unchanged.
>=20
> Does that match what you had in mind, or would you prefer a different
> range?

Yup, that range is great.

>=20
> Thanks,
> Shengzhuo
