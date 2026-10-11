Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECA2D322E
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791727512; cv=none; b=ISVJiQo/qj0PuX02P4x5OeWT2sagdgDkbpSr1OLS7THSUEm8sLqOjdzpddh0ZKANZa5F9FI/rQyIuWW9ptdxmFrJOGdi+Jzx3eJflRWFnFRHB053OJJBtk/lNEoSe4+Wfc9kY7g0fUzSUTt1geTsPx1zKaVQ1RhaARhCjyOHvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791727512; c=relaxed/simple;
	bh=fQ9Ibb9CSEZ+PULJZ5/JG8cuLLIX7zkWI0/u7tQJH/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiaDGrfq8WIX8FO7o7zEEvjsaAfJ6FprDHKvyWi+TZ8jsyePdfCcETLKVOBQS99moUlJlds1FuYXwARxL6aIh6msXRhtsegF6PVeuwSstNOMzgOnqllqoGx6FMJcZ4ohjXAMajYf74LCbMoYM2JdMUzoNVWTECsMIb73kwp8lXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5n+eCIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5n+eCIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECD51F0089F
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 14:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791727511;
	bh=/ZP9mYgIUz9YMc+23KxEk5KZByJyBE7m+dN+yOiaTi4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A5n+eCIi69zoQuXvSnhBIZ9aC63O+JFKGaUTOdc+TTU5juSfBG5RSKT3c4rQ2Ri+Y
	 gZfaAq0vuypFVJCSSgzGDEw/h9hQULGq0GEssJu8Qs4ap4aj5SxdSY1hDDm0MXlWr7
	 5bL0lt43aSVerpBE8RqSZ5cyqTVEoHgp7XXIxxUhopFy+EHeCMRgGaMSjmVRgM903R
	 7sdPHS5OncIz5DE7tMXr/bV/S3o04NTbLr7qhSOp4ylztl9196oQ7R1keXoftB7jXU
	 1FyvXwZl3QTM9PUZ2PvU7eg/YJj9M0u2Y31dpIBGG4CV3venPal8goYCdHqckZAosZ
	 nxlXtuF348bZw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1ab2ad719so661637a12.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 07:05:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzdEd9vj5rhLzlYCdx92mFj81ehovPVWyVEpERBRjI2KtpjqwpOzvcF1ELyKo0miVDiHXPMkNQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkTl+WNE8EotW5wACrKeuDJL9tf2gk4ES8/QeY/o11T89HQ+Fb
	zlTw6exSPox1wFTKW69Ter0FZnEphfUohu8B4tTciKMCPHYFDPwanzWMEUgAsYxo2QNlhs5Xq6P
	pPKv/EpZM3T+l/cHKzCnPVgw2BFvCJ7I=
X-Received: by 2002:a05:6402:c518:10b0:6aa:1112:62f2 with SMTP id
 4fb4d7f45d1cf-6b17c2759c5mr4536370a12.15.1791727509987; Sun, 11 Oct 2026
 07:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
In-Reply-To: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 11 Oct 2026 22:05:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4w6SN7GU-sYQerr7rkdD9vesJ=h24jEQHDxczeB0YU1A@mail.gmail.com>
X-Gm-Features: AclHuK_wkl41GPKJI7ip6m3noq5nnGLcBVVPh9hjqmLS-fvueKzuBAPhXPgohI4
Message-ID: <CAAhV-H4w6SN7GU-sYQerr7rkdD9vesJ=h24jEQHDxczeB0YU1A@mail.gmail.com>
Subject: Re: [PATCH] drm/loongson: Fix framebuffer selection in async cursor updates
To: Evanshenf <archwse@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Jianmin Lv <lvjianmin@loongson.cn>, 
	Qianhai Wu <wuqianhai@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
	Icenowy Zheng <zhengxingda@iscas.ac.cn>, Sui Jingfeng <suijingfeng@loongson.cn>, 
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 5:00=E2=80=AFPM Evanshenf <archwse@gmail.com> wrote:
>
> An asynchronous cursor update swaps the new framebuffer into the live
> plane state. However, the driver reads both old_fb and new_fb from the
> live state before this swap. When an enabled cursor changes buffers, the
> address-update condition is therefore false and the hardware continues
> scanning the previous buffer.
>
> Read new_fb from the new plane state before swapping the framebuffer
> references. This updates the hardware address when the framebuffer
> changes while retaining the existing behavior for cursor movement.
>
> Verified on a Loongson 3A5000 with LS7A2000 using 32x32 and 64x64 legacy
> cursor updates. Callback counters and read-only register observations
> confirmed the asynchronous path, the stale address before the change,
> and the new address afterward. Same-framebuffer movement and cursor
> disable/re-enable also passed, with the primary framebuffer and mode
> unchanged.
>
> AI assistance was used to investigate the existing report, prepare the
> fix and test tools, run the build and hardware comparison, and draft
> this message.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202311152357.4KFS0M8f-lkp@intel.com/
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller=
")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

> Signed-off-by: Evanshenf <archwse@gmail.com>
> ---
>  drivers/gpu/drm/loongson/lsdc_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loon=
gson/lsdc_plane.c
> index bcc0ffa..7b9c65c 100644
> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
> @@ -230,7 +230,7 @@ static void lsdc_cursor_plane_atomic_async_update(str=
uct drm_plane *plane,
>
>         new_state =3D drm_atomic_get_new_plane_state(state, plane);
>
> -       new_fb =3D plane->state->fb;
> +       new_fb =3D new_state->fb;
>
>         plane->state->crtc_x =3D new_state->crtc_x;
>         plane->state->crtc_y =3D new_state->crtc_y;
>
> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
> --
> 2.43.0
>
