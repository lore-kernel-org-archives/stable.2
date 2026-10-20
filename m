Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488448;
	b=Vdcva8l/3fhV4hQQq9FrU8jMMsPaHtJr/bTGDqZ3LmyaNub5+H2nFurHraITl7LDGH+Z
	 7Oh3DzFeXiyCmGbikMJXzt8tFv23q0urv0iaelntWGKh0uT1mn+i7ldj3aMtymwJ5zqVk
	 WA4F71kYx3MKt3kXFZ/ltN6txkOlSjFivTep+qNCF3pG2YjlsPglZt9bQlTn37cWzYu+P
	 Wez1A4oaPLbT9uxc9tMqLEHsCN7B+r5DUFjNKS9bO0AJd8Ww/mmKAFwMyxWuUeWCU/Iaa
	 bIUpX/wchVLTQtvpYSMPOERpTuo/RYCZFppdz4/EZF4aj/ww4GsM7xwdlJi9NAEBQ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488448;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=BDWYvpCyYNbdlYdFIyikLQLsNfMBmKmrC2Q4BgdAcQ4=;
	b=fFcSoM2oFN2L5sdtoZzUUepIiYak6sqWxlNcSkSfmhb8hOK6fbNGIZGsWtn7T7FXP67g
	 Ch1QK/vOY9nA+Pu5LhBI498lDNoqJfrpEAADIil2Ns8W5IOChb5245ENQNu12h6gO5JUw
	 6c09RkrrRlW3rpq46iSg8KsqnrPsPcJUARehM3PesHDDUma/KSqVbnpDvJN8LzxzsHBLM
	 6aytadIeXTP+bAFR43/1UiygxLCHbgTsZCC/upxVMxYughZ9dgNjDQZ8w+mnFiAClw3wK
	 SMlSqR/oSeULVMqqHNzScTdqI3TVk9/kd5o4yw2Vqx0KloE1gpOkauEFEt00YFO64aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B346C606A31F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 09:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B346C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7c420c2c4faso1670090137.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 02:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488447; x=1793093247;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BDWYvpCyYNbdlYdFIyikLQLsNfMBmKmrC2Q4BgdAcQ4=;
        b=EBgzwQMB8IyiiVu5hC9MR/78EQkhSGP+po/5VyENrZbfV8YJZ9Tmr1eJkaKRgWJaxK
         RcBoJeqDmDqTL99T99bAo4bvudxrKBMOJhKZ6i0ZlVSET/uk2VtSohIAe9aGd7IRlj+V
         DmH+Iz4ztjwSV8spHQ71dNip/dGpcfQwzBESsRqHivmv+WALDXzVzIeoEuo9YAfLsAYO
         3OF1zMXa20tyiIBbSBcCT5ybdRlvyYp5/W7+j2QrsKosRB3JcLUeRedm879AKcLMDbhV
         95DKkNWovHr70+UujHVatAyilyuFazla5vlFP9M1tC6+tQAGr4B9KLL5k8EXldTXF/kL
         kSiQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9eAJJz6cnrI2U1ZZ1CiaPn4ZKmvixer01Bt8WfqpwytH6DVZ+7UJCBHByP0c8nKIQeuenlmM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI74URA9vRzVGQ625UKl1uVHTJv9wQxphWRLaWVVOlA129bOt75
	IZ1vjflSwR3VMp7YV/EB1LY6Fg+VLzhUOnfEsnb5kUqkHh+eq9lo2VvAvyTylqT0toI=
X-Gm-Gg: AYBFou0GpVilKocrItjrssSWxFNaGg+jz3x5zJMUbEifU8I/gw8tCVKS/N85NuRDXaC
	OWzzgMVaQZr78OrA2kFT9ZDoXZ5PN2S3y5UB9vQgcnpiW5prk/Se6ABhMwWr3vapQr3o8w3yX7d
	ijBXNS5jky5pwuYmAes2IpBuoLX4lFxVol3ub71eCeiOPKlXH4LO8eYPpgJhuog0a58CNVOeG52
	U3LqoVV07O9q9uP1Cpo2XfyAPXa4lqi+AZWA0x0RbNHn/sTf205Za2OTaloo4VVqymdguxvqlQW
	jGnQVX15dfduoCHv51WLpgF+Tby9grcUxYB2D2X/TD00wdsSjR2xSR7zMv763ft4vnDlzZ1oAmu
	DjX3I8JiZHN9xmxKh/Lb8kZW5R6Lf+5zEmcShq/H8e6fp9s/b23Ki3x+AX23SCYGZOeK12lhGLv
	H73E/FSeaVZKCp88EfUJySFBWPplI88lUWLrx8niudbGGXghy+x2FnY+9yBa4PrIr5XaXCINho2
	G/5pFhTYfUqUb5MzsPDYgvI8eQIX14SBcIQVzx0hg==
