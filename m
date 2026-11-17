Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.119.170.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945294;
	b=dKiZx+QQx0kCuAiV+siBD421hrCUG2SeZd/SoD+e8OLl3e3R5CaR2rxoF651e2yUskZ3
	 xrqhXByR7Tndb3Ugou2r5XoSP05r20xnWfMrwwm5dnNDX39OOvUCE2ehR9bdSQPWCj/Pq
	 85qs0gczEEseHS5TAyY3P1tDR/dFVOku9h5qEqTL05Dxb58Wo766byS/QJndOFxdGqc0J
	 3SKHEE8TWyUBv2Tq1KRpk+dMZs6ddsd8f5XREXm59PPZ6XU3sxCYCz5xV82PwAalceoxn
	 CemaF6NJec/OG+6G2Eiz7MwqRw3KDdh5auqInGyrSNP9Y5CPb1fITSTLvycBSlEnr0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945294;
	h=DMARC-Filter:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=R/y6PfyiFJYEdh9afc7R9al5TZFvr9KCoRKFdnoX6S0=;
	b=oC7k/jIdXupiy9dYO+uOtNp5o7bfJXxPy7+FE/sVtQ0qIPVSew/FtfD3Cme6bdOFrgtY
	 ojz8ZCxiZn6HEiLG+l/V8sOagY9Eh0qH9SG2euK5ru3wl9qdYEyq0FLEwvaD+Jzvi0FYh
	 BtLjueZTG5Sy9SFOeaIciZZAUxymQjJWTVVK4fYM2FJb/D5fYyppvA2awjHR06mA54dGI
	 BSXMbfGns9tLoMqj+PE3zpi+XrHFRPTiAsWx4lyIh9c4BWlwkK5s0OPRUj1xLaKOODjcL
	 uOT+9jjWlJZSJcaljjtJL+1SB2beqZTClY/LFnZFMZXyAUAr84WS1j8x/XOr+4QgjRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crapouillou.net;
	spf=pass smtp.mailfrom=crapouillou.net;
	arc=none smtp.remote-ip=185.119.170.32
Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568D5606A332;
	Tue, 17 Nov 2026 19:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 568D5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Message-ID: <93964d456f5c002421df551e412a654eef060ede.camel@crapouillou.net>
Subject: Re: [PATCH v2 10/11] dmaengine: jz4780: Fix descriptor cleanup on
 hwdesc setup failure
From: Paul Cercueil <paul@crapouillou.net>
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>, Frank Li	
 <Frank.Li@kernel.org>, Alex Smith <alex@alex-smith.me.uk>, Colin Ian King	
 <colin.i.king@gmail.com>, linux-mips@vger.kernel.org,
 dmaengine@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Tue, 17 Nov 2026 20:54:45 +0100
In-Reply-To: <20261117163809.622249-11-lee@kernel.org>
References: <20261117163809.622249-1-lee@kernel.org>
	 <20261117163809.622249-11-lee@kernel.org>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Lee,

Le mardi 17 novembre 2026 =C3=A0 16:37 +0000, Lee Jones a =C3=A9crit=C2=A0:
> When jz4780_dma_setup_hwdesc() fails in jz4780_dma_prep_slave_sg() or
> jz4780_dma_prep_dma_cyclic(), the error paths pass &jzchan->desc-
> >vdesc
> to jz4780_dma_desc_free() instead of the newly allocated &desc-
> >vdesc.
> This leaks the newly allocated descriptor and either dereferences
> NULL
> when jzchan->desc is NULL or frees the currently active descriptor
> while
> it is still in flight.=C2=A0 Furthermore, jz4780_dma_desc_free() derives
> jzchan from vdesc->tx.chan, which is not yet initialised before
> vchan_tx_prep() is called.
>=20
> Initialise desc->vdesc.tx.chan in jz4780_dma_desc_alloc() and pass
> &desc->vdesc to jz4780_dma_desc_free() in the preparation error
> paths.
>=20
> Fixes: fc878efe84c3 ("dmaengine: jz4780: fix resource leaks on error
> exit return")
> Closes:
> https://sashiko.dev/#/bug/linux-b39121ef-5ffb-401a-9d04-0afccd467bde
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

(I had added it on your v1 btw)

Cheers,
-Paul

> ---
>=20
> v1 =3D> v2: Correct the Fixes: tag to fc878efe84c3
>=20
> =C2=A0drivers/dma/dma-jz4780.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index ac2094e65ecf..c3974c825ba7 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -248,6 +248,7 @@ jz4780_dma_desc_alloc(struct jz4780_dma_chan
> *jzchan, unsigned int count,
> =C2=A0		return NULL;
> =C2=A0	}
> =C2=A0
> +	desc->vdesc.tx.chan =3D &jzchan->vchan.chan;
> =C2=A0	desc->count =3D count;
> =C2=A0	desc->type =3D type;
> =C2=A0
> @@ -379,7 +380,7 @@ static struct dma_async_tx_descriptor
> *jz4780_dma_prep_slave_sg(
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sg_dma_len(&sgl[i]),
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 direction);
> =C2=A0		if (err < 0) {
> -			jz4780_dma_desc_free(&jzchan->desc->vdesc);
> +			jz4780_dma_desc_free(&desc->vdesc);
> =C2=A0			return NULL;
> =C2=A0		}
> =C2=A0
> @@ -426,7 +427,7 @@ static struct dma_async_tx_descriptor
> *jz4780_dma_prep_dma_cyclic(
> =C2=A0		err =3D jz4780_dma_setup_hwdesc(jzchan, &desc-
> >desc[i], buf_addr,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 period_len,
> direction);
> =C2=A0		if (err < 0) {
> -			jz4780_dma_desc_free(&jzchan->desc->vdesc);
> +			jz4780_dma_desc_free(&desc->vdesc);
> =C2=A0			return NULL;
> =C2=A0		}
> =C2=A0
