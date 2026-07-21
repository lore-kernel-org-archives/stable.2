Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807EA367B88;
	Tue, 21 Jul 2026 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641089; cv=none; b=n63GiINfG8R/msgSwrGwCNWBbRl5vqTzJcGsCWW6nUaDxaZSwDMZUcti+ZS+S8BcDESr8huIdfHVcvIx/Ar5h71UNe1666lvSTmtCcdyxPhw3NeFnR+kB24Kkt6WRxPokuZGOFjFfdT/x0oXEJvSrcZ+0wFCNg4JSvbCQKIzg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641089; c=relaxed/simple;
	bh=7BkyQZ4uyTJmDEmmLJa8zNvg1gbHk101B2wUaX6d1IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBmGyH5V2m26+oKuOp8+3e27ggAdSsmzaIiWZFEQf2rWKBauhA/8uh/7Lu1LaVAHO1UhdmfEsuPJdAymOL89S2sedAk8QzlFqwHPcEm2RuRNeoG28ym8u34UjvH/y7LLeqbrm4X3l3bMOkz+AFsT/2QoGeNzQFg/7PCNSnxIgp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG2NQBpL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG2NQBpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74E61F00A3D;
	Tue, 21 Jul 2026 13:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641088;
	bh=dG5v1XB3PvzTLRdeO2Qf9YtBA6Zx4qgiWbiYqHz4SU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UG2NQBpLEh9SaNogbQnp82KxknFuQPKMykJwCZIgTuGQ6TWmUYI7dFGB7Z0TkGPXa
	 z2AN7wZ6+57x556Uiq1l73TV6r3W29Vd54uAL3QBHdBSn/SG4iRIAZx/tyXtSgjmMj
	 UNg8Xwl0uR+wzBXkCwaIgCfSzfZV8lEFXm5eefQVEqU6XPlolFC5LUspXQcKNuRuj0
	 XZLE2360ghLzooOlRU6ag1zfVK25YfRct+MQXt7w1uRu7RJtdnCx21O9v+XBoTFmDl
	 9meLgZjbBjebHnCu4sCdA3iIgRLg9iKuBN82qGVDcoik3g4kXfCdJ8NwR3PF13/x1T
	 7/5PGIooMN7nQ==
Date: Tue, 21 Jul 2026 15:38:05 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Devin Wittmayer <lucid_duck@justthetip.ca>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: restrict NPU/PPE active checks to MMIO
 devices
Message-ID: <al92Pe2Z-oTiGsHv@lore-desk>
References: <20260720232640.41293-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZzjxQEaBfdmP5Whk"
Content-Disposition: inline
In-Reply-To: <20260720232640.41293-1-lucid_duck@justthetip.ca>

--ZzjxQEaBfdmP5Whk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> mt76_npu_device_active() and mt76_ppe_device_active() read dev->mmio.npu
> and dev->mmio.ppe_dev. The mmio, usb and sdio bus structs share a union in
> struct mt76_dev, so on USB and SDIO these read unrelated data from the
> usb/sdio struct, which is non-NULL in practice.
>=20
> mt76_npu_device_active() then returns true on USB, and
> mt76_rx_poll_complete() takes the offload path and skips
> mt76_rx_aggr_reorder(). RX A-MPDU subframes are delivered out of order and
> the peer's TCP stack treats that as loss: heavy retransmissions and reduc=
ed
> throughput in AP mode. Seen on mt7921u, mt7925u, mt76x2u and mt76x0u.
>=20
> Gate both helpers on mt76_is_mmio() so they only run for the bus type that
> owns the mmio union member.
>=20
> Fixes: 7fb554b1b623 ("wifi: mt76: Introduce the NPU generic layer")
> Cc: stable@vger.kernel.org
> Tested-by: Nick Morrow <morrownr@gmail.com>
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 07955555f84d..a32ba7c23f92 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -1736,12 +1736,12 @@ static inline int mt76_npu_send_txrx_addr(struct =
mt76_dev *dev, int ifindex,
> =20
>  static inline bool mt76_npu_device_active(struct mt76_dev *dev)
>  {
> -	return !!rcu_access_pointer(dev->mmio.npu);
> +	return mt76_is_mmio(dev) && !!rcu_access_pointer(dev->mmio.npu);
>  }
> =20
>  static inline bool mt76_ppe_device_active(struct mt76_dev *dev)
>  {
> -	return !!rcu_access_pointer(dev->mmio.ppe_dev);
> +	return mt76_is_mmio(dev) && !!rcu_access_pointer(dev->mmio.ppe_dev);
>  }
> =20
>  static inline int mt76_npu_send_msg(struct airoha_npu *npu, int ifindex,
> --=20
> 2.55.0
>=20

--ZzjxQEaBfdmP5Whk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCal92PQAKCRA6cBh0uS2t
rFxoAQDZmxV49WLDqcruQyFvjuTOhMYRyuY9EtnJNGg4tDWK6gD+LlYJLQ/0nLnx
tkhA98vlIOpTK+TAVGOPZgQSpNuzhQE=
=KLqq
-----END PGP SIGNATURE-----

--ZzjxQEaBfdmP5Whk--
