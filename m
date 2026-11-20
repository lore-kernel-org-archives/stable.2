Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164004;
	b=RVldvhza2wrdR7FeObiPjsJwEVw547UQtz7hXTg/k07115IkDMgR7X7U/XRiuTJldqo7
	 FOgkACW1JpI9CcrEBH4NWynqcJvlRNNyfXxW8hJnK9Rxfpva8zSxq+vI/IZkbPyXVt6yr
	 5FLJaCp83CLqR5IdltFMpU8epGoZgZo6U/qT96MtVhTmAooOrMWZaUV4XO7hNx/J0303W
	 oGPsCvC2Hny1+GuaILoQ0hKEK0eBmCeR8iOWqJcC2e2dbWbFY7xq8nz//MiEhDzhko2Z7
	 XqH6/BnB8uFRGorteGrMO9jGe329w6vTB6mMf0OxX8Mnv5rQEemWkJCB38TmaeCncog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164004;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OCZTGaCFLCsYJTt74vJ9dAjfbmceFOVIaPHdnU3R0Vg=;
	b=b4DwgLQ9WbwdPCuU8pYNHZ0wU7f4fa3MKJIyul2RxzPYmd6dTsf4XnobsnF3uSMC/o4P
	 ni5UdvJMVW3UzOcsKADEFPKSS15ZfxHG2Bxf5ds425coZ+Rkwv31AK8Sy5mvmNmJ6G6Gu
	 O19rEjrWgzRjPbz0anGAiSBx9Hf+e65tUd5wUPc+t42AkQu78coJXG6lnvrk1AHYfQR/h
	 /ppqYLPcwZeLbRgFUwckGwMXJ0rGyXZSONuL/EfvR68o8weFO5fR5wUXQd4/Vi39tAN5J
	 D076fj8v2ecuycJLUCVwa/S+F+P3nFE1ZoTiWgSGbJSchAPeh4NZKYSWJzB6F1GQeSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hK4CLmUU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452CF606A320;
	Fri, 20 Nov 2026 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hK4CLmUU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8601F000C4;
	Fri, 20 Nov 2026 08:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795164003;
	bh=OCZTGaCFLCsYJTt74vJ9dAjfbmceFOVIaPHdnU3R0Vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hK4CLmUUEefRTCa/OduHAYiA83k5mlUlmHSUBtKKg7nZA4S2PvxBY/e4UTwS8V7T5
	 je1tgSp1qsPINAFW5QCWTaEH0w2HUPDd1VZj0GiLhRmm1eue4P6r7BrbmxlgoUvX+t
	 2PcgcUtGwuGAJyqfHz1zwhiIDCyhjJpiGSlAswOhoFK2L3RQ7O13fPUI1l03TLvEhn
	 H6pZzf6mxVyxNtfmo6LDWRnE46tPFoybx1BYDQ9PHXYe2atLS38oQPThXTtyM+kN6o
	 bouNadSyplwf1BuA/5tXz+lGxqpwlvD2nbrS838wBdbeHZRBnCnLYOAGzNZuVAfb5S
	 V2SzsSnUcBIqw==
Date: Fri, 20 Nov 2026 09:40:01 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: sdio: check the RX packet length in
 mt76s_rx_run_queue()
Message-ID: <awAHYUeQXyiItg_3@lore-qca>
References: <20261119124928.1398520-1-maoyixie.tju@gmail.com>
 <av8osemFMD6C2EdK@lore-qca>
 <CAHPEe=FFgzM3L9aiBNczg2AQ4JiG-p+eFKLemjrOMzekuBmHpg@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="IyzNOabBFX4ct+Jl"
Content-Disposition: inline
In-Reply-To: <CAHPEe=FFgzM3L9aiBNczg2AQ4JiG-p+eFKLemjrOMzekuBmHpg@mail.gmail.com>

--IyzNOabBFX4ct+Jl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 20, Maoyi Xie wrote:
> Hi Lorenzo,
>=20
> On Thu, Nov 19, 2026 at 05:49:53PM +0100, Lorenzo Bianconi wrote:
> > I do not think this patch is correct since we actually consume just len=
 -
> > MT_SKB_HEAD_LEN bytes at most, right? I guess we should add something s=
imilar
> > to the patch below, what do you think?
>=20
> Thanks for looking at this.
>=20
> The fragment is len - MT_SKB_HEAD_LEN bytes, yes. But
> mt76s_build_rx_skb() first copies up to MT_SKB_HEAD_LEN bytes from buf
> into the skb head, so a frame still needs all len bytes between buf and
> end.

ack, you right.

>=20
> > +     if (data_len > len && data_len - len > buf_len)
> > +             return NULL;
>=20
> The caller passes buf_len =3D round_up(data_len + 4, 4), so this check
> never triggers. With it applied, my harness still reports the same
> reads past the buffer.
>=20
> Also, rx_check() runs before mt76s_build_rx_skb(). For a TXS frame,
> mt7921_rx_check() and mt7615_rx_check() walk the records up to
> rxd + len / 4, which a check in mt76s_build_rx_skb() cannot cover.
>=20
> So I think we should keep the check before rx_check(), as in this
> patch. Frames that fit are not affected, and the loop already ends at
> a frame that does not fit.

ack, I agree. Thx for fixing it.

Regards,
Lorenzo

>=20
> Thanks,
> Maoyi

--IyzNOabBFX4ct+Jl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCawAHYQAKCRA6cBh0uS2t
rE6BAP4shk3MXabjlp0caLHfRwygk6zb5Nhlb27aRWMLHkUiCgEAnhJKQlsfCUb7
nC8etWnjWA8G6qYx7kV1eLKJ4sptcA0=
=ELHR
-----END PGP SIGNATURE-----

--IyzNOabBFX4ct+Jl--
