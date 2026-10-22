Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685091;
	b=u+6ENHX6akzSRophGMRPAKBXbbjzjXeeQmSM3LWfF6OAy+60TQDrg1gO8V42H2PIeOQk
	 Rp7npnhcjkB1P8AMTRV3mQPObE/vVSMFuPKW8bLrEs6PtsTA2u0HNbrrExSY17oE9md5l
	 sM6+NufiZaqGl93zCfiThFqCip/V/zaBj/z/Xj3jyT5WGZYqElklzs89RP/luu6l7yFuk
	 uO+LtyJTq2pRZeolLv9lUlsj9HAb+KGkZtvES6KuozUnaFYQ/iX5FbEuI1F+v+5IABNsZ
	 zWcb5Ads8F2E0Qi3ngXZO18rwTl8sxvh0e2eIxAfaiH+iaMdlUeBSmobHWY58Rc4Z0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685091;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pDXAHPQkxTtF2dSwsTWY/c3EcaAOKqjepqfHcy7hZKQ=;
	b=TjEC0fBn646e4OURA3zY6PfH9hY1384hSZ6im4LR5+afFztv6DRkghBBouukr7CQNkHw
	 6iw2BvXN6zqzTTdWFzrPraTOZF7ntf1smg1+AX4wrnjFpYrYEVvegCNfHYclxg0tZ/I2f
	 FEor4SCIKYv/fXpt0fgJFkDJto4kaLMjllpXXDcr5opo2O9+JlAWk0hX1k3R5aEcDdYZZ
	 rS5i9/33maeI362FD7Jyp3mLfH+S6ijXboTGCY+OkQUlRi1FfFelVjzsVhGijmt84lwpb
	 jFbw+EvAljGynHweaVfl0lfKXnbakbN9gZ7ZHeGAjiYGS/HoKOkv29ZetZo9yvPQaLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tyhicks.com;
	spf=pass smtp.mailfrom=tyhicks.com;
	dkim=pass header.d=tyhicks.com header.i=@tyhicks.com header.a=rsa-sha256 header.s=fm1 header.b=KGEjgZIq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ii2cseVb;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76585606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76585606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tyhicks.com header.i=@tyhicks.com header.a=rsa-sha256 header.s=fm1 header.b=KGEjgZIq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ii2cseVb
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id AC5F8EC02CE
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:04:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 22 Oct 2026 12:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792685089; x=1792771489; bh=pDXAHPQkxT
	tF2dSwsTWY/c3EcaAOKqjepqfHcy7hZKQ=; b=KGEjgZIqH7284K5PSHfUkkEgny
	cs5LThFyH+x5VYUNTptgP09o5K2PPMmN/lCmvI1UmepZSE2InktEAgRWdRHvS1tb
	3Dorj+JcYuPJCvrCJIHk55dU6tKE9Bt8NiQNXpbIU+WcQxH9eVJyEz0+yryNaeab
	XFm0JQagJD5RXLEjiTUe8FgkA3ACn6T35ashU0Zxnh7nWptiHIn1s/XpHTHs7EZz
	cz9LO6nPJqQa3/S2BRyAUOZZXhSYOp2TVxvXsJMOWAuqM0xhZwVlg96AvHmMeLzb
	HkqYgVUJhHBnhsroTag28HgXA2DIIMgylmwy5m+i2sk7kEtTZCjZwZgs/P+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792685089; x=1792771489; bh=pDXAHPQkxTtF2dSwsTWY/c3EcaAOKqjepqf
	Hcy7hZKQ=; b=ii2cseVbIXRoefTYpqdDuM8Wc9J++NALyRhyFtb9C1/wM2Ra17A
	rHbLM7kHZnIAv5XTLsrrzT+qNLLVxo134c/Wl0bVJA+FbYD8xCYjDZQTQZZyr3Lb
	8jBoSplDSDhqvDUSXUA9YUwFdH9506DQC9pp7xa7jBoZ3+wJ8EQ9k5oNhG0/dS4X
	GIdE+Yaw85Ykh7d2GtOvyUqnePuB7mhhbKyqYFNQSJoEtYbuMeXD8rsd3vyxLy5M
	c5yHUbvP4RKHkvfG82Er0XCnMNLkBBN89WT6IqtKrXZaZAD8u1BaRHMpOWxw4qbq
	WvC2foTv5HCXq6k+W4X9C2kV6BQxnzLOcYA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792685089; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:H0o6ISz33iu0Ki0ql+L34HB3yYAGYmrli04mDYe83u7XXqY
	B3quF1V6aPa+/Ka2Cpk7eZSMPJ0gAl1jFaTJuIttsBj1Odwx9fpuarJau37NHQQH
	jFk/Ta6SHjF5uoBuVbYHeTbVmYubJH2AASECkg9CSoqlq3PwEZLNOnJB2pWwT4ny
	HJhssd+GTd3uUwCEU/vi4WePh2rnUKJUqTqqJMre4yrSKBVLvt8BBiaq0kbc5T9R
	JIP1ZziNcaEioVc5hX0+pwjXfRvM4gUVXSXID6X0bAmIl7kFYvZll3Ofia7tY8NU
	vZ+NaWz1orjA8aVPJMuxojwvekqDmyGZ8+4C9pA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:eIMjwbjvEkVM0KyB0641woYC+YgvOAMzz3RNnBYpFeA=:R/d9wQiJzANatNCUqyrrm2pLg4J+8//+WSbG0m0prLQ=;
