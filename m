Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DB40B373;
	Tue, 30 Jun 2026 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823502; cv=none; b=RZbH5pVy/deU/OlG7AFTU/PwVMrG610Towk4mo2wyOYjIro4QER76oCETg1T8HAqWG1tXl0Ka5ZPE76RyM06Z78iOVRJCdI9DzpsPS9GfK1QG12uqvFu5ogXWqUhN6laAhOxuas/Vrcy0awGF+f5LaS8tqokqhZ9RnnXWik60xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823502; c=relaxed/simple;
	bh=KKACRXQZhsiDWWLj/rMFRa/87esydj9Xg7Yma54m+yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD+NaYOaygguC2ame9OdQNHvOwVL6995xx7okKa1NNqW9/RYOj05jTmvyUCOkiOwfARvLeU/zGqN3ltsh2OHu5ffdpI/OZCPm2NH3alAdJJaIBkvo5b3I7L+0TMNirhEiqgzE4KJxVB6RgHjydA54B/UaNuopYcmGTKbVQA4wKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSHhCBBt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSHhCBBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A121F000E9;
	Tue, 30 Jun 2026 12:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823500;
	bh=3etnQMaNI9cDXzghRzwp6TlyMNWA45ZiTp4d3lUrh6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SSHhCBBtvN42FvZiNT3iAnPAv3UTSbRymlsVQy176+C5FqznMebOX0yU5aY8uHbur
	 O5uxetQoz1++HiSgJOYSwp/3CsBBHQE3hzJjBrjEQoJZe/LRFKODDXakSat3g0hYJY
	 5pdGNx0li1gwpAxtIj4CE8vf0J3GiKMKCZsJOlJZb30B0AHQyLKX49R1MAb7XEjIZr
	 T+X6MECDq2YraaSovUObSV0S1mnobr6xPzzcBgfafl4ozBtjVWzLGzcOph3lNZlupn
	 Yj4fh5ZdilzxPYIoc7LTd9Q0bRzWXPtGB36f4h2WWVtrhnINC5Dn3w9p8jMQmII+3I
	 ++xkY0qz0ZATQ==
Date: Tue, 30 Jun 2026 14:44:58 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Paul Kocialkowski <paulk@sys-base.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jason Xiang <jx@jasonxiang.net>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/logicvc: Avoid using DRM resources after
 device is unplugged
Message-ID: <20260630-sassy-gecko-of-unity-3a854d@houat>
References: <20260630-logicvc-uaf-v2-0-99e881833860@bootlin.com>
 <20260630-logicvc-uaf-v2-2-99e881833860@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="o36kjz5hklwpkjcs"
Content-Disposition: inline
In-Reply-To: <20260630-logicvc-uaf-v2-2-99e881833860@bootlin.com>


--o36kjz5hklwpkjcs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] drm/logicvc: Avoid using DRM resources after
 device is unplugged
MIME-Version: 1.0

