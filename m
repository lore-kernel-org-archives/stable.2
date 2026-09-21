Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3524915A1;
	Mon, 21 Sep 2026 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993028; cv=none; b=OuooDMW6+BBI0PT+5NWRzv8ITrk4IUzWe3c7vKfDpQMzZl0pfRC0L5O3hTYxW9S93Is9CeOru1p4e6mmzKI0x47VygyVVURdFk+x9arwx1PEGrTSm12z5rioF+cGOugpB9pkFfkV7EtLGqFj5iEZ3fpaA6+z+/o4d8r8geNjEqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993028; c=relaxed/simple;
	bh=ZvoPMXKi+kTAHHftCUaVh2GWMj4V6IEf+COAM5XtRx4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W3Rvsrt+dT+it21Gc9sncbYj1qXnAi9vcGnSKkkQeuLmgrayJeYst6EJQc4gQMKZJwzTA3HY/ITVv3ww/5QzMvY95IHPIf8i+xY//p2GCBNsB752ouYabVvopcjUgAt/kQdcYHsB1VkUGBbd1TZwq5KHPRHdpvbHzSaih50/Fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVaXWEVH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVaXWEVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789993026; x=1821529026;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZvoPMXKi+kTAHHftCUaVh2GWMj4V6IEf+COAM5XtRx4=;
  b=CVaXWEVHrJN7BvdhPlqDocQ7x44YPTvWVHyKQPKx9SGc9WxLgYlJ1apY
   BF2pSezKCfZRDhEO8IR8C0uT4r/gxCEMHUuvuRyFfJZAIMi7J26xD6QU0
   O9W71bQfmbFuWcNSyZRY6OFEmp5oy4MXm8V+WhILIOiQlffnqVTqtBFag
   vDcIfv8aq2JGf6rnYyOkXwg+adcqfbO4ryqZksXZ5bb1kny8/0aHyTKOB
   tbX3Mj9ObSzXH5/SvPcuF8x040jvkwv+LjjVHBJf9TjeEPmNfF1l/sHEU
   qGUwiDHFL7jzZjroKmMoBtuKoeOOLckchlyaHNyE7o3YoYNfVBxvtZ5Vh
   w==;
X-CSE-ConnectionGUID: vxgfnu6DT4SRVLHaIETU2Q==
X-CSE-MsgGUID: z7yaGyyrT6KwxPdyMimWHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="92998553"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="92998553"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 05:17:05 -0700
X-CSE-ConnectionGUID: z7axeSIGQIGgGCVKlLqpkw==
X-CSE-MsgGUID: YhAGcl0vT+GmC6IFckqO9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="272097535"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 05:17:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Sep 2026 15:16:57 +0300 (EEST)
To: Hui Peng <benquike@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] serial: core: allow third iteration in
 uart_get_baud_rate() fallback
In-Reply-To: <20260921013027.659965-2-benquike@gmail.com>
Message-ID: <5deff35c-902b-f402-36ec-083e5de6aab5@linux.intel.com>
References: <20260919222627.3797854-1-benquike@gmail.com> <20260921013027.659965-2-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1326732310-1789993017=:1213"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1326732310-1789993017=:1213
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 21 Sep 2026, Hui Peng wrote:

> In uart_get_baud_rate(), when the requested baud rate is out of range
> (try =3D=3D 0) and old is non-NULL, the function copies the old termios b=
aud
> rate into termios, sets old =3D NULL, and continues to try =3D=3D 1. If t=
he
> old baud rate is also out of range (for instance, after uport->uartclk
> was lowered via TIOCSSERIAL so max =3D uport->uartclk / 16 is smaller tha=
n
> both the old and new baud rates), try =3D=3D 1 clips baud to [min + 1,
> max - 1] and encodes it into termios via tty_termios_encode_baud_rate().
>=20
> However, because the loop bound is for (try =3D 0; try < 2; try++), the
> loop terminates immediately after try =3D=3D 1 without re-evaluating
> baud =3D tty_termios_baud_rate(termios) for the clipped rate, hitting
> WARN_ON(1) and returning 0, which then triggers a fatal divide-by-zero
> (Oops: divide error) in uart_get_divisor():
>=20
>   WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_rate+0x1=
36/0x260, CPU#1: init/1
>   ...
>   Oops: divide error: 0000 [#1] SMP KASAN PTI
>   CPU: 1 UID: 0 PID: 1 Comm: init Tainted: G        W        N  7.3.0-rc3=
-g5dd1818b15d9 #1 PREEMPT(lazy)
>   RIP: 0010:uart_get_divisor+0x5b/0x100
>   Call Trace:
>    <TASK>
>    serial8250_get_divisor+0x123/0x1a0
>    serial8250_do_set_termios+0x21e/0x1610
>    serial8250_set_termios+0x77/0x90
>    uart_change_line_settings+0xf6/0x720
>    uart_set_termios+0x1c1/0x5b0
>    tty_set_termios+0x5f7/0x920
>    set_termios+0x533/0x7d0
>    tty_mode_ioctl+0x8e4/0xd10
>    n_tty_ioctl_helper+0x3c/0x270
>    n_tty_ioctl+0x4e/0x2c0
>    tty_ioctl+0x1028/0x1480
>    __x64_sys_ioctl+0x184/0x1d0
>    do_syscall_64+0xda/0x4b0
>=20
> Increase the loop limit to try < 3 so that the clipped baud rate encoded
> on try =3D=3D 1 is evaluated and returned on try =3D=3D 2.
>=20
> Tested in QEMU against Linux 7.3.0-rc3 by setting /dev/ttyS1 to B115200,
> lowering baud_base to 9600 (max =3D 9600) via TIOCSSERIAL, and calling
> tcsetattr() with B57600 (old =3D B115200), reproducing the WARNING and
> Oops: divide error in uart_get_divisor() on the unfixed kernel and
> verifying clean execution with 0 warnings/faults with the fix applied.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 091ea8e5d34e ("serial: core: prevent division by zero by always re=
turning non-zero baud rate")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Split out from the 8250_core.c and uart_set_info() changes into patch
>   2/3, add Cc: stable@vger.kernel.org, and include the QEMU reproducer te=
st
>   details and kernel stack trace, as requested by Greg Kroah-Hartman.
>=20
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 95774b0f1484..128fc056f5c9 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -501,7 +501,7 @@ uart_get_baud_rate(struct uart_port *port, struct kte=
rmios *termios,
>  =09=09break;
>  =09}
> =20
> -=09for (try =3D 0; try < 2; try++) {
> +=09for (try =3D 0; try < 3; try++) {
>  =09=09baud =3D tty_termios_baud_rate(termios);
> =20
>  =09=09/*
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1326732310-1789993017=:1213--
