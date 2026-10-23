Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792792313;
	b=Q4ukhtFE+Dbn1z2JJ+hF92mICHc/OaaMEJnLUZgI/BUYBOC4S4Khhku7Nq0k6h3zoZsM
	 TKZM9wyVFp2VCNSE5eDRV8cNqOgHXE903q+UYURaoPFdH+P6OJ0+sKU8w9wKevT1nGxx8
	 xUF6IYIOJLZhDpwYPAaHSfoLwCAcD4qcz0XAOoBbpdiFcQ73EiJRST9Ued2DTxsT8Rhto
	 Wm7HTK1812Rc/sPOv3yW4liQ2FqarL9rhM8d4wysRl1Egbi+C0y+hcOYbCDFhaqNz7uIo
	 6KpG1rLojoR2wEUba9lvKLCafA6RPPcygCA1xIJNR7Z+MC1MDRSWgKG0dhX53lkVLUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JuEDAlBfDkuEmzQLzrlpohYSiGbH5rN6NLilorq2NMg=;
	b=jvScw7XHAhjokz09N1d8sPp09E+LYKEX83cPK1x5p8nUARlmA/tIHiuONWOypemi3Rfm
	 FYa5kzg6nMjE1R10S5YJO3FBVtXhqyEOJl8kDsbf2EucGTHqHHFmjaozBqoYsw0Vcp5Sb
	 I5m+UGIktpYaJB7xAKbQzKYFZsttfFnZS637h2FhDxlOjkDYYh6INPDvg5RWzBcIQuS7p
	 +T3lkbDAB1+SLi9aiw+/PUzrlF9BljnGZXya8GfpoBCz4JdKof15wqkpRcuRGRDw6nM3q
	 rKr8nC4LXthFwRSCnKhFG+9E+us1QcG4Fj6EmNfesO0WQW165B2FljjKhW6vsYFlVOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="GLSQqz/J";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5A606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 21:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D5A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GLSQqz/J
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-99075306daaso774126241.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 14:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792792312; cv=none;
        d=google.com; s=arc-20260327;
        b=LgvtzmYWweLdlgvhL2ywSWiDrna3pj4/7FTMw7+G3+mpqY7SlMmBCHh7T5dxyVKlm/
         cFdOFBcIUH5+6E8AX3SKK+3G1TzItNhiTbOWrJicZ/enTcnfjuBO7mne/0jQ3o96wxL0
         zB597VUGDrMvh2fXBveo5JfYcxiPsZ2WibN8xTCpNh3KRO9edp4B8HoDv3TR82t3IKeT
         dG+KA5/9JCzQ0vhJFLBPdWsjNAcYBNt0Pj2Pnyt/2/cBgHyhjNxit1Bs5ZZRBku+3xs8
         i1gTfejNqcbV1KExY4TrFZczctkT3tYKrrUO+M+EmUkGHji4M2gXcAwP381bVlAd2zA2
         KCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JuEDAlBfDkuEmzQLzrlpohYSiGbH5rN6NLilorq2NMg=;
        fh=RE5VIlLzF28YzVB9exZmOi8FLQSeev7LHTFZ7Pk8egU=;
        b=kCM5bYCdOJPAQqvTs0Y8FigCEO95nnH1JKirvl3wwbbWL1ybEAmNAmNEkJUAJmKR1P
         pV3hWcfhyzNrqCUkEyDtDB6YKJQy9Nj9a1yX/67NeOYT67HAS+/5ySOQXg+5noH9JM/C
         j4MWRdF5cK47vhRV7oNPEm4Qf9FMNOAUAnSwxplG4NLOiY6Z2rdqz/u77kEHKujt4SkR
         MlChamu6EScMqXEjngAJlWJ2po0mw72xX7/fSN86ZYCWATUU3RavXu08eVuHNNklpgik
         RY6UylgoTDRHchT7c5t5sM8YN4PSUcVyM25+Wy/IQ+gptlFW5NLizhISiHoO9GP8OCx7
         jJnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792792312; x=1793397112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JuEDAlBfDkuEmzQLzrlpohYSiGbH5rN6NLilorq2NMg=;
        b=GLSQqz/JrlghA/jwWUOMfFYBpEHVjsqospkQWEe4TZf1j3R0qKRMUiE+6wWJYtiOVe
         FA1FqyjxO1YsBZZLktjtMSRgbg5e+P9Qt6pKyhmAzf03C58gYcVfI5r3GQnW5LYlOhHB
         ENk5pxvlFQeWKSO4z08g2agCf/8rhXNK+hxh33WE1QvCPefi3Cx7Jo4njpOw06aYIKkM
         kQMaQw6exa7LQzNN8TIlJrHAMVAmOcEaNnQnqQHbLbGfdAzG3mSlVbd2I284j4AIlp1O
         oDxS7SwECIx/7UXulbH7Hfw8Qp8sVk9eeGka3gTt2g2XG5ceQTlHJn3EW2F0S4lsHj7x
         g/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792792312; x=1793397112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JuEDAlBfDkuEmzQLzrlpohYSiGbH5rN6NLilorq2NMg=;
        b=ESG3OKoB4vx7tmZSTEmpCUlWJHrI+wH1pPXOVb/UgGc1kjacH6FC/sVtEnsrWpsZ5P
         5z05G2zXchF2AefLVuaMM/se49VVgmqhwV/C7d6ritIfzA0bE55kUsjLkS7AkLOujwH0
         cwO/RTD1rfxfsIF4rFxX/ez44M8b69vO+7xpOTYd2nhTUqTwCYGFSmlwgaqIsT1YKryD
         AHRnL0AKsp+EI71ioffJmYrdyVj+fmI5NoVq/XumuhXFu0hxXs3hLheXv9WHxQGPdyHA
         D0MoF5Hj2nVg4aDG/rhhBFhS1htYUO2r6e/xI0Vfzaum11BwDqePQjqrVcvWMhjX5gm/
         5qqw==
