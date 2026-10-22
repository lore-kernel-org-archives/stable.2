Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792683746;
	b=IyItNl6bb6JbDvGwD/caBUDj8wYhHy3voRBQUo3hnICB57CJUslQHNOIJQNq3/DyZDXo
	 E8CO2ZNr5dj4hV02q9JvQVutJ1vzr9pgpGi1rs8+Lg2cU+O78sY0QTOt5bGBCIsviKOjD
	 mx/g0J/L6p4CqBS9jmqNRwAB4S3v0WSOqM4Z0ecHB4k5ANxf74TB7/BHUm3lga78NUrBv
	 PQTwPfS7wMzMgKAoSVd5vgeFDdKXxG7TGcuubeLJAh2eWL87dUiNHd5Siz/L6VD06w+1y
	 0gWDt1gJ0q07aF1CTrekCCaJ/q5D9eQDKzXBmvHx71/tJK1FdpybBbe0X7h+UoyEU9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=nOo6raRuVgtjcP13nHvQbmXlg/BZszZZ1L4y9D6+1TQ=;
	b=cv9Y8vFvFGV9u1Hn39fDUPvxpyqfk68TV3TPRtAwylXbtVk4525i4bMoWm8wSa5sGrL5
	 LCy9nn5Jt4Qkake/Uut+mLIRQeTTJhY51OTODdbbnqiIEKPdaQNDGUG4D5bJqC3o0DlAl
	 KIyvV/q+JFcFmJMgo5teAJXEh7iZag7Nj3Fl3ICqDFqq/8VjQGYPH4DMOZjTW7QEaMtCc
	 bAgE4fvG47uFOQ3Vj7snwclgEnMOs9hol+ighv0cgXWBH4ReGnOhZJHXoQ8qm36akul2i
	 6gHRJBB4YsdIz1BN8cAJVZMZPbdxbq04N2tQZug16ONx2v1cEOX7kORX3PB4fVT4XRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=thRbagr0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3969606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3969606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=thRbagr0
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f84a55cc06so1193672a34.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792683744; cv=none;
        d=google.com; s=arc-20260327;
        b=G3BGbP5JkcQR1nKuADm75YEL7tZC7P+htc55OeF92/vp+AenZN8NALxi44Nxf+7kDh
         Yh+Aj7YdM7nRVR8WXzmQzo+M/NEOXnYwDNlRPd6Ylm8vqcLJKiWk8EJ+4PGN/6cLEJgt
         5Hbi+rzTOoMWWGwqd9+J1mAesHneYE4wjD1SEBofGrhy3taNSzwKXb1w0kDtcDSMs7mN
         pky7ut8DuLAcdRsVt3yu+zW+C0WlF/Fowq1uFQjIWsuBFA+5g7aiTzj4ZpVfYRl6qUyR
         lRQVW5SYAFMdzVMla03G9rH5xj4lbeb+HG+biUKg4tbD/G4XvLOBoj5PC1cBwUTUX3hR
         3QSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nOo6raRuVgtjcP13nHvQbmXlg/BZszZZ1L4y9D6+1TQ=;
        fh=lNWP4gOhqg1qKCmAeSPZQQ+AzFGwo04BlyHFJDdpi1A=;
        b=eu/6msh9kmP3gkaKTdPNMswLypXS0+1XSzR4+8hoHrOVLfSnYs0Nddl31rF/1nRg/P
         /zNlQZjOx2OcZ16ljnuWYqHM3DQiC2M21UURhqGQVdjBn/e5SFbAZBixy8vruvY6D9ea
         izRogsdN65AmRNDnRTh7rUDP2u2rH8k2fVs5T0NylYeKPz+HYd+9nd1I7tAu5qwLoohF
         IiAgoZPR2ZIaiQpLDQL4u6xValqiv9CBPXOeJwzfIYSXVIlORFBjT973ialWerROfFAl
         ApHDZZD8l7LTaqp0LLbr0I3yvwds0eFRK9VGn9K1EPw3uaaIt0ldkBkrM8lS0Oj0RYbK
         scwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792683744; x=1793288544; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nOo6raRuVgtjcP13nHvQbmXlg/BZszZZ1L4y9D6+1TQ=;
        b=thRbagr0kS93zT5v8WW8/66BQkWG+fDEO65a7r6VnGj0XreMG07HdhqEgxotRl9whF
         ROisQRGyvFvzSiYM90RRE4aj2uziHCgMBppP00WiFQRX+sLvhW4kH26eK4K5AVegzHC9
         H27JleWBFMx+GQFx8xUlyoUTdYsNET65seYJnv195QDcFCMUORmh/4fJU0iACBUxBXDS
         dz1A6HV4UbspIVbm6K+kYSAdIP6BISTF2YXWTvpGdfj6fM6NEab8xE9bxChDl9dDOvcK
         OCN4Imhs3ILKO47gRXA5P+uqEZvAteBXPZiZ4Nhwb2fEIMP2uLdfkZPYLpYs09VC2TvQ
         tZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792683744; x=1793288544;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nOo6raRuVgtjcP13nHvQbmXlg/BZszZZ1L4y9D6+1TQ=;
        b=palXu1w/5ozJWotAmY7aBbD0Lf27P1KicU5OF2FHrWNYPMCgSNGcMMnSmsRdv4loa/
         iOG1NWtfJkRjVaeYQoAWRjexhLxhM6DkJayBpJ3wgwSLp6FNlSVubfx0amMqFCXh4BVp
         VIiltTx5KYZRqSkLcRk5iZ5BU3nd+lAH2iMaDdIJi86N20Y5d/D7WxT6COOvueamutz0
         iH5Jgn+nvVatiiD/o43mydJRAqq8z9yPYyD9JXjFpDAAb3DzhoNQvCMQcCxoIhisQ58m
         gRtKN9GhklJQS6mKHfvFdPiWfFd4+6zW2FzXnF0yCntdndqQocfIO08bP7h4UltVqfma
         McVw==
