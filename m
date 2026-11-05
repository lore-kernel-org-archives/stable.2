Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846187;
	b=Rzjlllx1Us8lfBD3sfHnI6Wt8/ljQePwawPEF5F0ZXaw1MdiQg6gWpXsWGvbBAGlTFPC
	 +cNYKDfoCf8Ep5koD9hsHourqRh2dfztTEP9hkwNpD3+eQA1I2QZWxnsJpXX5N66g1VJL
	 ZU5o+Ebl7ZW0YpR6kzKA+pc7gQyO1h4PEnAZ+kVAoXORx/H++JNmrGEX00Shx7RrEmL0h
	 f2AADigbUyjuQrRWI70FH9TVcv8YNGhRLzIXsdj3FT3gS8I8cSrpuF2J4pvwdLE15lXeN
	 TKNy0JFS1G2/eufGEI0PXkt90gi/HJeAZAa75AObvbuiLQmoQcUB9hQ8c/TRL/esh0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846187;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=mMANaqSq4GcsvcAjECinF07SRMy3T/n0++S+KBqJRx4=;
	b=cJATEHSfJgyTdFkVPWrKCa3BK6LYz1Ug5a7p7/2nqz5iMWVItIk52dNuCJnsAXwuCLOg
	 mofTzg7Tbe4j0hK9XBeO9SLiV7S/hMZiP7r8mo7sb5I4BVe1zqrbBytcQljzuiTBTrYBO
	 15nuQGXBqrHg/K9JqYAqm5cmE9PN14v7J5jRu7Bu/pr6nsK4gdYO95bHXO3Qqc4TRvGHH
	 sQ+BfiEJ1cqrsLIaqTBaAAlpfgFmIHaQaPE0qlO3mmKwrAvsIH7T5bCHxOZB1CN48XEV+
	 LdvxfDtxuDgoZ44yvadOdPXRTe7ap8d7NylWBxkvNiu/udhM9okCzvoplocASTxWx7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=iHiP5ZIx;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D31606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D31606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=iHiP5ZIx
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so715818a91.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 18:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793846187; x=1794450987;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mMANaqSq4GcsvcAjECinF07SRMy3T/n0++S+KBqJRx4=;
        b=l6KhAd4EsjfyQzr237a20Z4wpjlLjEwQbyDTvTlRhQy9SxcIFPFJvOS+DrL6X43LR9
         gEWZU+TQ1qxmU0YzaUg1UnBcdEAAPmKOuswu1S6lddNNbVG3f49XaFWQbAFdXDxoOL8z
         sUzNpsInNQXnTe6idVn+ihdsvbsRi1XMbhx6Bmk+j+75k/nDcrwoO62bbawNa9M+lc5D
         ygb+RS92VJbugwOuMJdLOf96+xsWkclf54FStefHDH+QYC3dRHUaOnzj7oIqqB7N1vQk
         m5wXAjOKFl44kLzvhXJpT22zn95OJdi8M/U2pQeyk4WrR352+UFuCytxgOJ9vl+O3PDm
         Nzbw==
X-Forwarded-Encrypted: i=1; AKwUvBzgaiUC+buFeUTN/PBw3fj23W2/8qmbbL+TbrTGMer2PHqDV0dw3JUP0bkgEPKnW+nig+T2Q3Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HwWbrseGuFRWyN43Xv+R/clmk6PtFlV8DV0vhipgT7dD4wzl+
	H9dGV2yhrmmW5FnhNkKbU9Movw6Q2HPOTyA0ZFhIuHTBBVhUcXvq5TRdcYz4rMj9u37p70ejB51
	m7jrVLPfayJN+xie6B/cDahIGPnv1lqtTFzVmKgbfuz7F5IoKlz6rHuARIXAuyANBE2O6LIHKOT
	FridxblhNmckr5mmrWRSCNkrPAKfUv5N0/N5EngOUV/eoxFoMDFzplEPQHPyDVLnDXRwcrVBpsh
	kqR/nPFImEEIa2c
X-Gm-Gg: AYBFou1H16Gx5GBsjh6LX/OxOGcSfOaUF7UJwgVry6AcClaucJQnwhJJuseqsfwD/AT
	qVZo4H/++OytyRM5wsZlVVv45zQVhmBKv6dKLkrm0/o76YhkejeE8vhjENCZDBePgpBos5wGump
	uvdXOyMtwTmeY9zF6lF0u9AxVl+d+j6ylityntBzHEYlAOKN1LL4G6yy3yQ2SMrq82Uy21cjToy
	NMrPm3uNOIjAbsalzPg7GWt53pmnwnRCngm2xZTu1ME8qBk4MR+GHju55xkCCHbclN6AHjiK1ZT
	9UTkYiB3oE1QK65WVbZrcOJkpFcpuvGmZTQruQyZJKTGtbB6zkGU2+yjf/STuAz4gfcvMLsYqdX
	+RJDKDUpx9aONVjFrDcPNAgi/UnXAeqtMoPt0tAy21IO+QBo5ZZyBhAf+1N/+XMTdC15LkwwGLJ
	iQfi4ow8d5TuYRvkmn2+9dx2fQs6KCGohpKg68305b