X-Forwarded-Encrypted: i=1; AKwUvBx6nysfqpmtiB1Cmd0gm3+/nyeDhSglWSaz3xxaPRRqC57LgKY9lXns7tOzaI6I/crUuAlbyJs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjHBQ5NULODfK9OiX7Dzdwa73UtZHZKW9Cxy+8MEQzKL85acqP
	cnV0UJziIRuAMYEkU2W1RuRaqVzM6kXWa4Q4hQJBACenRMsd5MW4RHV2aaHkDthiVU8BnU2wAQB
	TCpzrKjzKBIUhR+mGT3+Zuta0xKaZtTk=
X-Gm-Gg: AYBFou20I5GyexLZiJ7W7n98S4b1grVXs7JSHtTITzgoXPoMWXO2B3SKJZg9YxCmFp0
	o0G0YrGq3098DvLLYrX00XYH6gCox91HEpg5m/i1erPb1/Xi6+yRWV61CDUw2KLlmmrm8KBXQzE
	pwuZVh8aidtUSftsQX/urW+S1ggOxYsRQ0vVRbcuAeT7Owvr8zgsTc2wvf6wecPSpRM7nmr9pS9
	vScRK68Q7JxNY3Mz7pLIIrvTY5PaShN35Llwh3nKp6v8tV/krse7ZdWnxjOT1AjZlh35mm1SWz4
	6fHnvhXPCSAKsAHJdhKeiw8ee6tSTpbBNIeu4ogojZUdWMK0lHHTYKrbp/5vBQj375QV5aq+b9Q
	pDAdCnUmCrJhxMuRDuyOHVV5fao/6EqbT8BZXNptwnfMZePAZeig5mjJW9ifnFjuhTlrQ1NNj8X
	r/YVctQszYrNkXlKkjTaNVdMvvWVZ7CTd488JIGzRRRS7gv/VSFF1SWfh2Ji6GGONoVEiZlpnSx
	C9Q2N7nUz8w9Oj+XA4I3aU1sBwjuA==
X-Received: by 2002:a05:6102:6a92:b0:7cc:115:ddf1 with SMTP id
 ada2fe7eead31-7ce5cdd0044mr196399137.23.1792792312161; Fri, 23 Oct 2026
 14:51:52 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
 <20261023-submit-dw-dma-synchronize-v1-v3-1-c62bf048f5ce@gmail.com> <atvTOT0SApG_tNZO@SMW015318>
