Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B05568FDC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062402; cv=pass; b=Drb6J3bmbPlsKOymOY6Yq49NvhAkZJwDJBKMvLseQMEiu9/zfZkT6SRy7ib9N9Co0cJPxzzRCRIP1weT6cLkbd5Z8w3PNp5BOkOn70gpjOv2UTRHj82T7Zb4MuK5QlOvYhnM9QMZLn+Ua0PfxZ7qqWqM6+ttaFt1YCsLbSa+vo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062402; c=relaxed/simple;
	bh=Vrzrlw6NEH45X35QxpA1RjfO7FaaCToWOrz+oHjjRrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+wUU631Y6MmIwpBBDRsBGG2YfBCMLCpuep1zrOJSSp0n0nJQ3w+0nuk2eBBbmfwmAfM5Hvl5tYQkY/KJ89gsA+0L7/FGOyLsKaTRnZ3Leg1t+kJzJ+Hus2VeNV8e9oH2QJkxj7NPNNBAU/ogETsuwDxtJvz1JBxZ3tJC5A96Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h06Vlcwe; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h06Vlcwe"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66d20c35ffcso1163831d50.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 10:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789062387; cv=none;
        d=google.com; s=arc-20260327;
        b=SgJ59D2RnJhpD1I5CraguHLxQaehoxmZtqOCxokF4w4EM8IxAfLHh8ccHAByLOvsg3
         if/Abwn1BGPa5+O1VfCnrqmqYGrZ0VVzc/zP/zJH9knfiH+wFjHVh+BzLAJ8XT4CBSHt
         cMweJuldiR6RmzKs0pHRFtGtH/eggdcc5OqyXT25+mcRBEJ2vMP3Ei9b7CRw5TTvTApZ
         u9jJ1FdtwOl6vlP+ZIco+59m6dGS5NAGA/QYN0eqNh7AV1l1f93NJeFLV5oG5EH+r+kC
         SqZl/mljX4kaW2PQo1+EcwRPvUz2H/Da3VuDT+O+jXZ4d1ou5D3T8T29s0YzJq3xvQBO
         0Weg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4TZTvFeGPOKvIslE4wHXvMYV9kBCW5S/2L+GB2DcDc=;
        fh=KlEexQy3gwQ+TSynwwgmL7rTszD/GTt2+kAFdGeLf/Q=;
        b=VwiO7ps1MHuv0PZITShfsJEoZ7yj1L9nSdlxenno/AUQYQZ61WwxKL16pVROfjqjOZ
         fb+aeXn0FaxrmXGtuumzQqnwsEw55uNIDEcUi7SXRVi0BAQgIUGrjrOBjh813Rdf85sk
         HCjPF4VYeJGLlfSFG45mveQ9bO99tD0eQL0WrQZha0AcuRZOum6uZPNwuE+cV1/WCN/d
         SA4l9rl9OfsDaaoIkuBmQTYs9lKIeKhZZEs+S4triytxtPufOkBGrGXYi2BMpQPoDAbk
         1XCiiWcm1t8lsWL6b3j5lFPqKCOjtXk5rX3J7YN40QJNjgq/AKKrK9Rw7BfO2NMWPdZq
         f5YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062387; x=1789667187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w4TZTvFeGPOKvIslE4wHXvMYV9kBCW5S/2L+GB2DcDc=;
        b=h06VlcwemGDL3kiY2x5x+cJVYMWT60Ap76jj8I+zLTnmlvVfKDMPq/j1+DkiNwkmA6
         X5ZBjI+zFNcmvYNWbtppC2DSZa38aSf13fWubtC1WUCXpltkpTvQPHQwD8+qHg5QpWQQ
         wGr5KKtpjo6L8aOjZQ0JHzYzcYr/V0tDo65m9cB6iDRyuRpyQ3Bg0/cqwYTXTTCmVWFt
         HO6SJtnNHuTNTw1CEI9tGwGxnyLI9EjJSYtb5zD4/2jXe/+Rzvd8B54ws+IAD7O0eRoL
         Rbn8UP9Z1/DfhQLuTemqnAgEKIdBROIA7gbmjJD9KO41imFtF6QHkgGS0v/KbPLvR1KC
         yzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062387; x=1789667187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4TZTvFeGPOKvIslE4wHXvMYV9kBCW5S/2L+GB2DcDc=;
        b=BRftU8IEocMKXmSQmlV5qvn7eH6SyaaR66eKMIa9Zv0tp+p5yjAPnpJuR9PAYKpmW3
         KuSGJJX5IJWv78uIKrKGsMPlGM0i2PjYZa3WCaaIEjsITu2GsJMj/nOzhPjvzoqAygWP
         u9pkoiMFQAbpYzq1gmu41kOyihJV4ArernsCyRyDP9sTQ+/d2+3t9+BablNszVXxhlJw
         zFyNzYoe6AC+aqFNdA3Oxq6WI6nvdTEcx2/hnyfo0lVnQKmTEYiV1VpdRyCW7veDb5s3
         GFUpL9c7GQuhGxgtP2bMi/C2KM1aeXdRTUVBLulVKbUQ8U/QTin5NnjeTRobjv7CeEkl
         V9Cg==
