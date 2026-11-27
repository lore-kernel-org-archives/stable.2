Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795744027;
	b=PE1yXzP2EYY/4yS4gRDmEb/ItIey+9YE4EHcB2ZsvECsNw+LIpZXNYyJMvBUzZHGtQOV
	 QDcbeQ+lTGq4EtYIxGh4XS2qZAFro34XnRWkqF3Iwn1sNCvds0mMdSoBbG8GWnvW2YsYn
	 O76KVrrHjakMYLfxzXEY/gegR68FdkOn0MEq6xgod16bGN22Wj/vuSRofvO6d/KGQbBIm
	 3wfD4bcrdoNPIUwxIRUv8w/ZbD1wabMeAPb3X4Op7WJIwDPjjKXVYyFVk0gs8ShBCHu0V
	 ks809vRNN0dvST/jSV7RzeEGrIV7K6Z3xbAb0XChdEDSpsLAzDZLrfF4wYvpdce8liQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795744027;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=qwMP9B/3kCrlMLEZN1Lm4kmafzrl8vVQWCe8mDoH+Hs=;
	b=StiElJ5bVszn2vp+dgMkwWL1Bz9ipVfOF5yeWRggewDrYDNTXYIXIpOD02Iy/71r/mPA
	 y636YCf2RjSR9TYvagKUEl++ZUhFgRPa0qyNPU4bvo6Z/kYubi+vXuh2XtggocrtKHU28
	 rmbhkbxKqhPautS1uYjfPrrbjuAdv6nQfOo6LfycR7wtZJq4eEL41/BlmzLIVFeXr74qh
	 WfTN3dhPbldrGho2KEhdIm27jZmqO+fjVI7yCklsjt9aT1/GCJXmlY+N6mOFcua5F6KKi
	 oS8j040jdsTGz7Wqb5RSYSIedHmF78jxBav4tcoEUFxAOJDIB3HysUT+JuWfucDuusQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=dqa1Xc04;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F711606A31C;
	Fri, 27 Nov 2026 01:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F711606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=dqa1Xc04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795744024;
	bh=U1JA4zNJNtwQOu7BZhY0zwXJqaY5FdyigzB90dhY+uc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dqa1Xc044P/zDkZINqvd9zb9sE4LSgP1bkixAY0uqTURz6y4edAWODt+nUSeHyDb7
	 8O7qDvAoq83kJR5QnAB2ckbzAv7chyFQVJOFgixsbXZ+4F2k4KG/klAHXz9+mTkKGJ
	 ottJVzLH2EBW/t1+wNFukluyI+jr1VICrBdiaYfqp8ib+LHNbCMw6+qX36UJxsE1lj
	 3Z5g3aPHVcJviCwqPiXG4NjTIie6OPxs6/StnK5vxgFYIfGkgyQZSX9e7Uda8X4boq
	 iztQ26FM0XZ3MlX+AfQiVDVIGXtBEmAsZzVGfPITDXh8Hy4cvFDc3xbyOghZVxPNdF
	 Zz3SaHa1ipq1g==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B846717E01D1;
	Fri, 27 Nov 2026 02:47:01 +0100 (CET)
Message-ID: <adcc275b0637938c24f39578280b09982514e5ef.camel@collabora.com>
Subject: Re: [PATCH v2 0/6] media: verisilicon: Fix MPEG-2 field pictures,
 4K VP8 and the AV1 tile buffers
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: aiyengar1990@gmail.com, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>,  Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Sebastian Fricke	
 <sebastian.fricke@collabora.com>, Hans Verkuil <hverkuil@kernel.org>, Heiko
 Stuebner <heiko@sntech.de>, Boris Brezillon
 <boris.brezillon@collabora.com>, Jonas Karlman	 <jonas@kwiboo.se>, Ezequiel
 Garcia <ezequiel@vanguardiasur.com.ar>, Jeffy Chen	
 <jeffy.chen@rock-chips.com>, Tomasz Figa <tfiga@chromium.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org
Date: Thu, 26 Nov 2026 20:47:00 -0500
In-Reply-To: <20261112-hantro-codec-fixes-v2-0-f44424df585b@gmail.com>
References: <20261112-hantro-codec-fixes-v2-0-f44424df585b@gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-uG+GDnvb0XaDbhY/ZuMI"
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