On Tue, Jun 30, 2026 at 11:10:11AM +0200, Romain Gantois wrote:
> Some DRM resources such as plane, CRTC or encoder objects could remain in
> use after the DRM device is removed. Use the drm_dev_enter/exit() mechani=
sm
> to ensure that the DRM device is not unplugged before using its resources.
>=20
> Fixes: efeeaefe9be56 ("drm: Add support for the LogiCVC display controlle=
r")                                                                        =
=E2=94=82
> Cc: stable@vger.kernel.org
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  drivers/gpu/drm/logicvc/logicvc_crtc.c      | 35 ++++++++++++++++-----
>  drivers/gpu/drm/logicvc/logicvc_drm.c       |  9 +++++-
>  drivers/gpu/drm/logicvc/logicvc_interface.c | 12 ++++++++
>  drivers/gpu/drm/logicvc/logicvc_layer.c     | 48 ++++++++++++++++++++---=
------
>  4 files changed, 81 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/logicvc/logicvc_crtc.c b/drivers/gpu/drm/log=
icvc/logicvc_crtc.c
> index 3a4c347eaa648..f3a224a883b2f 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_crtc.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_crtc.c
> @@ -40,10 +40,15 @@ static void logicvc_crtc_atomic_begin(struct drm_crtc=
 *drm_crtc,
>  				      struct drm_atomic_state *state)
>  {
>  	struct logicvc_crtc *crtc =3D logicvc_crtc(drm_crtc);
> -	struct drm_crtc_state *old_state =3D
> -		drm_atomic_get_old_crtc_state(state, drm_crtc);
>  	struct drm_device *drm_dev =3D drm_crtc->dev;
> +	struct drm_crtc_state *old_state;
>  	unsigned long flags;
> +	int idx;
> +
> +	if (!drm_dev_enter(drm_dev, &idx))
> +		return;
> +
> +	old_state =3D drm_atomic_get_old_crtc_state(state, drm_crtc);

You don't have to move the state around here, the states are always safe
to access in the atomic callbacks.

>  	/*
>  	 * We need to grab the pending event here if vblank was already enabled
> @@ -58,6 +63,8 @@ static void logicvc_crtc_atomic_begin(struct drm_crtc *=
drm_crtc,
> =20
>  		spin_unlock_irqrestore(&drm_dev->event_lock, flags);
>  	}
> +
> +	drm_dev_exit(idx);

Only the device resources (ie, clocks, registers, etc. ) need to be
guarded. Any DRM facing resource can still used, and the vblank here
should still be signalled.

>  }
> =20
>  static void logicvc_crtc_atomic_enable(struct drm_crtc *drm_crtc,
> @@ -65,17 +72,23 @@ static void logicvc_crtc_atomic_enable(struct drm_crt=
c *drm_crtc,
>  {
>  	struct logicvc_crtc *crtc =3D logicvc_crtc(drm_crtc);
>  	struct logicvc_drm *logicvc =3D logicvc_drm(drm_crtc->dev);
> -	struct drm_crtc_state *old_state =3D
> -		drm_atomic_get_old_crtc_state(state, drm_crtc);
> -	struct drm_crtc_state *new_state =3D
> -		drm_atomic_get_new_crtc_state(state, drm_crtc);
> -	struct drm_display_mode *mode =3D &new_state->adjusted_mode;
> =20
>  	struct drm_device *drm_dev =3D drm_crtc->dev;
> +	struct drm_crtc_state *old_state;
> +	struct drm_crtc_state *new_state;
>  	unsigned int hact, hfp, hsl, hbp;
>  	unsigned int vact, vfp, vsl, vbp;
> +	struct drm_display_mode *mode;
>  	unsigned long flags;
>  	u32 ctrl;
> +	int idx;
> +
> +	if (!drm_dev_enter(drm_dev, &idx))
> +		return;
> +
> +	old_state =3D drm_atomic_get_old_crtc_state(state, drm_crtc);
> +	new_state =3D drm_atomic_get_new_crtc_state(state, drm_crtc);
> +	mode =3D &new_state->adjusted_mode;
> =20
>  	/* Timings */
> =20
> @@ -148,6 +161,8 @@ static void logicvc_crtc_atomic_enable(struct drm_crt=
c *drm_crtc,
>  		drm_crtc->state->event =3D NULL;
>  		spin_unlock_irqrestore(&drm_dev->event_lock, flags);
>  	}
> +
> +	drm_dev_exit(idx);
>  }
> =20
>  static void logicvc_crtc_atomic_disable(struct drm_crtc *drm_crtc,
> @@ -155,6 +170,10 @@ static void logicvc_crtc_atomic_disable(struct drm_c=
rtc *drm_crtc,
>  {
>  	struct logicvc_drm *logicvc =3D logicvc_drm(drm_crtc->dev);
>  	struct drm_device *drm_dev =3D drm_crtc->dev;
> +	int idx;
> +
> +	if (!drm_dev_enter(drm_dev, &idx))
> +		return;
> =20
>  	drm_crtc_vblank_off(drm_crtc);
> =20
> @@ -180,6 +199,8 @@ static void logicvc_crtc_atomic_disable(struct drm_cr=
tc *drm_crtc,
>  		drm_crtc->state->event =3D NULL;
>  		spin_unlock_irq(&drm_dev->event_lock);
>  	}
> +
> +	drm_dev_exit(idx);
>  }
> =20
>  static const struct drm_crtc_helper_funcs logicvc_crtc_helper_funcs =3D {
> diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logi=
cvc/logicvc_drm.c
> index bbebf4fc7f51a..2112646386e36 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_drm.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
> @@ -71,6 +71,7 @@ static irqreturn_t logicvc_drm_irq_handler(int irq, voi=
d *data)
>  	struct logicvc_drm *logicvc =3D data;
>  	irqreturn_t ret =3D IRQ_NONE;
>  	u32 stat =3D 0;
> +	int idx;
> =20
>  	/* Get pending interrupt sources. */
>  	regmap_read(logicvc->regmap, LOGICVC_INT_STAT_REG, &stat);

strictly speaking, that regmap read here should be protected, but it's
not going to be executed after remove anyway because the interrupt
handler will be deregistered, so you don't have to bother here.

[...]

>  static void logicvc_plane_atomic_disable(struct drm_plane *drm_plane,
> @@ -239,6 +255,8 @@ static void logicvc_plane_atomic_disable(struct drm_p=
lane *drm_plane,
>  	struct logicvc_drm *logicvc =3D logicvc_drm(drm_plane->dev);
>  	u32 index =3D layer->index;
> =20
> +	/* No need for drm_dev_enter() here. The regmap outlives the DRM device=
=2E */
> +
>  	regmap_write(logicvc->regmap, LOGICVC_LAYER_CTRL_REG(index), 0);

No it doesn't? It's a devm allocated regmap, it's going to be destroyed
at remove. The DRM device will stick around after remove for as long as
there's a userspace application with a fd to it, so the DRM device far
outlives the regmap (and you end up with a dangling pointer to the regmap)

Maxime

--o36kjz5hklwpkjcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCakO6QwAKCRAnX84Zoj2+
djmkAYDRKIz00t1Jue/0Pw75Ux63vDgzK6jvhQIld8ONCKpBneDyXKXClsUZqxY+
fRE4ELIBf0nG8Fp07gkBeln58vXnHFpyJSb5uTdhFRAmqEOwMTtBYbXdx9gIo2px
hzhcua3Xng==
=xAIg
-----END PGP SIGNATURE-----

--o36kjz5hklwpkjcs--
