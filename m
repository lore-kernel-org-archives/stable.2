Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2040DB3A;
	Thu,  1 Oct 2026 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844876; cv=none; b=SkzysiblMe/UKJuyVF9re9rCi1DNtOGSwmd4VuJaw14nBrACLqF/ANIGPOQnjK+dahTcHTaSmPve3Xf5pP/g3LceQRqVWyIj6eDWHL9PGCxrpT6LthgiTs3ckiaU1Kgj1paW3QPv7LPDSqyzqB8BeQViBCRZHaCIHRw+zVKBxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844876; c=relaxed/simple;
	bh=L6ngpHT3DfaWx4MSx08wIQBupXQ7J3Dcee/uRfV6umQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEXjkm0v+KDKsNRsqFvIBPtDwEjsIQjB+JOjaiLd6TZb12THHHPDzKen4PDrxN3fZqsYQwmcRnrOfmsZQtyRkJFutydCbG3LxgRZD2wv7Uf7ZTiq0UpS3B2XvrywsLRWxHsHz+XB8XidMLMvG/u6ASfEW3TBd3CG6wQOZ2HjXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XFJAI53X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XFJAI53X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02891F000FF;
	Thu,  1 Oct 2026 08:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790844874;
	bh=utC4V6cGBhGB1qaQwBhOVHBWZhYms2fuhFn3zzGNPPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XFJAI53XPiBv3Ta1PRWfCf8VI3GWiAVSTnbM+H6PYK5oJjPueYVMX+ERRpYbq9CRg
	 Iu+JtnOl/90F/TjnPgDW/kXSQFeIjCl7yzWbGjLgljFO9lSh4bV6GO5MdiDi31vzDu
	 PPwqxumSdESePtivJQWAHKX9MX/pLIz9HbboclX8=
Date: Thu, 1 Oct 2026 10:54:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hui Peng <benquike@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 1/2] serial: core: fix baud rate fallback in
 uart_get_baud_rate()
Message-ID: <2026100156-watch-balsamic-32db@gregkh>
References: <20260930125901.778868-1-benquike@gmail.com>
 <20260930125901.778868-2-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930125901.778868-2-benquike@gmail.com>

On Wed, Sep 30, 2026 at 12:59:00PM +0000, Hui Peng wrote:
> When uart_get_baud_rate() is called with a baud rate exceeding the port's
> maximum supported speed (port->uartclk / 16), it clips baud to [min,
> max - 1] and encodes it into termios via tty_termios_encode_baud_rate().
> 
> However, because the loop bound is for (try = 0; try < 2; try++), the
> loop terminates immediately after try == 1 without re-evaluating

But try == 1 should keep the loop going as it is < 2, right?  What am I
missing here?  Do I need more coffee?

> baud = tty_termios_baud_rate(termios) for the clipped rate, hitting
> WARN_ON(1) and returning 0, which then triggers a fatal divide-by-zero
> (Oops: divide error) in uart_get_divisor():
> 
>   WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_rate+0x136/0x260
>   [ ... ]
>   divide error: 0000 [#1] PREEMPT SMP KASAN
> 
> Increase the retry count in uart_get_baud_rate() from 2 to 3 iterations so
> that clipped baud rates are re-evaluated in the third iteration.

What is the magic 2 here, and why turning it into a magic 3 somehow fix
things?

thanks,

greg k-h
