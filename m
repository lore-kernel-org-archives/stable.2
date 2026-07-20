Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9BD3909BC
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574746; cv=pass; b=rvpRjWk4DSo2xYONY9mSXpmzP2xU4Npqbdyhq+IG6/twcgPNysZdSZbQJWPWaMZFg9uWk4C2ClU5dIkexfWn6qDljgdekiVpTYk1Sxf1AK97owhv5JFoMwkqysbrd7gUpORZQjHAUj6yGmX4we7KuKQTiTAGJOtmFKi9lwuSUF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574746; c=relaxed/simple;
	bh=mREub83eGI32NFJ5AQK+0Smu7QqyiGENCYK6tMBvBH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCeeS55fDjU0XMSH0SUyfMsJs7itKyDxeycLmOXZn6UXk3dVCa2m/vnDeyLfUMrJ/Yp5IQYkNlePXO8kpcPA66xXoYQTw0TB/x6f3EcMUBJ2aApR1wQs9IXbhZarI9Xm52LsV6MS+y3E6Vxw6vqlpcBSgAhhvRasOTeJ47n4Jwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF3uueS5; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF3uueS5"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so3656135fac.2
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784574743; cv=none;
        d=google.com; s=arc-20260327;
        b=sz/osx83qWhgtL/zbwg91OmhISrHcTG8hjRV+Jfyh4b0mDHnxZEOSC01JTOrGzNUMA
         yqnebD+0PxQft/zdpfqRgMgd8ZDvWBm9q/WMQxt3aI7JdHafyHmIguIGfMjlur/96riq
         MmL0j9aI43EJAhk22FUpeX9nbMsGu4ET9mD6MWwhXQ2EsrctgadaV8EEsMAAdDDwFQgv
         KIXkLnvKuU4aIXfmkik4Vy8+wURy2t5baCv2wjZpjIYGyK/J3B15u8Vxiax9wmuBMmnw
         hSuoCfaa03mSb5Sk6HZbQm+LD8oMWLLw7MQzsuX5jhAJS377+wOjTGtT/jYe0IScoI53
         sHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qgTohs12tn7pUsawXCo+sFgrXRMEdlm/0Hs5iyyxK0A=;
        fh=TiE4PhWEfk36fBs8j/iNmFniKmFjXgCJ6QrsGBOJqPE=;
        b=eHAysm5WShQQ4gKErDjVCn9LYPnCjaQYth2RJfTdNjfUvSa6dp0WCWqrVgINBQxBR7
         tWPu186wO6g0WYmcSGKenlzIG47DUpn/Xch4qQvvo5SCRwfXnXsNefSkhCndYBFbM3Qx
         DU0IQfhCoeVS1DbjgFmnAAJrk8W3gmQ7xyx/wPB4f1wez0vXqe/HWYrYIymaEWCoG0ui
         PU1ffUPtP12bGE+rAQTPtPsUiejLjLfkp/r32cbSjXhse75VIe3OV1VciVwDidl9GgJz
         tLmw0ZhZBdSFdeFJvHcDiiyVJRoXCFoRBChxlyfly/t+HkPwb9+3Osy52TWL0jwL8OiS
         8Q0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784574743; x=1785179543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qgTohs12tn7pUsawXCo+sFgrXRMEdlm/0Hs5iyyxK0A=;
        b=NF3uueS5U52/IORfZPJUBzNXoATpcJNTTjGNTS9lACvN5iijlpAhTYRCifnadG9m0z
         R5D5ZumY38oeSTpFUDTyqXetll5fAOs1YKeGiJWWjfLESI1m9V9IqEhw4Wtl73fn4/Mo
         bXplRmg8cIYmzKYhPlRxTF53sEnpHjou8+d2W/5lHM0nPq9uphbrxx16gzWBwzgOWF9M
         HHGca5s8VKu3Am3ftAZZMgwgmoVnLlYu6qmn/SV1+WCi2+YSR+8vvR2KShm1U8q7f5pL
         a0gRnmH8IjJSmtdPbtxuIBQwoDlaGrIjsW8ldOkOACcTv3pOc1fSyxyHqq5XKEBUlePL
         Z0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574743; x=1785179543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qgTohs12tn7pUsawXCo+sFgrXRMEdlm/0Hs5iyyxK0A=;
        b=kdbPkHL68TZMaupKtDopGOLN25yDXEFSYlTsoq+R+gsFyldBl+ZaSzBEEPhcZ5ujXq
         6R4zWXnP945or1wtpNiVifXepIxWbTvnybxKVJZF3jeUPlckghrrA2oF3eyyTEajS7A1
         zb8RJ3kyzIdPewoyDviNtoWC4V8a0RSv5pea3TgnykX97skrAwMixhTrdkTcbMLP6O1/
         dgdLUZsYmeBIzH0GYn7Pb5G51QUO30SAwnT39OAcTOQSLwCwGKVq/UmxyBc/ZRx1es+1
         PdJSlFSqAVMxwrFd0B7AWT+h/YaoQA4C0ieCnM30BDs6GaRtbz2mjUNtfoUy/ZXJRNWo
         gShA==
