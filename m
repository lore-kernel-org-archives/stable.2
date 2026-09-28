Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A75364E9E;
	Mon, 28 Sep 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598294; cv=none; b=bKY4ONGx4Et205JyVcl01HNiQE3FO7QpdVVfi0s4mrF29qSrNTYyrNoFJZClid5P9OIjOtrozr7gDokEgAu2vJP/IQP20VQykFLPhKDVoKvn6irj3OQ3oZmDWFbT94tmglzEl3Fv0j1Sr9ZuITP/OU9g7SdCRN4/xkJhOe2bM/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598294; c=relaxed/simple;
	bh=4ovbDUsZ9LUqVK5e2/PLj0fDDC6fZoSvBhWUl/P+DLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxRprUZS6mHJpHmE2qRF4U5TEARsZkNBXo1hmDM3plgsxdyT0ws7Am9lyoPl/LhkmR0zG75BzH7LBidBjcDerybjfJ727vUAB4qs+VS16pLRezAV3WrwRvI1FKoPDavwTWKpu1uQIpGyWAHErxZpK3TXAQ1hnZ40pAr48wvVKzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LANcxJMc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LANcxJMc"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5197E8FD;
	Mon, 28 Sep 2026 14:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790598181;
	bh=4ovbDUsZ9LUqVK5e2/PLj0fDDC6fZoSvBhWUl/P+DLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LANcxJMcRYDjix8dLB/j0nrbBRgD5P27HY88j+jDO8/Fm/9J3Z3tiQ9OdHW5MNGFA
	 Ksq4V1eVnBM+zfaMa+Ck6nzWbZ0CKQaiXuGVcmV7qtcQdSZG11a9YPy42+SrBmBh77
	 3RmZ0bDuOZ3oZebppIOgjYWQB/w7JqbWk/vhAYgc=
Date: Mon, 28 Sep 2026 15:24:50 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Laurent Pinchart <laurent.pinchart@skynet.be>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Fix bounds for descriptor parsing
Message-ID: <20260928122450.GA166131@killaraus.ideasonboard.com>
References: <20260911-uvc-ctrl-bound-v1-1-7b5cfc68bae1@chromium.org>
 <20260928120252.GB4406@killaraus.ideasonboard.com>
 <CANiDSCv5pd-3aO0Eb1-rvsAOGNpB4rhpjtnTosU6Ca+xBxN1qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCv5pd-3aO0Eb1-rvsAOGNpB4rhpjtnTosU6Ca+xBxN1qQ@mail.gmail.com>

On Mon, Sep 28, 2026 at 02:10:26PM +0200, Ricardo Ribalda wrote:
> On Mon, 28 Sept 2026 at 14:02, Laurent Pinchart wrote:
> > On Fri, Sep 11, 2026 at 01:23:50PM +0000, Ricardo Ribalda wrote:
> > > uvc_parse_control() passes descriptor by descriptor to
> > > uvc_parse_standard_control() with the number of bytes remaining in the
> > > buffer, not the number of bytes of that descriptor.
> > >
> > > Because of this, malformed descriptors could leak over the next
> > > descriptor, leaving malformed data in our structures.
> >
> > What issue does this fix in practice ?
> 
> Look into uvc_parse_standard_control().
> Let's take the UVC_VC_HEADER
> 
> Imagine we have a malformed control at the beginning of the descriptor that has:
> 
> buffer[0] = 3
> buffer[2] = UVC_VC_HEADER
> buffer[3] => Beggining of next control
> 
> With the current code, buffer[3...X] is parsed as UVC_VC_HEADER.
> 
> What does it fix in practice? It avoids that data outside the controls
> is parsed as part of the control.

I understand that, but what does it fix in practice ? And have you
encountered a device that exhibits such a problem ?

> > > Change the code so we pass the actual length of the descriptor to the
> > > parser.
> > >
> > > Note that this makes the existing check more strict and some devices
> > > that are wrongly parsed today will not be probed now.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_driver.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > index e289cc71ba98..429f1ab19a2a 100644
> > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > @@ -1248,11 +1248,14 @@ static int uvc_parse_control(struct uvc_device *dev)
> > >        */
> > >
> > >       while (buflen > 2) {
> > > -             if (uvc_parse_vendor_control(dev, buffer, buflen) ||
> > > +             if (buflen < buffer[0] || buffer[0] < 3)
> > > +                     return -EINVAL;
> > > +
> > > +             if (uvc_parse_vendor_control(dev, buffer, buffer[0]) ||
> > >                   buffer[1] != USB_DT_CS_INTERFACE)
> > >                       goto next_descriptor;
> > >
> > > -             ret = uvc_parse_standard_control(dev, buffer, buflen);
> > > +             ret = uvc_parse_standard_control(dev, buffer, buffer[0]);
> > >               if (ret < 0)
> > >                       return ret;
> > >
> > >
> > > ---
> > > base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> > > change-id: 20260911-uvc-ctrl-bound-9c1940f06fc7

-- 
Regards,

Laurent Pinchart
