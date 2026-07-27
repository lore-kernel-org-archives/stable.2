Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95DB3E9C12
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143367; cv=pass; b=t50eWtiIVWBzCpNPSETsAU3iT1B68RC5YBMLVCSfjyNN085oeuBDsIjlfofz1SC5jKgDtVwwVojSDkoJX1VLxNJu5ltaL3l2sGx+Vz1hjKnUYkUqvdPAxSbnkWlEDZmTbXegMeZQOfh+g2yhmAtnyYnpzGPUMRBzCjRGgeTc2/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143367; c=relaxed/simple;
	bh=9LtrwgiQSccbGGnkUIOdGQuhSzPaFLy9gcsyZ6YsSvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbkvz4cs9t2nEWcdgU11mKFKCuXYdhPdHNxa5My4WPFp8dNcaE99OQfDWFpASVtYRlhw7dTMDS6AohTUWDP2k9xH5G66Eydyqh6GOrqfVON5EJoEk+YfcKETDwwi6zm9jQGCfUkvsTWVU5l8crcfllwPFpRypBzwFE1BGLGJYpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLvy3ztB; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLvy3ztB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4957eefd361so18611435e9.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 02:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785143364; cv=none;
        d=google.com; s=arc-20260327;
        b=LaPyj1NMNHkqOyVK8mYpZi1VcqRF9MnNmlvaCmHq2eeEqaYShswSBmjqGLGZ+6HISn
         lT1GshcSVg0hU6DVGMq914ma4YeaA930A3TXLBwdRsN72CxdzPHWYEZ+kNTvp4/RL/7V
         bzpfYuIi6EnPUGemAmUt/D0UK52gTvQcwTcETTfNDb4F3YsGAwxME22Jp0Js5TaD3LjR
         PHw9ZYo2fSW049ho91RSxHyewvI0gd4dqG4PbGMjNJgUC527eLTANVnln4mwwRYrs+me
         M4ZSifnesnnQuFBp+11qpx8ySVqbkxdGVV3olDSEoqPAWpAOC5L/tRGE1kyIhGL5h5bV
         Q5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JdhVvMZN12mkLgsjdr2GJaRkJT3E6icWbbcpnxvBnOw=;
        fh=jLoki6s43rPzn7S+Qxbj9h+6aypkVFOMf+bgYJvN7tA=;
        b=hx+spCK2ttUU2jnwG5UIUt2Kq5UtflQ1eMy78LFjXykL0pjN3tCg3tho1Jr2/hUnub
         PwFDpCE/Axa1p1QD0rqY8v1X2jjkokTcVlPIF/vPac1LWb3yeL5Fq/5/cJYDeOpP4fJc
         /7ypLmwb40t7qb4Ug9FRqx4PmBNCB+gffMpwlZoClYJS5UzVf7+LFHFO76RW6IANuCyx
         RSPddiRehtEShDDEes/Tne+SDKilutmo37OqMZB6MJvfjnqsM4Fii9iNqucmj9qsQpcv
         0BN8feod+7hcSjZPftIU4yn4LHu65Bki6+ikeHP/jMLL2knK9i8udIjUbg6tOWY4leEu
         /QwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785143364; x=1785748164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JdhVvMZN12mkLgsjdr2GJaRkJT3E6icWbbcpnxvBnOw=;
        b=ZLvy3ztBDLJYUMJZoBAWXU7yIkBd7evo5aGro2Dvr6E4ML9X52d5sxSP1QONpZif1I
         Yo6INJS3cMp8Dw2YPgTYwNLH532Kmee2FehhYUuxYeIHpUG6yGd6GJ8/vsdhGCT5UATt
         y41lD0ZmZ/4cFDKTNtN5DfWmwQJ1HA8I/KvHeiUX3quuKbrSyX2beoJkNUNvh9jPsGld
         VvwGhdZU9KCT2GOZ+/z/2XIp7B24wsKEKRn4M4+0fjZvDOwM+uzuv378WNiW4me5/tTF
         O/ZjPxFFZ6SJPx3lWdIPRoGecHxvQwXFrBixkx69vGn+epoxLUS1i/SpsLXQNFmZClE+
         MwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785143364; x=1785748164;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JdhVvMZN12mkLgsjdr2GJaRkJT3E6icWbbcpnxvBnOw=;
        b=VJvXMyzgg5cDvNHIMKK3mMG6XV00OgPhH8nYLwAbIzCQLJ9OcAl1Gc5WeFlGHXFvlo
         VKWNtyzxdSNo3xEM7N2zDJEoKOvSWKf8Ah9egtAdwjXdlQhbaASzX/tOy1Ei22iXs4sX
         5yDH1ke1Wlf6MqVfic3WVTDkxktT6ZmA5UBMyNtBZiRtiF0+6SkCHhPO5A5Bj1nt+63L
         OSKWvVtOtNWVCO77+mGpWUqaD1xprcDVUnJKzmi0HaDIopuUzwWoaJwARg4tNbuagucF
         I1cEkDw1tG2Y46HzOMDWBu8ChZJiTC1DiYNywsdbYdtDlG90sCzeNMdCkt2b0q1EwMeD
         v8jg==
