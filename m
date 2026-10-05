Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2647F2C8;
	Mon,  5 Oct 2026 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205250; cv=none; b=kOh88fk0xgpy1Zj3aF12sN1OnoQC4dNYyVTOkDL0cQBLHu/JokxouMbD9BBQvy0zVoS3GExoPhdi8wBLTGrhdi45KjyMnhGQF67Mku2Xs/4KeDZcFR0rylFklc5eSCVMPR0iVRzbZvb0ANwEDq/5nTZ85ovJ8K5qiOHjqWQdq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205250; c=relaxed/simple;
	bh=OWzRwoTTuWQnunHy0mJCPcV646SUG8qTbfbf6Un3tCQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g1ZTWZNwCzGhe5em7LAT1fnEzN5Wz7wuHU5vtGXmapXsN/uwOq49+TDixzci3B4iymvk6rpayEMpOtRvrC3ntMzr6XHiA8kmYt95iTH53Zv0qI67q8d4sGl4VzNPU2AxiI2O8l+rKDYlRIxOtYSLGT285ccE995h7F2S+JKZ/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UryTw2M7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UryTw2M7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791205247; x=1822741247;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OWzRwoTTuWQnunHy0mJCPcV646SUG8qTbfbf6Un3tCQ=;
  b=UryTw2M7WB8uZwygkyvOJZmZPboFHcbRlR6ZpxlFUGc+aR6VGzOSqMUi
   SPZu550esT+E0wq3YEwrykO2C0ud246HXSFW0uHrAYFcYyVM2h7eI4QDj
   7w8GC856Z+Zlh1hfdSBQZY25jjo5fbc9YoCvgjf87mR6hvKLJyKe1St8l
   tIFXe3oWk06qS0EyUSxCXu2VThK/LxwRAfRmnUcZwna552NEi7ayZ/xNF
   FQq9ktr/Ft+OhV8mG65TAas4Ojg8/p4K98JYnHbU/VyJG7INVsK6IIjhl
   jA3uGUOnoEqz7WTz9+CH7lJwI/8KeA3AeepfwpytQTzoe9Cxn4JsaSltr
   Q==;
X-CSE-ConnectionGUID: /61MIXpETbeFyVo8mkySRQ==
X-CSE-MsgGUID: 5vDjzkoARaCu3EPd8XnV5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="108251560"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="108251560"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 06:00:47 -0700
X-CSE-ConnectionGUID: 3FayfDV2SPO2RyVABEwAzA==
X-CSE-MsgGUID: 0z0V8M5bRG+zxcU1oLhcVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="891106"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 06:00:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Oct 2026 16:00:40 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: hp-bioscfg: fix OOB read in
 hp_get_integer_from_buffer() on unaligned input
In-Reply-To: <20260919060404.85742-1-meatuni001@gmail.com>
Message-ID: <9e0d2b45-e931-bf3a-7fb8-f6fc25964cf4@linux.intel.com>
References: <20260919060404.85742-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2092172039-1791205240=:1173"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2092172039-1791205240=:1173
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 19 Sep 2026, Muhammad Bilal wrote:

> hp_get_integer_from_buffer() aligns the read pointer before dereferencing
> it:
>=20
>   int *ptr =3D PTR_ALIGN((int *)*buffer, sizeof(int));
>=20
> When *buffer is not 4-byte aligned, PTR_ALIGN() advances ptr forward by
> 1-3 bytes to reach the next aligned address. The bounds check that
> follows does not account for that advance:
>=20
>   if (*buffer_size < sizeof(int))
>           return -EINVAL;
>=20
> This only confirms 4 bytes remain from the original *buffer, not from
> the aligned ptr. If *buffer is unaligned and *buffer_size is between 4
> and (pad + 3) bytes, *(ptr++) reads up to 3 bytes past the end of the
> buffer.
>=20
> *buffer_size is also under-decremented on every call, aligned or not:

I don't see the explanation telling why things go wrong in the aligned=20
case.

>=20
>   *buffer_size -=3D sizeof(int);
>=20
> *buffer is advanced to the aligned, post-read position, but
> *buffer_size only accounts for the 4 bytes of the integer itself, not
> the alignment padding skipped to reach it. Each unaligned read leaves
> *buffer_size overstating the true remaining space by the pad amount,
> an error that compounds across repeated calls against the same buffer
> (hp_get_common_data_from_buffer() calls this in a sequence), making
> later bounds checks against *buffer_size progressively less reliable.
>=20
> Compute the padding explicitly, check for it, and account for it when
> advancing *buffer_size, so the pointer and the remaining-length count
> stay consistent with each other.
>=20
> Also switch ptr from "int *" to "u32 *", matching the type of the
> output parameter it's really standing in for, and size everything off
> sizeof(*ptr)/sizeof(*integer) instead of the bare "int" type name.
>=20
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

This also lacks information whether this problem is actually seen to occur=
=20
on some real device.

--=20
 i.


> ---
> Changes in v2:
>   - Use sizeof(*ptr)/sizeof(*integer) instead of bare sizeof(int), and
>     change ptr from "int *" to "u32 *" to match *integer's type, per
>     Ilpo J=C3=A4rvinen's review.
>=20
> Link: https://lore.kernel.org/r/20260824225610.18471-2-meatuni001@gmail.c=
om [v1]
> ---
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platf=
orm/x86/hp/hp-bioscfg/bioscfg.c
> index 309634c..f59957e 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -38,15 +38,19 @@ struct kobj_attribute common_display_langcode =3D
> =20
>  int hp_get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *integ=
er)
>  {
> -=09int *ptr =3D PTR_ALIGN((int *)*buffer, sizeof(int));
> +=09u32 *ptr =3D PTR_ALIGN((u32 *)*buffer, sizeof(*ptr));
> +=09u32 pad =3D (u8 *)ptr - *buffer;
> =20
> -=09/* Ensure there is enough space remaining to read the integer */
> -=09if (*buffer_size < sizeof(int))
> +=09/*
> +=09 * Ensure there is enough space remaining to read the integer,
> +=09 * including any padding PTR_ALIGN() introduced to reach it.
> +=09 */
> +=09if (*buffer_size < pad + sizeof(*ptr))
>  =09=09return -EINVAL;
> =20
>  =09*integer =3D *(ptr++);
>  =09*buffer =3D (u8 *)ptr;
> -=09*buffer_size -=3D sizeof(int);
> +=09*buffer_size -=3D pad + sizeof(*integer);
> =20
>  =09return 0;
>  }
>=20
--8323328-2092172039-1791205240=:1173--
