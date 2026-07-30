Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA664582C7;
	Thu, 30 Jul 2026 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428373; cv=none; b=FYIboA7FJWJTUd1K4F5Xl9dv+5aujyqXEwQP/698+THkWjlpxaFmG+J99Z8yllvbQoEvbnjuRHpdXcn0S7w9qWeUsBLq4sqsaJZReiPTTDmt0S++RrokMmeACbREbakr417UWCNB1tJSXbSw2MxVPI178jyFH7FCvTYSPnqSSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428373; c=relaxed/simple;
	bh=mJ8j8Nmz2JpO/7PVWfAR6O9TOe5S6qTgsMX9KgEMIYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFi/wgdZN8NJDZwPkfqJTamzmxixzHcwuiskDqtXwbSCXo2ff1VX3KxabNlhsaxM9ysq+hzc1D4sFLeUXV4eFaLI19Hss92+iupY39n/YoR2Yt8TDeMh73esKaF5TaA00wu1qSJcoZcNcGkNaczVDAYxg0ztpKfIH2avN0p8p0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zHh13bmz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zHh13bmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECB71F000E9;
	Thu, 30 Jul 2026 16:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428372;
	bh=oDztMpVrZjPhlG/rj2No4txp57MTVa7kKFbZAh/zeu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zHh13bmzI92t+3W8b1KaaWj/GZMNr3348EsrOTD3m+xaTRL6mu/QGsDoie6UFdznM
	 idePGZLbhk492W5FZ9A7tHkyUYcSkzZI4oUF0+EgNpZWu6Xtdt0CztX9pWBZDSW+DK
	 GeF2HigfV9rrz270fsO+ZgQ/Y/w/XAiK9o4+7eUo=
Date: Thu, 30 Jul 2026 16:28:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] serial: core: clear freed pointers on
 uart_register_driver() failure
Message-ID: <2026073030-smother-rundown-c4b3@gregkh>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-3-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719221014.44354-3-kmehltretter@gmail.com>

On Mon, Jul 20, 2026 at 12:10:12AM +0200, Karl Mehltretter wrote:
> uart_register_driver() leaves freed pointers behind on failure. If
> tty_alloc_driver() fails, it frees drv->state without clearing it. If
> tty_register_driver() fails, it also drops the tty driver reference
> without clearing drv->tty_driver.
> 
> Several drivers register the uart_driver lazily and use drv->state as
> an "already registered" sentinel. After a failed registration, the
> next probe sees the stale pointer, skips re-registration and calls
> uart_add_one_port() with freed state.
> 
> The resulting unwind can call uart_unregister_driver() with a NULL or
> dangling drv->tty_driver and oops in tty_unregister_driver():
> 
>   Unhandled fault: page domain fault (0x01b) at 0x00000018
>   PC is at tty_unregister_driver+0x10/0x68
>   LR is at uart_unregister_driver+0x1c/0x60
> 
> Reproduced with failslab fail-nth injection on qemu's raspi1ap board:
> fail the tty_alloc_driver() allocation during a sysfs bind of the
> PL011 port, then bind again in the same boot.
> 
> Clear drv->state after freeing the state array and clear
> drv->tty_driver after dropping the tty driver reference, as
> uart_unregister_driver() already does.
> 
> The tty_register_driver() failure case predates Git history. The
> tty_alloc_driver() failure case was introduced by commit 9e845abfc8a8
> ("serial: fix NULL pointer dereference"), which made that error path
> return cleanly instead of crashing in put_tty_driver(NULL).
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 9e845abfc8a8 ("serial: fix NULL pointer dereference")
> Cc: stable@vger.kernel.org

Same comment here, this can't ever be hit by a "normal" user, right?

thanks,

greg k-h
