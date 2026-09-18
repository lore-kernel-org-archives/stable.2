Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1422E7386
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720763; cv=none; b=IXQ2KBu9IV5/pnH3omZ1iyKj5A6GDITXWCcCTYPpVAaikndkvSW+2Cscx22f66Of1JS7cOipdAFG560gEavKopu99QcUP+mgP0wJsXEk9ICV00iYo7Br8ip+bV4WGmVeEhj+hDvSoY6I9LqZMGhUXFNQLNF16vDIVXFE6QaWXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720763; c=relaxed/simple;
	bh=zsMpUP/mg9BVSWDGNZRyk0AJH29HIpIfT4obPwwxJ+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwxQ62Gk++zUYcmVocdMkq5lrI6m2FUMAUI8JjEXRGsvr9g/T7vg2XKZCh3JTnDL41+wikRhcPR5MrAbnC+Pi7sYdK+/40TEiZEqehd4A1pQVpsVuWBd1lkzXOHHdIZbkPtSj/U+e3zewBL7StmO3FkMmzoVgd8mIwTFaybIBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBDcD3hf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBDcD3hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38121F008A2
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 08:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720760;
	bh=zsMpUP/mg9BVSWDGNZRyk0AJH29HIpIfT4obPwwxJ+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hBDcD3hfiwvSH57FClY99ov2uc4BAeIAoOmmD2zOXzFCR0M4z+qOD98GWdYuYYrMI
	 ZlW+cLUQggo56owN75M0ZZEJUEjc+1nwR3j65kZsHjH0V+Vf69TGYm9ruxiOhYUG06
	 QgoprMRxnA2g/Ovb0azBbLYJPo38VAp92yjkztYD3slIyu5KMzhFfwyg4HZXA3hK6d
	 Hw0xSkWsfgc9Adf0cLhJ4/lfMfVCgHASlMyUvMU5hcsXSoif+gG90W9EEpvauDPmNi
	 KU0PElLaB6qST6dYaNq1kJAxJ3XB7IMAi1NqWyclZbRtJtLq9f3ZI54/pkf1vRWQs4
	 Zw+XHMZYHfREA==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b74d0133e0so437778e87.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:39:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwfPVrfkq3vSqVpHGvBd+bMoe/rxdMbc1rnWUt83cWXSQ2TUea+U/Dsg466ck2DXwHFWxnAy5I=@vger.kernel.org
X-Gm-Message-State: AFuF++ngjS9ZdubIl60bu/7VLNdy+oS16pYZlDlALVtOiIEsSS+Ve4fU
	xOpPxY99KQ9w4nejDFP2SmwLTlNfDRQ9ylNlxx/NHO2vOduWjBt/zpkjJTGx0Ln8/kGlBtnmaSf
	riTZhG6pCQUXgLTXT0dZC2JSAElZvS6g=
X-Received: by 2002:a05:6512:3d14:b0:5b0:82d:e90e with SMTP id
 2adb3069b0e04-5b8c18429c1mr465853e87.19.1789720759430; Fri, 18 Sep 2026
 01:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917104920.2147568-1-vulab@iscas.ac.cn> <CAD++jLn8zuuBQKXTp_-Z9An2Qb-axBet5jwtyp+iecyUR_c0Og@mail.gmail.com>
 <26e9c43d-74a8-4d70-ba71-f50c2ac77e65@lunn.ch>
In-Reply-To: <26e9c43d-74a8-4d70-ba71-f50c2ac77e65@lunn.ch>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 18 Sep 2026 10:39:06 +0200
X-Gmail-Original-Message-ID: <CAD++jLn11d+t7i6dpz5NnpiKwJKywOoqLbb86tEbpqdOvuqQ9g@mail.gmail.com>
X-Gm-Features: AcwNN1XU7qBGncguGdfMfitY6zlKnJQaSupT-LXWndyDgyt4fGLUsBEs1OwT8NI
Message-ID: <CAD++jLn11d+t7i6dpz5NnpiKwJKywOoqLbb86tEbpqdOvuqQ9g@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: vitesse-vsc73xx: Fix SPI device reference leak
 in vsc73xx_spi_probe()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wentao Liang <vulab@iscas.ac.cn>, davem@davemloft.net, edumazet@google.com, 
	f.fainelli@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com, 
	paweldembicki@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 3:53=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Sep 18, 2026 at 12:22:12AM +0200, Linus Walleij wrote:
> > On Thu, Sep 17, 2026 at 12:49=E2=80=AFPM Wentao Liang <vulab@iscas.ac.c=
n> wrote:
> >
> > > spi_dev_get() takes a reference on the SPI device, but neither the
> > > probe error paths nor vsc73xx_spi_remove() ever release it, so the
> > > spi_device can never be freed after the driver has been unbound.
> > >
> > > Release the reference on both probe error paths and in remove().
> > >
> > > Fixes: 95711cd5f0b4 ("net: dsa: vsc73xx: Split vsc73xx driver")
> > > Cc: stable@vger.kernel.org
> >
> > I think we don't set this on networking patches, the network maintainer
> > decides himself what is stable material.
>
> That was true when DaveM did all the Maintainer work. But it is no
> longer true. Please follow the normal stable rules.

Aha! I didn't know that.

Thanks Andrew.

Yours,
Linus Walleij
