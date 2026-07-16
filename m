Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67D2D2385;
	Thu, 16 Jul 2026 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167238; cv=none; b=trQA+BixGLL1JDUZwaun49Zu04TXlivDHhleNogu/sVcaevpUfiEBsk6bSd2UgKIJD8jOVb5SeUM8Cn2tv+ZBnsXczhFOG0FL/LaSTqE94hI3QQDHYPBtj+sgd+ZcnjAaWJOa6jpjYjMP/mVZeE5x/E06FX8toC2gnJ6pTpMMt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167238; c=relaxed/simple;
	bh=Un/5Doi0TMlV2/uQIAjUjjB8FNMdi0rVyw1JWKpX3Eo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pWRvELhTnp+eCj3TrEOUkm0DWuV8iOge89S+2yaO3R91Xgs6rMGvbu85l42CPPcJQbjMUvniYBTNZFK33awXpTWyUyk0Mxt2e3eGbcIoo4SDIx8Jt3OajA2tPaPPyM3dpVu0q2TeOdT+I4X4NeuO5Hw86sIF1u+pLR3Zu/Qwlqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f2qZEMj+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f2qZEMj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784167235;
	bh=Un/5Doi0TMlV2/uQIAjUjjB8FNMdi0rVyw1JWKpX3Eo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=f2qZEMj+eVPB/stP1/+8ZrSp7z8S0jKFNzYPQVhyrbFYXLVV24p4CeHDXfc4RJiCa
	 bH0T9LV6BARBma80uBC9xdhKxDJlNrKfEA4ska/rvJ0o54Bl5FFAcyZ6uJC1QtCBb7
	 xWYQhELzurlgKrOJzbfY2ZeiLPy+vrNmh1MBtFZI5YhAWCYZiLNKCgFF7XsPa+gLh/
	 KTMCAc4eO/fz6TGnIrD5u9MoItD7X5yBAeQLFS9IY75YlpXvwDZzL1ADB5WA1UP4aa
	 FJzUvit8i4I6wx9B0d4tnkrauh2FT36A8Mevpe7OT4lvXbCqIDtLUICj364Sp/73bw
	 JP7Gyy2AK0Qfg==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1F97217E0B89;
	Thu, 16 Jul 2026 04:00:34 +0200 (CEST)
Message-ID: <30f5dbdf3cb01890ea25c4fb8d1ca6c8069a72d5.camel@collabora.com>
Subject: Re: [PATCH v1 3/7] media: chips-media: wave5: avoid skipping
 device_run while VPU has work
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Wed, 15 Jul 2026 22:00:33 -0400
In-Reply-To: <20260626012232.111-4-jackson.lee@chipsnmedia.com>
References: <20260626012232.111-1-jackson.lee@chipsnmedia.com>
	 <20260626012232.111-4-jackson.lee@chipsnmedia.com>
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
	protocol="application/pgp-signature"; boundary="=-30yVn2uhIc5+fOm/kwPA"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-30yVn2uhIc5+fOm/kwPA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 26 juin 2026 =C3=A0 10:22 +0900, Jackson.lee a =C3=A9crit=C2=A0=
:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
>=20
> The decoder stalls because empty_queue is set to true even when the
> m2m context still has pending commands. As a result, device_run is
> never invoked, the m2m source queue fills up, and userspace (e.g.
> Chromium) can no longer queue new bitstream buffers to the V4L2
> driver.
>=20
> Fix this by querying the VPU queue status via DEC_GET_QUEUE_STATUS
> before deciding whether to skip device_run. Only skip when the
> VPU's instance_queue_count equals the number of ready source
> buffers in the v4l2-m2m context, which indicates that there is
> genuinely no new work to perform. Otherwise, proceed with issuing
> a decode command so that the VPU can continue draining its internal
> queue.
>=20
> Fixes: a176ac5e701f ("media: chips-media: wave5: Improve performance of d=
ecoder")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0.../media/platform/chips-media/wave5/wave5-vpu-dec.c=C2=A0=C2=A0 | =
10 +++++++---
> =C2=A01 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index 01d1368b2965..6c6e86b09b40 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -1663,9 +1663,13 @@ static void wave5_vpu_dec_device_run(void *priv)
> =C2=A0		} else if (!inst->eos &&
> =C2=A0				inst->queuing_num =3D=3D 0 &&
> =C2=A0				inst->state =3D=3D VPU_INST_STATE_PIC_RUN) {
> -			dev_dbg(inst->dev->dev, "%s: no bitstream for feeding, so skip ", __f=
unc__);
> -			inst->empty_queue =3D true;
> -			goto finish_job_and_return;
> +			wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status);
> +			if (q_status.instance_queue_count =3D=3D v4l2_m2m_num_src_bufs_ready(=
m2m_ctx)) {
> +				dev_dbg(inst->dev->dev, "%s: no bitstream, skip\n",
> +					__func__);
> +				inst->empty_queue =3D true;
> +				goto finish_job_and_return;
> +			}
> =C2=A0		}
> =C2=A0	}
> =C2=A0

--=-30yVn2uhIc5+fOm/kwPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalg7QQAKCRDZQZRRKWBy
9IBkAP9HlFW4w1psp9pCmTASdd5I7obkb5Fm4O8zHqU4MtwIAwD8CmgOFzeiU6Yh
S5lV7GD6RP1Grnp/zIXReo65yOkOWQ4=
=U4P4
-----END PGP SIGNATURE-----

--=-30yVn2uhIc5+fOm/kwPA--