X-Forwarded-Encrypted: i=1; AKwUvBwJ0ft7tBuT/ac3kE/g76PziEdrQUg9V+c2juvD/d9Ws6YiuMT2xp8GI1GOnU3pB2f0JLVwsiw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9TWX32ZF+pyKyrZXG9tOONQwEGsZdMcZ2BaydQfVsNai6g3qA
	Mwr9xggkx3DIUszX9HtDo4w3fV7S1NWUmGIGUWfE4KPf0NiWQTEWYK9D3VTvjbqNjBhTjr8NuFc
	LDp9H3pVeoIXs+GNGHmz8u1YU9EMw2PEYs2wK9cwC
X-Gm-Gg: AYBFou3JfSpZkcYJDEFPYZB29G4o7F16FYsuKwdgIIeLxVdROtIb0gdLS7I7PKs1Blr
	0rtIxGdVTTjruEGd3m/PqI5aw7NMPh071FmjOPwH3mV/irFR6IpsUnUbH9Fa3kBnBPQGhRJcr6a
	HY2A3aS3Df9tVPjU561Z/4nWL0FAXIhilzfLlSy/NQJLx8VZTmYlyvK7OIbeEs4TqQykeOnin6D
	xtMptzm2VQINXGVHvFGBBxS4JXtZB7fCwboBHS2uct8/Wbt39WZsz7aoWna0l2iPO/W8VTE0BQb
	0B5Tqg7/1X8oQCHCKeXntrKMlxiPo4FfLVS5zv0Qmt1kDZarNtbBYyXc4pk9ieuNBoflMtruQEs
	yf6IaPY+7lcfM2+1hCNLtDArtGTUv/VMdGToRIprnNss8NGnWHl9j3ySMOC45wnHr72iq3RZg+0
	dXnpxmylS+5uzIkUSi7Ytvj6jmpA==
X-Received: by 2002:a05:6830:2992:b0:844:ec25:c7f3 with SMTP id
 46e09a7af769-84d08505b79mr4053552a34.18.1792683744082; Thu, 22 Oct 2026
 08:42:24 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019135701.2767078-1-sonalipradhan@google.com> <87a4o8ivv2.wl-tiwai@suse.de>
In-Reply-To: <87a4o8ivv2.wl-tiwai@suse.de>
From: Sonali Pradhan <sonalipradhan@google.com>
Date: Thu, 22 Oct 2026 21:12:11 +0530
X-Gm-Features: AclHuK_cY5MAxLFcDxNvPeTguvtEQpkDq1J7THEXa10GvkWtPofM-JBCJrLXn_A
Message-ID: <CALeehfmiOoJS4cwPCzHcAgi5dGpCiS0sTd9FQZo6VWXwVth-dw@mail.gmail.com>
Subject: Re: [PATCH RESEND] usb: gadget: f_midi: fix UAF race during IN
 request handling
To: Takashi Iwai <tiwai@suse.de>, Sonali Pradhan <sonalipradhan@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Neill Kapron <nkapron@google.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Fan Wu <fanwu01@zju.edu.cn>, 
	Victor Krawiec <victor.krawiec@arturia.com>, Felipe Balbi <balbi@ti.com>, 
	"Felipe F. Tonello" <eu@felipetonello.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 11:06:57 +0200,
Takashi Iwai wrote:
>
> On Mon, 19 Oct 2026 15:57:01 +0200,
> Sonali Pradhan wrote:
> >
> > diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> > index 63fb6ee70a3d..c26d04eb9209 100644
> > --- a/drivers/usb/gadget/function/f_midi.c
> > +++ b/drivers/usb/gadget/function/f_midi.c
> > @@ -280,9 +280,18 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
> >                     /* We received stuff. req is queued again, below */
> >                     f_midi_handle_out_data(ep, req);
> >             } else if (ep == midi->in_ep) {
> > +                   unsigned long flags;
> > +
> >                     /* Our transmit completed. See if there's more to go.
> >                      * f_midi_transmit eats req, don't queue it again. */
> > +                   spin_lock_irqsave(&midi->transmit_lock, flags);
> > +                   if (!ep->enabled) {
> > +                           spin_unlock_irqrestore(&midi->transmit_lock, flags);
> > +                           return;
> > +                   }
> >                     req->length = 0;
> > +                   spin_unlock_irqrestore(&midi->transmit_lock, flags);
> > +
>
> Does this transmit_lock help here?  As far as I see, the ep
> enable/disable itself is done outside the lock.
>
> > @@ -678,10 +690,11 @@ static void f_midi_transmit(struct f_midi *midi)
> >     unsigned long flags;
> >
> >     /* We only care about USB requests if IN endpoint is enabled */
> > -   if (!ep || !ep->enabled)
> > -           goto drop_out;
> > -
> >     spin_lock_irqsave(&midi->transmit_lock, flags);
> > +   if (!ep || !ep->enabled) {
> > +           spin_unlock_irqrestore(&midi->transmit_lock, flags);
> > +           goto drop_out;
> > +   }
>
> Ditto.

You are right about this. I'll rework the patch along with the issues
noted in Sashiko's review and send a v2.

Thanks,
Sonali