X-Forwarded-Encrypted: i=1; AHgh+RpzuPGm1LRhFKX5JqzSROJ3KSDcI5ZH3lxQkoVamoT/PJL95ZdGjKvf+s1Jr9+O9vhA0ukTbWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCThCR6GT0sQUu2WZsEmv2nMwOIlgpQAMMaRYG+yPW2DLxnTR/
	4Qfg6Ap4goBawMiOJnzxo1C8fyQBSKs/aF2TEUwgHWWwGj2PBBNsjRmDsgjCJtWq/mSBWm29kgL
	Z/iQgdHWDBsm53ZDqq6XLn135Vnvu6xg=
X-Gm-Gg: AfdE7clH0kK4NYk8AheS9FSc78MkohejzZHw27aNFAJwWiuqzfXWw7LZQVqo7St9pPO
	wVMoCq/fL60R49hUzsDIC9yJPY5NeW7p/2OUX0fZSYhovPhBxxuhrIRmIrjGaQB/t47dvvJ4ehA
	6Lg9hWzAEuI5CuEgAfj+7kE/OJFrZthpb3qTDxiaBI8mG5C3iEVijkm95PPuDJruEqkxcRXh9tj
	ryQK1fCw/CdZmjEvW3gTLmX9W+5vxTYpffCIEatv2VuRyH3DMvurn4LeneqsrOVzORuJh5SPqo/
	AzRhX2CHi/O21viyHU0=
X-Received: by 2002:a05:6870:a488:b0:441:3cdc:28c7 with SMTP id
 586e51a60fabf-456902170bdmr7045940fac.9.1784574742840; Mon, 20 Jul 2026
 12:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720150207.1963786-1-charles.daoust@gmail.com> <2a80e88e-936d-4927-a915-352fe92e47df@rowland.harvard.edu>
In-Reply-To: <2a80e88e-936d-4927-a915-352fe92e47df@rowland.harvard.edu>
From: "Charles D'Aoust" <charles.daoust@gmail.com>
Date: Mon, 20 Jul 2026 15:12:11 -0400
X-Gm-Features: AUfX_my8a4yLN_j8L1tIkscz-2rravyhw63mOlWyCUvY8YFH5chrZpGkergO1Gw
Message-ID: <CAAhWKQQU5Bj6iDGP2KYTcx=TpGDo70qLR_vpyJqc9jAA4KkxCg@mail.gmail.com>
Subject: Re: [PATCH] usb: core: add USB_QUIRK_CONFIG_DESC_READ_255 for Razer
 BlackShark V3 Pro
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You are correct, they are indeed the same. I apologize, I missed it.
---
Charles D=E2=80=99Aoust

---
Charles D=E2=80=99Aoust


