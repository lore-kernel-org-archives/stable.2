Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821840;
	b=tUlPzGSy1Q9UK48uhd6TA8ICasaS8fJTBFSg9SeiKqGxXPOgjYQNttl15k9NTi1e020j
	 hJ4ntMIkdjDUA+z9Gv8Vtz4da56fBTDuoZIJem2zPahu4fBCnuCOExaa5jI9Hm1VQMqvj
	 Gl7A4Vz0wYmf/geMXCXvIMoEfjO4JO/BQvY9Ifi2iALelS4KhteoYf4gF2R1ZK2ipJ1+F
	 9Gb0bSDxrTQ/T3xLOUGD+jP/ZUThinmtrOseWcbKMcCcu0EXwnTzPd4f764M3DvF4jklr
	 k84+od/zkkVgTUeSa8f5tAfas/up//ZnmEMFcvCPLSShFyQ4DjfOgaga1h1GN1hzPDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=RsYO5R8L5LVg0yubVJzT2dh49z5DZCuj8vx/6J0uBsU=;
	b=OvZs3z0Spv0KHtqCOI2aFNPXYQz9qcMXXDxkESjcR/D+IJ0xB0dyZoVa96pkbdyZyzAP
	 r0tuPQLl52EoP/bOuIFf5yJ96nmksftje6gvx9YwHCcw3Hg2Lif5eIdRD7Ug7AYSTWFRy
	 a3J0qFX2LcPTc+pZ7R9hdiumBZ50M7NoeIdQuvmHYFzQv8IJ0XeVfqiU+DEnqr4VFMsIH
	 sSBDHWAuL6PRPU2Y2nbsylg9Ucw7+DIzFcqxZ6Lj/3XtRajZ5NbPm1X3qw5Ym8kxkqget
	 9n5ACw/X+ovoQGufSktDsKWgF2mQ2StKk72/t+ZiRHnnWIclSq53yO3BigS1HVycDQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MG27KUQM;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A760954E0
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 462A760954E0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MG27KUQM
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e47347279so673917f8f.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793821837; x=1794426637; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RsYO5R8L5LVg0yubVJzT2dh49z5DZCuj8vx/6J0uBsU=;
        b=MG27KUQM5Y/sluPIHfuwpht8hFRunYBDE5XpEKeoFZ2Nv5z/+Wf45PB2N2B0pPIr0Y
         RYsxgVA/TUTEPjsDG+8GXB/moPjPPjDuskppEqeB7UnMD1K1eqfYfcIySKOKLK5dhE4q
         BQiG/CMBw0U7V7TWpJTrL9djiOSNE/3LQdzN+8ptvWyoxzwXafj7YHBndBR2lLyyzXw3
         l9rq+3X+tSVubUlh0BsgGTc8u1HvEoL2Qvc0dZaoye17n3WHG8HJ98j+ghBGLxEzcPgC
         9dC7CzKmSyUts81qRqw2m2m6T6i1YpTAr5FALmc1Uy/FgRNDbnffQ2g1hfAszgmd2pGd
         1JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821837; x=1794426637;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RsYO5R8L5LVg0yubVJzT2dh49z5DZCuj8vx/6J0uBsU=;
        b=xeFwaZONY4Tpwe6V5JX+J2NWMWgcgEXaqCvlWBx1vy1FaJ2seN5HtChS+F4BAS85dJ
         Y8KDnmhWRG+urxdRt2SAnIR1w30TgTnRMEDFz7HAv3Ld6XCuvB5ofDyrUiSYNB5++Oh+
         KZN9aBgEZBOpVqdBwHptTCllFIKoehH3HLDBWZ7sagnI+Zu2DE09IzfZj6TM0Vg0gnpo
         soW2jXFALZhf+JDp5mTCfah2wT2eM9HPMwordq991oD9OKn4mRa/t2ynK/FfquDoqi/3
         xmj4/NPlIT/Yhgd2vsNufMKFtAVf4RQEy5WgzvYqmYt0Owv66JsRp3SlSezdhnLwht/k
         KWAw==
X-Forwarded-Encrypted: i=1; AKwUvByn+S7NOufTnLP6N8dkvwnBsAC3OCV/wI0XQ6IICvXQmEuekk2aftoN6GMS02KF5Z0y81At4vg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DJS8KijJlRobx6lfu6hg3FCNgR+3GVsj8093hxAneDxOx0dWY
	N+HK8+eeuqqh4xUXodWBvndYeRctta8pAM6fqgLKIaCOX8xLivR+6R2N3gJPc7KkCiw=
