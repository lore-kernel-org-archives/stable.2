Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834294746B7
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628504; cv=none; b=aqZDwP3HDPUMqDxWzaercDi79ZZc1WsSpIDMcawb970BHTIuVtu1ng2nEFDV5T97os19EF1/H/xQvgMXxbx46xndiM6kJJ6oPscChgPN90m2PXZkfgvSaETwIsgBKUox+XEhR9SHHbUz4+YqovBntjpG2rtIk1ceV/jF70ZrcbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628504; c=relaxed/simple;
	bh=QdZkMkPjT+rsCBzn5BJHPFIr6hwuU7yRbvc/Yd27ByI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSRgkUyBmVJdDMvxQTNdKVazOufr/3mupw0wO6vvLHTF3s85VOBpUFKm1ND86OAuO6c/iTuslfbJ4IHW5FKYfJJtEpBsgyZ6PzHM5n2+tNo/A6GsGwxjB1yH/f/RixFMJoifvilHrtkhiOauxZ8fPbqLktfw9t4+zojQJnfan38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YBoZ86fQ; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YBoZ86fQ"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8805988a200so2184869b3a.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790628502; x=1791233302; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F0YGFMzdmfOvevk5Lbn5k63azBPy2K1/Oti2UC6CjIQ=;
        b=YBoZ86fQFYBOEyUXc7qSqbUbnzWbxuhKQ5LltogfykB5v1wd3v6jQLHwyXjmjTnZXn
         LMB/sBKEM53bQih0gohN9KbQjSIMUBb2hcoJYiIFElLykFWOL78WwvLCoFu2Q6gihDj/
         k2kKnvbgzgB7RVlkh7dWcsbTWn1C9r3Nc/yNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790628502; x=1791233302;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F0YGFMzdmfOvevk5Lbn5k63azBPy2K1/Oti2UC6CjIQ=;
        b=RBb2g8aMCUINzLC7iCzYDyh6+RqGUq748ok5O07UmlOi4Ck91mMirkAzYMv9SMTxpo
         ghQ6OPO8KGv3F7waaAubx+CHilq9t9m0/WDsbU1XdOlQrwi9PU5SPDnCnZ/oImR79z2Y
         R3beod5VS+eBe+rUsMwuyI4sGcyRsALVal4r5lSmIe4UviK01C+NK7ns31NGGxiXD2b8
         5xaPeAyF2ifE10frMbaQ8PwYDRQ9oBgHy2rtZtpfwi3xQsjJL4EJ6UraOmgk5K6vhFRq
         TLKIyYDySUrwBlg/atMvvlRl0w1iXrxKHyM0T/jNkgrR/DY4Gym57b0Iul3bRkj4XXi7
         jV8w==
X-Forwarded-Encrypted: i=1; AKwUvByV35+Kw450VAckwMHLCMUlNJGzxWQZx8gNEWJzp6n0hdPmHafQVKYnSCpclrH1n0gYTLoh/ig=@vger.kernel.org
X-Gm-Message-State: AFuF++m2rY9zgPDqUNvxH/BWJJEsDwIH5xrs5Y4Qzoz6ZYwHaIwynIWl
	PSUuuH22F6BbyB+aWiDVZiBHbneJSB5Z+NtUoXgOTKoVack8S8t2zJE+aT53WOgYHiHXqpBtCY3
	WAqYqhlf0
