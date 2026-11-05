Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867632;
	b=ygBw5Zlyiop6r84f+Nz2G3xZfxzAgoOT1rIbYhhaoxTfjLIksvXHSrl96ugnJLv4P3rF
	 GjzoETWs/LFJMLTcwV6IF2T9NEWVAfkdwhLDFjBUZ0pSoqSjvEC39l/OaerrsKB2vsOhy
	 mBlxmO/7G8qgPCn1Y/Wqmy6rkhDR1xX8NFSl4T7xuW7pdidatQR8+L6zFPC12q7onik26
	 lwM2Mg6ZSpXJOI7/ddVH7j0tZJEjAGpgsh3RbM1lYHcCEjViz+uBri8qiLjtpbXDse7rx
	 OU7Q1iMGghHYXyFkAbIz75Ku/r0kxn6G0QM6OkonVFDwNDL0zYQxdxjFhcYrODyQlig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867632;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iW7H3WHMn25bkmXFoYE2d48O2EiUJdBfmMFknEr+2HA=;
	b=2dVnChTOeyBduD7hpgsF9Fa8ODsN9HFdecIblVHrYb13lg+xgsaFHo7tTp6XNIvTrAC1
	 gZ5dYBtCe5SCxTdsraFlHUBc3rkv713Z939BJXLv1UUiiCTUjKl+uS1G98dTsFDDsw7Vu
	 +obErXN927rXiPU5cORB+/wz8mSQydl50/jU3Zl9qFha8GqB0szzzk+MqjqQZr+hlVwTw
	 lJECCi98RtUYcyo4hJvy7cUmViHU88WyaIpO/xTnpYODQSahs2vm0nDmAAWY/i3Qn3KBA
	 L2HZ8b3Lvr6BrE3ZO5IOfDBjpIfWzN33Gnugwo9a0t7xUBkglRZvS2k4DmAeidnWYVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eznWUqSh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34238606A326;
	Thu,  5 Nov 2026 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eznWUqSh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7B61F00919;
	Thu,  5 Nov 2026 08:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793867631;
	bh=iW7H3WHMn25bkmXFoYE2d48O2EiUJdBfmMFknEr+2HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eznWUqShYl/NC16Y8GIGt3uUMyGUZavnSVc+I4kvjO1zwQF63uuZnfhbQ9aZ3brt9
	 nprDMllmfL+c+6x8bI4fLaPqO9MPMHFKUXJxjW59zuaMFysEo4FT8x4/a5+RIkE5wX
	 1GC2f9JV3iBvOyExlE6nnMiwZNBNOLU5qTXvLB8d007ktDTtExxRPehzL7CsYRdUsd
	 dtiqouD7ZHZPctVjjg7xhGiac1eIfvHYEKHCmQ+IuLira1Vzr1ocFgIQ2nVEgVq6OI
	 d9a+ZYnrF3OHa9THimvg9EuWlrM456K+sfrFWA9Ro+LT5C9N3544vB+F/VoZn58b4L
	 tX7WwfqYoCIoA==
Date: Thu, 5 Nov 2026 09:33:49 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Zhi-Jun You <hujy652@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: mtk_wed: fix double free in
 mtk_wed_rx_reset
Message-ID: <auw_bbGdPSe14ScB@lore-desk>
References: <20261104-double-free-v1-1-efa52326702f@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fvGPRbACKxrQqlPK"
Content-Disposition: inline
In-Reply-To: <20261104-double-free-v1-1-efa52326702f@gmail.com>

--fvGPRbACKxrQqlPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> mtk_wed_free_rx_buffer already calls mtk_wed_hwrro_free_buffer but
> mtk_wed_rx_reset calls both subsequently. This would cause double free
> because dma_free_coherent doesn't set freed desc to NULL.
>=20
> Fix this by removing the mtk_wed_hwrro_free_buffer in mtk_wed_rx_reset.
>=20
> Compile tested only because I don't own v3 hardware.
>=20
> Fixes: 1543b8ff02f0 ("net: ethernet: mtk_wed: add wed 3.0 reset support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/map/216156
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhi-Jun You <hujy652@gmail.com>

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/mediatek/mtk_wed.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethern=
et/mediatek/mtk_wed.c
> index f40ac5794341..5e9674c9e63a 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -1723,7 +1723,6 @@ mtk_wed_rx_reset(struct mtk_wed_device *dev)
>  				   false);
>  	}
>  	mtk_wed_free_rx_buffer(dev);
> -	mtk_wed_hwrro_free_buffer(dev);
> =20
>  	return 0;
>  }
>=20
> ---
> base-commit: 11140c51df12e594d6bf2c8d2af5dec63b0219ac
> change-id: 20261104-double-free-b6b95c2539c6
>=20
> Best regards,
> -- =20
> Zhi-Jun You <hujy652@gmail.com>
>=20

--fvGPRbACKxrQqlPK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauw/bQAKCRA6cBh0uS2t
rCrlAQC7U08r6yWH2MyECLvdMu6gbWP7XteyGKL+5WSDBvEOqgEAsqz7Oi41Rjcu
KLPvD2yd6ku7X4ocmaGpG91W/jrixAI=
=1yhj
-----END PGP SIGNATURE-----

--fvGPRbACKxrQqlPK--
