Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBDA25C804
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789431586; cv=pass; b=McJk0+lfEwIs8HYLWFc7Em1JpMz7IsZAtBSIN3ZfqSj7oUbxct4FZ+dzKYWFIxqQWJ8GyQ57f9h9u6jqEBiGUEwPxIaistCY1a2RnQPmYp32YG2tzcWR6qzCjsfQAyXzJVSFMRLEbOcmCf0rhJF7r9dLHXXj6681zZCYFOU85Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789431586; c=relaxed/simple;
	bh=EdKInOD+E6jqh6viJs2EtgOk8z4C7E9EBNp/xGdSPnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRcRL6aajMIgvSvhHwwPTpO6IknxwEKe1cJz2GNdeikmrtw/oZncNFut4auHsJUUEM9lBJe9bYYbAx4fU4KQGpBvjwtVe5Y2lCnbXTWoGw5agvylS7StbvHNSjmH18IwEVhPXJjvV9KV+8tZ7gSw4er9Mcfwuumt3+vD4QoMT6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs0lTwvi; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs0lTwvi"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c29667ed561so490205666b.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 17:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789431583; cv=none;
        d=google.com; s=arc-20260327;
        b=MVSinqgEAZiEKwlEqR6vYaIrUwJYCIMMRbJ+NozlJe2OmEfNxgFuqoHWSM9s9CL2oU
         Z62DUZ/Az+dr8zHKwYEBZfO4QCxPAdp+IxW5twH5eUXiWPBGlFpX2tSI48+Ur6zxxYgi
         U2VJSuIxocLwg9asI7hLm+D259buflJWaPc517dNYqJC6DwX6lqp6Gf56/GmwF9XuB/2
         JOp7ahbziuSekZvgR3jeRsub0UOufKDTWqRZkAkTsdK17JW4e28UuLAZHBpbFunO7+Oz
         CcjKGyp2GJNeHoIhPaoU5ufiUa34zw1iL//IjlxYvchCFIgA/LM3bEJ3cpdIV3V5qoiQ
         o6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fhSnpJaF0zIlzRRxfxVLp3csW4mX+RohYNQStTeeaVI=;
        fh=2DPzUgFl/YQraR+xz6ylxt7DYiE42EX/RoVCVHw/oJ0=;
        b=QuXQUvhLc3vKf+ib0DbmULs+aypm7Lj3ieUJxUcGi/UFiNt6LWUVkb5dbpqBF6T/7z
         Na006Eszj/DIzN8iF8MKdDEWbj/BfzlevgiRPPP4FDtv21g403ku3qclOj9/zuXCPz8x
         +OYgjci7neD5xd0XGPBi4prD3dNy95E8VCzrWnXv6xyyjHDPCfnY+YC+jLauNHrkUg3d
         s4VZTVsVEW7ggroXkylvT7ICf4H8QiWOJwMcE4z5SYl/yOAkkqqRAp5dYpNxszdSMePW
         ub3HlHjRBgCKVFaL/TAs89LDyxv9VuqtNi+mOEYu7B7YDQKWSlyj07pzr0eFDhds4sjU
         6GOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789431583; x=1790036383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fhSnpJaF0zIlzRRxfxVLp3csW4mX+RohYNQStTeeaVI=;
        b=bs0lTwviMi/7oiOjjHHoDId/9KLD2tEHe6j+XUdo3m5DIgyWvZtShT05Ahhc9p1l8o
         Tnn/Bg6YASjpgK9l472Ez4jT6SEAsOZkIy7fFsvimRYjr1dqB/ud/z8w+vZpc7ZwkbH7
         YjcrS6y16fBvkEMbwdV6tPraAbRXPFb2pMA6W4y6tT7bwNMSFrSO7eaj0IHQGm8XKP6h
         S8Lhg0vPMx80Z+AxKNtTzi0LkWTOaj1dJnJyxEsExODbSScEDyUm/VIpC9zaA5DKGGFi
         GdDbEOQKDrFmhfl32TVvBUEZmo3Pv9/K9LjLJZOPKhTjYflHgC5j//88rCG2pHMzacx4
         aJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789431583; x=1790036383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhSnpJaF0zIlzRRxfxVLp3csW4mX+RohYNQStTeeaVI=;
        b=T8QeQhvvQxTbDi5NWpSWiHdu1nKFMf464E50p2k9KUXPwKDDJNUZjjBtp5QkNp1J6o
         BUaAIW/XD0Sc0sHlqhR8LyD6E2dJ2rpOdExZ5D7lk5EusiXFRlq9vV9fsenHGOQhTkNq
         u3M5cWcgPNGofNhI3Y1zbV9gmrwdqmaFo7ELDuUC33gUmy2s40+RbVouF62WrW4qhRXA
         zyaXfIu1+8FC4h8tvmHN+pUmH2ArA9dPUCcS2T0E7a4KqfcUybPJpxEzEFUALxDJTOcM
         k8AQ6ptKQw/IFwtmmiQIXcLGLCKj2And3InXDtOZM1V9YIFmapkdUncE099ZlzlcxSm/
         MStA==
