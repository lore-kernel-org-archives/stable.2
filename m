Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.119.170.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932775;
	b=dEvt/KqFyGGfKew+pA5YJ0e1pWJbDmerxurHXI4cy5ObCykY+7N/Fu6m2/NJsjllt3sk
	 +JmDAbbM//m7h3FXFhZKljvfA//FSKGeCgUHWUprW3UfzHgQs0dFv5bWCRH4Muv4rmoT3
	 +c8tfqlRyajfsZoUXVschj6qbNetCahZvCJwCm6xLAEWdunudpyZ4qxOQm4//WWoTzdTH
	 2FO4LuEKTMtFZOLYlwbyg4W4V9Jl8K3+x9l3RWHVmOq+CN1JfeVuEzGDyig+zPfn6gdrh
	 vnziJV1NjxhYftdkJvSFWEM4MY9dXy1XyyjUaxR3MhVaKialzEP0R/5NP08mPeJX8YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932775;
	h=DMARC-Filter:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=a4gjRdu3o+vVl5H2q8lXRC3wVpAmReSzbcYychrcUo8=;
	b=n5z/y0ipaHvTXFLFoXT1mEdA2veKh+0YMkBQpARtJSw9rgvfuzj6MhS8Ligk+ZrWw6fq
	 SVAmPfl+RP8jCYsSQBgR6ZBRlzv7NLam+AnoHoWaGRyvVyU7ohB818f2C9jvXRDAFcfqc
	 Ub3Q+XjRl70eNYNPfVCdLVFz6Ksob6MoQTcYMnMWKmevpvBXzqYvy6BzneyOXtR28sC9G
	 Dio17Osygp+kN5MvhqB77d1WKrJ0ha6nndmRuS2Z0VrWubsYBY5xg6D7E+fP1sDJAX73U
	 ZVIuOpT7t4xgUWDlGIlzTNeQnn5er7uHiXdw9KkWIbsgO/GPHvPjjuTcDJeQJxNwnXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crapouillou.net;
	spf=pass smtp.mailfrom=crapouillou.net;
	arc=none smtp.remote-ip=185.119.170.32
Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A881606A31C;
	Tue, 17 Nov 2026 16:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A881606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Message-ID: <c9f9b41ff36254ce0dd968ed190e265b1d2eb906.camel@crapouillou.net>
Subject: Re: [PATCH 09/10] dmaengine: jz4780: Fix descriptor cleanup on
 hwdesc setup failure
From: Paul Cercueil <paul@crapouillou.net>
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>, Frank Li	
 <Frank.Li@kernel.org>, Alex Smith <alex@alex-smith.me.uk>, Zubair Lutfullah
 Kakakhel <Zubair.Kakakhel@imgtec.com>, linux-mips@vger.kernel.org,
 dmaengine@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Tue, 17 Nov 2026 17:26:01 +0100
In-Reply-To: <20261111215349.1983909-10-lee@kernel.org>
References: <20261111215349.1983909-1-lee@kernel.org>
	 <20261111215349.1983909-10-lee@kernel.org>
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

Le mercredi 11 novembre 2026 =C3=A0 21:52 +0000, Lee Jones a =C3=A9crit=C2=
=A0:
> When jz4780_dma_setup_hwdesc() fails in jz4780_dma_prep_slave_sg() or
> jz4780_dma_prep_dma_cyclic(), the error paths pass &jzchan->desc->vdesc
> to jz4780_dma_desc_free() instead of the newly allocated &desc->vdesc.
> This leaks the newly allocated descriptor and either dereferences NULL
> when jzchan->desc is NULL or frees the currently active descriptor while
> it is still in flight.=C2=A0 Furthermore, jz4780_dma_desc_free() derives
> jzchan from vdesc->tx.chan, which is not yet initialised before
> vchan_tx_prep() is called.
>=20
> Initialise desc->vdesc.tx.chan in jz4780_dma_desc_alloc() and pass
> &desc->vdesc to jz4780_dma_desc_free() in the preparation error paths.
>=20
> Fixes: d894fc6046fe ("dmaengine: jz4780: add driver for the Ingenic JZ478=
0 DMA
> controller")
> Closes: https://sashiko.dev/#/bug/linux-b39121ef-5ffb-401a-9d04-0afccd467=
bde
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0drivers/dma/dma-jz4780.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index ac2094e65ecf..c3974c825ba7 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -248,6 +248,7 @@ jz4780_dma_desc_alloc(struct jz4780_dma_chan *jzchan,
> unsigned int count,
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
> =C2=A0		err =3D jz4780_dma_setup_hwdesc(jzchan, &desc->desc[i],
> buf_addr,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 period_len, direction);
> =C2=A0		if (err < 0) {
> -			jz4780_dma_desc_free(&jzchan->desc->vdesc);
> +			jz4780_dma_desc_free(&desc->vdesc);
> =C2=A0			return NULL;
> =C2=A0		}
> =C2=A0
