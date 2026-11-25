Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624369;
	b=j+QRKzMsz4IytmmPSw33Q5U7dVZOky2+1EqLxoVXC9ZA3AhwqT9PNWnLT4JG+jN6NQr1
	 +Jqqbc4zapYcZUT7kXnpcqhZp2z9l38WIzg+q56pz4eTGSYBCChd9fcVxikZm+C3e5/Ac
	 BmHRq9i0ZZidzbiM8oCCq90HjLbiuYrQVNSvWCR/9PWC1lMeqFygvtppyyb6Ro7R877HE
	 t5iBeVl0pLrPsGZJidpnK0kVYXewRvOKEO3CLI5n9pTKXxEAbKdFoTCOTVrLhKvSYwotw
	 JDEqBHyiWp/iNZsJhZ4+fpxrdxlPUtARE4lKHGNpM4BS8xCeZy52B6FZ0yrBnA+Reng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=fjeXOElCViRQmgZvgDDdONv2Uyhg+At7B3MV4y/CS3E=;
	b=mG41ENtkU2CM/9LcQtXCrX3aC5domhiVHYvbR74IWY7AfGE2ZlQXtfzInj/UvYliwSYr
	 6QTL30cMQIXvs/h8+XWfXdgotbXv8wZUHVCVG8sw7ROE6TYYUoCD8Jz9nCm+C9VP4YwT5
	 B5cV+CAyyaoOIvt/s2+EJBgGemZ57wF6cKTRh5aaU+rcmem+7uWcPoXuZ8sIYDRhLLuA9
	 bnCCXK5ArBGMAjw1G+PpE+mh4iGa+YCuzZHeZtWYOC3MUUTCCi/Y3sXZ9RaFh/y5Ny6h+
	 9WpuuZdcchebHgFHHhIQVegmDhM38UPo36W+dUyiS/fMRNv6dUUwAggaLDHdWPsSDnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OeYV92tR;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B9606A339
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D44B9606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OeYV92tR
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so51075065e9.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795624367; x=1796229167; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fjeXOElCViRQmgZvgDDdONv2Uyhg+At7B3MV4y/CS3E=;
        b=OeYV92tRoy3r9HM1arkFD4XQZAtUvBnArRdHX3S+tRAhPlHWD42AGwa0CbMKQhe1A8
         hpFCCQOqCtJtMB3yL2tkM9ewgVf+3TQlOdTOcVE8tVzC/N4x8FroFZ+4s1KkyyMRvvb9
         qO/v6gwiQ8v90pSSZhqvkv6IYdGMj5DDlM7FngblUIRRPd38C+Ed/z1fWqykg5LOt0Fa
         vY3HRgF55bzfsCw87qYRanRQB1D1EbX5syTy7RO3nqaT0AQpETdCfqNcTUPneuz5hpf8
         oU2uS23TLTIxbKspf8f5Yv9TS0g8f5S3dwLjkUQ1/P0pAemljB7Z3QkJDb+uUFDaiQpz
         UQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624367; x=1796229167;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fjeXOElCViRQmgZvgDDdONv2Uyhg+At7B3MV4y/CS3E=;
        b=bQmnHMvDnRyoqAczfL2g8jyPPY1HjSdjy7ZAFILgrT+THCFIDIrxDga0kDi46lc4zL
         t+ydcRNY/nm22XRXzmJCAHCrkjn6oOuyoNPb8+ycBLLofHgmC7TKfLNhxhET6+5tRECS
         4jesRlg9Wx+DQv9kVJx+EMMuSoMAX+zxJ1zzoi92GW11NgL3ZAmFtMJEpAz+rLvOV/8h
         i54flzjTElvvWT5UaKug/OQN7JcZVOcroSQWR/qtdRrM9yGTorN7AUL5wq/HimUd0F82
         TtZm0YyYJqDV6WlT5ByFxcGiRzsez1vsGItOotCPLGe7c25p09ChOaC0H+fG6hFTYhal
         CH9Q==
X-Forwarded-Encrypted: i=1; AL+hErFEJSDUtAy6dCdZ9n6i7yqp+8Ch76PSj/7E8tsEtIGp4mXH+sGefAHtS+x9fNdLyxlB7pBA/Ts=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TcW+XiaLENebBZOlyabRwjGMlxu9wiFqOFrSrC/s6TwBlKbOl
	SMFETiTMOhg0To4g/slItvfLeS1XIMfHkmk3NQY8aFIXNVEXxNu/Bw8P
