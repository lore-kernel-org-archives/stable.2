Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A71339368
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343522; cv=pass; b=gG0IqGvKjq9r0KYWTl9PuOZ0pE6I3bE/S1TGG/AHhjwbyJLKW40Id+sH4sMEI8iVVYsvoXBlU4i+8qly0HyTq6+c3pE37u+cUoH2P/DAD3n6JZTNmHwgqgYqT+87wUMVM/OfBpR4YR8Ty2LEicvtdueiPLuwcD7LFnAtn7D3b9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343522; c=relaxed/simple;
	bh=Glv+D9dOgkTlvAE3SHxcWgORV7c52cnKk4e/SQGvejo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKgru36RvhkuLTckBboIaM/PWWcDk3SPxXrCEhSURBxU14jIyKd/B4Bqjg1opER/pe/eBW1J30jxyXww9rjwL+o30MAFgKS+GLgkaOa1PchyqpdrlhIWxELq1pGGWs4IptzulneMFDl230+pmbGnLYvSoFkQy9XUMjcowpP4i7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChJ0lHdV; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChJ0lHdV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b966dd74so9125895e9.3
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 23:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786343519; cv=none;
        d=google.com; s=arc-20260327;
        b=h5PAKbxAPR4c8/eZ8kN3zx42dkuN5dr8/yfuhwBFU7xLUExvhN0J1A5OgUZy+K0VeG
         AavdQJ/GCDu1sPI9AEyGoZblaZSXjPR1PVyaAfZzVaCkNnCRem4V7vXm4XAV3onlNM94
         2oe4i1oK2RrlkALMzEiCvNvCXqfonsQAuts586m+VpAnSUrz2KaDEaS9YPqMTu4F4eO7
         aNED6RxkGYzWL1h0pAVQo1w1nx996zoHRQ15z4n+GMxEqKkV+gu4n2IeIEi4nqFKNhlq
         6wix1SLW8nOubG42qVUIYbAg54m9S+B+rqNBM9cnMlnq/8m0nIDtzipsaS20y/+db49N
         tUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3SjLv82lPKci1T9o7jRU252gydE3KzV/t6uQyPNLwxs=;
        fh=lyV2stehCsv++DWgdkBNBjN4R3E553mBFo5sRfgm5MI=;
        b=UHQ/5IQLIvku7n6G7BuUQSKNNUXXMj913mW6NNWFobJEjwnUbKBYIWZTVdat3/rATb
         hgeXpa9QciJVacVemUKE0CDxMIVsiC+B46SOALi7F7SqtwE3BBMJLnDaVqFEdt3oZBqL
         QIMywI/9LILbOyARtGuj3BMCMrVER7bqNyjeMjPbfU5QgsCpRQ1uZ48CvIXzhwC2EzMY
         aVqKyfZHi4F4xpa0Mqre/OEObLxMl+yFzry8nSYAcKWNPY0EGJv5yyauwuHCS5rU8qHx
         wAn/Vx+laQkivgumnrChO80cC/nj4AyYmAxWsSPlFW73y3CecI5kjpUcuwoYqGJpUoxm
         LPCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786343519; x=1786948319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3SjLv82lPKci1T9o7jRU252gydE3KzV/t6uQyPNLwxs=;
        b=ChJ0lHdVZCMAgx+GeMzYotT+NmeFPeY4xMkfbo7YfSYtOGRfYr8Tr9NJD9SzPvdRXm
         tMUBV066w6UUxCp+CHSP/FpaqkGNdB3NBbo3H7rNoAvGw3x05CSymEAs9PEVUtZxtE+R
         1aNWHHg6Z7Fl2vIprhVjpN+7CzIjC+BgNhNZg8UP+xKxSg8DOmcxowzLXH9QWeX1j3mk
         f6xhQdkHrq18yTSnxyAE5jWlfMgiC49r9WLdAORAvKYm73heG/X8KbAVhc3x7OE0pVq4
         OH7EPdtrY/vb1nI3yFtM1e3hlidqyuNth1C9+2X+EtVo5uPcR8ZnX/eJbqKL7rvFOpHF
         NJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786343519; x=1786948319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SjLv82lPKci1T9o7jRU252gydE3KzV/t6uQyPNLwxs=;
        b=mS3QUvYO04es+CR9hdCQf1cmiDa6CG5+98pv15OvwWDUmPwhllqVMc9QDNPoXbRxIS
         o8yn5OgkVhGvI0E1ZqUrSHmcrxr0F07ngr4iEyKTCwF2D/ozelHAW0GXSDNtvxTZPgVl
         a9KvKixs3p5sciuHIAyoaatp/GtHps2vFihg6rh/LbuqYz92HTs9xy26e/2/+Pm6QRJm
         FALIgTow1rvbuUWi0eTr6azkIl+BDfH2FpV8DLurYtglNvUL4y8Z1oDeWxq9oNch78iG
         SmO9YI99s4KzFeTzC3jSf7RNJY/AKEicuLoHtg6q/W/nRpMYHkBv9FvSRsncl8rjiPbI
         PPFQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHkGIuZv9q1L+iPbk68ZcH1PRaqRxibvbhScvpSKb7F2R91pzEH1v9T/fCuV4VJQUa+zf+MqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoi+oMZ/ADa1js6yla3z03aFH89nkMuPt88a0AD0LGwiowvVLV
	KDYmKahoZzEdyRNZw1dxd3pask5SteJTzUwjuXjuvIKOOsHThbZ0gMYuDOfkGQgNQzDHgcJNnfl
	bGlVByW6DiJYCpi6XlEskyYGrUVRlcOU=
