Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921BC286D56
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598948; cv=none; b=PZD9NtaSHRSyN2Y3/mwMjelocHTz9nfNjpH2moU2CWwZyZJQSMcTKUSKN2lNHYyZr8ZXDqQx+EtmnhPA8FSAIvnOJtSt5cPesRBdHaDTi35xNdHOcqHnOU27yqoZoPh0xnAl5dFO+bqL/MsjVfzJc7AD8H131StbWYdu8JYgK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598948; c=relaxed/simple;
	bh=73vKtw6aDU7dW85iYUC8zer7SLZnvtJKJF+MDMclS40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tm9a8Nt6xvyQWEZ/9idcz03KNsvIxzuSB1jq73StFKziRrMq0Zju2v0J1NGJ1sbh079ipHOmnZDDxeGx5+c7SFhXPHGSxOrPiAzwve3ji84OBQVaXmd7ctnZpKhweJ/2cbyLUfLOr7sK5j5h7MPOKpxn9pCgg0DSi26VQ+EKIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GI2Au14M; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GI2Au14M"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2e2ad8bf95bso4659325ad.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 05:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790598946; x=1791203746; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OGOKZcnbtkuor5V4UVqa15Vs2El3sc7IIltQAs0Fj2I=;
        b=GI2Au14MU+hijxCrJwQZU5NbglKRJRE/wGRedgXpPfjli4VhbHl7JoDGirrQ6mha+u
         bgZ4o50Y3r7I4ycxpMR3o8oXID4duJhihp0T9o1O8etR1nEGp0TnVMuLCSoDWCPxJKKR
         TXexMnUHrvkErMpjeaZfBLG86j8zllMy3d+FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790598946; x=1791203746;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OGOKZcnbtkuor5V4UVqa15Vs2El3sc7IIltQAs0Fj2I=;
        b=c2dcHmvKHZsoAVDeIdKI2lw8UFxZtaiJ4CFcGqRWVo1zXKex75ptg/R7UdhePTHBMh
         kYOgDjqvbwmnINejXKO0C1GDLreEZpBjcehCPce65oROYFJGNSs3ZqmnTReTiMuSQ9+d
         XST1H5Tw0HFra/src39dvTqzRlYhi2IzIo0sYawXA3zuua5iBMdxXGtN8XweaaiBwPNG
         Qe3q/K/6FjroOoKCyLtTXMYuGLoYv11B1X3otSPvYAigk3D3z1IK57F7S/bQsP7lOzSC
         joA0ld0plLDMz1gBivH0MsmjyxuaR0F7RPIItECWxl7KrjzbMIYyEwDgw/86PrrxKAu/
         DwNw==
X-Forwarded-Encrypted: i=1; AKwUvBwZ6vW91gaj38K+gZbYeKquPp4I8cOzOeowDvxJW5vnhQENCApy6UymbxPvG5oDl5KG9YLpPV8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVLHc89OJ7RnuBxhcV5oynAReCbLqexHVeyvgNHvhY3OdIPV9W
	H6ls7zX73NFK9PSDkLmEuuU0/a/dnK1PlO8VS1C3S+YUgb1qgr4zhjcdI50ErUOnVxzTaFtnp+x
	LMcM=
X-Gm-Gg: AYBFou3CQ7Lzk43wXAGpXMtoAdh+i20yOTX9qHjolXNir1PJajttlfgngbBq3Y8KjP8
	NyM1V3z70DGmWYvgBxw0m1R9ksaX978kavXB0mWhlIjRH/B0LX9MugsrHVjmiecrrwT7mxyWIzA
	EUSx6p+y2yIx6QGfvh8aAmDSZVLpb5rSzhCW9GFjtwKWyCNAlHEdpSCezrdZwEcfwsF5QKxjIsl
	hrTb+IJgyMYEtugMVmJ9DVflOaw/8WQueF1uKQ2vyjYkXs2WfhRZbTgORVTv0fjE38Y5RuUuKd4
	g7msMEyXVXswoV4A1grpQZdbO698zWbSPUGrt4FF9RZ18ScjE0nLL1+ZdYPnuSQdwE28hui6iko
	HaNlAIenYR0mntWe6SNhmB6VAalODsqOLoVzXDnrgyBf0VEwmscVoOKm8bv5lgz+w92V4I0LWhl
	B+9u7tMBim3KLQ6VOASmjHEx8TKCRMTCbNyMz2MLDPlKtK6iMgo/10RFOTfKQrvjsOmZFoQbt4D
	bW308GWlh2SaIY3NihEio1ApK8ApVZ42VrpJA==
