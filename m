Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF73C1D5B
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624964; cv=none; b=UIKaF7sTSXbYqaqniPv4+x/z9O6mqFYIih21XZiMRFXS4a3aRbdk5EEmjrpS8vXTS7PM7tRlXLHFJWMHuAjsoH1zit3oG7L/7fu3A6/58IZg+es4d/4ecb8cpcsmJSSo4CyQj5Q8DFZxuXyll2os4ENWZ+yRIP6k1YiJxg0KvIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624964; c=relaxed/simple;
	bh=LXDoVcg81MiG1sQyzMH6pbErIfy13ilp/6xeL+JZsqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsOzq5I8aWxDvkVvYC/Pv4AIqRayr28TnQrdUFFlc/GHjp06r0K4+MiWoLPvqKFtVh9RzoAgKuO1ZHbZeYwOUumXUiJnAcMb7f1e0TRFElt5AVgHLa3pCGRFI51J49pnXtfIaXruwaAPOzvHuNBIUqDk+hRzAwcMs+4tYJzQsPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FhWJr/9L; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FhWJr/9L"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so1448984a12.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790624962; x=1791229762; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIzIH4sC3j48Y/7JpNE/XdjFo0EqRvLt2ihZhDXSe3Q=;
        b=FhWJr/9Lz9e0Ocu+8fa7Tse5I9y0/1oBA7enhzz+Wj/Wx5RbtzCIrtZRXLRSRjUylw
         ihB/VCJHYJyF44ulz84+jTz0Xvf9LEYi5Uob78XsEQudhG+Cyli6uosoR0xxrAS/VZL0
         Fiu/zaZKJzpt0Kf9QJJcTBCsPDvlwlSSgq4IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790624962; x=1791229762;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DIzIH4sC3j48Y/7JpNE/XdjFo0EqRvLt2ihZhDXSe3Q=;
        b=au3i0MYdZh1gbXa3bei1VcPoOnBDNkgglOD4tGV0fDS2PTgXcNDRanPYWwjqwYZvHA
         4V9gITKzkFMITQK1bmz6GZKsxf3qCUhGGjmU3ps9w+e/pDeX6JGOGXieqwkw7xht3Ntd
         uiFjd7kzG50K4rL9G3U1of9Vt4V7qHYLQdjwmA17WEMkN8fOZnyL9+X0h1RL0k6axh/1
         hzxelOwro40CAHEX/NfLXKfPJZqFM8r0LTqJXQXKNDLaH0ToLqdnKAdZWxcHhUcAo3VN
         9iSHt3xuOKgKwBk40GL4NSd3F8wGW4VI++VXZVutbsX2qF4njUGli3lCmqJYubsBEunX
         XjDA==
X-Forwarded-Encrypted: i=1; AKwUvBzrOAJb0mTaW1b1qIFmAw4gKX0tbze4SqvMtuaCutxFQF66RyuV12j+EtjHqKLtezCZfKJhYgY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9R7uGdGk7SQX2fJEEejUYa7wJwnNjcAXeufTedA/iBUHb0/5m
	m4g4K3ViJtIYzglaDIaUFWdMR5racUrB1CAzylylWtHHyP2r81RhiCRGcOzgYQ3jD3jnf/q2YxJ
	+o7uyqEXl
X-Gm-Gg: AYBFou1JY2RVRIfNg90faxTlHNCshwJFtI9tt343Vswp69vW1yOlh9LkKkKsyecU87s
	iX9+5kJ9rKM6/G0aL15znEonfLfniJJZvU+6bUtRpufyVfEU2g/ymdnv/TETnKmewwS9hlbWAqE
	09soYQVfex1nX+eKYjfInBnffXNbwMtZvbDLMM6Fxmh3sG7TOrArVt7+iigjyCycr6Fbz6mPNrG
	3Iw82Dr8iIREVRRl17c8kdCg6kYeHy196VTHnqYCRazRnBtH2SGi+8hnrzJaUCzEs2PPn/RtpTo
	sMiQb1tDDi+fibACAJbg+ExjwVJSV+1f8h88zM1Jk6u/Pu6mdUsHahGcPyMuqIg2Xif7cA9brkQ
	1ZWBr73Zwsi/CdOmYMEEjiaY+5ffv/0fuj8LaE1DlI/LhVeiqiNZSZpxsF4zblAUVjr2GI6ffFP
	2H6Sih4ro3K40EH0F6jybww6AbC0Vz/er8mSXsRl6IFqlIQMW46Sl35ArJL7ukkzvwOBPAUUDDY
	3F+ajY0K4Kr7FLiw1EGAWqYdNjkv/xCJjzxFA==
