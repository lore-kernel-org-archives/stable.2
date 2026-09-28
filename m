Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2C4D7D54;
	Mon, 28 Sep 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624705; cv=none; b=Z9lOa7IrWtMcht1TmgT3WMOmwWVYNk1jFvBcWg9Mf1GZvJU03pt8U5b01MBe3rgZ4iGFzmRZHThdVfsvnvimO27ubfyAI3oiDCYOqXAR+BCfe/dyQ0NlxNT7elpBS/W/w221RyqY2pcwPjox7a2MCo6j3ImuG16mA2wZbmsl4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624705; c=relaxed/simple;
	bh=hCvew7md2wIV0ECyy4McQ/lsCTk4EqOcyRtTij05xfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjbrTUmf2w2XuVDHPksf9BqG90+UmIWPZDKumYPnDJeqGjtkE/tiVRR+gWRh0Fkuzk3zAoUXabtdybstIu7cH9m1Q+FxjkxAwFmw0cSpfT1C7FgKQCHHKEGwzwUnHY+tf3r/TAk+4noTrDzJ6de749ensKDVibb1OOVRXl00GtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=g9p7R7QU; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="g9p7R7QU"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 91288B07;
	Mon, 28 Sep 2026 21:43:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790624590;
	bh=hCvew7md2wIV0ECyy4McQ/lsCTk4EqOcyRtTij05xfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9p7R7QU4hq68nKGF89plMhaDxFtRRBK8CGzDRi/zzJNZhmMqVl19k0d1TNTh58M1
	 mCckzKdKgd4TfO+0zj3kpVO1H2WZJpftALWzwbQbMQC9ielJRiGE9VI6DCbTixF8i0
	 9/cHlf6JDxitffi57ZW2kSEnSXDuOm1yJrMXusPE=
Date: Mon, 28 Sep 2026 22:44:59 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Laurent Pinchart <laurent.pinchart@skynet.be>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Fix bounds for descriptor parsing
Message-ID: <20260928194459.GH210522@killaraus.ideasonboard.com>
References: <20260911-uvc-ctrl-bound-v1-1-7b5cfc68bae1@chromium.org>
 <20260928120252.GB4406@killaraus.ideasonboard.com>
 <CANiDSCv5pd-3aO0Eb1-rvsAOGNpB4rhpjtnTosU6Ca+xBxN1qQ@mail.gmail.com>
 <20260928122450.GA166131@killaraus.ideasonboard.com>
 <CANiDSCuBFLYXFbq7Vox7AhdhftfzC9Ga6FKL-2F1o08cHQjoAA@mail.gmail.com>
 <20260928124109.GF157191@killaraus.ideasonboard.com>
 <CANiDSCvvJd0_taNYvHm894kPpyOWQ+TaxC_XRVOs5qrUHod08Q@mail.gmail.com>
 <20260928184429.GE210522@killaraus.ideasonboard.com>
 <CANiDSCs8N-m1F7LMuerVbYF8xrBPBeVTg2_UX4p6M7g=9yz_Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCs8N-m1F7LMuerVbYF8xrBPBeVTg2_UX4p6M7g=9yz_Sg@mail.gmail.com>

On Mon, Sep 28, 2026 at 09:03:41PM +0200, Ricardo Ribalda wrote:
> On Mon, 28 Sept 2026 at 20:44, Laurent Pinchart wrote:
> > On Mon, Sep 28, 2026 at 04:03:15PM +0200, Ricardo Ribalda wrote:
> > > On Mon, 28 Sept 2026 at 14:41, Laurent Pinchart wrote:
> > > > On Mon, Sep 28, 2026 at 02:35:29PM +0200, Ricardo Ribalda wrote:
> > > > > On Mon, 28 Sept 2026 at 14:24, Laurent Pinchart wrote:
> > > > > > On Mon, Sep 28, 2026 at 02:10:26PM +0200, Ricardo Ribalda wrote:
> > > > > > > On Mon, 28 Sept 2026 at 14:02, Laurent Pinchart wrote:
> > > > > > > > On Fri, Sep 11, 2026 at 01:23:50PM +0000, Ricardo Ribalda wrote:
> > > > > > > > > uvc_parse_control() passes descriptor by descriptor to
> > > > > > > > > uvc_parse_standard_control() with the number of bytes remaining in the
> > > > > > > > > buffer, not the number of bytes of that descriptor.
> > > > > > > > >
> > > > > > > > > Because of this, malformed descriptors could leak over the next
> > > > > > > > > descriptor, leaving malformed data in our structures.
> > > > > > > >
> > > > > > > > What issue does this fix in practice ?
> > > > > > >
> > > > > > > Look into uvc_parse_standard_control().
> > > > > > > Let's take the UVC_VC_HEADER
> > > > > > >
> > > > > > > Imagine we have a malformed control at the beginning of the descriptor that has:
> > > > > > >
> > > > > > > buffer[0] = 3
> > > > > > > buffer[2] = UVC_VC_HEADER
> > > > > > > buffer[3] => Beggining of next control
> > > > > > >
> > > > > > > With the current code, buffer[3...X] is parsed as UVC_VC_HEADER.
> > > > > > >
> > > > > > > What does it fix in practice? It avoids that data outside the controls
> > > > > > > is parsed as part of the control.
> > > > > >
> > > > > > I understand that, but what does it fix in practice ? And have you
> > > > > > encountered a device that exhibits such a problem ?
> > > > >
> > > > > I have not encountered such devices, but even if they do not exist
> > > > > they are easy to emulate and use for escalation.
> > > >
> > > > That's what I'd like to understand, can this be used for any kind of
> > > > escalation ?
> > >
> > > It is very difficult (impossible?) to prove that something is not
> > > exploitable, especially as the code evolves.
> >
> > Regardless of whether or not all the bytes parsed by the
> > uvc_parse_vendor_control() and uvc_parse_vendor_control() functions are
> > part of the control descriptor or are split across multiple descriptors,
> > they all come from the USB descriptors buffer and are all ultimately
> > under device control.
> >
> > As far as I can tell, all this patch does it add a check on buffer[0]
> > but has no impact on anything else. If a device can supply USB
> > descriptors data with an invalid buffer[0] that currently causes any
> > type of issue in the driver, the same device could supply the exact same
> > USB descriptors with buffer[0] set to a value that will be accepted and
> > still cause the same issue. Am I missing something ?
> >
> > > We could spend hours trying to craft a payload, plus extra time in
> > > future reviews whenever uvc_parse_vendor_control() changes. It is much
> > > safer to just enforce the correct bounds now.
> >
> > So is your concern only about introducing issues in the future without
> > noticing ?
> 
> My main concerns are that the function's API looks wrong and yes, it
> could introduce bugs in the future.

