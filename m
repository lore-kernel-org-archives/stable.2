Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FE39C00A
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324383; cv=none; b=BuN2F+hbWIL5pt0rNXlTgxqOgpaGejPSlAOcQgX0WVivGFGn8A56UBWq2lZxAjdwQC1IZC762nhYWvnCvB1ErfqWtu4i2VPrF1EDIv2hz6BCe4Gfc1LwkfV5DDGOZ/+Hsz+MJRaIMZmNyGJ5iEPZswpjZZxIGu/RtpIorg95s7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324383; c=relaxed/simple;
	bh=M0/CdQ2hWlEsNpX+uvlrz2p+fcJUmzcvLY/hJKYzvCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE6f9jybC6svbB0Owu+TKyMesVWOYBuyUrJUxA7GYC40hYC9xgiQaX4yoQu8dZyyd0BgepUMVVAYfkmAiQ10DaqTJJfmcN117kSBlX9jICNfHboJFewbhHcJV1My23NNdJDq/SRuLkHCc3jqcFgZRltHmLI7Fb0IcrlIATCRhXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bbc717c52aso742911e0c.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 00:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783324374; x=1783929174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xh4P/7d1HtdDB3vmst4Juu+8bmd5NKznkNS5EpUXno=;
        b=pO2tDdqi+C6IzmkipBWOnzLWMwd5KYhlR7uSD266MyiFpTVrLh2KfySWRuqRuDuP6C
         GlsjUIifqUx20shKtNTj0OQD1mMIIDGUvLdR0kVhEEoAPEhBHgS8zHCA6NlKuncQIWsP
         T7ADJLRKefYZzYZL0xpqx9pUFaCnSH2g5rRJfezxvHIgoqb8q7/yv8w6j8r6hsA9Gh7M
         G+fJwRfHw1mcT/V7uDa2O4/rgyNORoLqQ7V36jqS1SJ4cEY5pYX2lP08j7rmQnCnWbuU
         Xp+UuGnPaY/ZPPzxl6xWr3NyyguP9nCQSqzIxneNmwBa2usXzlR4KtNU1Az2upwZdZnO
         3nHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYCwAwNHc8sh0gzaNKPXu80mnKXoX8HUyLXKeZdI57DZqNsMSAeZz6CxevisYaFnMLWOju7dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5s8eWKA/4PpcOw8wgS9UCgpTF418oH2CXpPbi3PMhC/138xkh
	Da8OR+0sZiRw+ogpqrlym8Uc/HK7GunZEgal2f+luJMdiLJmh6r4waPactJ3uklU
X-Gm-Gg: AfdE7cmT6Dio9xmCQ+CYW+FymN/YLIOLKw5iwxsdRbTrbzvk8dCT4+NofvlvEr6VjdP
	s3gmiRdk32faLdzoKpRl+fAg/pnZjyrmj+Fz4JtEIFK6mHgm6lE3ZR1Yhosp9gntsrcugQB7brN
	m8XsxUx3+bcf23h/JeX7U2+RUb2YmduVhU0aOL1RDa1fXB1BhqLF7YLbQDQ0IJXuIY0rLeJoMwR
	Ob5VtM8TZA7UqqIpz1RTSV5RCdFUtwLMVuLYIFJ+apEfWUNlnM6ANP/nmp+PX6rQXPsZKYqCBMx
	4xUkwokT7EbihhrC06BhWFN/haiCNfIvoOZZuu4lrXuS6b6GNRjjvvLvAzltgDP6cVNoWkFuhWW
	QbCjtJDrqjl0SGUJkcbPPCGAQUFqESACbL4fN2BNIg+2nLgDgggI5d+WxE/oTsaVZiXTiNSYyML
	w4cX0gCVzSjRzJYqr4otywcvYvR+GoeqAiim7RE0TnLP9eZTExHBZxtA==
X-Received: by 2002:a05:6122:d9f:b0:5bd:af82:fd9e with SMTP id 71dfb90a1353d-5be101de588mr2844049e0c.8.1783324374323;
        Mon, 06 Jul 2026 00:52:54 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5be02c5d487sm4470027e0c.14.2026.07.06.00.52.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 00:52:54 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-59ebf30a91dso742718e0c.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 00:52:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqwFpFrhL8FfAeCTrWV2bDzXS7OwqKJs6pxmPD2pYVHF6hhI5LTUO1zO7dhCGa/Mm1m8LcdjaY=@vger.kernel.org
X-Received: by 2002:a05:6122:550:b0:59c:b1f7:4df3 with SMTP id
 71dfb90a1353d-5be102ec434mr2791159e0c.12.1783324373810; Mon, 06 Jul 2026
 00:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702155108.949633242@linuxfoundation.org> <20260702155110.958322610@linuxfoundation.org>
 <ed0c9af450494df5f7bfd72670754c8e48e1f36d.camel@decadent.org.uk>
In-Reply-To: <ed0c9af450494df5f7bfd72670754c8e48e1f36d.camel@decadent.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Jul 2026 09:52:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWEVCxK3gPCrD5cTAsGguE6WOJ8sAHMrX_Ba992gkKubg@mail.gmail.com>
X-Gm-Features: AVVi8CcBna7djcvUVCHqavMy8dwrPHmBT7hVzDDa8jlPMmxq2pCY8JhUDX6MQ3E
Message-ID: <CAMuHMdWEVCxK3gPCrD5cTAsGguE6WOJ8sAHMrX_Ba992gkKubg@mail.gmail.com>
Subject: Re: [PATCH 5.10 94/96] mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulfh@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ben,

On Mon, 6 Jul 2026 at 00:15, Ben Hutchings <ben@decadent.org.uk> wrote:
> On Thu, 2026-07-02 at 18:20 +0200, Greg Kroah-Hartman wrote:
> > 5.10-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > [ Upstream commit f48ee49726ee4ab545fd2dc644f169c0809b19b3 ]
> >
> > The RZ/G2H (R8A774E1) SoC was previously handled via the generic
> > "renesas,rcar-gen3-sdhi" fallback compatible string. However, because
> > the SDHI IP on RZ/G2H is identical with the R-Car H3-N (R8A77951), it
> > requires the specific quirks and configuration defined in
> > `of_r8a7795_compatible` rather than the generic Gen3 data.
>
> But this backport maps it to the generic Gen3 data, so I'm wondering
> what the point of it is?

Nice catch!

Indeed, the upstream commit depends on commit 71b7597c63d2ddf6 ("mmc:
renesas_sdhi: Refactor renesas_sdhi_probe()") in v5.15.

For v5.10, I think you need to add a line

    { .soc_id = "r8a77e1", .revision = "ES3.*", .data =
&sdhi_quirks_bad_taps2367 },

to sdhi_quirks_match[] in drivers/mmc/host/renesas_sdhi_core.c instead.

> > --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > @@ -119,6 +119,7 @@ static const struct renesas_sdhi_of_data
> >  static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
> >       { .compatible = "renesas,sdhi-r7s9210", .data = &of_rza2_compatible, },
> >       { .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
> > +     { .compatible = "renesas,sdhi-r8a774e1", .data = &of_rcar_gen3_compatible, },
> >       { .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
> >       { .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
> >       { .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },


Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
