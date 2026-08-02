Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8C22931F4;
	Sun,  2 Aug 2026 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696150; cv=none; b=MBvfBoyYnZI5SOU5tk/LsSML7duXYgvFRkvfbn3fHqaz9cMUDrFNLc32jiM6dM8bV9fb8RmHAFLKchd3/0bsur4GbffR29ui455jlgp4ICt0xEXWtGnomYxkR865O3spGyrtTRJBxqTEux8CYp76e6/c2M2cJ0RtvwSnKtQPZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696150; c=relaxed/simple;
	bh=RDdNclBMO0GcfSn+P8gxi9eSc7QEDJsVz1VgoCTlnlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldFZM0wenDgBWoYI1g8+wiCvb5RX4FzwPJa8Jjstnwn7mOZKi1shFXjxo7ubhZrJaZCDUjes58Rf15sSNSv3Rr37ES45660A35yzIjEq+dUwb+6YDHY6LYDtRYDK7QuMl+1/4ucHWTnoVv9xX26F/OQxtF1SyNRrtZidxybCvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh9HDnZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh9HDnZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815C11F000E9;
	Sun,  2 Aug 2026 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785696148;
	bh=oS63NQlYDX3UkgpwTZTp0r+Evq8Hp+633HbhULQ7qtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bh9HDnZMWR+fJPzAEZ1xUVocFpcMoa88bHHyFvH42apzT4DpvgmqYvwUpKniTdJK8
	 4Ehh5GlHvhDkzE0mv5uJOSSPMEczSiSjyQwzYsFxTK0OC7x9BqabBnqwc/uZebizIy
	 DeeXaG5aThrX60f1qzCuf3oUfwPOgKohvYGyKOSncXnuCVRLOvHZHswaE09Nu4uGeG
	 tiPGACKXlU/d8gLlWIZMdl0sGSKDvQJta3sZX2NuUyVHdIaG3Z4DeTtx+yKS68tAC4
	 NjOmCwQYV1Fm8zXCbRJh2LBxUDJ9dKRbAAt3ICYCyJiFxQkMcqBPbe7ImpBNTe4e9j
	 yVGZW1nNceBlA==
Date: Sun, 2 Aug 2026 19:42:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Fan Wu <fanwu01@zju.edu.cn>, nuno.sa@analog.com, michal.simek@amd.com,
 bgolaszewski@baylibre.com, DileepKumar.Nagavarapu@amd.com,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Conall O'Griofa
 <conall.ogriofa@amd.com>
Subject: Re: [PATCH] iio: adc: xilinx-xadc: free IRQ before cancelling the
 unmask worker on unbind
Message-ID: <20260802194133.467ae096@jic23-huawei>
In-Reply-To: <750f615a-c00f-4e98-9bcf-8fa8704acfba@baylibre.com>
References: <20260802082851.433476-1-fanwu01@zju.edu.cn>
	<750f615a-c00f-4e98-9bcf-8fa8704acfba@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 10:39:58 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/2/26 3:28 AM, Fan Wu wrote:
> > The ZYNQ XADC interrupt handler xadc_zynq_interrupt_handler() arms the
> > zynq_unmask_work delayed work via schedule_delayed_work() every time an
> > alarm condition is observed, and that worker re-arms itself for as long
> > as the alarm stays asserted.
> > 
> > In xadc_probe() the IRQ is requested with devm_request_irq() before the
> > devm_add_action_or_reset() that registers xadc_cancel_delayed_work().
> > Because devres release runs in LIFO order, on unbind the delayed work is
> > cancelled before the IRQ is freed. The IRQ is still live at that point,
> > so a pending alarm can make the handler run once more and re-arm
> > zynq_unmask_work after it has been cancelled; that instance then runs
> > after the xadc structure that embeds zynq_unmask_work has been freed, a
> > use-after-free in xadc_zynq_unmask_worker().
> > 
> > Register the cancel-work devm action before requesting the IRQ so devres
> > LIFO teardown frees (and synchronizes) the IRQ first, then cancels the
> > delayed work. After free_irq() the handler can no longer re-arm the
> > work, and the subsequent cancel_delayed_work_sync() drains any instance
> > armed just before the IRQ was torn down.
> > 

This seems a bit too verbose to me.  A simpler explanation might get to the
key detail faster. Something like:

The driver clears outstanding work using a devm callback. That work is
queued up by schedule_delayed_work() in the alarm irq handler.
Reorder the work clear to occur after the devm cleanup for the irq
ensuring no additional work can be queued after the workqueue is
cleared. In practice this means registering the devm callback earlier
than the call to devm_irq_request_threaded().

If this was AI generated description (which I do as well sometimes)
it is useful to tell the AI to be brief.

> > This issue was found by an in-house static analysis tool.
> > 
> > Fixes: 2a9685d1a3b7 ("iio: adc: xilinx: use more devres helpers and remove remove()")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5.6
> > Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> > ---
> > 
> >  drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> > --- a/drivers/iio/adc/xilinx-xadc-core.c
> > +++ b/drivers/iio/adc/xilinx-xadc-core.c
> > @@ -1395,13 +1395,16 @@ static int xadc_probe(struct platform_device *pdev)
> >  	}
> > 
> >  	if (irq > 0) {
> > -		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
> > -				       0, dev_name(dev), indio_dev);
> > +		/* devm LIFO: register the cancel-work action before the IRQ,
> > +		 * so unbind frees the IRQ first, then drains the work.
> > +		 */

Wrong comment style.  Otherwise this seems correct to me but I'd like the
AMD / Xilinx folk to take a look.  Added a couple more +CC.

Not sure we need the comment, or perhaps the comment should just be
/* Clear out an work queued by the interrupt */

> > +		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> > +					       &xadc->zynq_unmask_work);
> >  		if (ret)
> >  			return ret;
> > 
> > -		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> > -					       &xadc->zynq_unmask_work);
> > +		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
> > +				       0, dev_name(dev), indio_dev);
> >  		if (ret)
> >  			return ret;
> >  	}
> > --
> > 2.43.0
> >   
> 
> Makes sense.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

