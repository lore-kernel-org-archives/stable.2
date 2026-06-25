Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E62DCF4C
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373561; cv=pass; b=HErDRMPhr5AErgcpF4TqEiN8q44wESkG32CwKsCiCLMX0V/b5L0vMrGZMEtiEeAfN7WXmjzxxWDcTY8AoLs6JknIRCc1LxYIi8oXeNRJ5N2T91JbuMA2j0yd+cckNdwjgCPS1PxCUnEAUWjFagNOi7nCLbGSNwybDVBtHcyLAcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373561; c=relaxed/simple;
	bh=xjhqiwfqjvDjvq7/IKaE0a/bR4ak+J7qc5NYkeF9uT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZnMxrew1BGsspGlDyvw5H9r4zLHzTzx1orKCS4PL4dv8n1F6IZTGHeFjoIVk2ueaTBNV09q5i0KojDBF3wTJrEWn6ttKqezslVVimClEHxxRTIHiwS3HyuJKkYukdmuIM9CxQ2vkwWodgEJdYbM5NIK2qryNNqnnMYqeHt8AS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xwf.google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/aSYRyx; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xwf.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/aSYRyx"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-519ed52bcc6so192451cf.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 00:45:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782373558; cv=none;
        d=google.com; s=arc-20260327;
        b=gVmvYcz2ku7QeYpdRSRsKbHBTBEjzM0SUoR6ZSlZ/T6JMrmAZ6KkoDNlSAeGrYEQRh
         fY9pSqYLARm0jFj1kcD0ImME1jzMy3+tA4fJFhlzm2UTPQjeVW8V4oxZ+QIs0fqIEPMy
         HHABX7ss7cDDV9+8CPGTzsnrliieajDJWrXCaU5s4t3OnJ7amCuRw6c3fnmFmZ0cUm5h
         Be5o5sYcUbHnyKEz3iikAa9EwuvJBlSTzRQ+V12hpPcUKoWifk1BYT+ac1uZSi/qj4gk
         jFYFRuhSRoCaa4cuJ8GDh7yM1kACixsZEHhIiuFiORkzQMnp4RzVY1BBO37lHNCNj18t
         uVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=zGHJN9jB/OpgAOebJC4dON10veRm2PZSUg/0Ta1s4nQ=;
        fh=H5CtrfUiCra9dy/0A//XDfYHM9i5Cyfx6Z020NArVms=;
        b=WMfVF0ecuUudOS7ABzjJ7xrCBuo4Aoc805TLnLtTpqjOsZT2HsnJxOTz1C51nvszkw
         8BUXYE+XiU9q5sp5vOoDk9nOERQdUpChWco+SRUgZPjpafG4IroqiQaFMVreqSrqgDVC
         2l+YErESmQkYNlONKvQMSCLYGv0UGpA8uw32LGh26xQyBgVGEExEEEOQddHiu/ZSkiV/
         PcByWbkr6F72m6Y3qorygIpJdWxVbPucvIT7jXWycpS2m4nUxJBez+3T7QhCh7Ww89e/
         ankW8KLICIzuHA7sp9B349x1HqrDc48903wqOVk1xgq/cOcHkoRKOnTBI/iTf6BvoUpQ
         uO4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782373558; x=1782978358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zGHJN9jB/OpgAOebJC4dON10veRm2PZSUg/0Ta1s4nQ=;
        b=R/aSYRyxCNEauzv4IdyMqaD8vhOIzkZd/RE/wUFqzsnL32jubqwDJQatnB7ovDkIDj
         h20Z0B/fz5JgXpAV6MoApHqixQWcUwab9Q2cDgWEMM+2ZUkcsbTddO5NRxd/zo20booI
         AFld32DDAXvious6yIMpkv+eIxDeT2PF1pDh9x3uQaMLD5nQ7t3NqZjLZFq6SIo1mx2D
         G2eA9GtkhwDQ0zNEMsC6xx05+4pY/rGbvgmxQRdBwTzq/7FGNfYtbt5xsqFaNXgLlFgR
         4Mufc8nwgC4gK4vXcWENcbMxS+E7whLOUsrVpYUwgQQVamKH7naVwR5K66D6qM8PPXR2
         r+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782373558; x=1782978358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGHJN9jB/OpgAOebJC4dON10veRm2PZSUg/0Ta1s4nQ=;
        b=djVnb7jTIbBpFDDjJYxwWj4QCMjCijuj87CAkwR+4RC5Yk9hMxRQqdVuBGQn9Z2/Gc
         hxA+XKaz3c7N8V89i/KvhOdIqFgiBAntFxbDc0Q6NLjWDeT9otZ1gG9Wdo4j9nMf7qzY
         DP5KMp2DTSOtoTnnj+9i6RhAh/kgeAIdmUJvSHPnMXjKYm/+wBgAaCBO1kegxwXcy0yL
         GHlSX7Pn7RQ/n+p51fV2T23atxjiRZ2Xo21MszIn/oVb4cQ81F2L1xzlzFnyuYizUkw5
         ALIJm8yH9VNAA+ou90qR0Kn+1GLpV6S+mfmzCVUXVlTQighVfLoAAFEXjzG6xVkuzkzq
         /YKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Nc8aQoD2rAwDhBRWpFy0YQ7ACTpZkVyLdE1R5nxiz/ry7jKEdcrVKHMyxfPwOC1TSdp3ttGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIqfpWZkD8Q34tcKgiHHWl82qjwJy+mb35CbiwIedz2Hx2YrJV
	tyyJMxpPq/APkhujKD99UwOemYL/gYAOD3IIPa1c8KlsMRNkP7TvfMjIicdk2Jd2cWvqWkbhRck
	U+Jmv4eYRzql3O/ZQY0hrs77dV3wliCNMBFbNrVvs