X-Received: by 2002:a17:90a:e7c4:b0:3a0:809b:1972 with SMTP id 98e67ed59e1d1-3a098ce5e08mr12594383a91.26.1790624961744;
        Mon, 28 Sep 2026 12:49:21 -0700 (PDT)
Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com. [74.125.229.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986a1910sm982154a91.14.2026.09.28.12.49.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 12:49:21 -0700 (PDT)
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-149d5ec8e96so333699c88.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 12:49:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwiAM+EJ8Cx+t06rEOiGdLlEs5WRtUXa0nrDgzVNqLsdxBHwfD1N7DjZr7JDyoHOTYZhkMWhmI=@vger.kernel.org
X-Received: by 2002:a05:701b:2301:b0:12d:f0e8:9696 with SMTP id
 a92af1059eb24-146ce1a9a9fmr12914251c88.4.1790624959572; Mon, 28 Sep 2026
 12:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-uvc-ctrl-bound-v1-1-7b5cfc68bae1@chromium.org>
 <20260928120252.GB4406@killaraus.ideasonboard.com> <CANiDSCv5pd-3aO0Eb1-rvsAOGNpB4rhpjtnTosU6Ca+xBxN1qQ@mail.gmail.com>
 <20260928122450.GA166131@killaraus.ideasonboard.com> <CANiDSCuBFLYXFbq7Vox7AhdhftfzC9Ga6FKL-2F1o08cHQjoAA@mail.gmail.com>
 <20260928124109.GF157191@killaraus.ideasonboard.com> <CANiDSCvvJd0_taNYvHm894kPpyOWQ+TaxC_XRVOs5qrUHod08Q@mail.gmail.com>
 <20260928184429.GE210522@killaraus.ideasonboard.com> <CANiDSCs8N-m1F7LMuerVbYF8xrBPBeVTg2_UX4p6M7g=9yz_Sg@mail.gmail.com>
 <20260928194459.GH210522@killaraus.ideasonboard.com>
In-Reply-To: <20260928194459.GH210522@killaraus.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Sep 2026 21:49:05 +0200
X-Gmail-Original-Message-ID: <CANiDSCs4WOB7jpyXHEAjGOGYf4_69OmUW3LdpB_cxQDmfHr-_Q@mail.gmail.com>
X-Gm-Features: AclHuK9OfvkWCsRZx0tpuXdlH0HC2GbUT_-WgGorjcgEWP_YAcO-2ScTCE4VM3Y
Message-ID: <CANiDSCs4WOB7jpyXHEAjGOGYf4_69OmUW3LdpB_cxQDmfHr-_Q@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix bounds for descriptor parsing
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@skynet.be>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Sept 2026 at 21:45, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Sep 28, 2026 at 09:03:41PM +0200, Ricardo Ribalda wrote:
> > On Mon, 28 Sept 2026 at 20:44, Laurent Pinchart wrote:
> > > On Mon, Sep 28, 2026 at 04:03:15PM +0200, Ricardo Ribalda wrote:
> > > > On Mon, 28 Sept 2026 at 14:41, Laurent Pinchart wrote:
> > > > > On Mon, Sep 28, 2026 at 02:35:29PM +0200, Ricardo Ribalda wrote:
> > > > > > On Mon, 28 Sept 2026 at 14:24, Laurent Pinchart wrote:
> > > > > > > On Mon, Sep 28, 2026 at 02:10:26PM +0200, Ricardo Ribalda wrote:
> > > > > > > > On Mon, 28 Sept 2026 at 14:02, Laurent Pinchart wrote:
> > > > > > > > > On Fri, Sep 11, 2026 at 01:23:50PM +0000, Ricardo Ribalda wrote:
> > > > > > > > > > uvc_parse_control() passes descriptor by descriptor to
> > > > > > > > > > uvc_parse_standard_control() with the number of bytes remaining in the
> > > > > > > > > > buffer, not the number of bytes of that descriptor.
> > > > > > > > > >
> > > > > > > > > > Because of this, malformed descriptors could leak over the next
> > > > > > > > > > descriptor, leaving malformed data in our structures.
> > > > > > > > >
> > > > > > > > > What issue does this fix in practice ?
> > > > > > > >
> > > > > > > > Look into uvc_parse_standard_control().
> > > > > > > > Let's take the UVC_VC_HEADER
> > > > > > > >
> > > > > > > > Imagine we have a malformed control at the beginning of the descriptor that has:
> > > > > > > >
> > > > > > > > buffer[0] = 3
> > > > > > > > buffer[2] = UVC_VC_HEADER
> > > > > > > > buffer[3] => Beggining of next control
> > > > > > > >
> > > > > > > > With the current code, buffer[3...X] is parsed as UVC_VC_HEADER.
> > > > > > > >
> > > > > > > > What does it fix in practice? It avoids that data outside the controls
> > > > > > > > is parsed as part of the control.
> > > > > > >
> > > > > > > I understand that, but what does it fix in practice ? And have you
> > > > > > > encountered a device that exhibits such a problem ?
> > > > > >
> > > > > > I have not encountered such devices, but even if they do not exist
> > > > > > they are easy to emulate and use for escalation.
> > > > >
> > > > > That's what I'd like to understand, can this be used for any kind of
> > > > > escalation ?
> > > >
> > > > It is very difficult (impossible?) to prove that something is not
> > > > exploitable, especially as the code evolves.
> > >
> > > Regardless of whether or not all the bytes parsed by the
> > > uvc_parse_vendor_control() and uvc_parse_vendor_control() functions are
> > > part of the control descriptor or are split across multiple descriptors,
> > > they all come from the USB descriptors buffer and are all ultimately
> > > under device control.
> > >
> > > As far as I can tell, all this patch does it add a check on buffer[0]
> > > but has no impact on anything else. If a device can supply USB
> > > descriptors data with an invalid buffer[0] that currently causes any
> > > type of issue in the driver, the same device could supply the exact same
> > > USB descriptors with buffer[0] set to a value that will be accepted and
> > > still cause the same issue. Am I missing something ?
> > >
> > > > We could spend hours trying to craft a payload, plus extra time in
> > > > future reviews whenever uvc_parse_vendor_control() changes. It is much
> > > > safer to just enforce the correct bounds now.
> > >
> > > So is your concern only about introducing issues in the future without
> > > noticing ?
> >
> > My main concerns are that the function's API looks wrong and yes, it
> > could introduce bugs in the future.
>
> I agree there's a quite small risk of introducing future bugs. This is
> what I wanted to know, if there was an actual issue today (as in
> exploitable bugs), or if it was only a forward-looking change.
>
> > we basically have:
> > parse_field(void *data, size_t total_length)
> >
> > instead of:
> > parse_field(void *data, size_t field_length)
> >
> > btw: in parse_field we are ignoring the field_legth in most of the cases.
> >
> > I am happy to drop the cc and fixes tags if you want to consider this
> > just a boring cleanup
>
> As it stands, I think the risk of introducing regressions is likely
> smaller. bLength can't be completely off or the USB core would fail
> parsing descriptors. It could be smaller than needed while still
> pointing to the next descriptors, with the control parsing then using
> the first few bytes of the next descriptor, but the chance that would
> result in values that don't cause observable weird effects are slim.
>
> So I think we can merge this change. I'd drop the backport as we're not
> fixing any existing issue. And maybe avoid "Fix" in the subject, to
> avoid autosel being triggered ?

sgtm. Do you need a v2 or can you modify it locally when merging?

Thanks!

>
> > > > As you said, the risk to break current hardware is low. If it happens
> > > > tis change is small enough to make it easy to revert.
> > > >
> > > > > > We add minimal code and solve a family of bugs. Do you think that it
> > > > > > is a better pattern that uvc_parse_vendor_control() and
> > > > > > uvc_parse_vendor_control() have visibility beyond the control that
> > > > > > they are parsing?
> > > > >
> > > > > I'm concerned that some devices may stop working. The risk is likely
> > > > > small though, but I'd like to understand what we get from this patch to
> > > > > see if it's worth the risk.
> > > > >
> > > > > > > > > > Change the code so we pass the actual length of the descriptor to the
> > > > > > > > > > parser.
> > > > > > > > > >
> > > > > > > > > > Note that this makes the existing check more strict and some devices
> > > > > > > > > > that are wrongly parsed today will not be probed now.
> > > > > > > > > >
> > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> > > > > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/media/usb/uvc/uvc_driver.c | 7 +++++--
> > > > > > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > > > index e289cc71ba98..429f1ab19a2a 100644
> > > > > > > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > > > @@ -1248,11 +1248,14 @@ static int uvc_parse_control(struct uvc_device *dev)
> > > > > > > > > >        */
> > > > > > > > > >
> > > > > > > > > >       while (buflen > 2) {
> > > > > > > > > > -             if (uvc_parse_vendor_control(dev, buffer, buflen) ||
> > > > > > > > > > +             if (buflen < buffer[0] || buffer[0] < 3)
> > > > > > > > > > +                     return -EINVAL;
> > > > > > > > > > +
> > > > > > > > > > +             if (uvc_parse_vendor_control(dev, buffer, buffer[0]) ||
> > > > > > > > > >                   buffer[1] != USB_DT_CS_INTERFACE)
> > > > > > > > > >                       goto next_descriptor;
> > > > > > > > > >
> > > > > > > > > > -             ret = uvc_parse_standard_control(dev, buffer, buflen);
> > > > > > > > > > +             ret = uvc_parse_standard_control(dev, buffer, buffer[0]);
> > > > > > > > > >               if (ret < 0)
> > > > > > > > > >                       return ret;
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > > base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> > > > > > > > > > change-id: 20260911-uvc-ctrl-bound-9c1940f06fc7
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
