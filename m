Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286574;
	b=UjDOyRW5hu5ok/jsoectRJVH8req0eCMIERiqkuMqPSrCSbWybM4gbtQfKrmK8jC1prr
	 0hzqm3czvoPrRtsLFEvnUXIJH/xwA7qU8u+ijCKIK80eK6Djf6o+Jm61OEdGUwTpMRd74
	 /yw/jOgVd7V1K0av64dV26Xof+17Tx30G1oU9bSyPyfgYyzXIXuY8Qk0w0ex4Je2Rnwz8
	 2l28lzt0HI3ydVJrccdOz3f80jzrrDrrjFWtjwB5cWjD0NIhKcKFEqlTIOgRsf2GC4Tr+
	 yPUyo9W0tAZ2SSi3JVJJJYe77vvGHT6fuDSHOpihlJNTeLFOfOZwBmw5ZKSlsjAMwUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286574;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wJXojSw9qP8FXSFkukZa6P6UQUwCdSDvKOXG7gKlvXo=;
	b=CYkY0apg9r14r2gNghbtH5z8AJ3QqLPKMXUVnwlSs6a+PnYfpuLJ5zHDAnpTwsRkzc61
	 31ojpnTG1hs8j9BRiyDs0oXau1vbTg7lW5c3MVW3PG90zE8NNprPIO2iXdIoYy1YzYzw9
	 tpcqJoovxlacuzUsRGPI0BroITWH7H/qmdy2EGaIOTDZbfildni4G5RAjBpm55Me368dw
	 vWPR86xgdt6RUPQkOnFQ0kDIpEKEyZZt2VU0UFQtxu1rEvBEFn+ML2vZBUt03Ic3Hb4/6
	 8wGfvqmOzG7eai+VVZR6v21c/qpzoH8muPLS9FrzqehalE9FlWw2UogMc/PDYWy0M+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwAJsR1u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9814606A31A;
	Thu, 29 Oct 2026 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwAJsR1u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8381F01825;
	Thu, 29 Oct 2026 15:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286573;
	bh=wJXojSw9qP8FXSFkukZa6P6UQUwCdSDvKOXG7gKlvXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FwAJsR1uCat1zYnUc+9XrIUng8neQ93WX+oJssSQamxW7XdsWlDgN2JbP4Q/fVdeg
	 cGP7Ts7Jpfw1soWH5FYzXJxIjoNYoLRjnKI3BIactUd/IotJC27t1+Y1AZiUWcuifT
	 nfZCYKYy78ooamMwd9jJ2W9YmbdCwJu6rsgnuZCaES/h5usStyw77SCMkSDxyQVFGz
	 yLqkwlgbJcOXMD7bltLghjynLWfua13ASHisU91N5CmOOLGPMJRsmfM9hJCD5s1UVu
	 hEr9oJpUCCpIrTGjLpfvCTLs9cXkyw3XNa7EzlmKCNqa/CyNMoosK+l4cLt8p44XuA
	 d2ERAS5go1XhQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xMRkx-00000004AY3-0fIU;
	Thu, 29 Oct 2026 16:09:31 +0100
Date: Thu, 29 Oct 2026 16:09:31 +0100
From: Johan Hovold <johan@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kevin Lloyd <linux@sierrawireless.com>, linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v2] USB: serial: sierra: validate URB length in instat
 callback
Message-ID: <auNhq32ChleGKQWz@hovoldconsulting.com>
References: <20261019103849.3716324-1-tristmd@gmail.com>
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
In-Reply-To: <20261019103849.3716324-1-tristmd@gmail.com>

On Mon, Oct 19, 2026 at 10:38:49AM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> sierra_instat_callback() reads request fields and one byte past the
> usb_ctrlrequest header without first checking that urb->actual_length
> is large enough.  A short USB interrupt transfer could cause an
> out-of-bounds read.
> 
> Add two length checks matching the pattern already present in the
> option driver (option_instat_callback): one for the request header
> before accessing bRequestType, and one for the line-state data byte
> inside the serial-state notification handler.  Use dev_err() since
> failing these checks causes the interrupt URB not to be resubmitted.
> 
> Fixes: 033a3fb980b041 ("USB: Sierra Wireless driver update")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v2 (Johan Hovold):
>  - Split into two checks: one for the header before accessing
>    bRequestType, and one for the line-state data byte inside
>    the serial-state handler, matching the option driver pattern
>  - Use dev_err() instead of dev_dbg() since early return prevents
>    further interrupts

Thanks for the update.

Now applied, with one change below.

>  drivers/usb/serial/sierra.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
> index 6e443aacae07d..03ed76dfbb2e3 100644
> --- a/drivers/usb/serial/sierra.c
> +++ b/drivers/usb/serial/sierra.c
> @@ -575,10 +575,23 @@ static void sierra_instat_callback(struct urb *urb)
>  				__func__);
>  			return;
>  		}
> +		if (urb->actual_length < sizeof(*req_pkt)) {
> +			dev_err(&port->dev, "%s: short transfer\n",
> +				__func__);
> +			return;
> +		}
>  		if ((req_pkt->bRequestType == 0xA1) &&
>  				(req_pkt->bRequest == 0x20)) {
>  			int old_dcd_state;
> -			unsigned char signals = *((unsigned char *)
> +			unsigned char signals;
> +
> +			if (urb->actual_length < sizeof(*req_pkt) + 1) {
> +				dev_err(&port->dev,
> +					"%s: short interrupt transfer\n",
> +					__func__);
> +				return;
> +			}
> +			signals = *((unsigned char *)
>  					urb->transfer_buffer +
>  					sizeof(struct usb_ctrlrequest));

I used sizeof(*req_pkt) here too for consistency.

Johan
