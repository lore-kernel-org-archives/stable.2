Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795199380;
	b=ufg13jl5J2vT3diEO2PmYfaoHBzeH5jf2KoqqeEUKVu6Ye7ARk33sCwTFfDRH/rf+cK+
	 KJBSl1863fUk9uv5UWX2297q5MOm58ta1szYYcT/zv/STPBkSYwjhca/CmSEfaQpJ9XbY
	 QnTxFD455a3OfEDAYMaq49Apwe3Zs79pHh1Oo6QRsgHEMddRTiIriHn6pTi1ChdK36AYL
	 Yhx0Ph1Le/Jv4UbEBvDPnnGFqwhxrF6o59BH8YFdcuYGFJ1LMuZ46wyqG73CCsgTEQA4A
	 7LeJ7+Ry21wYjda1DtclTbIRGKS/0r5YJYMT8NY4N/do787wHvnI7KlLsI/esSL2CoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WpZL2JSgED1dxCTCDeitpd9jOOz/PRQfRKQZbZU7GDc=;
	b=5qFgZaoiR/opUZWru5CUN54HbjF7UORc+ndhoosDxZ3eclwA2veer8u6v/wXrGemid3F
	 aY8Br+mNwqbeK6jk3bQ/NB7J7CavQELc+qjjq7kHlyfCPg0FleotK/13JSOfrXpOEPeMG
	 4mWlClV16/ppdG/7bOBiB/veC+NWwK49TRF0HhzCP5axFHIj+5//2ft+8ehjaUOwBexkB
	 srysPPGpNJ8J4Z5NQCAJhMHvQ5OYuU3TpcLdk6dNjXdHbyTNGrZvfyaYj3zmcDwm7+WMe
	 B+WTK85XAEBUPajxw/a3JZoHrfdsatADKaTaRKb5lt2p6VMZt3jNQXFXXo5/qDqNiOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uwABIWmP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FB8606A330
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5FB8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uwABIWmP
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so944554f8f.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:29:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795199377; cv=none;
        d=google.com; s=arc-20260327;
        b=hhYvod0Wt0rpN4GsXbcmWI679XVqgGkqF7+5Uhj+1fjMKexa3834z0VDqpVXKfJUA7
         cyr5t58vG8vEm4wlP3eHVPId7e6kQYEsKSgfH4jki2Nf1CQV8ry4QIGL7mP0hyu8kCZw
         CSqASJcfkAjkJeVGb3l7n+ozejQyU8z8i1TMxdlJ4m8nPPVVrkzXulETGrG43PjDyiIm
         ZRbGevmAtb8bPyYjoVidvvrzcVQeb5P4qqg3browFk6rSeFqjKLWZ7L81763BOQ2WuWd
         4Fzi3qA/PDVAnNiP147LAo7N+WTVdc4VoqFbfBZsK7DfDM8s9ULHeqo2/1Ick1tP/GYr
         0v2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WpZL2JSgED1dxCTCDeitpd9jOOz/PRQfRKQZbZU7GDc=;
        fh=oMB08q89yrO64MMqvHZtS5RG89cdkTI6i8TDm5llaxU=;
        b=ctfB8gZUev0oZzjU5dAk5rSwVT6g/EoFyGnpdLPMMmEdFVBz3THhDjGko89d7URDyo
         R9dyCl7tb+btXUbpEjYzDVSVMm+eKnO7F9nDeaLpmYbVf0jd22sMHF8Uz2TyYWJqft4v
         9mK/c1KCzv1JO0avGL0XcjXYhR3m8v/RRRgmDmPfZA6W+m0iRvIl52rx8+ZV+AXIlanC
         tqxNx8ASDx+eSp/aDIyOiMJlkL1QYW+deXLcljeX90PjB/8auJs0teJZn7Y6KEymDR4q
         aZce4dsyRX0jN7oQFKUKpFh5QLlCCcxiTDBz0d13hDMeSa7ZxXp35DLsJxv3ITv93ZzN
         Aw/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795199377; x=1795804177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WpZL2JSgED1dxCTCDeitpd9jOOz/PRQfRKQZbZU7GDc=;
        b=uwABIWmPL8ufMw3MxhB2hOwlsEmPeYT8AMWdeblvvNQ1+v8MV4AO60p9JPABKcnamE
         9JU6LGYN7Rjwug1zxzVeJfqBL5YXMOmJO0GTOzazp/XoyyrswxdfWvwZfhhafqQqFPPt
         puNGPl19MUAnpekoVGvKRt7Mr5vTe4SQFBbC7jnM/ITYttyruWuBOwQSJ9X52/Wj4iEH
         bosO+SyqUgtYWJAjPH7yYL8doFP9iZQqB2OGnY5zNkhvPXMUmBIgSn+t6PsMJQXz2KOH
         dDNGaZsmXmcj3qC835umHkJbCrs9Bn3d2RCkV/6r68WrFW+s0asEfLgHUq+ZdBKyOpQ4
         CFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795199377; x=1795804177;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WpZL2JSgED1dxCTCDeitpd9jOOz/PRQfRKQZbZU7GDc=;
        b=uGAD7pVcbqD8HQW+KolAGp4HqPCjTkYMhsWr64TobQ7ualXaN74VObLEQtRVkC0Z7F
         b+917kKc9s++Hg7csVwe+nAI9LSn1IM2+0P7rBFmK8e26EY2rCk88N9KP5QDttDHhD1o
         uuRQAljJPR/bCfru/6uIwklMH0xp6bNhIk/QOJizX1B6Ct1oQB8m/mXoN6W9Izt58aR3
         PnfBWt+WcUn9+Ftxj5fQ8NyueqHDWzFaloRRRQHaQRapqHWhe+1G0c2A+fVzs7/R83EK
         qZy4PF7YpBJXoZamkySsTdHdlpuR0U58bjoO/pKevSL01OvsGiUYunvahjfyGY3WR1st
         Vebg==
