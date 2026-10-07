Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396144C4F2;
	Wed,  7 Oct 2026 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369873; cv=none; b=IUUKkA3/DvcFvHKsxVheiEU2Ad5mK6zilM3LYeVX6Kq8uwV+Vr6IkMSwrQEmAF+kQjgtkV74CH6J3eE/LEWmPuncunFYREblTzTLLPWRh7yr4vCdw9CL3gVvBjprDES4xl372cy49q34Gsg2ZA1j0mT5ZnpLEq5Ukgeuom+/Exs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369873; c=relaxed/simple;
	bh=Nyk9eBoiqtY0Tb213xAOGuzs2Eh410ay/rHRThRfA90=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rM+zEWNsequ2RHgtSyUhCiVXvjjxA3oo6I901Bx/0wZur+CG6f80fEWULmywKOayun6scxTwDb5QDExCVGBfs0qYdZhuemxqi651zPg3OyCF33NZZk/SwOxGIq8yV52TTF09YNRJVRAP0e6XNDdyIdOatn40n5Rb2RaSDwSOC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AO9JypWQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AO9JypWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791369841; x=1822905841;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nyk9eBoiqtY0Tb213xAOGuzs2Eh410ay/rHRThRfA90=;
  b=AO9JypWQ8oxgp7ChBeqMKZxWmVIxNnFbIcfPO5wP+EJMFYZYBcZKk60S
   x5Z8ErdF9XIBJz+jz9nIkwCjcnxE3X4iHqR0Y839kMzktJuxaMxgvndK3
   WtmObTpdYwagnHdNgY8CQ2PPUTpAlhgrjcqvmJIWyXM0Ph0ywxsfvtaPf
   0fntxA9qtV1yHZXce23xNed7hYgmTz/Mnms2vc5YG+H7aeoGWvyFNoLje
   TQY9YNcrI6+z/gVd8TPL6Bend24WgN/i7GYIuduLw4bHoIuc75fX6IBd0
   LVO3h3g7TdI7JMRaFGFKHNx27yeCOXYPBWcV5iJdr2Q/YyMBfXA7Xn00F
   Q==;
X-CSE-ConnectionGUID: sbZnx6KdQWuq05rvEhR6eA==
X-CSE-MsgGUID: T7L2TRTVQOeV7oD3nspK7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="123761"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="123761"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 03:44:00 -0700
X-CSE-ConnectionGUID: WaA9NTd2SBGmJMtcTeSisQ==
X-CSE-MsgGUID: bVFNPNwrTKeRFemxxj3Ftg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="156862"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 03:43:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 7 Oct 2026 13:43:52 +0300 (EEST)
To: Hui Peng <benquike@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Hugo Villeneuve <hugo@hugovil.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v8 1/2] serial: core: fix baud rate fallback in
 uart_get_baud_rate()
In-Reply-To: <20261007094719.1362769-2-benquike@gmail.com>
Message-ID: <9b6de039-6db5-35c8-b3f6-104521e1d09f@linux.intel.com>
References: <20261007094719.1362769-1-benquike@gmail.com> <20261007094719.1362769-2-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1798260010-1791369832=:1171"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1798260010-1791369832=:1171
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 7 Oct 2026, Hui Peng wrote:

> When uart_get_baud_rate() evaluates a requested baud rate against a port'=
s
> supported limits [min, max], the retry loop operates as follows:
>=20
>   try =3D=3D 0: Evaluates the requested baud rate. If out of range and an=
 old
>             termios is available, it switches termios to old.
>   try =3D=3D 1: If old is also out of range

> (or unavailable)

This is not equal to the case where old is out of range because try =3D=3D =
0=20
didn't use continue if that's the case so baud is within bounds.

But as suggested by Hugo in the older version thread, the better approach=
=20
would be to prevent "old" from getting invalid in the first place so=20
please look into that instead.

--=20
 i.

> , the fallback rule
>             at the end of the loop clips baud to [min, max - 1] and encod=
es
>             it into termios via tty_termios_encode_baud_rate(termios, bau=
d,
>             baud).
>   try =3D=3D 2: Evaluates baud =3D tty_termios_baud_rate(termios) for the=
 newly
>             encoded clipped rate, which now satisfies min <=3D baud && ba=
ud
>             <=3D max and returns baud from within the loop body.
>=20
> However, because the current loop bound is for (try =3D 0; try < 2; try++=
),
> the loop terminates immediately after try =3D=3D 1 without executing try =
=3D=3D 2 to
> re-evaluate the clipped rate. Upon loop exit, the function hits WARN_ON(1=
)
> and returns 0, which triggers a fatal divide-by-zero (Oops: divide error)
> in uart_get_divisor():
>=20
>   WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_rate+0x1=
36/0x260
>   [ ... ]
>   divide error: 0000 [#1] PREEMPT SMP KASAN
>=20
> Increase the loop retry limit in uart_get_baud_rate() from 2 to 3 iterati=
ons
> (try < 3) so that clipped fallback baud rates are re-evaluated in try =3D=
=3D 2.
>=20
> Tested in QEMU against Linux 7.3.0-rc3 by setting B4000000 on /dev/ttyS0 =
via
> tcsetattr(): on the unfixed kernel it triggers WARN_ON(1) and divide-by-z=
ero
> Oops, whereas with this fix applied uart_get_baud_rate() smoothly falls b=
ack
> to 115200 without error.
>=20
> Fixes: 091ea8e5d34e ("serial: core: prevent division by zero by always re=
turning non-zero baud rate")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v8:
> - Rewrote commit description to detail the step-by-step loop iteration
>   progression (try =3D=3D 0, try =3D=3D 1, try =3D=3D 2) as requested by =
Ilpo J=C3=A4rvinen
>   and Greg Kroah-Hartman.
>=20
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index f91bcfa30113..6ed0195e6912 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -470,7 +470,7 @@ unsigned int uart_get_baud_rate(struct uart_port *por=
t, struct ktermios *termi
>  =09 * Ask the low level driver to verify the baud rate if it can't
>  =09 * then it will have encode_baud_rate set the Closet else .
>  =09 */
> -=09for (try =3D 0; try < 2; try++) {
> +=09for (try =3D 0; try < 3; try++) {
>  =09=09baud =3D tty_termios_baud_rate(termios);
>=20
>  =09=09/*
>=20
--8323328-1798260010-1791369832=:1171--
