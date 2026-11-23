Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432365;
	b=L9wi9OzA+7itbQCKprq4mQrHK3ZEBsfbzbQSsdvgHOypu2wuylqJtZUSV5nrUxSOoiu4
	 8MPltuedHN86lZHARkjUEFDOsPKb3WDf0Il8KhLenyTs5pb8tslj+mq/dhffyA0ayPEgL
	 2ASztG2vg6ekSgy5djuF4vqgadjEZkXGH8Fd13GMEt0ucUASUGc8emReoV96B0CF9cdJs
	 pXqBQVsco7DMpyKLdeKET/T/cSldSxCQrl5xVFd0t6XCBWuk+E1SDPbxLI+stFMQn+NlF
	 p5NCZYtljfQqCkNNk6PzOmJIL0Mb6D5ci0j6koAT3rDFqvm8dEJV5lveTYB4K0au8Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432365;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=nt98V4xlJAcIm+P/s6KIkxpYlGbaidkMKh5RbWgckdA=;
	b=tdijeLvObQhgz1UZWQibLLZ1gt7ljy4yMxYqlI12vJmo9+D6/uyT+Umoy9nLMYZaOH6K
	 L1wRFZ6oSR8YqtgbOgPA8yntrI+fDegE7QQsKqPf+GJIUDFtxrAdx4OFCD6QF8Ssw488H
	 mxiUKQM1RGi6mAW0yZSPKAR3KyF6OwbBaAAmXH8ovU2IXU8NkhNnoqDSmAyBSpKYMvNva
	 v25eghkCYMQIyjQLtAPM2HkmAHfZy2eAsRBXnq8wcukrQJJ5aXdRKn6486LjBeNZV4b7u
	 IyTmn53MlFvIUb336bHt4aUcSP4R3lSjjuWecS+HJ00iOnPb9m8nnZ02hcSHuZuuTdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=cghn12iM;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67580606A31A;
	Mon, 23 Nov 2026 11:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67580606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=cghn12iM
Received: from ideasonboard.com (mob-5-92-38-150.net.vodafone.it [5.92.38.150])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7410C177;
	Mon, 23 Nov 2026 12:10:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795432211;
	bh=OsiH9qpIq0gwPnTzaY/Wt8xuGbupdcCHjm7KALc0Brc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cghn12iM9S0IGyxxETI9ftgoDzhVWXAv4DRZYrICX/kMm3R9Wg0z7zAe9OjPF3hHK
	 lq7pILK5ZfzQ9vhyqNFHXmi0HKbsJBnHhKte9xzPwQWqAlDcloOEybWei3Kvs1veXa
	 Hk/kB0cTzdeGJO3z6iNqEvYlT7itmr6ieGH+ydRg=
Date: Mon, 23 Nov 2026 12:12:39 +0100
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Li Youhong <dayou5941@163.com>, Daniel Scally <dan.scally@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Nayden Kanchev <nayden.kanchev@arm.com>, linux-media@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] media: mali-c55: Keep IRQ requested during suspend
Message-ID: <awQYXLhEd2royiLw@zed>
References: <20261027-mali-c55-irq-supend-resume-v2-1-759b3f5b2cfd@kernel.org>
 <avMP-y1B9K0cp4M8@zed>
 <CAD++jLnuS9ZE8mRwkCizsqo3f40s5etqOJAUqLJNsCtE5eEkDg@mail.gmail.com>
 <awP0mKeNtrJj8zh6@zed>
 <CAD++jLnTCEPKG5hNtfQ8rbijxF8nsk3H_K+R4H+f1HJak3Dhvw@mail.gmail.com>
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
In-Reply-To: <CAD++jLnTCEPKG5hNtfQ8rbijxF8nsk3H_K+R4H+f1HJak3Dhvw@mail.gmail.com>

Hi Linus

On Mon, Nov 23, 2026 at 11:38:26AM +0100, Linus Walleij wrote:
> Hi Jacopo,
>
> On Mon, Nov 23, 2026 at 9:28 AM Jacopo Mondi
> <jacopo.mondi@ideasonboard.com> wrote:
>
> > So yeah, maybe Sashiko would tell you this is possible but I hardly
> > believe it is.
> > Anyway, there is a remote possibility for a window here, so let's
> > increase the pm runtime counter.
>
> I'm honestly not sure. The framework should ideally stop this
> from ever happening but I'm not good enough with the media
> framework to have even a vaguest idea of how to fix this.

The only way for this to happen is that all devices in the capture
pipeline probe before the ISP and when we register a notifier in
mali_c55_media_frameworks_init() the v4l2-async framework notices all
dependencies are there and calls mali_c55_notifier_complete() which
registers all device nodes. At this point we should have userspace
operating the pipeline before we get to installing the irq handlers
(which happens just after calling mali_c55_media_frameworks_init()).

Yes, there is a window there, but its so tiny I wonder if it we can
really ever hit it. But as we know the most unlikely things can
happen, let's take it into account even if unlikely ? What do you
think ?
>
> What happened is that I asked an LLM to review the code
> using the Sashiko scripts and it complains about this risk.
>

Exactly, this is one of the very far fetched issues bots tend to
report and for which we're receiving an increasing number of
not-really-required fixes for.

