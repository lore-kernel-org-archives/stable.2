Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478107;
	b=KN3AWY7PP6hxo7VtoCaYSs0YPNBnp7Nst5TYP5d6m1SXhgeu82Lt4mNPAJmafiGBMbmv
	 dJzpHa5c00FFaWZKpQsE2QwjW7nWBh364VGT8x1uTMwU6VRw9A17L2xqh6CRAX5EZi2eT
	 NIz4mJ+As3/VoscytYhaDjewTYd6/etzXlUnF+1LFqqKRUwooTpU/M0SZKjnpyuN+f4hs
	 XIH1OjuuNk0au3ZnbYsQMoLocDCbxgzbDdsq+T3556G0c5t2tyvRX/JgzDEizDd/vksd4
	 6z/zYGw5EAr4Jja9tofJ0egG8FskDm4MZF6hxHixyrpAdxHbsJ7ONBlD/pFLVLu2zDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=stpMvXIXp9iGZb1SUS24yhnAumjBKjIpChQo6LabxKg=;
	b=BY5O2pksJL5GrO8FS6xbU3u6W+oZOpPIWyY0wpsclYEptnx0Fxenf0kUluYFtjwi00iV
	 XoUbiPQMbnrbwALJa/pq31MQu4yBOj5vH9SGw3d4Yk/hRMJwdE/SHdsp3MJUrZwxsbBGF
	 F1sv9hwe7IoFfrH5JegA25iCdp4Ml1gKvUzM/DuSdDjsEWLCB/LJd+jlv5sLqpn3lgN/3
	 YZyNwRR/RosV1JkZ2ASBBp37CGe98YO8YECRI/axbeJ0JgKg+NvYx6SerkTikttVfRtz4
	 plJnVz9lJN0+wEgCzrJkm+ddqRLCzW0V4HsaqqfAzT01xCoir6jVEGlhphthCk8g+7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dKfympfp;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E1606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C3E1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dKfympfp
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so31260465e9.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794478105; x=1795082905; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=stpMvXIXp9iGZb1SUS24yhnAumjBKjIpChQo6LabxKg=;
        b=dKfympfpfKj99jgLwxm3SlAiqNp6SvPx5zNadVqEIczyZLFAaecoCR1N0SPhQM8bBP
         OOqkxIj2Vk/CbfQKf6VWDg9wB+l50tqzDsAgcjQyv2CoNQ/FcCXmxD+d9x82S4UfN9tk
         sW6T2HwghchjcRJdA93rLETtqhtouEa79jf+AAodQ6XfcFJtXet+WsPYuSb5zv8yx3pD
         r5FcRFN09b0WifkamDp3a8zvWFgzYExbccTGiSXt5dOdg/Minza2NVKuidckMhvEQku3
         b2c7U6jQPLaQUOKCuSm+wCqzEdsQR9jQp+XKIbyz0R9WPODmJc6o6GJL+Gl5xQRZjhQQ
         z0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478105; x=1795082905;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stpMvXIXp9iGZb1SUS24yhnAumjBKjIpChQo6LabxKg=;
        b=GlcUaB9tEC0so/i5J8hWZwJq56fu+o/+SWoTbC2TOO51UYSDf/2yYuI8CbizxW8oFk
         r/XeoZEJoBT4/RLQx8Hbmg9RAk2iMv1xxCZzuUTcrzWb51Cf6RStx9MwK1JsiJHA1CZA
         miX6RanHYsVIMH2VMlS1t6PvIRQT1HCzZg4AqUD+UKsNnJssVqR09kpaHVPbvy6zFpo8
         qrFaMf0H2xRV42liQ+L1jEHz0rLfuGL4dmklzLOMj3AKN86yMxOpjgegU7NYjoQI5ybZ
         FVqQGkavifsJBnJB2OM2yXnYuYOzziUWanaItPOAKktNUnY4IePWkkQvpNbEn3ACOSx5
         2P3A==