X-Gm-Gg: AR+sD11i52nIX6fRZEbFAxRz95P9MBL/sG6R4SdKuRjBxUxFrdeBnLtI7J1t5gf1/cN
	ffxlkIM4a7a+9kVCErxeleJnIyurl+e1SSXz7hNK2hgT/ijB4uAoM7BShvZLXg9r3FbwuxXLxgC
	g4XHifyJ8oDDdVuhLUhoBjFcBYqmmP4ZxonsabblstUlNXxortJ0oSchwJcB43IRMS25hLCvfEK
	Q0RsOdhzFO6TlPBY6TdLRfwWA2xpdefiN+DPlMd9iUWpCKvieIrafsDrC17BwoTvfR5dWfTXDfw
	TDONmXiq1xYDslqh8gf7EsfArn+cf7gzgj9qTWixoB+mIVLvFKdc+t716L8COxGXR0thhYRaiqx
	mTql+xW6NOdVNfVYd3HBReCCxGq4xbvzQZmJjTVHZFIcHTBlRg2qX/1NxLF6RjtZbUnhC0ECaVn
	8=
X-Received: by 2002:a05:600c:a20b:b0:495:737a:7afe with SMTP id
 5b1f17b1804b1-4994e7d5b82mr387146075e9.15.1786343518782; Sun, 09 Aug 2026
 23:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260727095843.116950-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <d1a5c1c4-4a9f-4dc7-b709-4f89a25ad4c9@tuxon.dev>
In-Reply-To: <d1a5c1c4-4a9f-4dc7-b709-4f89a25ad4c9@tuxon.dev>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 10 Aug 2026 07:31:32 +0100
X-Gm-Features: AUfX_mynmOOcMxUkeHfpvOzO_beN0LAWdFmV1ZYmmpijFA_DJ37tQAh5BAIv5NA
Message-ID: <CA+V-a8ujEokYydnADu3uxLxb0StKpB3sjsKPZqv=m4YF6Za6pA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: rzg3s: Fix IRQ domain initialization error handling
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thank you for the review.

