Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.119.170.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965524;
	b=iOK5gm4vdtuq4rzl5TGnOSwrClOK5NYRi3+LXKlLNEXnrDIfDJh0kVa50VwslyVt9ko1
	 PL4mo19vYYUSOCatzzZm571L/mehz1pl4QdbcBGb/Vx15jPLR4zCKX9rE6isxFasJGJCc
	 IAjEwNAcmL+4XQePHTekcnKUYj5UqGD+ordse7uoFI/geULKpd92cdyGZMF2wQIQnKABm
	 cMg4Bzlz8zb1v5epTrntgaXlh0/OSHLCrUGOOXCSIRnw0kq/AVKPpBdQGZANJtpkavQ40
	 jT/Pem6k3ESpmZdoZaHNe0dFlyhQU4IFnRV8MlVC24vhb35jY29szACoImxypCJ3R2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965524;
	h=DMARC-Filter:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=1RBHY3hPRDk0PqItgt+PMZFbI0zf0aeDwbS6+0ip1AI=;
	b=D7gcqCmeT6kF83Vi30oSlIfogOww1zoKO+uex3aKLYs0ohyAiY9xIqTN6f3UNAr76TPP
	 2pkt8Jt3q1u7sgYkvTIhB12yEBJw9i87/8RpVzlPzO+DKKSQrsjsJ979sumCDmQUbPjx+
	 zhh/xBTIWOn1a3wwge7T7u3kuS4lnT46GpVj9fGgtLiiunjaH8ZTpm01wFJHS+MJ9mWeW
	 8/tpFm+IkQj/+zQALVsaKfbPGPHGV9XMNxnM1Qys6MvTQ5ZQoYN2wOIGr0seF2G8T6RKB
	 rySmMh5tKF6fStAoSAv06BD7U3CKh3d/eqAdON8O2oekyITrSdMPRU1SBEd2pRAF6tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crapouillou.net;
	spf=pass smtp.mailfrom=crapouillou.net;
	arc=none smtp.remote-ip=185.119.170.32
Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9880606A31A;
	Sun, 25 Oct 2026 21:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9880606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Message-ID: <dc62e1711e971504c463bee8760c8144b0df53ac.camel@crapouillou.net>
Subject: Re: [PATCH] dmaengine: dma-jz4780: Fix NULL dereference in
 tx_status after terminate
From: Paul Cercueil <paul@crapouillou.net>
To: Olivier Louvignes <olivier@mgcrea.io>, Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-mips@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 25 Oct 2026 22:58:29 +0100
In-Reply-To: <20261023080953.16963-1-olivier@mgcrea.io>
References: <20261023080953.16963-1-olivier@mgcrea.io>
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

Hi Olivier, Vinod,

Le vendredi 23 octobre 2026 =C3=A0 10:09 +0200, Olivier Louvignes a =C3=A9c=
rit=C2=A0:
> jz4780_dma_terminate_all() sets jzchan->desc to NULL. The cookie of a
> cyclic transfer never completes, so a later jz4780_dma_tx_status()
> call
> with that cookie finds no descriptor on the channel's lists, takes
> the
> else branch and reads jzchan->desc->vdesc.tx.cookie through the NULL
> pointer.
>=20
> The driver has always allowed this, but it only shows once something
> calls tx_status() on a terminated cyclic channel, as
> snd_dmaengine_pcm_sync_stop() does since commit 88e98af9f4b5 ("ALSA:
> pcm_dmaengine: Don't synchronize DMA channel when DMA is paused").
> Closing a playback stream then oopses:
>=20
> =C2=A0 epc : jz4780_dma_tx_status+0x184/0x210
> =C2=A0 Call Trace:
> =C2=A0 [<8048e104>] jz4780_dma_tx_status+0x184/0x210
> =C2=A0 [<805804d8>] snd_dmaengine_pcm_sync_stop+0x4c/0x94
> =C2=A0 [<8058f068>] snd_soc_pcm_component_sync_stop+0x80/0xc0
> =C2=A0 [<805775b8>] do_hw_free+0x20/0x6c
> =C2=A0 [<80577650>] snd_pcm_release_substream+0x4c/0x9c
> =C2=A0 [<805781ac>] snd_pcm_release+0x48/0x9c
>=20
> Only compare the cookie with the current descriptor's when there is
> one.
>=20
> Fixes: d894fc6046fe ("dmaengine: jz4780: add driver for the Ingenic
> JZ4780 DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> Apologies to the stable list: two copies of this patch reached it
> earlier
> today from test sends, with the Cc trailer still in place. Please
> ignore
> those. This is the real submission, and it is the same patch.
>=20
> Seen on an Ingenic X1600 (HiBy R1, compatible "ingenic,x1830-dma" as
> fallback) on v7.3; the code is shared by all the SoCs this driver
> supports. The patch is build-tested on 734bef548a96 (v7.3-7363).
>=20
> =C2=A0drivers/dma/dma-jz4780.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 6070dfdb7114..7f827be502f1 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -658,7 +658,7 @@ static enum dma_status
> jz4780_dma_tx_status(struct dma_chan *chan,
> =C2=A0		/* On the issued list, so hasn't been processed yet
> */
> =C2=A0		residue =3D jz4780_dma_desc_residue(jzchan,
> =C2=A0					to_jz4780_dma_desc(vdesc),
> 0);
> -	} else if (cookie =3D=3D jzchan->desc->vdesc.tx.cookie) {
> +	} else if (jzchan->desc && cookie =3D=3D jzchan->desc-
> >vdesc.tx.cookie) {
> =C2=A0		residue =3D jz4780_dma_desc_residue(jzchan, jzchan-
> >desc,
> =C2=A0					jzchan->curr_hwdesc + 1);
> =C2=A0	}
>=20
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
