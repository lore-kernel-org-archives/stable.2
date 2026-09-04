Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D66501F48
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540783; cv=pass; b=HR1OhGqGlRszVoLeEo3teNxoIsyNy6E5/9nmcpWLKwzrzzil9h8lzU8OnyfSTJ7wHx1K6a1Z37nXKTK0lBweMp9VmgiyQFuUNpTwtpI5ZgbaWkw8FkslJTf2H7o8rhmIIm90ZGwjQc3gcMa6EvARP0kcJlMrNlvTbTfM6pPpI70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540783; c=relaxed/simple;
	bh=nCqEeX/YmPXgBfiXFWn13hZN8T7Z+lPuAqTre4JIEAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lG5dbOI9aLLDQmhhApg/ZBHVnl3NoaX4j15E55FBnX9ITDSHRFRCrhSsXRRZKbaR7kbEfvDZK+rK1V6CjY32WA3lThW5E8rPhVBSUFKBFhAQwrmIJlUlAhN2TiVvI72ZRYRSENTo6pwmGUpdgzwFqAuSMoHCc1pk30+OLua+uHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmjnUSD7; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmjnUSD7"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-97cc72fe0f3so1542775241.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 09:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788540780; cv=none;
        d=google.com; s=arc-20260327;
        b=s9hBvYdJFFPD/Pc9h+XG05PmHOA67wUBy6pG6aNcZvGntJZP9E/JVoWpaNSfZ0GMCF
         9l5yD0OxXB234/miMErLQqaCtSpHYszhBx9++LQexFe1e6VtmHMDqmZ4R517zBm+x/gL
         ex+9g5ZFIYeOPJ9Q1+Rz1azb4WmuForItkhNwaqSmfaWcBmppot38oshnxm+fPel7Yy2
         I34eRORrGmMDEEYd93AG5X1q2W+I3Me8ZnzsV6HXLye0FExLXHxg7BRoLE9Ar7ZgHvK8
         NczL47CKdbJ80h68C/jJW6wfbCYVZYwsVUOYqjSbw+BOovD9optOLFLaH5mdD4xUK80r
         bqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ien2o60ZIi4QpF5qZ3s+1MoomCrROw/TLgJB8j1A6bc=;
        fh=kEex2FD9d6K+Mk8cgVWuT/+cr5Psd22+6uPtAiaAifI=;
        b=czOXSVnz8kd+kPGIb/a96MerTb2aa9PHJS5XtmC36YSzslAnll9fdrZlsnI+occ9uI
         Nuv9stGTNWqyiq57p1KXarCeM3FstRdcZgNnyil17EqbLvVCUHtmvE019RQbhPSN9XIo
         obeAVCU311OOFkaplfYq+MJB08AODaKTNDOlROnG3iNQlhsZCLBLskYCKShGtTyNz1p2
         nCK54QpWjgKqUF1VV6w6x7RsPVBc525Zk0qahf8CyMFxvTnnszinBUQRFe3tSPsyQpJG
         M7PtrqtwBwty7N3h0Wc5Jw1DlmlBb8u0+xVDLboNWGgZ06Q4muLRLyk7nKkUUeRvMntO
         jF4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788540780; x=1789145580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ien2o60ZIi4QpF5qZ3s+1MoomCrROw/TLgJB8j1A6bc=;
        b=SmjnUSD7RGTHvpg/GV8Xa4QSny9Za0MZvaW0SAgHdChhZjIZNjB5pUhNWjLJnWJybf
         MNKdF5L/AEgZjMdlYlB1/7xPVUVMWA1yTShfai6QQ2EH+UR4kt7B8SwJppBaUwyvP3F6
         spWx/WtASEMx1qLp4DkQ+6gkd6ui3jjIlVYjd1xtFEXP/VEE6HS+scmICRLYZdC7EHcK
         FsL2kaYkRydjYZV5KunAORFRLQday9Jw1vHuNfqKZR7ofc4artZCCNnrjHuMBpVwrMtK
         zZqhbbth87rz9/fAgE8fzyxZANiA151h+FNPi7KBM/ce24cUB0GOkkCFqUowtGSkkjiq
         o4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540780; x=1789145580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ien2o60ZIi4QpF5qZ3s+1MoomCrROw/TLgJB8j1A6bc=;
        b=raHGrJ7hNrWOmRu5PdxieNH1RUiN+umC0f1i+JR+r9fqmvj+Q7rD3n9VsKWxdEP+4P
         B/tBD0SMu5FoS6kToaNye20C1uR4SUt34zCzvu0K3hyG+y1cwJ2iB11un/uU5TLdDIYL
         n2YRyQXajXtEAB6pgo8xvciXOA11Q1Dnh5pHMNOtdZb2Z0djU2SGa+9jQddAZehK1Ich
         uy8rfmgU7MGSgJ3e/ZOXkbR1NDaSqjbgLClDqWPPVz62a4FTkcSspHd3GLWNoR1l4vGM
         o4HuBvn2DWmnJaaFgUSAxVSuD81FyVmEVi9i/p/IH8WvW4eOuNx/YVR3mdqauCubl1vP
         QGrw==
