Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15D24B827A;
	Mon, 28 Sep 2026 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596978; cv=none; b=Wv3CKhyobObRYIJlSDTAUD46K6dF+AEXn1+4lBrO4WvWZYRRf38bo9xTlrVT/gvF66EPcINALZdaY45/ELIHHt260Xezy7wIRyYknh4Il7azPNSJ+1iXepffbsHFB6AMSb6yW9YibLxqk0MW6e+PtHgWqFz6WTAEoGttXRAGv1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596978; c=relaxed/simple;
	bh=sHiFuAgIrzDmApValHknsaNy8FJJYWo/uqBLxF0S+/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbsRax37jvC8gDM3eivSfdv9gO9HqMqsUJVAn1UTEeK939qdQsWievpJtg0jihxb5yDQE7b7zRYTnsTm/QjLSdHtXvVtmoMZ/o8rB7XmLXIJysvxtgEMT17hRX2tGB0dSv2K9nkriVZQB6ZjCC04XffFEnKo3JBH/NfGHqdTyTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=srdDpZO3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="srdDpZO3"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C6E413D9;
	Mon, 28 Sep 2026 14:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790596864;
	bh=sHiFuAgIrzDmApValHknsaNy8FJJYWo/uqBLxF0S+/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srdDpZO3SCn8FcDmnMxNdyNCL5bEPjxJSh3PQOR7zXP60gyfUkwfyQohWA8D07fhM
	 ICzVjFd33rzWZqz0G3YDFxshOdB3WeTer5PlFHN/0J1XPse5lmEEo/lrV1D00H0295
	 z9dd3sUQ9yjfTUX/BeHbPJNjOsjUb36MFl2GWLpw=
Date: Mon, 28 Sep 2026 15:02:52 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Laurent Pinchart <laurent.pinchart@skynet.be>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Fix bounds for descriptor parsing
Message-ID: <20260928120252.GB4406@killaraus.ideasonboard.com>
References: <20260911-uvc-ctrl-bound-v1-1-7b5cfc68bae1@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911-uvc-ctrl-bound-v1-1-7b5cfc68bae1@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Fri, Sep 11, 2026 at 01:23:50PM +0000, Ricardo Ribalda wrote:
> uvc_parse_control() passes descriptor by descriptor to
> uvc_parse_standard_control() with the number of bytes remaining in the
> buffer, not the number of bytes of that descriptor.
> 
> Because of this, malformed descriptors could leak over the next
> descriptor, leaving malformed data in our structures.

What issue does this fix in practice ?

> Change the code so we pass the actual length of the descriptor to the
> parser.
> 
> Note that this makes the existing check more strict and some devices
> that are wrongly parsed today will not be probed now.
> 
> Cc: stable@vger.kernel.org
> Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index e289cc71ba98..429f1ab19a2a 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1248,11 +1248,14 @@ static int uvc_parse_control(struct uvc_device *dev)
>  	 */
>  
>  	while (buflen > 2) {
> -		if (uvc_parse_vendor_control(dev, buffer, buflen) ||
> +		if (buflen < buffer[0] || buffer[0] < 3)
> +			return -EINVAL;
> +
> +		if (uvc_parse_vendor_control(dev, buffer, buffer[0]) ||
>  		    buffer[1] != USB_DT_CS_INTERFACE)
>  			goto next_descriptor;
>  
> -		ret = uvc_parse_standard_control(dev, buffer, buflen);
> +		ret = uvc_parse_standard_control(dev, buffer, buffer[0]);
>  		if (ret < 0)
>  			return ret;
>  
> 
> ---
> base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> change-id: 20260911-uvc-ctrl-bound-9c1940f06fc7

-- 
Regards,

Laurent Pinchart
