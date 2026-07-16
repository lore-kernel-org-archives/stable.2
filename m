Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB58446BE4
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225897; cv=pass; b=OvAES5Ibni4E+JRXFEf+2QjxYaNIPq2vjXSlKwULrxOtB3YAUth9BfE67xYWJsuMCeW4NT8yZt1kU3wmHUgiIpq/N+1bjkeFqZz/nqfetZruAFAZSiAY0xXUgAeVu4IQxEbNB6dbtScTSIaQX57wjbojG4mrr9A/NFEz7BZbxB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225897; c=relaxed/simple;
	bh=upO5nduqEjh1O333xP1lf7qLObT1k2t9G8uyP7OYULo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3K9XyvX2QGVP4vcFyJ3I/mc01vyqipYAF2OXmE3nKVDHlpVG+emBONyXjGTkZr0qc5AmPMyGywDxqZlaTuiGTg9nLkUyKaSG8UifUVly2G5XNAKDDk16XXiGIrNlyeeyihxjOydys92UFEfkzS8p+3RxHj3PQoB9o1zvDw4nSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cr0EHXLI; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr0EHXLI"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so208515e9.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784225893; cv=none;
        d=google.com; s=arc-20260327;
        b=sTDntAUJ/FuLUzM08WQ54QfVDUvoWoNTTkIXWnfzQBbHWgoa22ykiZ572aFfQddaTT
         5en8Df/Db7Nbn9S0HVrsp1dDKnsiRxLndbz7kropF0EVNl2j675g0FEXwE0LSe0sbIbe
         pYxOxv9wTsfOeQrvOn7Il6M+rnWoHQT8bpWQtOW8r8uxBwtOIvR17SEDZU9vDXSmpPMV
         olYYhSE13/TXZUlc5gyC4sm3JKkGLDn9E9t1wGpOyMUrYx3hESWqd/YoSVNZc68D3/Li
         YucYrj5njeUUh8mvoPCZT/AnwjfqLIeybM83Ks986N8WsKbY1zWoc7pH4CEx/n2U6hyA
         u3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FxN2/D2tlTtH/J7f3tJFTTV+44thI+Z+5mi2902UYhc=;
        fh=n1VXuv1YeFKOR0P1OR+vdHAd1CM1ZmKjxHV4Y62EcJg=;
        b=q2KNTIjj+cQHcfB2MDlNoRLI1st/6JfWSP7N3gqVtC7CogQdLx/Mb0U6nSyhF3QnDu
         na6o5eLpxZSdil4vRc1DUJgCJI9Bn17UcfswnDmT7rp2UR0nXfjvBPWSUFUb0/iDR6EX
         RZFExWypZ6GAVRHHy0KSlqDArD4AfZGEpbQHTwhKrc0KcWMouQbo8L0tkzrVBNQ7DLI6
         g2v8QQeRo+FFfS8KPnF8Tt2id501j4vk2g7bKGg9klBwRw8zHxlMraOszNCIGrsCBXSx
         yYrcfxq6K/KX++TMAt011okXqtji3oa7vW3EUKnPK9Te266jY+Og5gYVOmHiLxueubon
         pSCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784225893; x=1784830693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FxN2/D2tlTtH/J7f3tJFTTV+44thI+Z+5mi2902UYhc=;
        b=cr0EHXLI5ArwTURPS85LmkCxFe6M14wDM/o1Oyw1HwjVW2cqvJDGTB2OVOC4Z2Etb6
         FjcECqaBNZT8n8kUSNbgii+y1MuHoO73gQ5vLE6mgsxpajQMeCA68k5HkCaXwgCclDxM
         gaVN7xQo6FA1YOnPQoClN3KljVptvgUF2Dl7gbUzyS6LzfLg35MH275ovRBU+x+m2pXo
         gnDXD6/soXFew9TSyds5TYskHDUGEuFfOKkm0gZCPJ/TVwuv2XOZ2Y3KZEdgiWwpDXon
         0dCvKJ6HAYyQe3jQUZPkUCKTGLTjCYsu1DeQF+pnr1wfX4QxHgHi/pWP0CAs6OB0QnBT
         74/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784225893; x=1784830693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FxN2/D2tlTtH/J7f3tJFTTV+44thI+Z+5mi2902UYhc=;
        b=SnglXYHvqMAz9p3q32Qd1E0tN5OBGhWIfUyMGWKtyczzAEDdTVyZOw1jrtoOw4yBhN
         2LHhrLWLrJ+h7pyE0QkfK9yiBWzpINOQxuMOohtQ6HdZAlWUyMUeuzeASA7cK+oPhCPQ
         Z400CidXoih4wEd8f8QxPNQf0gDO3XOI5OY9Q1+I+0KCBdmA5heVJjYW1KR36pmbUZqg
         6uylRszCYmGHgiD51dB+7FOVoz3KALfyYNdKEhMoNDG/t4LD2fFsOC4cG5UVEO74x577
         vr4mrbzNfpwQ1CQR0guqaWbVLFMvot4h22fh5+iNNpthfOCuAPC1qbgwU9WY7Ms6+7oL
         28Lw==