This is not your case of course, I'm just complaining about the
current state of affairs and the overload it imposes on reviewers and
maintainers :)

> > > PM reference. The probe reference keeps the ISP active until the IRQ is
> > > installed, so runtime suspend cannot call disable_irq() on an IRQ we
> > > haven’t requested yet. I’ll add a comment.
> >
> > A suspend will always follow a resume, and if a resume tries to enable
> > an irq before it is installed we'll have problems as well.
> >
> > If that's a real concern to you, shouldn't we install the irq handler
> > before enabling pm runtime and powering the device up ?
>
> Often that is not a good idea, because the IRQ line can
> be in an undefined state and give rise to interrupt storms
> if you do that. As soon as the irq handler is installed it gets
> unmasked by enable_irq().

Right, and those are probably the spurious IRQs I had seen when I first
tried to install irq handlers in probe(). I still question the idea of
having the irq vector being fully unmasked in POR state, but it's
probably a bit late to complain to hardware designers.

>
> Also right now the device is powered up
> by directly calling __mali_c55_power_on() in probe() maybe
> we should just let the PM runtime resume power it up
> for clarity?

The thing is that the driver doesn't depend on PM.

Honestly, I would just depend on PM everywhere these days.

>
> It's quite common to power up a device (enable clocks
> and de-assert resets) before enabling
> runtime PM though, that's what I usually do.

Isn't it happening here as well ? I see a call to
__mali_c55_power_on() before pm_runtime_enable().

>
> Remove problems:
>
> > > > > +     pm_runtime_disable(&pdev->dev);
> > > > > +     free_irq(mali_c55->irqnum, &pdev->dev);
>
> Note: here we disable runtime PM and free the IRQ and this will
> make sure no further IRQs appear from this point.
>
> But clocks can still be running and resets can still be
> de-asserted because there is no guarantee that runtime
> suspend has executed just because we disable pm_runtime.
>
> > > > >       mali_c55_media_frameworks_deinit(mali_c55);
> > > > > -     if (!pm_runtime_suspended(&pdev->dev)) {
> > > > > +     if (!pm_runtime_status_suspended(&pdev->dev)) {
> > > >
> > > > I guess this is required because you moved pm_runtime_disable() up
> > >
> > > The remove ordering is part of the IRQ lifetime change. Both runtime
> > > PM callbacks now assume the IRQ is installed, so we need to drain
> > > them befor free_irq(). Then free_irq() waits for the threaded handler
> > > before we unregister the media entities it uses.
> >
> > I'm sorry, this is certainly me missing some pm_runtime internals,
> > but where is this happening ?
>
> It's not a pm runtime thing more of a free_irq() thing,
> it will wait for outstanding threaded handlers to complete.

I see

>
> When we get here we know no further IRQs can happen, but we
> have no guarantee that runtime suspend has been called,
> so we check just like the old code did to make sure it
> gets de-clocked and resets are asserted.
>
> Compare with the old code:
>
> static void mali_c55_remove(struct platform_device *pdev)
> {
>         struct mali_c55 *mali_c55 = platform_get_drvdata(pdev);
>
>         mali_c55_media_frameworks_deinit(mali_c55);
>         if (!pm_runtime_suspended(&pdev->dev)) {
>                 __mali_c55_power_off(mali_c55);
>                 pm_runtime_set_suspended(&pdev->dev);
>         }
>         pm_runtime_disable(&pdev->dev);
>         kfree(mali_c55->context.registers);
> }
>
> Since IRQs are unregistered in the runtime suspend callback,
> this is not a problem here.
>
> > > That’s also why I switched to pm_runtime_status_suspended().
> > > It reports the actual status after pm_runtime_disable(), so we only
> > > power off the ISP if it’s still active.
> >
> > It seems to me pm_runtime_status_suspended() ignores the runtime
> > counter and is only there because you pm_runtime_disable() earlier ?
>
> Kind of, I guess it's a bad idea to free_irq() before disabling
> runtime PM?
>
> An alternative is to call pm_runtime_force_suspend() before
> free_irq() so you know for sure the device is powered off,
> I can try this if you like it better.

Reading the pm_runtime_force_suspend() documentation

 * Typically this function may be invoked from a system suspend callback to make
 * sure the device is put into low power state and it should only be used during
 * system-wide PM transitions to sleep states.  It assumes that the analogous
 * pm_runtime_force_resume() will be used to resume the device.

Do you think it is appropriate at remove() ?


>
> Hm actually that would probably be better... shall I try that?

Is pm_runtime_force_suspend() different than open coding

        pm_runtime_disable(&pdev->dev);
        if (pm_runtime_status_suspended(&pdev->dev) {
                __mali_c55_power_off(mali_c55);
                pm_runtime_set_suspended(&pdev->dev);
        }
        free_irq(mali_c55->irqnum, &pdev->dev);


Is it different because of the dev_pm_enable_wake_irq_check() (which I
don't the purpose of) ?

Anyway the implementation of pm_runtime_force_suspend() calls
pm_runtime_disable() first as your patch does, and we're really
looking at details here. Also, I'm a bit out of my experties area
here, so whatever seems appropriate to you should be fine with me as
well.

Thanks
  j

>
> Yours,
> Linus Walleij