--=-uG+GDnvb0XaDbhY/ZuMI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 12 novembre 2026 =C3=A0 08:54 +0000, Arun Iyengar via B4 Relay a =
=C3=A9crit=C2=A0:
> Fixes for the Hantro decoders on Rockchip SoCs, found while running
> conformance streams and v4l2-compliance on the RK3588.
>=20
> Patches 1 and 2 make field-coded MPEG-2 decode on the G1 and VPU2: the
> driver refused V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF for MPEG-2, so the
> second field of a frame could not land in the same CAPTURE buffer as the
> first one, and once it can, the second field was identified with
> top_field_first, which is always 0 in field pictures, so it predicted
> from the wrong field. None of the field-picture streams of the ISO/IEC
> 13818-4 main-profile suite decoded before; they decode now.
>=20
> Patch 3 stops advertising VP8 above 1080p on the VDPU2 and RK3399
> tables, whose only CAPTURE format stops at 1920x1088, so that a 4K VP8
> stream is refused instead of mis-decoded.
>=20
> Patch 4 fixes the reuse check of the VPU981 AV1 tile column buffers,
> which only compared the deblocking data buffer although the five buffers
> scale differently with the frame height, bit depth and number of tile
> columns, and clears the sizes when the buffers are freed.
>=20
> Patches 5 and 6 reject malformed AV1 frames before the decoder is
> programmed with them. With no tile columns the tile column buffers are
> sized to zero and the decoder runs without them (patch 5). A frame that
> is larger than the CAPTURE format does not fit in the buffer the decoder
> writes it to, whose size and layout come from the format, and a frame
> height beyond the limit of the decoder also wraps the 32-bit size
> computation of the tile column buffers, which leaves them too small for
> the height programmed into the hardware (patch 6). Both are rejected at
> prepare time.
>=20
> Tested on an Orange Pi 5 (RK3588S). Patches 1 and 2 were verified with
> the ISO/IEC 13818-4 main-profile conformance streams through GStreamer's
> v4l2slmpeg2dec on the VPU121, compared with FFmpeg: the field-picture
> streams (sony-ct1..4, tcela-8/9/10, hhi_burst_short/long) went from
> rejected to 53-67 dB PSNR, and the 26 frame-picture streams are
> unchanged. Patch 3: the VPU121 decoder lists VP8F frame sizes from 48x48
> to 1920x1088, S_FMT of a 3840x2160 VP8 OUTPUT format is clamped to
> 1920x1088, a 1080p VP8 clip still decodes bit-exact against libvpx, and
> the 4K clip is now refused instead of decoded into 1920x1088 buffers.
> Patch 4: one v4l2slav1dec context decoding a 1920x1080 10-bit
> 4-tile-column stream and then an 8-bit 5-column one (and 2048x128 with 4
> then 8 columns) is bit-exact against libdav1d, 32/32 frames each, and a
> kprobe trace of the DMA allocations shows the tile buffers reallocated
> when the second stream needs larger ones.
>=20
> The new rejects of patches 5 and 6 were tested on the board with v2:
> requests with a no-tile AV1 frame, with a frame height that wraps, and
> with a frame that is wider, taller or, through superres, upscaled wider
> than the 1920x1088 CAPTURE format (3840x2160 among them) are each not
> decoded and both of their buffers come back with V4L2_BUF_FLAG_ERROR,
> and a frame of the format size and a smaller one after them are still
> accepted. Four runs of the fluster AV1 conformance suite give 203/242
> each, failing the same 39 vectors as an earlier run on the same board;
> the streams that change the frame size and the ones with spatial layers
> still decode. In a fifth run av1-1-b8-06-mfmv also failed, with one
> decoder timeout and no reject; it passed in the other four runs. The
> board kernel is 7.3-based and also carries a fix for the ->run() error
> paths (the AV1 one finishes a refused job twice), which Sascha Hauer's
> series "media: verisilicon: Fix error paths in hantro drivers" addresses
> upstream [1].
>=20
> [1] https://lore.kernel.org/all/20260824-rk3588-jpegdec-v1-0-180a30a2852d=
@pengutronix.de/
>=20
> This series was developed with Claude (Anthropic) as a coding assistant:
> it wrote the code and the commit messages, and I reviewed and tested
> every change as described above.
>=20
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

For the series:
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> Changes in v2:
> - New patch 5: reject an AV1 frame with no tile columns, which would
>   otherwise size the tile column buffers to zero (Sashiko: AV1
>   tile_cols =3D=3D 0)
> - New patch 6: reject an AV1 frame larger than the CAPTURE format, which
>   does not fit in the buffers of the decoder and whose height can
>   otherwise wrap the 32-bit size computation of the tile column buffers
>   (Sashiko: u32 overflow from frame_height_minus_1)
> - Patches 1-4 unchanged
> - Link to v1: https://patch.msgid.link/20261110-hantro-codec-fixes-v1-0-0=
fd5372ce831@gmail.com
>=20
> ---
> Arun Iyengar (6):
>       media: verisilicon: Support holding the CAPTURE buffer for MPEG-2
>       media: verisilicon: Find the second MPEG-2 field without top_field_=
first
>       media: verisilicon: Don't offer VP8 above 1080p on the Rockchip VDP=
U2
>       media: verisilicon: Check every VPU981 AV1 tile column buffer befor=
e reusing them
>       media: verisilicon: Reject AV1 frames without tiles
>       media: verisilicon: Reject AV1 frames larger than the CAPTURE forma=
t
>=20
>  .../platform/verisilicon/hantro_g1_mpeg2_dec.c     |  8 ++--
>  drivers/media/platform/verisilicon/hantro_hw.h     |  8 ++++
>  drivers/media/platform/verisilicon/hantro_mpeg2.c  | 31 +++++++++++++
>  drivers/media/platform/verisilicon/hantro_v4l2.c   |  2 +-
>  .../verisilicon/rockchip_vpu2_hw_mpeg2_dec.c       |  8 ++--
>  .../verisilicon/rockchip_vpu981_hw_av1_dec.c       | 53 ++++++++++++++++=
+++---
>  .../media/platform/verisilicon/rockchip_vpu_hw.c   |  8 ++--
>  7 files changed, 98 insertions(+), 20 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261110-hantro-codec-fixes-59d42b5609c4
>=20
> Best regards,
> -- =20
> Arun Iyengar <aiyengar1990@gmail.com>
>=20
>=20
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

--=-uG+GDnvb0XaDbhY/ZuMI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawjhFAAKCRDZQZRRKWBy
9EfoAQC5BLzFJOWU0RvUDpGetVfKarxfp4Gi7jKWadpUW8gZlAD/SXNekZd2lcO0
ggmfyz/UD0BWGvfxSj089RGPCY7r9wo=
=AAwj
-----END PGP SIGNATURE-----

--=-uG+GDnvb0XaDbhY/ZuMI--
