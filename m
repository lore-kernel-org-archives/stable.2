Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450A73ADB98;
	Thu, 24 Sep 2026 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250044; cv=none; b=H/RG16kTxPHoyvt3ATuogpF1DPyqMBqXbfrMYdaPu9p4mRkk3HVdLRST8816Uav9NlpfiR8FaKXxbegFOwEEnqxz+G04R/6uJyrShybC1+yG1e6OI6jRV9q0qs6x+ua1m2+pCYVMCqzGnT6YW6z8F7T9VYHTKUEQ0qK9a1CBoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250044; c=relaxed/simple;
	bh=LI65mtCnBcAAZ+mIIBZkm54ZhyyssX97Tme+Lzrpx88=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EKZLYOx4+uc33IVWqW3DLWSZ1mk/7SacLLQegCsaqROVCwx68GM+4r9fDLXGXeKZxM93EZ5WODq45DqAccu5PIKtAWTHxa2ItOG2iAg/FdZdQ29+VQ5uGTK1o9i2KC+vgvEIczq5DZbpyKkrK+U90B/uWVb73ShsDy7/EAMTKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECWpVYQu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECWpVYQu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790250042; x=1821786042;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LI65mtCnBcAAZ+mIIBZkm54ZhyyssX97Tme+Lzrpx88=;
  b=ECWpVYQu6WbMY4Z7eR0Kqs9GAPdRd2PEghS9VBvHxRaHpwdc3lrPEio+
   3PdL4I00uk8KYbv+M3UG29hp69RHNm/1PsNB9sts68TOvWuGxG3MVxr6z
   J7sjOiA0CdBTMQAc2HP9JR68YyLdpHH5eCRkPyF3j+RIr9I3FrOLaisGz
   +01WbjSDAyxku7Dh0XJnOh87uVBj5u9mDbcW/BDHDNhK4Czqhct0Sw+VO
   HRBs9QLWwDLxWCDn9dfOZoDciMDOLKyuScfkV+Ypn2qV7YaH1bVyiTomI
   5D+jYLZtg/+gUoAz0FxUE6hWP2nTWv4VKqVD8UdjHGEQeh4S5xvT9YyuA
   A==;
X-CSE-ConnectionGUID: P7B1x5BxT2qPBuwBgzL3ew==
X-CSE-MsgGUID: IGviOJjPSiidT9lOZx7V7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90243367"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90243367"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 04:40:36 -0700
X-CSE-ConnectionGUID: YnsHjVvZS/ONfe4m/RJdJw==
X-CSE-MsgGUID: suiSdnqSSr+9FqtUjJtuXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="277158463"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 04:40:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 24 Sep 2026 14:40:29 +0300 (EEST)
To: Hui Peng <benquike@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4 3/3] serial: core: reject baud_base values that overflow
 port->uartclk in uart_set_info()
In-Reply-To: <20260924065510.2587569-1-benquike@gmail.com>
Message-ID: <5e819651-e077-d7a1-d950-752e3320a436@linux.intel.com>
References: <20260924060511.2364717-1-benquike@gmail.com> <2026092417-seducing-stank-af6d@gregkh> <20260924065510.2587569-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1169037781-1790250029=:1187"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1169037781-1790250029=:1187
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Sep 2026, Hui Peng wrote:

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
> Reject new_info->baud_base > UINT_MAX / 16 before multiplying by 16 in
> uart_set_info().
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
> Changes in v4:
> - Check new_info->baud_base > UINT_MAX / 16 before multiplying by 16,
>   as suggested by Ilpo J=C3=A4rvinen.
>=20
> Changes in v3:
> - Add missing #include <linux/limits.h> for UINT_MAX and move the
>   new_info->baud_base > UINT_MAX / 16 check to the uartclk =3D=3D 0 check=
, as
>   suggested by Ilpo J=C3=A4rvinen.
>=20
>  drivers/tty/serial/serial_core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 95774b0f1484..75bb1eaa27e7 100644
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
> @@ -931,8 +932,13 @@ static int uart_set_info(struct tty_struct *tty, str=
uct tty_port *port,
>  =09old_custom_divisor =3D uport->custom_divisor;
> =20
>  =09if (!(uport->flags & UPF_FIXED_PORT)) {
> -=09=09unsigned int uartclk =3D new_info->baud_base * 16;
> +=09=09unsigned int uartclk;
> +
>  =09=09/* check needs to be done here before other settings made */
> +=09=09if (new_info->baud_base > UINT_MAX / 16)
> +=09=09=09return -EINVAL;
> +
> +=09=09uartclk =3D new_info->baud_base * 16;
>  =09=09if (uartclk =3D=3D 0)
>  =09=09=09return -EINVAL;
>  =09}
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1169037781-1790250029=:1187--
