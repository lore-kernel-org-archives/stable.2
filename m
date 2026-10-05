Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04E4854ED;
	Mon,  5 Oct 2026 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215183; cv=none; b=jJIFm46IeWsqgJ+RBKC/MzHVhg2H1W0wTb3z97TwkLt4eO7NlIR+w3OIDLCZOmRbHgme9DcnJEIqkp7F0HIm2lq9DfwJafye7DJHMJ6YwAL2jflBxdSeFx+Ux4s50EcgfJhRghlkFF9xPYkVlzO952U6P4yw6j2CcqM8gBdRp5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215183; c=relaxed/simple;
	bh=Tm4QouRk0x2Wa6QbwGwe3xbo7L5KYG//7pwWfoGqHI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNDxsZqcKm7rM4xfU57gOiLljz0YP7baczZt5sH63qkX44raNsuzBSMfYgaKXIcDrLzjvhkrExuGQWsE2NaEJqug0ngxIvhmJmLlrfzf6jZ9+ayCk/oUvzre9Cl4ysVePSQJzHzfMiTek/uz6gDw/LYhkdGHG21Jjehg+3G0WCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV4zmBmj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV4zmBmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAEC1F000FF;
	Mon,  5 Oct 2026 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215181;
	bh=22A7Ie5xqbZmB45xFidjN3s7sl8pmcD//SVzUGLYRAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lV4zmBmj5HvZnez9W30i/G8yWiYZrHwTes5SpSM3lPzu8exUoucY+AZJ8T94aOgbI
	 ujVravOdBvre5SA7iM5wvYrk2NU4oW5kz0z4hcjBL0fSkT22g5KFxS4Ylu0TsVptxX
	 42ctyXySRwKKt9T8d89nLyC+uuhwr/7b6nk2HhK1aKV3CjqQUByX1CLjg4NtOwXVT8
	 aQOAkbk5HVsSMge0IlHWzOByOJp/U9VjD0dfEaZ0oC0UYnkF7xSr6Vns605B6QfqZi
	 N3WBQKbl07ZuG0STMWeVym/0mSTogQzLWZkoCdKJkysf/2FQff+WcUReLy4Z5eTYa2
	 /ZJvdvkXg/gKA==
Date: Mon, 5 Oct 2026 17:46:17 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, brgl@kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v25] dmaengine: qcom: bam_dma: free interrupt before the
 clock in error path
Message-ID: <asPGSUbsCJNEZxa0@parshuram>
References: <20261002-bam-dma-free-irq-v25-1-f39e01d19910@oss.qualcomm.com>
 <ar_gqlHElQOGN9KV@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar_gqlHElQOGN9KV@lizhi-Precision-Tower-5810>

On 02-10-26, 12:49, Frank Li wrote:
> On Fri, Oct 02, 2026 at 10:51:47AM +0200, Bartosz Golaszewski wrote:
> > The BAM interrupt is requested with a devres helper and so on error it's
> > freed after probe() returns. We disable the clock before freeing or
> > masking it so it may still fire and we may end up reading BAM registers
> > with clock disabled.
> 
> It is less possible to happen. I see other methods to fix similar issues

Actually this is the right change. devres for irq was a bad idea IMO. We
need to ensure device is quiesced on free and ensure no tasklets can be
triggered. devm acts later and at such time we might get supurious/valid
irq triggering tasklet while we are unwinding...

> 
> https://lore.kernel.org/all/20260608001128.80090-1-dennylin0707@gmail.com/
> https://lore.kernel.org/dmaengine/20260927-dma40-fixes-v7-6-89f595e8851d@kernel.org/
> 
> >
> > Stop using devres for interrupts as we free it in remove() manually
> > anyway. Add an appropriate label and free the interrupt before disabling
> > the clock in error path and in remove().
> 
> Just want to avoid bounce in future, change back to devm version.
> 
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=2
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > ---
> > This used to be part of the larger BAM DMA pipe locking series and never
> > got picked up despite months on the list. I'm resending it separately.
> > ---
> > Changes in v25:
> > - Don't touch remove(), it's not wrong in its current version
> > - Link to v24: https://patch.msgid.link/20260723-qcom-qce-cmd-descr-v24-0-4f87bb4d9938@oss.qualcomm.com
> > ---
> >  drivers/dma/qcom/bam_dma.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> > index 05a3b1f9e0c23dc5f861488fae03494867970523..a626746b5c93496e5c5e885b35a856d38c284448 100644
> > --- a/drivers/dma/qcom/bam_dma.c
> > +++ b/drivers/dma/qcom/bam_dma.c
> > @@ -1332,8 +1332,8 @@ static int bam_dma_probe(struct platform_device *pdev)
> >  	for (i = 0; i < bdev->num_channels; i++)
> >  		bam_channel_init(bdev, &bdev->channels[i], i);
> >
> > -	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
> > -			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
> > +	ret = request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_HIGH,
> > +			  "bam_dma", bdev);
> >  	if (ret)
> >  		goto err_bam_channel_exit;
> >
> > @@ -1366,7 +1366,7 @@ static int bam_dma_probe(struct platform_device *pdev)
> >  	ret = dma_async_device_register(&bdev->common);
> 
> Can you update it use dmaenginem_sync_device_register() to update current
> base?
> 
> >  	if (ret) {
> >  		dev_err(bdev->dev, "failed to register dma async device\n");
> > -		goto err_bam_channel_exit;
> > +		goto err_free_irq;
> >  	}
> >
> >  	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
> 
> devm_of_dma_controller_register()
> 
> > @@ -1385,6 +1385,8 @@ static int bam_dma_probe(struct platform_device *pdev)
> >
> >  err_unregister_dma:
> >  	dma_async_device_unregister(&bdev->common);
> > +err_free_irq:
> > +	free_irq(bdev->irq, bdev);
> >  err_bam_channel_exit:
> >  	for (i = 0; i < bdev->num_channels; i++)
> >  		tasklet_kill(&bdev->channels[i].vc.task);
> > @@ -1410,7 +1412,7 @@ static void bam_dma_remove(struct platform_device *pdev)
> >  	/* mask all interrupts for this execution environment */
> >  	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
> 
> Actually there are problem
> 
> pm_runtime_force_suspend(&pdev->dev);  it will call suspend, which disable
> clk,
> 
> ...
> writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
> access register
> 
> clk_disable_unprepare(bdev->bamclk);
> 
> Maybe cause refcount overflow because previous pm_runtime_force_suspend().
> 
> Actually DMA driver seldom remove. It has another issue if still have
> consumer acquire channel because miss dev link between consumer and
> provider.
> 
> Anyways, if you resolve above runtime pm problem, irq problem may not
> existing.
> 
> Frank
> 
> >
> > -	devm_free_irq(bdev->dev, bdev->irq, bdev);
> > +	free_irq(bdev->irq, bdev);
> >
> >  	for (i = 0; i < bdev->num_channels; i++) {
> >  		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
> >
> > ---
> > base-commit: 9f24d789f03b22941b905ded43cb5ff8eea9ce62
> > change-id: 20261002-bam-dma-free-irq-cac4b268c465
> >
> > Best regards,
> > --
> > Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> >

-- 
~Vinod
