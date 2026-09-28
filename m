Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF554D596C
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604216; cv=none; b=iwhyH8zFvv5bANusbftab2o4w95zRYn7BzZhcEsXRi/C90ttlJLANfnxaWIBAcdricZ5/GFZKqeFfv6Ba0NpuakJjfortsnXCr/cbX6gMahDHdJtxeo3zAV2gK7Zg2fCg4uFwSQpSEdWy+GA6f03SGQNlUsOPCXB82xqwDFn2+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604216; c=relaxed/simple;
	bh=nOhLwxUinnp+EKfvunI9tE5Mzri76nXjiAG6EMhp03I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUMFAyx7Hn9vHV2E/5Ab83xwEoyoBO3vxfK4JiH2CD6mtmh2aGP/EAP7ALRqk6xRhJZ/SjsedJB+ePX9wNgIXIRDSsSnfrSVl6DjHvfANPNU37VC4QuGzvWZgsQ82utyGGgARGHO7s//6OglR+751iBNC3sJ0QmeCMlIoXgblwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aC90VGll; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aC90VGll"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8633a38df87so1254849b3a.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790604214; x=1791209014; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OfkeIgOAr8W95/lWVVLlZKauL7pPNd1iNdfWaeJ0T6k=;
        b=aC90VGllHXfFB/7Z0rtMscNg0uBHcAiH0ORvzu1qk0Gik/G0tFy9pADHUZQeWAzq6r
         YGK6+3SsveZicOte4BJ1VmqrzcQSFZEUwvXDH8o03C4Ue3W6PCTbmtxNieU/Pk/eJuQd
         TG0HmIO64byJ5GiQNLBbWAC7paPT+500RfmVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790604214; x=1791209014;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OfkeIgOAr8W95/lWVVLlZKauL7pPNd1iNdfWaeJ0T6k=;
        b=PKjwXHGM+11OENBuwF+IyBXpXeSTEyimFWqXC8SCM0RgpyHQIjIQb0xVFYdUe3KdgN
         zykai3Vt17Sju21ZhMvH8c+ENFX/hP4ujbmGGCXhFvOjeend/W9/p9fxZYj2izKLSgog
         lZ5VCAUf+n62kb35iG9A1t+kgLI/+tfzUrgb7caI7L9805XmrWHk7nYpOYhZJcsOiODq
         6yUL8BTM1JLKwD3WR0l4Vup2ADSmCeD+B5BJNfrkvLPXnwWOeUUWNLvn24jruXxzOBUo
         13gM1Lcmg7Lx+HfZshISTbICDbZ1nTwd64QxJNekdrEpwVUlT8QLgdu2fZrDzj3yzZcL
         vX2Q==
X-Forwarded-Encrypted: i=1; AKwUvByao3si5+2mAcFqzvh3yPViiv7AhgsAEgVaB4nZiLR2Yp8zgMmRDHQwHJyEiLo3pT15r1eJKUY=@vger.kernel.org
X-Gm-Message-State: AFuF++l5SO6fYmiRLleW0hJe9gmAO5b88trWGZKsJYSQQNvF1pFfS1cn
	dbNFBp0fNoIsHG4Y3TBUngFLijCeDJi1/2mNFkLhatlHnq/Ciw+8KK3sVar3YMao85XCYKE/PUy
	6G9Q=
X-Gm-Gg: AYBFou0ITWZ884ar4/JJ7vXz9K1sNN5GE2rJJOVqBYmWFIHgIRw0nBCKZVBVdOpQmXK
	cA89gjC3lUQBtEsWLs60ucJmKVJQQ7kYbC4t3L/bPnp1dDmz+/VKLESLx6CiKpmRVA4SZIgId1i
	O+agGDOECvfBWUYGN8CAggvrraFuAu+LHExvcLIU6aV+3w6QM3g8QraGEneLSdnLe1Cd1zfLg8K
	/lFKcDfrhqAArHvRkw+5WvxAaw3ncanY1YKfmIuFNmN2CdkRT6zVwbAbPlnzzcvWOCElyGzRUS3
	9Xz7tGgETvc1ZfpabyROzoBK8nY16faNKdMcl9W+9QXcqrEKOVIBEzOBDfzg5pz+Yvi8CYYe/+n
	YVKSoG/JJDeWNYvsKfODlyz2TaQ9Zspr2IQN1pgNzJVadJKs/SvxWvV5+fYFMFwzeO8DDC6IY1x
	HFGToO9v2zlZt9y/8/WpOLJUVTwZjfH9aYyLb7ZmG02dNEblYxM7sp46Ir4ibDDn2tP0Cjtn6s/
	vODoLZHFa2pp4MAFdbSAD69NF7z9XSeh7b5Vnk=
