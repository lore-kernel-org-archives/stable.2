Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298991448E0
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783902650; cv=pass; b=tJyKbw5bCBbQdw5cdRSuKvzdHHEbIyycmiZjFykBe4rq6Sr4BN4Nes18MlpVL6yzRVYT5gFdVuP2gV1iCwm4sUMfr9zl1sNsxDmJEIUvsj4EUgsT/RVsHMYsB74IqS3nwvE9EZeYC4NvkmXWEe1FPFqJt7uICnigyobC28kHc48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783902650; c=relaxed/simple;
	bh=YclTtfQFm4H1iD4uxqndR27sxUZLguekuKgacTyMg9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5fSsEGwTd2j7fffp+qn8nSia0E4nXnyQarmHC1iVnjbPnl7BtYzumqpvwaNlw8h2qAiFkxTNnY0O/lmSw9f5NCUKrK2p9qFMnzR/fiTgoN2ZOR0sPzJ42xUddOhnLTU/DhKRUDek8QVLmw6EkEq58KdIwXYLOyEIoXA32dXfnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8LEdPTb; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8LEdPTb"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so3193722a12.2
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 17:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783902647; cv=none;
        d=google.com; s=arc-20260327;
        b=PjtYyaQoRScHdYksGF4//Rvpl8ck89F3Mw6aDRMUg4cBYUqIhZXV8IeCrKtIPByPM0
         A+lSirhQhp091kXgMDEiDl3UjCZhhTvFKAC6nMBg+ouN9C99msedAMcre6OZcgvLPNmz
         ErIpNMFyixB9lTAfMS7Ljjwj3Rif1c+dTF4vrq99sRt8Anv1HzboYVFX6yoBLigjVqf3
         2yAUC1Jq1jrpt66iv0jxkXu7FE63aNl6REEmYlvxSoKiSAomg9OjgDLAhJpXUIJYkPRi
         c2THLMPJXWGPzbJLLXD9365kH9n1T6UCCShMAOjRbRv/b6sSRSONqbexDmfyoqVT7bRo
         qwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H1mj9b4CfdzykEisbey5ZMpUh/K36ETmETj2T8bst0g=;
        fh=jy9rJuXGotaG0wg7jB1B178Hu2R7b0ar13cwy0nrpX8=;
        b=PdwJpTL42/lyWol1k53g6P1gBjw1h8lRo01jyB2GP/4WIj5kZZueNVuqEjQkIBqo59
         1cBBH/vBzY6W6gLUq4hDUmxlWqnFm9alhC0GRdFO4mGuE2RaePmKtqN+qZqhEilyZi0K
         DQ3iDVuOTK47qfW0YSdPJ1SU4P3zQ9NwRfv2z4eFldTNnwdp5sxFJDAZ7j+MypnSmyX+
         278J7iNw/kEJOm/AydYvZMV6VS8ItUk8ig3OcoqyqAW9iKV/o0CH5ocEGYHlTdqE+omq
         dMuIZzUDCHFr98KEaK/vqpTTsZBd5sHuwdXTgFqCV6ktEXKQkoZfsZWofJLpgZV8lljJ
         w6/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783902647; x=1784507447; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1mj9b4CfdzykEisbey5ZMpUh/K36ETmETj2T8bst0g=;
        b=M8LEdPTbRS/OXPBvZOggTr+J5+1aRxJZiay8Cuj8amZrzodqm79TudUmvnRD4SC3Eu
         pQ+Frv59YE7BDPcKoQ4hC+/FsPq0j2sYS/J27Jnq5K3ZcDX/zwgQGn4iVHMZnlgeCVDX
         Saw0y823/SjyiLufMBZ1MefJwwZMFDJQRL05taZzeBAyl40r1zVwno0sk02c2u/oQvOU
         1nQT8Z3+7etMWkfIhnohZE/4KaiTmo+yXQCsouGFeb6v+EBbD2/Uv6uS5S4r3AclEyPw
         F66/jy+qh30Pe/Vrpnk7f9cJ+44HIG1Najf3ehRRLd9t04kVydfb1Jy7+wfYD3fuVu2z
         eILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783902647; x=1784507447;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H1mj9b4CfdzykEisbey5ZMpUh/K36ETmETj2T8bst0g=;
        b=Eju+CB63jXI1yxpeSY7rcXJJYAYm2m/81I1k4NyYZLHac1R3+3ENQTaf9ZoS4GeSW+
         CJMxLUy3xwLF1HC1hg2UnncyV8bYENuUTB5D23glcDUM5wu+fLXv+XX0rGD0JExAd12h
         N575UwiFbzyPXPsgUJQBGF5FGsDt+D1OpUhh7gmUCLyC+Po7UFCu0HeZrnkhakodVU+k
         g7ooQzfZlWpQ8aI9gn4tC1pDncNRhh/kdjOHz1liU0GVZetvYpiMhWUw3IRfCUuxMphE
         /t/d3XsCEffQg4fEdr0jPFRs3xv+fyZfLjxXs6r5q7BdGuPtfnbrI+s/jigDDj0P/EmV
         BxSw==
