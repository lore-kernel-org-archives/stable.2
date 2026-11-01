Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793562110;
	b=AFEc5hRR1zJSyTPPEAK9eCimyFzLqm1+H2j0elayxswc3A2FiZyoU6oO1PUsH2xhBBuM
	 laVgsEy7hvwL7Gasz5ioxe6U5Vsd0fkSqu5Yq1Pp893aXRSKDUQ9VSylZ1JgDSPZQBiMd
	 +LpnrtGce51ZTdVrW+PkjrPc4OHf8kZCZqGEJnEpEhl2+esWEQysV4KY56LYfgys9hPNq
	 9uz+MjnYVbbs1S/GfVue1XyYmNd8n24cGvDomve4uhJ+smxTfKJ99uyU7DODvO8qyUhuM
	 JJcaRJiDwlCF0xRktsEOB2xvCmmB+BwwMcBf/POkH/s26Yfk2z351tdBQxWfyywuOgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JA3jX3tndrIW4yCSFoQPJFyHa7m1TQaR2efx9QzdHgU=;
	b=ngYJld5uMXjRp+PlB4AvqkuzcVnSyn/8se0BCEBasq/Ydq21veuF2RTtzcfVItdVHk/6
	 8AOMClCMmlHKQSJttHn2QiJOvuKTdctyPcid3W4erEDq6g3FStuJkYTeX3Yxy9dJMFN7a
	 xNOtoKay1R6/3vySSyD0cmcX10l/btxa/+waQlAg6yoexa4ikauol+Om4Vn0yvgFtjLC7
	 QGUKqg5zhuxyhHVntqmvmQY8L4jpHGT27akUmB1lb1GjWuv6LmyuLG8vCsEQRFNqPwKt0
	 sxAY8VFpgtY8/lUC8R0AsVCBBWK+H8WQHxbE+0hLQRikv7WtUaM893G/EMInHGWffFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ot6Gds7T;
	arc=fail smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3C606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 19:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74A3C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ot6Gds7T
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9d7791b00so16838395ad.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 11:41:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793562110; cv=none;
        d=google.com; s=arc-20260327;
        b=QgFnZPnJWCUTrmIElyEhiQnbh7qS3qByJwVhqvvz5GHOe1rvaseXB6LQiPciXcRDyT
         XDZVWnQgZG8fLNpAxXdzLsvz9QaSFR1pK5ppFsOPx68ljkKmf1+R4APcZV8nY6dGLlZH
         8fsY6zw/uyQIUMTDbBQSYSXCdZ14pFvBzXA6L86xwpcpjcbC7kNX3LByFaxgqqONzzbZ
         QO4Awj5k3OJCHrz/54b+fgWZTsHba1yHm9zHN6xl2DzMUhWMs+/jPOdxRea5cM1LJC+w
         NT39A7Q0WA13LEoEC8h5JHIJ5doXGXn1QaJHjSs7DAE+wWZCwbmLg7sK5PrlOEsnpSGu
         kDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JA3jX3tndrIW4yCSFoQPJFyHa7m1TQaR2efx9QzdHgU=;
        fh=8epfHTPOOjndCBtQ0ttsNSg8mmrX96jT4Gzur7OjQpk=;
        b=IODBAeUS7MJteGwkASZOUzdN+Upkq4/NnvfzZuOs79Hq4v71b6WpRweOSMYvTW3+ZN
         32LEpVAoFWG7ydcZxisnXsLG+DOOdECsosU2hIMnmWVd7BZyp1LR5HJNRr8RFrns6koC
         3DUbEVhjHkU7AGuAN7UnW3ucpjdum1TExdawm7LLgkPVzkt49I/nGNriFPYUoEg9vGM/
         vZBRptQKho2xvgSdgtFlpKIvCvnUTJkhw7PecNLMWBhFuX/2gQLzYEYZHqBv0JN9ahaH
         l7fGvY32n2TuX9bMKsC/8av6oxTmJM5xYnQE7zC8JZnM4u1ujaeBBlHTRH8oVe0Uu84T
         SaeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793562110; x=1794166910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JA3jX3tndrIW4yCSFoQPJFyHa7m1TQaR2efx9QzdHgU=;
        b=Ot6Gds7T+5UmsDwVVpntlzClSyWM0aKqpK4RXwbAj+elqcztjTX1ABwoES4t4j6tsF
         PcG1/jCUFX8ULqCgxwPOFB53mEIr4k3pNMBPt8A5jJUhhznD3mrn/7zk+8BgjJncKDuW
         cEXCVwQb4QyqL9MPsd7ovyb+EzQbUePlM1RD/78aWInie7KEY/310H54plu42QP8Jtme
         mNuUAip/djVFfwy0upN5ObbPCJ4pE1E1ksL5cDXnwcIH2JUnVt7o8HeUY2CZyGAywaoM
         yPeCxohuqbzK81O1LcmigXaqDAvbEcSkm8nTiRJ3b9CVQRg2JX/nWHcnfqtydoz/ai6a
         X75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793562110; x=1794166910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JA3jX3tndrIW4yCSFoQPJFyHa7m1TQaR2efx9QzdHgU=;
        b=0mBB37ias71+l3YTbDwNXINMT8OLJsSwRLAY7Xv80zsea9ChwIcCHJJow2/93Jnrjh
         9EJWvdtUVMBql8G4zTvN/MCQgVY/szwloaSlz9SdxoEbgtEQIOXPTrBIbvtt3VDp9VUO
         macEn0hOD6NxseAmRtB+Z4A3S6he+DuS5ObYs1l5P5HUoNhRTQ+GmqRI1zsZA9eKe22l
         6Eke7hiUn/6ONpwTXjaPoYtERPFZFxacFb1m6CxqylaMS3Lg/9nQMT3ZbWfUHV3bmuoj
         B1+Qk6hRvyj7AwkeqRhDHO3bMDkagKSIeH1xGt4G3q07BjH4CrLLE1TK3yopgemRhHVB
         Bplw==