X-Forwarded-Encrypted: i=1; AHgh+RoatjmKau/X9bN3U98Mf5DMvmL1pQCkElFybEFrHyvcRxd4q8muJ7ES4yb+/qaCf/q/gj0xruE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHA0kbcviVEk+rXYruqH9cnuIzDmzzxzsgY8/lmsXlY33s2z62
	+mO+GPwmr3v6A4CnYh82h4foVMc6++DPg7JMUs3qi2FdHzmER1YXIOESDwRj/Xs5K9tLYtdRCvt
	T/YcYu/6/5mafFWqeberTW++sxYARY8Y=
X-Gm-Gg: AR+sD12YFntUenfhQtPH99LEcZPrjz++KqQU4P/NQNo8WIC71G01ye+aLXu7kHxxEFx
	Rw1yTLXNsy8P5iQLaVmic9mKi3/yecsHAkmvnSvAImxn+w13u+8CRDX3TuEWG3BeqXLS7hUR9Bc
	DLmuMOvyYjgomyymubhSJ1QVil758z3oCFAQ+5yUJq2MZMYSfASXEOARvoIZGUg3nepCrxhd6cO
	HANiVvvhvR5MXJsoUT6bIan4jVDBVC04P9vvFwuQLwF6q6/z7MQr/QvzmzW1OWhNy558794exBO
	N+NyCcR3jSFSwUC+uVWo54E7Zn/hc+Rav6/5TGXyATzbS5L5OcuG7l302viFVPGIu5e+J4I/ZK9
	s1V5Z
X-Received: by 2002:a05:6000:2c07:b0:47f:7030:bfbd with SMTP id
 ffacd0b85a97d-47f9fea7d1amr9501388f8f.48.1785143363292; Mon, 27 Jul 2026
 02:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715223019.3002237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715223019.3002237-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <97f207cb-4ae5-4a48-a5da-fb4167f8d0d4@tuxon.dev>
In-Reply-To: <97f207cb-4ae5-4a48-a5da-fb4167f8d0d4@tuxon.dev>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 27 Jul 2026 10:08:55 +0100
X-Gm-Features: AUfX_mw0NWK-edxNp2T0-GT5xa6oAmVVbb0LklmBjLsIb83Q7oOJjRpihR_TXic
Message-ID: <CA+V-a8sG_tQo5vKSLGkjUnu8=Nf95TgJXFZmN5vJAVzBZDezsg@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: rzg3s: Fix IRQ domain initialization error handling
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thank you for the review.

