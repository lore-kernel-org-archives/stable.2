Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794084082;
	b=iOMTZUD3UhjNEHtw0ed7mJ7lGUSzkAv1FJ2Y9HFAozjZvIQEl6Gli2G3MVWG4ERRLNwj
	 fiu7rEM3Nc3G8+6q3o6w+fcizVA7Nurg5d/YCQh/NplwlXq5jJgrtXs6+f7NRtAP7inTs
	 Zo8Zb9TnXZts1zdecqm6p94LrUnEHU7PFQR9mKp3IgMgQwQv5hcPGyIjn4POj8wu4umam
	 4/ATOgZmrMZSmznciO5PEFWeKw78Y1JWlMw/QFx5ywSSXrPkig8WTzZqPiFIUApCEjwSL
	 ttLX1fDUCuD/VMRL1Cop88Wh57soMo3GtT5FKMLWKv0PkrPx24EZ2fv/AvhYOj2jYyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794084082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=A3nE0Zc+c8FrcoVV463cyZzi2Tv0FGf+LyHH8XWcZQo=;
	b=sOS2hrX1bvPM7ey2aFB8jALp1hwIFRhx9Q3sBlWfl65JlJSW4I7N4pLxEZe0bg1zmWng
	 Rn42fe+HvpChV+fHLjV/xb7ujFd1lJXPC7g68u7pU1rASVXk0yRgUfkLKmnaPq+GNbdw9
	 RwDidO6IeFo+iCHl8Fgk5dXY2j7VXF6MfEVx2iWiF1+IhtWgfgy7W3vg9Hq7tPj8/NQFU
	 zwNWL/dXAa29q6QOy296GPQMJs2aee3dsCMlnWpxm+AFtEbmASBcJ8RYwp+0D7A8fVPAp
	 Drc1QRga5Pc2bUFZwVHM9ELX8Q0ddTbCJE761Qmy9A4x0en1S+Syy1D4sqVxEXRnDfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QrhxV8+W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 20:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DAD2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QrhxV8+W
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso1952463a12.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 12:41:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794084081; cv=none;
        d=google.com; s=arc-20260327;
        b=CRaknONPbRwWh0fNoq4a2A9yqviaQUJmjefoo6zYVMiuWzzQjeU4+yF9nQdnwCATtu
         2uILFC4KYu/vj5b1JQJDVvo0lque3IDYgIXPI5T9MTNXUxyRszjLxU0LQcAYiDRG4lUi
         yVFWAbz8Fmw/md1dq7sIMblILyCokZIM7ajbkeI49pTCIJQqbmQoEcQDniwPRB+BdDcx
         6ODJNXGwF21AceI9huFt00Ls0bElTYeZNG+htAkF+xG7IQux4sAZl+LthSnJs9+KHFlG
         LnS18cwrHYz1Z3S9h/JcVCc50VRWDSwTCvPA7tf8YYsfwpWwXbCoC73c4UM4pJ2iiqTT
         4whA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3nE0Zc+c8FrcoVV463cyZzi2Tv0FGf+LyHH8XWcZQo=;
        fh=+Al+lPGRxLGnoEd1FBSehITOEiBWmXGKpVfndSyxfeo=;
        b=FNRuhLgyp8jdZgIHP1bAh0IlOzH0amE0V5XgaU25WR1WjKJ2ROOKy3vEhuqD0vTVet
         Tow7+tzORb+/UisUJL+R0MnuST+oj930ZObMqk5EDT1tSolFXvK4Jn0tih7/SKN2hecg
         mxd6YaopW0u6ndyh+CdF0JzUI4H2jaJxOjvOA6CVxhp89Aw0NVCFJ7cCCYeTbBbHQZbY
         dJPREu5vA/Z7NVFjpFdjMBw3p9mpLYRfraQxq2jg8w1ZanO0dNdvpP/b1h3UnAo4LhIq
         M8JTGkKFwTwrp4rvkCBOs2wc7fQejs/0yL0Jut0F0V4E8yLQBwv6mRJvbaHFegPeys3D
         5xog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794084081; x=1794688881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A3nE0Zc+c8FrcoVV463cyZzi2Tv0FGf+LyHH8XWcZQo=;
        b=QrhxV8+W8itMrpY3BIAtLx5Syxw/46j2EC/NSnQF5f09fVDs+kInE8Gl59mvGbZkpO
         2baCdd7hgzS5TKNyGDMCFRlQdhv/7S2sg98/UpcT9MgBZOe41EZVUthAvMzZrrW3AIJ8
         1qxrHXQZi9iVo/vMGSp4HGS9qV9bZGnU6YcHO2L6HVMTF3ceFLolgZqReDbP5+ngc4/b
         gej4+yk1vpq0A26l3+wABdlbMYILcu1sxk04VR18ap/dbtZw4b4CwBZC5DuKNUwhpfrX
         pycmTIQHLFaFkMxJ/Eeyla/KtKRhs4/MwbkHkISxUeCReEeYpy1B8VyYMW0gxF+cEd4b
         jIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794084081; x=1794688881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3nE0Zc+c8FrcoVV463cyZzi2Tv0FGf+LyHH8XWcZQo=;
        b=tuVZUkMnZPiBeaOQNfcRjLr6cCHA/QpKuVz1ueW98LtnmHRQSFGAxFpr4I8dQ/CLr+
         5Km1SVjcsgB8gOJTUIne63gd1S53okGrPF3KmCyEEciL5CiXjDEdQbUBt2FIKe1dKLrd
         BKdt3jLVKhpl50FF7yD5rihwUAHU0IJzyKEzYLAkEJ9EnEtcmUC4UwlIISCJUkE4YTWq
         djfXfblUEHM2w2cL2yD5TiQM9qW6hDLfIk0nhL0rFYNmD9P/IWZvHpPbq251JxsFasya
         ZprUECn8m3zhqHFoZ7Qs7kCvRvhNAIJrygZl0VHFmL5goytP2tnZPjzWB1ULheQSQT1F
         Q3kQ==
