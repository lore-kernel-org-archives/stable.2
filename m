Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEAA48F015
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989382; cv=pass; b=sBMWfm+x+gmLV8bLKIcsyayud1qF9Gr+h71Ze6IeFNMVaI3Dh09ludqwgvUaUDd0IGjDamQD7UgF1AUY/K6eJPwcfJYsLCWID0HxNtcyVd5FvWul4dkLfVvtgaOMLfDwGzkgY0hHJmLVk9/mVRmxhFF4GiCfLcgydk0XPC4feTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989382; c=relaxed/simple;
	bh=UY27w1Rfg6xCtMs7QTO53sEOpBKzcS6nCTvac4TS40A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTRtbIA9WEcDwFF6f3sOZk1yi/eM1AQtfOV0xE7IuCoOFVl9HSKd6PJSrXFgmuLedAuesWSiaWpFC0Bi7V/ioi+IeodzS533abFSnVo3BcY/Jj9npdz4yNRxVnwAMe8M4qSpRyw/LjEgoevrmJ92vWpE8e6Xz64Zkk7jV38czfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSdI+FYs; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSdI+FYs"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-6729ca45e37so1223452d50.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789989379; cv=none;
        d=google.com; s=arc-20260327;
        b=MjwQZoUTMUzi3QLnjRVkJoayyzsBV2O0hCOcGkyTh/9jPJwamPhqgFH/t0G+7tx21q
         QDoLmwwKr2r//Rlp2yIGVC/wdUGo+S0xL9cp3EY4B6WHXPzQs9YOkvyEGBP+fAUiQLsF
         4HS60in5XjxZ/UJXUjn5TfQMMIUaOoJpExbNFMRQFFHkai77yqgY7yuiqAjrjp9CiQd6
         GDynFv07AORYgCIYP2/r7DIR/1w7rK8lCqvonBJ2+h/Fsx/3YRQ3nJS04K16dAec1pzp
         dXHQmiXjE1BAcVcc5xZmQxVmiZ3iL37cBQh9GcX0npRJ9JIK3jur41LLUcMuyNXeKHW+
         I2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pOZGG9rQS4x6RO0sAzFbkNSMIY91sIYWznb6POPYtaM=;
        fh=DDxbOQkuPcaM9LLIoQS65evwWkkKSbrGnO18OoRWjU8=;
        b=OkCquoeE52X2hD8nZzxABqcMtH2hepneZ55fSqCLjYo+0KayeH1ILhzsZ5+EDi0jDm
         RWqsYGqtuRDrIVHWvNnBoW71PJAO6lqRJs+5lkg2zxKOmZjTw9RgFmgRpx3ck/rQLKEh
         zPPTZlmEkkxWBNC4pTpLeB/TMUrBb5ksZNgzGuyo58LkGmFlmaQ+oAs2K8fotfRgh46Y
         PLGoA/xRrdVJHZftryu/WBlHeAi6fV81mGpOVTXFc6lNgo8jDqnzWVjAfMQ+hiM/nRAM
         5hfax3XnKnDlaCtIj6Q34E2y9QSVErdt4DdO3iFBO6E4rHY/AnU4vtbnanAJaps2Pmw4
         bhag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789989379; x=1790594179; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pOZGG9rQS4x6RO0sAzFbkNSMIY91sIYWznb6POPYtaM=;
        b=hSdI+FYsDeu6UasZMF5RDReUq7JWGuq3otRkujWb6JLFMDEjm8ireuFceohum0h0uJ
         VQEjyp9lPc0C81/aeF/w+QVzbZiF3esQpfF1rDs/7Z+cAfqITqj0iJbqtcV9xlZw3xRj
         N8aDF20fNmOBCQEO7/8B2rbelnKNWBx/hwHNR8Id6QDIz7vsqXQOUN/u5jw9vkYIJ6fs
         1zOZhXYMmJM4thxlNzFMLlyOla9g9lqrihXX9jg/7HQ1bwdIbOefrCR6KjgbwsnIQpXm
         6UzK7I4XVnfaw6mfZ/Q8iILOu2rpjSsnXBu62BaH8jmkKpo3g1JZ/tHUM4bRyRmWhAHz
         a/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789989379; x=1790594179;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pOZGG9rQS4x6RO0sAzFbkNSMIY91sIYWznb6POPYtaM=;
        b=UuEkB7V1Gz2TzLXj6zIuCbJa8UiW7DV61SGbgf2wClGg/6jq0VEwQvVZOHAQ+oXOg0
         e4W99i6L6ea4DdWB+y2gmkaLVuCicNE+l78dEakL744Gb1twflGtyNfKxLupO4WiAbLQ
         6Lihz99pCBaws1iw1dmctinCwZxQxf8yChInoACWYdJ/kokMHho10/HABqIE/DUmeeZQ
         lRKswFGTnze2lOOUoeif3Ar3Ii5pPbcFC2UEi7WGCJDlb0nEMhg8ov5/b8Inq+JJ1L3K
         UTd1j6VHcMe4rNZN19HFl62C265wzYg1XaUWpKsKWN4xZ8Ozpo0jvDFOs2jJbFvwgYFI
         aRmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzob9Qo75y9YrNfxC+/4/ljmIQ42B8GkIlgIISB7eUusRQfr4Oh7fCYVZLvqGfTJ72wHqXN9iI=@vger.kernel.org
X-Gm-Message-State: AFuF++ldVYd2zrcRopeQy00XLu+m3M42ZalvXID9VtrVXKUTPtaoOSlp
	wyuXMJrRxNfFy/WuZ80WVKBgNGLUsF7hFwcI7xTKKYmFzDTuCrCtjlxXiciu8z/QhGOXssdomC0
	2gY6QJx3TL0sMmbU0osPi7NLCv1S4N5g=
X-Gm-Gg: AYBFou3awgFVrd/1zZQ3T6P3hpEGI9O2G9c6zdvXqQaShfbpQBS+qzdIv2SW4juXCSO
	+0jtvp/GshnmPHLQfRLJA6wg5qldjZwYsR8P2BMal0b6cnl6MGiJndkDlNbNDadyvfIBKQjcA1U
	SumD4kCVfjsFjwxg/gT8SmysnwENgnNkcOhKTwZoyM4PNlUH8I0LOaFbvRkLcYknl/MR7VbLPXg
	fDFSxBpz7Ls1dv6CpHPhPWJCfnH4OhOyx8BSSth3QP40tg3872RoPd3cNtuxd3L/g/wjLL1/Ca3
	7rkDgioCzA3Tz8yUGy/FxhCa9xiJJZqdp7AMqdnTa+b5TRxNKypT0kow2w==
X-Received: by 2002:a05:690e:418b:b0:671:4ed:6b63 with SMTP id
 956f58d0204a3-6717fdf34d0mr2345152d50.71.1789989379554; Mon, 21 Sep 2026
 04:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913045001.1126563-1-lgs201920130244@gmail.com> <aqgO5PfShs5FG--f@SMW015318>
In-Reply-To: <aqgO5PfShs5FG--f@SMW015318>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 19:16:07 +0800
X-Gm-Features: AcwNN1U2EQbqeVHXltNz7b04PkxaH8i1uZCpkC4vS2xVRRfVK0ht_Ajux6vb24U
Message-ID: <CANUHTR-2haN5Z6ajc8ELGF57JvTHOCcFG_ZzXRdR7XwgC3PKog@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: fsl-dpaa2-qdma: fix ppriv memory leaks
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	Peng Ma <peng.ma@nxp.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Frank,

Thanks for the review.

On Mon, 14 Sept 2026 at 23:12, Frank Li <Frank.li@oss.nxp.com> wrote:
>
> On Sun, Sep 13, 2026 at 12:50:01PM +0800, Guangshuo Li wrote:
> > dpaa2_qdma_setup() allocates priv->ppriv separately from priv, but the
> > allocation is not released on all teardown paths.
> >
> > If dpdmai_get_rx_queue() or dpdmai_get_tx_queue() fails after
> > priv->ppriv has been allocated, dpaa2_qdma_setup() returns through the
> > error path without freeing it.
> >
> > The normal remove path has the same issue. dpaa2_qdma_remove() frees
> > priv without first releasing priv->ppriv, losing the only reference to
> > the separately allocated array.
> >
> > Free priv->ppriv on setup failures that occur after its allocation and
> > during normal driver removal before freeing priv.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 7fdf9b05c73b ("dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA controller driver for Layerscape SoCs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
>
> qdma_setup() is called by probe() only use devm_ allocate function
>
> Frank
>
> >  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> > index bf771251264d..0f0fe0291a06 100644
> > --- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> > +++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> > @@ -365,7 +365,7 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
> >                                         i, 0, &priv->rx_queue_attr[i]);
> >               if (err) {
> >                       dev_err(dev, "dpdmai_get_rx_queue() failed\n");
> > -                     goto exit;
> > +                     goto err_free_ppriv;
> >               }
> >               ppriv->rsp_fqid = priv->rx_queue_attr[i].fqid;
> >
> > @@ -373,7 +373,7 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
> >                                         i, 0, &priv->tx_queue_attr[i]);
> >               if (err) {
> >                       dev_err(dev, "dpdmai_get_tx_queue() failed\n");
> > -                     goto exit;
> > +                     goto err_free_ppriv;
> >               }
> >               ppriv->req_fqid = priv->tx_queue_attr[i].fqid;
> >               ppriv->prio = DPAA2_QDMA_DEFAULT_PRIORITY;
> > @@ -382,6 +382,9 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
> >       }
> >
> >       return 0;
> > +
> > +err_free_ppriv:
> > +     kfree(priv->ppriv);
> >  exit:
> >       dpdmai_close(priv->mc_io, 0, ls_dev->mc_handle);
> >       return err;
> > @@ -787,6 +790,7 @@ static void dpaa2_qdma_remove(struct fsl_mc_device *ls_dev)
> >       dpaa2_dpdmai_free_channels(dpaa2_qdma);
> >
> >       dma_async_device_unregister(&dpaa2_qdma->dma_dev);
> > +     kfree(priv->ppriv);
> >       kfree(priv);
> >       kfree(dpaa2_qdma);
> >  }
> > --
> > 2.43.0
> >

Agreed. I'll switch priv->ppriv to devm_kcalloc() and send a v2.

Thanks,
Guangshuo
