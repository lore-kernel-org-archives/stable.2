Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6840097D;
	Fri, 17 Jul 2026 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298721; cv=none; b=rTn6QxKHIU6xBG8DEPkSpUr9FgxgcSpuiTbZf/Vu8+RMUb1VU0DOyBwaWYJnUB0EsHALQrOYkF/C2jhr6CbvGuNnD5E4xGaNyAjqyuo1Cu6DDaxbGN1eGMmMgFtjnW6is8dwRuDwhNTbHetvIaOwBaIBlTe1Nqz1QEXyVvKMXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298721; c=relaxed/simple;
	bh=c0SDOQ15nRyXj8rLOqoDsDZP84RsTgp7QGlThjQu/3I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AwJ9siNSeuMhxpmv+AGmCo/k7+tn8c5fgkm1fzRH0sR7Ei9igmcZAlQcPzy8aoF9zeSq9Ml3tqRK3PAr8g3vLUNuCKtQOG3IbwX5CIPw53Hu9Nu77HcjbS1hQYRgd2FtQZrr4eGNO/1wtss7lEax35970rHICD0uY2JU44jY0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pb7Wkl1O; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pb7Wkl1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784298712;
	bh=c0SDOQ15nRyXj8rLOqoDsDZP84RsTgp7QGlThjQu/3I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pb7Wkl1Oe1LW55745pa/+Y0p+12T4XczXXj6ws7qYt/Lq0lDrQ3RkHKPh/ie7R1eO
	 BwOTuuCf8Rv3SzkLwUZXiVcTVAprAMkLtnlKu5+Emu526Z9Nxju8/MBKcqWR/AXg3K
	 7abTMDD2SGAJ5IHFqRCuO8Rq0xhR+rqlAux9J4hIO6l7TdB92c+X60aCn5kdqtTaLs
	 aKelK1/Ww4hBP9hfwKkEyMgThHcSoUww/EHt0nvoe9y3cY5+WR/LxP7k5Xviv4pSg3
	 oQZVCSZwZ2ByhSLYrY4FhBmoDj2E8ckU4e+DUioDR0BahkvqcHQZ3taHOfGX0vZu8/
	 F9pRmNYPl42Qw==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 739F917E010F;
	Fri, 17 Jul 2026 16:31:51 +0200 (CEST)
Message-ID: <7bd147f9472fa3093bc958843d7dbed51251b456.camel@collabora.com>
Subject: Re: [PATCH] media: chips-media: wave5: Handle polling IRQ thread
 failure
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Linmao Li <lilinmao@kylinos.cn>, Nas Chung <nas.chung@chipsnmedia.com>, 
 Jackson Lee <jackson.lee@chipsnmedia.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
	 <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 17 Jul 2026 10:31:49 -0400
In-Reply-To: <20260717071315.1485454-1-lilinmao@kylinos.cn>
References: <20260717071315.1485454-1-lilinmao@kylinos.cn>
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
	protocol="application/pgp-signature"; boundary="=-Ehf1BOs+FlJ9LBiRwIAc"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Ehf1BOs+FlJ9LBiRwIAc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 17 juillet 2026 =C3=A0 15:13 +0800, Linmao Li a =C3=A9crit=C2=
=A0:
> When falling back to polling mode, wave5_vpu_probe() does not check the
> return value of kthread_run().=C2=A0 On failure, dev->irq_thread holds an
> error pointer instead of a valid task pointer.
>=20
> Both the probe error path and the remove path only check
> dev->irq_thread against NULL before calling kthread_stop() on it, so an
> error pointer passes the check and kthread_stop() crashes on it.
>=20
> Check the kthread_run() result, clear dev->irq_thread and unwind the
> probe on failure.
>=20
> Fixes: e66ff2b08e4e ("media: chips-media: wave5: Fix Null reference while
> testing fluster")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
> =C2=A0drivers/media/platform/chips-media/wave5/wave5-vpu.c | 7 +++++++
> =C2=A01 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> index 76d57c6b636a..37df270b5f99 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> @@ -340,6 +340,13 @@ static int wave5_vpu_probe(struct platform_device *p=
dev)
> =C2=A0		dev_err(&pdev->dev, "failed to get irq resource, falling back
> to polling\n");
> =C2=A0		sema_init(&dev->irq_sem, 1);
> =C2=A0		dev->irq_thread =3D kthread_run(irq_thread, dev, "irq thread");
> +		if (IS_ERR(dev->irq_thread)) {
> +			ret =3D PTR_ERR(dev->irq_thread);
> +			dev_err(&pdev->dev, "failed to create irq thread\n");
> +			dev->irq_thread =3D NULL;
> +			goto err_vdi_release;
> +		}
> +
> =C2=A0		hrtimer_setup(&dev->hrtimer, &wave5_vpu_timer_callback,
> CLOCK_MONOTONIC,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HRTIMER_MODE_REL_PINNED);
> =C2=A0		dev->worker =3D kthread_run_worker(0, "vpu_irq_thread");

Looks fine to me.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

--=-Ehf1BOs+FlJ9LBiRwIAc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalo81QAKCRDZQZRRKWBy
9NmLAP9ql7QYEto+/cHOxwgRAIkk38xuT1hojtzuqZ0vCSkgCQD/W1bUXpkLuK+V
Dk3sJkvSNANSTIGBBdqQGxnV7REXcAI=
=hLGq
-----END PGP SIGNATURE-----

--=-Ehf1BOs+FlJ9LBiRwIAc--