In-Reply-To: <atvTOT0SApG_tNZO@SMW015318>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 15:51:41 -0600
X-Gm-Features: AclHuK8Tyt_Umqnr9Mqazfm-yRc5xsW9OpmaY0sK302TzZx5ie9RAXwyacee-yg
Message-ID: <CADvTj4r_p=e2nxeXR5UVyCLwnPR9KgbqQVFke+cwNVNQY=Hk3Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dmaengine: dw: Fix XFER bit set, but channel not
 idle error
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Maciej Sosnowski <maciej.sosnowski@intel.com>, Dan Williams <djbw@kernel.org>, 
	Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 3:36=E2=80=AFPM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> On Fri, Oct 23, 2026 at 10:27:22AM -0600, James Hilliard wrote:
> > From: Serge Semin <fancer.lancer@gmail.com>
> >
> > If a client driver gets to use the DW DMAC engine device tougher
> > than usual, with occasional DMA-transfers termination and restart, then
> > the next error can be randomly spotted in the system log:
> >
> > > dma dma0chan0: BUG: XFER bit set, but channel not idle!
> >
> > For instance that happens in case of the 8250 UART port driver handling
> > the looped back high-speed traffic (in my case > 1.5Mbaud) by means of =
the
> > DMA-engine interface.
> >
> > The error happens due to the two-staged nature of the DW DMAC IRQs
> > handling procedure and due to the critical section break in the meantim=
e.
> > In particular in case if the DMA-transfer is terminated and restarted:
> > 1. after the IRQ-handler submitted the tasklet but before the tasklet
> >    started handling the DMA-descriptors in dwc_scan_descriptors();
> > 2. after the XFER completion flag was detected in the
> >    dwc_scan_descriptors() method, but before the dwc_complete_all() met=
hod
> >    is called
> > the error denoted above is printed due to the overlap of the last trans=
fer
> > completion and the new transfer execution stages.
> >
> > Clear the channel interrupt status when stopping it, and keep the XFER
> > check, descriptor detachment and queued-transfer restart in one locked
> > section. An empty active list needs no completion processing.
> >
> > When the locked XFER recheck finds no event, only update residue. A sta=
le
> > tasklet snapshot may belong to a terminated transfer, and a zero residu=
e
> > only means the source has been read, not that destination writes have
> > finished. Requiring RAW.XFER also prevents the fallback scan from freei=
ng
> > a descriptor still linked on active_list.
> >
> > Fixes: 69cea5a00d31 ("dmaengine/dw_dmac: Replace spin_lock* with irqsav=
e variants and enable submission from callback")
> > Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA=
 controller")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > [james: require a locked XFER event and handle an empty active list]
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  drivers/dma/dw/core.c | 70 ++++++++++++++++++++-----------------------=
--------
> >  1 file changed, 27 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> > index dd75f97a33b3..07a5f5105787 100644
> > --- a/drivers/dma/dw/core.c
> > +++ b/drivers/dma/dw/core.c
> > @@ -141,6 +141,12 @@ static inline void dwc_chan_disable(struct dw_dma =
*dw, struct dw_dma_chan *dwc)
> >       channel_clear_bit(dw, CH_EN, dwc->mask);
> >       while (dma_readl(dw, CH_EN) & dwc->mask)
> >               cpu_relax();
> > +
> > +     dma_writel(dw, CLEAR.XFER, dwc->mask);
> > +     dma_writel(dw, CLEAR.BLOCK, dwc->mask);
> > +     dma_writel(dw, CLEAR.SRC_TRAN, dwc->mask);
> > +     dma_writel(dw, CLEAR.DST_TRAN, dwc->mask);
> > +     dma_writel(dw, CLEAR.ERROR, dwc->mask);
> >  }
> >
> >  /*--------------------------------------------------------------------=
--*/
> > @@ -257,34 +263,6 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, s=
truct dw_desc *desc,
> >       dmaengine_desc_callback_invoke(&cb, NULL);
> >  }
> >
> > -static void dwc_complete_all(struct dw_dma *dw, struct dw_dma_chan *dw=
c)
> > -{
> > -     struct dw_desc *desc, *_desc;
> > -     LIST_HEAD(list);
> > -     unsigned long flags;
> > -
> > -     spin_lock_irqsave(&dwc->lock, flags);
> > -     if (dma_readl(dw, CH_EN) & dwc->mask) {
> > -             dev_err(chan2dev(&dwc->chan),
> > -                     "BUG: XFER bit set, but channel not idle!\n");
> > -
> > -             /* Try to continue after resetting the channel... */
> > -             dwc_chan_disable(dw, dwc);
> > -     }
> > -
> > -     /*
> > -      * Submit queued descriptors ASAP, i.e. before we go through
> > -      * the completed ones.
> > -      */
> > -     list_splice_init(&dwc->active_list, &list);
> > -     dwc_dostart_first_queued(dwc);
> > -
> > -     spin_unlock_irqrestore(&dwc->lock, flags);
> > -
> > -     list_for_each_entry_safe(desc, _desc, &list, desc_node)
> > -             dwc_descriptor_complete(dwc, desc, true);
> > -}
> > -
> >  /* Returns how many bytes were already received from source */
> >  static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
> >  {
> > @@ -302,6 +280,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw,=
 struct dw_dma_chan *dwc)
