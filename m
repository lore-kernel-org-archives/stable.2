Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422514;
	b=o70L2NtPvar7Rw7I2WkxlYticoujgr4FRMDIBXkmsxnayv+FafwC5ZcyXzV2kokH1sKv
	 ZYuhBmH9ndLjayXQGym0RjfBCO1+P868rRZPIHiaKUWsrwgRHh0tk6wbbA5UfFYSJgfGo
	 8/W9RKykVM/sS3wb83YO4o26/1MHpAkvG0L4NNjcSufaYOpXWBaY1HW7ClsMfP2fbA2/G
	 Jc5cXMMDb9yx8eyOoSA2yMYIXaGTZ3jWHhBQqip38a9l00lGEWSZ6Zhgu6bqGq/oxdvm/
	 zcuWIaUdVNHwpY2l5dTxjCDLzs3YbijlwQD6cIPnSfIpMFN7VTFp/GSyQKg7zyiqCqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422514;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=gPh24W8P88YnhbuVKf/7WuGqGcw81hO8isioZWFtmtQ=;
	b=PP+wLaMWIfgC/EVT4/1Q3eRx/2FyLy+KuAfVIcCheNPBlcvnwk4F7L0Eq4juqLakd67t
	 55+NCt6oN48ssRDuPIZaKcpJh+xEfOF29C80BS1YrTjd7gEGOMGSsRabdrSGNGEGRaNa+
	 STiChGYBGhjA2CyMNLroN31TGRrmXZsEQEFnROYsKe24OkhUEApLVsY+cPZxvrsI4Zpib
	 Bnzz8auzQRahUpIfEIsKwpoxrFr7MysV+XvNXrUnF2KEKArIfFgXnadmT6wnHAKcJp1KA
	 GlpWscgWx3wt9rxZ2NON5miqdqJOOfHqF8IwNnQQTXe3p4UgkkF/WxH7AS0hO+1kBbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=YIZEhsz4;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231DC606A321;
	Mon, 23 Nov 2026 08:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 231DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=YIZEhsz4
Received: from ideasonboard.com (mob-5-92-38-150.net.vodafone.it [5.92.38.150])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E9DC7177;
	Mon, 23 Nov 2026 09:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795422360;
	bh=U7NM5wyVUdsUMbvcIh5lbj8OAqDmxZ3X50eO/vgYd4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIZEhsz4WV2iGFyiEY+TksosTZxRBdjQonL+8j9DT9Wkbz0QBfqxjoQjXtKcKfNM+
	 qWi0TYFS3VILlNOl3ITM+XusuQXf26pBefQU1ZSw8vBBejZrJ6lhjzgFHmy5iqQzpy
	 aR16qpXH9q5s7DOmW1evmQShujnrevwnvioaVWJI=
Date: Mon, 23 Nov 2026 09:28:28 +0100
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Li Youhong <dayou5941@163.com>, Daniel Scally <dan.scally@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Nayden Kanchev <nayden.kanchev@arm.com>, linux-media@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] media: mali-c55: Keep IRQ requested during suspend
Message-ID: <awP0mKeNtrJj8zh6@zed>
References: <20261027-mali-c55-irq-supend-resume-v2-1-759b3f5b2cfd@kernel.org>
 <avMP-y1B9K0cp4M8@zed>
 <CAD++jLnuS9ZE8mRwkCizsqo3f40s5etqOJAUqLJNsCtE5eEkDg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnuS9ZE8mRwkCizsqo3f40s5etqOJAUqLJNsCtE5eEkDg@mail.gmail.com>

Hi Linus

On Mon, Nov 23, 2026 at 01:29:05AM +0100, Linus Walleij wrote:
> Hi Jacopo,
>
> On Tue, Nov 10, 2026 at 1:51 PM Jacopo Mondi
> <jacopo.mondi@ideasonboard.com> wrote:
>
> > >  static const struct dev_pm_ops mali_c55_pm_ops = {
> > > @@ -825,27 +813,42 @@ static int mali_c55_probe(struct platform_device *pdev)
> > >       pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
> > >       pm_runtime_use_autosuspend(&pdev->dev);
> > >       pm_runtime_set_active(&pdev->dev);
> > > +     pm_runtime_get_noresume(dev);
> >
> > Why is it relevant to hold a PM reference during the installation of
> > the IRQ handler ?
>
> Probe enables runtime PM before registering the media devices.
> Once those devices are visible, a streaming path can take and drop a

This seems veeery theoretical. To have the v4l2 device and subdevice
nodes appear to userspace we have to wait the ivc to probe (see the
.complete() notifier callback handler) and to operate the pipeline we
need the CSI-2 receiver and the sensor to have probed as well. This in
m2m mode. With an inline path to have the devnodes registered you have
to have the whole chain to probe up to the sensor.

So yeah, maybe Sashiko would tell you this is possible but I hardly
believe it is.

Anyway, there is a remote possibility for a window here, so let's
increase the pm runtime counter.

> PM reference. The probe reference keeps the ISP active until the IRQ is
> installed, so runtime suspend cannot call disable_irq() on an IRQ we
> haven’t requested yet. I’ll add a comment.

A suspend will always follow a resume, and if a resume tries to enable
an irq before it is installed we'll have problems as well.

If that's a real concern to you, shouldn't we install the irq handler
before enabling pm runtime and powering the device up ?

>
> > > +     /*
> > > +      * The driver needs to transfer large amounts of register settings to
> > > +      * the ISP each frame, using either a DMA transfer or memcpy. We use a
> > > +      * threaded IRQ to avoid disabling interrupts the entire time that's
> > > +      * happening.
> >
> > Does this comment still apply in your opinion ? I mean, thread_irq are
> > pretty regular stuff, do we need to justify its usage ?
>
> Nah I'll drop it.
>
> > > +     pm_runtime_disable(&pdev->dev);
> >
> > It amazes me how, after so many years, I still can't find a clear, firm
> > indication of what is the intended call order for pm_runtime_disable()
> > and the other pm_runtime calls is during a driver's remove.
> >
> > Media drivers seem to do different things with some disabling pm
> > before setting the state to suspended, other doing the other way
> > around.
> >
> > In the end, I think this doesn't make any difference, but in this
> > specific occurance:
> >
> > 1) Is this re-ordering required to support the new interrupt handling?
> > or
> > 2) Is it a change that is worth doing anyway ? (and I should say "should
> > go in a different patch on its own")
> >
> > > +     free_irq(mali_c55->irqnum, &pdev->dev);
> > >       mali_c55_media_frameworks_deinit(mali_c55);
> > > -     if (!pm_runtime_suspended(&pdev->dev)) {
> > > +     if (!pm_runtime_status_suspended(&pdev->dev)) {
> >
> > I guess this is required because you moved pm_runtime_disable() up
>
> The remove ordering is part of the IRQ lifetime change. Both runtime
> PM callbacks now assume the IRQ is installed, so we need to drain
> them befor free_irq(). Then free_irq() waits for the threaded handler
> before we unregister the media entities it uses.

I'm sorry, this is certainly me missing some pm_runtime internals,
but where is this happening ?

>
> That’s also why I switched to pm_runtime_status_suspended().
> It reports the actual status after pm_runtime_disable(), so we only
> power off the ISP if it’s still active.

It seems to me pm_runtime_status_suspended() ignores the runtime
counter and is only there because you pm_runtime_disable() earlier ?


>
> I'll resend a touched-up version.
>
> Yours,
> Linus Walleij
