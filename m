Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215D23504B;
	Sun,  2 Aug 2026 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785695551; cv=none; b=dC53MZCC99JxK6ai4owIb/3q9OwA5Lcw4YGGo4RZx/ksJ0eMt5gDpMLAo5ccH+zlqR+ytWrNPGISfgXpWDyNGasPSoM4wMVlsPRs9V+z9w6B41opDoeRplgmMNX97+NLT4BMxdm/f1GaPRebH4K5PuPzHukXqnpD8o3jtbkqlLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785695551; c=relaxed/simple;
	bh=JloHv8PwHYhzJlqE75AHsRMeALYFuXVhUZbtf1hnkww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+jy63OcMiDN9MRqJDAmD3tWbLvjgi/MBKMcmLatIR7CwgCBLcC8TiYilSbD2G4bHE9YfOeJgQc9SdPn1vPoheTd4hPOw+PK9mwdm9h6IEwsrJnwHYePgo6jHw5WKIkdNbreSmySRuSE8U/HvGhZ/dekldm2P5HRHhghr4pRDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOFtjuZe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOFtjuZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFDD1F000E9;
	Sun,  2 Aug 2026 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785695548;
	bh=jIA9ZVx8PyWBnxesA2G9zsi4wxw8T9NgAK+26zwicsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aOFtjuZe3y6QliGB9wYVn/Qzohs3dgnCqpVO38P2mF4gCXkoVYdRaZD5iuarshpUk
	 WHX4xR9BcRfc2z0pP3I18CSNJNVYdil5X3fG3YvnjI4Dofj5RBpA9t0NjxnRUFTY4J
	 T+Mtu9PZqNGfDcHNunkOfFaWNSOAKF8LWvbE5vtJMHOIK5rCzncL3q7MV0/sZbMiNC
	 zFqvqK4++yYkkUQjqprWfNDQu0y1/91k6aG0QPkxZ8D2N27jGoxhoACag9EMat+ej2
	 xmZ7W1XyDzIBxLFkn0y1YXThMWLkru9Osbus4kGU4YV3cnc0cghs3Lw9NgIfvnyGEU
	 0nnApJRdN3KUw==
Date: Sun, 2 Aug 2026 19:32:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: mranostay@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Matt Ranostay <matt@ranostay.sg>
Subject: Re: [PATCH] iio: chemical: atlas-sensor: use
 iio_trigger_poll_nested() to fix remove UAF
Message-ID: <20260802193224.1a565cbe@jic23-huawei>
In-Reply-To: <20260802071858.430780-1-fanwu01@zju.edu.cn>
References: <20260802071858.430780-1-fanwu01@zju.edu.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Aug 2026 07:18:58 +0000
Fan Wu <fanwu01@zju.edu.cn> wrote:

> The atlas driver requests its hardware data-ready IRQ with
> devm_request_threaded_irq(); its threaded handler queues an irq_work,
> atlas_work_handler(), that calls iio_trigger_poll(data->trig).
> 
> The IRQ is devm-managed, so free_irq() runs from the devres unwind after
> atlas_remove() returns without flushing that irq_work.  Once a buffer is
> enabled, conversion-complete IRQs keep firing and queueing it; a pending
> irq_work can therefore run after the unwind has freed atlas_data/indio_dev
> and the trigger, when atlas_work_handler() derives the atlas_data pointer
> via container_of() and dereferences data->trig, a use-after-free.
> 
> Call iio_trigger_poll_nested() directly from the threaded handler instead
> of bouncing through irq_work.  free_irq() then drains the threaded handler,
> closing the window; other iio drivers with a threaded data-ready IRQ do the
> same (e.g. bmi270).
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 7103b99b031c ("iio: chemical: atlas-ph-sensor: reorg driver to allow multiple chips")
> Cc: stable@vger.kernel.org # v6.4+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Added another email address for Matt.

There are reasons why he might have got the irq_work route but I can't
recall if they applied.  What we lose here is the ability to hang
other consumers that need a top half of the trigger.  If that doesn't
matter then agreed your solution is the cleanest path forwards.

One day someone will get the time to make combining nested
trigger handling with top halves cleverer than current approach of
just not running them.

Jonathan


> ---
> 
>  drivers/iio/chemical/atlas-sensor.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -13,7 +13,6 @@
>  #include <linux/mutex.h>
>  #include <linux/err.h>
>  #include <linux/irq.h>
> -#include <linux/irq_work.h>
>  #include <linux/i2c.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/regmap.h>
> @@ -88,7 +87,6 @@ struct atlas_data {
>  	struct iio_trigger *trig;
>  	const struct atlas_device *chip;
>  	struct regmap *regmap;
> -	struct irq_work work;
>  	unsigned int interrupt_enabled;
>  	/* 96-bit data + 32-bit pad + 64-bit timestamp */
>  	__be32 buffer[6] __aligned(8);
> @@ -437,13 +435,6 @@ static const struct iio_buffer_setup_ops atlas_buffer_setup_ops = {
>  	.predisable = atlas_buffer_predisable,
>  };
> 
> -static void atlas_work_handler(struct irq_work *work)
> -{
> -	struct atlas_data *data = container_of(work, struct atlas_data, work);
> -
> -	iio_trigger_poll(data->trig);
> -}
> -
>  static irqreturn_t atlas_trigger_handler(int irq, void *private)
>  {
>  	struct iio_poll_func *pf = private;
> @@ -470,7 +461,7 @@ static irqreturn_t atlas_interrupt_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct atlas_data *data = iio_priv(indio_dev);
> 
> -	irq_work_queue(&data->work);
> +	iio_trigger_poll_nested(data->trig);
> 
>  	return IRQ_HANDLED;
>  }
> @@ -666,8 +657,6 @@ static int atlas_probe(struct i2c_client *client)
>  		goto unregister_trigger;
>  	}
> 
> -	init_irq_work(&data->work, atlas_work_handler);
> -
>  	if (client->irq > 0) {
>  		/* interrupt pin toggles on new conversion */
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
> --
> 2.43.0
> 
> 