X-Forwarded-Encrypted: i=1; AHgh+RrWNOSifNG0DSJeYEiEJ1gscyBX4qsg8U3wKX5O5PC3fXiv8QCqvwDC1//C7QClGSlYLMuHniw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5J9AOqg2eXmjbi2vubCS+PSe5ZLdZ00CoYvIE96rZi3rHopo
	yC6A8MVBO5FNxJdBT2VbQpK7KhbG4CxrP4ylUkyST41GN7qrIZaPOoUhkPw423qidQk3VnJuXq3
	+GtXWukRIh2c5x+3t+m6tt8hhM4MIgEk=
X-Gm-Gg: AfdE7cnpQv+8FFxvtzvrkR0AEn5v6F/6a96WpsoBSlIIRDJ4dltoNuIbmOxaqN8XZ2C
	p8TLdBMk+Biu1riPNAbHSXnt6Jw7afJuyww1WRRUZrJlaX0iq54dAj+6e//qh27EfY/1WgIvGG3
	tz4dy0GoHHIPQWyT3xPV2ZT4MbXJ+7aCB9ELW5itT8QPJ3InEU+P+dIvejHOux6hY6iV55cwOz9
	ZhcpLs60DSdHDw1I6nVVeUPH8LaQgOI42gpAmv1RCS86wAs6sM1THjh/lGsY1pizr59JtwOdQYf
	ZWjoIkoexvOnjd29xZX1EtHe7s9QjA+c3YV3
X-Received: by 2002:a17:906:9fcd:b0:c16:1ba4:f29 with SMTP id
 a640c23a62f3a-c161f36dfbfmr309609866b.44.1783902647332; Sun, 12 Jul 2026
 17:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709095006.3683940-1-prashanthkumar.k.r@amd.com> <CAEg67Gk9zaFd1KZaffy04VgrRb86TnpDfBtH4Z_jkqQG9bOPcQ@mail.gmail.com>
In-Reply-To: <CAEg67Gk9zaFd1KZaffy04VgrRb86TnpDfBtH4Z_jkqQG9bOPcQ@mail.gmail.com>
From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Date: Mon, 13 Jul 2026 10:30:34 +1000
X-Gm-Features: AUfX_mxHECNWwBLID2eoScv-gzgYAWynjbBG9LVZ9SmcPopMhhk_wrYgKF60Be8
Message-ID: <CAEg67GmDHqtDvV_E_=WkJdZsn+Q=afyf76j726m1iP=Y1qG-aQ@mail.gmail.com>
Subject: Re: [PATCH net] amd-xgbe: fix MAC_AUTO_SW handling in CL37 AN
To: Prashanth Kumar KR <prashanthkumar.k.r@amd.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jul 2026 at 09:16, Patrick Oppenlander
<patrick.oppenlander@gmail.com> wrote:
>
> Hi Prashanth,
>
> thank you for addressing the bug. I will test your patch on our
> hardware next week.

Tested working on 7.0.1 with your patch applied. Thank you.

Patrick

> On Thu, 9 Jul 2026 at 19:50, Prashanth Kumar KR
> <prashanthkumar.k.r@amd.com> wrote:
> >
> > From: Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>
> >
> > MAC_AUTO_SW (VR_MII_DIG_CTRL1 bit 9) enables automatic XPCS speed
> > mode switching after CL37 auto-negotiation and is only meaningful in
> > SGMII MAC mode. The original code unconditionally set this bit on
> > every call to xgbe_an37_set(), including when called from
> > xgbe_an37_disable() with enable=false. This left MAC_AUTO_SW=1 after
> > AN was disabled, causing the XPCS to autonomously switch speed from
> > stale AN state during subsequent mode changes, breaking SGMII speed
> > negotiation on 1G copper SFP modules.
>
> In my testing this was breaking negotiation for all 1G SFP modules,
> not just copper modules.
>
> Patrick
>
> > Fixes: 42fd432fe6d3 ("amd-xgbe: align CL37 AN sequence as per databook")
> > Reported-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
> > Link: https://lore.kernel.org/netdev/CAEg67GmFS0Q4oSZkz8zWdOzckSth9_vBPiOy6a7-d697C2w2Xg@mail.gmail.com
> > Signed-off-by: Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>

Tested-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>

> > ---
> >  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> > index fa0df6181207..12770af031eb 100644
> > --- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> > +++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> > @@ -267,9 +267,14 @@ static void xgbe_an37_set(struct xgbe_prv_data *pdata, bool enable,
> >
> >         XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_CTRL1, reg);
> >
> > -       reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
> > -       reg |= XGBE_VEND2_MAC_AUTO_SW;
> > -       XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
> > +       if (pdata->an_mode == XGBE_AN_MODE_CL37_SGMII) {
> > +               reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
> > +               if (enable)
> > +                       reg |= XGBE_VEND2_MAC_AUTO_SW;
> > +               else
> > +                       reg &= ~XGBE_VEND2_MAC_AUTO_SW;
> > +               XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
> > +       }
> >  }
> >
> >  static void xgbe_an37_restart(struct xgbe_prv_data *pdata)
> > --
> > 2.34.1
> >