X-Forwarded-Encrypted: i=1; AL+hErGBvcwSTjev/U2MsiJAAkNXSAWibFoHbxMKPdEscb82hFkrm4yQn9un0crqvq97JKHXQA3ScCA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YUU/Tsxb42rkfZ62icoeVDiR+mWn2lHYhj7+7UATROnJPc0dl
	bn7sil/DfmEL46pTh7H8iiza98jvvDbSb5C+39bK5zNHU6pQrBVTgUKX
X-Gm-Gg: AYBFou1HzVOyJjtWswWD3AbgBz/0TGmKqmnED/nkBqMmTxzW2GykIcAcpL4IrKqZnb5
	UU+S9rH2aH0eAEKeoWFl3E2R1H/5Xxl5FaipgSf41K9yoTdKPpu1VT8nzQjHYLD5EDvbJpJ05V4
	dfzNwUYbVElCXrgrogXned7jAYNAywkiS7YzmMm2FAzlJvOgpQ8Pn9pADsyWIWe5F+ZGIhgdoMb
	6rg6pXwZIEyruslLRA8pYevsmAerWqnN5Mqk7mTnz3ELtrI79ecEksV4xhJulZBuip6mfloLi7Y
	Fd9B3iEBNAxg2SH5G0pc2jgmarrJPAdo+SjYIFL5e/K5Tub7Jz7K1nj03gb6hxAgzV5VWE3nhBx
	HZXPzS++ucwhtsBd0H6wqGSlre5yQ0zcCCGEw30k29mITta8INke1g024Ro1X9Rup1T8FxpFkdi
	5MS3AAvg7REroyvUunH0ru4k5Ky+wcF7K8SekLzK+Esdq8971msJ3YLtjpEnObsK63YCgKS07pX
	lQMy+7Z2qaipblj4cIs2QC3mZqU2DXgfDuM7XyVM4pAu3CnxOdL0D0N7LylD3AMHwdWHkfsD2D1
	ee33iPk/UBqJYaQV9Ou1rdhPiUAws5MEANUQDZjePBZm+IoNv/k=
X-Received: by 2002:a05:600c:4e41:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4ba0931ed76mr91630525e9.2.1794478105252;
        Thu, 12 Nov 2026 02:08:25 -0800 (PST)
Received: from smtpclient.apple ([217.111.110.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0953d26asm70701795e9.4.2026.11.12.02.08.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 02:08:24 -0800 (PST)
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
Subject: Re: [PATCH ipsec 1/7] xfrm: esp6: use the current sequence number for
 the IV
From: Usman Malik <usmalik90@gmail.com>
In-Reply-To: <20260930144523.435271-3-Jeremy.Jean@oss.cyber.gouv.fr>
Date: Thu, 12 Nov 2026 11:08:14 +0100
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Sabrina Dubroca <sd@queasysnail.net>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>,
 netdev@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <07261E5B-923A-43BE-BD55-B2AB94D02836@gmail.com>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-3-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: Apple Mail (2.3901.200.71.1.16)

On Wed, 30 Sep 2026 14:45:18 +0000, Jeremy Jean wrote:
> When a GSO packet is split in software for IPv6 ESP,
> validate_xmit_xfrm() calls esp6_xmit() for each segment.

Tested this patch as posted (patchwork 14858682) on v7.3, no other
patch of this series applied, in a VM with two network namespaces on
a veth, plain TCP over an IPv6 rfc4106(gcm(aes)) SA with esp6_offload
loaded and no hardware offload, TSO on, 3 MB per run, 3 runs with the
veth default noqueue and 3 with a tbf qdisc per SA mode. The sender
capture was decrypted with the SA keys.

Without this patch every run reused IVs. Over a transport-mode SA 1 to
3 IV values per run in 6 runs, over a tunnel-mode SA 1 to 4 in 6 runs.
Each reuse is a packet with sequence number N and the next packet with
N + 1, as the commit message describes. With this patch, 0 in all 12
runs.

Tested-by: Usman Malik <usmanmalik@engineer.com>