X-Forwarded-Encrypted: i=1; AKwUvBwZsyrvy309kStl3ARDDEUYqNNNDEUs08ipgHDpEUB+JAJdU/DsTE4GnzZRo5VloHBOpb8X/hE=@vger.kernel.org
X-Gm-Message-State: AFuF++n10SS/m3oihv7ATI5qh8i5yJoj771w4ekcCcY9ShKDhfOPLk86
	M3f4Td5XqPambPbRDoDWQ11FzDB+Ors6OgbevVgyxAKCIoOUIQckHA+rP1WbmLpJMqsRkicW1VD
	aQJKY7htSRVeiKzmDQPgq2vVaK03MKk4=
X-Gm-Gg: AYBFou3aw4E8UyJe5tOt+VDeGo9jGEbQxB/Sv5QwPBzWWhYGe7F5Xawq/H7Cj2h2fin
	WDXx0RbU+6HDGQwGxRXT1paZW/r2aI32Bnv1UHrAqsDPcakrWeTquJaxe+Rj0KvzvJseRvi+jJw
	IgXqeZC2UI+awRL6c/Tdm36u8nwNN162Vp9NAgrbZtnLWF4dVtmEpRJ7DT6+D+66D/m0MJmBfBX
	25JdBLXo2tfdz23meqFfF/EF629YrWCfYkvh9Eqzp07L6mmYDfDR6ELtTE9LGNYFprUsXjLnPkd
	6jdmRysnGlBpSAAcSzs56IGxTcOzy1b6+/fHi4f/qjLOD8aG26OEcZJjlxxMoO64HnkK30ity9M
	jCjMz9oK7HiNRbKC7uSd+nBTlCCecto8Ye3LOPf6v7Fmz586sf7sxftbaB0FzK/NnVAam4ttVVE
	IMKSHnJhmTIQwfDC44/F0VGnMKAmHAy91ZoCGetkQBXhW9Wp+aacs41bRekQ6q/NQDXQ==
X-Received: by 2002:a17:907:7245:b0:c29:566f:531c with SMTP id
 a640c23a62f3a-c29b870633dmr347632066b.31.1789431583089; Mon, 14 Sep 2026
 17:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914214720.2467586-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260914214720.2467586-1-donggeunyoo.kernel@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 14 Sep 2026 17:19:31 -0700
X-Gm-Features: AcwNN1U5EfGdgTc1xsFDmc6062Wi3vW51HrhRuGo76kBeV0qilCmtX4PEonDaJg
Message-ID: <CAKxU2N-h7ooJ8BOhFz2HqaxJfAs6=9W4oEef_9C11kNMcm61qA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phy: qca808x: handle the active-high LED
 polarity mode
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>, 
	Christian Marangi <ansuelsmth@gmail.com>, Sashiko <sashiko-bot@kernel.org>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 2:47=E2=80=AFPM Donggeun Yoo
