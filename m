Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38854705C;
	Sun, 11 Oct 2026 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791696923; cv=none; b=Y3F38xfPvAvF8U9h5EQcG5j52S6Rjy6Oz9VPxe5EukBWHudvr6DOBDkqqKWMXs4a3QmrV70N2KSVFHBR41xn3VNZYjerKOJApZ3uYR8Ti7X7jhd+ORzqHLiJ01u5pWDBFwTnjwYyaA8+HCqtmwxDb5EgYdQUYnioJzxB0OD2NnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791696923; c=relaxed/simple;
	bh=7c/Cj/0XytUFwQSK2ygFR7SIok+7xy4th3rKk++nBBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YViAWU+BNukASxzQhI02yv3tItxyzuN0Lbjiyc5CTIT7o5wPndywykvbeYqALb6fOS/Inka+V5CxE8ZWk7TnbRM1Ffx50r+YdQK/6oQH7DBZB3p6fWChauONDtMDDAMJcE7bxXLWKFOeVNu4vXkuYe7BY6Hs7Mpdenqn5j3qVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyXcIhdr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyXcIhdr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF831F0089B;
	Sun, 11 Oct 2026 05:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791696922;
	bh=hbSUbxPwLBAuGQ/briyqGpW3Pv/LLcuhKOxbSlYjBoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dyXcIhdr4ZdBdew3SQOWprLrrzTVQmsEm/WYH0Uh9b+MRfMO5b0HXhb70m7I/B1io
	 DTwjlqP5I0LjDuEsGxSfNhrBmu6MemCxPaw278f9DHmrNER7OsoFGRO97Aqd0mWXUn
	 ZPkd2v3WeMGle9PbUzeYpQu9DiaebpWl9YIb0WjI=
Date: Sun, 11 Oct 2026 07:35:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ferry Toth <ftoth@exalondelft.nl>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Revert "serial: 8250_port: Drop duplicate NULL
 check"
Message-ID: <2026101151-regroup-caterer-b92d@gregkh>
References: <20261010193755.187706-2-ftoth@exalondelft.nl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010193755.187706-2-ftoth@exalondelft.nl>

On Sat, Oct 10, 2026 at 09:37:56PM +0200, Ferry Toth wrote:
> This reverts commit 7885af04df6e4efd72910200c1bfc079d61202e4.
> 
> Commit 7885af04df6e ("serial: 8250_port: Drop duplicate NULL check")
> added `up->dma = NULL;` to serial8250_release_dma(), with the stated
> intent of making sure DMA would not be used again after release.
> 
> However, up->dma is assigned once at probe time.  serial8250_do_startup()
> only calls serial8250_request_dma() when up->dma is non-NULL, so after
> the first close the pointer stays NULL and DMA is never re-acquired.
> 
> On Intel Tangier (Edison) with HSU DMA this causes a regression: the
> first port open uses TX DMA, the second and later opens transmit in PIO
> mode, producing 64-byte FIFO bursts with ~50us gaps between them.

Ugh, sorry about missing that.  I'll queue this up when I get a chance
in the next few days, thanks for posting it.

greg k-h
