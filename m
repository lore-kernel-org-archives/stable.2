Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106996;
	b=04BhT2N22EYinbGY+FG2AZFl1eo5kB53QauABeStpSj0yMiL01/+LDvw0qXc+rL7mkHT
	 od4HkCV1Zz6OUxFQ3dOaDnFlp7kigIeJr3vbYpHx9XR5DJJ3Zrl6yMfetQ2nhfup5XDD5
	 /u8+A0uEVD3Fdfg/1F2XEX0o2SGFgl7iAGH5hqn+x87Giapa28QX4yXGkaj9qvffCiSIA
	 sbLchvGoiG10DqevftZ01CLXjuPQYZSHAUy4OvcnxQAs5WzBX8SVNG59J1HkLJFs6pERH
	 Vdpypjxjg6Yn9br0Uod9YQScrYD7A4z/JgP+a7l5EEcKQpOVleOdG/wXPaBDcDf6a5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106996;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hkL6LCpwsy5aui12YKRbGKekStF7qkr49f4TEB6Q6ko=;
	b=V3GXLKIfbsTGK5r6mpK0hULzEDaS0o/D0QqgJQLpGd2XrRK1+VoYHbAjXhwhAGeew/Qw
	 pN4Gwve3qmAC3M8Fa+xnQUw32hpmjpvjlW1EE61cJkzX1vBA1czRp89Ded5y3IQYRaD26
	 oXwXNDFgmuzlPULb8yMF7uhJ11n+1xUHYHdVsa0zdALMLZ530SZR9URFKsFmA1vb1V0Ev
	 K/Ewd5ha01EdJjOpB6GuoDPDokPiafvPF/W/OtrgCLgmxMBUmIret/6QAorBrCBbFp+mU
	 oBck3xbLmNszAfXvUuH5w9WQI6iSaeogT4KwsavbJUkE8RLTFthRTLL8Dgx4S4Z6gcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mavax59V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2160A2625;
	Thu, 19 Nov 2026 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mavax59V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7B41F000C7;
	Thu, 19 Nov 2026 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106995;
	bh=hkL6LCpwsy5aui12YKRbGKekStF7qkr49f4TEB6Q6ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mavax59Vne56Zps4+bvprTLE46rKCX62u98fBxOxfLfnO0nahuq5QaI6aykEWgaKK
	 ykigUTOYJqPhcEZh2Zr4PJB6JWz3uKvpsXYREBCtHfuc2+9QMbK4nL6cGklNffbIo2
	 KBFMU63s1N4169vgRGr1tZ1MuFFGHVtXNZvZB15ILEDLokYffguf35OryUYXEeZrLj
	 FUjbMo4G5OBFHAijoBPrXjCx2jM/YerFjtY63m4j6bAObmOWXZ4RCEYpguatDboyRt
	 VAmhoYOyZf0j4IZMKee7Tt9wEkw+hUVJEixuBaLBasLz8RElAe+OUoOOLQfMTD76Rl
	 Ui3wUdwuWIgnQ==
Date: Thu, 19 Nov 2026 17:49:53 +0100
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
Message-ID: <av8osemFMD6C2EdK@lore-qca>
References: <20261119124928.1398520-1-maoyixie.tju@gmail.com>
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
	protocol="application/pgp-signature"; boundary="J99XZwWZUsYwxxM/"
Content-Disposition: inline
In-Reply-To: <20261119124928.1398520-1-maoyixie.tju@gmail.com>

--J99XZwWZUsYwxxM/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> mt76s_rx_run_queue() reads the packets that the chip announced in the
> interrupt status into one buffer. It then takes the length of each
> packet from the first word of the packet and does not compare it with
> the bytes read. A larger length can make the driver read TX status
> records past the end of the buffer and build an skb that extends past
> it.
>=20
> Stop at a packet that does not fit in the bytes read.
>=20
> Found with a CodeQL-based static analysis tool that we are developing.
> Reproduced in a userspace harness under ASan, which reports no such
> read with this patch. Not tested on hardware, only compile-tested with
> W=3D1 on next-20261116.
>=20
> Fixes: dacf0acfe2ce ("mt76: sdio: extend sdio module to support CONNAC2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
> I used an LLM to help write the harness and this patch.
>=20
>  drivers/net/wireless/mediatek/mt76/sdio_txrx.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net=
/wireless/mediatek/mt76/sdio_txrx.c
> index 3f314e8e1e69f92..86dd1165d2c7f1f 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> @@ -127,6 +127,8 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rx=
q_id qid,
> =20
>  		/* parse rxd to get the actual packet length */
>  		len =3D le32_get_bits(rxd[0], GENMASK(15, 0));
> +		if (len > end - buf)
> +			break;
> =20
>  		/* Optimized path for TXS */
>  		if (!dev->drv->rx_check || dev->drv->rx_check(dev, buf, len)) {
>=20
> base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
> --=20
> 2.34.1
>=20

I do not think this patch is correct since we actually consume just len -
MT_SKB_HEAD_LEN bytes at most, right? I guess we should add something simil=
ar
to the patch below, what do you think?

Regards,
Lorenzo

diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/w=
ireless/mediatek/mt76/sdio_txrx.c
index 3f314e8e1e69..4f01d239e0ac 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -62,6 +62,9 @@ mt76s_build_rx_skb(void *data, int data_len, int buf_len)
 	int len =3D min_t(int, data_len, MT_SKB_HEAD_LEN);
 	struct sk_buff *skb;
=20
+	if (data_len > len && data_len - len > buf_len)
+		return NULL;
+
 	skb =3D alloc_skb(len, GFP_KERNEL);
 	if (!skb)
 		return NULL;

--J99XZwWZUsYwxxM/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCav8osQAKCRA6cBh0uS2t
rF6mAP9G+ttPFkNFhkiPa7VBvasY41dns0pz/vyoWO+cyHp5fwEAij8Ipf+yBgyX
v0TxuSeQI9EqJUr3hFvIkzgWGVL+YwI=
=SZYg
-----END PGP SIGNATURE-----

--J99XZwWZUsYwxxM/--
