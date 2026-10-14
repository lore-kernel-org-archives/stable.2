Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBAE4EF14C;
	Wed, 14 Oct 2026 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983420; cv=none; b=StxwN/i7xfsHF+dDi+rVN3JDifbvxePGRh0rSg0gY5vHLuBP8zrFgqWXFol0zTMHjLRmpqzFQqBigN6lbCtJqHiflfiZeO+xal/pGnowfhtjkIcV3+me0Q9n80PvAg0I/g5vHe7431iG0vWN2pirtYUkvU75W4EV6Jupl5iQjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983420; c=relaxed/simple;
	bh=BSLJ4BHBxJh2A4tzaijs/DNK96aL/MW5tTmKJC6MAKg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c+mIp6et6qmN0ehhmFEtKvjI63USv+Vhr1xBg+PN8dTFf6IefSU2RUk9ISn3MUDUWlw5083ZJi3CvMDi9Q9RvsPy9+BR/B1+ZDr25+sGw9AePJIGOgzihiBVDI+rUKxw9T5oDdVtbuCK81zFqthzciWmW4JhDQZqyNEl2W6bjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AioVkGP/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AioVkGP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791983418; x=1823519418;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BSLJ4BHBxJh2A4tzaijs/DNK96aL/MW5tTmKJC6MAKg=;
  b=AioVkGP/8+7zeRxSzIyGsOZvL7Ev5rIEBb+bSz2aUdOqzYn2OQY9WK6L
   ZItMSFRbPNOIbECqPCRfsoxxup4zs5uw8BQdwSR2mYN0R69HQK0b6t/uN
   zd5PRfWRsxJ6ix5TRyoabk9/rJqIJYBPjGh7xFSycAknlV0gNswToN7HE
   foL+A7Dd5QS2srOTorJegV2aHWvABxe+qIjstR13vYEI1Y7mzyA4LW8yF
   PozUbsgt/FQP4g1qDokFFQW6B+5h9IIxWJPD477N8IQqG19A1CxwQlc6Y
   TGZ2F6TG+lxOLnGns6gpldlmhs0ask8mXEL2qPOtJaF+kuCXCnd4bRuYa
   Q==;
X-CSE-ConnectionGUID: JQP2F2atSL2pxqK/Hbb6pw==
X-CSE-MsgGUID: EtkqCKWOQxa8xRJFzHRIOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="606049"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="606049"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 06:10:16 -0700
X-CSE-ConnectionGUID: bIwpUFjETHGl02WD1LfFhg==
X-CSE-MsgGUID: erpxzEaeQqqma4fWZ4CLZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="3176397"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.234])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 06:10:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 14 Oct 2026 16:10:08 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v5 6/9] platform/x86: hp-bioscfg: fix heap OOB in
 hp_enforce_single_line_input()
In-Reply-To: <20261007134711.473857-7-meatuni001@gmail.com>
Message-ID: <c3be14c6-08c0-0d6b-8027-04d2f5f2a855@linux.intel.com>
References: <20261007134711.473857-1-meatuni001@gmail.com> <20261007134711.473857-7-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-282824689-1791983408=:1157"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-282824689-1791983408=:1157
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 7 Oct 2026, Muhammad Bilal wrote:

> The store handlers copy the input with kstrdup(), which stops at the
> first NUL, but pass the full write size to
> hp_enforce_single_line_input(). With an embedded NUL the copy is
> shorter than count, so the helper reads, and can write one byte, past
> the allocation.
>=20
> Writing "A\0" followed by 4093 bytes of "B" to current_password makes
> memchr() scan 4093 bytes past a 2-byte copy.

Shouldn't that input just return -EINVAL ? Because that's what it is,=20
invalid input from user.

> On an HP EliteBook 840 G2
> running Linux 7.2.7 all 100 such writes fail with -EINVAL although the
> input has no newline, so memchr() matched one in the heap. A userspace
> replica of the helper under ASan reports a 4095 byte read, 0 bytes
> after the 2-byte region, and is clean with this change.
>=20
> The input is a string, so only scan up to its first NUL.
>=20
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Cc: stable@vger.kernel.org
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> Changes in v5:
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platf=
orm/x86/hp/hp-bioscfg/bioscfg.c
> index 754ab03bfd7b..84d75926d768 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -166,6 +166,8 @@ int hp_enforce_single_line_input(char *buf, size_t co=
unt)
>  {
>  =09char *p;
> =20
> +=09/* buf is a string, ignore anything after its first NUL */
> +=09count =3D strnlen(buf, count);
>  =09p =3D memchr(buf, '\n', count);
> =20
>  =09if (p =3D=3D buf + count - 1)
>=20

--=20
 i.

--8323328-282824689-1791983408=:1157--
