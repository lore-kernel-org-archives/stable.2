Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50735C691
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 04:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744195; cv=pass; b=dtC+kdm3sjtW9E4cEOLVt4j4dPu9yWzTlWQniWUFhvZe92NSb7YYek0cQtc7iecIsTNjWpxh8kjGOdD6kQDlsWXKemvDq0i6hRYnm+3SS8T3dNaCKsBxSfpLK3bJ/70QP/otDPgn+w/vf9O7zBD1OVNaWkt6LWcSfTPT2gAvqfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744195; c=relaxed/simple;
	bh=aijIq6MG49th3NxWEi1RYjXRzGo8e6tnPdyVZG7VoU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSuwvppCLlzGqwC4nZa5z6g6BX/GZMmyGUc1zPxgfZ4qzhPiJvJ6ysuh51ElNgMguWhUYaFq7lsoGCniuTYWB9rQD0CUFggwTs/EUb1pSHgZ4MOJV2xEfyn8BnLQWzQEmPmwWL5b4T+9+jBRAwQYRPJOoQ805FQS0nxs/dlnLL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsPfNluM; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsPfNluM"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab22370so4383970d50.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 21:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790744193; cv=none;
        d=google.com; s=arc-20260327;
        b=Wm9JetT12Zj466jLOhfamA6UA8zs0xUdrCtKOJPYX/+K7R+pRFGC9lktUHgAqy2kIs
         JrtfigS+2ff8JzEzrCCma5JKM5Mb6c4cspuPON/9JY6gN1BCxEdDdCkmVSlbPRGpdpfY
         snwX9qELIk1aRxq5wFmzNdlMsKMQBnqp35zu/1qf18dsSHiAjZQoSYxAYFMqYgk1Bh9/
         0JNSeS3rcYLoMaOZOr9EzD/2nrcAWKxQI+xv8uC8lajST3XpH7bfvBNtupaC27DkMGkL
         mzLFX9vN1apheSaJqLyTXuoy0+SL9o4NFi39qxWyyqB+Uoi6/W/oxl2AVBMlgQu5+ujA
         C8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YazpLo8uOEsrRzgBDuZEHvPTChLlaZapwZA6DqRFIGE=;
        fh=DIm9aBAtvwP1+ewterpU/fl48p9g0Koq0byCLF70dCQ=;
        b=oti6XAViafe/3JJl3NyBKfeTI1S1yKi7wnhHYQCEtV8wS/fBGPtAISiP0vDlantGdP
         5TKaYOpJnNDSBp3kEnUPQCSpJkdrVoLv9xKMtyLUI463QXJvZp6JidlICBhnENPHhSSE
         9PT1FhP4JrutxwmmMWRTwLC3rHsla+EHmmdUe8mQSe7pn10HgA1w3ecsSYMKeiD/reG7
         lEvkfKno7ESBtg8K0Mosd46R6wmMalLhi9ZydFG2h0zgbBQkiMP+KVwT5Rkj9hWX5EtV
         WcA+ysvrjZ+tLMG8EV35s2UPLkFUP6YjM1mua279i9uOFlUluVbdLyoiHp5jn7/29aDD
         xZQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790744193; x=1791348993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YazpLo8uOEsrRzgBDuZEHvPTChLlaZapwZA6DqRFIGE=;
        b=BsPfNluMyV7VnbDx8bcRuJLa4SEFo0DgwXPjaEIuDdc0oWXf3kKnzF62jQE6biHBCH
         ATxkbkB8adjFF3aqLYM3jJd7zMMyOCn/2gbDlAw9qpHgcbPKC0yCOtT/xh0fyZpKCLyB
         hE7Jtmswmb0ySZxaORv2IoJb3Eax9+geI2nCpQrPxIzSdNLcdJFmRlgx2q+PtQxkDgbu
         RdqY8j7SKp4Bgnvf0I1rLEHWHb1rxZbTOF8+Vk1ynsN6OQVzQCiSrL5jIYF0F5Dbk+iR
         0cRkU66G08rWsPN5ECNwGrsR27YzbhwD+5HWxCOG7azhtfU15ApGqMOvTXE+cNPz/GIB
         JWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790744193; x=1791348993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YazpLo8uOEsrRzgBDuZEHvPTChLlaZapwZA6DqRFIGE=;
        b=iNwFpClCEtEUdwRSgsr/qv9ohAn3k4QxbiB4FQULBfz17zMomX/kDfEIeOcGwTySxh
         OAqlnY2VS5ZYVe0khhfD4li5ngm8w1AnpBMMdxemzSk5UZSeSkVGPJb9xYLBaY2br0k/
         oH0U54CeonBlIO9bZUgVCMd1KRAzJI+sN8i/CLRKHOn5B18cA8rxfr9+y6x1KJmBMHdC
         gm6daAfJtic0pJkijv7cZvPjCSy1j72g7GoNqzFfuQUdK/dPehn5+HSNzN5bF136HVVW
         2rQNsSa+k8Xp95zhJBIdgnerSoFbov5A2XKl7YNVUOZ38tGbdzxMzXgJBEYku6tvKLFz
         beMw==