X-Forwarded-Encrypted: i=1; AL+hErGXX9oDSkZdU9krhuSOLzKtrAC7C6n/MMgi8a8mdX/vzFU8h3n4lBv3WsUo2wEHrG+9CUmTTJg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/CCwT9zEOpcKcvgije/tYYbrvtEsngooQbq5HJN3OP5/pkV6j
	u7E54/401BWqgRqEEwSjrsONPASS0gqwRfHu5WT9IEc205xSZ5Jv1uXVwn2ZnrmP+z7LFrCs143
	1LucPzCGWVW+X+qwmRn+QlODnLR+DFDM=
X-Gm-Gg: AYBFou0WHYiLS6phEcCiqles9bBfyQdOsO4zhUnK5PDpHoxJQrp0wIAX+Rr7hUaO5IR
	R9CPKqFEYPxHNOoh0sFSHn9tsth5K91zX4Rqv088agGiJKpiLhd1HrhQ0DlWIplLYahHREux3N3
	WHrBaoK+voha7hJsuhTIWzV1sy1FuHX5PA2ZDSrCSn1ro5K7MOkQJzowaP9EqcJSd1TW2Xc1tBB
	TAYLpACPmwtYWobBeBTAp1UclwtAz9L7w+5b4+61isszy46CET4oMnfVy/eiq1xUM3Om6GLP+wN
	I0ZU3v5rXCQQh88L5BWXuwktkr4aCfh1TZGwu+RslBiQHNF5vOvKUSmY6NnGRjByVeBieWZJNMj
	7G5TgPxLy0IJDX5Tn/ooNPU7wTTDh2oiYVz5nWP7vi95ciu9X3Q/jhbuelugPBpIQSUpQfsnZvg
	+zYB0PJ1Yd1ny4TbOt3psonkn/aJll8ebz7mXUUO6m4DuG3TvgOc9mEwgs6yTBUuDKr4Ka3baKJ
	tlEz8poQMVaPuT2ppJ6tda5pgQnTdMVC8eAtGU3Wc48Swsleg==
X-Received: by 2002:a05:6402:540d:b0:6b5:fb30:5651 with SMTP id
 4fb4d7f45d1cf-6b5fb308201mr4206352a12.26.1794084080656; Sat, 07 Nov 2026
 12:41:20 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107061443-failed-5.10-0d66f9895f28@kernel.org>