X-Forwarded-Encrypted: i=1; AKwUvBxFhjAiq76ZtWqxgcZQBXNI3rVqm5ihFH5/DPXPJxTu/dOveXO+lMr+h7wfMygoPbjr3vY3fzA=@vger.kernel.org
X-Gm-Message-State: AFuF++mbtKpIbYDqpAppSSXbLF5PV2zhLNhmj7P6y0tvX0J3wt2N8hip
	kjBDfYgrk8xBpWHRsZmVveg0sTgkcVfDd4h8H84TT9xXyp+yMeo+HIK/7zZpoU0frvJFcOCsMNy
	wzaV4x9vRDDn0WYykMUH+UO/pICpwMNM=
X-Gm-Gg: AYBFou2OFDLzLrXUvGo+eKDNOYC8T/E+nXjxxsVljXZI4cTiAlNvsXXO3cHi7JPhr5Y
	IWavFc90/eLNDdSBpmLWSF5EUkoVcV+chVDPmjvQf4eBRzsVis5FpnJuAoTkaxyqzTLVYjC1g2Z
	M0RcSwjUyo0FKFk096vfxgcx4+dUEYM7sQi2OdAPOHAVsura416h718rrVCLnB0Q3O4zRPQW7U9
	1sD23SOAUkiY+QnDUMm4C3dsZMTqTDQ0RaTxgurOTFGEtT634R5oO4icARl6e7dFowklZFGTIQd
	YxA8kAKvG7rEl+P1TF9Jz8XxE06l9y+PqC9ETqx/VznEcCuvE66ibF2OQA==
X-Received: by 2002:a05:690e:2630:b0:671:1256:56f2 with SMTP id
 956f58d0204a3-6712434a30cmr243759d50.0.1789062386241; Thu, 10 Sep 2026
 10:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910113325.717882-1-itai.handler@gmail.com> <8fcad389-8340-4ccb-8ef4-008d826115fa@sirena.org.uk>
