Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795108094;
	b=YQkZ0DldrQEX6YXgnyFBzLg3LfFMtp59SPOnGcAGu4aevyGn69xGRhTGueO4Gwde2yrk
	 J+RGLMmxnuIXZX3RQLyXhmXnSunBQPd810xTsY0fHc/qc1kYz56YOkHSqZugnS8lHBtzi
	 9aw6Gfefk6WQkh/+mTQ1KyfEAzQDoA6DE50HIK2oWDjgJKuo4/A/MgqvpW2MaL/EPiBo0
	 fry98Y581t02vawkdhYk0kbb1rijZvc0dndjVmYGrRlztXNcMcoTd/wPMfSJZ52jr9ES7
	 xBXB+ZjTOxybDh4XDy8PGKksoaONEYLZW1DfIBbDWp/lOFdahE3zrbQpIa/coCbLJNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5+9Af2auHdiAbr4leGPmH+sT3gFAEFvlw0HHsc15WGc=;
	b=TdDyRKLRLFsNk4FVqglkASxC9JNNENaImTKNyXcYHq6NqB0E9g3digBPaVYiChATn/Gs
	 1NQ2qDqBt+f654PfH++mOzsYP60jBzZTCIpQ34taHqMq6uYuOY8bVZNYh2DiOo97wF+I/
	 bUUKeonIpH+hEC2NiGdCQRVw2F+tWgGn7S1R9X+ZwXNr/NfFRASe9YVe/wBwuoWwjlU3c
	 /lziKuT8Q525khToS+QN1pxjN2NDqCtXrfsrsQ10Rqmv1qSyLLVf1CNKDB0Wcn9oKhiyY
	 /Wng9REP/8BAv/D3nQMIU7wgLuAcvxj/WOKtc5jOi8ErajKVT4n2x2hmer/PWVqeBfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=djsZe68E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1160A260F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABB1160A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=djsZe68E
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso3287306a12.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:08:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795108092; cv=none;
        d=google.com; s=arc-20260327;
        b=BrsKuiIyBPHtO6M3Mzj7Kp06Fkm6ovr6Viq2bKxeqIuxRvdX+JFlXbGuQoHH1p56B+
         ru9zAaGxvFH1ujc4vQ8GkryBd0ohizrI3c22IHjTz4EGzqBDekZD+nZtCgiP2bNBZYOL
         +SyVd7GGp5DEDyUIt2p66dtKRiTnYh1JzHaCdM/9aVkI6vYA4KfPgrq1PCdXZUhlA1nQ
         J4O9zbKz3zmr2noop/Ouc7zQltV6G0v6UTWnqzEFuv4HHSAbDbkCPS8mL3gdUAPvtSEI
         BDJxVAMJ4cH3NQ43J+/6EnESNJbFPh/JWHQ2eEa/lPt8s5ZMtrq2Ci2xi/vdBfj4YJBt
         +W3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5+9Af2auHdiAbr4leGPmH+sT3gFAEFvlw0HHsc15WGc=;
        fh=rU8p1K4Q1AUVWDRvlDKpbOOvgLvZg2Ahg8mHysYML3A=;
        b=mKXh5ZmhbUvd9aVKZ3pbUJWeMBhbDtz6MBE1nVwYGQXfVYrLbYmCuf+CM0hqczkAxE
         cl8CREhlenwHgY8JmlHPst14KWevUvVkS8nEhPfSwCBHREpQ0V4ai+uLe/84+5mGf++6
         OncgB+eiRYUD5ZCRId9Es0fXGkB3jnP7nceaRDCQM3qZD0jdVoYVxLgzuFy9wJz96CU5
         yeGNhYOtnbxo+cttnHm4ROQtVv4KiBklV9cNBxDmOyG1G6I4dnDe1/DAyY7d7Dt/CrmP
         1RDz6lLvrGzbnoVayx0+8TlAGkf+t5/0XPlb3SLLQYoRsexw5WfAMD3IUDcOXuinOroE
         RcsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108092; x=1795712892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5+9Af2auHdiAbr4leGPmH+sT3gFAEFvlw0HHsc15WGc=;
        b=djsZe68EQnlDuap90ac+sKyt4pfBgdQLtIjpGnLTNQdMCJgqVSMQ75FPlPJf5mLjTk
         0NyL87FbwwpzA4CkRPSv/XPpBjrAsIYuDaedSz1mnoafDW64hmeVrAny7ZJ25MIGVP9i
         /yejFUz5kfSZ1I+FJBKnvcXWHRZD2iHQnTSbfqMcBed/I639kb7eRD29wFtUZUhChQ2Z
         F7VyILdTp9pu0OXGJ7biHdUqG6uk6tiAV8EcH5u8xG38U8EhmL52DbN5w/6Di6waUfvd
         KdZAkd1LVwvfUFy+MxVgqgMjV78QXs6pB6TDiTGWVsHJcCwN+MqwUiIWHN9vtsnytVmh
         KtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108092; x=1795712892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+9Af2auHdiAbr4leGPmH+sT3gFAEFvlw0HHsc15WGc=;
        b=JAKGwe4Wi2neG31GvWqXcwlQEoKM7BmmisJC0g43tVjtgaDLX9oPK5rVfdMHoDJHpO
         qraVIZh/B2pDIZAsWFsOu34QcrRrw+LW8IC2mWbXoBdEWSE0GY6XGOsSQlldhbSG3qd7
         dOcbZaQvZRjrSpuGvViFd3SXvC4nF/+0+d/PRcp8FiUKPDhfYMrNevsllZWFaIUMp+9e
         Uv+zxIq5hPMPeoZRU9KYLeOBhukfQQDaXJVjdul1UbY14zHnXBfwxzqYVC9SKgnjFlX0
         lT7Xl0qjMT4PagKl4AfMrmLqZkrEyN0nALrh2hPvxr/g7N1CycMBVYAh8hnyqx6ueSq1
         bfuw==
