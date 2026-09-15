Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABA8003D
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467969; cv=pass; b=WkcH50HLu3OI58uFs1Vd5kZv7Iop0m9+7bwSEHfpulEvUjqWGkVS05+VDqlGD5MYOqDia3zUmVWm/YWi8mrVEc601L3zz5z9YrZG5t34zsQJyC5I+wMp4pdcsBJsnGK76Vkq3b//xVbDHwgW/RDLZ9MWK8nvC0gOrPlNvhkyU0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467969; c=relaxed/simple;
	bh=JBUy+nz8yoNC+BZ+++kswfX4CT9SuhGl69xtoGeYccI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtjnyiWMurxFbz5WCQnYiX5lud7xVC8rJxB3zlzOPfv6YhPZmO8HQ6uZ8frAUlSPvnxiefXciP6T3Ak5tWJN7lFNT8EQZ3IcRhnhTMz01CRVmcqz1cwre6CLJZvMPAxe81ywcZPL6znBFrYwoHfPNhCILVF7Me5UhDeccsLcqWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDeeb4TT; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDeeb4TT"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd148aso33513526d6.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 03:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789467966; cv=none;
        d=google.com; s=arc-20260327;
        b=lEdzJ6j0x/ownDs+eyEqaU8bQdZp4DpeiSAjyeAO7WiKNMqX50XccNZSzC4wM1ikzE
         iymjEHfhcb/8Bvhs9DaTcykiTj7Bpm9eLqgM37Aua1QZ/fy4F1bmwxAaYZfsXJs4SeT4
         T8EGfSYyClpf5IxZVe5ImkLfh+6lkwRyK5yuhsjQrKW3j0FyhZWnd0gggC0SOtqrKhad
         xqq4RkuxaQ5D7ks+SDXT1y9X4455QyNa0MuEW7Ssts3EbT3sBj3dXQigywHFx3KG4wFZ
         uBfeVLGs1YKzxW0WtX+ZVD5U7GSJ/qPW4fGepJaubSGl1o5YaGY3pCEM6HbZ4wx9Y4lR
         u/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TmqZCDgFfpZ8cNrOODbC41NVyTbNreASHxYyKCFmeq0=;
        fh=zqh6/85++i8VnPNExWcoWtG0WNXQJibfcZAkU6M8BcE=;
        b=IgZWYhjwuxHPZveXlDEXMmRdWe3vf61D6ZTWeQmcm8iVRcxn+bMHQPPjorhfWmZnA6
         ajAZLG8LlaSB0YwG+N5K2qfyW9k2Hx/aPf9UkCAgbR4QorDFZqlA5spTLtu8/+AltyR8
         cwaK5PLnvgNvDEn3Ii4sgPVuhk40evr4355InaBV2UBCf0dTly7wL5Gc8EG2zM0gV0ZK
         f3L5hJBVncKMB6ToV1jWCkjAIT2/pHXTWgXbmEeBhEJ+c55PqO6p/98azHMaPX+ZiOQz
         gnU0Rxbi1rw4OnZx4TP9IVoo7GCf7B8p6c6//PJiD73xAQ8kSRleMBkKxpgRpicvyi0j
         Qnug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789467966; x=1790072766; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TmqZCDgFfpZ8cNrOODbC41NVyTbNreASHxYyKCFmeq0=;
        b=jDeeb4TTmliDBWyDkhBxUQ/XHnCS0QKZvC65IAMifHD4q1oUfOho/THOonXqg+p7Np
         E28VsyDwBPuuaXEMNwAjapDB3aXXSMW4FARVzt8v4mrVeefS8WU5DyrM5jVrb/JBWeIQ
         YhkDMevzzlb4lvWLj7kB5+jvZ87PRT0uM0iOhGxqzUsJ76Yrd3rUTfBuWMVWDE/ohj1Q
         v1pDp3ouiORLcie65UTh4msG/vEKed3cFtHOZx5vooM9gOQaOoBPLqlxU7mqvjF5sfff
         gkGYItt+qdsjr6aqvWpLNRFmQcJt9gFEn4P3T++YLHMMt9ULMT9DrsrHwp4U1aKEY5VO
         Grag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467966; x=1790072766;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TmqZCDgFfpZ8cNrOODbC41NVyTbNreASHxYyKCFmeq0=;
        b=cvQ0Frzu5gnHabknizxuskER9H99t3LkMinQOt10AO84FY8B2tp/w/TQG6/lKA1Oqe
         5udLDfxKm+h0dZNxnmft4f/FblFYJYriVnqLcg2AXFyzDKNcnPBySZwi2V3+Tt6WW3pr
         ApYAgwLYj6f11iB1bk3ZQ0GUNGUPYCozzJpe7u0vQjJ08A6lsW12v1rYpyOI/SHPJaS5
         WJL8NUwaYFVsruoXg+WRw307LzblaIeUNQs6Z3txVSTe5Df2LfwfWP7YcSGtAZMoiML+
         ap/qk2OZ6/iYdF6Q5qUqh0snJ5ScjQLb6jc7GTpFQkGnt1mEMEQVH2lOCj5XRXApfJRQ
         pBBg==
