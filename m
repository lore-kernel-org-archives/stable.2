Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEEA258EC1;
	Mon,  1 Jun 2026 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297886; cv=none; b=SdcKpxN8mUle/Cjuy0D+sR/uHbeaTbzLD+dgN/megYnRpRZvzovRlpdrsFIk/EMAbOZnw/JADj9JI+kudDghupYSsI+fCTBHL2OQxPoJbzt+D02QhXuLKRUImjBrPJnZ9VKjlJR0yfikKThdQ3+cCOdaxjs471njZzxsCHTChEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297886; c=relaxed/simple;
	bh=H17aj6dp4+RqkfWxsMkjE2STWSXHTP7bDRPzFtWRFvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXwkvT7XTjWbC0heXiH9o8WATA1iyO54812M/pNBcMT1BOd1Ih03k7oYqzHaEvrWaBVxsGjLuWTLCXyDBxHBnHl4F2AgI8sf7q2JHpbnpG6ecABUA4qo3Ibfu4XsOBMdHIWDnZg3Hl53VrQvxxBnr7osUT/GITAQtZ0iApNklTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULN6gKvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULN6gKvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376D61F00893;
	Mon,  1 Jun 2026 07:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780297884;
	bh=H17aj6dp4+RqkfWxsMkjE2STWSXHTP7bDRPzFtWRFvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ULN6gKvFCFauR1tYq/Qf0Cg9N09C47mfwmWWIPby/qvj52hcqIwoGLie7Qyjuk7eN
	 zRRZ781t9eoFI0EDtFNVOUWA6zxqNIj7TUoaKj49fA+PoCBo7L0zwLh5VdUE8+oOmU
	 PmKHi3z1bhMwRS0PJG73KTR/NqAn57qWdwwDDp08y4nHJYsju0yOFxf2HLBS2a9+ob
	 E+FiWSVCjVzZeaE6QgB9BdfJxihcMAJORNgWQd+ExmNLn/nLxbzBxFY/9mL6WYDK9X
	 hzwQztU2ULoX9nF5dUZRdCty5O/Nv77jkyoNQj+LDu+cmXIKHNv5m6lGIz40foZF7B
	 eaqNNZLsv+jDQ==
Date: Mon, 1 Jun 2026 09:11:21 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Paul Kocialkowski <paulk@sys-base.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/logicvc: Avoid use-after-free with devm_kzalloc()
Message-ID: <20260601-ultra-wapiti-of-imagination-ba59e8@houat>
References: <20260601-logicvc-uaf-v1-1-8c9ca5b3429c@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="lbqgwgxdtws5js22"
Content-Disposition: inline
In-Reply-To: <20260601-logicvc-uaf-v1-1-8c9ca5b3429c@bootlin.com>


--lbqgwgxdtws5js22
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/logicvc: Avoid use-after-free with devm_kzalloc()
MIME-Version: 1.0

Hi,

On Mon, Jun 01, 2026 at 08:52:44AM +0200, Romain Gantois wrote:
> The logicvc driver calls drm_universal_plane_init(),
> drm_crtc_init_with_planes(), and drm_encoder_alloc(). These functions
> should not be called with structs allocated with devm_kzalloc(), as this
> can lead to use-after-free bugs. In fact, a use-after-free caused by this
> has been observed on a v6.6 kernel.
>=20
> Use DRM-managed allocations instead for panel, CRTC and encoder objects.
>=20
> Found using KASAN.
>=20
> Fixes: efeeaefe9be56 ("drm: Add support for the LogiCVC display controlle=
r")
> Cc: stable@vger.kernel.org
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

You're only partially fixing the issue. You also need to protect any
device resource (register mapping, clocks, etc) are no longer accessed
after the device has been removed, and this is typically done using
drm_dev_enter/exit.

Maxime

--lbqgwgxdtws5js22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCah0wmQAKCRAnX84Zoj2+
dg89AYDWmy2puaE/0V1ioSSd74fzTf4MeiUHmCAPWW/PNSHvcKBjIr0ydZ45hMgv
wjhkMM0BfjR613xm9Qev4KwK9ANZ7uKfa4Jboc95pcuAAXCXO2YvcbeEmDJbRCIC
jvCckEorpQ==
=33cf
-----END PGP SIGNATURE-----

--lbqgwgxdtws5js22--