X-Received: by 2002:a05:6a00:1a8d:b0:883:54dc:7892 with SMTP id d2e1a72fcca58-88354dc7c05mr2301906b3a.52.1790604213731;
        Mon, 28 Sep 2026 07:03:33 -0700 (PDT)
Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com. [74.125.229.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea18ef25sm4310856b3a.15.2026.09.28.07.03.32
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 07:03:32 -0700 (PDT)
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144efd1ea76so1630143c88.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:03:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzu+LAPlWX5qWE5lmSfkE1Yl9br2KcGrhrjNY5OP9eKorETxVaPqCQSsLlS5z4LiaAIqGtvelg=@vger.kernel.org
X-Received: by 2002:a05:701b:4186:10b0:143:5c63:23a1 with SMTP id
 a92af1059eb24-146ce680185mr10455491c88.19.1790604211213; Mon, 28 Sep 2026
 07:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-uvc-ctrl-bound-v1-1-7b5cfc68bae1@chromium.org>
 <20260928120252.GB4406@killaraus.ideasonboard.com> <CANiDSCv5pd-3aO0Eb1-rvsAOGNpB4rhpjtnTosU6Ca+xBxN1qQ@mail.gmail.com>
 <20260928122450.GA166131@killaraus.ideasonboard.com> <CANiDSCuBFLYXFbq7Vox7AhdhftfzC9Ga6FKL-2F1o08cHQjoAA@mail.gmail.com>
 <20260928124109.GF157191@killaraus.ideasonboard.com>
In-Reply-To: <20260928124109.GF157191@killaraus.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Sep 2026 16:03:15 +0200
X-Gmail-Original-Message-ID: <CANiDSCvvJd0_taNYvHm894kPpyOWQ+TaxC_XRVOs5qrUHod08Q@mail.gmail.com>
X-Gm-Features: AclHuK-bAdJr7VD1Kpb9pjJeCGhtkq2oBETN-wX0NINpxgYT65DJZrat6qMDKuY
Message-ID: <CANiDSCvvJd0_taNYvHm894kPpyOWQ+TaxC_XRVOs5qrUHod08Q@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix bounds for descriptor parsing
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@skynet.be>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Sept 2026 at 14:41, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Sep 28, 2026 at 02:35:29PM +0200, Ricardo Ribalda wrote:
> > On Mon, 28 Sept 2026 at 14:24, Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > >
> > > On Mon, Sep 28, 2026 at 02:10:26PM +0200, Ricardo Ribalda wrote:
> > > > On Mon, 28 Sept 2026 at 14:02, Laurent Pinchart wrote:
> > > > > On Fri, Sep 11, 2026 at 01:23:50PM +0000, Ricardo Ribalda wrote:
> > > > > > uvc_parse_control() passes descriptor by descriptor to
> > > > > > uvc_parse_standard_control() with the number of bytes remaining in the
> > > > > > buffer, not the number of bytes of that descriptor.
> > > > > >
> > > > > > Because of this, malformed descriptors could leak over the next
> > > > > > descriptor, leaving malformed data in our structures.
> > > > >
> > > > > What issue does this fix in practice ?
> > > >
> > > > Look into uvc_parse_standard_control().
> > > > Let's take the UVC_VC_HEADER
> > > >
> > > > Imagine we have a malformed control at the beginning of the descriptor that has:
> > > >
> > > > buffer[0] = 3
> > > > buffer[2] = UVC_VC_HEADER
> > > > buffer[3] => Beggining of next control
> > > >
> > > > With the current code, buffer[3...X] is parsed as UVC_VC_HEADER.
> > > >
> > > > What does it fix in practice? It avoids that data outside the controls
> > > > is parsed as part of the control.
> > >
> > > I understand that, but what does it fix in practice ? And have you
> > > encountered a device that exhibits such a problem ?
> >
> > I have not encountered such devices, but even if they do not exist
> > they are easy to emulate and use for escalation.
>
> That's what I'd like to understand, can this be used for any kind of
> escalation ?

It is very difficult (impossible?) to prove that something is not
exploitable, especially as the code evolves.
We could spend hours trying to craft a payload, plus extra time in
future reviews whenever uvc_parse_vendor_control() changes. It is much
safer to just enforce the correct bounds now.

As you said, the risk to break current hardware is low. If it happens
tis change is small enough to make it easy to revert.

>
> > We add minimal code and solve a family of bugs. Do you think that it
> > is a better pattern that uvc_parse_vendor_control() and
> > uvc_parse_vendor_control() have visibility beyond the control that
> > they are parsing?
>
> I'm concerned that some devices may stop working. The risk is likely
> small though, but I'd like to understand what we get from this patch to
> see if it's worth the risk.
>
> > > > > > Change the code so we pass the actual length of the descriptor to the
> > > > > > parser.
> > > > > >
> > > > > > Note that this makes the existing check more strict and some devices
> > > > > > that are wrongly parsed today will not be probed now.
> > > > > >
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > ---
> > > > > >  drivers/media/usb/uvc/uvc_driver.c | 7 +++++--
> > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > index e289cc71ba98..429f1ab19a2a 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > @@ -1248,11 +1248,14 @@ static int uvc_parse_control(struct uvc_device *dev)
> > > > > >        */
> > > > > >
> > > > > >       while (buflen > 2) {
> > > > > > -             if (uvc_parse_vendor_control(dev, buffer, buflen) ||
> > > > > > +             if (buflen < buffer[0] || buffer[0] < 3)
> > > > > > +                     return -EINVAL;
> > > > > > +
> > > > > > +             if (uvc_parse_vendor_control(dev, buffer, buffer[0]) ||
> > > > > >                   buffer[1] != USB_DT_CS_INTERFACE)
> > > > > >                       goto next_descriptor;
> > > > > >
> > > > > > -             ret = uvc_parse_standard_control(dev, buffer, buflen);
> > > > > > +             ret = uvc_parse_standard_control(dev, buffer, buffer[0]);
> > > > > >               if (ret < 0)
> > > > > >                       return ret;
> > > > > >
> > > > > >
> > > > > > ---
> > > > > > base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> > > > > > change-id: 20260911-uvc-ctrl-bound-9c1940f06fc7
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
