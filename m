Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC146456E0A;
	Tue, 22 Sep 2026 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790069266; cv=none; b=spmTBDMHfQ2jkccFbanXVkDcHGc1AnbdJK1C/lZP0Y9sq5Q2B8Z8s4AnckDbsIzZnQcWA+QdNbvZdxJoxHjFUHCICqmzpN5BBM7qXRO2eyKt31bK4+89RwAtMdRDEhw0TZIQX5PheGdZtQSsxebJneZ/t0qVt4nAsHqPpNZLxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790069266; c=relaxed/simple;
	bh=Dz06FPZPayJGVz2Pc5dBqcMZCH31Phvzy0hr12FeLlU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R211ySUvkwbIVz8Te6cqic1gUv7nCwM8dobFJ1qh3UDa/pTArp3KSgLqORPwW0ezA0eDK13B4kFaTl3Dzt3uAVNmDedqp6oqhXyCny7S+zXkUIzuqlcCzXguakpDnrXsaYOu4l8RBaT6lQNPge64BtNsHwr0NKPBLMJwcIImUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UV30IZQI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UV30IZQI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790069265; x=1821605265;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Dz06FPZPayJGVz2Pc5dBqcMZCH31Phvzy0hr12FeLlU=;
  b=UV30IZQIHXEEwwSLsUtLUFKzSBTKz0AeBbNvFf12MetGknE1ZA+F1SgY
   /C1nfu9mbJHgmZ/CUt1BqljNQms99zEETkWmHnJlvGUtKYY9okcBE2cSc
   9fFYXTISPvkLhpBv5WedqY5rsFjn6sd5srPkXpgDsIJ3uot409ci+24Vr
   5KGEj9X8M9ItN2ckmjQrfLGHe02kaCDg7S+nbwhOWie5vlbdl/VEn/998
   GFAsm7hVHObk+yMEBxMGbBg14IByMcrbY2ayLoPtfEa8iq6uDhn/1MoIc
   TT0+cB+Lm9uHKSPuv8Uet5OdmIj9jgB8/B/RZDk2XGCq6Ds+Ph41HSx/r
   g==;
X-CSE-ConnectionGUID: V4s0I8G/TaOqQlupZWaJ9Q==
X-CSE-MsgGUID: fK1uNodmQoaFJx5blrUtcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90524287"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90524287"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 02:27:44 -0700
X-CSE-ConnectionGUID: 2YImfgsnTAu+ldaXf1Kjsg==
X-CSE-MsgGUID: ExxeUIY1TrCgmcB6W1e8LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="272551655"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 02:27:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 22 Sep 2026 12:27:37 +0300 (EEST)
To: Hui Peng <benquike@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: reject baud_base values that overflow
 port->uartclk in uart_set_info()
In-Reply-To: <20260922083152.4055969-4-benquike@gmail.com>
Message-ID: <90ddd895-856a-f7ae-162b-c80a6042d788@linux.intel.com>
References: <20260922083152.4055969-1-benquike@gmail.com> <20260922083152.4055969-4-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1689351862-1790069257=:1233"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1689351862-1790069257=:1233
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 22 Sep 2026, Hui Peng wrote:

> In uart_set_info(), new_info->baud_base is multiplied by 16 and stored in
> uport->uartclk (an unsigned int):
>=20
>   uport->uartclk =3D new_info->baud_base * 16;
>=20
> While uart_set_info() checks if (uartclk =3D=3D 0) and
> if (new_info->baud_base < 9600), when new_info->baud_base exceeds
> UINT_MAX / 16 with low bits set (for example, 0x10000001), multiplying
> by 16 wraps around in 32-bit unsigned arithmetic to a small non-zero valu=
e
> (16), bypassing both uartclk =3D=3D 0 and new_info->baud_base < 9600 and
> setting uport->uartclk =3D 16 (baud_base =3D 1, well below the required
> minimum of 9600 * 16).
>=20
> Reject new_info->baud_base > UINT_MAX / 16 alongside the uartclk =3D=3D 0
> check in uart_set_info().
>=20
> Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
> &ss) with ss.baud_base =3D 0x10000001 on /dev/ttyS1: on the unfixed kerne=
l
> TIOCSSERIAL succeeds (ret =3D 0) and wraps uport->uartclk to 16
> (TIOCGSERIAL reports baud_base =3D 1), whereas with the fix applied
> TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 6eabce6608d6 ("serial: core: check uartclk for zero to avoid divid=
e by zero")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v3:
> - Add missing #include <linux/limits.h> for UINT_MAX and move the
>   new_info->baud_base > UINT_MAX / 16 check to the uartclk =3D=3D 0 check=
, as
>   suggested by Ilpo J=C3=A4rvinen.
>=20
> Changes in v2:
> - Split out into patch 3/3 of the series, add Cc: stable@vger.kernel.org,
>   and document the QEMU test method, as requested by Greg Kroah-Hartman.
>=20
>  drivers/tty/serial/serial_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 3845fb582f45..362dd6648ba4 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -16,6 +16,7 @@
>  #include <linux/console.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
> +#include <linux/limits.h>
>  #include <linux/of.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/proc_fs.h>
> @@ -933,7 +934,7 @@ static int uart_set_info(struct tty_struct *tty, stru=
ct tty_port *port,
>  =09if (!(uport->flags & UPF_FIXED_PORT)) {
>  =09=09unsigned int uartclk =3D new_info->baud_base * 16;
>  =09=09/* check needs to be done here before other settings made */
> -=09=09if (uartclk =3D=3D 0)
> +=09=09if (uartclk =3D=3D 0 || new_info->baud_base > UINT_MAX / 16)

Logically it would make more sense to check the overflow before=20
multiplying even if this order too produces the "correct" result.

>  =09=09=09return -EINVAL;
>  =09}
>  =09if (!capable(CAP_SYS_ADMIN)) {
>=20

--=20
 i.

--8323328-1689351862-1790069257=:1233--
