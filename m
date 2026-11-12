Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478501;
	b=1hG3lFT9gQfQcxFKYS1M4i/90DbZYrOE8mmCnKd8a3wHOejSbflyDuFtxqBzH5bT23+P
	 dafo5Im90ySZTJf+ybiKD25ZoiTmXmPB71FXR10mTN6H8pNT69c0S7H3lUijotH92Tea2
	 H91WOnoNUUUuTvv+MLGWIQsx2RXqixNGjKHPy5MoCbmy5pyFxaWOMOUoFUuLejoIvczbJ
	 BnEzUI8R78/oyzX1zSEvzjQIi7/YC+s7Cwpl/xZniw3GzdfGfsncGecRdXYdCr7RHpT6r
	 ok9SVBGg+rosh+S2QxOv0Kxi1vekBGM9Crfn1pmCDPyDCu1llBvcfSwtHpfOex7n4KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=ihVUDcggHZh6D0xYhZJc42bMgYps+7jjufAK/stHqbo=;
	b=z3VSeieOx2v+tdPgVDX7W6H9aDoKXVBCr+r3KFOfmXe6cQ2MEvTU2BIXdAsa9MCHphBN
	 LAYjymA2e6l3Isi9UrL7TrfkCUn7usYq9lEt+uWvmvXMcbZSSU9RIsPW4Zh8602D5TRjP
	 jcc3cLPVy6LHSjA9adPSLobVVUmZh3R8tw48Xz/dyEQX4uw0cJrhcas9+CDK/PtV8yOOL
	 X/ELVOWjzBYTmRYPGEOwzjj/sQTLLUAnXXjDeILcCuFYRsC51/Si02JPdI6eBMl13f3A3
	 zMgyfFQtyK2889nIgeW1GoH8DfPvbpv+3P5/laowikokTBfrG+61BgwWs2yCkyiBg8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSgcoAzY;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E12606A886
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9E12606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSgcoAzY
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so6393175e9.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794478499; x=1795083299; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ihVUDcggHZh6D0xYhZJc42bMgYps+7jjufAK/stHqbo=;
        b=TSgcoAzYSBGKg8YleqBq0oSirYkeMKTSHAk1fuGI/Ma6xKCokSaxTddLnZLIf3yuXx
         MfbwAaoioEP2GFhBmnxpxlLvy2093taK53Rc/Ndf0mkW2go13gq19PpZ/mKNDzTXGxvf
         5f4W15IQdBuZC7xcEYGhjGFVUnI8W4pmq7CqHcuhDrfuDbYZCX9FxZsDzj3f7/1uF6kN
         0MVvnQ/Sisk0L+854rFAY8WF7iV+6F6LhC+BYrwynW95cItJOPimtlpJK5r1PrDxDzVd
         iPwJWJFozgVKMIHJhBHlmqYl8WATj1y72ZfvRJzgcZwzkZ15q4x8yqCBje+rNX39FKqB
         sj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478499; x=1795083299;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihVUDcggHZh6D0xYhZJc42bMgYps+7jjufAK/stHqbo=;
        b=ecv8VgNh0KbakwjgobDvo27IGSWwJhzehcu6eLYV3zjjc05alI+zDSdrvpgqCwT4Hu
         2i9H4BJoxmtFYVVAnEILGa33kBkUF5lhSsveS8pLW/Bepyjky+b2uoMp9HBDtunzcaWF
         WQQXyEusiTIoYjthdzMd3YqgEgsr2MZXaH2MTFXI61gTe5YcUIc+qOh4YAsRCWi/N/Wt
         4vKJeS5ljccpaLNJrDSFsn1aiSk3+huxIBfCwH3CrbYdIY5fz1rbEtllT9SiylN5z7pi
         SX82idOy1bc0L2Bk+xM5QdzxgmKb1PnA4Hre7xpJXhvN3UJ+KsHT/1gy/fSZsNNo8HnE
         ipUg==
X-Forwarded-Encrypted: i=1; AL+hErEa8b5NM5vZIX/Siqd3gjhNP3r6BcnFSTXpbuYoEPGKqVrvPNu68A636Bdjit+1nJ6r6Z7CBQY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9LN+JVIjP6eeJZM55k2EmqvdLldBIR3CJNatVpmJTi15e41Mk
	kbuc+nX8NRMelRIlpglxn6fAuGQFXURBRNRkve4v0pBeOUNCNYVVqk/4
X-Gm-Gg: AYBFou1Z4n5LFwYA9Nrl3wNcEhYCmUhNQT7ka7s8a8ooKl5y57tSa+TUe6d52aJgMzC
	xVQ8uVebrjcRIapxxeFD2W/CaxvSdZMlvRYCIZde/jFE5JuAlEpiinFf8DJOQlZRF0tnHDEqmby
	mZvALz/WaQ549oRwSicVypbtcAp5OromNWVwJEmndFXxU0GGo3229x73OJ9opc2bRTyaEmzxoE6
	VAvLSg8KM0J85Ou9y3pRcraTX2CJpFgVXGgKzSuNDJCLw0rVLkp7VVgek9dMwQg4xfAHkbr3C5f
	7z/gYrvYHk5YamAPLogl845eUU5dnveiXdE+O1qzC443VlkfhTykIaGAw7ExZ2Twl502cf3ZGU2
	w2sPmaZmCBKCyYpH6NvuBKpJyGyzHubXJ8YFEpXIJJmdS16vXLovzWmFHJf7rmF9UJKgR/yRBNn
	dKpSZnpHG2/fuIyl1AsScS4dbgtAdnvtbi2c8JzNNxbTIViT+taeiM6uYoKf4iYBE6K60Uf5lyl
	pUhbrBOnKhwFTCNrdJvdQflR5Kxpqy5Y8gLmjCZZrQ/38n6nkpNjsUatoJSJVCZNdAj5NIGPW/f
	DYjqtJs2PkZZ0wUPjaG7Axkl7+lwIZkGMg+OsTWqwpcIE970OyJYM3dBs1Efo9ePunwMhi+3
X-Received: by 2002:a05:600c:154a:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4bb4e27a9afmr42890975e9.7.1794478499301;
        Thu, 12 Nov 2026 02:14:59 -0800 (PST)
Received: from smtpclient.apple ([217.111.110.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e26700fsm66747305e9.10.2026.11.12.02.14.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 02:14:59 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH ipsec v2 1/7] xfrm: esp6: use the current sequence number
 for the IV
From: Usman Malik <usmalik90@gmail.com>
In-Reply-To: <20261108142652.1330952-2-Jeremy.Jean@oss.cyber.gouv.fr>
Date: Thu, 12 Nov 2026 11:14:48 +0100
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>,
 Boris Pismenny <borisp@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <530C7AD4-2591-49A9-9707-D504EEB48542@gmail.com>
References: <20261108142652.1330952-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261108142652.1330952-2-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: Apple Mail (2.3901.200.71.1.16)

On Sun, 8 Nov 2026 14:26:46 +0000, Jeremy Jean wrote:
> When a GSO packet is split in software for IPv6 ESP,
> validate_xmit_xfrm() calls esp6_xmit() for each segment.

I tested v1 of this patch and posted the results in the v1 thread:
=
https://lore.kernel.org/netdev/20260930144523.435271-3-Jeremy.Jean@oss.cyb=
er.gouv.fr/T/

The code of this patch is the same in v2, so the results hold.

Tested-by: Usman Malik <usmanmalik@engineer.com>

