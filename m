Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370F30EF97
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715647; cv=none; b=TnDPsIlYFeKkx6cbp7oAcwkyU38EiZG7ZLN5YFPujePwr7jxL3ctk+DzgZY667vYmaEAbg1VtAZyLmTTal8bheP/Q3x3mxvBmyIuWNjDcN6/dA/iObXxV0eBpYHRgqW3R8zF4GoeLDR/vMh3jSGRg+vctvz3DORVQhDW6C9oI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715647; c=relaxed/simple;
	bh=0H3j7sWl5G8y6Uv1S0WkJaRGAOnVVH/GrTVxH1ZKHyI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BAXx1cLggcxLAMXrV9p6oJz136MwlxincjFLbmmvQNq+RqTSYHCR9REZFH6drrVUmW3gXoCN7LuVVXsMIa3S7gqNnU9/QoHt5lcRZVY8BQV5GTew/7p4b3kLIYhkwRvEA7MyiC1FqhD9ADjOVXcMxBVL8qM92DMiVDvgv5x66ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=sZUywr3K; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="sZUywr3K"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c4436d02cso5952801cf.1
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1786715645; x=1787320445; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tq/4Dxp9Lq5lOmtwqVhbb0b5mzgrcMsvD4kX5zmmpJg=;
        b=sZUywr3KbNrnC1+xtKhzKulyZNvid8xpoXtEDCz8lRJRI8QgVoeluk5ysK7cjGrctV
         926zTFPKAqZXmaG7I+dKjVD/3C8o8VuPmh6pnC3MX/+xDQHQa9qSgyqPw9PBczeXOZ/O
         1cYzFsT0CsYerp3o96c5r+pG7SVOpaFwSSyTAhkLVpFYPgGDPze7OI4F3v+ek6SwSyVQ
         s767OV7peNM1hhom2dtO13B8hIFxdZ1Cy5+nB0jFWCp1Aid5Qj98Bjxp28YO57NQj31m
         +M/AhEvw4we+y92y6ijj+ob4P13NGP1L7KgNrAqYBM/LEkDUoQw0ieSHVjSJv/9Q/GVN
         m4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786715645; x=1787320445;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tq/4Dxp9Lq5lOmtwqVhbb0b5mzgrcMsvD4kX5zmmpJg=;
        b=jlr4OrZiV/fCE2grrJLV5SkEKKRUe+y1w25mDPBhsH0HquJNcimICfTDezoCc38yHW
         k/KqY656Z3nCYdmcQPeRlGQDEw8Waljd+IbIq2bqY2eMoqW1j0st+q3yO6w3exTy+nNw
         IHV/uDU7XJKEM2UPd9rxEKR6PgbTlE6HjtdRWhCQn6uvUAasnaYHrB+K1+8xjQxckZIH
         VRhJvFtPSwQJsKhfnJ2GXEGDv9aE6hl5NSNZ5x/e5nICaI+ILj851DdLEEQdfxkxtTdE
         B60CB1rxZ2eduxDR5tntPb4ZBotA5pHGbeEFEWCFZkC6T7Vjgya1+fwxQVTRj9H2IOA6
         fHHA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1g5jDZRHTq0fDWOG49Esy9kO3Y0S5iU5dnRCban2evrOa8/NTAz27iA62Mc+PxfG1UtP+rX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfOlLhe3RDnm09Th9dCn1YImcVwlKcAm7e9PEhUHjd4zG0xNAN
	DVYGq+SNQX8R56Z2HubWGv1GWy5YLYKOqfZReCq4Ky9h3+fld3n6+gvQ5tUkFSXkY8Y=
X-Gm-Gg: AR+sD121UE8vdBK9cv+kLOhiQ7MPSBkjFIosA9/6hAkraMdILV+jWFPrqxVEQdujs0K
	lVkjbwvtQD/fL0Wvimho5uJ5jBDeF336ByzXggkyRp73u7xfkOFY/hJc/B/tnAcrxduI7MrZHIN
	kWgpEQnzzKTgxAhsj6YRoYx1vPKvUWJ6aj29u5QqPwbjHoU4tl+poLBGg0iUVh6uQuv0mW4DQxr
	KQJXfkpYjmhlxrt/PYA/40gqVQb+1MB/7szYS8yt6J3tbFjYOfaZH0eOSn5gbp0VmksQvytasqj
	u7JHF9muVM0cATFw5sp4UGl/LKGveApO9VhM9oVotfskRRss4SxlAh3a56bQWYLjKXzwiPu5qaN
	Zdnrpt+w/YSu18VuxAwhxxv90aEjmeiy/KRH9/9ldgLu92CAzDpkm24p8jieU3tGt+W2aKI1M/p
	260IZ3eYAFrYCuIU5TtRKWVBmYmAUB3S9zPdzzgTGu4296fDx4ETGZcmY05YGSojUR9w==
