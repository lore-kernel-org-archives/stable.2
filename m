Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD794BB276
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597447; cv=none; b=hwo0AH2yy5PNbIpe4pZqs8evG8DasCZfLKrifCfi0k8j+/aAOwA+2HQdyWPGmsuUbNqDt9vqmryiLixhRtvUy1uAVLUDWybHtqSjzdfeJdBEjEcJpK761T7PJyh2xUkJmRCk+8fIvA4NQzrWmhtQIBtaq79SOOwwRF3xB+yr2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597447; c=relaxed/simple;
	bh=hsmTgOXWY31yOiEwYfObS2Rz+k0nCQ4lsbwNkTGpX2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHNTCOg9vQwZE1g4lMmtF7f8h9o1nE2hNjHpWOiqV0AQVgACIdkDXXdzqyhSyNg+RKUb7CoyV9Px3gUKcBj/dPNsI5ctHUPzNjUQ9QZOk263qcAzA8jEyNEZe6r9Pne8+0p9pQhX96AySzJ3CYGnp1IKeryDN09h/dFAttxsSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RS53vJ63; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RS53vJ63"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-881a3a28e72so514789b3a.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790597445; x=1791202245; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zm7WiEcvZgYFQgA/86utiXIUrMSJvOJdKJld1YmBXzI=;
        b=RS53vJ63mZyxQ69NX5UhnZBEo2X7/McAKSQp6fBl9M0P4O368zY5U5EMwh50jcvgd6
         zFhyCea1ZPRhCXoeURRWv6M/gSSnNDaD2vwRi4EiQtg7sR/2tW6PCa14QJusK7MSFvo1
         jFmggh8SEKEQBN4GNJh+AUV83pK4PbJKaOtFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790597445; x=1791202245;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zm7WiEcvZgYFQgA/86utiXIUrMSJvOJdKJld1YmBXzI=;
        b=dsxGQk5+gciVkhmMvF+iHsF0tGA4XPUUjX9846nfNq8hkc5Fmk+U5d1Fo0YribMx+8
         ysg0AGF+IuLokQ9+89JZubJnB/Kg2QvagmWUdOR7B9r9wH/SdKb3nJK5bHAhi+jnZjSd
         EBHDElvyzGV3IL65hKuAm+oetfC9vviVWQITiE1ZBPk/wRadv8nJlbQD11MTIj6CkR4M
         DZNU99BCorIx0vKTAWIapHTZ6Cf/t6TVbIKh9eHULkarc6TWezxMJJ0TsaLAbFKts+M3
         PKo32Y7SQtDrNCUi/QoYzyjbau7IBa0i2itCEuKdb3l6OytPjhS1WE3HgAh+/ujlPeyH
         s9Lw==
X-Forwarded-Encrypted: i=1; AKwUvByNc9SNUCbPVnUB62xdEZBNjh0M+RLVal7YJk3S8a8falZ3AHlDLYDa2pDh6Vpg6h+dXT5vMMM=@vger.kernel.org
X-Gm-Message-State: AFuF++nm+9tsBP+0cRJynqmJKjyGmRfRZRSsuCJkPxJ7voG3LvxNQLBf
	FEnAhhYS0o1r1PtJQVWWcZudZhMZQwY41BCBNLRHHTPJeQ0q3oeCtjzqAcLIFBBxOvK0iNmJSnu
	7YpE=
X-Gm-Gg: AYBFou3gs82S/XCutG3OTHUAslBTRGCf0rfZQqrdFL0723FQbsbUQcH8q5Jf5cj1o1y
	E/+uriq2gtw9taMnu7ZUiKHAnpWST/EV90+hq7h8Yy47bI+mLY+ocGWJgnOEkKqE5qgo137cGNz
	eZnmLVXnLT3J5usCtyqz+GlVGUBEHLVojrOS2vhAY3GdMPBSyZkp4XQbRV8/KmeQO+vjfrcdsIr
	ugpzdHtYYvMAkN2cgzXVZLB0EwqW+SjdUEN+/f1uZC/6y8329hxNcxmTMSHBzjREXb/dG7n3Xzz
	QuDYENUgpzWzWIQ3NF9FDH+LAK8hQi8c3bWHGOSTq8qPMiMm2RN0hsxvFZFQnMDOtN4NgnaJ+8S
	WEslLCg8fd1xq6ILZyX5afyXZX1Ui4vLTrYRyCNvFePKa7cSze6e9EQ3TWAROWMsBsJSv60yYmU
	Y9URSQIqQJ1IAj3YPuylX7WPfljMpVVyMINtLO6MTLQ0WLAio2pY9zH1IwbZ05qhhzXcEGCqCnE
	P932L3xXFk3tX71Hupn3iHdmQjoz3YaKTbQLA==
