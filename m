Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13D395AD3;
	Wed, 30 Sep 2026 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754976; cv=none; b=Ce2p1+FtqDrwsV6mE9EWhK0aEf/0if3J6X982f7VJmS9FUw8JOmUzPOtFNbVuAIHBNVYRxVkxrZXEO76rXfZoBtQ/dohNlOlIwmc6VxHDvVsF4hfVzhBcovw8nnk01QjKEdxBJzcE8rz2hgUU1qekdkf2o0w0XzaBfwPpHoRUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754976; c=relaxed/simple;
	bh=KpaEsrlUIGwpgZy6iLE59SqczMf8bYPC4Mgghmu/w98=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lh6RkObJKJEw7v0dkHymZU5oGoKLXQtrxORIHQJMIky0jfSY3owFS3Vjr+C840FPRyqyxEY/BwpoJ9xdpIAsfoP81wDZ+LnEw5zjcAZlCWjBhExEKQrKJPv5pv0GgZdRGYPIaxN0GdhUcI3xfjYyvUycDnfmV6s7yvPmCbUAHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/re3Auo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/re3Auo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790754976; x=1822290976;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KpaEsrlUIGwpgZy6iLE59SqczMf8bYPC4Mgghmu/w98=;
  b=j/re3Auo+vvY4impejJa5YPBSR57DpHIF1To7HtJkJ0zzZ/Ip7BTiLY8
   oitJKNE8/1StBOGx09VfgRGDGS/Pd+MNG/3NcyUOFy55vwlJnKwr2lxLO
   5moT1IPryRRVqJ7axO0LhKY87Z/l8O8Ab+dna4mm9zmeO+cLjyYgMOW8B
   XCha9KIodAOUyLK5AmJ61VRZTEhJpwzpPONkPAvVcAYJ7JRBv66NlR0rm
   NvimGC0IE0pXIMQGFEGHtqhmHuy4Ol9+WmHMYIoUJ4Iv0lJtSBzoM0DNh
   QtlR/X1oJVyBnYehwbWqO9nqYH+Ibr4WGT/98gDEoheHkzUCwrb4F9rCk
   Q==;
X-CSE-ConnectionGUID: vQ/AViCsSwKais0Q0vkfow==
X-CSE-MsgGUID: u/MKe6UiSQmQzlyItjbMbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="101650262"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="101650262"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:56:15 -0700
X-CSE-ConnectionGUID: IqIvYnFoQk29k1eBr03rKg==
X-CSE-MsgGUID: 1vh1+5m+TKiiUkzLatiVUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274225643"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:56:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 30 Sep 2026 10:56:08 +0300 (EEST)
To: Hui Peng <benquike@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/3] serial: 8250: fix deadlock in
 serial8250_register_ports()
In-Reply-To: <20260930074850.465003-2-benquike@gmail.com>
Message-ID: <5cd2e684-d213-b841-3435-5f69411b75c9@linux.intel.com>
References: <20260930074850.465003-1-benquike@gmail.com> <20260930074850.465003-2-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-776957803-1790754968=:1755"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-776957803-1790754968=:1755
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 30 Sep 2026, Hui Peng wrote:

> In serial8250_register_ports(), mutex_lock(&hash_mutex) is acquired while
> holding spinlock_t serial_port_lock during IRQ chain registration:
>=20
>   spin_lock_irqsave(&serial_port_lock, flags);
>   mutex_lock(&hash_mutex);
>=20
> Acquiring a sleeping mutex while holding a spinlock causes a
> sleeping-while-atomic bug and potential deadlock.
>=20
> Replace mutex_lock(&hash_mutex) with spin_lock_irqsave() in
> serial8250_register_ports().
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 9e4f5a2a2eaa..f64a1b0a2eaa 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -102,9 +102,9 @@ static void serial8250_register_ports(struct uart_dri=
ver *drv,
>  =09struct uart_8250_port *up;
>=20
>  =09for (i =3D 0; i < nr; i++) {
> -=09=09up =3D &serial8250_ports[i];
> +=09=09up =3D &serial8250_ports[i];
>  =09=09up->port.dev =3D dev;

You failed to check what garbage AI outputted for you? Please, please=20
don't waste our time sending unfiltered AI output.

--=20
 i.

--8323328-776957803-1790754968=:1755--