X-Received: by 2002:ac8:5952:0:b0:51c:1ec5:d0f with SMTP id d75a77b69052e-52d854f2433mr60161451cf.40.1786715644660;
        Fri, 14 Aug 2026 06:54:04 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e221::5ac? ([2606:6d00:15:e221::5ac])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d83ef775csm21392021cf.7.2026.08.14.06.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:54:03 -0700 (PDT)
Message-ID: <3a0996708452454edb9ef4735d0ae343a04dbce6.camel@ndufresne.ca>
Subject: Re: [PATCH] media: vicodec: zero-initialize stateful decoder heap
 buffers
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: moonafterrain@outlook.com, Hans Verkuil <hverkuil@kernel.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Keiichi Watanabe
 <keiichiw@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Yuhao Jiang
	 <danisjiang@gmail.com>, stable@vger.kernel.org
Date: Fri, 14 Aug 2026 09:54:01 -0400
In-Reply-To: <20260813-vicodec-fixes-v1-1-13077b5b6c29@outlook.com>
References: <20260813-vicodec-fixes-v1-1-13077b5b6c29@outlook.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
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
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-v6aq/8iizxPYsUlaL/5Q"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-v6aq/8iizxPYsUlaL/5Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le jeudi 13 ao=C3=BBt 2026 =C3=A0 13:51 +0800, Junrui Luo via B4 Relay a =
=C3=A9crit=C2=A0:
> From: Junrui Luo <moonafterrain@outlook.com>
>=20
> vicodec_start_streaming() allocates state->ref_frame.buf and the
> compressed_frame buffer with kvmalloc() for the stateful decoder and
> leaves both uninitialized.
>=20
> decode_plane() derives is_intra from the reference pointer being NULL
> (is_intra =3D !ref) rather than from frame-sequence state, and the
> stateful decoder always passes a valid ref, so a P-coded first frame
> reaches add_deltas() over stale heap content that is then folded into
> the decoded frame and returned via VIDIOC_DQBUF. The padding rows
> between visible_height and coded_height leak on every P-frame as well,
> since copy_cap_to_ref() writes only visible_height rows while
> decode_plane() reads up to round_up(visible_height, 8). For
> compressed_frame, only comp_size bytes are copied into the new
> comp_max_size allocation, leaving the tail uninitialized for derlc() to
> walk into.

There is a lot of description of what the code does already, and what your
change does, but for some reason, it seem you have forgotten the essential,
which is the rationale for this patch. Please focus on what this patch fixe=
s,
and then go into details. Looking forward a v2.

Nicolas

>=20
> Use kvzalloc() for both allocations.
>=20
> Fixes: 256bf813ba39 ("media: vicodec: add the virtual codec driver")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/media/test-drivers/vicodec/vicodec-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/=
media/test-drivers/vicodec/vicodec-core.c
> index 318e8330f16a..7ebde8f3fc37 100644
> --- a/drivers/media/test-drivers/vicodec/vicodec-core.c
> +++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
> @@ -1595,9 +1595,9 @@ static int vicodec_start_streaming(struct vb2_queue=
 *q,
>  	}
>  	state->ref_stride =3D q_data->coded_width * info->luma_alpha_step;
> =20
> -	state->ref_frame.buf =3D kvmalloc(total_planes_size, GFP_KERNEL);
> +	state->ref_frame.buf =3D kvzalloc(total_planes_size, GFP_KERNEL);
>  	state->ref_frame.luma =3D state->ref_frame.buf;
> -	new_comp_frame =3D kvmalloc(ctx->comp_max_size, GFP_KERNEL);
> +	new_comp_frame =3D kvzalloc(ctx->comp_max_size, GFP_KERNEL);
> =20
>  	if (!state->ref_frame.luma || !new_comp_frame) {
>  		kvfree(state->ref_frame.luma);
>=20
> ---
> base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
> change-id: 20260813-vicodec-fixes-a91ec4217ce3
>=20
> Best regards,

--=-v6aq/8iizxPYsUlaL/5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCan8d+QAKCRDZQZRRKWBy
9OlFAQDWCBKY1VPxjrIt6+0Y0vi5NqefHw4gi/J7J0jhjV3jIAEA/8niRR+SFiue
2AmZGOwn+1aLC2jGt1PU+A5ccjQnRgY=
=ew/F
-----END PGP SIGNATURE-----

--=-v6aq/8iizxPYsUlaL/5Q--