X-Forwarded-Encrypted: i=1; AKwUvBwezqiZHt++cbDpuwtcUQetGP8PaZiBa2cDiONqiDAw5NtSvNSPqxSUs+aklMOQP3yo3czYI8U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU3OMwglnmJbMJ+l/iLvQBCvZ8+77WCkJtULR9paC6o0Q3Iv88
	GNTUi6zHUTZ5BdvrIwCzwrXFZN9xIFXVrPbgS6iNUfjI0x4uQzZ/06tqqhY9+O/gCtrIFzS6Dkx
	60dz0eSTO0R0b1/8TUW4tNfp5JZ98cMU=
X-Gm-Gg: AYBFou1Jz6FHO7RYHO5hkSyvGucDzax8MZhPbuohUvk3wpnU1OoR6LcoF2/l81R5ocO
	/6lQP8XaH4mFb7U5x1iosnKxWI+HLhfWQENm4jpZsbANUPVjO6ymFmK6htKna/8mX2QwSDXcHp4
	8iWb+raOYTkBPmKgbl3caKMXP65KCs4/CkklEQd+PZ/bbkBsI2C42w+F/Zo/67nIe1LRCTAZZz3
	PhTpL3yZ0ixh+cdkLcew9i/mlSw1tJMbnsFgoyg+zh8uGEMeyYJzx+jr9RNf97cImsMOILMvijQ
	a4ldH0uCmhWkAC7mH1LQecizKNbYYnLXfDx9gPhds5J5ho6NoI3i3/TfIxQlog6XZfQ=
X-Received: by 2002:a05:690e:4197:b0:675:39f6:9bca with SMTP id
 956f58d0204a3-676834a58f0mr102811d50.58.1790744193227; Tue, 29 Sep 2026
 21:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920055519.3778269-1-lgs201920130244@gmail.com>
 <CAKfKVtGZH8OaXp0WtJSD7AAQb8BSWg=xo+x9jj1sbjSxjEanGg@mail.gmail.com> <CANUHTR_yAgnZN05PBLae3DSk3xo0haLRRgHyKxswSYDE2tHgFQ@mail.gmail.com>