I agree there's a quite small risk of introducing future bugs. This is
what I wanted to know, if there was an actual issue today (as in
exploitable bugs), or if it was only a forward-looking change.

> we basically have:
> parse_field(void *data, size_t total_length)
> 
> instead of:
> parse_field(void *data, size_t field_length)
> 
> btw: in parse_field we are ignoring the field_legth in most of the cases.
> 
> I am happy to drop the cc and fixes tags if you want to consider this
> just a boring cleanup

As it stands, I think the risk of introducing regressions is likely
smaller. bLength can't be completely off or the USB core would fail
parsing descriptors. It could be smaller than needed while still
pointing to the next descriptors, with the control parsing then using
the first few bytes of the next descriptor, but the chance that would
result in values that don't cause observable weird effects are slim.

So I think we can merge this change. I'd drop the backport as we're not
fixing any existing issue. And maybe avoid "Fix" in the subject, to
avoid autosel being triggered ?

> > > As you said, the risk to break current hardware is low. If it happens
> > > tis change is small enough to make it easy to revert.
> > >
> > > > > We add minimal code and solve a family of bugs. Do you think that it
> > > > > is a better pattern that uvc_parse_vendor_control() and
> > > > > uvc_parse_vendor_control() have visibility beyond the control that
> > > > > they are parsing?
> > > >
> > > > I'm concerned that some devices may stop working. The risk is likely
> > > > small though, but I'd like to understand what we get from this patch to
> > > > see if it's worth the risk.
> > > >
> > > > > > > > > Change the code so we pass the actual length of the descriptor to the
> > > > > > > > > parser.
> > > > > > > > >
> > > > > > > > > Note that this makes the existing check more strict and some devices
> > > > > > > > > that are wrongly parsed today will not be probed now.
> > > > > > > > >
> > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> > > > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > > > > ---
> > > > > > > > >  drivers/media/usb/uvc/uvc_driver.c | 7 +++++--
> > > > > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > > index e289cc71ba98..429f1ab19a2a 100644
> > > > > > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > > @@ -1248,11 +1248,14 @@ static int uvc_parse_control(struct uvc_device *dev)
> > > > > > > > >        */
> > > > > > > > >
> > > > > > > > >       while (buflen > 2) {
> > > > > > > > > -             if (uvc_parse_vendor_control(dev, buffer, buflen) ||
> > > > > > > > > +             if (buflen < buffer[0] || buffer[0] < 3)
> > > > > > > > > +                     return -EINVAL;
> > > > > > > > > +
> > > > > > > > > +             if (uvc_parse_vendor_control(dev, buffer, buffer[0]) ||
> > > > > > > > >                   buffer[1] != USB_DT_CS_INTERFACE)
> > > > > > > > >                       goto next_descriptor;
> > > > > > > > >
> > > > > > > > > -             ret = uvc_parse_standard_control(dev, buffer, buflen);
> > > > > > > > > +             ret = uvc_parse_standard_control(dev, buffer, buffer[0]);
> > > > > > > > >               if (ret < 0)
> > > > > > > > >                       return ret;
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > ---
> > > > > > > > > base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> > > > > > > > > change-id: 20260911-uvc-ctrl-bound-9c1940f06fc7

-- 
Regards,

Laurent Pinchart