X-Forwarded-Encrypted: i=1; AKwUvBzcS9UHiTiguH44qlVKxVYe3kMGiE52swLbAbplQHm/jUxOnoVz0FWubxGO4yoUAqJ0Py1kZrE=@vger.kernel.org
X-Gm-Message-State: AFuF++mnlKE20ZcxjfPiJMJkbvgWr8c2XGdt37ZlvCaegh71JmA8uAMR
	gVCUZXdbi8Hsj+oGfdKN4f+HMM2A/0a1Wof2eD5a2AVH5FXUCD3dT0vr7/teyMAXlLrf5fQuFFo
	On+tl0z0OEiT0xuQT1ipU8HeBulpXAm8=
X-Gm-Gg: AYBFou2Q7hohvujGtZthfauvR0hDs7A34w/ZCzXWQ5gxiZ1KRTnCa2jme2N4tDgeR/O
	d1FBMq7se3ebSw9Jbfr3/9/LO92liotLweQpEYnUErfM41M29KVEIty/Di2uJyGCTTyOfI+jXzl
	MtYuSV49Wyw2hdBD5EUDbHXGYByeCpresC4Kn2ge5Syyp2dlP8968nnyoHUikH2C+zBGOUxHNt2
	crObxNS3IiPQ6u5gHu/iKDOk9A/1A6Q4dXldn/4ZV4j9Qp4i0od3hECjo7QBJHxS4//sVaZ8pt3
	FPU+nGqi1NJ4FU+E2PsWNPS2Ma6TgULRGYMml6p8+jafm62vCihTo/vd4VHZRrq7Moc=
X-Received: by 2002:a05:6214:6285:20b0:912:3162:523e with SMTP id
 6a1803df08f44-9123162551bmr69922176d6.8.1789467966144; Tue, 15 Sep 2026
 03:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914214720.2467586-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260914214720.2467586-1-donggeunyoo.kernel@gmail.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Tue, 15 Sep 2026 12:25:54 +0200
X-Gm-Features: AcwNN1U-3EGl1dwa2s6HBcl5buSVBgdBb0MTb6m6SgGCBXYkYsN7vkg0bISTlEY
Message-ID: <CA+_ehUwT_RYztjGJ0P_czx++wxNShT3Zv3JhjQ_eBbaoGQoNRA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phy: qca808x: handle the active-high LED
 polarity mode
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>, 
	Rosen Penev <rosenp@gmail.com>, Sashiko <sashiko-bot@kernel.org>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 14 set 2026 alle ore 23:47 Donggeun Yoo
