Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6FB305680;
	Mon,  3 Aug 2026 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768856; cv=none; b=XQlqtKsR2CEV2/G2W7Whcgxy5ycqjNd1RCPIRaSJsmKy9f/P1h4QCynzOuLQpbf1TmWLGNB4oKI8ypCUXXLyVJ4js/WA7a2n64m6G+04/2rrIg1wWw8MMA4iGwK7tmWuFg3MQxwAoMaqqg5kEF8Ud2bWCty3nf5HMWHw4nPs83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768856; c=relaxed/simple;
	bh=bn9DntWmYHX7rjqyF2E8Zl/GfronaN47+0YjZ0pG1R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEkqyuFG7n3nCg6U9ekK/PnwHRJPOaCVWkrjCHofyaIE+Sm5I4mSVe14Lw9BF7hBAlBUC+xEpr9Koz4BWbDzsAihDlPRGHU2RndBeGOV14o/JArLDceCtkUIM8kwYzhIMD3tNN+6b2MFz9O2lZl5WF9aImfRRZhmuntoNqG97sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fNMCSboL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fNMCSboL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A471F000E9;
	Mon,  3 Aug 2026 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785768854;
	bh=LWWMyiRyHQgnIeqT2FsVGOyXULdTvyWYrbxiNMTKbzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fNMCSboL3Q4QfowHWSTQl4JGBKt7K2MpilPyyL7bcEHAJ9Nj8N/OlLUXPRngp3m9w
	 e5ZCPSNNOmvz2UDmhRh7vDfrEaBgLlJVOr472RvCkZocJKhbOAHnLjJTXPhwpAeJDd
	 mUggtZjIrCuWKohhfIobaJuy6Cuv1c3MMYitaG2s=
Date: Mon, 3 Aug 2026 16:53:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4 5/5] serial: imx: serialize imx_uart_ports[] lifetime
Message-ID: <2026080341-agreeing-context-ca78@gregkh>
References: <20260731181844.11330-1-kmehltretter@gmail.com>
 <20260731181844.11330-6-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731181844.11330-6-kmehltretter@gmail.com>

On Fri, Jul 31, 2026 at 08:18:44PM +0200, Karl Mehltretter wrote:
> imx_uart_probe() publishes its devm-allocated port in imx_uart_ports[]
> before uart_add_one_port() because console setup uses the table. The entry
> is not cleared when adding the port fails or after removal, leaving a
> dangling pointer.
> 
> A sibling probe can register the shared console through that stale entry.
> This was reproduced under KASAN on QEMU mcimx6ul-evk by unbinding a
> sibling UART, unbinding the console UART and rebinding the sibling.
> 
> Keep the entry valid through uart_remove_one_port(), then clear it. Protect
> port addition and removal together with their table updates so sibling
> operations cannot interleave. Reject an occupied slot rather than
> clobbering an active port during a duplicate-line probe.
> 
> Fixes: dbff4e9ea2e8 ("IMX UART: remove statically initialized tables")
> Fixes: 9f322ad064f9 ("imx: serial: handle initialisation failure correctly")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260719162850.043B41F000E9@smtp.kernel.org
> Link: https://lore.kernel.org/all/20260719222501.CB4CB1F000E9@smtp.kernel.org
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Backport note: the removal fix is self-contained. Complete probe-failure
> coverage also requires patch 1. With patch 1, all fallible allocations
> precede console registration, so rollback can safely clear the table.
> Without it, a late allocation failure (only reachable with fault
> injection) can leave the console registered after imx_uart_ports[] is
> cleared, turning the pre-existing use-after-free into a NULL
> dereference.

None of these should probably be backported, so this should be ok :)

thanks,

greg k-h
