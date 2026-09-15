Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C984252D5
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511560; cv=none; b=GVa7//E4k92czgLAZ+rQNuB8IuGtp0wGAUDUy29h1x7rV6vHsfI1m1LPpoUXWHFA52i7Hfy3GE/YsdwoB2I/og+A7D2OCCPrtMPPySBBO2B6XEfa4JBdBlIH5AmARN85wCuIVBhK4K8ta0Ru25i16BvxdFm+hcoXYnolZQatxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511560; c=relaxed/simple;
	bh=GzTLop++KI4rIrrgZnzAuT0dfgzVAoCkRLISOpHLns4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxhvYSfnIgKMxW37lmvKE9wmQOsmbYbHsBUcJ0VFZwPKPmwP0jQWYdkj7WX6RR0FmOOW3Pkoixvy28piirhkiG7brhpXnHwPuR0U4W+m1Zw2j1GtEEvqPG5O9JtfjhdL6em6q2P5pGVPEgsDKc8oc6jL0Lm6Kqp5itCaBxSN8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFYifaDW; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFYifaDW"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f7so2123455ad.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 15:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789511558; x=1790116358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oAaufJPLhvNq8yuCsSv2xM1qq27Ru9xLaw02eoo87UA=;
        b=iFYifaDW9E9swlgMsLswBzibolQ2SmndVeltmZO+lqYTeM9vWXIWTE7bHvlPA+uDZX
         FY+WaB5CA0txY+Ip2qH7951N3mPVw0aiuXOPc/6EmCVaY2vk3Ohcf8He8po9L2KHLcvw
         sqUaQP8qdLcmyXeQ8OizDh3cEMT32nxE5b2Ro76Ep0qAQX6jNmZSJi7g5D6AD13BWnaI
         3gKqPubrswh01gZHxFhZrn+5P3yYimVprqd+lEYXqYhBZh/fHsRO9+tsy19d1vyXC0qp
         iH8MpnAEEkGABxaLrOTbzbLjL35Kwz3033koXIfCkhAEgnS169Ne8GoqGQkJ6aIpxO63
         DORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511558; x=1790116358;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oAaufJPLhvNq8yuCsSv2xM1qq27Ru9xLaw02eoo87UA=;
        b=BoNgI0nHMeSdy6dlv6AQpUXS/q8KWl7VVazYKAmtET+lReUDsKh86rBeD5q+DuO9rF
         Q3Q5bVyZ6pKhVDxdiV2I/bpjiOkEsHF8KtFgD73IZMkAgxDRqnN6rHozoNGnqq6ZVIUq
         69e5RTM2xIHJHQExOpg8IOuUL1mqfZPsRZ3c1CxRxAcrEJ24ujdCRwLoS2xLiBF6Roi/
         vb/i21vI6dp8q6/JBClDwo3EFi81C22HTDgqLKPjB3zTb7pcMSTXmpAMMtxUGSBvyL4W
         JMuEmu8A+eWAZsPr1dSzNCPadkvzrxTgx6KCVm8CYBI23dJmiOMG1Oz4u5gSH1LAw8+b
         pdqw==
X-Forwarded-Encrypted: i=1; AKwUvBwIL4tFeS+AZhsBaWi1zq9bfZcxASuvEixQ/MA/sq8gRA38nt2IINqM0g9PvWgtJprailodGDI=@vger.kernel.org
X-Gm-Message-State: AFuF++lMUIjRfMsL5kub5aPXo/w2HhBN7ehlLUnsWBxINPsjTsianjkW
	XMJIjFr3iGd8of7b/7AsxJvYmEVQoGdoCMsP2Mh9qVo3eD6lITLAHoE=
X-Gm-Gg: AYBFou3FU25B155QasIjPelloRyb5jqngP7ubBE2TjQJR7myWdLGNoz3zNuBvLkYmQn
	HBTtdhdHIa2r3AhegdvvSN+yqjHBmv7Q2JAhp9aobt2uET4QEXGbe6/8b+JZ+azsQ5xLNcMsZMX
	KtL0rUBmnAPJUPlZiHhEOu7ASwjE1+vxbbFXaUKL+yXXg3/KTTwj6Vspu4ArUfeGnYkL1rxLAQs
	VXPsGJk+TIvZ1+pL9wAox7bfuJE0GTvBY6f+TTgk5Ts6xzJgjfYi8/RxoSTkd/XUAgG7kIGMBJv
	rc8S2B5/rrDWE68P2Ahjkj7FS3/NX1GRQz1jsPpFURnPo4LUcb5jPugVRgfscoy2soz6U4H3F3q
	P04rS3jyi6nSUKD2EtayuQsfASq3SCFYFPsa8ENqHNtFr8nsX6czwsBiWD0gLUT0/Mar8ngkNVS
	6/VgPDXgIUNtgL+VttLIJk5U41eHsyYqK5UnWAm4aaMwXlD6FJIbu54Ds1kacPSNmBqI3eaC+6t
	jR20ryfLm87ELeCOHFxjkeIKA==
