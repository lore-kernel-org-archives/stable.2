Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7B26ED3C
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933287; cv=none; b=qqyZcKqaKMzduPJdoC0WtH5HdRyIrcxc/JuSevKsSfNrWt5A1+ko4jXsyyaumKKB2kiuzxdz6UawX6JWGiRMls8Fg3gUd8+ONs1LGobPy+5Zj+Indag/nonzkGKyKCKiffTM9hvZzIYwnr5oj42hqgEefjkoZ9hU/fYWFt7VcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933287; c=relaxed/simple;
	bh=2zzvKccfSmrDmMfysd8h/sLvDfpNw2Iet07BeHZ172Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYy0FMUC21B4rkLCTLQ1DmVKmLHG+y89rxoBTr5KD5MNyGPOZ0Mhs/8AG7zpx/5ZFpJ8TyWihPityS3kWnDhM/WpzOluIU+erbrL+N6u9FRfsOdHcLimPRbI+3RLwiWOz0FpMSDmm5MB3e6L0Cky6D71KDYrRg7ldjCSN3zh9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oheAatLP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oheAatLP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E3ABC4E40B93;
	Mon,  8 Jun 2026 15:41:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB9BD5FFB7;
	Mon,  8 Jun 2026 15:41:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED002106A2737;
	Mon,  8 Jun 2026 17:41:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780933281; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yGOnMqKJMw/ydQNQDFBMggWDghRXv4f0XxOD1sItqDU=;
	b=oheAatLPbXPnsFhCVuN0kS9KdyeOpnw+JH0MvQdS289veqEd9jXAQAhjsK4aW14GPiDr8q
	jlL+JiVVjDkQV4AsGR5Cmz2zg2JSPjnyE5zeI5ncskmvIx6aQ658N5+7hm+rOEYrrMisVJ
	wjefiv6Q9Y3FQzftbL4KUJ1crv0YAB2nLvaKeRywrSBiC+ntn/KGAvB22D5+WoL+oQFspC
	WjTV7KUmc0nIbuYISnn6Bz6ebR5DOdJzDXD6K3ftCCuIrMdBTxj3wVNus9r5eHshNv25EZ
	ZBV6CiDX7+FUnHaYVF6xGfh+D3uXErjVMilYsR7ZZ7VOEX4sLXr4M6J98xvtIw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Paul Kocialkowski <paulk@sys-base.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/logicvc: Avoid use-after-free with devm_kzalloc()
Date: Mon, 08 Jun 2026 17:41:11 +0200
Message-ID: <5Q6YIC1WTqOFVMFErYGBEQ@bootlin.com>
In-Reply-To: <20260601-ultra-wapiti-of-imagination-ba59e8@houat>
References:
 <20260601-logicvc-uaf-v1-1-8c9ca5b3429c@bootlin.com>
 <20260601-ultra-wapiti-of-imagination-ba59e8@houat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartuGU-zTcuSqG5rLu8I8MPMg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPartuGU-zTcuSqG5rLu8I8MPMg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] drm/logicvc: Avoid use-after-free with devm_kzalloc()
Date: Mon, 08 Jun 2026 17:41:11 +0200
Message-ID: <5Q6YIC1WTqOFVMFErYGBEQ@bootlin.com>
In-Reply-To: <20260601-ultra-wapiti-of-imagination-ba59e8@houat>
MIME-Version: 1.0

Hi Maxime,

On Monday, 1 June 2026 09:11:21 CEST Maxime Ripard wrote:
> Hi,
> 
> On Mon, Jun 01, 2026 at 08:52:44AM +0200, Romain Gantois wrote:
> > The logicvc driver calls drm_universal_plane_init(),
> > drm_crtc_init_with_planes(), and drm_encoder_alloc(). These functions
> > should not be called with structs allocated with devm_kzalloc(), as this
> > can lead to use-after-free bugs. In fact, a use-after-free caused by this
> > has been observed on a v6.6 kernel.
> > 
> > Use DRM-managed allocations instead for panel, CRTC and encoder objects.
> > 
> > Found using KASAN.
> > 
> > Fixes: efeeaefe9be56 ("drm: Add support for the LogiCVC display
> > controller") Cc: stable@vger.kernel.org
> > Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> 
> You're only partially fixing the issue. You also need to protect any
> device resource (register mapping, clocks, etc) are no longer accessed
> after the device has been removed, and this is typically done using
> drm_dev_enter/exit.

Sorry there's something which I don't quite understand: is this a new issue 
which is specifically introduced by my changes in this series, or a different 
issue in this driver which isn't handled by my series?

IIUC all I'm doing here is just letting the drmm code handle cleaning up the 
plane, crtc, etc. objects instead of doing it "by hand" with devm_kzalloc. Why 
does this make it necessary to add additional protection of driver resources?

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPartuGU-zTcuSqG5rLu8I8MPMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmom4pcACgkQKCYAIARz
eA7+eg/+O47Ty0diNzEC4oWVcVq/SUIL6d6Q8Jdi2zabL+pt8Og8dN76aryWrUgM
vMkF1SkR+F24DI6cilixpB2JcYFY/4hJy760QrPKWFNeTbW8C0Z6z+bqUTdjKCFE
Zu7aqrsHVakLpJlshCSgQ1lvftxP+uK2XQa+3b/FOdfm3uiQKacfNdVWwxqbgy3B
ck8Kw+rGI7ynqS9XmQ2vbcKlvfG1LgVKyessDWXNRsPX7dDbg+KC99epmKQQkuT/
SIx64W9z4q90cCpjJ4EAHOWrFTex9MNYU99xMjvSacSsYZuXLVUw27CdV9N6EAw6
6Waszf///OZ+c6B3Mhr/uB9gqg9h8E0kci5E2kaHVCDl3PnyquJVnbV8wwnKvKsB
GmSWyF1urLDJCIaRmQxs/gA67bEZvZ51wRMuUCTnVkYShGeVTpf5xUdASFQGILsY
5y6XKRl2kOavJVXEB+MlA7GCc8k53xj3BBiAuvUp5YYooOzjSaqMIbzTIOREDCC1
/m7ENYPUnWCHh0z6dgPRR17S6UiLKyNzY0NIVv91JIMGlyOODNbQFTt7TS1Z8HO1
f4121ntjOMukWX2kbJ882R8gGVgma8iDo45ft30BsFm9gm9wHEZsSCkkVi/xOnNM
cBTcldtZmhsX1Ealzr+r8xt0Ofq9rgdCkx1syIGUag7pTovNEvw=
=QlMw
-----END PGP SIGNATURE-----

--nextPartuGU-zTcuSqG5rLu8I8MPMg--



