Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9FC48CFC;
	Wed, 15 Jul 2026 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784155527; cv=none; b=G4S2717Xu+bVtIqeDWvm5JRa/U/SQtc0Al+d6TGOnZgNS/RR+27r+BoAefLUS0tVCd6PXmmTsDHI5iDJO6FtljsPSRayRwN8UOC6ipE2NCYqwyqQ5l8H7dRIMWJJAOSrr7Kuo9OSJx38/L2DfTi90tFDGD2aukrPoceRjRSvB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784155527; c=relaxed/simple;
	bh=26FjX/e7xnbplCk23y9PjT+woZZKEcAuRBoakCUskuA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rO9aNcJ9TvwQmqmYgZWARB09GU3Ljp98pKyK2quOOPeaMTBV2U6FO2FmJW038aj1TNRaonGvpXrIF3pScKWcOc36IpbNzmpcrCTzF+aKW7Z++cuWQaza+Tx+RGWRvFdYo3uHw4oEnBx+QalJF7kBvhbXsU5HgUQrLqRf7/GfGLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U66iHuho; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U66iHuho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784155523;
	bh=26FjX/e7xnbplCk23y9PjT+woZZKEcAuRBoakCUskuA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U66iHuhoUjmJcChJLk3hwHFQw9zRgTFq+K7FGRAP8Dxb77tznedEUb2SjEXqj9c4p
	 LDXBZqKaGjkAwEDjYOXP0c2QP6UNgT0xVtaWxwDWwyQQpdR/qTtNPmq7QvOi3swmlM
	 ZOHUwoq/CIC0V5v9E0g/ck0vNX9mZ+9fAm58FbmmS25BBFVxTvJfyZVlJd/pzxl/Ka
	 KoE6SFVtGeoqcSwynFQ4GcokCbi7uzHq9uNXnsW7d3Y7J47fMcqzzjNlE4bwPxCQne
	 y+CaqXXMo8CsLwnEMEFgpS30DJz0bvG9oWVHYA8BdKAjeGtWh8eLvrb3pg5H+9YOCm
	 K/ysBXrWYX3UQ==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7A9AC17E07A2;
	Thu, 16 Jul 2026 00:45:22 +0200 (CEST)
Message-ID: <8c5be57e8fcc088f8041bf64068575b6bb0d7fcb.camel@collabora.com>
Subject: Re: [PATCH v2 3/3] media: rkvdec: hevc: guard
 INTER_REF_PIC_SET_PRED index underflow
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, Detlev Casanova	
 <detlev.casanova@collabora.com>, Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>,  Mauro Carvalho Chehab	
 <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 15 Jul 2026 18:45:21 -0400
In-Reply-To: <20260527194737.1999409-4-michael.bommarito@gmail.com>
References: <20260513181922.2075438-1-michael.bommarito@gmail.com>
	 <20260527194737.1999409-1-michael.bommarito@gmail.com>
	 <20260527194737.1999409-4-michael.bommarito@gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-I8pg+O55ZQp1VWGZyCYM"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-I8pg+O55ZQp1VWGZyCYM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 27 mai 2026 =C3=A0 15:47 -0400, Michael Bommarito a =C3=A9crit=
=C2=A0:
> st_ref_pic_set_prediction() computes the reference RPS index as
> st_rps_idx - (delta_idx_minus1 + 1) per HEVC spec equation 7-59.
> Both operands are u8, so when delta_idx_minus1 + 1 exceeds the
> current index the subtraction wraps and the subsequent array access
> at calculated_rps_st_sets[ref_rps_idx] reads far out of bounds.
>=20
> A userspace V4L2 client that can open the RKVDEC m2m decoder can
> submit an EXT_SPS_ST_RPS control with INTER_REF_PIC_SET_PRED set
> and delta_idx_minus1 crafted to trigger the underflow.
>=20
> Reject the entry early when the reference index would underflow.
>=20
> Fixes: c9a59dc2acc7 ("media: rkvdec: Add HEVC support for the VDPU381 var=
iant")
> Cc: stable@vger.kernel.org
> Suggested-by: Detlev Casanova <detlev.casanova@collabora.com>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-common.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-common.c =
b/drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-common.c
> index 3119f3bc9f98b..898d1ce74f38a 100644
> --- a/drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-common.c
> +++ b/drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-common.c
> @@ -268,6 +268,9 @@ static void st_ref_pic_set_prediction(struct rkvdec_h=
evc_run *run, int idx,
> =C2=A0	int i, j;
> =C2=A0	int dPoc;
> =C2=A0
> +	if ((unsigned int)rps_data->delta_idx_minus1 + 1 > idx)
> +		return;
> +
> =C2=A0	ref_rps_idx =3D st_rps_idx - (rps_data->delta_idx_minus1 + 1); /* =
7-59 */
> =C2=A0	delta_rps =3D (1 - 2 * rps_data->delta_rps_sign) *
> =C2=A0		=C2=A0=C2=A0 (rps_data->abs_delta_rps_minus1 + 1); /* 7-60 */

--=-I8pg+O55ZQp1VWGZyCYM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalgNgQAKCRDZQZRRKWBy
9GIcAP9N/ju7zuDAju1GJU3D1q50WHfd8e3K6bwTwIhCQCezRQEA/WKm8VkQAkIJ
FGLTRoEbQCWgEcGsVv8X5CJPPWkRVAU=
=01gk
-----END PGP SIGNATURE-----

--=-I8pg+O55ZQp1VWGZyCYM--
