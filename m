Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D41223815B
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 05:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788844647; cv=pass; b=GwshqSq2mVE/vqcN/+EyZ6JWArU6ztF2tCsvbPIwKNnDaxHh+XtEvo8T+ubpEHgf7BjBMg3AIlQsV17JbUTCMNvS3mQDEjHJfABdgTRLh7LxByexZhV1qZnIvicSDQ2SjY5PhGN5xDBhCyjxYSFRU0siGJ4afCWXdUHqFewOqDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788844647; c=relaxed/simple;
	bh=jj8iZbJ39WK9flKdG5MjPLxzl/UYfk7onXSn9gYx1lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Exf2DB8y5IcFBJOkNrz/qsPphVEdDWUSYwdh3ciU5JK9MHbiwBzUz1oXV2RHle5FBXzsXt/fS9dRwnWo+k5YjFJ6L7SfSkwg1S8QIIF8D9k7oiYaRL/TNB+Kx/XNR1Hpzr9bTbGnirL9HmaLQ5TubJbAzx3RWtZIN2ZvJpCu9ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j8WkMTuH; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j8WkMTuH"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66d9f9d8384so1199921d50.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 22:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788844645; cv=none;
        d=google.com; s=arc-20260327;
        b=H7TBkS/++vi/3pTRVXXMR16tsHMWnoyM3dtcZfSWEiiO+X4BC3fc2L23rHwEAnEyMD
         9X7YoofEAeVOEAbxE4Yo/S7Dcm5OaF1a5yiqrWg2K4U4WJ4wOB00T8tMNPf4sQ1gC243
         bwBuoXHPxeNkLKgjNTetayD9iKF5bY9bptFxX8sxiTIKlbJeL52XZ1UOIu1PBg6KiF0x
         +8glWnzCeLCOqba9s2+Wfufp194KJEonf2C5p5ZO3Gkrbz7i9Y3cPgWSkgZcQHl53Eoj
         6sBA4F7rD12vBhRZOkWgc+kLjb+q2kvWsxLHXG7H6iAtZDMnLlCpgehvglul+47mHioC
         d2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7FCFgCrO8nYxa4w36rz8tfzjeCQplkAjHhgkmQ0tkA8=;
        fh=sfqXgOVZkPsWcLnSuu6DIE8GrVTxr0bWX4g9a/cxN5g=;
        b=SWi4hX/e4nqZVYwstoeT6wIYp0ko4Vfgpr4ZyNqCUMjwgmnogRNXrJczQzWoLKZTAT
         mnjSP+VbR5P+A5EG2N02eaTm81p/8l4f8VQ7rRXwKc/fMF49rVHK/h+OUMWgtNLeyXmD
         i9UUbgQSTmi5tAVzqAhiwJVIqxrGdYlNRBjx1nr750pZG05csnklvMdHqhCeDgtEhOMz
         zwcD/cSmz8W/Dz1l5qIdv+f8Wc/DxqILwMD0yjvMM+aSf7AJf2f4oHMiABZKT6MloZYX
         gU3t2DvaNxRsrEbTIri2NpHgrWyM2swqDauwFq+AaSDPcfPD5sh86PiEdRebBZEFBXKj
         y0hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788844645; x=1789449445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7FCFgCrO8nYxa4w36rz8tfzjeCQplkAjHhgkmQ0tkA8=;
        b=j8WkMTuHaZLXUR9ejUNzFG6MGQWCzM3SubBbWCGnb5P+ZZ+6NLcnxxmtEr47Emgtpi
         RycBnQ11/a4M0LsCPadrX1kHSmKOglXrV2xSSF5f1XTKn775nkyfI7S+pE7KxVXZvcMe
         uHf4OY5AlZtvOwPT2kz73WM0bmkFc9/t/ov9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788844645; x=1789449445;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7FCFgCrO8nYxa4w36rz8tfzjeCQplkAjHhgkmQ0tkA8=;
        b=hh6IlkYkFXd+/36R1vd/oOcfS0gT9SOgFhllxT/Q3uiycpHTeu/nomZ09bKl+l9MEj
         OW/gAB+20dLPFNQmEyKS0O9JpnKmVid/uiSS97icYOCZS9NkEVV+QrFd3NNQaSJ3w8lD
         hYTT5x7dip6GWPBOJxtB+irbHRGIkZ3RfRnrRFGJLCD337RJsnhEdBKtCbHk9R3v95Sk
         EcLrbsLLj9Stquq43d6epT7YkCnOUMsZsopaDLSZvR8FJUHGy1IQ5E0AAL7ilG2eixtF
         nc0rxSq1hBqAbA3jPDgN/k/fjonm1uuMiX/iTwwvkII2/CFJju9xlkgY2Li25Pxm1pjh
         gbSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDvjNmocZH1tGb8Bve6d5sjI+dTLpQy0zLyx5cZ/6G+fCkSkjRqye44LRFPBVYLRLZn8lSSF4=@vger.kernel.org
