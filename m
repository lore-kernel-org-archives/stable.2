Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173AF2FDC20;
	Tue,  6 Oct 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300999; cv=none; b=R2FJMA9NPbLr7BYTm0AazD2wzViIPIyPBoP+k/2nwLMoqJS+pria3o1a0u1h65kVVSZzMvK2Ayr0M9JKkSPx2IUnPTbLsHXVL//4zS7we5up2CvB5vZ64hGp6MEclZdwNbc1075fnYizgMa+1CqAxRHBZjlHCySgSmF7Hrs3tvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300999; c=relaxed/simple;
	bh=4Wx6FlxLELJH4KUGi3iAA9os2hDmzpV95j74p16rwA8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ui/b3JL52tmnZfqfzxGwREesE5mHNTsfsDPBhNyHkHTiZuSV+AxBSLzBx67bxLGpMnTNrJ4ITdk3S+gCO46OdDjJUxrhGk/w0sEW/quZE7bAEbFyEHB0/8TyCO2a9Sfg56zzWDTJwQv/hi1/0Z7ZMx58cdS8VWWwuNQpxvo8yjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=XK1u3Slw; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="XK1u3Slw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=+8CSBT2OQAOa7nJB3rRl2U1wh9CwAZDl+AQNBGfWpBE=; b=XK1u3Slw/qXMmriQFbFmg1ehMb
	srmBpIViseRWCKIRL2StJpRLyv0VEY3k5SVbGEGN4Q2CPyoznmyN+F74TyZiCt7SvdVaOtDRPGPMZ
	9AaWcoHkXC/Lrl65iob7y8g4NlOJaSK4VhXCuzr6IstSovPgE7RvjqbxhYRTVCxIhO5k=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xE7DV-000000007NO-1cs1;
	Tue, 06 Oct 2026 11:36:35 -0400
Date: Tue, 6 Oct 2026 11:36:34 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hui Peng <benquike@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v7 2/2] serial: core: reject baud_base values that
 overflow port->uartclk in uart_set_info()
Message-Id: <20261006113634.67dcefd86c007e115a5fa150@hugovil.com>
In-Reply-To: <20260930125901.778868-3-benquike@gmail.com>
References: <20260930125901.778868-1-benquike@gmail.com>
	<20260930125901.778868-3-benquike@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam_score: -2.0
X-Spam_bar: --

Hi Hui,

On Wed, 30 Sep 2026 12:59:01 +0000
Hui Peng <benquike@gmail.com> wrote:

> In uart_set_info(), new_info->baud_base is multiplied by 16 and stored in
> uport->uartclk (an unsigned int):
>=20
>   uport->uartclk =3D new_info->baud_base * 16;
>=20
> While uart_set_info() checks if (uartclk =3D=3D 0) and
> if (new_info->baud_base < 9600), when new_info->baud_base exceeds
> UINT_MAX / 16 with low bits set (for example, 0x10000001), multiplying
> by 16 wraps around in 32-bit unsigned arithmetic to a small non-zero value
> (16), bypassing both uartclk =3D=3D 0 and new_info->baud_base < 9600 and
> setting uport->uartclk =3D 16 (baud_base =3D 1, well below the required
> minimum of 9600 * 16).
>=20
> Use check_mul_overflow(new_info->baud_base, 16, &uartclk) in
> uart_set_info() to reject overflowing baud_base values with -EINVAL.
>=20
> Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
> &ss) with ss.baud_base =3D 0x10000001 on /dev/ttyS1: on the unfixed kernel
> TIOCSSERIAL succeeds (ret =3D 0) and wraps uport->uartclk to 16
> (TIOCGSERIAL reports baud_base =3D 1), whereas with the fix applied
> TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 6eabce6608d6 ("serial: core: check uartclk for zero to avoid divid=
e by zero")

The final statement that returns zero baud rate was already present
before 6eabce6608d6. My commit added the warning, so I am not
sure if this additional Fixes tag is justified?


> Cc: stable@vger.kernel.org
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v7:
> - Use check_mul_overflow() instead of raw UINT_MAX / 16 comparison as
>   suggested by Jiri Slaby.
>=20
>  drivers/tty/serial/serial_core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 6ed0195e6912..9a8f4c2e1180 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -14,6 +14,7 @@
>  #include <linux/tty_flip.h>
>  #include <linux/serial_core.h>
>  #include <linux/console.h>
> +#include <linux/overflow.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> @@ -931,9 +932,11 @@ static int uart_set_info(struct tty_struct *tty, str=
uct tty_port *port,
>  	old_custom_divisor =3D uport->custom_divisor;
>=20
>  	if (!(uport->flags & UPF_FIXED_PORT)) {
> -		unsigned int uartclk =3D new_info->baud_base * 16;
>=20
>  		/* check needs to be done here before other settings made */
> -		if (uartclk =3D=3D 0)
> +		unsigned int uartclk;
> +
> +		if (check_mul_overflow(new_info->baud_base, 16, &uartclk) ||
> +		    uartclk =3D=3D 0)
>  			return -EINVAL;
>  	}
> --=20
> 2.47.3
>=20


--=20
Hugo Villeneuve
