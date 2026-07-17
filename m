Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72320225791
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307840; cv=none; b=fWWsJ3Hs9Y688pNiqbVMxyAKnyLLFiLOhCGX7BWpwSfgV8pgi9XzJ6P9HbNKry1HtfKYk5nh7dmAbYDElkx/vZgr5oDGPYVqfv2CF0oTpBl6ZNarDsUPXunowwBCkhWzg8nUDyUX4HCwS1cP+vqEJW5i13ddSGBmSGVXTbvKYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307840; c=relaxed/simple;
	bh=9eIOcBtvC6o/UJ6VxEXArpUqEiSaaQf9woRdnZmVAyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfRpK0j9Kqtwmnj31pY1l0ogAF7xAgxUTq7m4PhGfAe/27voPLldF7HQLwkrLar7pYWWQe1hrO5/qZq5Aze8ovJ/jcFVe9qo85Im2GsCSv0v92QKSrtcT3J2Tq0LclB+BwsU9y/zcL2vMhzOhYMwvYVh4FiAAwDlYNnTHbecnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CIWtd5DN; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CIWtd5DN"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5bfaa014978so2665217e0c.3
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784307837; x=1784912637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g+QJXY8MXcqCdgqaL6hKXIE3d7JPVGuOOc9OTwhTDnQ=;
        b=CIWtd5DNGQ7ilWOmEiVHUKoQMDHO2f0LrtQP0eY8/N2ZeMEPZS4gI/MS3IBmP3o0wO
         KI3NhnMCo6hWO6WeOe3ENEtFFHK5hBixMMePXzbstsfUJWUa5dkxLcRvZUlYq1su/+rl
         8ccGNNbz1EZYNcmmFhDL1Kf1xo+EcqkrMxm3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784307837; x=1784912637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g+QJXY8MXcqCdgqaL6hKXIE3d7JPVGuOOc9OTwhTDnQ=;
        b=PPvaV9iSNzWr4nrLTX7pEpzh1+J29KjAAHK7Y9lQlJfEwXMFyHan/txTRBnbuoTnQE
         2qMdHVQo2GGdabOHE1umDitOsvCsFFYlKVopgxmxUqjrWLC052St6uFMJd14vAdP9Cch
         kibTmrxG511OjrL5d8ueW41YoUp+ZNpTnxX6z2r6r8s38PUvZuI4ueTyvRN8NoxofVB5
         NqX+YC46PRvhqfFhxcW/HQFxBykbT0gJE2fHw6MjtQ/LVo1hCKebg6J8mhwSyt4mD0WH
         Ts7z7lmIKqhzYl+6LpD2Rwl8iV44N3ctQJBfakrJH/P5pEWfJtnlJZa4jzPQkSz5tGO7
         fMyA==
X-Forwarded-Encrypted: i=1; AHgh+RrD+8nkzw/PhGnLezKdfsnihOl6OwjDS0ZLFpItk4tHamuf/bcAGDXpW/Tc37Oq0FAa1TwM1Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9gweV4/vsyPM0df40N/GggHZrTnApPUKAuYNTaOR5C1CFb6y8
	MIs6Plkl8iabUyjv2hJkYdj6iuO1GXjXmWW4vxMm9eYmtTDVUtVkISJUtDbGMeLl7QTZykMf04s
	rE/c=
X-Gm-Gg: AfdE7cmFKogAbQV2JqPitJxmuyGYgB6jzD2pFUN/4B7iel5VhL6N+o9wSTBOVwjPCVJ
	1ux3T1+sBDk+jBiHKLAbgvs5Xxzpi2F/RChKCIHUH2lP4R5BfqhG8wv2jW9hdOrseoxcwsj020Y
	JVkMZccGQ8dwgGwlF1pbKX91fX2ahtJnOnh+ZGXq/09JcDrisfoyJI3d5wy3EOm5Lh5YYAuXjFm
	7kgtyjKVP5ah/nIfI64T3GVUS3BG2kOiaq4y4b15EJYA7vopZs0VDER85Uxpr1IKU9AvuX155Ly
	UJh7zhArj0E0E2Ixcz+GAREQZI4CYJAfuRdqwE1nSg4G5T7fzyFnnLJDc/IWoOvqx4FaZ6C3D64
	FX2xGjymCWAVkbYR4stopLWBLsnfvCvQVT+mQk0SW3LwX3xeLF3zpvZmxC97TaLC7Gl/002Eq43
	Ggg8CVumDz8CKWjvrec0Hml20w0NRlFWa67cT4rQa5R869MMCSwEjL924=