X-Received: by 2002:a05:6a00:8c4:b0:874:705d:f647 with SMTP id d2e1a72fcca58-87e9be79ef1mr9271338b3a.41.1790597444851;
        Mon, 28 Sep 2026 05:10:44 -0700 (PDT)
Received: from mail-dl2-f39.google.com (mail-dl2-f39.google.com. [74.125.229.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feaf950f3sm3974603b3a.44.2026.09.28.05.10.42
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 05:10:42 -0700 (PDT)
Received: by mail-dl2-f39.google.com with SMTP id a92af1059eb24-1438cb9b3a3so1639200c88.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 05:10:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByGzAimLE81ZOWkR6CwU+5WQcyGWHuaBYFTpbA6D8uiHildafAqmftbeekJsWJAlRpIAS/pRLk=@vger.kernel.org
X-Received: by 2002:a05:7022:689b:b0:141:aa71:6e02 with SMTP id
 a92af1059eb24-146ce2a0f65mr14559278c88.2.1790597441109; Mon, 28 Sep 2026
 05:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-uvc-ctrl-bound-v1-1-7b5cfc68bae1@chromium.org> <20260928120252.GB4406@killaraus.ideasonboard.com>
In-Reply-To: <20260928120252.GB4406@killaraus.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Sep 2026 14:10:26 +0200
X-Gmail-Original-Message-ID: <CANiDSCv5pd-3aO0Eb1-rvsAOGNpB4rhpjtnTosU6Ca+xBxN1qQ@mail.gmail.com>
X-Gm-Features: AclHuK_-lgmEmOmfxcxZ6_9uVZ5ilRo7HifkMu9cud87ufINOQ3FYQtiYfguUNg
Message-ID: <CANiDSCv5pd-3aO0Eb1-rvsAOGNpB4rhpjtnTosU6Ca+xBxN1qQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix bounds for descriptor parsing
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@skynet.be>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent


On Mon, 28 Sept 2026 at 14:02, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Fri, Sep 11, 2026 at 01:23:50PM +0000, Ricardo Ribalda wrote:
> > uvc_parse_control() passes descriptor by descriptor to
> > uvc_parse_standard_control() with the number of bytes remaining in the
> > buffer, not the number of bytes of that descriptor.
> >
> > Because of this, malformed descriptors could leak over the next
> > descriptor, leaving malformed data in our structures.
>
> What issue does this fix in practice ?

Look into uvc_parse_standard_control().
Let's take the UVC_VC_HEADER

Imagine we have a malformed control at the beginning of the descriptor that has:

buffer[0] = 3
buffer[2] = UVC_VC_HEADER
buffer[3] => Beggining of next control

With the current code, buffer[3...X] is parsed as UVC_VC_HEADER.

What does it fix in practice? It avoids that data outside the controls
is parsed as part of the control.


>
> > Change the code so we pass the actual length of the descriptor to the
> > parser.
> >
> > Note that this makes the existing check more strict and some devices
> > that are wrongly parsed today will not be probed now.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index e289cc71ba98..429f1ab19a2a 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1248,11 +1248,14 @@ static int uvc_parse_control(struct uvc_device *dev)
> >        */
> >
> >       while (buflen > 2) {
> > -             if (uvc_parse_vendor_control(dev, buffer, buflen) ||
> > +             if (buflen < buffer[0] || buffer[0] < 3)
> > +                     return -EINVAL;
> > +
> > +             if (uvc_parse_vendor_control(dev, buffer, buffer[0]) ||
> >                   buffer[1] != USB_DT_CS_INTERFACE)
> >                       goto next_descriptor;
> >
> > -             ret = uvc_parse_standard_control(dev, buffer, buflen);
> > +             ret = uvc_parse_standard_control(dev, buffer, buffer[0]);
> >               if (ret < 0)
> >                       return ret;
> >
> >
> > ---
> > base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> > change-id: 20260911-uvc-ctrl-bound-9c1940f06fc7
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