In-Reply-To: <20261107061443-failed-5.10-0d66f9895f28@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 7 Nov 2026 12:41:09 -0800
X-Gm-Features: AclHuK8GIvWYHmxHvJiWpKo5EogDeTUmwaW2hZJ5qUu42byAUs2B42l38FCXFRY
Message-ID: <CAKxU2N9mXdar0Pctgck2scdwSncajE2jbzuCsruL7FvwsPP4Sg@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] mtd: rawnand: ndfc: use
 devm_platform_ioremap_resource()" failed to apply to 5.10-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: miquel.raynal@bootlin.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 3:14=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 0d66f9895f286d2fab396a71e6efeb95c4a7e5a6
Requires cceca8cb776b03e83985578f84bd730c30d57f70 as a prerequisite. I
guess I messed up and didn't add a Fixes: tag to it.
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061=
443-failed-5.10-0d66f9895f28@kernel.org' --subject-prefix 'PATCH 5.10.y' 'H=
EAD^..'
>
> Thanks,
> Sasha
>
> ------------------ original commit in Linus's tree ------------------
>
> From 0d66f9895f286d2fab396a71e6efeb95c4a7e5a6 Mon Sep 17 00:00:00 2001
> From: Rosen Penev <rosenp@gmail.com>
> Date: Mon, 24 Aug 2026 13:21:20 -0700
> Subject: [PATCH] mtd: rawnand: ndfc: use devm_platform_ioremap_resource()
>
> Replace the open-coded of_iomap()/iounmap() with the managed
> devm_platform_ioremap_resource() helper. This fixes a mapping leak on
> driver remove (the old code never called iounmap()) and simplifies the
> error path by dropping the manual cleanup in ndfc_probe().
>
> There is no overlapping memory-region concern introduced by this
> change: each supported board DT describes a single ndfc node with a
> unique 0x2000 register region, and the EBC parent uses dcr-reg rather
> than a MEM reg resource, so the newly added request_mem_region() cannot
> conflict with an existing reservation. Distinct chip selects map to
> distinct 64-bit physical addresses, so CS instances do not overlap.
>
> Fixes: a808ad3b0d28 ("[MTD] [NAND] ndfc driver")
> Cc: stable@vger.kernel.org
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/ndfc.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
> index a48274297d3b1..d6db04d48c45a 100644
> --- a/drivers/mtd/nand/raw/ndfc.c
> +++ b/drivers/mtd/nand/raw/ndfc.c
> @@ -185,10 +185,15 @@ static int ndfc_chip_init(struct ndfc_controller *n=
dfc,
>  static int ndfc_probe(struct platform_device *ofdev)
>  {
>         struct ndfc_controller *ndfc;
> +       void __iomem *ndfcbase;
>         const __be32 *reg;
>         u32 ccr;
>         u32 cs;
> -       int err, len =3D 0;
> +       int len =3D 0;
> +
> +       ndfcbase =3D devm_platform_ioremap_resource(ofdev, 0);
> +       if (IS_ERR(ndfcbase))
> +               return PTR_ERR(ndfcbase);
>
>         /* Read the reg property to get the chip select */
>         reg =3D of_get_property(ofdev->dev.of_node, "reg", &len);
> @@ -210,11 +215,7 @@ static int ndfc_probe(struct platform_device *ofdev)
>         ndfc->ofdev =3D ofdev;
>         dev_set_drvdata(&ofdev->dev, ndfc);
>
> -       ndfc->ndfcbase =3D of_iomap(ofdev->dev.of_node, 0);
> -       if (!ndfc->ndfcbase) {
> -               dev_err(&ofdev->dev, "failed to get memory\n");
> -               return -EIO;
> -       }
> +       ndfc->ndfcbase =3D ndfcbase;
>
>         ccr =3D NDFC_CCR_BS(ndfc->chip_select);
>
> @@ -232,13 +233,7 @@ static int ndfc_probe(struct platform_device *ofdev)
>                 iowrite32be(be32_to_cpup(reg), ndfc->ndfcbase + offset);
>         }
>
> -       err =3D ndfc_chip_init(ndfc, ofdev->dev.of_node);
> -       if (err) {
> -               iounmap(ndfc->ndfcbase);
> -               return err;
> -       }
> -
> -       return 0;
> +       return ndfc_chip_init(ndfc, ofdev->dev.of_node);
>  }
>
>  static void ndfc_remove(struct platform_device *ofdev)
> --
> 2.53.0
>
>
>
>
