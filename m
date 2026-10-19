Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF22CCC5;
	Mon, 19 Oct 2026 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392076; cv=none; b=RAKPrfFrD94qO06rdxozgzWEPteP21RvuWmBNgcdNlIvqHBgk2nSL3oQKq3kuRa3nh3a9A8gbqXmSXggZ0CvuDa3JPTshVD2vou8gN/UUJRkTbXrFPb5QotnfHZ7nLiqDEXI3rEfKSrc8fccmaPVbISkAGL3fGB3X7B+l4EgcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392076; c=relaxed/simple;
	bh=OUrPHmI6Hj2h9GuMtErdolX43eYievuSKqRX8w69rB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObtSQocuucOQH5oGnaH/uUzJ46bKBxb/hR0zshQXiTMbM1/VUXi4AVBMzp904DuwQZybl1CKGQxizeZBiJaOgK2Yp4UySC4t/fhbSGbwq+kKWuQFNBTU3nwBziol37xXnKj2gTAhtS7YcjNSfecWL+6n3/C6XS/I/hkvY5kHmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVWskY5B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVWskY5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3E31F000C5;
	Mon, 19 Oct 2026 06:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392075;
	bh=8rlJyYYqoynaDBHY/RyxVb+fpxwBNW99WhPCl+Cu8l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KVWskY5BFDjT5FEBQqJo3bs0JEeRWpWg0cyCbQVniVyjTHdgP6+BDt3QLF09788lY
	 1TgMCi1Codt+3jzVTLYvxxMsJdydI5+VjNP+GUag/I43xl71YnN2DwTiijuMoQYDlg
	 YAStOSFMwmxih2Lhv9APqMk/wzeWMW/gTHWqfnDrg7AD0kV4K3PWYlFWkNp8zWa+72
	 WLivDrWk/SukZ9AKu+05pmFj+L2WhnEF0WHlRKotPGY85Hh+/gPxsehCuxzOxvzoZW
	 Mcjl/uGpJc4W/Bk/qopDCnxDy/hviflCc8lGxdaNy+KziRTYBd3rPA/CxwgRQOMrPV
	 iTwRasb7obkzQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xIh3Y-000000086Ow-3cFq;
	Mon, 19 Oct 2026 08:41:12 +0200
Date: Mon, 19 Oct 2026 08:41:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kevin Lloyd <linux@sierrawireless.com>, linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] USB: serial: sierra: validate URB length in instat
 callback
Message-ID: <atW7iCuqfmpJ5pp8@hovoldconsulting.com>
References: <20261018223352.2021650-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018223352.2021650-1-tristmd@gmail.com>

On Sun, Oct 18, 2026 at 10:33:52PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> sierra_instat_callback() reads one byte past the usb_ctrlrequest
> header at offset sizeof(struct usb_ctrlrequest) without first
> checking that urb->actual_length is large enough to contain it.
> A short USB interrupt transfer could cause an out-of-bounds read.
> 
> Add a length check matching the pattern already present in the
> option driver (option_instat_callback), which validates the same
> field access.
> 
> Fixes: 033a3fb980b041 ("USB: Sierra Wireless driver update")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/usb/serial/sierra.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
> index 6e443aacae07d..8f800cde25229 100644
> --- a/drivers/usb/serial/sierra.c
> +++ b/drivers/usb/serial/sierra.c
> @@ -575,6 +575,11 @@ static void sierra_instat_callback(struct urb *urb)
>  				__func__);
>  			return;
>  		}
> +		if (urb->actual_length < sizeof(*req_pkt) + 1) {
> +			dev_dbg(&port->dev, "%s: short interrupt transfer\n",
> +				__func__);
> +			return;
> +		}

This silently breaks a theoretical device that submits requests without
payload not yet handled by the driver (the else branch below).

Please split this up in two checks; one for the header and one for the
line state data as in the option driver.

And since you prevent any further interrupts if you ever hit this, you
should use dev_err().


>  		if ((req_pkt->bRequestType == 0xA1) &&
>  				(req_pkt->bRequest == 0x20)) {
>  			int old_dcd_state;

Johan
