Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595974;
	b=AdV5D3zsWKEwsgtQ5HqmxrznP5IZIY4a0svN9wB29jd71aJ7c8gE1c/XvGFuiUz0jtsP
	 4zstN7CC94O4dTfvje2/LYQnjYDdjmMWa68owjPhbjOjrGPRC7o/CmaXxG1JgOBUOb3di
	 eaAfASamOd8T3o0h1ZWG6g5evncIMUF7v/faYccrAI9bqj9lKLyBNACg7R+mgws1tx2OL
	 m8sF2kz12W+ehI/Wl7X+wca5jfvjWrMr47gmPfchWUzbOPw7pTBpcnKRV27bTwFjwaiKy
	 AyNfSg0b6XkEEQ1j1uFzedX7VqhThV25W+PVeSrLvYo2yIF8ycMQFbnkA7J1hDIVF4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595974;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=swKX6yvknrxvk9A2wRzpAX0JGRz4LkH+nz+ybBYjXJg=;
	b=osB4jJ3SDCrcSi6F89YO1q8WvLqn4Vax+t4oYbqhbA4zvi+/5B9SHasdXseEiH3HMLPf
	 JJQRPGa+AqSzO4IuITS6h/gjkpuvsYjyF2lyNd8E/RMpZe9+ANhRCUEtONHbhkPpju6Q1
	 JiD7q6wNJLg13+mHcHHByj1SVuHQmFmYiL43hPPwn0QV0vBylJb8ApVj4BPStTHnRfVM5
	 2YqW7jQrhIqnd74ngIgj9auLy7gzMfGyYV0hzd43DEMvBp83TG4Y1EPjVHrjp6cNxzWSR
	 tbNz24Xc1RcvqEJZ5a5uc/XU1u4PkQ4S4p52xAkLc+ufEvrZNDxI7bBhzFgQHlRm+BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EMGyggDh;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8860F606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8860F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EMGyggDh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792595973; x=1824131973;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ULpDr1+rUPCdSres7S3dstuiM5d6KmYwt0077EWqOLQ=;
  b=EMGyggDhRZxLaoNoTC2J2CYDE1XnztYGMEYGNlDSR/dyUA7aiEUYvoZt
   DnS8RePNS+8Jmuk35v4BxBXEov8zJsTADbgpbsrkK6D6QqVpgq6UBmM/V
   p873UoO3mKMULzt+zFuRVyMxdcygoMdritVHP0XGMfOLOyA1FLfJbefM9
   b2ExrYwlUn18fBFTza4UrskhP4Zp6VwWmzaKNyAMoBqLlF7xgKymNs7+K
   PiYuJtEqnQxO/+VuQanf+Ng+r83vOOEXbepNfktWNyrcie/adBtyYBMhy
   9AtkC9HnDEm6t8Pq8e3G+iDg4j7pKkQwEqJYt3/v4liPu8fjAFLbyolEX
   g==;
X-CSE-ConnectionGUID: cVOFtGJZTK2twhSGWgh7MA==
X-CSE-MsgGUID: p8s+6pxpTD+JbgtMamfaDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1305759"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1305759"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:19:33 -0700
X-CSE-ConnectionGUID: 5fpXuWE+ThWdE7/v2i2BZA==
X-CSE-MsgGUID: KvadopIeRXiVF02RcDjrng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3127372"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO [10.245.245.16]) ([10.245.245.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:19:31 -0700
Message-ID: <871b54cbf3d6ac1937891e57a8353d00ca740ca4.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Don't fail runtime suspend permanently on VRAM
 eviction -ENOMEM
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost
	 <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org
Date: Wed, 21 Oct 2026 17:19:29 +0200
In-Reply-To: <atfMwPZB4l01xna5@intel.com>
References: <20261020100545.46715-1-thomas.hellstrom@linux.intel.com>
	 <atduGDrVk7kc-PPe@intel.com> <ateSC6dTa0M3Qc8n@gsse-cloud1.jf.intel.com>
	 <atfMwPZB4l01xna5@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-10-20 at 16:19 -0400, Rodrigo Vivi wrote:
