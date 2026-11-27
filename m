Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742450;
	b=vpjbFdKGFL2t1VqYF6sULfTFv+iuPsEzoZlbnuyqm6+c6gpa6L4IbT8ov1wHSBetjeC9
	 cu0eR0XJBa9kj1bgZLSBYsJDMgiA8QsoxPZSejRqHM73LvIZueuJ9QQb8/4eigN1iBIDq
	 d1PhHqRKUtKzicrfrokDQkqD073hkullR3zAsxH9q5nvx7pr8NtV73kR3yb7tVOBIX21d
	 4+2S6ca/st606SG0imZHeqEfFKlDSXwA0fzouUOnUp5HB0q0q9HaO4p2Xd63y9m/g2B2H
	 jiHxpI/sMS4YoD+UERQNNgXXcSlM2qtSjCMIAN/c2VussbfyLXl0LV2HIpsZEEEV9oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742450;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=ZkWtZggftKVPD75pE7qH992O4GA1BM/KH+rHMtR/v/4=;
	b=a2HWYDQfPO+J7XELsZQMSKPGmpouGU/w2cx2O9tv+ItO/Fukp9bl7L4RhtU9v5IA+Lw9
	 AEA3WG02gxazDqJ/yHKFSsMk3bo/4J9/laBE2gGZAGaGeUYzOyt4PBIn3368qbdUJszhO
	 z72m1GEbK6+nrxTrYZYHnfldSRDkNqqurMF1Dtwd1wPRBDbTfxjQaluTd5H/PQnVyCcQL
	 gW7c3LqoT2vmPUqG59qkxW/SygWcvbmulNa++Tub9E2tK5uO6Xl6/dsGe5hhCjDj48zv2
	 l5Ek04VZTXvAmzdHBH5a5K0WbeOOcFrZmhc1y1z3xv6yKkdyk6iUJgq7W9m96qxdN+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=pDmYUXwa;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A364606A31C;
	Fri, 27 Nov 2026 01:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A364606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=pDmYUXwa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795742447;
	bh=tX6LqRAArlooF01KeIGBb1isEhnLA2qIUwZwAp4Z8r0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pDmYUXwaQgrLlGBCFPOJkr22c3FkXZfi4AADbywbSSRyIqmc62vMtUzF3dt4p3ecb
	 DZm3SNZmk6IxYpbdZL5UYkiPGoKjsfcWu+wSb1xDi7gPw7YamKsGFbfOctg6F2IMAQ
	 35k2KWZKUJ9+Cykol//GsZ0927KzHPd4orPKvNu5OZczeeEr62bYH2sBnZT7u2PH5X
	 jLQxqvg28N/FgSL0LR5Bs4BBknlJ3fwUWcVFYaf0FSTTrdmJ6p8o2Jqa5z2dpgZSK7
	 rY+NBeC/l3QP5KO79t0T4hLMmpYJ8Tz7kamyMZop7Vztcjv7rMRtjOUy4hd4/UpELE
	 vuAsfT5lG8l8A==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 281DB17E07B5;
	Fri, 27 Nov 2026 02:20:46 +0100 (CET)
Message-ID: <a4263b2fe186675c2d1c9d930480220dfeb85ef3.camel@collabora.com>
Subject: Re: [PATCH v2 9/9] media: chips-media: wave5: Stop FrameBuf Reset
 During Seek
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Thu, 26 Nov 2026 20:20:44 -0500
In-Reply-To: <20261109052853.110-10-jackson.lee@chipsnmedia.com>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
	 <20261109052853.110-10-jackson.lee@chipsnmedia.com>
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
	protocol="application/pgp-signature"; boundary="=-k6TPE6RjIt3sfNJyfuCk"
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

--=-k6TPE6RjIt3sfNJyfuCk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 09 novembre 2026 =C3=A0 14:28 +0900, Jackson.lee a =C3=A9crit=C2=
=A0:
> From: Brandon Brnich <b-brnich@ti.com>
>=20
> A seek drains the capture queue via stop_streaming without stopping the
> m2m_ctx. streamoff_capture checks needs_reallocation which will always
> be true after the first sequence initialization. This will trigger a
> DEC_RESET_FRAMEBUF_INFO which will go through and deallocate all of the
> frame and auxiliary buffers.
>=20
> Video output can have corruption if the firmware is still referencing the
> buffers that just got reset. Clear needs_reallocation in wave5_prepare_fb
> once the new buffers are registered.
>=20
> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index 102c07979d08..57511acbb28b 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -1250,6 +1250,8 @@ static int wave5_prepare_fb(struct vpu_instance *in=
st)
>  =09=09return ret;
>  =09}
> =20
> +=09inst->needs_reallocation =3D false;
> +
>  =09/*
>  =09 * Mark all frame buffers as out of display, to avoid using them befo=
re
>  =09 * the application have them queued.

--=-k6TPE6RjIt3sfNJyfuCk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawja7QAKCRDZQZRRKWBy
9HemAQDJi3lAKW58EB2weMhDqmSsD0L7Cm6WldQQ2mX9VaYYwgEAzXyEgpFxRTIt
BFt19ffWCMXLyN8uVjEhknXpdee8Dw8=
=5Q8g
-----END PGP SIGNATURE-----

--=-k6TPE6RjIt3sfNJyfuCk--