X-Gm-Gg: AYBFou12F8hGMa34/d5w2NVAYF53HxKFEIykRH5S7lo6kLeuy51v08DC154UZW1BxOa
	zYamw2m4D7rfdfPa4N8PAPQ05q/yU4WGN6S6RlOLDQGBRR7JVAdE92nuv6dqWsmgdSsSI85a2/f
	j0kB3hTxWChG+e7NrAvmmOfziMbqwaHsaTp3a7Oefkso9oLKDMbqT07cjKZFCXWeUGHLgrVIP5s
	YiK0XUaeIRaTzTT/Zgyhl8oH9sCtkm52+s4FYXP3A1MmaUKUFyZOMRvRw0SujSb7l75Y+bdY3hr
	ClYLe4YFVCSW8rVipov+IE7JHY/XLbZUehh7mXXBsXJldhLMhxFyLjWvjEXWB/FbyIt/Kgjdjtn
	OhUhjUcMMBsqoPIG4v93F4itUZoIT74HsPGC/8s2PyEMZ3D0IEDBiLnPh84ZCUOH8h73/8aIsF6
	k1H8IfVUz/hQ2jkp5oKhj6uuM4WcoWDReYdN3T+pdXUofMSNueFotEL/WZ3t7HAZpTYbxRGhVZ7
	s9/yaM83ahxBjZsgVMYVM0wiWsRb8gaAdTqdoyToSHeFhTm+G1fB4YcmVAvUAg2gvrbGVhnJIhK
	XWN+sXxxqU+290fNJQHSaZHZvCW9EilNVUBaQFsr7K/tn1I=
X-Received: by 2002:a05:6000:4021:b0:48d:e6f6:21cf with SMTP id ffacd0b85a97d-48e6e306900mr38286580f8f.31.1793821837378;
        Wed, 04 Nov 2026 11:50:37 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed5538basm5325940f8f.44.2026.11.04.11.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:50:36 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ee0b8d44e90725828066b8930e0f6189120bcd9f47cbb7b5da9d5a8229c3;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 04 Nov 2026 20:50:28 +0100
Message-Id: <DMMORNOEOVC1.W8WMKFFWRVGU@baylibre.com>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Frank Li" <Frank.Li@kernel.org>, "Tony
 Lindgren" <tony@atomide.com>, "Daniel Mack" <zonque@gmail.com>,
 <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Julien Panis"
 <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, "Francis, Sebin"
 <sebin.francis@ti.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] dmaengine: ti: cppi41: Use td_queue to restore
 DMA_TDFDQ
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Frank Li" <Frank.li@oss.nxp.com>, "Markus Schneider-Pargmann (TI)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com> <20261103-v7-3-topic-am335lpm-cppi41-v1-1-d7213446c5f5@baylibre.com> <autue--8pip-cNQk@SMW015318>
In-Reply-To: <autue--8pip-cNQk@SMW015318>

--ee0b8d44e90725828066b8930e0f6189120bcd9f47cbb7b5da9d5a8229c3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Nov 4, 2026 at 6:42 PM CET, Frank Li wrote:
> On Tue, Nov 03, 2026 at 08:37:28PM +0100, Markus Schneider-Pargmann (TI) =
wrote:
>> [You don't often get email from msp@baylibre.com. Learn why this is impo=
rtant at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> In init_cppi41() td_queue.submit is used to setup DMA_TDFDQ. In
>> suspend/resume the same value is read, stored and restored.
>>
>> To get rid of the suspend register access, use td_queue.submit in resume
>> as well to restore the value.
>>
>> Cc: stable@vger.kernel.org
>
> Do you fix some problem? why only have cc stable without fixes tag?

This in itself does not fix an issue. But without removing the register
read in suspend the follow up patch would not be enough to make it work.

Best
Markus

--ee0b8d44e90725828066b8930e0f6189120bcd9f47cbb7b5da9d5a8229c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCauuMhRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOZ
tQEAk5I87cijSBP2K97rUA3N6Qdsw4NGsd6NwNNQXdTFSOEA/Ay25+LZG9HzW52x
Y0gRoHYQHeAJZpoTQz9sRHXM0LwE
=sNxU
-----END PGP SIGNATURE-----

--ee0b8d44e90725828066b8930e0f6189120bcd9f47cbb7b5da9d5a8229c3--