X-Forwarded-Encrypted: i=1; AL+hErEQQH3sjRjXuoiE6pkXRubRI7Opy0lqTY48KnalahhgpY2YzMkeDU7eBi16fiJBLn78XWUMntc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eexuOVUGDu/cr8YczTByd078OjWnot2WIUQ87i2xZYbWdrd2h
	zjevYurVOU3CtU3zEEhHPTc482oFR9XOnvl5OIA7sV7c9lF3ChY3OmN6tt7nFgfojenzpRH+XsK
	lTJ//XBvD51VPhgADluhLeKGoSQnQaGw=
X-Gm-Gg: AZFdTZfnsK2i2+vavfg6DlMK1br8l9AJy9hPwV2UwYqiH8j5tCDOTTreMQlqHX5OHW+
	Yui/4v21Pa1i9y+ZRUo7oNofuh/5xzSIUmvRSkOvO2UEaQHaKfI6b1PG3d02kefqRGRaD0sUV7a
	fEcrktGuNxNS0QyG8l4Tb/nvO62Q5g/Kq7FUBpPmxqYoHTmjoxyOPItiD/v+Cf6pOUy2XgFYzsv
	OkOC866mIOSxX0+hO0Qb3/34W2b24WZU/U9EoeFVv2+1cjbU7YxoBU2GoJryh80+kQOZb+ZG/3V
	MpdQ0BB52/dsru3Vf37wDUGADi+yQRhWkmXuHVlX5uEYfCd6gNonLPkFdNWiDRK/XGnFUEpIEfv
	JqwSzQdh+Ewf3dJ9SyE6j1McKcdhB22X79vow+8KvKIuZeizTlsXIkYI2AtvAPBElgw7hGI5grp
	0UayViagcsveG/C/V8pGa+wqj+8qqdeeVH5zktHR7twBleCfl5PLJ7WexswQ==
X-Received: by 2002:a05:6000:481c:b0:4a5:ebcc:2260 with SMTP id
 ffacd0b85a97d-4abb2dda518mr7812309f8f.29.1795199376768; Fri, 20 Nov 2026
 10:29:36 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120002549.1908299-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261120002549.1908299-9-prabhakar.mahadev-lad.rj@bp.renesas.com> <d0f5f347-a5f6-4e84-b773-f29ffcdab156@linux.dev>
