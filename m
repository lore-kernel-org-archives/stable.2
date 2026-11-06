Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975198;
	b=ustygO8vHu1e7g/oWjhrGq/B/WyJu6jKzYnhZ5DR3h3+tG1I0NYmOg4AEQOjNAq7Zty6
	 EXvhytaJZ1EVPe4JTFcOo4zBnBvE+LUbL2UxdchPQy2ZXS0UrkBl/GT6ffZ5lWvNaEM8L
	 EdFNbVhpPbQL1UszT3z6l4F8gT0X3a9hipUUCKH8ZPv4WrFfhakZi0Y+akkBw70LFc5EC
	 +m5Z6tK4Ot1pBikcez4olrYYWul2r/yNIpT3KElsQ3mcGFyr1n4da4/9Aud7WF1jQjeK1
	 qvSZjyaqGmIrwyQF+jHkLn/SVlyCXzUOBZ0sEbJp33eIdLn+UXoL7s/wfyCyb7KtvJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975198;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+KYXN7aai6IX1x5SM7xizmV0HBq9zshAmdQbcwaB9mo=;
	b=2hKNny2KMF/2YKUu5fczjCJa3mZI4IdcsxaJW437EvGcuMo9EuXx9b33VoezwW9cMRAk
	 B1E4TVZycjR4pOLOj2xqthwb9Q/ZU1FtYHbet7WbMPq/eQkg1XSL+NJ6CGislS/NmBYW2
	 MNla/W13mdidQ23ygeQ4XG25ZfP95NKqJ+yvRChjozXuuJTHRJj9yUtnl2a4j1geJLdzx
	 o0mAxQZAJOlQQg5gs8ZakH2NWv3L0ZWke5LpJ+5qNZvwhPsWdtxOB23/CE6TA2v3R5TZv
	 P5VKjtrVgSQGGCRqYdMclHxj9lhNHxprgtL9M/ZPCpQPJur9bZ2qxp/C0iKhnad/G3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmCJB6mn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98868606A32D;
	Fri,  6 Nov 2026 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmCJB6mn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E751F0089F;
	Fri,  6 Nov 2026 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793975198;
	bh=+KYXN7aai6IX1x5SM7xizmV0HBq9zshAmdQbcwaB9mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TmCJB6mnQ8WzGjBpzNOrtANc6+bY+KMqzHJFg2qc1E9+OtkJ1fZYWR9ZIu4yeLFXK
	 HwDvyReArqnyDG3QmALWbiL1UUAoHlZ1jK/ZNhu4rubc/zrBuAi4DMzhCTF1DLKLRp
	 xuN7JZL3hBmNMfjatE2r8jO3zUcSs9I4Bi4FufHBHsilAQiyHFpmc+e+H/ORp4tRkt
	 6cYigqJetm+vXP0Gj5Det55akl6h45cWKjSosDs+bG3zhkoPtiv3Rkxc5jXm4t06es
	 DoqXJat7+eqbmQdziODXhuruIj2c1Ezn3BX5guYcrgaeZ100NWd0yt9Q0wqog/BJJw
	 yKF6S3iPYGcHA==
Date: Fri, 6 Nov 2026 15:26:36 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Florian Maurer <fmaurer@disroot.org>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH wireless 2/2] wifi: mt76: npu: read the rx slot count
 after the first slot is complete
Message-ID: <au3jnOD5ZOJR0mvb@lore-desk>
References: <cover.1793927986.git.fmaurer@disroot.org>
 <653d93b3c35975cd13dd6b33d76ea6517b55be91.1793927986.git.fmaurer@disroot.org>
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
	protocol="application/pgp-signature"; boundary="KtjQmKF3zC2utkqj"
Content-Disposition: inline
In-Reply-To: <653d93b3c35975cd13dd6b33d76ea6517b55be91.1793927986.git.fmaurer@disroot.org>

--KtjQmKF3zC2utkqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> mt76_npu_dequeue() reads the slot count of a frame from the info word
> of its first descriptor before checking the done bit of that slot. If
> the NPU completes the slot in between, the count is still the 0 left
> by the refill, so a frame spanning two slots is taken as a single slot
> frame and its second slot is parsed as the start of the next frame.
> With mt7996 this shows up as bogus tx-free events, which hit the
> WARN_ON_ONCE() checks in mt7996_mac_tx_free(). From the code, such an
> event can also release tokens that are still in use.
>=20
> Check the done bit of the first slot before reading the slot count,
> and order the descriptor reads with dma_rmb().

Relying on the patch I shared for 1/2, I guess this is no more a problem si=
nce
we will just delay the skb allocation. Agree or am I missing something?

Regards,
Lorenzo

>=20
> Fixes: 7fb554b1b623 ("wifi: mt76: Introduce the NPU generic layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Florian Maurer <fmaurer@disroot.org>
> ---
>  drivers/net/wireless/mediatek/mt76/npu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wirel=
ess/mediatek/mt76/npu.c
> index 6e503a4a890c..f00ae683a7eb 100644
> --- a/drivers/net/wireless/mediatek/mt76/npu.c
> +++ b/drivers/net/wireless/mediatek/mt76/npu.c
> @@ -72,18 +72,25 @@ static struct sk_buff *mt76_npu_dequeue(struct mt76_d=
ev *dev,
>  	int i, nframes, index =3D q->tail;
>  	struct sk_buff *skb =3D NULL;
> =20
> +	if (!q->queued ||
> +	    !FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, desc[index].ctrl))
> +		return NULL;
> +
> +	/* The slot count is only valid once the first slot is complete */
> +	dma_rmb();
>  	nframes =3D FIELD_GET(NPU_RX_DMA_PKT_COUNT_MASK, desc[index].info);
>  	nframes =3D max_t(int, nframes, 1);
>  	if (nframes > q->queued)
>  		return NULL;
> =20
>  	/* Only take the frame once all of its slots are complete */
> -	for (i =3D 0; i < nframes; i++) {
> +	for (i =3D 1; i < nframes; i++) {
>  		int idx =3D (index + i) % q->ndesc;
> =20
>  		if (!FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, desc[idx].ctrl))
>  			return NULL;
>  	}
> +	dma_rmb();
> =20
>  	for (i =3D 0; i < nframes; i++) {
>  		struct mt76_queue_entry *e =3D &q->entry[index];
> --=20
> 2.47.3
>=20

--KtjQmKF3zC2utkqj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCau3jnAAKCRA6cBh0uS2t
rKxxAQCZ+WzNiOTB1+5eiTtdzP8G/JQKB+ravFT4xNbo4OIRTwEA61IME59No34X
i6GOyP7UthDtFp6rmgVGBPNWrHeuPgo=
=oeNY
-----END PGP SIGNATURE-----

--KtjQmKF3zC2utkqj--