On Fri, Jul 31, 2026 at 5:02=E2=80=AFPM Claudiu Beznea <claudiu.beznea@tuxo=
n.dev> wrote:
>
> Hi, Prabhakar,
>
> On 7/27/26 12:58, Prabhakar wrote:
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
> > v1->v2:
> > - Restricted the code to max 80 columns.
> > - Moved calling irq_domain_remove() under err_cleanup_intx label.
> > ---
> >   drivers/pci/controller/pcie-rzg3s-host.c | 49 +++++++++++++++++------=
-
> >   1 file changed, 36 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/con=
troller/pcie-rzg3s-host.c
> > index f51b5d7c1998..70f1faf7e422 100644
> > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > @@ -1006,22 +1006,35 @@ static const struct irq_domain_ops rzg3s_pcie_i=
ntx_domain_ops =3D {
> >       .xlate =3D irq_domain_xlate_onetwocell,
> >   };
> >
> > +static void rzg3s_pcie_clear_intx_handlers(struct rzg3s_pcie_host *hos=
t,
> > +                                        int count)
> > +{
> > +     while (--count >=3D 0) {
> > +             irq_set_chained_handler_and_data(host->intx_irqs[count], =
NULL,
> > +                                              NULL);
> > +     }
> > +}
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
> > +                     dev_err_probe(dev, ret,
> > +                                   "Failed to parse and map INT%c IRQ\=
n",
> > +                                   'A' + i);
> > +                     goto err_cleanup_intx;
> > +             }
> >
> >               host->intx_irqs[i] =3D irq;
> >               irq_set_chained_handler_and_data(irq,
> > @@ -1033,21 +1046,29 @@ static int rzg3s_pcie_init_irqdomain(struct rzg=
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
> > +             dev_err_probe(dev, ret,
> > +                           "Failed to add irq domain for INTx IRQs\n")=
;
> > +             goto err_cleanup_intx;
> > +     }
> >       irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
> >
> >       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > -             int ret =3D rzg3s_pcie_init_msi(host);
> > +             ret =3D rzg3s_pcie_init_msi(host);
> >
> > -             if (ret) {
> > -                     irq_domain_remove(host->intx_domain);
> > -                     return ret;
> > -             }
> > +             if (ret)
> > +                     goto err_cleanup_intx;
> >       }
> >
> >       return 0;
> > +
> > +err_cleanup_intx:
> > +     if (host->intx_domain)
> > +             irq_domain_remove(host->intx_domain);
> > +     rzg3s_pcie_clear_intx_handlers(host, i);
>
> If you have it like this it worth squashing these lines in the same funct=
ion, e.g.:
>
>         rzg3s_pcie_teardown_intx(host, i);
>
> defined something like:
Ok.

>
> void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int count)
> {
>         if (host->intx_domain)
>                 irq_domain_remove(host->intx_domain);
>
This needs to be done after the handler has been set to NULL as the
handler does use intx_domain (pointed by Sashiko).

>
>         while (--count >=3D 0) {
>                 irq_set_chained_handler_and_data(host->intx_irqs[count], =
NULL,
>                                                  NULL);
>         }
> }
>
> > +
> > +     return ret;
> >   }
> >
> >   static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *hos=
t)
> > @@ -1055,6 +1076,8 @@ static void rzg3s_pcie_teardown_irqdomain(struct =
rzg3s_pcie_host *host)
> >       if (IS_ENABLED(CONFIG_PCI_MSI))
> >               rzg3s_pcie_teardown_msi(host);
> >
> > +     rzg3s_pcie_clear_intx_handlers(host, PCI_NUM_INTX);
> > +
> >       irq_domain_remove(host->intx_domain);
>
> And use the same function here, replacing:
>
> -       rzg3s_pcie_clear_intx_handlers(host, PCI_NUM_INTX);
> -
> -       irq_domain_remove(host->intx_domain);
> +       rzg3s_pcie_teardown_intx(host, PCI_NUM_INTX);
>
> Btw, the order b/w rzg3s_pcie_clear_intx_heandlers() and irq_domain_remov=
e() was
> revered here compared with the order from rzg3s_pcie_init_irqdomain().
I will do the below:

static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host,
                     int count)
{
    while (--count >=3D 0) {
        irq_set_chained_handler_and_data(host->intx_irqs[count], NULL,
                         NULL);
    }

    if (host->intx_domain)
        irq_domain_remove(host->intx_domain);
}

Cheers,
Prabhakar
