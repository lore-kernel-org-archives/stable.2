Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739AE2741B5
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438952; cv=pass; b=VkD2H3QOVyoD1W7DV5fBryLV96tKaKZpHn/CxVBlX/8P//lS8sbxQajsdravNLHi61O96OI0V0uXgmSGBi3Yv4RfCXKCQIuITWVY4RdOfd8EeaNy4+hi7WdZDPyP+2/Zp70Fl4V5fw8Uu0TSDXL3Bv3bkncidGXt9jIhxE2Wf/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438952; c=relaxed/simple;
	bh=jXiXb8BB8/5rZZmokBeg/dECudwiIK4cvNgjgqBgQ3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKVOsJWvNcJNtMERHYaj4wNBlwsWXUmDNtnncfNOLuxz+PaPaq4EXHuutcj6oeV2n1f1pyQmgdxdakapmSm2L/jCd53gsEJfuU67PiA9RnABgEKOgl16R4vUhFYmhHzZgVJwoCmr+b/VzaTwIby9DC3lBRoJoCx1o5BrzaaUfM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWe5gc6r; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWe5gc6r"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-697ebe536b6so689005a12.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 18:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782438950; cv=none;
        d=google.com; s=arc-20260327;
        b=NUjakK68pzYo5SnnV8ZyyoFvYjGb2LboZTFnuTQfPuAFlMepkpHSnCgJ4Aqq3/BuCU
         zaOmTAkdw+29pyrYBD1TnGf0Y7avxJ6xVcc8Yeb8kYscZiZ6QGQ+B9yQuLyDjBa1rFFl
         XD9G49ZIE6ebi1WQYcg1Ko1JGC4IAdb6SQeJ4JMCif3IvJmIkNaO4N+QJeMpgXGcU21n
         72xDajbADnYYE1+Y7b/Bx11tJxxGDIUsFMa+m5hobbAqtPPuy1/74qF8voAqZjXMq8kW
         8UuFfkJPuw4TqZLzdMec1bo2EnrKOc2AKXADYR3N9Nf3iQpD16/+VBGfCSoxWiyZA5SA
         dHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LNZy2c6rQcybgL+bCAHWO3UrpbXcc8ANhnoFPYD99Hk=;
        fh=wd/bvQxnowN19m4m3ASseOiKQ31j5rz3QjrTrnw1X9o=;
        b=Nmy7lnIqauZ5NZtV4NrJgMMtCWsNj1Q77WFtiWzxVyzdSOFOF9vJfik0OwVs+v1q7I
         i4xJ8qSSQ9ac7Z5rltFFIa0TRTNka4VnA0sU+DHDdOeR+qBXJ89LgFu4Ujw/l/UAv2XL
         +MJKZaD639ZTQmNaXhF/DfM7D+KlxhhXW/NatoDNttS/9ytCNfz6TE916YY/QhwvXO1S
         RLxz1II9FUB3qe/vhwYicfq/4C3RvEb6T8FCxDfn+edOnWu/PucktdSOb0LhcfeZflTe
         yuEcG8/OqKNjhIiNHICbsWjboNEP2dRaSPhtvrA4VcU+3JT9suvOY2mF4Iarh5RJjosJ
         KXXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782438950; x=1783043750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNZy2c6rQcybgL+bCAHWO3UrpbXcc8ANhnoFPYD99Hk=;
        b=nWe5gc6rAFWOdIkY+CahYvCdhWSBnezkK8Yh6zP9/grgJuDp01mKbqSJgN0phhojiK
         7e0RtZ1GVg7TEXf1XDYntwYWqPSptq7Ub1QS2RT0Xbn+RKrsNM3By3+pr/PVtzHf8Oxb
         tN7jtkfEHo6llKMzISX4AyWfVICOl8kLeJ6SUfd4FNhUEHUjAUUw21qJ878yeMI22fh7
         wmDVf+TPgAiHAeKs1L9KHS21JyjwWC6u08n87lojUb9qmk1MxlMkQNYgd1WFS5B8tRNe
         DuHrTrXbcTfM6p+t+m9fuvdlJGcRIJl+VUV5W9WwcPCeSzYwzuM6IGxmDFY9CQ7hIKV2
         kOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782438950; x=1783043750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LNZy2c6rQcybgL+bCAHWO3UrpbXcc8ANhnoFPYD99Hk=;
        b=kUAGWJy2m/wkSwkAMxMJCSprd67lrc53wLD6LfEW4TDg+JjtrBSo8g6MAWXTfJtU5i
         Xb4kccMPgfw6Kk02l7Emh7KDrWcoKnY5T6E7r6Y474Xj4/JoRaESL6U7z7n7f7Homb3H
         G2JpeQ0wy1FNsgBNtQygJxLhFRxvqzHBN0QpCExst72WeNaPxwzaabxAXLItXz673lEW
         O1W3XV028/zHCasH8MyxZh81wul8oxJqujP9sL0HdTXfBSqcn27/EEg6etLGToBT3kOA
         S224EfASEm1kr7uSbieO3mRPUUN5PgBy2ndea1pC4Jcs2BBiVPySOkdL7WenuB/XWHO+
         Ekvw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8z2+ij1YjGI6mtkEMoOE8jXEO2mcCBP6jrt15RZxaWVI2wwiYlYqu6fHA2h1pjaWkkYsEd/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6cxUinm822Zo5ClaNTNxjna3eXLe9NzGzBxV/PIkZs+xbBMg
	CKavTliBpLUsXbI0VSnNyoz43K1pLpVTUpivhcvr3aT9UlqyNOAyeArsJSs+Tmg+V5QcVLnNc74
	3PRAP+gbgBBAVq/Zlu7KvRR66lw9qLFI=
