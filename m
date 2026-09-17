Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD394908DD;
	Thu, 17 Sep 2026 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654200; cv=none; b=ePpHE80UVhVpTEZ3Z/Z7IGcpu88gxaDyOsOe4x1Ep4iF36PxL7mkfx48ScPzlpUE60jNvbOUezhIWf/uPktUqm9cHtiEp31NABWwabDTo1IWyVoTUoUwJ+SzDXYUy9d80DryLJUrm12wLZ6O5W/V4OhOnwwNGBjf13jhgrxn2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654200; c=relaxed/simple;
	bh=fO4fdO6luX52cUZanGqAU9t/YcZ4N1JwmTl9PxIxe4w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ixzDhTkDQM0N/tNL/+sX0GIc7gkhndxLncJvXXsX7lfUlh+Xuc4cIYP4hc73J4GMkBLFHiS4OQeq1YLeMMoZLIw0TFuL6LNi8CMlT7wIq3gzxjrYr/exTO1P5EL2JTURU+kfxwxTBWljYbcbIYxFMSSGzrDzkZqCgoItYTB+v58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQqVC91u; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQqVC91u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789654195; x=1821190195;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fO4fdO6luX52cUZanGqAU9t/YcZ4N1JwmTl9PxIxe4w=;
  b=jQqVC91u2wvbd3qrRotO/Zy4Rrn0qBXMIttsWOiYNI8ZH9Sw4IOxCXCI
   WpI/DVnZqMWWBPP9SscMlo6PC6pxrzsTBBHcHDiZTvkVVEWadupnBVAhE
   WLDjdfNLSN+I20bZW51HbXDAypDG4v7WCquzf5tBNv40+OAplrrt3Uq/n
   I7XA+yhihQ6gv+CpaucoS8rvdrBuizmkXtekiyLOCGTFnZMSjgviW/yfe
   vsnLqNC/XGjMMfIgYwNAHtVbbZBKSzEIM4zSE4Ap1no9z2MmDLojH6uvo
   C3vjqp0L2b0hXUtNnd6euO0aMupJovWj6y+FCcCNasf8AB9ElMYHfAVHL
   A==;
X-CSE-ConnectionGUID: UwD/kigQQX2GR2iX6Uf10Q==
X-CSE-MsgGUID: +qjoiM3QSrmxlVQpTuUgQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90097234"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90097234"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 07:09:47 -0700
X-CSE-ConnectionGUID: ZKJncDdRSHWqAuDEXG5fww==
X-CSE-MsgGUID: j77OhG4dSXG4dvTwmYhurg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270514533"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.62])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 07:09:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 17 Sep 2026 17:09:39 +0300 (EEST)
To: Wentao Liang <vulab@iscas.ac.cn>
cc: Shyam-sundar.S-k@amd.com, Hans de Goede <hansg@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, 
    platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/pmc: Fix RTC device leak in
 amd_pmc_verify_czn_rtc()
In-Reply-To: <f320a056-78a6-c33b-9d75-8298f140283b@linux.intel.com>
Message-ID: <d3bce55c-5eee-36c8-b4c3-4a85e72690fe@linux.intel.com>
References: <20260917135854.2154187-1-vulab@iscas.ac.cn> <f320a056-78a6-c33b-9d75-8298f140283b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-747575916-1789654179=:1179"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-747575916-1789654179=:1179
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 Sep 2026, Ilpo J=E4rvinen wrote:

> On Thu, 17 Sep 2026, Wentao Liang wrote:
>=20
> > rtc_class_open() takes a reference to the RTC device, but all paths
> > that return after it succeeded, apart from the final one where the
> > alarm is programmed, leave the function without dropping it. Route
> > them through a common exit that calls rtc_class_close().
> >=20
> > Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for t=
imer based S0i3 wakeup")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > ---
> >  drivers/platform/x86/amd/pmc/pmc.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/=
amd/pmc/pmc.c
> > index cae3fcafd4d7..f40e8d9b124a 100644
> > --- a/drivers/platform/x86/amd/pmc/pmc.c
> > +++ b/drivers/platform/x86/amd/pmc/pmc.c
> > @@ -569,32 +569,39 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_=
dev *pdev, u32 *arg)
> >  =09=09return 0;
> >  =09rc =3D rtc_read_alarm(rtc_device, &alarm);
> >  =09if (rc)
> > -=09=09return rc;
> > +=09=09goto out;
> >  =09if (!alarm.enabled) {
> >  =09=09dev_dbg(pdev->dev, "alarm not enabled\n");
> > -=09=09return 0;
> > +=09=09rc =3D 0;
> > +=09=09goto out;
> >  =09}
> >  =09rc =3D rtc_read_time(rtc_device, &tm);
> >  =09if (rc)
> > -=09=09return rc;
> > +=09=09goto out;
> >  =09then =3D rtc_tm_to_time64(&alarm.time);
> >  =09now =3D rtc_tm_to_time64(&tm);
> >  =09duration =3D then-now;
> > =20
> >  =09/* in the past */
> > -=09if (then < now)
> > -=09=09return 0;
> > +=09if (then < now) {
> > +=09=09rc =3D 0;
> > +=09=09goto out;
> > +=09}
> > =20
> >  =09/* will be stored in upper 16 bits of s0i3 hint argument,
> >  =09 * so timer wakeup from s0i3 is limited to ~18 hours or less
> >  =09 */
> > -=09if (duration <=3D 4 || duration > U16_MAX)
> > -=09=09return -EINVAL;
> > +=09if (duration <=3D 4 || duration > U16_MAX) {
> > +=09=09rc =3D -EINVAL;
> > +=09=09goto out;
> > +=09}
> > =20
> >  =09*arg |=3D (duration << 16);
> >  =09rc =3D rtc_alarm_irq_enable(rtc_device, 0);
> >  =09pm_pr_dbg("wakeup timer programmed for %lld seconds\n", duration);
> > =20
> > +out:
> > +=09rtc_class_close(rtc_device);
> >  =09return rc;
> >  }
>=20
> I was expecting 2 patch series, with one which adds the DEFINE_FREE() int=
o=20
> the public rtc header, not going back to the old approach. You also seeme=
d=20
> to forget to increase the version number in the subject.

My apologies, I now realized it was sent earlier by somebody else so I'm=20
waiting update from them to fix this issue.

--=20
 i.

--8323328-747575916-1789654179=:1179--