X-Received: by 2002:a17:902:cf03:b0:2df:8909:f72d with SMTP id d9443c01a7336-2df94908d3bmr85639125ad.10.1790598945676;
        Mon, 28 Sep 2026 05:35:45 -0700 (PDT)
Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com. [74.125.229.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2b4bc736fsm7141545ad.74.2026.09.28.05.35.44
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 05:35:45 -0700 (PDT)
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144e32aaa1cso1656908c88.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 05:35:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwd8XoDySjn2TwblxUpFq5jjnlVA7BlGVI5B3zyZUwB/REUHkXGmzaTE2nEKJnRk1CY6Q6LUs8=@vger.kernel.org
X-Received: by 2002:a05:7022:b059:10b0:143:298e:459f with SMTP id
 a92af1059eb24-146d096cf16mr9764812c88.42.1790598943539; Mon, 28 Sep 2026
 05:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-uvc-ctrl-bound-v1-1-7b5cfc68bae1@chromium.org>
 <20260928120252.GB4406@killaraus.ideasonboard.com> <CANiDSCv5pd-3aO0Eb1-rvsAOGNpB4rhpjtnTosU6Ca+xBxN1qQ@mail.gmail.com>
 <20260928122450.GA166131@killaraus.ideasonboard.com>
In-Reply-To: <20260928122450.GA166131@killaraus.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Sep 2026 14:35:29 +0200
X-Gmail-Original-Message-ID: <CANiDSCuBFLYXFbq7Vox7AhdhftfzC9Ga6FKL-2F1o08cHQjoAA@mail.gmail.com>
X-Gm-Features: AclHuK-QPMoirQ8WWBZFkgJeJP3t1AaILGIrQSKW8AmLJATjcu8qyr8-bswBwxQ
Message-ID: <CANiDSCuBFLYXFbq7Vox7AhdhftfzC9Ga6FKL-2F1o08cHQjoAA@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix bounds for descriptor parsing
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@skynet.be>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Sept 2026 at 14:24, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Sep 28, 2026 at 02:10:26PM +0200, Ricardo Ribalda wrote:
> > On Mon, 28 Sept 2026 at 14:02, Laurent Pinchart wrote:
> > > On Fri, Sep 11, 2026 at 01:23:50PM +0000, Ricardo Ribalda wrote:
> > > > uvc_parse_control() passes descriptor by descriptor to
> > > > uvc_parse_standard_control() with the number of bytes remaining in the
> > > > buffer, not the number of bytes of that descriptor.
> > > >
> > > > Because of this, malformed descriptors could leak over the next
> > > > descriptor, leaving malformed data in our structures.
> > >
> > > What issue does this fix in practice ?
> >
> > Look into uvc_parse_standard_control().
> > Let's take the UVC_VC_HEADER
> >
> > Imagine we have a malformed control at the beginning of the descriptor that has:
> >
> > buffer[0] = 3
> > buffer[2] = UVC_VC_HEADER
> > buffer[3] => Beggining of next control
> >
> > With the current code, buffer[3...X] is parsed as UVC_VC_HEADER.
> >
> > What does it fix in practice? It avoids that data outside the controls
> > is parsed as part of the control.
>
> I understand that, but what does it fix in practice ? And have you
> encountered a device that exhibits such a problem ?

I have not encountered such devices, but even if they do not exist
they are easy to emulate and use for escalation.

We add minimal code and solve a family of bugs. Do you think that it
is a better pattern that uvc_parse_vendor_control() and
uvc_parse_vendor_control() have visibility beyond the control that
they are parsing?

>
> > > > Change the code so we pass the actual length of the descriptor to the
> > > > parser.
> > > >
> > > > Note that this makes the existing check more strict and some devices
> > > > that are wrongly parsed today will not be probed now.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_driver.c | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > index e289cc71ba98..429f1ab19a2a 100644
> > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > @@ -1248,11 +1248,14 @@ static int uvc_parse_control(struct uvc_device *dev)
> > > >        */
> > > >
> > > >       while (buflen > 2) {
> > > > -             if (uvc_parse_vendor_control(dev, buffer, buflen) ||
> > > > +             if (buflen < buffer[0] || buffer[0] < 3)
> > > > +                     return -EINVAL;
> > > > +
> > > > +             if (uvc_parse_vendor_control(dev, buffer, buffer[0]) ||
> > > >                   buffer[1] != USB_DT_CS_INTERFACE)
> > > >                       goto next_descriptor;
> > > >
> > > > -             ret = uvc_parse_standard_control(dev, buffer, buflen);
> > > > +             ret = uvc_parse_standard_control(dev, buffer, buffer[0]);
> > > >               if (ret < 0)
> > > >                       return ret;
> > > >
> > > >
> > > > ---
> > > > base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> > > > change-id: 20260911-uvc-ctrl-bound-9c1940f06fc7
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
