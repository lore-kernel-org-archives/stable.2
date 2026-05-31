Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A01E492D;
	Sun, 31 May 2026 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780253831; cv=none; b=DgUDKI2NVEOt5hJ96FT1lEkpX5AhErGogwXVDvm3D0rcTAUyMCorSuNVTqy3ARxBdZLhWdxQYQcPgsDuJZyMutq7/zqISWZvUQWQRxCSjP8V8w5krpZciYVj+iJWHy6ej5oRH8O8y1sKhWIwwFhNkC6L12xKjHmEmQ4cIRwuVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780253831; c=relaxed/simple;
	bh=Db+ioLYzsI8g46s7v2BnZ65iBiufZ9SNon8FuVqevn0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qXpcHvPU3zEWkQcmsc/JFDfNaRJfevAS5qp3IzUxlTkAb1fqEmdm+4Ou4G58+9SqnspUBTaMTUjpsuBWeeqnGVTUNkK/WYe7uB0PpRVYMM7FG69mNdEcge2QVb83UXMYWFo+q673vGlklvBMYdvDV4aSbYhiE91mRsF8P8aDnvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noXUtDwO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noXUtDwO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780253830; x=1811789830;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Db+ioLYzsI8g46s7v2BnZ65iBiufZ9SNon8FuVqevn0=;
  b=noXUtDwO44/a4EkPU9HovhOx6s0Kx3J/pYbBv6jgL6y6Zv21RTSjo6d8
   255WLa10y5Eq9dpxrPXB8UsfFweHGQhcafb/WvzD+u9jaVH964kr6RnOG
   0g3XJqTfYNeoto8D9AVfdJ1mweqs2/KuObatCggYDQcAc83KONNjESJRo
   ktOWUyHYLtQXf2GiWqnKPVSbWfx2M7MykrHRdXz7EifSfFeFJGjJaSXYW
   RpIw8L7LZ9o9xLqNQl8dPn3gYitNgrhPuk3I1nv9+oXXT+LFGOhjXHs7Z
   /9JKbVUkj//gzqGa7eX0NneNG81A3hnW6/koXwmZRI+cdlW4wDdK0BYFi
   w==;
X-CSE-ConnectionGUID: X6gSJL7wT9ClSsJdaYXD5Q==
X-CSE-MsgGUID: bGMP7PeaSfWd1Vuqo9+etQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="81132885"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="81132885"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 11:57:09 -0700
X-CSE-ConnectionGUID: VtjZYYyzTTexE5Y74u2zeQ==
X-CSE-MsgGUID: NtEe55fnShSuvX8Y92D7TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="237024138"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 11:57:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sun, 31 May 2026 21:57:02 +0300 (EEST)
To: William Breathitt Gray <wbg@kernel.org>
cc: Raymond Tan <raymond.tan@intel.com>, 
    "Felipe Balbi (Intel)" <balbi@kernel.org>, linux-iio@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
    stable@vger.kernel.org, Stepan Ionichev <sozdayvek@gmail.com>, 
    Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH 1/1] counter: intel-qep: Use devm_mutex_init()
In-Reply-To: <20260529023428.615928-1-wbg@kernel.org>
Message-ID: <31478645-66df-f8e2-09d4-864a88e6027e@linux.intel.com>
References: <177941369796.201156.12547650998958016276.b4-ty@kernel.org> <20260529023428.615928-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1565969351-1780253822=:1217"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1565969351-1780253822=:1217
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 29 May 2026, William Breathitt Gray wrote:

> On Fri, May 22, 2026 at 10:36:15AM +0900, William Breathitt Gray wrote:
> >=20
> > On Wed, 20 May 2026 14:18:12 +0300, Ilpo J=C3=A4rvinen wrote:
> > > intel_qep_probe() calls mutex_init() but lacks the pairing
> > > mutex_destroy() calls. Convert to devm_mutex_init() which handles
> > > cleanup automatically.
> > >
> > >
> >=20
> > Applied, thanks!
> >=20
> > [1/1] counter: intel-qep: Use devm_mutex_init()
> >       commit: ff35c72101d1dc6793496ade9c1bc3d70dd27bdd
> >=20
> > Best regards,
> > --
> > William Breathitt Gray <wbg@kernel.org>
>=20
> Hello Ilpo,
>=20
> In a similar patch[^1], Jonathan made a good point that a Fixes tag may
> not be appropriate for this patch when it only affects debug information
> as Joshua pointed out[^2].
>=20
> So I am going to treat this as an update patch to intel-qep rather than
> a bug fix and remove the Fixes tag and stable@vger.kernel.org CC line
> from the description. If you feel that this patch really should be
> picked up by the stable trees, please let us know and we can discuss
> further.

Hi,

It's fine for me to leave those tags out if you so prefer.

--=20
 i.

--8323328-1565969351-1780253822=:1217--
