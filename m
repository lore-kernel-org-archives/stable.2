Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1C51B173
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029026; cv=pass; b=Ucfq/eefqc8ts07w+/NY45q9/Zt2bTyR1NSpa8Qgj0Ujlu03HQvTnbQD2/tYF/aXwoHJZBJBQIGVG1AIfz61HF5Ia+RlME21X1SU1y0SW3UPZ5EOwCuxqx6DGvVYfYTJ4tChIV5FWZyGAfHO+JXgj+WSptri5SLhOv5A8gE4gqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029026; c=relaxed/simple;
	bh=ygxQGrVULTuQLXHw/7/JdMV/ZQLiV+IGlcOGZt/F2D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7qKf27IuWGd57baRw9aZTqNQYIEhGFeF9NqM3SFxVmqyiquSFped+iV4eW/kpbYwJsSIvOSVGPRWK+wJLXFxn+8SiyWiLHOCGr0yLVykGvyKguvDL4cT0YXuOhaoX48R3MGNmHlvZxepawIEWbwCZIUcMjd/b3lsSTkcnis2AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o16dsyQu; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o16dsyQu"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa22408406so5351033a12.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790029022; cv=none;
        d=google.com; s=arc-20260327;
        b=rM02/UMflstT7NCLEid1IXMFtQTzkJvfGhiR6V35EcS7ETm9Ua1pBJsWj+wNjYGR99
         gmZWK4d77voJIjmtUSiaGe+1xhR+36ohotNk8s6+06alRBkRieJvjEgj53LOXhwjd9JG
         dcbc7++v6P/rKvHzm+2gHOJym7wm1VW/f3OzpdiEeqmABqBa+8zycdMbwLiZrC3Pi/ct
         jMoeROAvSCuReewmVlN7gV8qVm+Bw0iwqI3jqYGAaspe7trL0KENcAQKeRoT+K+wKH/m
         OIp2ARUpaKdJwTNJyJKqYID8l5gb5fY3wSyGvMVqoPMDxSUywAFLMJCuJ7V5SC3UZPWs
         E4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ck2dQ4iiA8x8tPtfYLzBLk9ACmAdSjWMpZnAG67iB4E=;
        fh=Dv5/TlruSh0170NBo6689p+O0fdoNUXJNHn17OA0Guc=;
        b=MiZCNizttNXtyDDpMQ1gxEqoEwRp6gAQeAy7V9mR9f9fLyKIHbflPyEAXTzBLDoFLN
         +jTdiW+6Q+8+10twPfFcjQM5ZNPzrUQXZgeGRjtcd2USsbm2QbmM7P9ZUc+lZBM0JnA9
         PvGs7uzW+3TchgTBqPfPGZvO0M5FRRqPrQDrJIrhCwxhbii/vjWr8fGq/OuDCqxOi8HQ
         AN5a/F4KJDKiKyBTOmz0W/f/HX74unm2ncS0wRKHHJOdLT55orf5MdWcbBbd8KIgZ55X
         DUWPhzbqcNsj5jancUc1MeuG7IFrBRHX+oVb+t2Hik73Vui8WoOxKw7UiHNinYKjGHam
         rpLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790029022; x=1790633822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ck2dQ4iiA8x8tPtfYLzBLk9ACmAdSjWMpZnAG67iB4E=;
        b=o16dsyQumVzJ6ZQD9CBPZDz7YOyTg+pWyJM4BZxRIEkzasViSj7ryKk/YSR5KboqyD
         N83aI3rJno/AkfjPuoFBp8G0qX7X6KV8DXy75N9/Ih4AQ+dOPnVxxOVz/SFmwSdi8rXo
         PAckqX5bPQv6k1wOv0NO8MWWG4mlhF3YLJaPpnWql8Bro/IbTaTziifDN9OIeCQwtXn5
         eZKC//FrR3NTUiMsi+gtr6DnbmWadYllc02tNhue6HVursRuuwxEscIkUO0jujJxEQ5C
         Ge6Y5UMpXO0bjYGlDGZtvETsUXLC2BzMDi9cU38TvWYHuFAPaM4NgEoNeFH3zVB+ed0w
         vKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790029022; x=1790633822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ck2dQ4iiA8x8tPtfYLzBLk9ACmAdSjWMpZnAG67iB4E=;
        b=fnapaPqyqWPajd5YLVU332+rmar4S8TJXiEUFYnAGmbdv8Ut66kuKsIq+XZTCZzTWj
         4F6Si2xviJPdw6/EsfTV5VBktWh66j0PhwwzBdxmp7aO8xs9Sh9PXOX1OvpnFCDHZsyM
         9glUNBEFpF8vb5SvI0IwHM9CrhomnpSUO4g74PwlgAES8Uwn8kLZ37fj6mm06RcC6hKn
         5sk31nA/bxrY8LAKyI6oKJOPQVDxxqJuL140OD4RiSeSEx160fsBnegdYMfJx9JeLK0g
         9PVowbfrzAGZCy57ZL04H6lFsEk9YZCKLxSi2eJFIHLSwi77decG/5fM/ANNMUeN9h3G
         7/gw==