In-Reply-To: <8fcad389-8340-4ccb-8ef4-008d826115fa@sirena.org.uk>
From: Itai Handler <itai.handler@gmail.com>
Date: Thu, 10 Sep 2026 20:46:13 +0300
X-Gm-Features: AcwNN1U3FFO8vc3TdnTHV2rTuiD4fh1DFByrqEjK3AblMQ21SxCX7JRhTKfW558
Message-ID: <CAFpOueQ-veAYVWAPTN6_0c9NXCEN24wzV4i2uVuNykWmBy6vfA@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-zynqmp-gqspi: stop the controller on shutdown
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-spi@vger.kernel.org, michal.simek@amd.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 7:56=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> > +static void zynqmp_qspi_shutdown(struct platform_device *pdev)
> > +{
> > +     struct zynqmp_qspi *xqspi =3D platform_get_drvdata(pdev);
> > +     int ret;
> > +
> > +     /*
> > +      * Only a runtime suspended controller can be left alone: its clo=
cks
> > +      * are gated, so it cannot be mastering the bus, and its register=
s
> > +      * must not be accessed either.  Any other answer means it may be
> > +      * running and has to be stopped.  In particular, on a kernel bui=
lt
> > +      * without runtime PM this returns -EINVAL, and there the clocks
> > +      * enabled in probe() are never gated at all.
> > +      */
> > +     ret =3D pm_runtime_get_if_in_use(&pdev->dev);
> > +     if (!ret)
> > +             return;
> > +
> > +     zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
>
> What ensures that nothing can start new transactions after this has
> run,

Nothing does, and that is a real hole in v1 - thanks.

Two things narrow it without closing it: device_shutdown() has already
called device_block_probing(), and it walks devices_kset backwards, so
the SPI slaves and the MTD stack above this controller are shut down
before the controller itself. Neither of those stops a late spi_sync()
from anywhere else.

I will fix it in v2 by quiescing through the core first, which is what
this driver's own ->suspend already does:

        ret =3D spi_controller_suspend(xqspi->ctlr);
        if (ret)
                dev_warn(&pdev->dev, "could not stop the queue: %d\n", ret)=
;

        ...
        zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);

spi_controller_suspend() answers both halves: spi_stop_queue() waits for
ctlr->queue to empty and ctlr->busy to clear, and __spi_mark_suspended()
makes every subsequent __spi_sync() return -ESHUTDOWN. It can sleep,
which is fine here - device_shutdown() runs in process context and
already holds device_lock() across the callback.

Unlike ->suspend, shutdown cannot abort on error. If the queue has not
drained after spi_stop_queue()'s ~5 s cap I still want to write
GQSPI_EN, because a controller left mastering the bus into memory the
next kernel is about to reuse is worse than a truncated transfer. So the
return value gets logged rather than propagated.

I did consider making ->shutdown just call the remove path, as
spi-fsl-dspi and spi-bcm2835 do, and it would quiesce correctly here
too since zynqmp_qspi_remove() calls spi_unregister_controller() first.
But it then disables runtime PM, drops both clocks and tears down the
controller and its children, which is a lot more teardown than the
shutdown path needs and none of it stops the hardware any harder.
spi_controller_suspend() is the part that actually answers your
question, so I would rather call just that.

> and if there's any operations in flight will the controller be OK with
> just being stopped like this?

With the quiesce above there should be no message in flight by the time
of the write. For the case where one still is (the -EBUSY path):

- Writing GQSPI_EN_OFST is the driver's existing stop primitive.
  zynqmp_qspi_remove() and zynqmp_qspi_suspend() both do exactly this
  write, so this is not a new way of stopping the hardware, just a new
  caller.

- No controller state has to survive. Whatever runs next reinitialises
  it from scratch: zynqmp_qspi_init_hw() clears the ISR and the DMA
  status, writes GQSPI_EN 0, resets the TX, RX and generic FIFOs, and
  writes GQSPI_QSPIDMA_DST_CTRL_RESET_VAL. A power cycle obviously does
  the same. So a controller stopped mid-operation is recovered by the
  next probe.

- The flash is the part that outlives the write, and stopping the
  controller does not make its state worse. A read is aborted when CS is
  dropped and the chip goes back to idle. A program or erase carries on
  inside the chip whatever the controller does, and the next kernel sees
  WIP and waits for it. Waiting for those belongs above this driver - I
  have a separate patch making spi_nor_shutdown() take the flash lock so
  the upper layer does not walk away from its own operation - and it is
  not something a controller ->shutdown can fix.

The failure this is aimed at is the opposite case, where the controller
is left running with nobody driving it: after a kexec without this patch
GQSPI_EN still reads 1 and QSPIDMA_DST_ADDR still points into the
previous kernel's memory, so the engine keeps writing there while the
new kernel is relocated and started.

I will send v2 with the spi_controller_suspend() call shortly.
