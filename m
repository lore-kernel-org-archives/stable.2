Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F983CF69E;
	Wed, 30 Sep 2026 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762801; cv=none; b=Vld76rfucZ7qZzyo1SGe0j9ogmBPcelkHpj+qpit9f9uE55fMRK4X2u3pITKNh3SytIAOkCzGPk+A/O8QXOXYNKv6/krN9iUhOZQsut9Ml3PLTnP3xj0hFP8lvKrCjGty8hRV6x+fP86bV7cCNsWlMtDaTTpHZMnLypIxmcv/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762801; c=relaxed/simple;
	bh=6DKCuVzw+OC0gi/9qKgWQLqBPffB5qIdfI6pJ0FZkCI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S3ApcH0Ls1sV/5IHjqXKeJgleij/axy/G5bKyCwuznFGzCszqOr/uCG4knZ2hgyyIbsHVYsF9gQ1+fF8fS5bEH+gFjdbXtz09Pxu2oJYInZLMIf3/ViLMpthBMyO+t52rrDuKnoNof3jER9kXqJsvIyuoow/h9slwlwzwljhGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0SuuwFO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0SuuwFO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790762800; x=1822298800;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6DKCuVzw+OC0gi/9qKgWQLqBPffB5qIdfI6pJ0FZkCI=;
  b=e0SuuwFO5hL6Wd8zvpB556lC70NK+vgOzMYikuo0Tsv60tfkAMIDng+P
   o8gAHufWoWsFm4EXESsF7m2egL1allVua8+f3hnUbavpdCtm+ju1lK2M1
   Uv9ZLCLQYANy2Fjp1UlAv52kWP8ndeJWQJ5XUCqfas8KW0rKd0dEz1zxZ
   2XWJUjqagnZ8GcGv2yPHMFHeO8ExjoQRLoOpxqGEWzUzbJkDdk2xPz/rX
   EQPp0t96j9/lSJpa1nZ0I34OHStcoOBQqVhmgYnw3XFIhkioHjVi1nE/V
   E+j96XRyIdvmu4vf9eHHmfdDyQ0LGc4vo9nY1UvhyALpHnxnsn3nqGOVK
   w==;
X-CSE-ConnectionGUID: GBA3EjZbSbCJiTpnuSne7g==
X-CSE-MsgGUID: liwDvNAQThSRPz9zvlIZGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="94377840"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="94377840"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:06:40 -0700
X-CSE-ConnectionGUID: 3c5miMiZQKqRJM82ONPiOw==
X-CSE-MsgGUID: HQh3aW2VSY2F9sfdNdsxgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278854746"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:06:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 30 Sep 2026 13:06:33 +0300 (EEST)
To: Hui Peng <benquike@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/3] serial: 8250: hold hash_mutex across IRQ chain
 linking in serial_link_irq_chain()
In-Reply-To: <20260930041216.155911-2-benquike@gmail.com>
Message-ID: <494e613e-f841-9942-222c-1488c9802bb3@linux.intel.com>
References: <20260930041216.155911-1-benquike@gmail.com> <20260930041216.155911-2-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1871305287-1790762793=:1755"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1871305287-1790762793=:1755
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 30 Sep 2026, Hui Peng wrote:

> In serial_link_irq_chain(), serial_get_or_create_irq_info() acquires
> hash_mutex to search or allocate a chain instance and drops hash_mutex
> before returning.
>=20
> If a concurrent call to serial_unlink_irq_chain() runs immediately after
> serial_get_or_create_irq_info() returns while i->head is still NULL,
> serial_unlink_irq_chain() acquires hash_mutex, finds i with
> i->head =3D=3D NULL, frees the chain structure via free_irq() / kfree(),
> and removes it from the hashtable. serial_link_irq_chain() then
> proceeds to scoped_guard(spinlock_irq, &i->lock), dereferencing the freed
> chain pointer i and causing a slab use-after-free.
>=20
> Move guard(mutex)(&hash_mutex) to the beginning of
> serial_link_irq_chain() and rename serial_get_or_create_irq_info() to
> serial_get_or_create_irq_info_locked() so hash_mutex is held across the
> entire lookup, linking, and error-path unlinking sequence.
>=20
> Tested in QEMU against tip of mainline (62f4c998b297, "Merge tag
> 'parisc-for-7.3-rc5' of git://git.kernel.org/.../parisc-linux")
> with KASAN enabled by concurrently opening/closing 8250 serial ports
> sharing IRQ 4 (ttyS0 and ttyS2): on the unfixed kernel KASAN detects
> slab-use-after-free in serial_link_irq_chain(); whereas with this fix
> applied, port registration and unregistration run cleanly with 0 KASAN
> warnings.
>=20
> Fixes: e91f1ed6c24f ("serial: 8250: fix use-after-free in serial_link_irq=
_chain")
> Cc: stable@vger.kernel.org
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

I'm also pretty sure I've not given my tag for this so why did you add it?
Never invent Reviewed-by tags on your own.

--
 i.

> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v5:
> - Rebased cleanly onto tip of mainline commit 62f4c998b297.
> - Updated patch diff and commit description to align with upstream
>   guard(mutex) refactoring in 8250_core.c.
>=20
> Changes in v4:
> - No changes.
>=20
> Changes in v3:
> - No changes.
>=20
> Changes in v2:
> - Split out from monolithic patch into patch 1/3, add Cc: stable@vger.ker=
nel.org,
>   and document QEMU test procedure in commit message body, as requested b=
y
>   Greg Kroah-Hartman and John Ogness.
>=20
>  drivers/tty/serial/8250/8250_core.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index b875d394796f..e831a8fe9a95 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -130,12 +130,10 @@ static void serial_do_unlink(struct irq_info *i, st=
ruct uart_8250_port *up)
>   * - find the corresponding info in the hashtable and return it, or
>   * - allocate a new one, add it to the hashtable and return it.
>   */
> -static struct irq_info *serial_get_or_create_irq_info(const struct uart_=
8250_port *up)
> +static struct irq_info *serial_get_or_create_irq_info_locked(const struc=
t uart_8250_port *up)
>  {
>  =09struct irq_info *i;
>=20
> -=09guard(mutex)(&hash_mutex);
> -
>  =09hash_for_each_possible(irq_lists, i, node, up->port.irq)
>  =09=09if (i->irq =3D=3D up->port.irq)
>  =09=09=09return i;
> @@ -156,7 +154,9 @@ static int serial_link_irq_chain(struct uart_8250_por=
t *up)
>  =09struct irq_info *i;
>  =09int ret;
>=20
> -=09i =3D serial_get_or_create_irq_info(up);
> +=09guard(mutex)(&hash_mutex);
> +
> +=09i =3D serial_get_or_create_irq_info_locked(up);
>  =09if (IS_ERR(i))
>  =09=09return PTR_ERR(i);
>=20
--8323328-1871305287-1790762793=:1755--
