Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595643;
	b=MTpiZrr3J+Aqu1zohS3/eAqzCgrpUN0Iiy0rCT/HphWRQ9z7czK3zmgLC6PWXJyKwpo7
	 X1e1JUB3F61GdmzfIrEcm8zCVrsz54ZeNlcYEKadF/7LvCO59VhByWj8I0dxVGp888IcC
	 gIlFasRUAV3sGUtZ3ZtfBjtuXOWw7SDktTJRxYWnNqMVye7+X6J6UyOWXu9SB1Sy5t7or
	 SA8pKEfzZVim/m2H02L80G14ar4nYmAQbslCY8D3bzbdtjzSbvtcYvX0BJTMlNDxPLo4C
	 4HWkFCmxcAlg1R47li/+zXi88M3lP7ub8zIrNU1iwUVflyTg1lVqX03XKZ+18UWTI0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595643;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Geg0b6hH0eRWbQ8qY3ctgtGMd48jkOfdfrZ5jdS1AfA=;
	b=Sbu/FP6x6d6BCFXNzghI7cY8u2PeK8/Fbqi/5F0CoJCPHOe7O6qkExjyriNqurH3nWZ8
	 88Ii4/jRhdSHnn1J+JPbb4ckBp89IEbMbgowHRMqc6uWefVRTPW0vsdevAhLbbj4pQtYd
	 mBxc3o8ner01TXbC+fT8iMOhrixJyMcSDf5IDNuGTcex9xiyIylhaqFQxwoT5xKO3iW+h
	 wfETp97MfqBnH5HtP8F6OlCgfZo+f/R9hpaf2mw4sazI4g0Yo7Gzt6zSXzGRmZjmTueLz
	 2mzX6jffYRViUB30HaDW+CV2vw+trv4CftSzS93sGiWE9UvELNha3pd5NZUMwufaNFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZBRvbacT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00307606A31E;
	Wed, 25 Nov 2026 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZBRvbacT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88661F000C4;
	Wed, 25 Nov 2026 08:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795595642;
	bh=Geg0b6hH0eRWbQ8qY3ctgtGMd48jkOfdfrZ5jdS1AfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZBRvbacTGHYypVUHep4fR/X31LXmnYm6QANb0EmRexJanIagXSB7dDE4RDI8mWXTi
	 qJs3rZxPUq3lTBMZBrH+3rEXBUHEZitrx7awfw8qoqbE+X8iv6ar4/tKA1g4gemJrw
	 ESHWWeUPTfsI+YagWbQDJiq6bGqVfgkMJaqQt+eA=
Date: Wed, 25 Nov 2026 09:34:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhu GuangLei <zhugl3@xiaopeng.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	liuwb@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH] misc/pvpanic: share the shutdown handler across devices
Message-ID: <2026112504-halves-payer-1293@gregkh>
References: <20261125080635.112699-1-zhugl3@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125080635.112699-1-zhugl3@xiaopeng.com>

On Wed, Nov 25, 2026 at 04:06:35PM +0800, Zhu GuangLei wrote:
> Each pvpanic device registers its own power-off handler at
> SYS_OFF_PRIO_LOW. register_sys_off_handler() accepts only one handler
> per non-default priority, so when a second pvpanic device is probed the
> registration fails with -EBUSY and the driver logs "Could not register
> sys_off_handler". The handler that did get registered notifies every
> device on the list, but it is owned by the first device. Once that
> device is unbound, or its shutdown event is masked through sysfs, the
> handler is unregistered and the remaining device stops reporting
> shutdowns even though its events mask still has PVPANIC_SHUTDOWN set.
> 
> Register a single handler for the driver and keep it as long as at
> least one device has the shutdown event enabled. Serialize updates of
> the events mask and of the handler registration with a mutex. The
> panic and power-off paths still take only the list spinlock, so access
> the events mask with READ_ONCE()/WRITE_ONCE().

If a spinlock is used, why is the read/write once stuff needed?

> The shutdown event only reaches pvpanic when no higher priority
> power-off handler, such as the ACPI one, turns the machine off first.
> Tested on a v6.18 based guest booted with acpi=off under QEMU 8.2.2
> (TCG) with two pvpanic-pci devices created with events=7: after
> unbinding the first device and powering off, QEMU did not receive the
> shutdown byte (0x4) without this change and does receive it with it.
> Masking the shutdown event on a single device still suppresses the
> write.
> 
> OpenAI Codex was used to write the code change and the QEMU test
> scripts, and to run the tests. GitHub Copilot was used to review the
> change and to rewrite this changelog.
> 
> Fixes: 7b51b1373321 ("misc/pvpanic: add support for normal shutdowns")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhu GuangLei <zhugl3@xiaopeng.com>
> ---
>  drivers/misc/pvpanic/pvpanic.c | 56 ++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index 3d43045bf..ed7a01d45 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -16,6 +16,7 @@
>  #include <linux/limits.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/panic_notifier.h>
>  #include <linux/platform_device.h>
>  #include <linux/reboot.h>
> @@ -35,12 +36,14 @@ struct pvpanic_instance {
>  	void __iomem *base;
>  	unsigned int capability;
>  	unsigned int events;
> -	struct sys_off_handler *sys_off;
>  	struct list_head list;
>  };
>  
>  static struct list_head pvpanic_list;
>  static spinlock_t pvpanic_lock;
> +static DEFINE_MUTEX(pvpanic_sys_off_lock);
> +static struct sys_off_handler *pvpanic_sys_off_handler;
> +static unsigned int pvpanic_sys_off_users;
>  
>  static void
>  pvpanic_send_event(unsigned int event)
> @@ -51,7 +54,7 @@ pvpanic_send_event(unsigned int event)
>  		return;
>  
>  	list_for_each_entry(pi_cur, &pvpanic_list, list) {
> -		if (event & pi_cur->capability & pi_cur->events)
> +		if (event & pi_cur->capability & READ_ONCE(pi_cur->events))
>  			iowrite8(event, pi_cur->base);
>  	}
>  	spin_unlock(&pvpanic_lock);
> @@ -86,30 +89,34 @@ static int pvpanic_sys_off(struct sys_off_data *data)
>  	return NOTIFY_DONE;
>  }
>  
> -static void pvpanic_synchronize_sys_off_handler(struct device *dev, struct pvpanic_instance *pi)
> +static void pvpanic_set_events(struct device *dev, struct pvpanic_instance *pi,
> +			       unsigned int events)
>  {
> -	/* The kernel core has logic to fall back to system halt if no
> -	 * sys_off_handler is registered.
> -	 * When the pvpanic sys_off_handler is disabled via sysfs the kernel
> -	 * should use that fallback logic, so the handler needs to be unregistered.
> -	 */
> -
>  	struct sys_off_handler *sys_off;
>  
> -	if (!(pi->events & PVPANIC_SHUTDOWN) == !pi->sys_off)
> -		return;
> -
> -	if (!pi->sys_off) {
> -		sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_LOW,
> +	mutex_lock(&pvpanic_sys_off_lock);

guard()?

> +	if ((pi->events ^ events) & PVPANIC_SHUTDOWN) {
> +		if (events & PVPANIC_SHUTDOWN)
> +			pvpanic_sys_off_users++;
> +		else
> +			pvpanic_sys_off_users--;
> +	}
> +	WRITE_ONCE(pi->events, events);

As you have a global lock here, again, why is WRITE_ONCE() needed?

thanks,

greg k-h