X-Forwarded-Encrypted: i=1; AKwUvBzV/735RkQH8sVFhnAyRuxAy+hb9GCARGeZBxr0aU8aMW+aEtCNEI9ClbFxMJG2fW+DyzoFK9A=@vger.kernel.org
X-Gm-Message-State: AFuF++kjyiXyeJ8zNgTRIRwy7xC01dgSoe5nclLH23XJVse06nYItZ/j
	cOGoOAo1A85RaC6a+gbLnl3+uRtZARqTWyaybbOsHaB3OuLhnhZwwMfvBYHjw3WCvfZtxYzycb0
	mg0AyCmuuFUVsA6hryUK+oxZTzfVzOw==
X-Gm-Gg: AYBFou1XHM0eqvzezqrsl41aisbKv8QkGGZfispzWzowhsNaK/hqYzjQQ0c+GkvEvDR
	XiVQaI3xN8Di5JYvLN6ZWNRMMc7fXaBdYp4s0Lz+/i5gHR5eBJ0mX1X2826xJv4OTb0nEpLbCWq
	3xkskvjUzLibXs7l0M7d7GRq2/oyGMcVzcUqn9kzReqXAqU1N5QhrGGqSVaQo/86xM+wcKN2rpp
	LtCfbxYAnwRYycvUtlK4XuhbkfHOTQVmudVD279OyVOsB55S1vmvGUtBzYu4NmIsJ/diaZDa55j
	H6RBvamUZDSYVu4uGaCI68enUeOtL+O+a2OaMBqinysvCbhFnAuNMzA1BUXZYJeEGelYgcZ8y/M
	ch0nNraqL+XYa08c3H96ikouL0BScLXYymT5vM57BeN3BuY7k5CGhoP/NH/LjBgRfWhDy
X-Received: by 2002:a05:6402:2790:b0:6a7:ee56:8158 with SMTP id
 4fb4d7f45d1cf-6aa579b0382mr9106641a12.38.1790029021870; Mon, 21 Sep 2026
 15:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGEsz8F2eKsmV_tymO+9UD5xkS_tWhZo-b9Xom1_SiKuc-BCqg@mail.gmail.com>
 <arETYSjwaHytxyBu@orome>
In-Reply-To: <arETYSjwaHytxyBu@orome>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 21 Sep 2026 18:16:49 -0400
X-Gm-Features: AcwNN1ULiGgKpQwlzJhSBbDWZG7BlTQmkG_ouL-IXAT-QUCIcQoVWsAgftcR8FU
Message-ID: <CAGEsz8EpXPPD=S8uM4fex1_c5eV6byzOcYgVyqmJMKBLUAm67Q@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: tegra-xudc: Disable port reset work on removal
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review. v2 keeps the Fixes tag on one line and switches
plc_reset_work to disable_delayed_work_sync() as well, since the
port-status IRQ can queue it after cancel_delayed_work_sync() returns.
usb_role_sw_work stays on cancel_work_sync(). Its producer is the USB
PHY notifier, which v2 unregisters first. The two bugs are split so
the notifier fix can be backported below v6.10.

2026=EB=85=84 9=EC=9B=94 21=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 7:28, T=
hierry Reding <thierry.reding@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Thu, Sep 17, 2026 at 07:20:58PM +0000, Myeonghun Pak wrote:
> > The port status interrupt can schedule port_reset_war_work to handle th=
e
> > Tegra210 port reset workaround. The remove path does not cancel this
> > work, so it can run after the PHYs and controller resources have been
> > released and access freed memory.
> >
> > Disable and drain port_reset_war_work before tearing down the controlle=
r.
> > Use disable_delayed_work_sync() so that the interrupt handler cannot
> > queue the work again while the managed IRQ is still registered.
> >
> > This issue was identified during our ongoing static-analysis research
> > while reviewing kernel code.
> >
> > Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB
> > device mode controller")
>
> Please don't wrap lines like this.
>
> > Cc: stable@vger.kernel.org # 6.10+
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/usb/gadget/udc/tegra-xudc.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > --- a/drivers/usb/gadget/udc/tegra-xudc.c
> > +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> > @@ -3926,6 +3926,7 @@
> >
> >       pm_runtime_get_sync(xudc->dev);
> >
> > +     disable_delayed_work_sync(&xudc->port_reset_war_work);
> >       cancel_delayed_work_sync(&xudc->plc_reset_work);
> >       cancel_work_sync(&xudc->usb_role_sw_work);
>
> This is a preexisting problem, but given that we only delete the gadget
> below this cleanup, shouldn't the other two cancel_*() calls be
> disable_*() as well? Otherwise there's potentially a race condition
> between this and the interrupt handler (which is only unregistered after
> .remove() completes).
>
> Either that or the existing cancel_*() calls are enough in which case
> your patch probably should be using that variant as well.
>
> Thierry