X-Gm-Gg: AZFdTZeF2kqaK7jxg1ijJnjnFF8UEB65sBF4fiA6gewXuirpa0ZHrQutM27Vl8do8cE
	979QSBn0nrbGhvkqrxcTPwcUeIf2Au3qS2Ucsr+PLlix7IrPinyWBbs9I6RR2ywGRc1Cp3Jb0WJ
	NMyb7iZGV/qYZWe3EL3ZEbGJcDPhyxows6W0WPRuHZTiRhqCy3LgVJYLEinSxMIO81abJexLI8b
	tUdfr40UDs1i9J8mk0LQNHEywKv+Auz9nWo88UAk8hqXIZ3pcC2+cHzr8+fHxSYs+PynwhN3oJV
	5GuxfLwGJUi3ugQusnTfaT9uJrUg26E0ueJf7mQ9h+acIYUiBITuiUgVM5gq+5usoSy/WinZq22
	WOBHGd5XnsHtz2K5uIBNw1pwnUJczphd2F+y3WaDv8h4YfzcKlXmLQrICTsDfAzyXglgKi7fQs3
	JyTfaKcoMDgudoEffiV5Puj4roCu5hPA4cu3m2XQlqnwHCxn0CQ9hhlDKX5kQsQKPdbDLHUc6zq
	flX174UcQvO+RjbbLVrhzLqzHeVrP/r9hyiKs57BZEtwsujowyDXWvh2NRfvHhjxLXBIipa0RSf
	mDNyeFfMsF0Y4ALjWHGcXteVoSsqvX6o2HwDfWe0jB4929LgV1FGSt4qO1AToqRoUapmay4eenk
	g325w9Kw2s9/JOnOgSQSwvgf2JdtCbal+NLqTeyr+O3WZMFnEOfj2Lftujks+nJB/qX5MbnpBB4
	i2mjMqTP/na0I5qyMQhaBiJ/bLIkvV0lDTl0cKPttsN9LNN96LDzVXXvBWXORRWXRncgANpebma
	c+A1HoA84/kuXpQwyEEkUkR1Y0rzUQTfEn4wqjG8aoNRAj5XEScnpK0FwDDtmyWCNhEIqpxaFUg
	ts/N7p+2
X-Received: by 2002:a05:600c:800e:b0:4bb:7757:fe58 with SMTP id 5b1f17b1804b1-4bb8881b9d7mr381679255e9.19.1795624366963;
        Wed, 25 Nov 2026 08:32:46 -0800 (PST)
Received: from jernej-laptop.localnet (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm560493135e9.8.2026.11.25.08.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:32:46 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 Re: [PATCH RFT v3 3/5] drm/sun4i: layers: Fix VI buffer address for clipped
 offsets
Date: Wed, 25 Nov 2026 17:32:45 +0100
Message-ID: <sBipOLw6T_aZ1e-H2zFl3g@gmail.com>
In-Reply-To: <20261124074041.115251-4-wenst@chromium.org>
References:
 <20261124074041.115251-1-wenst@chromium.org>
 <20261124074041.115251-4-wenst@chromium.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 24. november 2026 ob 08:39:31 Srednjeevropski standardni =C4=8Da=
s je Chen-Yu Tsai napisal(a):
> Commit 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to
> get display memory") dropped the code to calculate the framebuffer's DMA
> address in favor of drm_fb_dma_get_gem_addr().
>=20
> This turned out to be wrong in a couple ways. The hardware is programmed
> with clipped dimensions, so it needs the buffer address to start at the
> clipped boundary. Moving to the helper negated the clipping. Also, when
> clipping on the left, the buffer address needs to start at the first
> pixel in the sub-sampling group even for the luma plane. The hardware
> handles the interpolation internally.
>=20
> Switch to the new drm_fb_dma_get_gem_clipped_addr(), which provides the
> buffer address starting at the clipped boundary. Calculate the intra-group
> offset and adjust the luma plane buffer address so that it points to the
> start of the sub-sampling group.
>=20
> Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to=
 get display memory")
> Cc: <stable@vger.kernel.org> # v7.1+, needs drm_fb_dma_get_gem_clipped_ad=
dr()
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> This is an alternative to Jernej's original revert:
> https://lore.kernel.org/all/3980ea1aeb3f7fe8b4700e36560deeba3d050664.1785=
772659.git.jernej.skrabec@gmail.com/
> ---
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  2 +-
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
> index f9c7f28f9fa2..67cce1b0e70f 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -130,7 +130,7 @@ static void sun8i_ui_layer_update_buffer(struct sun8i=
_layer *layer,
>  	ch_base =3D sun8i_channel_base(layer);
> =20
>  	/* Get the start of the displayed memory */
> -	dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, 0);
> +	dma_addr =3D drm_fb_dma_get_gem_clipped_addr(fb, state, 0);
> =20
>  	/* Set the line width */
>  	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> index 4d3fc03f9877..b6796416d550 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -205,7 +205,21 @@ static void sun8i_vi_layer_update_buffer(struct sun8=
i_layer *layer,
> =20
>  	for (i =3D 0; i < format->num_planes; i++) {
>  		/* Get the start of the displayed memory */
> -		dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, i);
> +		dma_addr =3D drm_fb_dma_get_gem_clipped_addr(fb, state, i);
> +
> +		/*
> +		 * The mixer can handle odd offsets into sub-sampled YUV
> +		 * planes, but needs the address of the first pixel in each
> +		 * sub-sampled block. Adjust the luma buffer address backwards.
> +		 */
> +		if (i =3D=3D 0) {
> +			u32 x_diff, y_diff;
> +
> +			x_diff =3D (state->src.x1 >> 16) & (format->hsub - 1);
> +			y_diff =3D (state->src.y1 >> 16) & (format->vsub - 1);
> +			dma_addr -=3D y_diff * fb->pitches[i];
> +			dma_addr -=3D x_diff * format->cpp[i];
> +		}


This could be done differently.

Before for loop (done only once):
src_x =3D (state->src.x1 >> 16) & ~(format->hsub - 1);
src_y =3D (state->src.y1 >> 16) & ~(format->vsub - 1);

Inside for loop:
gem =3D drm_fb_dma_get_gem_obj(fb, i);
dma_addr =3D gem->dma_addr + drm_framebuffer_get_block_offset(fb, i, src_x,=
 src_y);

But it works in any case, so:
Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> =20
>  		/* Set the line width */
>  		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
>=20