X-Received: by 2002:a17:90b:1a85:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3ae89736172mr14701800a91.21.1793846186503;
        Wed, 04 Nov 2026 18:36:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0b315a3f7sm886773a91.1.2026.11.04.18.36.26
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 18:36:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91e98bada22so3959756d6.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 18:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793846185; x=1794450985; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mMANaqSq4GcsvcAjECinF07SRMy3T/n0++S+KBqJRx4=;
        b=iHiP5ZIxelP/mtqj8/E96mEa46bm/O+JkF1IjuWIhY7d4A19x5kYJoI9vhEMDXS0p2
         MeqqJxV9LWwZ+cIsK0naDeKjJid+8D/T0UaWK3OaraZ3z4aoQu6gbeasBplNfqUPQdkV
         8zHQ0LxoDke+eKMb5YEDPIVeDNgF4WT/bh/yI=
X-Forwarded-Encrypted: i=1; AKwUvBz5GrPolvlWe5nkFBd2l/sCe6OLnawtjgSTVQhBNXx5JjboVguvzjfJn+sja4oa+74R0O0+8ME=@vger.kernel.org
X-Received: by 2002:a05:620a:bd3:b0:93c:6ded:4665 with SMTP id af79cd13be357-944214cb617mr2864029785a.1.1793846185414;
        Wed, 04 Nov 2026 18:36:25 -0800 (PST)
X-Received: by 2002:a05:620a:bd3:b0:93c:6ded:4665 with SMTP id af79cd13be357-944214cb617mr2864027385a.1.1793846184912;
        Wed, 04 Nov 2026 18:36:24 -0800 (PST)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4875514sm352304585a.37.2026.11.04.18.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 18:36:24 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:37:44 -0800