On Thu, Jul 23, 2026 at 6:11=E2=80=AFPM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
>
> Hi, Prabhakar,
>
> On 7/16/26 01:30, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > rzg3s_pcie_init_irqdomain() installs chained handlers for the INTx
> > parent interrupts before creating the INTx irqdomain and initializing
> > MSI support.
> >
> > If any subsequent step fails, such as obtaining an INTx IRQ,
> > creating the irqdomain, or initializing MSI, the error path returns
> > without removing any chained handlers that were already installed.
> > This leaves stale handler and data pointers attached to the parent
> > interrupts.
> >
> > Fix the error path by unwinding the chained handler registration before
> > returning. Also clear the chained handlers during
> > rzg3s_pcie_teardown_irqdomain() so that teardown fully mirrors the
> > initialization sequence.
> >
> > Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >   drivers/pci/controller/pcie-rzg3s-host.c | 37 +++++++++++++++++------=
-
> >   1 file changed, 27 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/con=
troller/pcie-rzg3s-host.c
> > index f51b5d7c1998..5aeb030d43c8 100644
> > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > @@ -1006,22 +1006,30 @@ static const struct irq_domain_ops rzg3s_pcie_i=
ntx_domain_ops =3D {
> >       .xlate =3D irq_domain_xlate_onetwocell,
> >   };
> >
> > +static void rzg3s_pcie_clear_intx_handlers(struct rzg3s_pcie_host *hos=
t, int count)
> > +{
> > +     while (--count >=3D 0)
> > +             irq_set_chained_handler_and_data(host->intx_irqs[count], =
NULL, NULL);
> > +}
>
> On PCI subsystem lines are still wrapped at 80 chars length. Could you pl=
ease
> update it, adding also {} around multi-line blocks as the rest of the cod=
e in
> this file is doing, e.g.:
>
> static void rzg3s_pcie_clear_intx_handlers(struct rzg3s_pcie_host *host,
>                                            int count)
> {
>         while (--count >=3D 0) {
>                 irq_set_chained_handler_and_data(host->intx_irqs[count], =
NULL,
>                                                  NULL);
>         }
> }
>
Ok.

> > +
> >   static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
> >   {
> >       struct device *dev =3D host->dev;
> >       struct platform_device *pdev =3D to_platform_device(dev);
> > +     int i, ret;
> >
> > -     for (int i =3D 0; i < PCI_NUM_INTX; i++) {
> > +     for (i =3D 0; i < PCI_NUM_INTX; i++) {
> >               char irq_name[5] =3D {0};
> >               int irq;
> >
> >               scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + =
i);
> >
> >               irq =3D platform_get_irq_byname(pdev, irq_name);
> > -             if (irq < 0)
> > -                     return dev_err_probe(dev, irq,
> > -                                          "Failed to parse and map INT=
%c IRQ\n",
> > -                                          'A' + i);
> > +             if (irq < 0) {
> > +                     ret =3D irq;
> > +                     dev_err_probe(dev, ret, "Failed to parse and map =
INT%c IRQ\n", 'A' + i);
> > +                     goto err_cleanup_intx;
> > +             }
> >
> >               host->intx_irqs[i] =3D irq;
> >               irq_set_chained_handler_and_data(irq,
> > @@ -1033,21 +1041,28 @@ static int rzg3s_pcie_init_irqdomain(struct rzg=
3s_pcie_host *host)
> >                                                    PCI_NUM_INTX,
> >                                                    &rzg3s_pcie_intx_dom=
ain_ops,
> >                                                    host);
> > -     if (!host->intx_domain)
> > -             return dev_err_probe(dev, -EINVAL,
> > -                                  "Failed to add irq domain for INTx I=
RQs\n");
> > +     if (!host->intx_domain) {
> > +             ret =3D -EINVAL;
> > +             dev_err_probe(dev, ret, "Failed to add irq domain for INT=
x IRQs\n");
> > +             goto err_cleanup_intx;
> > +     }
> >       irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
> >
> >       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > -             int ret =3D rzg3s_pcie_init_msi(host);
> > +             ret =3D rzg3s_pcie_init_msi(host);
> >
> >               if (ret) {
> >                       irq_domain_remove(host->intx_domain);
>
> Could you please drop this ^ from here and (see below)...
>
> > -                     return ret;
> > +                     goto err_cleanup_intx;
> >               }
> >       }
> >
> >       return 0;
> > +
> > +err_cleanup_intx:
>
> Add it here? To have everything grouped together. I am also working on fi=
xing
> the hotplug support and having it like this would be useful. I can do it =
myself
> in a separate patch, but I think, logically, it belongs to this patch.
>
Ok, In that case I will need to add a check for host->intx_domain !=3D
NULL before calling irq_domain_remove().

Cheers,
Prabhakar