X-Gm-Gg: AfdE7cmzOarZJkXA7tIknDCJ4YhSMvdbRDLkzixNsH66pbti8T7t9xao0EcGxOG6L8x
	OIS1DYaKV83/1KsLKoklcyHBqP0tWsd3LHDrmdUdkV9sYyMa6OqKgNDa0xKCPkDRe8Sa/chAnjY
	PnxewMRsJ6UvEg2CHJ11EJ2xWRMeNF3F7QV4IDmH9wXmcbVHLE/KhBoPpFJcKUEbtmvnT2irfpZ
	hGj44xX4sx7leDAE4WrvYob6LVGV0EL5dxYnCVh4yBEW/wVx6OPiBGKZDJz6MnrVvy6dJ2+IXU=
X-Received: by 2002:ac8:5a88:0:b0:519:b655:235 with SMTP id
 d75a77b69052e-51a703faaaamr4692221cf.3.1782373557914; Thu, 25 Jun 2026
 00:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624030154.393004-1-hhhuuu@google.com> <079877da-315a-4ed6-b344-35d9954a54cc@rowland.harvard.edu>
In-Reply-To: <079877da-315a-4ed6-b344-35d9954a54cc@rowland.harvard.edu>
Reply-To: hhhuuu@xwf.google.com
From: "Jimmy Hu (xWF)" <hhhuuu@xwf.google.com>
Date: Thu, 25 Jun 2026 15:45:46 +0800
X-Gm-Features: AVVi8CfP7Jtduehpy4-si3dBYVGhBscoWBJRKaGupGUm3v3mD8AFqszcsL81qz8
Message-ID: <CAJh=zjJ4mfM4_-yQ3B6-rS+uUv3QwCjjV1Wk2ifTwLoBR1E8eg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: udc: Fix use-after-free in gadget_match_driver
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 10:38=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Wed, Jun 24, 2026 at 11:01:54AM +0800, Jimmy Hu wrote:
> > The udc structure acts as the management structure for the gadget,
> > but their lifecycles are decoupled. A race condition exists where
> > usb_del_gadget() frees the udc memory (e.g., via mode-switch work)
> > while gadget_match_driver() concurrently accesses the freed udc memory
> > (e.g., via configfs), causing a Use-After-Free (UAF) that triggers a
> > NULL pointer dereference when the freed memory is zeroed:
> >
> > [39430.908615][ T1171] Unable to handle kernel NULL pointer dereference=
 at virtual address 0000000000000000