> >       struct dw_desc *child;
> >       u32 status_xfer;
> >       unsigned long flags;
> > +     LIST_HEAD(list);
> >
> >       spin_lock_irqsave(&dwc->lock, flags);
> >       llp =3D channel_readl(dwc, LLP);
> > @@ -310,6 +289,10 @@ static void dwc_scan_descriptors(struct dw_dma *dw=
, struct dw_dma_chan *dwc)
> >       if (status_xfer & dwc->mask) {
> >               /* Everything we've submitted is done */
> >               dma_writel(dw, CLEAR.XFER, dwc->mask);
> > +             if (list_empty(&dwc->active_list)) {
> > +                     spin_unlock_irqrestore(&dwc->lock, flags);
> > +                     return;
> > +             }
> >
> >               if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
> >                       struct list_head *head, *active =3D dwc->tx_node_=
active;
> > @@ -341,9 +324,23 @@ static void dwc_scan_descriptors(struct dw_dma *dw=
, struct dw_dma_chan *dwc)
> >                       clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
> >               }
> >
> > +             if (dma_readl(dw, CH_EN) & dwc->mask) {
> > +                     dev_err(chan2dev(&dwc->chan),
> > +                             "BUG: XFER bit set, but channel not idle!=
\n");
> > +
> > +                     /* Try to continue after resetting the channel...=
 */
> > +                     dwc_chan_disable(dw, dwc);
> > +             }
> > +
> > +             /* Detach the completed transfer before starting queued w=
ork. */
> > +             list_splice_init(&dwc->active_list, &list);
> > +             dwc_dostart_first_queued(dwc);
> >               spin_unlock_irqrestore(&dwc->lock, flags);
> >
> > -             dwc_complete_all(dw, dwc);
> > +             list_for_each_entry_safe(desc, _desc, &list, desc_node) {
> > +                     list_del_init(&desc->desc_node);
> > +                     dwc_descriptor_complete(dwc, desc, true);
> > +             }
>
> what's purpose move dwc_descriptor_complete() implement into here?

To keep the XFER check and descriptor detachment under the same lock.
Previously, the scanner dropped the lock before dwc_complete_all()
reacquired it, allowing termination/restart to replace the active transfer
in between. The old completion event could then complete the new transfer.
Callbacks still run after unlocking.

>
> Frank
>
> >               return;
> >       }
> >
> > @@ -389,22 +386,9 @@ static void dwc_scan_descriptors(struct dw_dma *dw=
, struct dw_dma_chan *dwc)
> >                       desc->residue -=3D child->len;
> >               }
> >
> > -             /*
> > -              * No descriptors so far seem to be in progress, i.e.
> > -              * this one must be done.
> > -              */
> > -             spin_unlock_irqrestore(&dwc->lock, flags);
> > -             dwc_descriptor_complete(dwc, desc, true);
> > -             spin_lock_irqsave(&dwc->lock, flags);
> >       }
> >
> > -     dev_err(chan2dev(&dwc->chan),
> > -             "BUG: All descriptors done, but channel not idle!\n");
> > -
> > -     /* Try to continue after resetting the channel... */
> > -     dwc_chan_disable(dw, dwc);
> > -
> > -     dwc_dostart_first_queued(dwc);
> > +     /* Residue describes source reads; only RAW.XFER completes a tran=
sfer. */
> >       spin_unlock_irqrestore(&dwc->lock, flags);
> >  }
> >
> >
> > --
> > 2.53.0
> >