X-Gm-Gg: AfdE7cmdWIK8E+v0AovyxVuzZEXW54mD3I0ynRVhwa+t7R1pFrr/9zVUz9+bKlaLUcg
	L8uKwe434eS+v2cCwIQUf/b45oNy/FDvkQQfjk7AOFrrjcxbLlLmZRx9Xxwr29CAYzga8/AupbR
	bu8uCH6Z/ZtV2LQ4QGHeFFgfzco65vcuhxqD9Hma+6NaFuN1Okr2kx2N9jIi+w9q4cA3+FI8ycf
	oYGTC9KhRxYM7ezPLBhN7TNMTlCk+gR7UieZ8eX11zGGOcyOBq6jnJ8EiFb4UMycNy7k6wFPpbb
	5Sz0VA4=
X-Received: by 2002:a05:6402:3512:b0:697:eece:eae0 with SMTP id
 4fb4d7f45d1cf-69810a3a8a5mr919346a12.6.1782438949713; Thu, 25 Jun 2026
 18:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625071130.93544-1-liem16213@gmail.com> <20260625160219.55116-1-liem16213@gmail.com>
 <aj1UR5ddawsdMbZC@SMW015318>
In-Reply-To: <aj1UR5ddawsdMbZC@SMW015318>
From: liem <liem16213@gmail.com>
Date: Fri, 26 Jun 2026 09:55:38 +0800
X-Gm-Features: AVVi8Cdo9F6_HUwGPZkGfKdDVs1g2IkW69-hNTuPosIJl9Kc44faaQDJLD5vnmQ
Message-ID: <CABoz+=00tywisdxcmkF_F8rOYg=BMtzZDsTN2JOXfzEwsQu01Q@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: imx: Fix slave registration error path and
 missing timer cleanup
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andi Shyti <andi.shyti@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Biwen Li <biwen.li@nxp.com>, 
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frank,

Thanks for the review. I'll split this into two separate patches and
send a v3 series.

Regards,
Liem

On Fri, Jun 26, 2026 at 12:16=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wr=
ote:
>
> On Fri, Jun 26, 2026 at 12:02:19AM +0800, Liem wrote:
> >
> > There are two issues that affect the i2c-imx slave handling:
> >
> > 1. In i2c_imx_reg_slave(), i2c_imx->slave is checked at the beginning
> >    and the function returns -EBUSY if it is non-NULL.  If
> >    pm_runtime_resume_and_get() fails later, the error path returns
> >    without clearing i2c_imx->slave, leaving it non-NULL.  Subsequent
> >    attempts to register a slave will then immediately fail with
> >    -EBUSY, making it impossible to register the slave again.  Fix
> >    by setting i2c_imx->slave =3D NULL on the error path.
> >
> > 2. In i2c_imx_unreg_slave(), the slave pointer is set to NULL after
> >    disabling interrupts.  However, a pending interrupt might already
> >    have started the hrtimer (i2c_imx_slave_timeout) before the pointer
> >    was cleared.  If the hrtimer fires after i2c_imx->slave is set to
> >    NULL, the timer callback i2c_imx_slave_finish_op() will call
> >    i2c_imx_slave_event() with a NULL slave pointer, and the
> >    last_slave_event check loop in i2c_imx_slave_finish_op() may cause
> >    a system hang because last_slave_event is no longer updated.  Fix
> >    by canceling the hrtimer and waiting for it to complete after
> >    disabling interrupts, before clearing the slave pointer.
>
> Please use two patches to fix these problem. One patch fix one problem.
>
> Frank
>
> >
> > Both issues can trigger a kernel oops, system hang, or permanent
> > slave registration failure under certain race conditions.  Add the
> > missing NULL assignment and the missing hrtimer cleanup to harden
> > the slave path.
> >
> > Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Liem <liem16213@gmail.com>
> > ---
> > v1 -> v2:
> >   - Instead of adding a NULL check in i2c_imx_slave_event(), cancel
> >     the hrtimer and wait for it to finish in i2c_imx_unreg_slave()
> >     after disabling interrupts, as suggested by <Carlos Song>.
> >     This avoids a potential hang in the last_slave_event loop in
> >     i2c_imx_slave_finish_op().
> > ---
> >  drivers/i2c/busses/i2c-imx.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.=
c
> > index 28313d0fad37..04ffb927aba9 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -936,6 +936,7 @@ static int i2c_imx_reg_slave(struct i2c_client *cli=
ent)
> >         /* Resume */
> >         ret =3D pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
> >         if (ret < 0) {
> > +               i2c_imx->slave =3D NULL;
> >                 dev_err(&i2c_imx->adapter.dev, "failed to resume i2c co=
ntroller");
> >                 return ret;
> >         }
> > @@ -957,7 +958,7 @@ static int i2c_imx_unreg_slave(struct i2c_client *c=
lient)
> >         imx_i2c_write_reg(0, i2c_imx, IMX_I2C_IADR);
> >
> >         i2c_imx_reset_regs(i2c_imx);
> > -
> > +       hrtimer_cancel(&i2c_imx->slave_timer);
> >         i2c_imx->slave =3D NULL;
> >
> >         /* Suspend */
> > --
> > 2.53.0
> >
> >