In-Reply-To: <CANUHTR_yAgnZN05PBLae3DSk3xo0haLRRgHyKxswSYDE2tHgFQ@mail.gmail.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Wed, 30 Sep 2026 10:26:20 +0530
X-Gm-Features: AclHuK_5dLBTDCM2a4gpvqnnswpJIWECN6q0YsymVQT1CjxevikTIfBgbHvWtBg
Message-ID: <CAKfKVtFkZ-T==D2-3OJeWUsRAzCE7_YP9kW1dDA0d3kjVWfBFg@mail.gmail.com>
Subject: Re: [PATCH] EDAC/versalnet: fix memory leak on device registration failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 7:45=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> Hi Shubhrajyoti,
>
> Thanks for pointing that out.
>
> On Wed, 23 Sept 2026 at 23:03, Shubhrajyoti Datta
> <shubhrajyoti.datta@gmail.com> wrote:
> >
> > On Sun, Sep 20, 2026 at 11:25=E2=80=AFAM Guangshuo Li <lgs201920130244@=
gmail.com> wrote:
> > >
> > > init_one_mc() allocates dev with kzalloc() and registers it with
> > > device_register(). If device_register() fails, the device has already
> > > been initialized and holds its initial device reference.
> > >
> > > The current error path eventually frees dev directly with kfree().
> > > This bypasses the device release path and can leak driver-core
> > > resources associated with the initialized device. The existing
> > > versal_edac_release() callback is responsible for freeing dev once th=
e
> > > device reference reaches zero.
> > >
> > > Call put_device() when device_register() fails so the initialized
> > > device reference is dropped and versal_edac_release() performs the
> > > proper cleanup. Return after freeing mci to avoid falling through to
> > > the direct kfree() path, which remains necessary for failures that
> > > occur before device_register() is called.
> > >
> > > The issue was identified by a static analysis tool I developed and
> > > confirmed by manual review.
> > >
> > > Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR c=
ontroller")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > > ---
> > >  drivers/edac/versalnet_edac.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_e=
dac.c
> > > index 3a06b41c1d84..db3bf5a1345b 100644
> > > --- a/drivers/edac/versalnet_edac.c
> > > +++ b/drivers/edac/versalnet_edac.c
> > > @@ -829,8 +829,10 @@ static int init_one_mc(struct mc_priv *priv, str=
uct platform_device *pdev, int i
> > >         dev->release =3D versal_edac_release;
> > >
> > >         rc =3D device_register(dev);
> > > -       if (rc)
> > > +       if (rc) {
> > > +               put_device(dev);
> > >                 goto err_mc_free;
> > > +       }
> >
> > There was a comment earlier from sashiko
> >  failure path calls put_device() with dev->init_name still pointing at =
a stack
> > buffer before device_add() copies it. That's unsafe in
> > principle (dev_name() would follow init_name)
> > >
> > >         mci->pdev =3D dev;
> > >         mc_init(mci, dev);
> > > @@ -852,9 +854,9 @@ static int init_one_mc(struct mc_priv *priv, stru=
ct platform_device *pdev, int i
> > >         device_unregister(mci->pdev);
> > >  err_mc_free:
> > >         edac_mc_free(mci);
> > > +       return rc;
> > >  err_dev_free:
> > >         kfree(dev);
> > > -
> > >         return rc;
> > >  }
> > >
> > > --
> > > 2.43.0
> > >
> > >
>
> Would splitting device_register() into device_initialize(), dev_set_name(=
),
> and device_add() be a reasonable way to handle this? For example:
>
> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.=
c
> --- a/drivers/edac/versalnet_edac.c
> +++ b/drivers/edac/versalnet_edac.c
> @@ -64,7 +64,6 @@
>  #define XDDR5_BUS_WIDTH_64 0
>  #define XDDR5_BUS_WIDTH_32 1
>  #define XDDR5_BUS_WIDTH_16 2
> -#define MC_NAME_LEN 32
>
>  static int init_one_mc(struct mc_priv *priv, struct platform_device
> *pdev, int i)
>  {
> @@ -730,7 +729,6 @@ static int init_one_mc(struct mc_priv *priv,
> struct platform_device *pdev, int i)
>   u32 num_chans, rank, dwidth, config;
>   struct edac_mc_layer layers[2];
>   struct mem_ctl_info *mci;
> - char name[MC_NAME_LEN];
>   struct device *dev;
>   enum dev_type dt;
>   int rc;
> @@ -773,13 +771,17 @@ static int init_one_mc(struct mc_priv *priv,
> struct platform_device *pdev, int i)
>   goto err_dev_free;
>   }
>
> - sprintf(name, "versal-net-ddrmc5-edac-%d", i);
> -
> - dev->init_name =3D name;
> + device_initialize(dev);
>   dev->release =3D versal_edac_release;
>
> - rc =3D device_register(dev);
> + rc =3D dev_set_name(dev, "versal-net-ddrmc5-edac-%d", i);
> + if (rc)
> + goto err_mc_free;
> +
> + rc =3D device_add(dev);
>   if (rc)
>   goto err_mc_free;
>
> @@ -800,10 +802,13 @@ static int init_one_mc(struct mc_priv *priv,
> struct platform_device *pdev, int i)
>
>  err_unreg:
>   device_unregister(mci->pdev);
> + edac_mc_free(mci);
> + return rc;
>  err_mc_free:
>   edac_mc_free(mci);
> + put_device(dev);
> + return rc;
>  err_dev_free:
>   kfree(dev);
>
>   return rc;
>  }
>
> This avoids keeping dev->init_name pointing at stack storage and uses
> put_device() only after the device has been initialized. Would this look
> reasonable to you? If this looks good to you, I=E2=80=99ll send v2 with t=
his approach.

This is already addressed in the ongoing patch series:

https://lore.kernel.org/all/20260724171945.2812749-5-shubhrajyoti.datta@amd=
.com/

Please have a look and let me know if you have any concerns.
>
> Thanks,
> Guangshuo