X-Received: by 2002:a05:6102:419e:b0:7b3:4199:2dd7 with SMTP id ada2fe7eead31-7cc364a1700mr3377531137.0.1792488446727;
        Tue, 20 Oct 2026 02:27:26 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990bb3adfd0sm2413453241.12.2026.10.20.02.27.25
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 02:27:25 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ead32bc7d8so1046641e0c.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 02:27:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxiFMmUmYrnTvNVw+G7TejFH+ruqe/CLC503uveuqxFllbMw9PpNCRmT33EomptaxvlH/RJXgk=@vger.kernel.org
X-Received: by 2002:a05:6102:1625:b0:7af:fef2:8ecf with SMTP id
 ada2fe7eead31-7cc3691cf50mr3455060137.8.1792488445010; Tue, 20 Oct 2026
 02:27:25 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-divo-ssgrlpcsrc-2966-i3c-v1-0-30a47f25e515@renesas.com> <20261020-divo-ssgrlpcsrc-2966-i3c-v1-1-30a47f25e515@renesas.com>
In-Reply-To: <20261020-divo-ssgrlpcsrc-2966-i3c-v1-1-30a47f25e515@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Oct 2026 11:27:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWt8KV02C+N1dj=gcdJwX4s-_=+zRpsh+Za+f0HeHOkuw@mail.gmail.com>
X-Gm-Features: AclHuK-aAi-Edh8uIEyKFfeZ8ZpBiAefIme6DU1Cm8luHP5VW0oo3t3lyPOBTwA
Message-ID: <CAMuHMdWt8KV02C+N1dj=gcdJwX4s-_=+zRpsh+Za+f0HeHOkuw@mail.gmail.com>
Subject: Re: [PATCH 1/8] i3c: renesas: Fix zero I2C SCL rate on pure I3C buses
To: Diogo Ivo <diogo.ivo.sx@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Linus Walleij <linusw@kernel.org>, linux-i3c@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Diogo,

On Tue, 20 Oct 2026 at 11:15, Diogo Ivo <diogo.ivo.sx@renesas.com> wrote:
> On a pure I3C bus there are no I2C devices, so the I3C core leaves
> bus->scl_rate.i2c at zero if i2c-scl-hz is not specified in DT.
> Deriving i2c_total_ticks from that zero rate programs a zero-width
> open-drain SCL into the STDBR open-drain fields, which are still used
> in pure I3C mode for example in DAA.
>
> Fall back to the 1 MHz FM+ limit instead, the fastest rate an I2C
> device could have, so that a sane open-drain timing is programmed.
>
> Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Thanks for your patch!

> --- a/drivers/i3c/master/renesas-i3c.c
> +++ b/drivers/i3c/master/renesas-i3c.c
> @@ -579,7 +579,18 @@ static int renesas_i3c_bus_init(struct i3c_master_controller *m)
>         if (!i3c->rate)
>                 return -EINVAL;
>
> -       i2c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i2c);
> +       /*
> +        * A pure I3C bus has no I2C devices, so the I3C core leaves
> +        * scl_rate.i2c at zero if not explicitly defined in DT. The
> +        * open-drain SCL fields of STDBR, which are used for the DAA
> +        * pending read, are derived from it though, so fall back to
> +        * the 1 MHz FM+ limit instead of programming a zero-width clock.
> +        */
> +       if (!bus->scl_rate.i2c)
> +               i2c_total_ticks = DIV_ROUND_UP(i3c->rate, I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE);
> +       else
> +               i2c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i2c);
> +
>         i3c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i3c);

This looks like a good opportunity to use the shortened tertiary ?:-operator:

    bus->scl_rate.i2c ?: I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE

>
>         i2c_parse_fw_timings(&m->dev, &t, true);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