X-Forwarded-Encrypted: i=1; AL+hErHj/7lGqhIjb1FNI0v5bwfuwVhlWPRLxlHmr5Ei2/xjX2/uZWHRj/1MJJg1GYYO42HZy6cZmzc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ifF0Ii7kt5jDA/ZR0NYhLHkNjrfl+rGPy4Yoxt+sJDLAkMR44
	bdcbDIK4wZZJZqRIdI+p2yJEUU31KoCVrpjndLdbrVkq+rtk+FsDfv/LeqOCYtdJpWuV4qRmcow
	r0bkqOsSfYwqa+kUgd9LPj9yNJ5+TLY4=
X-Gm-Gg: AYBFou3xpZWPNhEKZQBYrMh6bFGLg9x6iadvx21n0pYkzoLGvD1u3hHKwIW2dtUGfQa
	Ljccy5sAMJdLZtuLD8EbDLRfil5TDMvHmJyqD02iNzpGYuWNlMEBg7SbvH1nI38SwJPlj585eMN
	MKyuH/SOemRPjBdi41rOAGy11QBQ6nk8toCJFIcEN/8VepHrIc/ktxTKr+ZVl4ILUkPKV5N2s7t
	lUuuLpmALatvtLcf0AcJjMss3v0Qofwe0B0gtU95HUbxLlGqeQA8btOBUJRoMjKY0nOR+Xr3NVZ
	ZVNEFoPuRXa2NU+TDKzSu2ve1NMD+xgyjteXA107K8BJAA98S6Axl/cN7LZS4LfjFyLw14KRglK
	VGDXtvf1vBiQFtScACnDFEKad6sxNuXF8CQe2fLLnePU4cd/4abP9WL/8fAUCmzMiI6warPPB8p
	YFvx2azrk/724AvCfZ+b1p+vg0jhhuLK2R5NwnCttjOPzA9aK6aHBniUDde0yYjDqsJRfBGjacJ
	/Blqh0QyQAFTirTyqmvZXgXa/onnX0RbGYy830ihM5x1vIdZYM=