X-Gm-Gg: AYBFou30PkVuqKOxKrjThBwJDt6gsc7XJ8zqB5nv9gyijhnue5l2aK3rDOwYko3XysH
	/RHG9f3djiM7bTfzk2nWWNVQ+f2WIX/QBDGDgYNMdRvOLTO2kR4G6y2c2M+M8qOlDyEOzDNJXbl
	AhmMRhP5EI3Yve9jsI9dFw2aC8IikdPU8zSxgSCvwYsuAFKDWXP0IayogPfiFXsdjuxYc71OuCm
	jgz8zeFN9vvJRD3Jwp9cIBjOBmS0Q+oNXNjqvc1TcPtLrkqJElwvCK5TvrWEbCAZ6TEaBKyEAC7
	zdJq1Vj9SdABgoOaUn3AWze7QQvByefQ8x/7BH9cHUC754bQXyqagCwSB+szKPMS/f8kqYGeqS4
	WKVVSrxlzdAbk2rB/jv1rqakYpVpoMuzdjcvwkb3Z6cFK+ZQ5Yl8e9RI9DClgVg0V0n55cGtIX2
	Bt11kKLP4tLKQkZbQSVoqo+cNwECqXC7SEFY8HSILqk671IudPQE/3kLvUQrxjzc6jp0jj5MAdq
	gDomtk6STH+2TMyZfWeYriycCZO3/cb/O79og==
