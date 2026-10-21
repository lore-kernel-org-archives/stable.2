Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600450;
	b=iF/0M6bgidfEdSPmEsiXP3zNVGMYI0BYtErXA19QjH8REXjGufQlscErpayLqYs2gka3
	 Qo7gm+fCkYYrhRKkaLq0hSFb73hFiJJ3zkWDJz1x5DPpiO69i0emuj+T3MPKWwQlXvKdS
	 Jt+xwvXBZpn6YWNyrQLEjh0iJmb98+r1ZY+ed1SbFSr17MYxmWLXyE1WJTOmGYUhsDvTW
	 vfpGtOYhlEwqROv1ON3yhH+U6eMipMYtExBSu2vi93yUKlqfXMYkfd6IiVLza0jIU6EiL
	 uBGS366k1jRMoqNO3tvFpdZoyrHGqul2JkeFS5zz7B8vBYt3m59XKa1Zt2i8huteFTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600450;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=odKDNtkbaGsEGggup2G4St8tDApvqwrM08BGj9fz1M4=;
	b=RRE1YmP06s5cMqGm+ggc4Oolo1p60Q9Nbz2PlD6WOzrrLQk/MgsDR/ZlrubzoDtChIPT
	 aaSoaZHkpO6PkZe/TkFciNjk331tL+0+xK3Hxyc0C7yaJLsZeYpdNPD1/sSfX0mBYH6hC
	 dMzBbzKKTE92QmDW5A0G/j447enJPULZf/4VnKm90nfdBalmiD90FTKdxNZlIepvV/de/
	 Se9Icm2kykFYF77UD3Jn3mKR5B37oSdgR3s+uCLHQIh9e80Dxo7fHNbPNY4NITPBYAE+W
	 Z27emTv9RZitrzKa9OOtPwP7cXNZxVPLHnKZ9bG2M7GgnwbtwfSk6j5i562CFzEbdaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkCb19Sz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F81606A31E;
	Wed, 21 Oct 2026 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkCb19Sz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D121F000C1;
	Wed, 21 Oct 2026 16:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792600449;
	bh=odKDNtkbaGsEGggup2G4St8tDApvqwrM08BGj9fz1M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YkCb19SzDz6qagE2Nr1xchf+djbBXfpDC/l/TbrhNWwywPm3vOQakNq6+aT3p0qFA
	 ktTUjo5KinGKz+ApjNUWIbdgZjjPavKuDEkfgpG8bnpS8pph2KrO+5RpYBqOpCV54e
	 ksjUpfJq+ub0PkGp5o9WD8EG8vUa1LXp3ibGVdRWtJSPymP0gUaqGtfajoJjqJwJ8E
	 CO8ovjJPIgRl5xnyuxtBDxXF2HyHWxWAW0JxMX/PZYgZj41MX9Bed3AJ/Of62b1gp4
	 U5wCfKOAI1v2Apmiifutz8HgpTLRpxH5DLbqLH4hB+QIg9bLn+/TlKfByaAPxAKIEc
	 l+9Nck/vCeAGw==
Date: Wed, 21 Oct 2026 17:34:05 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Corey Minyard <corey@minyard.net>,
	Huacai Chen <chenhuacai@kernel.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 02/28] mfd: ls2kbmc: Unregister GPIO GSI via
 devm_add_action_or_reset()
Message-ID: <20261021163405.GI1795367@google.com>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-2-lee@kernel.org>
 <atjEyo2VkaJuecMh@ashevche-desk.local>
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
In-Reply-To: <atjEyo2VkaJuecMh@ashevche-desk.local>

On Wed, 21 Oct 2026, Andy Shevchenko wrote:

> On Wed, Oct 21, 2026 at 12:09:24PM +0000, Lee Jones wrote:
> > ls2k_bmc_init() unconditionally calls acpi_unregister_gsi() immediately
> > after requesting the GPIO interrupt via devm_request_irq().  This
> > prematurely disposes of the active IRQ mapping while the interrupt
> > handler remains registered, breaking the GPIO watchdog interrupt and
> > causing a use-after-free when devres later frees the disposed IRQ
> > descriptor on probe failure or device unbind.
> > 
> > Register a devm_add_action_or_reset() callback before devm_request_irq()
> > so that acpi_unregister_gsi() is invoked only after devres has freed the
> > interrupt.
> 
> ...
> 
> > Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
> > Closes: https://sashiko.dev/#/bug/linux-cab8bfb6-4077-46f3-a173-ac2e2042cf66
> 
> Don't we use the official Sachiko's email in Reported-by tag?
> Reported-by: Sashiko <sashiko-bot@kernel.org>

Roman suggested Closes: when I reached out.

-- 
Lee Jones
