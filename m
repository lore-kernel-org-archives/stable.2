Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C63495504;
	Wed,  7 Oct 2026 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382398; cv=none; b=LViIy5T3v6E2K6JmhIsSrtMss/qPGD4sJ3JtxdjAys1aVX+qOGSyp1DArb5NOQcYjfIHTYps0NmSr6PaF6wshLMSRRBMRAy2JKRirXXEhRhdLzBQqvmQ6wzwHsLcvgGSVaCcLxiMQhTiAgHoUwdE7KI4J2UqDZS0QmCZ8yeUID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382398; c=relaxed/simple;
	bh=HiOi5e2T4x225gImL/TJWJ8DefHkXVdDKplaSxviIzI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ErDVGa9WgK+PC+n5cZLUXur9s3FQmlca+0LAhLLBCAHmQMBFJBXmEjgr0Vi2LPUYNbdNQLcIgkdRFipE91zb7sz1Wj4e8RZh2BZfylem5CODzzkr9aM6P7y96zWYDcXdsJcRPStS6UcowG+r8Hxlt+g7foMDJ/UBQzUxjU2jybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=BgtzNttB; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="BgtzNttB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=og/7X/CjUI0QTbRR3oumV+UU2alUYe1L0SW6ZkPwQAM=; b=BgtzNttBQNs2zSg2TxM81D+pk2
	B4k69hlrfZ/vktZL0kHeJHcYmMmvcQpZR+twOcxTl2KT47ihiHjq61pSAhzoHWsc1mqd8+hUWPGgA
	1+c2yiymnSxGsF7ijPoRtGx1EcUi/OwIShIOshfWFfSEUzDHozy2A2/5I70NNQhifxe8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xESOK-000000008MD-0enk;
	Wed, 07 Oct 2026 10:13:08 -0400
Date: Wed, 7 Oct 2026 10:13:07 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hui Peng <benquike@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v8 1/2] serial: core: fix baud rate fallback in
 uart_get_baud_rate()
Message-Id: <20261007101307.223cfb6fe59699a2b52eac1a@hugovil.com>
In-Reply-To: <20261007094719.1362769-2-benquike@gmail.com>
References: <20261007094719.1362769-1-benquike@gmail.com>
	<20261007094719.1362769-2-benquike@gmail.com>
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

On Wed,  7 Oct 2026 09:47:17 +0000
Hui Peng <benquike@gmail.com> wrote:

> When uart_get_baud_rate() evaluates a requested baud rate against a port's
> supported limits [min, max], the retry loop operates as follows:
>=20
>   try =3D=3D 0: Evaluates the requested baud rate. If out of range and an=
 old
>             termios is available, it switches termios to old.
>   try =3D=3D 1: If old is also out of range (or unavailable), the fallbac=
k rule
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

The loop terminates immediately after try =3D=3D 1. I see that below even
you acknowledge that fact. This is confusing and it does not
properly describe the current behavior. You should instead write
something like:

     try =3D=3D 2: no more action, the loop exit immediately

and adjust your other comments accordingly.


> However, because the current loop bound is for (try =3D 0; try < 2; try++=
),
> the loop terminates immediately after try =3D=3D 1 without executing try =
=3D=3D 2 to
> re-evaluate the clipped rate. Upon loop exit, the function hits WARN_ON(1)
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
Ilpo J=E4rvinen
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
>  	 * Ask the low level driver to verify the baud rate if it can't
>  	 * then it will have encode_baud_rate set the Closet else .
>  	 */
> -	for (try =3D 0; try < 2; try++) {
> +	for (try =3D 0; try < 3; try++) {
>  		baud =3D tty_termios_baud_rate(termios);
>=20
>  		/*
> --=20
> 2.47.3
>=20


--=20
Hugo Villeneuve
