Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DEA19ADA4;
	Thu, 16 Jul 2026 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168097; cv=none; b=Xmn9bB40qklL7zaCB9RDwhaJknJqw/NWIHNqJZLjENjqi/cVMqlYGmL+DxjnePlhWdeo4nIpzpw66OQdyKYr0GjN8tXzkNcOYuAKRRqY6AgmJXkd+6ENuUicD4Ftc5eDV7N88gUgE9dWvPBFaxXkx1aLR3LvTcDbQijPv3DO/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168097; c=relaxed/simple;
	bh=cQAHxN97ECIu0ZseFMVT+bdB5XZM90+QEDKxfhKQ6P0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BtlknSAK8C8yG7GicVnhtQy4gzGNzBYvQr/T/b51Mun0yaJ5kXy97H7pD8A1L8pOgszV2jOlSIxKvdtIsiSmAtznDSLChcQhBeQLITXKyoGzswA040TKVwybZ8Varxg1eba8Y+V4XITmb7M+jFNYJTDi00MHyOyP2EP7sBLMG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pGaiFEek; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pGaiFEek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784168094;
	bh=cQAHxN97ECIu0ZseFMVT+bdB5XZM90+QEDKxfhKQ6P0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pGaiFEekF2Z9uq/eVrJgikSLvAJ3qqdymhP7DiaFmmuDCGRmES3R/xFyOsMvEPo+w
	 pKlsXOmFwBbT0nbivMalkQ9gmRbGUwu4WQHdk7trAjBL2DBXjdu9BMJmo22UsnpbQS
	 cA07A9jPpgHUYswFPAdQDagSFvUBLSoYFRac74M88xobBdeD8L8YM/lozkoJCya7uC
	 fLLpe/5se5xQdSGQEJTObD5iIx5w6MNjrhayWjZtQP8YndxeQsVq1mAEd9sN9VSSkY
	 HTrcxsEHkUmKoiHrCBagPJCszHId15jhT7cLzu4333PZqxSDpPl9U2x4sC/5V/s28L
	 rNBW6BDK1oubQ==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D011D17E0B89;
	Thu, 16 Jul 2026 04:14:52 +0200 (CEST)
Message-ID: <2ea957e9b2866efeda766453f1b9c83bf6f8ffee.camel@collabora.com>
Subject: Re: [PATCH v1 6/7] media: chips-media: wave5: Fix pipeline stall
 when queuing fails
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Wed, 15 Jul 2026 22:14:51 -0400
In-Reply-To: <20260626012232.111-7-jackson.lee@chipsnmedia.com>
References: <20260626012232.111-1-jackson.lee@chipsnmedia.com>
	 <20260626012232.111-7-jackson.lee@chipsnmedia.com>
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
	protocol="application/pgp-signature"; boundary="=-kXrnMCy/ac5/HMwFNi2u"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-kXrnMCy/ac5/HMwFNi2u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 26 juin 2026 =C3=A0 10:22 +0900, Jackson.lee a =C3=A9crit=C2=A0=
:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
>=20
> The Wave5 decoder calls v4l2_m2m_job_finish() immediately in device_run()
> after submitting frames to firmware. When the firmware completes those
> frames and the queue drains to zero, finish_decode() has no active M2M
> job to finish, so v4l2_m2m_schedule_next_job() is never called and the
> decoder stalls.
>=20
> Call v4l2_m2m_try_schedule() in finish_decode() when the firmware queue
> empties to ensure the framework always schedules the next device_run().
>=20
> Fixes: a176ac5e701f ("media: chips-media: wave5: Improve performance of d=
ecoder")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index f33c00cb801b..1817b83c5884 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -475,7 +475,10 @@ static void wave5_vpu_dec_finish_decode(struct vpu_i=
nstance *inst)
> =C2=A0			v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
> =C2=A0	}
> =C2=A0
> -	inst->queuing_fail =3D false;
> +	if (inst->queuing_fail) {
> +		inst->queuing_fail =3D false;
> +		v4l2_m2m_try_schedule(m2m_ctx);
> +	}
> =C2=A0}
> =C2=A0
> =C2=A0static int wave5_vpu_dec_querycap(struct file *file, void *fh, stru=
ct v4l2_capability *cap)

--=-kXrnMCy/ac5/HMwFNi2u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalg+mwAKCRDZQZRRKWBy
9PBSAQDNA5qz/xkLlR8vPywzfN99OpDkKMAq22haZvgkddCLzQD/S/I/iryGM8mn
AaAb8wwemG3KoXvZQtzBYE7vXIrZLgU=
=mm2D
-----END PGP SIGNATURE-----

--=-kXrnMCy/ac5/HMwFNi2u--