X-Forwarded-Encrypted: i=1; AKwUvBxnz6YuRg/qH81N4giqVZBC8OOhVSj+c6JYWgi9Thmi1Vdxq+OHmvU5Dxxvg8gEtgz0ybYecTs=@vger.kernel.org
X-Gm-Message-State: AFuF++l11FV5z+doA3Ul8aTJyYZiZqZ7SQTDCTFdvHb7RaGh50IeozWU
	0yCLFlXqPa7VrMLRJJd64dPb6h9KUhV4pJrqNOW8VK6idEreOq2ePrLUqqYabGbiOgHjvvNGVkC
	Wpg8hDDcjp09KYlfL2yY7WGrTapACDiY=
X-Gm-Gg: AYBFou2wWAp06rMKVdh8/RF4IT+9g70Ol9NgSS7IB+7fRcel9QG/wzl3FV6EccvpH0K
	gNS6LN4e8eM4T9tg0bYZEM/vkzT1zCb9iyyi+0oRYva4wSkGnW5cI0Kl/rtttetOlqND5tA/d7R
	UkL6ht+8p7YFGiLa9Jfld95Lu+2/3ZJ+7ZPpN8PC3rzjrtDREoh8yNrnbkwfpMadJvP55Sxx3Qf
	avL4rXRzcl4NVXElRH8D5lcJYqh/eMXQMi+WNPo9u2QoK8knQkkIyMcSdaMWmVHrflgm4M4sLq7
	v6Iv70Coz8YOlm0XgLjHiRll/lX94dKDim6Qb5r5NyJZq8R0njB8QMLbxlQAE8hApjmzIKL0sUl
	lq/YMiTDdL3JUEMi08HBmFk9kF49sq+cOhKJmK2LC03kaslxKvKrXft7HRFS8bEUlRw02AwPu1I
	Q13hh0wsx4gp+jeRkSshHjIO5eorOQtaZ/euTisQ==
X-Received: by 2002:a05:6102:4b01:b0:786:a11e:484d with SMTP id
 ada2fe7eead31-78a4a86b686mr1500572137.6.1788540780511; Fri, 04 Sep 2026
 09:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811060651.227431-1-james.hilliard1@gmail.com> <87ecf911jr.fsf@bootlin.com>
In-Reply-To: <87ecf911jr.fsf@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 4 Sep 2026 12:52:49 -0400
X-Gm-Features: AcwNN1VzoX6Wx03j6h-GsWo7X9YwKmv-DqDt9ZWJFHiKu2jY-uxo82M8zbL9kdI
Message-ID: <CADvTj4p3kFN+4NeeouXscPrnHTWKbauVcYXnh2uW1OGHUL_sbQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: sunxi: reject invalid ECC step sizes
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-mtd@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	stable@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Richard Genoud <richard.genoud@bootlin.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Boris Brezillon <bbrezillon@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 9:25=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> On 11/08/2026 at 00:06:48 -06, James Hilliard <james.hilliard1@gmail.com>=
 wrote:
>
> > ECC maximization forces a 1024-byte ECC step and divides the
> > available OOB bytes by the number of steps. A NAND with a smaller
> > page therefore produces zero steps and a division by zero.
>
> No, steps cannot be < 1. If they are, it's a bug that must be fixed.

The zero step count is created by the Sunxi maximization path itself.
sunxi_nand_hw_ecc_ctrl_init() unconditionally sets ecc->size to 1024,
including for a 512-byte-page NAND, before calculating nsectors.

The controller attach callback runs before nand_scan_tail(), so this
division happens before the generic ECC handling can reject the
configuration or fall back to software ECC.

For this case, would you expect the Sunxi maximization path to retain a
512-byte ECC step on 512-byte-page NANDs, rather than selecting 1024 and
then validating the resulting step count?

> > An explicitly configured ECC step which is larger than, or does not
> > divide, the page also produces an unusable step count before the NAND
> > core can diagnose the configuration.
> >
> > Validate the step size at both points where the driver derives the
> > number of sectors and reject invalid geometries.
> >
> > Fixes: 4796d8655915 ("mtd: nand: sunxi: Support ECC maximization")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/sunxi_nand.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/s=
unxi_nand.c
> > index 45ccbce91551..ad314c0e30b2 100644
> > --- a/drivers/mtd/nand/raw/sunxi_nand.c
> > +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> > @@ -2032,6 +2032,15 @@ static void sunxi_nand_detach_chip(struct nand_c=
hip *nand)
> >       sunxi_nand->user_data_bytes =3D NULL;
> >  }
> >
> > +static int sunxi_nfc_ecc_steps(struct mtd_info *mtd, unsigned int step=
_size)
> > +{
> > +     if (!step_size || mtd->writesize < step_size ||
> > +         mtd->writesize % step_size)
>
> I don't get it, mtd->writesize < step_size is conceptually
> impossible. If that happens, it must be fixed earlier than that.

An explicitly configured step reaches the controller attach callback
after the NAND geometry has been detected but before nand_scan_tail().
The Sunxi binding permits step sizes of 512 and 1024 without constraining
them against the detected page size.

Could you clarify where you expect this invariant to be established:
in the raw NAND core before ->attach_chip(), or in the Sunxi driver when
it selects or consumes the ECC configuration?

> > +             return -EINVAL;
> > +
> > +     return mtd->writesize / step_size;
> > +}
> > +
> >  static int sunxi_nfc_maximize_user_data(struct nand_chip *nand, uint32=
_t oobsize,
> >                                       int ecc_bytes, int nsectors)
> >  {
>
> Thanks,
> Miqu=C3=A8l