On Mon, Jul 20, 2026 at 12:04=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Mon, Jul 20, 2026 at 11:01:26AM -0400, Charles Daoust wrote:
> > From: Charles D'Aoust <charles.daoust@gmail.com>
> >
> > The Razer BlackShark V3 Pro wireless headset dongle (1532:0577)
> > fingerprints its host during the first enumeration after power-on: if
> > the first GET_DESCRIPTOR(CONFIGURATION) request asks for 255 bytes, as
> > Windows does, the dongle enables its vendor HID command channel; if it
> > sees the 9-byte header-only read that Linux issues, it disables that
> > channel for the rest of the power session.  Audio still works in that
> > state, but battery reporting and all vendor commands are silently
> > ignored, and nothing short of removing power recovers the device:
> > resets, re-enumerations and byte-exact replays of complete Windows
> > control sessions were all verified not to help.
> >
> > Both read lengths are spec-compliant (the device truncates the reply
> > to wLength); the firmware was evidently only validated against the
> > larger request.  The kernel already accommodates this class of
> > firmware assumption during enumeration: hub_port_init() reads the
> > device descriptor with a 64-byte request because that is what Windows
> > does and what many devices expect.
> >
> > Add USB_QUIRK_CONFIG_DESC_READ_255, which makes usb_get_configuration()
> > request 255 bytes for the initial configuration descriptor read rather
> > than USB_DT_CONFIG_SIZE, apply it to 1532:0577, and expose it as
> > runtime quirk letter 'r'.  Devices without the quirk are unaffected.
> >
> > The trigger was isolated by single-variable bisection on otherwise
> > unmodified kernels: with only the widened initial read, the dongle's
> > vendor channel comes up enabled on a cold plug with no interface
> > drivers bound (bare enumeration only); without it, it never does.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Charles D'Aoust <charles.daoust@gmail.com>
> > ---
>
> Is this not the same as
>
> https://lore.kernel.org/linux-usb/20260717195336.98500-2-nikhilsolanke5@g=
mail.com/
>
> ?
>
> Alan Stern
>
> >  Documentation/admin-guide/kernel-parameters.txt |  3 +++
> >  drivers/usb/core/config.c                       | 13 ++++++++++---
> >  drivers/usb/core/quirks.c                       |  6 ++++++
> >  include/linux/usb/quirks.h                      |  3 +++
> >  4 files changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index b5493a7f8..1bd138ba6 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -8169,6 +8169,9 @@ Kernel parameters
> >                               q =3D USB_QUIRK_FORCE_ONE_CONFIG (Device
> >                                       claims zero configurations,
> >                                       forcing to 1);
> > +                             r =3D USB_QUIRK_CONFIG_DESC_READ_255 (ini=
tial
> > +                                     configuration descriptor read mus=
t
> > +                                     request 255 bytes, as Windows doe=
s);
> >                       Example: quirks=3D0781:5580:bk,0a5c:5834:gij
> >
> >       usbhid.mousepoll=3D
> > diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> > index cd3231d21..c7e21cc76 100644
> > --- a/drivers/usb/core/config.c
> > +++ b/drivers/usb/core/config.c
> > @@ -908,7 +908,7 @@ int usb_get_configuration(struct usb_device *dev)
> >  {
> >       struct device *ddev =3D &dev->dev;
> >       int ncfg =3D dev->descriptor.bNumConfigurations;
> > -     unsigned int cfgno, length;
> > +     unsigned int cfgno, length, first_read_len;
> >       unsigned char *bigbuffer;
> >       struct usb_config_descriptor *desc;
> >       int result;
> > @@ -938,7 +938,14 @@ int usb_get_configuration(struct usb_device *dev)
> >       if (!dev->rawdescriptors)
> >               return -ENOMEM;
> >
> > -     desc =3D kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
> > +     /*
> > +      * Some devices (see USB_QUIRK_CONFIG_DESC_READ_255) malfunction =
unless
> > +      * the initial configuration descriptor read requests 255 bytes, =
as
> > +      * Windows does.  Only the header is consumed here either way.
> > +      */
> > +     first_read_len =3D (dev->quirks & USB_QUIRK_CONFIG_DESC_READ_255)=
 ?
> > +                      255 : USB_DT_CONFIG_SIZE;
> > +     desc =3D kmalloc(first_read_len, GFP_KERNEL);
> >       if (!desc)
> >               return -ENOMEM;
> >
> > @@ -946,7 +953,7 @@ int usb_get_configuration(struct usb_device *dev)
> >               /* We grab just the first descriptor so we know how long
> >                * the whole configuration is */
> >               result =3D usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> > -                 desc, USB_DT_CONFIG_SIZE);
> > +                 desc, first_read_len);
> >               if (result < 0) {
> >                       dev_err(ddev, "unable to read config index %d "
> >                           "descriptor/%s: %d\n", cfgno, "start", result=
);
> > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> > index 87ee2d938..c8f71b825 100644
> > --- a/drivers/usb/core/quirks.c
> > +++ b/drivers/usb/core/quirks.c
> > @@ -142,6 +142,9 @@ static int quirks_param_set(const char *value, cons=
t struct kernel_param *kp)
> >                               break;
> >                       case 'q':
> >                               flags |=3D USB_QUIRK_FORCE_ONE_CONFIG;
> > +                             break;
> > +                     case 'r':
> > +                             flags |=3D USB_QUIRK_CONFIG_DESC_READ_255=
;
> >                       /* Ignore unrecognized flag characters */
> >                       }
> >               }
> > @@ -496,6 +499,9 @@ static const struct usb_device_id usb_quirk_list[] =
=3D {
> >       /* Razer - Razer Blade Keyboard */
> >       { USB_DEVICE(0x1532, 0x0116), .driver_info =3D
> >                       USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
> > +     /* Razer - Razer BlackShark V3 Pro wireless headset dongle */
> > +     { USB_DEVICE(0x1532, 0x0577), .driver_info =3D
> > +                     USB_QUIRK_CONFIG_DESC_READ_255 },
> >       /* Razer - Razer Kiyo Pro Webcam */
> >       { USB_DEVICE(0x1532, 0x0e05), .driver_info =3D USB_QUIRK_NO_LPM }=
,
> >
> > diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
> > index b3cc7beab..02de5ed48 100644
> > --- a/include/linux/usb/quirks.h
> > +++ b/include/linux/usb/quirks.h
> > @@ -81,4 +81,7 @@
> >  /* Device claims zero configurations, forcing to 1 */
> >  #define USB_QUIRK_FORCE_ONE_CONFIG           BIT(18)
> >
> > +/* initial configuration descriptor read must request 255 bytes (Windo=
ws) */
> > +#define USB_QUIRK_CONFIG_DESC_READ_255               BIT(19)
> > +
> >  #endif /* __LINUX_USB_QUIRKS_H */
> > --
> > 2.55.0
> >
> >