X-Received: by 2002:a05:6402:5cd:b0:6b8:7769:fffc with SMTP id
 4fb4d7f45d1cf-6b887eb2136mr5368008a12.15.1795108092010; Thu, 19 Nov 2026
 09:08:12 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
 <20261119-submit-dw-axi-dma-stop-pause-v1-v8-5-f8e7fe60594c@gmail.com> <av8jamIp8oT_M_eU@SMW015318>
In-Reply-To: <av8jamIp8oT_M_eU@SMW015318>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 10:07:58 -0700
X-Gm-Features: AclHuK9A144CvlmfACCQifWSoNELDRDyoYtLquyalg4FrmtKj7AedmTpR5B7M_8
Message-ID: <CADvTj4pPHr6-30iHU3VQnQvc_hfcGxjY6aeS4Sx7fBEOc6QowA@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] dmaengine: dw-axi-dmac: preserve pending pause requests
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Sergey Khimich <serghox@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sia Jee Heng <jee.heng.sia@intel.com>, 
	Baruch Siach <baruch@tkos.co.il>, Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:27=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> On Thu, Nov 19, 2026 at 09:01:00AM -0700, James Hilliard wrote:
> > dma_chan_pause() clears SUSPENDED even when polling times out. Hardware
> > can set that status after the last poll, and the unconditional clear th=
en
> > discards an acknowledgment the caller never observed. Another channel's
> > interrupt can also consume the status because the shared IRQ handler
> > clears every channel's status before taking its lock.
> >
> > Leave SUSPENDED to the pause and resume paths. Track the suspend reques=
t
> > separately from its acknowledgment so a timeout can be followed by eith=
er
> > a pause retry or a resume. Wait for acknowledgment before clearing the
> > hardware request, since hardware ignores an earlier clear. If that wait
> > also times out, return -EAGAIN with the request still pending.
> >
> > A completed transfer is also quiescent, but its completion handler may
> > still need to advance a cyclic descriptor. Defer that restart while a
> > pause is pending, and resume it without reprogramming the first LLI.
> > Track the active descriptor until its completion handler runs so that
> > resume and issue_pending cannot restart a completed cyclic segment or
> > reissue a completed noncyclic descriptor while its IRQ is pending.
> > Start queued work after the active descriptor is retired, respecting th=
e
> > pause request.
> >
> > Clear stale suspension status at the start of a new descriptor rather
> > than at each cyclic restart. Reset the software state after successful
> > termination and when allocating a channel for a new client.
> >
> > Store the lock-protected pause flags as bitfields in existing padding.
> >
> > Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 99 ++++++++++++++++++=
++++----
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  8 ++-
> >  2 files changed, 91 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/d=
ma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index 8c115d20728b..99b648d4ca76 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -482,6 +482,8 @@ static void axi_chan_block_xfer_start(struct axi_dm=
a_chan *chan,
> >       irq_mask |=3D DWAXIDMAC_IRQ_SUSPENDED;
> >       axi_chan_irq_set(chan, irq_mask);
> >
> > +     axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> > +     chan->desc =3D first;
> >       axi_chan_enable(chan);
> >  }
> >
> > @@ -490,6 +492,9 @@ static void axi_chan_start_first_queued(struct axi_=
dma_chan *chan)
> >       struct axi_dma_desc *desc;
> >       struct virt_dma_desc *vd;
> >
> > +     if (chan->desc || chan->pause_requested)
> > +             return;
> > +
> >       vd =3D vchan_next_desc(&chan->vc);
> >       if (!vd)
> >               return;
> > @@ -544,6 +549,10 @@ static int dma_chan_alloc_chan_resources(struct dm=
a_chan *dchan)
> >               pm_runtime_put(chan->chip->dev);
> >               return -ENOMEM;
> >       }
> > +     chan->desc =3D NULL;
> > +     chan->pause_requested =3D false;
> > +     chan->is_paused =3D false;
> > +     chan->cyclic_restart =3D false;
> >       dev_vdbg(dmaengine_chan_dev(dchan), "%s: allocating\n", axi_chan_=
name(chan));
> >
> >       return 0;
> > @@ -1088,6 +1097,8 @@ static noinline void axi_chan_handle_err(struct a=
xi_dma_chan *chan, u32 status)
> >       vchan_cookie_complete(vd);
> >
> >       /* Try to restart the controller */
> > +     chan->desc =3D NULL;
> > +     chan->cyclic_restart =3D false;
> >       axi_chan_start_first_queued(chan);
> >
> >  out:
> > @@ -1135,11 +1146,18 @@ static void axi_chan_block_xfer_complete(struct=
 axi_dma_chan *chan)
