Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50116318EF4;
	Sun, 16 Aug 2026 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786902366; cv=none; b=XXg/f0OhjMymLrhghPVA0yfTdTVCZ6guoZsxwckKO7SaW2MX+UJ0WzeqcXdzm4wwjuFGyTPgf2YEbuPTHbEPvkYUQxoTY5pFMDf/EmcbPQ+NGwJ0hT7VNACHS/Da9IRHyAYn1nYnxhs6NPwXIraAxP6DmBV9dF00fbuf/3IQbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786902366; c=relaxed/simple;
	bh=U8/lHO7bNUJBgx+9HZXO1/MFvALZJyLBGBBtUS9ujOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X70jpt1WTJTSE5JBxDTs4oKJyx/X3jTYNqob+loOGwDoAm+I25QPzk2pbHHlK9Ej188uIz/7mISM4y4AiW1qRFoQJmqWYmH/22Ntuj4tj+JwlIyePaO4W1jXZq1hJtnQRXHBdQgp1CYJcNdoNBv02YbKRyp6ENvzhM3HUPhQjBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT6hNHY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT6hNHY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1A51F000E9;
	Sun, 16 Aug 2026 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786902364;
	bh=jwghG+wlU/H6vXyODbTWWoT5cNNlk8GRr6O30A+QvWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kT6hNHY8N3GpmcoKJYyyTnKLqfpikcGybvqktlEiDJw/MzznfFBfq8YOGwFimYKIZ
	 rEtw+/qYEAT0XfxaGVuYwbwfpRunbPm1eyDnXzXveyhkPDqwLtO4uobSca8bvOIVBr
	 +NJfQQ7pkWrKT1l8lickLvcLX0UEVrUebQ77xwiXsYVbgpDu9bd/hP7ti2lJVoDuqY
	 gDmyee9dJfAn9C5PqZH54iji6BXRQlFxOK6rj3T6lFLruKvCkjmZa/Zvh80VJslS0/
	 cQS6/sf/i805584zvvE+zvUJ/VRjvvXGpHHSF+crj4Ml0QpPlW8KLarTrdc1XyW2sr
	 Wwc25MURqUHdA==
Date: Sun, 16 Aug 2026 18:46:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap020a00f: drain irq_work after free_irq
Message-ID: <20260816184602.2dd023f6@jic23-huawei>
In-Reply-To: <20260806132923.468833-1-fanwu01@zju.edu.cn>
References: <20260806132923.468833-1-fanwu01@zju.edu.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 13:29:23 +0000
Fan Wu <fanwu01@zju.edu.cn> wrote:

> The threaded IRQ handler queues data->work through irq_work_queue() so
> the trigger is polled from a per-CPU context.  free_irq() does not flush
> an irq_work the handler already queued, so after gp2ap020a00f_remove()
> returns that work may still run and call iio_trigger_poll() on data->trig,
> which the devm cleanup has already freed, causing a use-after-free.
> 
> Add irq_work_sync(&data->work) after free_irq() in remove() and in the
> probe error path, mirroring commit 78601726d4a5 ("iio: trigger: sysfs:
> fix use-after-free on remove").
> 
> Found by an in-house static analysis tool, confirmed by manual review.
> 
> Fixes: bf29fbeaa13d ("iio: gp2ap020a00f: Add a driver for the device")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Hi,

Thanks for the patch. It looks correct to me but this is an old driver
and we'd not use an irq work at all these days. The reason it was used
was to ensure we could use the trigger from this device to drive capture
on another one that needed a top half.  However the top half (non threaded
bit) of trigger handlers only ever gets a timestamp, so we end up dancing
through
threaded_irq->irq_work->iio_pollfunc_get_timestamp->actualhander.
which almost certainly gives a less useful timestamp than
threaded_irq->actuallhandler without the irq_work part.
The slight risk is someone is actually using that timestamp in
a consumer and will find pf->timestamp is now always 0.  However
I think that's very unlikely with a light sensor (sensor fusion
doesn't really occur much like it does for inertial sensors)

So I think a better solution given you've identified a bug here, would be
to rip out the irq_work dance in favour of a direct call to
iio_trigger_poll_nested() instead of irq_work_queue() in 
gp2ap020a00f_thresh_event_handler()

That would mean also grabbing a timestamp locally in
gp2ap020a00f_trigger_handler() rather than using pf->timestamp()
+ dropping the use of iio_pollfunc_store_time.

A more invasive change, but one that lands us with a more modern solution
and removes the problematic code entirely.

Do you feel like taking that challenge on?  If so do it on top
of this patch because this one is going to be easier to backport.

Applied to the fixes-togreg branch of iio.git but note that won't
go upstream until after rc1 is released (and I'll rebase on that)

Thanks,

Jonathan


> ---
>  drivers/iio/light/gp2ap020a00f.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index c7df4b258e2c..20d1aa9e99d7 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1560,6 +1560,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
>  	iio_trigger_unregister(data->trig);
>  error_free_irq:
>  	free_irq(client->irq, indio_dev);
> +	irq_work_sync(&data->work);
>  error_uninit_buffer:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  error_regulator_disable:
> @@ -1582,6 +1583,7 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  	iio_trigger_unregister(data->trig);
>  	free_irq(client->irq, indio_dev);
> +	irq_work_sync(&data->work);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	regulator_disable(data->vled_reg);
>  }
> 

