Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573548;
	b=Tn11BVPYBgbjJBE5c4XOvQHlPJdCxtz6qS9lj4KhgTIT2BKgBnGZaonRXC12uxgiImIY
	 w7LjcB4Q9qlKrpkqImP/6g6MQ358V6kBXtDIBZZ3tVX3NKAouA2iJSWX+MzGS3eJMGdrE
	 49j2sY1k45+TGQb7+Y19TEOfCUD/WPI93FB0xI3AgU7/Fvpe3qEeZ8jPv19RBdx81M+OR
	 bxqPrVjMgJWrjjlnYyod/ZNej+CfPin8gsAEvND1cyZWfzgtzVDbKT2s6x1N5/XcQxb8b
	 Lidayuq9TbUbhYRYsX/CPD974mqOg9Savt6mj3GETaGD6JuVq2pxMb0HQXi6WG4LSdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573548;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=MDiV8Cg2qYD5w4v3RNhhR59ppcpCPG7oh6UM9oq7LWM=;
	b=DNpS2VjnPWKVr3vnc89+gg036/OHe3+mc1HZXL+5t+nmcY/n6Swi1Wf63/tu4VOGRN+f
	 uQW7pa071y+REiqL9QUuAeX9qu7Dmf6eClUQ3ZV963wON/GJaOkVoZkiiEIwZoDyGxN4J
	 tEkE/1C7YucR1yiXaDGKTY159Os7/yF2EwQJZ2uAgDVSn0SVWPmdsQ0dWJn0bj7Hk+3rE
	 rj5aX2gyYjMmyEax55vArc/yKw+wQtqbLBcwRKlv+rP6hMIFAV3PCbshWwf2R7MafVBEh
	 nxglvAE++l1jfinXf4wsG5n+E2FRlU/iOHgMrO+K9WE01YWDarIWdpRUstEuERAA5hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mrx0lhpi;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02117606A31A;
	Wed, 21 Oct 2026 09:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02117606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mrx0lhpi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792573548; x=1824109548;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3bc6kI4G+m4pyFPZ8z/26MoCOdgMktIlpCdemjKJb20=;
  b=Mrx0lhpikuGCSw25U3AR941mZUL75yNASpNpagGQo1wqOUShovZyzMUK
   iVhKaOkFvegjCOMRTM4TogXwRPwpHoOcADqihvkLWlMg1pkEwFOO8D7/c
   9E+s3r3bXBrerZS3o8W6fR6wPhs3NlOPrFLG7D+psHPt464OICjB25BFj
   bipm3wx29h8NDsVBBYT4u4yoTMxFPZ+C6VVKsMjyg1nKsJJ1OZN+cE/nj
   sOih2XzO0iid4f4/Bi7ZUYX+m7UX+RzpPtOBFfymzr9mpKmN08fQzg47g
   qXpkGtjsPAyO4eK14bZOthgNKkgjzc4oHUgHxw/kTzujXbx5qisKySegn
   Q==;
X-CSE-ConnectionGUID: xPS2RVvYTqCKr1yjQcTAUQ==
X-CSE-MsgGUID: 5Y3dYEaySe+GtF4Uc17gew==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1303247"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1303247"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:05:48 -0700
X-CSE-ConnectionGUID: kq2bl2/3SRmAWc4968UjTQ==
X-CSE-MsgGUID: TNG0Hco4Tc6jfhpl38N7+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3437346"
Received: from alekseim-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:05:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Oct 2026 12:05:40 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v6] platform/x86: hp-bioscfg: fix heap OOB in
 hp_enforce_single_line_input()
In-Reply-To: <CADqcGBkV4iE_0j6usv6TvV3K9XGUa0L9J-ebUkTLsB0NBYzTHA@mail.gmail.com>
Message-ID: <a905f45d-aec8-569f-d5bc-718896f7c9c9@linux.intel.com>
References: <20261016025352.230535-1-meatuni001@gmail.com> <29c3e4a2-9d6a-60cf-d06d-85152a40a703@linux.intel.com> <CADqcGBkV4iE_0j6usv6TvV3K9XGUa0L9J-ebUkTLsB0NBYzTHA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2130717885-1792573540=:1258"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2130717885-1792573540=:1258
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Oct 2026, Muhammad Bilal wrote:

> Hi Ilpo,
>=20
> > Why use n variant?
> strnlen() keeps the read within count, which is the size of buf as far
> as this helper knows, so it does not depend on the caller NUL
> terminating the buffer. Both current callers pass a kstrdup() copy, so
> strlen() works too. I can switch to it in v7 if you prefer.

As the contract here is the input must be a string, I don't see any need=20
to limit the length with n variant so I do prefer strlen(). Also, we know=
=20
that it should not be longer than count anyway.

--
 i.

> Thanks
> Muhammad
>=20
> On Wed, Oct 21, 2026 at 2:19=E2=80=AFAM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Fri, 16 Oct 2026, Muhammad Bilal wrote:
> >
> > > The input is copied with kstrdup(), which stops at the first NUL, but
> > > the full write size is passed to hp_enforce_single_line_input(). With
> > > an embedded NUL the helper reads, and can write one byte, past the
> > > copy. Return -EINVAL if the input contains a NUL.
> > >
> > > Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
> > > followed by 4093 bytes of "B" to current_password 100 times returns
> > > -EINVAL every time, without reading into the heap.
> > >
> > > Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> > > ---
> > > Changes in v6:
> > >  - Return -EINVAL on embedded NUL instead of limiting the scan (Ilpo)
> > >
> > > v5: https://lore.kernel.org/all/20261007134711.473857-1-meatuni001@gm=
ail.com/
> > >
> > >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/p=
latform/x86/hp/hp-bioscfg/bioscfg.c
> > > index 876fc35d035b..e306bd8b1e72 100644
> > > --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> > > +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> > > @@ -162,6 +162,10 @@ int hp_enforce_single_line_input(char *buf, size=
_t count)
> > >  {
> > >       char *p;
> > >
> > > +     /* buf is a string, so a NUL before count is invalid input */
> > > +     if (strnlen(buf, count) < count)
> >
> > Why use n variant?
> >
> > > +             return -EINVAL;
> > > +
> > >       p =3D memchr(buf, '\n', count);
> > >
> > >       if (p =3D=3D buf + count - 1)
> > >
> > > base-commit: 8667bd30fd033295b3038ce374c551d1059538ba
> > >
> >
> > --
> >  i.
>=20
--8323328-2130717885-1792573540=:1258--