> On Tue, Oct 20, 2026 at 09:08:43AM -0700, Matthew Brost wrote:
> > On Tue, Oct 20, 2026 at 09:35:20AM -0400, Rodrigo Vivi wrote:
> > > On Tue, Oct 20, 2026 at 12:05:45PM +0200, Thomas Hellstr=C3=B6m wrote=
:
> > > > If evicting VRAM to system memory fails with -ENOMEM during
> > > > runtime
> > > > suspend to D3cold, the error is returned to the runtime PM
> > > > core.
> > > > Runtime PM treats any error other than -EAGAIN or -EBUSY from
> > > > the
> > > > ->runtime_suspend() callback as fatal, records it in
> > > > dev->power.runtime_error, and refuses further runtime PM
> > > > operations
> > > > on the device until the error is cleared.
> > >=20
> > > oh!
> > >=20
> >=20
> > I'm poked around core PM code but had a hard time verifying the
> > above
> > claim is correct.
> >=20
> > Any code references to help me verify this is correct?
>=20
> drivers/base/power/runtime.c
> rpm_callback()
>=20
> if (retval !=3D -EAGAIN && retval !=3D -EBUSY)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dev->power.runtime_error =3D retval;
>=20
> that prevents new calls while this is not cleared.

This patch needs a prereq change, since if we return -ENOMEM, there's
nothing that drops any allocated backup for pinned bos.

So will hold off this patch for a while since it increases the
likelyhood that this will happen.

/Thomas


>=20
> >=20
> > Matt
> >=20
> > > >=20
> > > > Memory shortage is a transient condition, and with eviction now
> > > > using
> > > > __GFP_RETRY_MAYFAIL it is also more likely to occur. Convert -
> > > > ENOMEM
> > > > from the eviction to -EAGAIN so that the device stays active
> > > > and
> > > > runtime suspend is retried at a later idle transition.
> > > >=20
> > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for
> > > > Intel GPUs")
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > Cc: intel-xe@lists.freedesktop.org
> > > > Cc: <stable@vger.kernel.org> # v6.8+
> > > > Assisted-by: LLM
> > > > Signed-off-by: Thomas Hellstr=C3=B6m
> > > > <thomas.hellstrom@linux.intel.com>
> > > > ---
> > > > =C2=A0drivers/gpu/drm/xe/xe_pm.c | 10 +++++++++-
> > > > =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/xe/xe_pm.c
> > > > b/drivers/gpu/drm/xe/xe_pm.c
> > > > index daa7ba2df317..9bf57ed1ea59 100644
> > > > --- a/drivers/gpu/drm/xe/xe_pm.c
> > > > +++ b/drivers/gpu/drm/xe/xe_pm.c
> > > > @@ -649,8 +649,16 @@ int xe_pm_runtime_suspend(struct xe_device
> > > > *xe)
> > > > =C2=A0
> > > > =C2=A0	if (xe->d3cold.allowed) {
> > > > =C2=A0		err =3D xe_bo_evict_all(xe);
> > > > -		if (err)
> > > > +		if (err) {
> > > > +			/*
> > > > +			 * Runtime PM treats errors other than
> > > > -EAGAIN and
> > > > +			 * -EBUSY as fatal, so report memory
> > > > shortage as
> > > > +			 * transient to allow a later retry.
> > > > +			 */
> > > > +			if (err =3D=3D -ENOMEM)
> > > > +				err =3D -EAGAIN;
> > >=20
> > > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > >=20
> > > > =C2=A0			goto out_resume;
> > > > +		}
> > > > =C2=A0	}
> > > > =C2=A0
> > > > =C2=A0	for_each_gt(gt, xe, id) {
> > > > --=20
> > > > 2.56.0
> > > >=20