X-Gm-Message-State: AFuF++n0l4vkq6iTkiaP7J47rcWHPjsD1VUR83uuuIxeczes2b8XUPU1
	OSX8GkusfwJMPYSse48Ro3fn5gHVxere+NeCCdBEDeOCJF/g2THx57Fz8pFckjWzwEd3YKEMfjr
	YXLwYh72hUW56kNQy04U4ys7rkcBVTKsKTGJm37Xp
X-Gm-Gg: AYBFou0byRnyxTkJldKBw7xnvPIiWLw1MQflHKW7WQxjX62xse4eHoBE2nuMIsnwhqx
	Izs9UzY1qCKQX5RnGk7VDXLbVhUAMVlcATJpObl3B1MstOzvyrDwfW0h+F3Q7BxUCNptSPAVUWd
	LR1vBYo7EK6cygzZY+LTqDNnhBh9SSiOFVYbn6tGcU00WfLw6w0FHeg2TrKHmqV8KT2CnNu+quq
	4pZEWTjsokCeLv9jqTsLc6cQRLYEjyw0g7eoIwP8xk0AIsnetFUI4vvpJUI6KPdVnMWRAmB6NNQ
	qlpG5nMl8EgjIqhmU/A8fHy5PREFXcfSWbmA+2vFCwwOiLg6tcOsoirCLWD1vCiY23FJj5REWZg
	=
X-Received: by 2002:a05:690e:d49:b0:66f:c1bc:87db with SMTP id
 956f58d0204a3-66fc1bc8991mr4871587d50.52.1788844645029; Mon, 07 Sep 2026
 22:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908050229.754977-1-wenst@chromium.org>
In-Reply-To: <20260908050229.754977-1-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 8 Sep 2026 13:17:13 +0800
X-Gm-Features: AcwNN1UvbZam4KMBF7rri3O2usHHuyHcUFKj6A3hEX1XxQedM-d5CJUALYS2SIM
Message-ID: <CAGXv+5FjHY36sHc+osF2ENjpz9Y97WDCzFEE0c+unXtyxR23Dw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/sun4i: Align VI buffer addresses for subsampled formats
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 1:02=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> Commit 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to
> get display memory") dropped the code to calculate the framebuffer's DMA
> address in favor of drm_fb_dma_get_gem_addr().
>
> This turned out to be wrong in a couple ways. The hardware can handle
> pixel offsets within a sub-sampling block, but the buffer address must
> start at the beginning of the subsampled block for all planes. The
> hardware then does the interpolation internally. However the helper
> gives the address exact pixel for luma, which messes up the result.
>
> Instead of reverting the commit, calculate the intra-block offset and
> adjust the buffer address so that it points to the start of the block.
>
> Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to=
 get display memory")
> Cc: <stable@vger.kernel.org> # 7.1+
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Please ignore this one. As Sashiko pointed out, this could underflow the
buffer address.

Instead this should be sent along with another fix I have that switches
this back to the clipped buffer address.


Sorry for the noise.

> ---
> This is an alternative to Jernej's original revert:
> https://lore.kernel.org/all/3980ea1aeb3f7fe8b4700e36560deeba3d050664.1785=
772659.git.jernej.skrabec@gmail.com/
> ---
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> index 2e9cda45c04e..185e9e5211c1 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -207,6 +207,20 @@ static void sun8i_vi_layer_update_buffer(struct sun8=
i_layer *layer,
>                 /* Get the start of the displayed memory */
>                 dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, i);
>
> +               /*
> +                * The mixer can handle odd offsets into sub-sampled YUV
> +                * planes, but needs the address of the first pixel in ea=
ch
> +                * sub-sampled block. Adjust the luma buffer address back=
wards.
> +                */
> +               if (i =3D=3D 0) {
> +                       u32 x_diff, y_diff;
> +
> +                       x_diff =3D (state->src.x1 >> 16) & (format->hsub =
- 1);
> +                       y_diff =3D (state->src.y1 >> 16) & (format->vsub =
- 1);
> +                       dma_addr -=3D y_diff * fb->pitches[i];
> +                       dma_addr -=3D x_diff * format->cpp[i];
> +               }
> +
>                 /* Set the line width */
>                 DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
>                                  i + 1, fb->pitches[i]);
> --
> 2.55.0.979.g7e5102b832-goog
>