Message-Id: <DMMXFHCWWRFR.MUE8FPMJCZEG@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5/6] drm/vmwgfx: validate the framebuffer selected for
 cursor updates
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-6-zack.rusin@broadcom.com>
In-Reply-To: <20261027211729.646988-6-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue Oct 27, 2026 at 2:17 PM PDT, Zack Rusin wrote:
> Cursor atomic checks select an update path and look up surfaces through
> vps->uo. That object is copied from the previous plane state and is only
> replaced with the new framebuffer's object in prepare_fb(). Switching
> between snooped surfaces and buffer objects therefore applies the old
> framebuffer's cursor limits to the new image.
>
> KMS clients can also submit a guest-backed surface without a backing BO.
> The check accepts it, but the MOB update later copies from a NULL source.
> Zero-sized MOB images pass the check as well, then fail preparation when
> mapping zero pages, so TEST_ONLY accepts a commit that cannot succeed.
>
> Resolve the user object directly from the selected framebuffer in both
> validation and preparation. Apply the matching cursor limits, reject
> zero dimensions and require a backing BO for GB-only and MOB images.
> Recheck the backing BO in preparation before mapping it, while keeping
> snooped surfaces independent of a BO mapping.
>
> Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 61 ++++++++++++++------
>  1 file changed, 43 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/d=
rm/vmwgfx/vmwgfx_cursor_plane.c
> index f0661e5effeb..9e8ea9e07f40 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> @@ -89,10 +89,26 @@ vmw_cursor_plane_update_legacy(struct vmw_private *vm=
w,
>  	}
>  }
> =20
> -static enum vmw_cursor_update_type
> -vmw_cursor_update_type(struct vmw_private *vmw, struct vmw_plane_state *=
vps)
> +static struct vmw_user_object
> +vmw_cursor_plane_user_object(struct drm_framebuffer *fb)
>  {
> -	struct vmw_surface *surface =3D vmw_user_object_surface(&vps->uo);
> +	struct vmw_user_object uo =3D { 0 };
> +
> +	if (!fb)
> +		return uo;
> +
> +	if (vmw_framebuffer_to_vfb(fb)->bo)
> +		uo.buffer =3D vmw_framebuffer_to_vfbd(fb)->buffer;
> +	else
> +		uo =3D vmw_framebuffer_to_vfbs(fb)->uo;
> +
> +	return uo;
> +}
> +
> +static enum vmw_cursor_update_type
> +vmw_cursor_update_type(struct vmw_private *vmw, struct vmw_user_object *=
uo)
> +{
> +	struct vmw_surface *surface =3D vmw_user_object_surface(uo);
> =20
>  	if (surface && surface->snooper.image)
>  		return VMW_CURSOR_UPDATE_LEGACY;
> @@ -642,17 +658,10 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *p=
lane,
>  	if (!vmw_user_object_is_null(&vps->uo))
>  		vmw_user_object_unref(&vps->uo);
> =20
> -	if (fb) {
> -		if (vmw_framebuffer_to_vfb(fb)->bo) {
> -			vps->uo.buffer =3D vmw_framebuffer_to_vfbd(fb)->buffer;
> -			vps->uo.surface =3D NULL;
> -		} else {
> -			memcpy(&vps->uo, &vmw_framebuffer_to_vfbs(fb)->uo, sizeof(vps->uo));
> -		}
> -		vmw_user_object_ref(&vps->uo);
> -	}
> +	vps->uo =3D vmw_cursor_plane_user_object(fb);
> +	vmw_user_object_ref(&vps->uo);

If fb =3D=3D NULL then uo =3D 0 and that would cause a null pointer derefer=
ence in vmw_user_object_ref
since it's not doing a null check over there.

> =20
> -	vps->cursor.update_type =3D vmw_cursor_update_type(vmw, vps);
> +	vps->cursor.update_type =3D vmw_cursor_update_type(vmw, &vps->uo);
>  	switch (vps->cursor.update_type) {
>  	case VMW_CURSOR_UPDATE_LEGACY:
>  		surface =3D vmw_user_object_surface(&vps->uo);
> @@ -662,6 +671,9 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *pla=
ne,
>  	case VMW_CURSOR_UPDATE_GB_ONLY:
>  	case VMW_CURSOR_UPDATE_MOB: {
>  		bo =3D vmw_user_object_buffer(&vps->uo);
> +		if (fb && !bo)
> +			return -EINVAL;
> +
>  		if (bo) {
>  			struct ttm_operation_ctx ctx =3D { false, false };
>  			size_t size =3D (size_t)new_state->crtc_w *
> @@ -744,7 +756,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *p=
lane,
>  	int ret =3D 0;
>  	struct drm_crtc_state *crtc_state =3D NULL;
>  	struct vmw_surface *surface =3D NULL;
> -	struct vmw_plane_state *vps =3D vmw_plane_state_to_vps(new_state);
> +	struct vmw_user_object uo;
>  	enum vmw_cursor_update_type update_type;
>  	struct drm_framebuffer *fb =3D new_state->fb;
> =20
> @@ -763,7 +775,21 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *=
plane,
>  	if (!fb)
>  		return 0;
> =20
> -	update_type =3D vmw_cursor_update_type(vmw, vps);
> +	if (!new_state->crtc_w || !new_state->crtc_h) {
> +		drm_dbg_kms(&vmw->drm,
> +			    "Cursor dimensions (%u, %u) must be nonzero\n",
> +			    new_state->crtc_w, new_state->crtc_h);
> +		return -EINVAL;
> +	}
> +
> +	/* The duplicated plane state's user object still belongs to the old FB=
. */
> +	uo =3D vmw_cursor_plane_user_object(fb);
> +	update_type =3D vmw_cursor_update_type(vmw, &uo);
> +	if ((update_type =3D=3D VMW_CURSOR_UPDATE_GB_ONLY ||
> +	     update_type =3D=3D VMW_CURSOR_UPDATE_MOB) &&
> +	    !vmw_user_object_buffer(&uo))
> +		return -EINVAL;
> +
>  	if (update_type =3D=3D VMW_CURSOR_UPDATE_LEGACY) {
>  		if (new_state->crtc_w !=3D VMW_CURSOR_SNOOP_WIDTH ||
>  		    new_state->crtc_h !=3D VMW_CURSOR_SNOOP_HEIGHT) {
> @@ -772,7 +798,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *p=
lane,
>  				 new_state->crtc_w, new_state->crtc_h);
>  			return -EINVAL;
>  		}
> -		surface =3D vmw_user_object_surface(&vps->uo);
> +		surface =3D vmw_user_object_surface(&uo);
>  		if (!surface || !surface->snooper.image) {
>  			drm_warn(&vmw->drm,
>  				 "surface not suitable for cursor\n");
> @@ -789,8 +815,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *p=
lane,
>  					 SVGA_CB_MAX_COMMAND_SIZE -
>  					 sizeof(struct vmw_svga_fifo_cmd_define_cursor));
> =20
> -		if (!new_state->crtc_w || !new_state->crtc_h ||
> -		    new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||

Why remove these checks?

> +		if (new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||
>  		    new_state->crtc_h > SVGA_MAX_CURSOR_CMD_DIMENSION ||
>  		    image_size > max_size) {
>  			drm_dbg_kms(&vmw->drm,


--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

