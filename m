Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575667;
	b=LTq658U3xQDq0K0cLKQS5PB0lxBZZPjFGIhZf/wD0ySHzOqGl1dCQP/ogpLFLbPPdvtA
	 maREST2k7dKbK1VLZADJeJ73HgQh6aja6pfCmmmhxQEuH9HkwhXEDR/pe2OWgFPN9AX73
	 FIfVe/2LOC4diXqqIs2ZASwpXwXIr7GRlWWTaHpgqgr1mlZXE7SGS40/ff1eHtkiG0yO4
	 9xnHHCz365V9AUnP1M067wFrNm+toEXO2AxI5kkhgHWqPlELw6YR0/EosoAXoK4v1+IsN
	 byK4M4fJyA7w2QFACZr9V7JjJSX5KemOy2In9VHcZiun7evhnkwxFuz7RKTujLsCH8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575667;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=GQxW6xENtXbMj8QQDuCNwAAh6QE3zn6BXyEAG556udM=;
	b=Q+lJqH4SIzqqiHBQvWWmEAmGXstAfR5xhCa6Omu6JPZ8jJ4O878uyqw1sf2bDoVz1Mm9
	 iWXsC8eR/MpA6QVBsiwRwX/b58dspf429cBz0eTsPgOFodN5mwh4Er/hG6kDs/6BwAYKv
	 449BKJILXvLZjwQhBWQWosfnrEq5BIxrUxpB8vOBdjlsAXlW8aXeAPRHpHUC1joUbuWdW
	 QgmQX/IjHw8LWzSRa3brSOigSWvPngIw5wl0F5dpYpliS3zC/i4vMdeYe6wNyChJYZd+B
	 8JeCHoR2TjBmqjONaNr06CxvWw4l7M18yiJNV2cDkT/4bR/rOX61vsalKUiYFux0gAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="hM86O0k/";
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F1606A31B;
	Wed, 21 Oct 2026 09:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 817F1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hM86O0k/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792575667; x=1824111667;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jWWtomYEmcE2WRVvCrQva78fyq2hiVCpAZfWf4+FIys=;
  b=hM86O0k/TqhZFl1DEX4P7hhwtJ91DIPJzGa2NEtERr4pZfRSHn+ajZCU
   9UXV5C34jL3PifhwE3iZEWcatgF1Q816eVJQeUV83VuNDZxQSU8m4ZC0Y
   hXAJ+gL3+bMS6ZS1cxwuPK79MrLg6liHdIbUsK8RQotJxvLOdITte5/Lz
   0TXu+vWdMTVZJglpTp5J8UXjyncYTAeMMpMhufSV7ZeARos4tuZ9fnwgq
   Z6DBk4i9pfpfLTOt+hUqw+3SUmw2ec5r1IpmyEQk3l459HVjo6rPT/xRA
   jpV4elgYFWkKvvS8k10Xags6GEF3+Vu92wH/ORrmhFKsUSHfrbU9aENlL
   A==;
X-CSE-ConnectionGUID: qMmBT9zjS86dfTucRozmJw==
X-CSE-MsgGUID: XNA5n7G5S++rmVUBjf0Gyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1306606"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1306606"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:41:07 -0700
X-CSE-ConnectionGUID: CuTzZbQvS3uG0gS4V7rB9Q==
X-CSE-MsgGUID: 8Y1uQFNaSS2B3yPFqYXC3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="4845540"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:41:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Oct 2026 12:40:58 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v6] platform/x86: hp-bioscfg: fix heap OOB in
 hp_enforce_single_line_input()
In-Reply-To: <a905f45d-aec8-569f-d5bc-718896f7c9c9@linux.intel.com>
Message-ID: <273be4cc-ad7d-cdcd-de25-8d1439bed3e3@linux.intel.com>
References: <20261016025352.230535-1-meatuni001@gmail.com> <29c3e4a2-9d6a-60cf-d06d-85152a40a703@linux.intel.com> <CADqcGBkV4iE_0j6usv6TvV3K9XGUa0L9J-ebUkTLsB0NBYzTHA@mail.gmail.com> <a905f45d-aec8-569f-d5bc-718896f7c9c9@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1747451990-1792575658=:1258"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1747451990-1792575658=:1258
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Oct 2026, Ilpo J=C3=A4rvinen wrote:

> On Wed, 21 Oct 2026, Muhammad Bilal wrote:
>=20
> > Hi Ilpo,
> >=20
> > > Why use n variant?
> > strnlen() keeps the read within count, which is the size of buf as far
> > as this helper knows, so it does not depend on the caller NUL
> > terminating the buffer. Both current callers pass a kstrdup() copy, so
> > strlen() works too. I can switch to it in v7 if you prefer.
>=20
> As the contract here is the input must be a string, I don't see any need=
=20
> to limit the length with n variant so I do prefer strlen(). Also, we know=
=20
> that it should not be longer than count anyway.

I only now notice Andy's comments which seem better suggestion in general.

--=20
 i.

--8323328-1747451990-1792575658=:1258--