<donggeunyoo.kernel@gmail.com> wrote:
>
> Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
> LEDs") added PHY_LED_ACTIVE_HIGH but did not cover qca808x, so
> qca808x_led_polarity_set() returns -EINVAL for it. phy_probe() propagates
> that, leaving the mdio device unbound and phy_attach_direct() falling bac=
k
> to the genphy driver.
>
> Accepting the mode alone is not enough: led_polarity_mode records
> active_low, so an explicit 'active-high' node stores 0, while
> qca808x_config_init() re-asserts QCA808X_LED_ACTIVE_HIGH only for -1. The
> bit does not survive the reset phy_init_hw() runs first, so the LED would
> come up active-low.
>
> An 'active-low' node needs nothing here: the bit is clear after the reset=
,
> which is the polarity it asks for.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026090810595=
9.70453-1-donggeunyoo.kernel%40gmail.com
> Cc: stable@vger.kernel.org
> Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LE=
Ds")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> Assisted-by: Claude:claude-fable-5 sparse
> ---
> v2:
>   - No code change.  Rebased onto net/main.
>   - Cc Rosen Penev and Christian Marangi, per Andrew Lunn -- they may hav=
e
>     QCA808x hardware.

In my case, qca8k controls the LEDs. I don't think I have any devices
that control LEDs through qca808x.

>     Christian wrote f203c8c77c76 ("net: phy: qcom:
>     qca808x: default to LED active High if not set"), the default this
>     patch extends.  If either of you can put an 'active-high' LED node on
>     a QCA8081 and confirm the LED comes up the right way round, I would
>     appreciate it.
>   - Say why an 'active-low' node needs nothing in qca808x_config_init().
> v1: https://lore.kernel.org/netdev/20260912012819.2072067-1-donggeunyoo.k=
ernel@gmail.com/
>   - Supersedes [PATCH net v3 3/3],
>     20260908105959.70453-4-donggeunyoo.kernel@gmail.com, whose
>     Reviewed-by from Andrew Lunn is dropped: that version only accepted
>     the mode, this one also makes it survive the reset.
>
> Compile-tested only (W=3D1, sparse).  I have no QCA808x hardware, and the=
re is
> no KUnit suite or MDIO mock under drivers/net/phy to exercise the MMD7 wr=
ite
> without it.
>
>  drivers/net/phy/qcom/qca808x.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808=
x.c
> index 8eb51b1a006c..68fd4d0fe31b 100644
> --- a/drivers/net/phy/qcom/qca808x.c
> +++ b/drivers/net/phy/qcom/qca808x.c
> @@ -200,8 +200,8 @@ static int qca808x_config_init(struct phy_device *phy=
dev)
>         struct qca808x_priv *priv =3D phydev->priv;
>         int ret;
>
> -       /* Default to LED Active High if active-low not in DT */
> -       if (priv->led_polarity_mode =3D=3D -1) {
> +       /* Set LED Active High unless active-low was requested in DT */
> +       if (priv->led_polarity_mode !=3D 1) {
>                 ret =3D phy_set_bits_mmd(phydev, MDIO_MMD_AN,
>                                        QCA808X_MMD7_LED_POLARITY_CTRL,
>                                        QCA808X_LED_ACTIVE_HIGH);
> @@ -603,6 +603,9 @@ static int qca808x_led_polarity_set(struct phy_device=
 *phydev, int index,
>                 case PHY_LED_ACTIVE_LOW:
>                         active_low =3D true;
>                         break;
> +               case PHY_LED_ACTIVE_HIGH:
> +                       active_low =3D false;
> +                       break;
>                 default:
>                         return -EINVAL;
>                 }
>
> base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
> --
> 2.53.0
>