X-Forwarded-Encrypted: i=1; AHgh+RpJr0hjw1t999yY5j/U0nEWoOio+3MXrwEnbjNakOmnllYKcBdR1/a7ZtiW7KbAVkuN55Bg1JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHaABmRsc4wvzcmjYfZYYsgj3FdxPtd9xYw+7RmPoCm7xPln5A
	GbifFR7VakTchWajtj39o4J7YI4OaotG/KnQZ9NOBlzsz2j6ItV5BzfGUn41vqMdwslD0MSUWR7
	39pEWt+THeg94AN/P8/rsG/+/KHpj8uM=
X-Gm-Gg: AfdE7cnigISB1v1/vNMusY8EgzHNUklLxEEF3VVeBeJV54JUMkeW1+rt2IJ8d5DNSHr
	4JtHFTgIU3tMb6/MGBR3Cx5oB/wmjJ40YS2/iPLbaBcVG9EWQ2XJZx2nvzwZm4TVSP+lBhYf3Ei
	M70xv7SiSrMAJYkQ7cqbQgPgBoJr36b/9H2L14xAMe5kEO18rpl1h6Do2heZGY5+ic6ijTI5FQf
	nZIuIllkz2Y+hAl4rWEfHrZ+cwEr9b9eP1/SeDnH/giBuLlIS5az8R8NB5N3PCucn0YqCygkB6n
	3+bEv15mxo/IeZoDrWhFtXdonXE52Np9zwwEDh+uHw==
X-Received: by 2002:a05:600c:548c:b0:493:ee2b:c876 with SMTP id
 5b1f17b1804b1-495483c839fmr5254685e9.35.1784225893091; Thu, 16 Jul 2026
 11:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715174305.336261-1-joannelkoong@gmail.com>
 <20260715174305.336261-2-joannelkoong@gmail.com> <17c5a1f5-0743-4c06-b771-2562ed6d45e2@bsbernd.com>
In-Reply-To: <17c5a1f5-0743-4c06-b771-2562ed6d45e2@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Jul 2026 11:17:59 -0700
X-Gm-Features: AUfX_mzO9FaoEpefIv6-tKxJZWDlmYbleseNkoAvr5BSXGeSJoeEmHYa0W81Dtk
Message-ID: <CAJnrk1Yqb3tpkt4-LT=7Q5rVUMmwNDvV_OM7bcF6P4u=1P4F8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fuse: fix missing barrier when checking io-uring readiness
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 3:26=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 7/15/26 19:43, Joanne Koong wrote:
> > fuse_block_alloc() reads fch->initialized and then fch->io_uring.
> > fch->io_uring is set before fch->initialized, ordered by the smp_wmb()
> > in fuse_chan_set_intialized(), but fuse_block_alloc() has no matching
> > read barrier between the two loads.
> >
> > This may lead a CPU to observe fch->initialized=3D1 but fch->io_uring=
=3D0,
> > and skip the check that blocks request allocation until the io-uring
> > queues are ready. This can reintroduce the lock-order inversion deadloc=
k
> > that commit 3393ff964e0f prevents.
> >
> > Add an smp_rmb() barrier to pair with the smp_wmb() in
> > fuse_chan_set_initialized() to prevent this.
> >
> > Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring ini=
t is complete")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 5763a7cd3b37..b70c536d7e25 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -85,7 +85,13 @@ void fuse_chan_set_initialized(struct fuse_chan *fch=
, struct fuse_chan_param *pa
> >
> >  static bool fuse_block_alloc(struct fuse_chan *fch, bool for_backgroun=
d)
> >  {
> > -     return !fch->initialized || (for_background && fch->blocked) ||
> > +     if (!fch->initialized)
> > +             return true;
> > +
> > +     /* Pairs with smp_wmb() in fuse_chan_set_initialized() */
> > +     smp_rmb();
> > +
> > +     return (for_background && fch->blocked) ||
> >              (fch->io_uring && fch->connected && !fuse_uring_ready(fch)=
);
> >  }
> >
>
> I wonder if we could remove smp_rmb() in fuse_get_req(), it follows
> fuse_block_alloc().

Nicely spotted. This is removed in the 2nd patch ("fuse: use
release/acquire for fch->initialized") but I can move deleting that
line into this patch.

Thanks,
Joanne