X-Received: by 2002:a05:6122:1822:b0:5c1:781:7122 with SMTP id 71dfb90a1353d-5c1b64e8f86mr566450e0c.3.1784307836897;
        Fri, 17 Jul 2026 10:03:56 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c1eecca4f7sm974791e0c.3.2026.07.17.10.03.55
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 10:03:55 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c11f9015d8so1142677e0c.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 10:03:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp07eOe2TmRPX/UqjcgakGFJEL1Xq8/rs+QfAaEqzP2oDH0EUYnpOw4NxT1oB/Nplyfjydp9i8=@vger.kernel.org
X-Received: by 2002:a05:6122:4689:b0:5bd:c52e:5278 with SMTP id
 71dfb90a1353d-5c1b6672a10mr590060e0c.5.1784307834087; Fri, 17 Jul 2026
 10:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717143119.1815106-1-johan@kernel.org> <20260717143119.1815106-2-johan@kernel.org>
In-Reply-To: <20260717143119.1815106-2-johan@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 Jul 2026 10:03:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X33HQcz3atmFzor2oLJzxzcRBJsnsSu_ewErduSxy0gQ@mail.gmail.com>
X-Gm-Features: AUfX_mx8-WoOVhZrSgUBlVvgJVwx2aS4_-6WlhMllLZfKjuDOM4r92VnKp7FzeE
Message-ID: <CAD=FV=X33HQcz3atmFzor2oLJzxzcRBJsnsSu_ewErduSxy0gQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/panel-edp: fix i2c adapter leak on probe failure
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 17, 2026 at 7:32=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> Make sure to drop the i2c adapter reference on probe failure (e.g.
> probe deferral) and on driver unbind also if a devicetree redundantly
> uses the 'ddc-i2c-bus' property to point to the aux ddc bus.
>
> Fixes: cc5a3fc041f0 ("drm/panel: panel-simple: Stash DP AUX bus; allow us=
ing it for DDC")
> Cc: stable@vger.kernel.org      # 5.15
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Link: https://lore.kernel.org/r/CAD=3DFV=3DVZPhzHU+Pet2m3L+Pqc7mOPfZC-f5p=
0OuNL79wNZPxRg@mail.gmail.com
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index aa27d6cd932e..ac815729aa83 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -831,6 +831,13 @@ static int generic_edp_panel_probe(struct device *de=
v, struct panel_edp *panel)
>         return 0;
>  }
>
> +static void panel_edp_put_adapter(void *_adap)
> +{
> +       struct i2c_adapter *adap =3D _adap;
> +
> +       put_device(&adap->dev);
> +}
> +
>  static int panel_edp_probe(struct device *dev, const struct panel_desc *=
desc,
>                            struct drm_dp_aux *aux)
>  {
> @@ -878,6 +885,11 @@ static int panel_edp_probe(struct device *dev, const=
 struct panel_desc *desc,
>
>                 if (!panel->ddc)
>                         return -EPROBE_DEFER;
> +
> +               err =3D devm_add_action_or_reset(dev, panel_edp_put_adapt=
er,
> +                                              panel->ddc);
> +               if (err)
> +                       return err;

Yeah, devm makes this so much nicer. Thanks for fixing!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll plan to apply this, probably to drm-misc-next next week. Unless
someone objects, I won't land it -fixes because it's such a corner
case.

-Doug
