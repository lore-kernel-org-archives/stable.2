Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989379;
	b=ldVhfjP08voR9gYOs9MRGRiZ0kLRKZU5s0SHwMYq7DxYX5Dbsr9R0hDc4eFvIw+mmqJ1
	 +2/17E0KVeEtPoh9q2rrzcTxAd47c9A1tIb4d4HN5aoyIzdh8iR6SLTxBhkfg8ksxi3z+
	 eKhl+ay5tdpNoEd9oASZHilprshCHwYvAQAQRv+6+SzJjRO/tyNsHvtVFObJkZjjP9rBa
	 ddmdaWuJw7LPSKKtB9hBJzdaEaZaxjIvF9d09WL3WFRCYMAC+4G/vZC1vHeUTFiTVbGiJ
	 Ee0T0cYjMfT8ruqrfhJKidsMhyDrPDuJu7LA06dcCNUvXXfssbhfgm0MXqngSKK9dsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989379;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rke1jdyO0lEsHXkbA0Ck5uBcUmcwEIzcVtlXtGAvOMc=;
	b=rLNyB4OFu1zyMOIj6zrIm4Bny13N2PH0XOuH5Yzwm9rsLeFM6TilNugs06V751wuaQtO
	 EJZn1oo35QVf3TOWstuGr1x4z8dC3RZhOXpldLoLN6sZM4qxNnmHlJ/+267o7JN4ec4O3
	 QzTZ+L/IF7ydTFezuNmnFs8VIJBw9ezlLwEmqtLhl0pmrYNDTrGAxBhoNQ1DRiFUyqm3U
	 iX+mh4jUFYXYh4EMJfzwHiG5dNLg9B6429Udqmx21RG7+7CHOGsHnlMRzPAj1BK2Stv3y
	 CO7XEaIjdrJ72rZCaysPQtAV7FGnUC0rQ5cGdtRaDbbatFYFntYi7+rsX7pNII+Eqyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=atIC1J0O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA2A606A31C;
	Wed, 18 Nov 2026 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=atIC1J0O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D09C1F000C4;
	Wed, 18 Nov 2026 08:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794989378;
	bh=rke1jdyO0lEsHXkbA0Ck5uBcUmcwEIzcVtlXtGAvOMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=atIC1J0OqWYKVwOz0tH9WxpUvE0UoD2jC98wXxwhFMDaCDQyveYploMvpwDxu0xGa
	 cIhdPBLRFmDdps0x2CXTTeCVd1MdVSSE7ivYVRykhuJCCLSn8AN2ixkMyHCdxIYUdu
	 y1198oNCCvDHFJQui1UJSAcZOB3b8dacVMDlRzQo=
Date: Wed, 18 Nov 2026 09:09:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ziheng Wei <zihengw03@163.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] parport: do not re-enable interrupts in
 parport_claim()
Message-ID: <2026111830-doorstep-aloha-5faf@gregkh>
References: <20261118075816.2323688-1-zihengw03@163.com>
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
In-Reply-To: <20261118075816.2323688-1-zihengw03@163.com>

On Wed, Nov 18, 2026 at 03:58:16PM +0800, Ziheng Wei wrote:
> When the claiming device was on the wait list, parport_claim() takes
> it off the list with spin_lock_irq()/spin_unlock_irq() while it holds
> cad_lock with interrupts disabled:
> 
>   parport_claim()
>     |
>     | write_lock_irqsave(&port->cad_lock)     <- IRQs off, cad_lock held
>     | spin_lock_irq(&port->waitlist_lock)
>     | spin_unlock_irq(&port->waitlist_lock)   <- IRQs on too early
>     |
>     +---- port interrupt on this CPU ----+
>     |                                    |
>     |                                    v
>     |                        parport_irq_handler()
>     |                          read_lock(&port->cad_lock)
>     |                          spins forever: cad_lock is held
>     |                          by the code it interrupted
>     |
>     | write_unlock_irqrestore(&port->cad_lock)  <- never reached
> 
> Interrupts are already disabled here, so use spin_lock()/spin_unlock(),
> like the "blocked" path in the same function.
> 
> Found by LLM-assisted static analysis.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

So, this isn't a real issue given that no one has actually noticed it in
20+ years?

> Cc: stable@vger.kernel.org
> Signed-off-by: Ziheng Wei <zihengw03@163.com>
> ---
> 
> Notes:
>     v2: shorter changelog; drop the kernel test robot tags.
>     
>     The bug was found by the static analysis above.  The kernel test robot
>     had sent a smatch warning for the same code to oe-kbuild only, which I
>     found afterwards and credited in v1:
>     https://lore.kernel.org/r/202608091622.jlJn0jOj-lkp@intel.com/
>     
>     Tested in QEMU (parport_pc) with two ppdev users, one waiting in
>     PPCLAIM while the other releases the port: lockdep warns without this
>     patch and is quiet with it.  I have no parallel port hardware.

Then maybe this isn't a real issue?

>     On real hardware this needs two users of the same port and a port
>     interrupt within a few microseconds of the hand-over, so it is
>     unlikely to be hit; lockdep reports it whenever the path runs.

parport devices should not be used by 2 users at once.  If you do so,
you get to keep the broken pieces :)

thanks,

greg k-h