X-ME-Sender: <xms:ITTaamSFAOFhHTPfwO2QqAHsKZp8c7qi_4EbVf0PzbF5ewNcAjQ7TQ>
    <xme:ITTaakv9PPkyuNOdAMf4pebPQKNYYN_hOdRE5K9FVfjxKWOY42WZeN0Gnbe0JWIi8
    knIMPv5TlDAMYsUyRvjEJVU5eQX8FsMwFuB80UWInpbIw3rtOWxbaI3>
X-ME-Received: <xmr:ITTaavaC5svGbjo9rLZLJuw-OzqfTbg9E4QlFDME5ukh0OLL8ONKkw>
X-ME-Proxy-Cause: dmFkZTFLCAHjFQO2QIsgkjKn7X68PZwkorxm4dIFqzI2GdM9HP9XRb57VrPON0WYWLb7dF
    RiPOvVi5nFg/+AmE2cP2zLCM2/hPq07i5mM5IhH4LJYoeYh135q/YzBPq/Axgw7gE0QJis
    gEjFd/3LZ/OUuj9FmsrOhgyUy6KRrYpOdtOs2DBO+MMuKHs/EPHVmmEGTOQc7s53/lYobw
    /kMvH2hEZoG30C9rH57dofsGH+OE3PfbBzv9IMcAO/dJDJjvPryOZqx6bI8Yzs9N7s9N68
    CpomlH5tkDeR0pnCW7Sr4LdfN/NP3nnll3qq7pVUCdahWhIAaqxHjnwQ9psVklFUUIqwde
    ISYRNOzV2rNgtw6aBpuPcOSRKxQn9QcD0xn+XtQXsaOrxglV1cnSK680tjsH9Rr+32WYFz
    jCwIAKqbnDVQJKcrXt0kaO0/cqtMqIP2y5zL1dK7zqf5jlbgNM9QTJTJ1ESHxu+QsN1MOC
    i71R/5QI9Y5JBnlp3J9H8NZoyMvmh4rE3IugJ+i/rPQTSIPvJpi0U3fksxl1P9g3j5Os1J
    J6DUI+JHLOq22Bg7uuURSvkC+xCPLVCveCkPxMclxMP/bODf8z2WnNbXMbKd7tM44px7TL
    GI+/4x1k6e6GcHinQcB8ltnMNaKpckYILo2eMKV8MEuwCFuVhWTtB1HBt2kg
X-ME-Proxy: <xmx:ITTaaiEICPG9ItgyAzA7bQXrvA_uvleLKitiiqKAhxlZJkZLjZ7FDQ>
    <xmx:ITTaarx26Dz-KZ_YH8O_73TxVS_7E8JaTMUogNj8MReimAy-g975Ww>
    <xmx:ITTaasnl5Cqz9S_m3_5VEMQAOVz1H5YBpXH5_6EVtDNtJftkseSYkA>
    <xmx:ITTaask7qnO7jDN_RJJcaXjRuLkqmPTjvBLoxDD21UH2jYEXAuppkA>
    <xmx:ITTaanM-E2nj4tOJqToeHVXfRA-Ni2jrvboeJpTxIg-gwfLDPI1G8mEr>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 12:04:48 -0400 (EDT)
Date: Thu, 22 Oct 2026 11:04:29 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Nguyen Duy Nhat Anh <neganhat@gmail.com>, ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ecryptfs: reject short encrypted key payloads
Message-ID: <179268488671.837681.74144863274950534.b4-ty@b4>
References: <20261016170633.1415240-1-adrianox@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016170633.1415240-1-adrianox@gmail.com>

On Fri, 16 Oct 2026 14:06:32 -0300, Adriano Cordova wrote:
> Reject payloads too short to hold a struct ecryptfs_auth_tok,
> as a key created with a non-ecryptfs format is shorter than
> the struct, so the payload gets dereferenced past its end.

Thank you! This has been applied to the next branch of the tyhicks/ecryptfs.git tree.

I made one small change to the first patch's commit message. Instead of
"as a key created with a non-ecryptfs format is shorter than the
struct", I changed it to "as a key created with a non-ecryptfs format
can be shorter than the struct".

You can find a direct link below but please be aware that the commit hash is
unstable and, therefore, the URL may not be valid in the future.

[1/2] ecryptfs: reject short encrypted key payloads
      https://git.kernel.org/tyhicks/ecryptfs/c/00cc31a869e2f635e6455685c91c4c9045c96ebd
[2/2] ecryptfs: bound session_key_encryption_key_bytes in auth tok
      https://git.kernel.org/tyhicks/ecryptfs/c/8f6626bd6594a78f454d02b27b74a580c890cab9

Tyler
