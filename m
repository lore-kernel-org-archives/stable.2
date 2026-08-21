Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE68388873;
	Fri, 21 Aug 2026 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355424; cv=none; b=dzbAFgglZr4VqaUaUQ1S2q/LR0WaCZL+p2hwH0V+oa540BbOo4vYfFEgWEd7LX7SgYlTFmYkXUgO05g5EHvoY93twhwd75KKSj3MUXjzy2oxT7hYGoBQ9+kVd8zE1ZHVy34X9sqshQtC7K3Hud93iIOJZMNZAeKCHlr1gme82Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355424; c=relaxed/simple;
	bh=m5q74RqLvaYaSxFUIjS6oRfZsXvQh8h2gvEZZA8x3/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7oW8Fh2sl2frftvzj+ygXHmlhxf0dOdSllvU0b+0FJVzquz5mqm/SqjaO29SZOYv3TB6zt4YTak/HcwORzwKweCaFPyhVlGrc8DEVC6FlRwa20ERbG7VuWH3MxE6mFYEmDMHhw9bL3E92DdukyK/kTUTJlgeDvs9DI/6KbgI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h38Q+32S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h38Q+32S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B17B1F00A3A;
	Fri, 21 Aug 2026 23:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355421;
	bh=5V+eDhsR1l7gTGXw7zOCDC0m5/sh2YoqmdcVnpCZQgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h38Q+32ShgEFW6b9POQWwnB6vfv8kstTsH7+rsl0ZxCgsAAImPzvnHvCLlHL0QCfN
	 veKWjwInFjanmdb1/cOWNmjJNm3zYV1JKisFNLL2v1ta4R07B1/6xZmn3Q+XRgOTNw
	 SI8QANa+07C3R/L9wBffnkbBlFPV3winnEYG/9Y7A/Sw1AcDEnrUy5z4N7mnkj1fMv
	 dwCcjzjtKEo+auWxvDFS75TMvFvxd4x0KDdVKRzXNCPdftx1gEVT3e0SHVYqw3xccX
	 TzneA9HV0l8hNzmXNo6JDkequ4C9ASDpX3ZtNrQbf9q1PE8PMQvTjVM9A1mF/AGGpT
	 6L6gAlQ/EF7WQ==
Date: Sat, 22 Aug 2026 00:36:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Fan Wu <fanwu01@zju.edu.cn>, dlechner@baylibre.com, nuno.sa@analog.com,
 michal.simek@amd.com, conall.ogriofa@amd.com, bgolaszewski@baylibre.com,
 DileepKumar.Nagavarapu@amd.com, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: free IRQ before cancelling
 the unmask worker on unbind
Message-ID: <20260822003656.4cd11afe@jic23-huawei>
In-Reply-To: <c87bd58e-2c23-467e-8ae2-8398052ee8d5@amd.com>
References: <20260803080343.467906-1-fanwu01@zju.edu.cn>
	<c87bd58e-2c23-467e-8ae2-8398052ee8d5@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 23:27:37 +0530
Sai Krishna Potthuri <sai.krishna.potthuri@amd.com> wrote:

> On 8/3/2026 1:33 PM, Fan Wu wrote:
> > The ZYNQ XADC alarm IRQ handler queues zynq_unmask_work via
> > schedule_delayed_work(); that work is cleared by a devm callback.
> > Register the devm callback before devm_request_irq() so the devres LIFO
> > teardown frees the IRQ first, ensuring the handler can no longer queue
> > work by the time the workqueue is cleared. Otherwise the handler could
> > re-arm the work and run it after the xadc structure has been freed.
> > 
> > This issue was found by an in-house static analysis tool.
> > 
> > Fixes: 2a9685d1a3b7 ("iio: adc: xilinx: use more devres helpers and remove remove()")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5.6
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>  
> 
> Reviewed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> 

Applied to the fixes-togreg branch of iio.git.

I'll be rebasing that on rc1 once available.

Thanks,

Jonathan

> Regards
> Sai Krishna
> 
> 
> > ---
> > 
> > Changes in v2: shorten the commit message and replace the multi-line code
> > comment with a one-line note, per review feedback from Jonathan Cameron.
> > The devm registration reorder (the fix) is unchanged; David Lechner's
> > Reviewed-by was obtained on v1.
> > 
> >   drivers/iio/adc/xilinx-xadc-core.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> > --- a/drivers/iio/adc/xilinx-xadc-core.c
> > +++ b/drivers/iio/adc/xilinx-xadc-core.c
> > @@ -1395,13 +1395,14 @@ static int xadc_probe(struct platform_device *pdev)
> >   	}
> > 
> >   	if (irq > 0) {
> > -		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
> > -				       0, dev_name(dev), indio_dev);
> > +		/* Clear out any work queued by the interrupt */
> > +		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> > +					       &xadc->zynq_unmask_work);
> >   		if (ret)
> >   			return ret;
> > 
> > -		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> > -					       &xadc->zynq_unmask_work);
> > +		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
> > +				       0, dev_name(dev), indio_dev);
> >   		if (ret)
> >   			return ret;
> >   	}
> > --
> > 2.43.0  
> 