X-Forwarded-Encrypted: i=1; AKwUvBx0r6cbLM6IzgPiK7DCOl6SVXnMcmNeXTXcLM8QnJ7VhZmIkldvkBXYOxUAAI/WyIs4Bx20NNs=@vger.kernel.org
X-Gm-Message-State: APuU4Z93iBhL0MZNuM+XwVEfxlBI7EElfDb1KD5zCfeIYxfXiFEN/Q6N
	dbX5/esGzITSH5Mv3i3omp/24qO3/MceO3FUlD9r+d490ZdqFXxZ+tOKtTx5vlR1wPnUDf3rBJQ
	Wj3b2mpa3t+FFmLYtxlL9N/JPsQr6eg==
X-Gm-Gg: AYBFou2aX21KdYG3ySt2Nj6qvbyJR3a7MGKoNw1Ew6kqDlwlGoWPzNBa45VYH2stj1G
	RIWHss0gWRc2q/jjkp5wQIpPXG3KF7Z7LgkeC2bZNU/ZkAdr/tagGwwVZKSFIK/nCPFZ+5kfcAe
	LjvUSaZeGiQlcAjNsiT9JERLd+o5vPYRhfTrYFgkRWhj6x1Sv27e2jwAcxJZ17z86cdA3OWdEjo
	T8OGjFMSdEmrY8Wz0igkBzFcKQ0Jl3F/V7YGOcIc53t/aMnfqBx+Lvb7D/XvIypK8p4Y18dT5Cg
	lSX9ZWerRx5EyzKGsAaeC3/82ezkQhMo2AKew+PxSFdBYxx1whHacDs+0yfF8PcEWi/TgB7q8S6
	L2KY3dFCXvBOYgYtqagVQS4R4eYwh7zcHkTu1OvVtvPOS+GJVbuW7UdI8Uf6BjxJ3UChxNA==
X-Received: by 2002:a17:902:ecc3:b0:2e9:814c:dccb with SMTP id
 d9443c01a7336-2eb36520f1amr79989415ad.69.1793562109749; Sun, 01 Nov 2026
 11:41:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031133455.3070233-2-rsalvaterra@gmail.com> <CAL+tcoB6vg+-w1JZdND_cTN_zPeh76_+-W_NU34jkunJUFwrrA@mail.gmail.com>
In-Reply-To: <CAL+tcoB6vg+-w1JZdND_cTN_zPeh76_+-W_NU34jkunJUFwrrA@mail.gmail.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Sun, 1 Nov 2026 19:41:38 +0000
X-Gm-Features: AclHuK-312lSJcqm_yH_edcVqM-T-ygyAdVyAurMKANlnKwC0cEWpz-W8iElwLU
Message-ID: <CALjTZvbPacWO+NY62fbFdQEAJemD57zmhdYy+v+BXpxFgntcNw@mail.gmail.com>
Subject: Re: [PATCH] tg3: make depend on ZONE_DMA
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: pavan.chebbi@broadcom.com, michael.chan@broadcom.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jason,


On Sun, 1 Nov 2026 at 05:48, Jason Xing <kerneljasonxing@gmail.com> wrote:
>
[snipped]
>
> The blamed patch seems correct, so I think you need to root cause it
> instead of adding a global dependency here.

I'm sorry, perhaps I misunderstood, but *I* need to root cause it? I
never claimed to fully understand the implications of the patch I
sent, nor the intricacies of the tg3 driver. What I *do* understand is
that a supposed "fix" from Broadcom has left the Ethernet controller
on my late 2012 Mac Mini inoperable since the 24th November 2024, when
absolutely nothing changed in my kconfig. That is, by definition, a
regression. I'm entirely available for testing any patches people send
my way, if whoever fully understands the driver and the hardware is
unable to reproduce the issue. However, asking the user to fix a
problem created by a patch from the hardware manufacturer is=E2=80=A6 an
interesting approach, at best.


Kind regards,

Rui Salvaterra.