X-Received: by 2002:a05:6a00:b94:b0:881:750f:b142 with SMTP id d2e1a72fcca58-881750fb5c0mr6177999b3a.55.1790628501583;
        Mon, 28 Sep 2026 13:48:21 -0700 (PDT)
Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com. [74.125.229.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-883f8e430d8sm1569236b3a.48.2026.09.28.13.48.21
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 13:48:21 -0700 (PDT)
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144d8be360cso163837c88.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:48:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByZhbky+9sTbHtaf+SVGdkZCVuVU8ct4IgRGu0pAa1u8rnn4KBDL5UNW7hKp/iaM3PCV4qESGY=@vger.kernel.org
X-Received: by 2002:a05:701b:2705:b0:148:aef3:a2aa with SMTP id
 a92af1059eb24-148aef3a530mr7204133c88.42.1790628499772; Mon, 28 Sep 2026
 13:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928120252.GB4406@killaraus.ideasonboard.com>
 <CANiDSCv5pd-3aO0Eb1-rvsAOGNpB4rhpjtnTosU6Ca+xBxN1qQ@mail.gmail.com>
 <20260928122450.GA166131@killaraus.ideasonboard.com> <CANiDSCuBFLYXFbq7Vox7AhdhftfzC9Ga6FKL-2F1o08cHQjoAA@mail.gmail.com>
 <20260928124109.GF157191@killaraus.ideasonboard.com> <CANiDSCvvJd0_taNYvHm894kPpyOWQ+TaxC_XRVOs5qrUHod08Q@mail.gmail.com>
 <20260928184429.GE210522@killaraus.ideasonboard.com> <CANiDSCs8N-m1F7LMuerVbYF8xrBPBeVTg2_UX4p6M7g=9yz_Sg@mail.gmail.com>
 <20260928194459.GH210522@killaraus.ideasonboard.com> <CANiDSCs4WOB7jpyXHEAjGOGYf4_69OmUW3LdpB_cxQDmfHr-_Q@mail.gmail.com>
 <20260928195500.GI210522@killaraus.ideasonboard.com>
In-Reply-To: <20260928195500.GI210522@killaraus.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Sep 2026 22:48:05 +0200
X-Gmail-Original-Message-ID: <CANiDSCvfuz0Kr-Ud4N13pSrdkdjUGtWuHkpYC+o7G39qvnkfHQ@mail.gmail.com>
X-Gm-Features: AclHuK9uEJ81QEEoQTkptGz8XRpIZzP4J1cMv3E_B3ad8LAXHWDyXqc3q0Vji-o
Message-ID: <CANiDSCvfuz0Kr-Ud4N13pSrdkdjUGtWuHkpYC+o7G39qvnkfHQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix bounds for descriptor parsing
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Sept 2026 at 21:55, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Sep 28, 2026 at 09:49:05PM +0200, Ricardo Ribalda wrote:
> > On Mon, 28 Sept 2026 at 21:45, Laurent Pinchart wrote:
> > > On Mon, Sep 28, 2026 at 09:03:41PM +0200, Ricardo Ribalda wrote:
> > > > On Mon, 28 Sept 2026 at 20:44, Laurent Pinchart wrote:
> > > > > On Mon, Sep 28, 2026 at 04:03:15PM +0200, Ricardo Ribalda wrote:
> > > > > > On Mon, 28 Sept 2026 at 14:41, Laurent Pinchart wrote:
> > > > > > > On Mon, Sep 28, 2026 at 02:35:29PM +0200, Ricardo Ribalda wrote:
> > > > > > > > On Mon, 28 Sept 2026 at 14:24, Laurent Pinchart wrote:
> > > > > > > > > On Mon, Sep 28, 2026 at 02:10:26PM +0200, Ricardo Ribalda wrote:
> > > > > > > > > > On Mon, 28 Sept 2026 at 14:02, Laurent Pinchart wrote:
> > > > > > > > > > > On Fri, Sep 11, 2026 at 01:23:50PM +0000, Ricardo Ribalda wrote:
> > > > > > > > > > > > uvc_parse_control() passes descriptor by descriptor to
> > > > > > > > > > > > uvc_parse_standard_control() with the number of bytes remaining in the
> > > > > > > > > > > > buffer, not the number of bytes of that descriptor.
> > > > > > > > > > > >
> > > > > > > > > > > > Because of this, malformed descriptors could leak over the next
> > > > > > > > > > > > descriptor, leaving malformed data in our structures.
> > > > > > > > > > >
> > > > > > > > > > > What issue does this fix in practice ?
> > > > > > > > > >
> > > > > > > > > > Look into uvc_parse_standard_control().
> > > > > > > > > > Let's take the UVC_VC_HEADER
> > > > > > > > > >
> > > > > > > > > > Imagine we have a malformed control at the beginning of the descriptor that has:
> > > > > > > > > >
> > > > > > > > > > buffer[0] = 3
> > > > > > > > > > buffer[2] = UVC_VC_HEADER
> > > > > > > > > > buffer[3] => Beggining of next control
> > > > > > > > > >
> > > > > > > > > > With the current code, buffer[3...X] is parsed as UVC_VC_HEADER.
> > > > > > > > > >
> > > > > > > > > > What does it fix in practice? It avoids that data outside the controls
> > > > > > > > > > is parsed as part of the control.
> > > > > > > > >
> > > > > > > > > I understand that, but what does it fix in practice ? And have you
> > > > > > > > > encountered a device that exhibits such a problem ?
> > > > > > > >
> > > > > > > > I have not encountered such devices, but even if they do not exist
> > > > > > > > they are easy to emulate and use for escalation.
> > > > > > >
> > > > > > > That's what I'd like to understand, can this be used for any kind of
> > > > > > > escalation ?
> > > > > >
> > > > > > It is very difficult (impossible?) to prove that something is not
> > > > > > exploitable, especially as the code evolves.
> > > > >
> > > > > Regardless of whether or not all the bytes parsed by the
> > > > > uvc_parse_vendor_control() and uvc_parse_vendor_control() functions are
> > > > > part of the control descriptor or are split across multiple descriptors,
> > > > > they all come from the USB descriptors buffer and are all ultimately
> > > > > under device control.
> > > > >
> > > > > As far as I can tell, all this patch does it add a check on buffer[0]
> > > > > but has no impact on anything else. If a device can supply USB
> > > > > descriptors data with an invalid buffer[0] that currently causes any
> > > > > type of issue in the driver, the same device could supply the exact same
> > > > > USB descriptors with buffer[0] set to a value that will be accepted and
> > > > > still cause the same issue. Am I missing something ?
> > > > >
> > > > > > We could spend hours trying to craft a payload, plus extra time in
> > > > > > future reviews whenever uvc_parse_vendor_control() changes. It is much
> > > > > > safer to just enforce the correct bounds now.
> > > > >
> > > > > So is your concern only about introducing issues in the future without
> > > > > noticing ?
> > > >
> > > > My main concerns are that the function's API looks wrong and yes, it
> > > > could introduce bugs in the future.
> > >
> > > I agree there's a quite small risk of introducing future bugs. This is
> > > what I wanted to know, if there was an actual issue today (as in
> > > exploitable bugs), or if it was only a forward-looking change.
> > >
> > > > we basically have:
> > > > parse_field(void *data, size_t total_length)
> > > >
> > > > instead of:
> > > > parse_field(void *data, size_t field_length)
> > > >
> > > > btw: in parse_field we are ignoring the field_legth in most of the cases.
> > > >
> > > > I am happy to drop the cc and fixes tags if you want to consider this
> > > > just a boring cleanup
> > >
> > > As it stands, I think the risk of introducing regressions is likely
> > > smaller. bLength can't be completely off or the USB core would fail
> > > parsing descriptors. It could be smaller than needed while still
> > > pointing to the next descriptors, with the control parsing then using
> > > the first few bytes of the next descriptor, but the chance that would
> > > result in values that don't cause observable weird effects are slim.
> > >
> > > So I think we can merge this change. I'd drop the backport as we're not
> > > fixing any existing issue. And maybe avoid "Fix" in the subject, to
> > > avoid autosel being triggered ?
> >
> > sgtm. Do you need a v2 or can you modify it locally when merging?
>
> Can you tell me what you'd like as an updated subject line (and include
> commit message updates if you think that's relevant) ? I'll then use
> that and apply the patch.

How does

media: uvcvideo: Bound uvc_parse_*_control to the control size

sound to you?

In any case you are usually better than me at writing commit messages,
so feel free to change it to anything that makes you happy :P


>
> > > > > > As you said, the risk to break current hardware is low. If it happens
> > > > > > tis change is small enough to make it easy to revert.
> > > > > >
> > > > > > > > We add minimal code and solve a family of bugs. Do you think that it
> > > > > > > > is a better pattern that uvc_parse_vendor_control() and
> > > > > > > > uvc_parse_vendor_control() have visibility beyond the control that
> > > > > > > > they are parsing?
> > > > > > >
> > > > > > > I'm concerned that some devices may stop working. The risk is likely
> > > > > > > small though, but I'd like to understand what we get from this patch to
> > > > > > > see if it's worth the risk.
> > > > > > >
> > > > > > > > > > > > Change the code so we pass the actual length of the descriptor to the
> > > > > > > > > > > > parser.
> > > > > > > > > > > >
> > > > > > > > > > > > Note that this makes the existing check more strict and some devices
> > > > > > > > > > > > that are wrongly parsed today will not be probed now.
> > > > > > > > > > > >
> > > > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > > > Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> > > > > > > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drivers/media/usb/uvc/uvc_driver.c | 7 +++++--
> > > > > > > > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > > > > > index e289cc71ba98..429f1ab19a2a 100644
> > > > > > > > > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > > > > > @@ -1248,11 +1248,14 @@ static int uvc_parse_control(struct uvc_device *dev)
> > > > > > > > > > > >        */
> > > > > > > > > > > >
> > > > > > > > > > > >       while (buflen > 2) {
> > > > > > > > > > > > -             if (uvc_parse_vendor_control(dev, buffer, buflen) ||
> > > > > > > > > > > > +             if (buflen < buffer[0] || buffer[0] < 3)
> > > > > > > > > > > > +                     return -EINVAL;
> > > > > > > > > > > > +
> > > > > > > > > > > > +             if (uvc_parse_vendor_control(dev, buffer, buffer[0]) ||
> > > > > > > > > > > >                   buffer[1] != USB_DT_CS_INTERFACE)
> > > > > > > > > > > >                       goto next_descriptor;
> > > > > > > > > > > >
> > > > > > > > > > > > -             ret = uvc_parse_standard_control(dev, buffer, buflen);
> > > > > > > > > > > > +             ret = uvc_parse_standard_control(dev, buffer, buffer[0]);
> > > > > > > > > > > >               if (ret < 0)
> > > > > > > > > > > >                       return ret;
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > ---
> > > > > > > > > > > > base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> > > > > > > > > > > > change-id: 20260911-uvc-ctrl-bound-9c1940f06fc7
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda
