Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528953EC684;
	Thu,  1 Oct 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844613; cv=none; b=m6Dq0Z1A8D8wlsWwkkfu+1ZkKW4rvsH3Lebkvcw3HyZX3l9vv3lO5QOIBd2C5E4bzm84OMkJ+9LLzCZfpTnTKkegh0++McFD6fFl1HdAuRS0U8NT4pBiAYAINOLl3R8veeQimiCo8tyW3NKCtkbqmMUpqmj5M2hDG7xv7cxZUas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844613; c=relaxed/simple;
	bh=pxUzKT425ODQD3RlKjWqvW2ou19MMC+s5ZTzGwRIumk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hco7CZzM7oC1h6XB0tB6ot7fWb/zX2Z/sN52dZ8w7ioBg3T6AjNMpN6tqHu2K8X/lpgsm1OItHMD2vhhMfBuuPLRSPBGtDrOSI9wvLeXoBgvpOq8vIhHusKlLnsqWjDerXJJCtLUalKUN0J01T1nkzPqF1UA6HVzfcIyKmEmpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JPTyr9/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JPTyr9/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483741F000FF;
	Thu,  1 Oct 2026 08:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790844611;
	bh=Xt/qPIC7xIUoeVEu27a44z9OYbE4U4n6riy6EtW3WXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JPTyr9/aIwPTkz4BBavBehl9c6+SMAmta7nZXlP5rIMrUOPDJ9CB3oVC/N1bSrvtR
	 Erop4lMBBua+FO9L7ZpRb6DJctUYIZdobq6Bv718mqAgqsPGo/oog0a6qj5U3ETXw1
	 28rgiw//yXKj7DH5rYFQuIcfSekiGpW6y/6xDyh0=
Date: Thu, 1 Oct 2026 10:50:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hui Peng <benquike@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 0/2] serial: core: fix baud rate fallback loop and
 baud_base overflow
Message-ID: <2026100102-retract-colonial-3ceb@gregkh>
References: <20260930125901.778868-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930125901.778868-1-benquike@gmail.com>

On Wed, Sep 30, 2026 at 12:58:59PM +0000, Hui Peng wrote:
> This series addresses two issues in serial core:
> 1. Division-by-zero WARN/Oops during baud rate fallback in uart_get_baud_rate().
> 2. 32-bit unsigned overflow in uart_set_info() when multiplying new_info->baud_base by 16.
> 
> Note on v6 1/3:
> Patch 1/3 from v6 ("serial: 8250: fix deadlock in serial8250_register_ports")
> has been dropped. The hash_mutex race condition was originally found and
> reproduced on Linux 6.18.14 (where guard(mutex)(&hash_mutex) was dropped
> inside serial_get_or_create_irq_info() before serial_link_irq_chain() linked
> the port). We did not realize that it was already fixed in mainline by
> commit b339809edda1 ("serial: 8250: use guard()s"), which refactored to
> serial_get_or_create_irq_info_locked() with guard(mutex)(&hash_mutex) moved
> into serial_link_irq_chain(). Apologies for the noise in v6 1/3.
> 
> All remaining patches are ported to the latest tip of mainline (551c722f4080)
> and dynamically verified in QEMU KVM with CONFIG_KASAN=y.
> 
> Changes in v7:
> - Dropped patch 1/3 (already resolved in mainline).
> - Clarified in cover letter that 1/3 was found and reproduced on 6.18.14 and
>   we did not realize it was already fixed in mainline.
> - Retained patch 1/2 and patch 2/2 using check_mul_overflow() as requested
>   by Jiri Slaby.
> 
> Hui Peng (2):
>   serial: core: fix baud rate fallback in uart_get_baud_rate()
>   serial: core: reject baud_base values that overflow port->uartclk in
>     uart_set_info()
> 
>  drivers/tty/serial/serial_core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> -- 
> 2.47.3

You have sent 3 versions of this series in one day.  Please relax and
slow down.  I've now deleted all of these patches from my review queue.
Please wait a few days, take the time to make sure the submission is
correct, and then send a new version.  Don't overwhelm reviewers without
helping them with review of other submissions, to do otherwise is not
very kind.

thanks,

greg k-h
