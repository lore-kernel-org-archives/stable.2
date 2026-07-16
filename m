Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEBD43F085;
	Thu, 16 Jul 2026 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167017; cv=none; b=JkQx6R0DPnno3BOxOlXtGCjJf2jrvIPJoskREIKBvg4O+18VijquQyAqbQ1cwvoyChCRmn05EtM3/84YKsWsL/zeNdZo7tO9RMvWO9nU1dLwBkzoX/aeHHD95Y3j0Qxww3r5XLQpf5z2kgSC8BVuRe3a6NVewoTeXR9NsxCeDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167017; c=relaxed/simple;
	bh=AwRBoYYatv5O9WhhNssDrfQS4DnFWiBdQv//4Bd82qo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U6woLO/95B0fZ+zjmHs3y5fwkz0W2ENZJDJWbEZhmk4Q1Xm1jiTcyopCKZlBHWyS8G/qgZ9HSk68JnW78MBPX0OvFlU4OXW4B1C7whmAXYIKzoh+nbVvE9Aq56+umYh5CgK/mWgtUy6CzMAUZ91rAh6coa7zlOuatzzS7qW8DXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hHWY92Bm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hHWY92Bm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784167014;
	bh=AwRBoYYatv5O9WhhNssDrfQS4DnFWiBdQv//4Bd82qo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hHWY92BmfDj9VVCdsev8ePLGSDZ4aCtS+sSl1NdC2ykRICVVP+d8rffqI3gQeKQwK
	 f7NoK0zy9GD7MuTsMWXLPx/4I8rgKrfdSgfoVz2IL+6ReXdd8fOgjPVaplDMMWlSox
	 OUdNV16ZbNTFtY9isEi4hT6eF0HPUER6m66litt8mRCfnmUamJwYeMEZldwgb20cmM
	 blIzH1mZ5Cq7Regwdnm6GVP5CH64leKbEM26jVljO9XK7BQ3E+BiTp0i9HPbxPw6lB
	 SIwH/1R1x/bv+8+fQVd5uembqEBqmzoEHgjv+etCNQMcNh+7U2u794cI72AZa5sWuw
	 5q2XQcS+hbfRA==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0839017E0857;
	Thu, 16 Jul 2026 03:56:52 +0200 (CEST)
Message-ID: <6ac658ba5f73ca731b7eb27de912a78165a41faa.camel@collabora.com>
Subject: Re: [PATCH v1 1/7] media: chips-media: wave5: Guard bit depth check
 with initial_info_obtained
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Wed, 15 Jul 2026 21:56:51 -0400
In-Reply-To: <20260626012232.111-2-jackson.lee@chipsnmedia.com>
References: <20260626012232.111-1-jackson.lee@chipsnmedia.com>
	 <20260626012232.111-2-jackson.lee@chipsnmedia.com>
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
	protocol="application/pgp-signature"; boundary="=-LEAUk2qvo4uiiI7n5aQd"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-LEAUk2qvo4uiiI7n5aQd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 26 juin 2026 =C3=A0 10:22 +0900, Jackson.lee a =C3=A9crit=C2=A0=
:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
>=20
> When CAPTURE STREAMON is called before the VPU has completed sequence
> initialization (initial_info_obtained =3D=3D false), the initial_info fie=
lds
> contain uninitialized data. The driver checks
> luma_bitdepth and rejects anything other than 8-bit, so garbage values
> (e.g. 15) cause STREAMON to fail spuriously.
>=20
> This is reproducible with the following multi-threaded test scenario:
> =C2=A0 1. Allocate 2 CAPTURE buffers.
> =C2=A0 2. Call STREAMON on the CAPTURE queue.
> =C2=A0 3. Call DQBUF, which blocks waiting for a decoded frame.
> =C2=A0 4. A second thread calls STREAMOFF on the CAPTURE queue.
> =C2=A0 5. The blocked DQBUF should be released, allowing graceful termina=
tion.
>=20
> At step 2, STREAMON reads uninitialized luma_bitdepth and rejects the
> stream, causing the test to fail.
>=20
> Fix this by checking initial_info_obtained before accessing the bit
> depth fields, so the validation is only performed when the sequence
> info has actually been parsed by the VPU.
>=20
> Fixes: 035371c9e509 ("media: chips-media: wave5: Fix timeout while testin=
g 10bit hevc fluster")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index bb2ba9204a83..01d1368b2965 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -1403,6 +1403,7 @@ static int wave5_vpu_dec_start_streaming(struct vb2=
_queue *q, unsigned int count
> =C2=A0	} else if (q->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
> =C2=A0		struct dec_initial_info *initial_info =3D
> =C2=A0			&inst->codec_info->dec_info.initial_info;
> +		struct dec_info *p_dec_info =3D &inst->codec_info->dec_info;
> =C2=A0
> =C2=A0		if (inst->state =3D=3D VPU_INST_STATE_STOP)
> =C2=A0			ret =3D switch_state(inst, VPU_INST_STATE_INIT_SEQ);
> @@ -1410,6 +1411,7 @@ static int wave5_vpu_dec_start_streaming(struct vb2=
_queue *q, unsigned int count
> =C2=A0			goto return_buffers;
> =C2=A0
> =C2=A0		if (inst->state =3D=3D VPU_INST_STATE_INIT_SEQ &&
> +		=C2=A0=C2=A0=C2=A0 p_dec_info->initial_info_obtained &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 inst->dev->product_code =3D=3D WAVE521C_CODE) =
{
> =C2=A0			if (initial_info->luma_bitdepth !=3D 8) {
> =C2=A0				dev_info(inst->dev->dev, "%s: no support for %d bit depth",
> @@ -1418,7 +1420,6 @@ static int wave5_vpu_dec_start_streaming(struct vb2=
_queue *q, unsigned int count
> =C2=A0				goto return_buffers;
> =C2=A0			}
> =C2=A0		}
> -
> =C2=A0	}
> =C2=A0	pm_runtime_put_autosuspend(inst->dev->dev);
> =C2=A0	return ret;

--=-LEAUk2qvo4uiiI7n5aQd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalg6ZAAKCRDZQZRRKWBy
9KhUAP419pGgndQFNJfJcyYRYQNfotkT/NYc5v8aEvqCtUmElwD+Pz7Zv2FGOipw
jv71rXBSk+e4PzCU+kpdL41FCpiQaAI=
=IsnI
-----END PGP SIGNATURE-----

--=-LEAUk2qvo4uiiI7n5aQd--