> >                       }
> >               }
> >
> > -             axi_chan_enable(chan);
> > +             if (chan->pause_requested) {
> > +                     chan->is_paused =3D true;
> > +                     chan->cyclic_restart =3D true;
> > +             } else {
> > +                     axi_chan_enable(chan);
> > +             }
> >       } else {
> >               /* Remove the completed descriptor from issued list befor=
e completing */
> >               list_del(&vd->node);
> >               vchan_cookie_complete(vd);
> > +             chan->desc =3D NULL;
> > +             axi_chan_start_first_queued(chan);
> >       }
> >
> >  out:
> > @@ -1161,6 +1179,8 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, =
void *dev_id)
> >       for (i =3D 0; i < dw->hdata->nr_channels; i++) {
> >               chan =3D &dw->chan[i];
> >               status =3D axi_chan_irq_read(chan);
> > +             /* Leave suspension status for the pause and resume paths=
. */
> > +             status &=3D ~DWAXIDMAC_IRQ_SUSPENDED;
>
> If you don't clean DWAXIDMAC_IRQ_SUSPENDED, does it cause irq flood?

No. SUSPENDED is enabled in CH_INTSTATUS_ENA so the pause path can
poll it, but not in CH_INTSIGNAL_ENA. Leaving the status bit set
therefore doesn't assert the IRQ line.

That matters if the acknowledgment arrives just after a pause times
out. A retry can still observe it, even if a shared interrupt ran in
the meantime. The pause path clears the bit once it has seen it.

>
> Frank
> >               axi_chan_irq_clear(chan, status);
> >
> >               dev_vdbg(chip->dev, "%s %u IRQ status: 0x%08x\n",
> > @@ -1200,6 +1220,12 @@ static int dma_chan_terminate_all(struct dma_cha=
n *dchan)
> >                       dw_axi_dma_set_byte_halfword(chan, false);
> >
> >               vchan_get_all_descriptors(&chan->vc, &head);
> > +
> > +             axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> > +             chan->desc =3D NULL;
> > +             chan->pause_requested =3D false;
> > +             chan->is_paused =3D false;
> > +             chan->cyclic_restart =3D false;
> >       }
> >
> >       if (ret) {
> > @@ -1215,16 +1241,49 @@ static int dma_chan_terminate_all(struct dma_ch=
an *dchan)
> >       return 0;
> >  }
> >
> > +static bool axi_chan_is_suspended(struct axi_dma_chan *chan)
> > +{
> > +     if (axi_chan_is_hw_enable(chan))
> > +             return axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED;
> > +
> > +     /* A completed transfer cannot acknowledge a new suspend request.=
 */
> > +     axi_chan_disable(chan);
> > +     return true;
> > +}
> > +
> > +/* A timed-out request can still be acknowledged. */
> > +static int axi_chan_wait_for_suspend(struct axi_dma_chan *chan)
> > +     __must_hold(&chan->vc.lock)
> > +{
> > +     bool suspended;
> > +     int ret;
> > +
> > +     if (chan->is_paused)
> > +             return 0;
> > +
> > +     ret =3D read_poll_timeout_atomic(axi_chan_is_suspended, suspended=
, suspended,
> > +                                    2, 40, false, chan);
> > +     if (ret)
> > +             return -EAGAIN;
> > +
> > +     axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> > +     chan->is_paused =3D true;
> > +     return 0;
> > +}
> > +
> >  static int dma_chan_pause(struct dma_chan *dchan)
> >  {
> >       struct axi_dma_chan *chan =3D dchan_to_axi_dma_chan(dchan);
> >       unsigned long flags;
> > -     u32 status;
> >       int ret;
> >       u64 val;
> >
> >       spin_lock_irqsave(&chan->vc.lock, flags);
> >
> > +     chan->pause_requested =3D true;
> > +     if (chan->is_paused || !axi_chan_is_hw_enable(chan))
> > +             goto wait;
> > +
> >       if (chan->chip->dw->hdata->nr_channels >=3D DMAC_CHAN_16) {
> >               val =3D axi_dma_ioread64(chan->chip, DMAC_CHSUSPREG);
> >               if (chan->id >=3D DMAC_CHAN_16) {
> > @@ -1251,17 +1310,11 @@ static int dma_chan_pause(struct dma_chan *dcha=
n)
> >               }
> >       }
> >
> > -     ret =3D read_poll_timeout_atomic(axi_chan_irq_read, status,
> > -                                    status & DWAXIDMAC_IRQ_SUSPENDED,
> > -                                    2, 40, false, chan);
> > -
> > -     axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> > -
> > -     chan->is_paused =3D true;
> > -
> > +wait:
> > +     ret =3D axi_chan_wait_for_suspend(chan);
> >       spin_unlock_irqrestore(&chan->vc.lock, flags);
> >
> > -     return ret ? -EAGAIN : 0;
> > +     return ret;
> >  }
> >
> >  /* Called in chan locked context */
> > @@ -1295,6 +1348,8 @@ static inline void axi_chan_resume(struct axi_dma=
_chan *chan)
> >               }
> >       }
> >
> > +     axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> > +     chan->pause_requested =3D false;
> >       chan->is_paused =3D false;
> >  }
> >
> > @@ -1302,15 +1357,31 @@ static int dma_chan_resume(struct dma_chan *dch=
an)
> >  {
> >       struct axi_dma_chan *chan =3D dchan_to_axi_dma_chan(dchan);
> >       unsigned long flags;
> > +     int ret;
> >
> >       spin_lock_irqsave(&chan->vc.lock, flags);
> >
> > -     if (chan->is_paused)
> > -             axi_chan_resume(chan);
> > +     ret =3D 0;
> > +     if (!chan->pause_requested)
> > +             goto out;
> > +
> > +     /* Hardware ignores resume until the suspend request is acknowled=
ged. */
> > +     ret =3D axi_chan_wait_for_suspend(chan);
> > +     if (ret)
> > +             goto out;
> > +
> > +     axi_chan_resume(chan);
> > +     if (chan->cyclic_restart) {
> > +             chan->cyclic_restart =3D false;
> > +             axi_chan_enable(chan);
> > +     } else {
> > +             axi_chan_start_first_queued(chan);
> > +     }
> >
> > +out:
> >       spin_unlock_irqrestore(&chan->vc.lock, flags);
> >
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  static int axi_dma_suspend(struct axi_dma_chip *chip)
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi=
-dmac/dw-axi-dmac.h
> > index 3c86e5d468ea..b18c9880711a 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > @@ -42,6 +42,12 @@ struct axi_dma_chan {
> >       void __iomem                    *chan_regs;
> >       u8                              id;
> >       u8                              hw_handshake_num;
> > +
> > +     /* Protected by vc.lock. */
> > +     bool                            pause_requested:1;
> > +     bool                            is_paused:1;
> > +     bool                            cyclic_restart:1;
> > +
> >       atomic_t                        descs_allocated;
> >
> >       struct dma_pool                 *desc_pool;
> > @@ -50,8 +56,6 @@ struct axi_dma_chan {
> >       struct axi_dma_desc             *desc;
> >       struct dma_slave_config         config;
> >       enum dma_transfer_direction     direction;
> > -     /* these other elements are all protected by vc.lock */
> > -     bool                            is_paused;
> >  };
> >
> >  struct dw_axi_dma {
> >
> > --
> > 2.53.0
> >