In-Reply-To: <d0f5f347-a5f6-4e84-b773-f29ffcdab156@linux.dev>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 20 Nov 2026 18:29:10 +0000
X-Gm-Features: Aa3M54pnhmFSvmvZzRx-r4wW9mEW3Np4iPEWnckhFv_SM03jf-al_Jy7M9nYdCI
Message-ID: <CA+V-a8tQH_aFb871XXJ6QkNUhyXwZo_0RD4j83GbgDpfa=9x0A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/24] net: dsa: rzn1-a5psw: Fix LK_LEARNCOUNT
 write mode encoding
To: Clement Leger <clement.leger@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Simon Horman <horms@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Clement,

Thank you for the review.

On Fri, Nov 20, 2026 at 6:01=E2=80=AFAM Clement Leger <clement.leger@linux.=
dev> wrote:
>
>
>
> On 11/20/26 01:25, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The LK_LEARNCOUNT write mode lives in bits [31:30] of the register, but
> > the driver writes the raw A5PSW_LK_LEARNCOUNT_MODE_* values (0, 1, 2)
> > directly. As a result, adding an FDB entry writes "set LEARNCOUNT to 1"
> > and deleting one writes "set LEARNCOUNT to 2", instead of atomically
> > incrementing/decrementing the counter.
> >
> > Use FIELD_PREP() with A5PSW_LK_LEARNCOUNT_MODE so the mode lands in the
> > correct bit field.
> >
> > Fixes: 5edf246c6869 ("net: dsa: rzn1-a5psw: add FDB support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v4->v5:
> > - New patch
> > ---
> >   drivers/net/dsa/rzn1_a5psw.c | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.=
c
> > index 13c46cf2c420..7fd2652813ac 100644
> > --- a/drivers/net/dsa/rzn1_a5psw.c
> > +++ b/drivers/net/dsa/rzn1_a5psw.c
> > @@ -5,6 +5,7 @@
> >    * Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> >    */
> >
> > +#include <linux/bitfield.h>
> >   #include <linux/clk.h>
> >   #include <linux/etherdevice.h>
> >   #include <linux/if_bridge.h>
> > @@ -545,7 +546,8 @@ static int a5psw_port_fdb_add(struct dsa_switch *ds=
, int port,
> >               goto lk_unlock;
> >
> >       if (inc_learncount) {
> > -             reg =3D A5PSW_LK_LEARNCOUNT_MODE_INC;
> > +             reg =3D FIELD_PREP(A5PSW_LK_LEARNCOUNT_MODE,
> > +                              A5PSW_LK_LEARNCOUNT_MODE_INC);
> >               a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT, reg);
> >       }
> >
> > @@ -604,7 +606,8 @@ static int a5psw_port_fdb_del(struct dsa_switch *ds=
, int port,
> >
> >       /* Decrement LEARNCOUNT */
> >       if (clear) {
> > -             reg =3D A5PSW_LK_LEARNCOUNT_MODE_DEC;
> > +             reg =3D FIELD_PREP(A5PSW_LK_LEARNCOUNT_MODE,
> > +                              A5PSW_LK_LEARNCOUNT_MODE_DEC);
> >               a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT, reg);
> >       }
> >
> > @@ -963,7 +966,8 @@ static int a5psw_setup(struct dsa_switch *ds)
> >       }
> >
> >       /* Reset learn count to 0 */
> > -     reg =3D A5PSW_LK_LEARNCOUNT_MODE_SET;
> > +     reg =3D FIELD_PREP(A5PSW_LK_LEARNCOUNT_MODE,
> > +                      A5PSW_LK_LEARNCOUNT_MODE_SET);
> >       a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT, reg);
> >
> >       /* Clear VLAN resource table */
>
> Hi Prabhakar,
>
> It could probably be worth it to add a small a5psw_set_learncount()
> helper that contains these the FIELD_PREP + writel.
>
Sure I will do that in the next version.

Cheers,
Prabhakar

> Otherwise, LGTM:
>
> Reviewed-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@linux.dev>
>
> Thanks,
>
> Cl=C3=A9ment
>