> > [39430.911397][ T1171] pc : __pi_strcmp+0x20/0x140
> > [39430.911441][ T1171] lr : gadget_match_driver+0x34/0x60
> > ...
> > [39430.911890][ T1171]  usb_gadget_register_driver_owner+0x50/0xf8
> > [39430.911910][ T1171]  gadget_dev_desc_UDC_store+0xf4/0x140
> > [39430.931308][ T1171]  configfs_write_iter+0xec/0x134
> >
> > [39430.957058][ T1171] Workqueue: events_freezable __dwc3_set_mode
> > [39430.957287][ T1171]  dwc3_gadget_exit+0x34/0x8c
> > [39430.957304][ T1171]  __dwc3_set_mode+0xc0/0x664
> >
> > Fix this by ensuring the udc structure remains allocated during the
> > match. To achieve this, introduce a new usb_gadget_release() routine
> > to the core. When the gadget is added, usb_add_gadget() stores the
> > gadget's release routine in the udc structure and takes a reference
> > to the udc. When the gadget is released, usb_gadget_release() drops
> > the reference to the udc and then calls the gadget's release routine.
> >
> > Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> > ---
>
> This is basically right, but there are a few small issues noted below...
>
> > V1 -> V2: Rework the fix using a new release routine in the core.
> >
> > v1: https://lore.kernel.org/all/20260526070635.839701-1-hhhuuu@google.c=
om/
> >
> >  drivers/usb/gadget/udc/core.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/cor=
e.c
> > index 60340ff9edbf..f8ce8694c101 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -31,8 +31,9 @@ static const struct bus_type gadget_bus_type;
> >  /**
> >   * struct usb_udc - describes one usb device controller
> >   * @driver: the gadget driver pointer. For use by the class code
> > - * @dev: the child device to the actual controller
> >   * @gadget: the gadget. For use by the class code
> > + * @gadget_release: the gadget's release routine
> > + * @dev: the child device to the actual controller
> >   * @list: for use by the udc class driver
> >   * @vbus: for udcs who care about vbus status, this value is real vbus=
 status;
> >   * for udcs who do not care about vbus status, this value is always tr=
ue
> > @@ -53,6 +54,7 @@ static const struct bus_type gadget_bus_type;
> >  struct usb_udc {
> >       struct usb_gadget_driver        *driver;
> >       struct usb_gadget               *gadget;
> > +     void                                    (*gadget_release)(struct =
device *dev);
>
> What happened to the column alignment here?
>
> >       struct device                   dev;
> >       struct list_head                list;
> >       bool                            vbus;
> > @@ -1362,6 +1364,18 @@ static void usb_udc_nop_release(struct device *d=
ev)
> >       dev_vdbg(dev, "%s\n", __func__);
> >  }
> >
> > +static void usb_gadget_release(struct device *dev)
> > +{
> > +     struct usb_gadget *gadget =3D dev_to_usb_gadget(dev);
> > +     struct usb_udc *udc =3D gadget->udc;
> > +     /* Cache the gadget's release routine to prevent UAF */
> > +     void (*release)(struct device *dev) =3D udc->gadget_release;
> > +
> > +     put_device(&udc->dev);
> > +     if (release)
> > +             release(dev);
>
> I don't think the test is needed.  Even if the release function pointer
> was given as NULL when usb_initialize_gadget() was called, the value
> stored in gadget->dev.release would be usb_udc_nop_release(), not NULL.
>
> (Come to mention it, that's a really dumb name -- it should be called
> usb_gadget_nop_release() because it's a release function for a
> usb_gadget, not for a usb_udc.)
>
> > +}
> > +
> >  /**
> >   * usb_initialize_gadget - initialize a gadget and its embedded struct=
 device
> >   * @parent: the parent device to this udc. Usually the controller driv=
er's
> > @@ -1418,6 +1432,9 @@ int usb_add_gadget(struct usb_gadget *gadget)
> >       mutex_init(&udc->connect_lock);
> >
> >       udc->started =3D false;
> > +     udc->gadget_release =3D gadget->dev.release;
> > +     gadget->dev.release =3D usb_gadget_release;
> > +     get_device(&udc->dev);
>
> What this is doing -- the whole scheme you are now implementing -- is
> sufficiently unconventional that it deserves a comment explaining the
> situation.  That is, saying why we need to take a reference to the udc
> and why we therefore need to override the gadget's release routine
> (i.e., to drop the udc reference).
>
> >
> >       mutex_lock(&udc_lock);
> >       list_add_tail(&udc->list, &udc_list);
> > @@ -1462,6 +1479,8 @@ int usb_add_gadget(struct usb_gadget *gadget)
> >       mutex_lock(&udc_lock);
> >       list_del(&udc->list);
> >       mutex_unlock(&udc_lock);
> > +     gadget->dev.release =3D udc->gadget_release;
> > +     put_device(&udc->dev);
>
> These two lines don't seem to be needed; usb_gadget_release() will take
> care of this for you when it runs.
>
> I suppose you could argue that usb_gadget_release() might never be
> called if the gadget was statically allocated by a modular driver.  In
> that case the udc structure would be leaked.  So if you want to keep
> these lines here, that's okay -- provided you add a comment explaining
> why.
>
> Alan Stern
>
> >   err_put_udc:
> >       put_device(&udc->dev);
> >
> > base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
> > --
> > 2.55.0.rc0.799.gd6f94ed593-goog

Hi Alan,

Thanks for the review and the detailed explanation.
I've sent v3 with all your feedback incorporated (column alignment,
NULL check, and expanded comments):
https://lore.kernel.org/all/20260625073705.803880-1-hhhuuu@google.com/

Regarding usb_udc_nop_release(), I completely agree it's a dumb name.
I'll send a separate clean-up patch to rename it right after this fix lands=
.

Thanks,
Jimmy
