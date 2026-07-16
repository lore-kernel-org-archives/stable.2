Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191919ADA4;
	Thu, 16 Jul 2026 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167103; cv=none; b=Msbtutz9EYphN3JjKqxL6nAT1XNR41buc/qQ0tgU4sYHcU8iUiDowPcV69p4BoblFFNhOdAyr4dP0yPh7freeWE+V0mHY79L7NBqpFB5vBdLXKNUlh8HgWVuK/IA+OEziVFn4u9+1zSCPyAsoLdmtqbRLuPkQUROs4IvepYxBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167103; c=relaxed/simple;
	bh=iOhPjnlyjajnNeKk4fwL+SXAFvbiD1CqH2obIG27D5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DrzMW5J8Ql2GgRerGPMy3Vn4pRBBjMxGJm4fM2x7jbJA7IE1t+sjdmUB31zjiO7QBVQ+CNFV/KbFhBqzW46eW/L+uTzG8DKXD4KH9mfgmkOdSOyw5binw/Lpw+LvpDxhhWmL5f3cn2vEHQpp/Bx/QoECMhcs+5UwWys3QxNWM+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VegcjZFB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VegcjZFB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784167100;
	bh=iOhPjnlyjajnNeKk4fwL+SXAFvbiD1CqH2obIG27D5I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VegcjZFB6brt/JqA0I/yQ1ZiJKkBgw4ne5rRoCqB/gicjz38ZepkWIj+CI4LO/j6K
	 2c9gp4pgLrixSX3inyrkZWULuyTP9iMo6fQeUI52obhowQKrjQM2jMoGO4NZYOi3M+
	 LUiMhty4TSX4bb1XpFoBStx0VWlDlE879ai2mU+YYl1YoYhE0cvRxC0xJ8uh4PY3x9
	 QTaeXzSoIIuhEqQTcSnL+5/a0wFkZrePs05LNvYxb1tGpdvcE2+nDc6IqDJYqSg7Ag
	 9G47JOAAqKzqgniwMGLNFxWJeYiSYprcb9IKn6GrhrOevRZDKMMe92DQYjEew945pv
	 7PCmqUsEOkTKg==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4BC3817E0B89;
	Thu, 16 Jul 2026 03:58:19 +0200 (CEST)
Message-ID: <67a3a66a1c7e6935041b0afbad6efce8b12a89c1.camel@collabora.com>
Subject: Re: [PATCH v1 2/7] media: chips-media: wave5: Set inst->std during
 default format initialization
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Wed, 15 Jul 2026 21:58:18 -0400
In-Reply-To: <20260626012232.111-3-jackson.lee@chipsnmedia.com>
References: <20260626012232.111-1-jackson.lee@chipsnmedia.com>
	 <20260626012232.111-3-jackson.lee@chipsnmedia.com>
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
	protocol="application/pgp-signature"; boundary="=-xSbvXqpWfv3EjvAA23v1"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-xSbvXqpWfv3EjvAA23v1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 26 juin 2026 =C3=A0 10:22 +0900, Jackson.lee a =C3=A9crit=C2=A0=
:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
>=20
> When the encoder is opened, wave5_set_default_format() sets up the
> default capture format (e.g. H.264) but does not initialize inst->std.
> As a result, inst->std remains zero, which does not match any valid
> encoder codec.
>=20
> If STREAMON is called before the user explicitly calls S_FMT on the
> capture queue =E2=80=94 as v4l2-compliance does in testBlockingDQBuf =E2=
=80=94 the
> codec/product check in wave5_vpu_enc_init_seq() fails with
> "Unsupported encoder-codec & product combination" because inst->std
> is neither W_HEVC_ENC nor W_AVC_ENC, returning -EOPNOTSUPP.
>=20
> Fix this by setting inst->std via wave5_to_vpu_std() in
> wave5_set_default_format(), so that the codec type is always consistent
> with the default capture pixel format from the moment the instance is
> opened.
>=20
> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index e6c94b6f2671..f9fcdf4c224b 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -1494,7 +1494,8 @@ static const struct vb2_ops wave5_vpu_enc_vb2_ops =
=3D {
> =C2=A0	.stop_streaming =3D wave5_vpu_enc_stop_streaming,
> =C2=A0};
> =C2=A0
> -static void wave5_set_default_format(struct v4l2_pix_format_mplane *src_=
fmt,
> +static void wave5_set_default_format(struct vpu_instance *inst,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 struct v4l2_pix_format_mplane *src_fmt,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 struct v4l2_pix_format_mplane *dst_fmt=
)
> =C2=A0{
> =C2=A0	src_fmt->pixelformat =3D enc_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pi=
x_fmt;
> @@ -1506,6 +1507,7 @@ static void wave5_set_default_format(struct v4l2_pi=
x_format_mplane *src_fmt,
> =C2=A0	wave5_update_pix_fmt(dst_fmt, VPU_FMT_TYPE_CODEC,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 W5_DEF_ENC_PIC_WIDTH, W5_DEF_ENC_PIC_HE=
IGHT,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 &enc_frmsize[VPU_FMT_TYPE_CODEC]);
> +	inst->std =3D wave5_to_vpu_std(dst_fmt->pixelformat, inst->type);
> =C2=A0}
> =C2=A0
> =C2=A0static int wave5_vpu_enc_queue_init(void *priv, struct vb2_queue *s=
rc_vq, struct vb2_queue *dst_vq)
> @@ -1770,7 +1772,7 @@ static int wave5_vpu_open_enc(struct file *filp)
> =C2=A0	inst->v4l2_fh.ctrl_handler =3D v4l2_ctrl_hdl;
> =C2=A0	v4l2_ctrl_handler_setup(v4l2_ctrl_hdl);
> =C2=A0
> -	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
> +	wave5_set_default_format(inst, &inst->src_fmt, &inst->dst_fmt);
> =C2=A0	inst->conf_win.width =3D inst->dst_fmt.width;
> =C2=A0	inst->conf_win.height =3D inst->dst_fmt.height;
> =C2=A0	inst->colorspace =3D V4L2_COLORSPACE_REC709;

--=-xSbvXqpWfv3EjvAA23v1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalg6ugAKCRDZQZRRKWBy
9PDzAP9ANkdBhB/i6YK/cOJjXIyWYtpWyuHXDKvHdFCUxStaEQEAuMnPrCyzSl3i
hT29kTJzellIscT2X4Lr9X70bwWzyQM=
=Ke+B
-----END PGP SIGNATURE-----

--=-xSbvXqpWfv3EjvAA23v1--
