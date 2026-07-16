Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99A332B130
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784181156; cv=none; b=Fl6KByoG9siErCgRhVoDVZvv35JU/jzoZzq9e9dJ0SQaW12bsMweIy01ZbwyYMvZ/R02d1tsqCP4G9KEsVqZEL4sbbRtG6E1buRj8GsOUjCMCL/3r1SMv9pDw287lAYFlynILVgL0Znq0dZ/+s0jeZtLDkTd00PdcA9Ss8P6TOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784181156; c=relaxed/simple;
	bh=F1QWL+Uy/2SekYk7UEHLqA2CChAnmU31D56neYR4pik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ETRf93tda65V55l1sJXriX/I1qr9fLd4Qt1jMXD/Rz/+cEvNiK6Y6dv72qO3PDHCr8nC0tQx8UK0R11OZTfix8tGH+Me0JPZn2eZs6liwyTNC/qEzEQr8LlptAuXj7+TI6nrFJawSHivo1UTc0rv9FvBv5a4TcvE2r8Favqc4z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=a+WOtlnz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="a+WOtlnz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:From:Reply-To;
	bh=3M4YGqP3JjfbtrMorVGNcv30iBQZHSl4SVkOaUbstLw=; b=a+WOtlnzOsXkdJJyN18Zy7JnLc
	pSO3GPSESBJvGbyrHlw3BTKPJjbfLHfL/YC+PbkIYpQwaDlwe7ZJWaG0/FxkmQMewUi/zKESlaI4o
	VpuJrlg1gT40dQyBfF6PnzIO0mkVdZ/cn613P85i04ewQXn5JIZGwNT0xdzvgujvusNGG7Qx2c5t/
	S11wR3t7C8OAm7z4h6OqmWvK7Xb3IFI0SiUTYJChnPy68K/KTdIjalluZWCvwf754iy6MN5mZ5GEG
	nc/YzUKIctnNf8ID6N7X6jhYlcrBHdUiz13jwJ1xkj9JKqncWSABhqsLypGx6OZ6SWJRpTfVbuMla
	uy3ool4A==;
Received: from [192.168.12.229]
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wkF1G-00FlmP-RG; Thu, 16 Jul 2026 07:52:26 +0200
Message-ID: <a43ba189b507567e8ddd3d958859c14334356c2d.camel@igalia.com>
Subject: Re: [PATCH] drm/v3d: Widen cache_clean_lock over the whole L2TCACTL
 sequence
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
	 <mwen@igalia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
	 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
	stable@vger.kernel.org
Date: Thu, 16 Jul 2026 07:52:26 +0200
In-Reply-To: <f51d745c-c383-4d19-ac51-af9c69a83ba8@igalia.com>
References: <20260707200738.659002-2-mcanal@igalia.com>
	 <e65137e19a8773a2f760531034481e0df60071d4.camel@igalia.com>
	 <f51d745c-c383-4d19-ac51-af9c69a83ba8@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks, if we don't see any impact on performance on Pi5, this is:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>


El mi=C3=A9, 15-07-2026 a las 10:46 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> Hi Iago,
>=20
> On 15/07/26 03:16, Iago Toral wrote:
> > Hi Ma=C3=ADra,
> >=20
> > has this change fixed anything?
>=20
> Not real bug, just the theoretical race-condition between
> v3d_clean_caches() and v3d_flush_l2t().
>=20
> >=20
> > Also, I believe that GFXH-1897 is exclusive to Pi4. Have you tested
> > if
> > this change has any visible performance impact on Pi5?
>=20
> I'll test it, however I don't imagine it would have a impact, as the
> race condition should be rare enough. We would need a CACHE_CLEAN job
> running simultaneously to v3d_invalidate_caches().
>=20
> One thing I believe it might be possible is to skip a flush if a
> flush
> is already happening, but it would be a micro-optimization.
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> >=20
> > Iago
> >=20
> >=20
> > El mar, 07-07-2026 a las 17:05 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> > > v3d_clean_caches() and v3d_flush_l2t() both write the single
> > > L2TCACTL
> > > register and poll its status bits. The mutex cache_clean_lock
> > > exists
> > > to
> > > serialize them, but v3d_clean_caches() only took the lock around
> > > its
> > > final
> > > FLM_CLEAN write.
> > >=20
> > > These functions run concurrently: v3d_flush_l2t() is issued from
> > > the
> > > BIN/RENDER/CSD invalidate path while v3d_clean_caches() runs from
> > > the
> > > CACHE_CLEAN queue, and each queue's scheduler uses its own
> > > ordered
> > > workqueue, so their run_job callbacks execute in parallel.
> > >=20
> > > Because clean locked only its final write, a concurrent flush can
> > > write
> > > L2TCACTL during clean's unlocked phase. Both use non read-modify-
> > > write
> > > writes to the one register, so whichever lands last wins: clean's
> > > TMUWCF
> > > write can land on the flush's in-flight L2TFLS invalidate,
> > > triggering
> > > the
> > > GFXH-1897 hazard of writing L2TCACTL while a flush is pending.
> > >=20
> > > Hold cache_clean_lock across the entire L2TCACTL access sequence
> > > so
> > > it
> > > is fully mutually exclusive with v3d_flush_l2t(), which already
> > > takes
> > > the
> > > lock around its own write.
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Fixes: abf888b03a98 ("drm/v3d: Wait for pending L2T flush before
> > > cleaning caches")
> > > Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/v3d/v3d_gem.c | 5 ++---
> > > =C2=A0=C2=A01 file changed, 2 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/v3d/v3d_gem.c
> > > b/drivers/gpu/drm/v3d/v3d_gem.c
> > > index c43d9af41374..e597b6fd47c4 100644
> > > --- a/drivers/gpu/drm/v3d/v3d_gem.c
> > > +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> > > @@ -204,6 +204,8 @@ v3d_clean_caches(struct v3d_dev *v3d)
> > > =C2=A0=C2=A0	struct drm_device *dev =3D &v3d->drm;
> > > =C2=A0=C2=A0	int core =3D 0;
> > > =C2=A0=20
> > > +	guard(mutex)(&v3d->cache_clean_lock);
> > > +
> > > =C2=A0=C2=A0	trace_v3d_cache_clean_begin(dev);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	/* GFXH-1897: Ensure pending flushes complete before
> > > writing
> > > L2TCACTL */
> > > @@ -220,7 +222,6 @@ v3d_clean_caches(struct v3d_dev *v3d)
> > > =C2=A0=C2=A0		drm_err(dev, "Timeout waiting for TMU write
> > > combiner
> > > flush\n");
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > -	mutex_lock(&v3d->cache_clean_lock);
> > > =C2=A0=C2=A0	V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL,
> > > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 V3D_L2TCACTL_L2TFL=
S |
> > > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 V3D_SET_FIELD(V3D_=
L2TCACTL_FLM_CLEAN,
> > > V3D_L2TCACTL_FLM));
> > > @@ -230,8 +231,6 @@ v3d_clean_caches(struct v3d_dev *v3d)
> > > =C2=A0=C2=A0		drm_err(dev, "Timeout waiting for L2T clean\n");
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > -	mutex_unlock(&v3d->cache_clean_lock);
> > > -
> > > =C2=A0=C2=A0	trace_v3d_cache_clean_end(dev);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> >=20
>=20
>=20