X-Received: by 2002:a17:902:d552:b0:2d6:df31:5bd0 with SMTP id d9443c01a7336-2dd8e40117dmr5012515ad.10.1789511558421;
        Tue, 15 Sep 2026 15:32:38 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:556:537c:f7cd:8a1b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89e9345dsm1900175ad.24.2026.09.15.15.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 15:32:37 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Rosen Penev <rosenp@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: Re: [PATCH net v2] net: phy: qca808x: handle the active-high LED polarity mode
Date: Wed, 16 Sep 2026 07:32:30 +0900
Message-ID: <20260915223230.321441-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CA+_ehUwT_RYztjGJ0P_czx++wxNShT3Zv3JhjQ_eBbaoGQoNRA@mail.gmail.com>
References: <20260914214720.2467586-1-donggeunyoo.kernel@gmail.com> <CA+_ehUwT_RYztjGJ0P_czx++wxNShT3Zv3JhjQ_eBbaoGQoNRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Tue, Sep 15, 2026 at 12:25:54PM +0200, Christian Marangi (Ansuel) wrote:
> The commit description looks a bit "dense" and took me well 2-3 minutes to
> parse the english and understand the change. Was also the commit description
> assisted by LLM?

Yes, drafted with AI help - that is what the Assisted-by: trailer records -
and reviewed carefully before sending. Which part cost you the most to get
through? I would rather fix that than guess at it.

> > -       /* Default to LED Active High if active-low not in DT */
> > +       /* Set LED Active High unless active-low was requested in DT */
>
> Why the comment was changed if it does say exactly the same thing?

Because after this patch it no longer does. Until now that branch ran only
when DT said nothing about polarity, so "Default to" was exact. It now also
runs when DT asks for active-high explicitly, and there the driver is
following an instruction rather than applying a default.

> This change is O.K but I would ask you to better clarify this. -1, 0 and 1
> is very confusing here.
>
> I would introduce a simple define like
> #define QCA808X_PHY_LED_UNSET -1
>
> And set this in probe and change the condition here to directly check
> for the macro PHY_LED_ACTIVE_LOW.

Done in v3. The >= 0 test in qca808x_led_polarity_set() took the define
too.

> The only problem is that I feel it would be better to split this patch in 2
> different commits.
>
> This really addresses 2 different problems and splitting also makes the commit
> description easier to understand.
>
> One doesn't account the case where phy is reset, the other doesn't account
> the mode in led_polarity set.

Agreed, and v3 is split that way:

  1/2 qca808x_led_polarity_set(): accept PHY_LED_ACTIVE_HIGH, so the PHY
      binds at all.
  2/2 qca808x_config_init(): re-assert the bit for an explicit
      active-high, carrying QCA808X_PHY_LED_UNSET and the comment.

Both Fixes: a274465cc3be and Cc: stable, so they backport together. After
1/2 alone an 'active-high' node binds and the LED comes up active-low,
which is still ahead of today, where led_polarity_set() returns -EINVAL,
phy_probe() fails and the PHY falls back to genphy.

It is no longer compile-tested only. I put a synthetic MDIO bus behind
phylib that answers as a QCA8081 and emulates MMD7 0x901a, with the reset
clearing BIT(6) as your f203c8c77c76 describes, and ran the same harness
over all three arms:

  DT node            base      1/2 only   1/2 + 2/2
  active-high        -EINVAL   inverted   correct
  active-low         correct   correct    correct
  no polarity node   correct   correct    correct
  high-impedance     -EINVAL   -EINVAL    -EINVAL

The middle column is the reason the second patch exists. A confirmation on
a real QCA8081 would still be worth more than an emulated register, if you
have one to hand.

v3: https://lore.kernel.org/netdev/20260915223138.321307-1-donggeunyoo.kernel@gmail.com/

Thanks for the review.
