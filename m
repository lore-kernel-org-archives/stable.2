Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531168;
	b=RwsmrIyFmpKlA2qHkKCl9WXYde7Z+y6h6R3+8vabWUZ6RMTff+QgOInEgXwME5Z+35cW
	 ZECFF0Bcow19A4/nCLUvKmboRJSfX87shoDVCkssHmBYmezlcAoT09AoQgAHd74IgE1Tc
	 TKQ2IkvVvPsDbg5rKeEfuT2sGBv+eiukb5exh6UdBQsN9kB/32LMHMTjEMXN9aZg6PWtw
	 cBOSZAbLGm/Y08tXRSr7pcOc+phv9xQ2O57qLFMtDIGMcnF94GAOshFIIIrPJBRihXwiL
	 ScVH0SSpfCQYWoLoPEEyv7vSqVnONqv5udXvdVArxCxdzuiDR34yQuPBErZHzEn0G0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531168;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=EFiAhLpPCbCG0qGhG6c3PkB+2nh7/RIhptsbUY/w6Xo=;
	b=zE7G1F2BMDxF2ljgEjGhiYYOpMC8+neVqtWeukvfaMIqt1sufSZanQd2hFkRw1YgONZu
	 /V1JCOPUchqr6h/Qof6GR4WwO7jpLned0Ev5Q2e0MGSgMG+i0uXpl5WZFfyVco1sq52aW
	 o6vpraU9vxLJhJxQA7XecBjZGzYMLacRNMRJoRUI+B3xtwyUKydJedYvxLDRAg56ULNGT
	 A0Y70lgmsZUnVU7VhBJhrXkUek4SwYvddfOWD7+j6gy/gZoinupd1fBN6xi0tYZUezAtT
	 xHuuG4AzUcu6FxZRBViVv1eejkiAHRME0e033XLSXRHPTpANo9JRGr1gjz0Iidv8xxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F3qdzCfs;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE5606A31A;
	Tue, 20 Oct 2026 21:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEFE5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F3qdzCfs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792531168; x=1824067168;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wgvs4TfrBwmQe25MIzOokgSbmEY5CtIwpB5o6j1X8W8=;
  b=F3qdzCfs8B2EhF8lIFh3AukcSjMLBPyvBiSFn515Loa/BIeCiZdw8AwR
   aqWHuHa8JBYjQ/sZOsEMqQ/uhFrtwAy0laugta3X6srSSXOHquoibSlqv
   FOA5cEyvJ2tonCkNe1prS02zb21DKNr3i9sn5bWOdMPsYoMi+mgXSSFHN
   HjDGWwjHZcj17mKQtsyEryFbpbJUXO3YazWbyTj2MYi6o71DwFLHv6001
   NG3xYIQ+fFG9ZuTre+5AlvWBSznXXCeHUiAN/km2fOQRXdJJ7ExX3M2n1
   eQhyugYsd1RU/xQz+9pmaMbQiWH+bu75De5bg4QIGA+A/J2XH/F6Ul+kE
   A==;
X-CSE-ConnectionGUID: oMG9/OQWTPmh2s52y+kJUg==
X-CSE-MsgGUID: zji5zxIQQZ2H2sDnD4nLKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1237154"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1237154"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 14:19:27 -0700
X-CSE-ConnectionGUID: xa+w+ahqQl+dGt6z/uSZNg==
X-CSE-MsgGUID: ZhqweZftTYe8HRjO2kP8mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3316165"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 14:19:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Oct 2026 00:19:20 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v6] platform/x86: hp-bioscfg: fix heap OOB in
 hp_enforce_single_line_input()
In-Reply-To: <20261016025352.230535-1-meatuni001@gmail.com>
Message-ID: <29c3e4a2-9d6a-60cf-d06d-85152a40a703@linux.intel.com>
References: <20261016025352.230535-1-meatuni001@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-400396624-1792531160=:1177"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-400396624-1792531160=:1177
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 16 Oct 2026, Muhammad Bilal wrote:

> The input is copied with kstrdup(), which stops at the first NUL, but
> the full write size is passed to hp_enforce_single_line_input(). With
> an embedded NUL the helper reads, and can write one byte, past the
> copy. Return -EINVAL if the input contains a NUL.
> =20
> Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
> followed by 4093 bytes of "B" to current_password 100 times returns
> -EINVAL every time, without reading into the heap.
> =20
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Cc: stable@vger.kernel.org
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> Changes in v6:
>  - Return -EINVAL on embedded NUL instead of limiting the scan (Ilpo)
> =20
> v5: https://lore.kernel.org/all/20261007134711.473857-1-meatuni001@gmail.=
com/
> =20
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platf=
orm/x86/hp/hp-bioscfg/bioscfg.c
> index 876fc35d035b..e306bd8b1e72 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -162,6 +162,10 @@ int hp_enforce_single_line_input(char *buf, size_t c=
ount)
>  {
>  =09char *p;
> =20
> +=09/* buf is a string, so a NUL before count is invalid input */
> +=09if (strnlen(buf, count) < count)

Why use n variant?

> +=09=09return -EINVAL;
> +
>  =09p =3D memchr(buf, '\n', count);
> =20
>  =09if (p =3D=3D buf + count - 1)
>=20
> base-commit: 8667bd30fd033295b3038ce374c551d1059538ba
>=20

--=20
 i.

--8323328-400396624-1792531160=:1177--
