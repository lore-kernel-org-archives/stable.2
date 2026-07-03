Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023563845D5
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 05:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057751; cv=none; b=uQqwt3otU2RggUdf5ofQwylkOWHYzGsaCZbniRN68rqhs8VPEHlilB0z15M5bPMIjD1yEUMcJORjlwua/HojS0ivy8vMGWZuIDVshUiuSZUIuwTMeUEOkb3jzjucacMor48TO8126OyLK9Gw65MhOG1W0mnOTLFR9GQW7YfDR1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057751; c=relaxed/simple;
	bh=KHMiOO8pe2aqxs7efuP2gne6h5icOVRvsvGu0tgqYMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqF8OEITbq2pHDYexnb6cJ+ybl+Q21J70zVesKYjLsvoqPDfM0V3tuHSfDi1PDdj+lylncYDxx5xVWfhWpFnvTWlNmIQ1jvfZUHE2w28oKPwpulyC0gXM53YQbTcVtpVZYeuCfWictpHz8d+NA+3mfSuxCNZdjdcxHUJV2MzhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=advU/LRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="advU/LRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B461F000E9;
	Fri,  3 Jul 2026 05:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783057739;
	bh=DEGjoqjPcIPmYqvgZrYrIG+p7VdrLCFjG3UQIW8DMoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=advU/LRGaeIdUspm9HdpEyXD7p1PD6ot2CN5OXkqCO2RT8jkxusBRCbZkhbqugqfr
	 z4WKiOuAPZ3GEUSLSzACZk6VUpTJnXrcqF5zCx+r70usRv7csanoOAWfRCkyzs6Iwk
	 xA3jKkWgFmJtfMMThBfv8aBgnh7AG58sAPJFXHh4=
Date: Fri, 3 Jul 2026 07:49:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sonali Pradhan <sonalipradhan@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_ncm: validate datagram bounds in
 ncm_unwrap_ntb()
Message-ID: <2026070359-uselessly-staging-f506@gregkh>
References: <20260703051945.1691028-1-sonalipradhan@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703051945.1691028-1-sonalipradhan@google.com>

On Fri, Jul 03, 2026 at 05:19:45AM +0000, Sonali Pradhan wrote:
> When unpacking host-supplied NTBs, ncm_unwrap_ntb() checks datagram length
> against frame_max but does not verify that the datagram fits within the
> declared block length. Additionally, when decoding multiple NTBs from a
> single socket buffer, subsequent block lengths are not checked against the
> actual remaining buffer data.
> 
> With these checks missing, a malicious USB host can specify datagram
> offsets and lengths that point beyond the block, or supply secondary NTB
> headers declaring lengths larger than the buffer. skb_put_data() then
> copies adjacent kernel memory from skb_shared_info into the network skb.
> 
> Fix this by verifying that sufficient buffer space remains for the NTB
> header before parsing, handling zero-length block declarations, ensuring
> that block lengths never exceed the remaining buffer space, and verifying
> that each datagram payload stays strictly within the block boundary.
> 
> Fixes: 427694cfaafa ("usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call")
> Fixes: 2b74b0a04d3e ("USB: gadget: f_ncm: add bounds checks to ncm_unwrap_ntb()")
> Cc: stable@vger.kernel.org
> Assisted-by: Jetski:Gemini-2.5-Pro
> Signed-off-by: Sonali Pradhan <sonalipradhan@google.com>
> ---
>  drivers/usb/gadget/function/f_ncm.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
> index c5bf8a448d64..64eabda2f546 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -1189,6 +1189,10 @@ static int ncm_unwrap_ntb(struct gether *port,
>  	frame_max = ncm_opts->max_segment_size;
>  
>  parse_ntb:
> +	if (to_process < (int)opts->nth_size) {
> +		INFO(port->func.config->cdev, "Packet too small for headers\n");
> +		goto err;
> +	}
>  	tmp = (__le16 *)ntb_ptr;
>  
>  	/* dwSignature */
> @@ -1209,8 +1213,12 @@ static int ncm_unwrap_ntb(struct gether *port,
>  	tmp++; /* skip wSequence */
>  
>  	block_len = get_ncm(&tmp, opts->block_length);
> +	if (block_len == 0)
> +		block_len = to_process;
> +
>  	/* (d)wBlockLength */
> -	if ((block_len < opts->nth_size + opts->ndp_size) || (block_len > ntb_max)) {
> +	if ((block_len < opts->nth_size + opts->ndp_size) || (block_len > ntb_max) ||
> +			(block_len > to_process)) {
>  		INFO(port->func.config->cdev, "Bad block length: %#X\n", block_len);
>  		goto err;
>  	}
> @@ -1273,7 +1281,7 @@ static int ncm_unwrap_ntb(struct gether *port,
>  			index = index2;
>  			/* wDatagramIndex[0] */
>  			if ((index < opts->nth_size) ||
> -					(index > block_len - opts->dpe_size)) {
> +					(index > block_len)) {
>  				INFO(port->func.config->cdev,
>  				     "Bad index: %#X\n", index);
>  				goto err;
> @@ -1285,7 +1293,8 @@ static int ncm_unwrap_ntb(struct gether *port,
>  			 * ethernet hdr + crc or larger than max frame size
>  			 */
>  			if ((dg_len < 14 + crc_len) ||
> -					(dg_len > frame_max)) {
> +					(dg_len > frame_max) ||
> +					(dg_len > block_len - index)) {
>  				INFO(port->func.config->cdev,
>  				     "Bad dgram length: %#X\n", dg_len);
>  				goto err;
> @@ -1310,7 +1319,7 @@ static int ncm_unwrap_ntb(struct gether *port,
>  			dg_len2 = get_ncm(&tmp, opts->dgram_item_len);
>  
>  			/* wDatagramIndex[1] */
> -			if (index2 > block_len - opts->dpe_size) {
> +			if (index2 > block_len) {
>  				INFO(port->func.config->cdev,
>  				     "Bad index: %#X\n", index2);
>  				goto err;
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