<donggeunyoo.kernel@gmail.com> ha scritto:
>
> Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
> LEDs") added PHY_LED_ACTIVE_HIGH but did not cover qca808x, so
> qca808x_led_polarity_set() returns -EINVAL for it. phy_probe() propagates
> that, leaving the mdio device unbound and phy_attach_direct() falling back
> to the genphy driver.
>
> Accepting the mode alone is not enough: led_polarity_mode records
> active_low, so an explicit 'active-high' node stores 0, while
> qca808x_config_init() re-asserts QCA808X_LED_ACTIVE_HIGH only for -1. The
> bit does not survive the reset phy_init_hw() runs first, so the LED would
> come up active-low.
>
> An 'active-low' node needs nothing here: the bit is clear after the reset,
> which is the polarity it asks for.
>

The commit description looks a bit "dense" and took me well 2-3 minutes to
parse the english and understand the change. Was also the commit description
assisted by LLM?

Anyway more comments below for the patch.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908105959.70453-1-donggeunyoo.kernel%40gmail.com
> Cc: stable@vger.kernel.org
> Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> Assisted-by: Claude:claude-fable-5 sparse
> ---
> v2:
>   - No code change.  Rebased onto net/main.
>   - Cc Rosen Penev and Christian Marangi, per Andrew Lunn -- they may have
>     QCA808x hardware.  Christian wrote f203c8c77c76 ("net: phy: qcom:
>     qca808x: default to LED active High if not set"), the default this
>     patch extends.  If either of you can put an 'active-high' LED node on
>     a QCA8081 and confirm the LED comes up the right way round, I would
>     appreciate it.
>   - Say why an 'active-low' node needs nothing in qca808x_config_init().
> v1: https://lore.kernel.org/netdev/20260912012819.2072067-1-donggeunyoo.kernel@gmail.com/
>   - Supersedes [PATCH net v3 3/3],
>     20260908105959.70453-4-donggeunyoo.kernel@gmail.com, whose
>     Reviewed-by from Andrew Lunn is dropped: that version only accepted
>     the mode, this one also makes it survive the reset.
>
> Compile-tested only (W=1, sparse).  I have no QCA808x hardware, and there is
> no KUnit suite or MDIO mock under drivers/net/phy to exercise the MMD7 write
> without it.
>
>  drivers/net/phy/qcom/qca808x.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
> index 8eb51b1a006c..68fd4d0fe31b 100644
> --- a/drivers/net/phy/qcom/qca808x.c
> +++ b/drivers/net/phy/qcom/qca808x.c
> @@ -200,8 +200,8 @@ static int qca808x_config_init(struct phy_device *phydev)
>         struct qca808x_priv *priv = phydev->priv;
>         int ret;
>
> -       /* Default to LED Active High if active-low not in DT */
> -       if (priv->led_polarity_mode == -1) {
> +       /* Set LED Active High unless active-low was requested in DT */

Why the comment was changed if it does say exactly the same thing?

> +       if (priv->led_polarity_mode != 1) {

This change is O.K but I would ask you to better clarify this. -1, 0 and 1
is very confusing here.

I would introduce a simple define like
#define QCA808X_PHY_LED_UNSET -1

And set this in probe and change the condition here to directly check
for the macro PHY_LED_ACTIVE_LOW.

>                 ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN,
>                                        QCA808X_MMD7_LED_POLARITY_CTRL,
>                                        QCA808X_LED_ACTIVE_HIGH);
> @@ -603,6 +603,9 @@ static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
>                 case PHY_LED_ACTIVE_LOW:
>                         active_low = true;
>                         break;
> +               case PHY_LED_ACTIVE_HIGH:
> +                       active_low = false;
> +                       break;

The ACTIVE_HIGH wasn't a thing when this was introduced if I'm not wrong.
Anyway this change looks good. The only problem is that I feel it would be
better to split this patch in 2 different commits.

This really addresses 2 different problems and splitting also makes the commit
description easier to understand.

One doesn't account the case where phy is reset, the other doesn't account
the mode in led_polarity set.

>                 default:
>                         return -EINVAL;
>                 }
>
