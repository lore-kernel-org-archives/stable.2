Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113379;
	b=EoJxc2eU+/8k0l9NKhgdgEJ1tbjFcIMcE5QsSNla33M5xCuNiNmetQrRVy5JjzEBqVte
	 qZGOs2j7ln3bOC638hhS6ICXKvnLw+DTHTyXACKQ5pd77QIBJbP7gKDz8AwbHh/K/p39S
	 Se2YNQx9uQU79f1LSHQhUayDXyHYtwlJE2kF8nNJh5zKG13B240SBNCIxH65dTw0ucMaf
	 0hjsXmCsQ3usUtIqvkK1jJ2Vs5QDdpbzAhiiktjvIxiMrlh2NdKnlljB4jzDGDtit5nW0
	 8jH0VjGilO7gqTqbW9Sai6kR4zo6G0Ij6uwKPjnAL+Weudy8GRKorwlMrlHLD2PPQNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113379;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=FULaFNtrULKtjyIOf20Z7zfzpc6DhShhuKKqg8qTcek=;
	b=49T7LU+4YS8aXZL0w538dmMFcay7zsrY7bs/vGG/+GsHpvtvKpkIPzs248x+WaGvjhvC
	 2P5H1O8u0uPExmU3p9KSkRqblrzCI9dB9rhDphlnsYcnkSnj06xOTPyLqCymx1NkgBOap
	 cCzwt+dJ+FjxsoDKk6YeFyuY+z1x1r9KpULcOlSqQj+a3ItjAGQogFswX//P16ykveHXu
	 ifPDRcaQHd6xqtvAaqftoj3MMkpmGFcJZR5Uj9QrcdH1dfwfw9tgYSNa++2+o9PfAQmlz
	 jjGeZ8HWqtn4V40qmpy2HO98wDYbqSB+UMBLvY+Bx+ccA+0FOsv+/YtCCTJvh9goNLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GXRzv2vi;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884CB606A330;
	Thu, 19 Nov 2026 18:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 884CB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GXRzv2vi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795113377;
	bh=T0pI6QoapOdjZGBfMviw/VjaDgMcZ0ZLY/0s1FdOCz8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GXRzv2viFAwjbxAOLNWsmzavPED2g8LFVjMa9FNCzMdEvFnpd3cKQ9/5N8zyBbawb
	 Nv41WlfmgXmmK2Zy463yIHU61hlVhYDD2Gh7s1zJMaTy7yptllR3ZLdXBoQY0kPB12
	 wyy0zhnZbPbwWPNPOrMx7/f2v8XrmMJnGOdxavlaiCKqA2A9LnQ8b2gr2uZS1IYpvr
	 c3OTki0lGjdRRvmf5EDZG/7yKk5DMZUfpPFjibZ/4JjcHjeVWINHe80wLZg/Oiz76e
	 dXn9TI1KBZ4aq/AhnoCaw+m9Zx+rdGlisChHzBLbFy0mKqSDQDys3pDijm3O6GQFj6
	 jj2wTnmIurvMQ==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 85D3317E0406;
	Thu, 19 Nov 2026 19:36:14 +0100 (CET)
Message-ID: <5ff0d8de9df06706f3c5412b642e150d5f068851.camel@collabora.com>
Subject: Re: [PATCH 2/3] media: verisilicon: hantro: cancel watchdog work
 before m2m release
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Shengzhuo Wei <me@cherr.cc>, Mirela Rabulea <mirela.rabulea@nxp.com>, 
 Mauro Carvalho Chehab	 <mchehab@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer	 <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>, Hans Verkuil
 <hverkuil@kernel.org>, Ming Qian <ming.qian@nxp.com>,  Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Ezequiel Garcia	 <ezequiel@vanguardiasur.com.ar>, Bin Liu
 <bin.liu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno	 <angelogioacchino.delregno@collabora.com>, irui
 wang <irui.wang@mediatek.com>,  kyrie wu <kyrie.wu@mediatek.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Date: Thu, 19 Nov 2026 13:36:13 -0500
In-Reply-To: <20260825-media-timeout-work-v1-2-ebfebbeb6c31@cherr.cc>
References: <20260825-media-timeout-work-v1-0-ebfebbeb6c31@cherr.cc>
	 <20260825-media-timeout-work-v1-2-ebfebbeb6c31@cherr.cc>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-1wAt75ie9F4gKgzfOH9h"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

--=-1wAt75ie9F4gKgzfOH9h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 25 ao=C3=BBt 2026 =C3=A0 03:34 +0800, Shengzhuo Wei a =C3=A9crit=
=C2=A0:
> Each job arms vpu->watchdog_work, cancelled only by the
> job-completion path. If a job stalls, hantro_remove() drops the last
> reference to vpu->m2m_dev via v4l2_m2m_put() with the watchdog still
> pending, and hantro_watchdog() then dereferences the freed m2m_dev --
> a use-after-free.
>=20
> Drain the watchdog before the m2m device is released.
>=20
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> Assisted-by: GLM:5.3
> ---
>  drivers/media/platform/verisilicon/hantro_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index 2e81877f640fb429b18d2f4fd64bc0c392cf600e..1b04b98371a48184f390a1379=
1243fd00d6b80ef 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -1284,6 +1284,7 @@ static void hantro_remove(struct platform_device *p=
dev)
>  =09hantro_remove_dec_func(vpu);
>  =09hantro_remove_enc_func(vpu);
>  =09media_device_cleanup(&vpu->mdev);
> +=09cancel_delayed_work_sync(&vpu->watchdog_work);

Same comment as for mediatek driver.

Nicolas

>  =09v4l2_m2m_put(vpu->m2m_dev);
>  =09v4l2_device_unregister(&vpu->v4l2_dev);
>  =09clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);

--=-1wAt75ie9F4gKgzfOH9h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCav9BnQAKCRDZQZRRKWBy
9GSlAP9EsaWLG8JyqO/cX436Nctw6ISzDKmkLD6Z0tjeBm29fgEAtpOfRfVkBMCN
IJuqlSJQ3i9bJ1WiaUzaUfiM4xTi3As=
=N4qZ
-----END PGP SIGNATURE-----

--=-1wAt75ie9F4gKgzfOH9h--
