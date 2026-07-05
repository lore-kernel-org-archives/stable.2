Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA43750DC;
	Sun,  5 Jul 2026 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783292564; cv=none; b=ah8g3bKrtVpAa69lj2u79SChJtaxS8hQYHU33kUTnVKd1cht3fzl0VpIaG8o2Sh3kjwYSxrKy5QmXahd0whyeufCfbgwOE5ppg4rTO9FwARAwReKVlgnvrmyYP2s9tKl2LsxSNvHGd+v6HBE+mxZ7avxn0DTnI3HR7jWN7DVWtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783292564; c=relaxed/simple;
	bh=C8YbSHHOoCZssgu2pYNqHCgNW/kYdS4EyZx4x5gXAyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/MqOOQwzKIkGQV1emPwvBh90UhBKEwvSXL45PxoV8yG2efSX0KFr+pcOaPPnzjPPdSZWNETqquCirmTO2t8Q77fcuMiTQenVsLWtv2oHpn/2uzm0Cr2Enw6AVhySw5Ob+87iDDw2NVaRPfyJcl5yWFbq1psD/S0snrCD6GWthE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARTmV7FI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARTmV7FI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A971F000E9;
	Sun,  5 Jul 2026 23:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783292558;
	bh=bQpjCok8Mdg6npO2C0lYe5rB1L+nY9w4oK2c4uUJbtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ARTmV7FIyI2MBMJzcJN/1zYb+9ByC87fAMEzMO83xJlo1pVY6qlFHYFnTIAB/tLtN
	 rS3lAbhfFWp1LwV9miLPTH8i0hA1RcNkJcG372Kczs73eBNQ1mQDnkZmqSZ4o15nrk
	 clkGpQFJkXdmtOnIHgQMOkCVbZiaXyGoN2wnUU7iDfsV2HeMDPdD31wLbltrk2cB1M
	 /hi0FbXBFjvw0R9HytjZ7qrFej3n4YI/Z0I3ZrJJ05pfdos5v7avQPuN3P5FG6Ebaw
	 Cx6Ru3RICnbEzRqfF6z0uuczv1NjwDuL5UvcsR5xqhBRRcX/VEJ1GABuwDARK7DGUO
	 nmAr1Zh9mRP6A==
Date: Mon, 6 Jul 2026 00:02:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: free irq before teardown
Message-ID: <20260706000233.3104e0d3@jic23-huawei>
In-Reply-To: <20260705042731.388592-1-mlbnkm1@gmail.com>
References: <20260705042731.388592-1-mlbnkm1@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Jul 2026 06:27:31 +0200
Melbin K Mathew <mlbnkm1@gmail.com> wrote:

Hi Melbin,

Thanks for the patch,

> bmc150_accel_core_probe() requests the interrupt with
> devm_request_threaded_irq().  The managed IRQ is released only after the
> driver remove callback has returned unless it is freed explicitly.
> 
> bmc150_accel_core_remove() currently unregisters the IIO device and
> triggers, cleans up the triggered buffer, suspends the chip and disables
> the regulators while the IRQ action is still registered.  A late
> interrupt can therefore run the hard or threaded handler while the IIO
> trigger state is being torn down or after the device has been put into
> deep suspend.

For me this raises a load of questions.  In particular having the interrupt
torn down before we remove userspace interfaces (as occurs after this change)
is itself a big source of race conditions as we have to cope with userspace
being able to poke every interface with the interrupts missing.  So it is
a design pattern I'm very resistant to!

Anyhow, is this theoretical or have you seen it in practice? i.e. can we test
fixes? Are we talking spurious or shared interrupts, or is there a path in
which a race generates a real interrupt? My guess would be the thread
running a while after the interrupt but please confirm.  What is the effect
of talking to the device when powered down? Bus errors, stalls?  A quick
glance at the datasheet suggests some registers are fine, so this description
would need to say which ones that are accessed are not.  I think it's only
the fifo_data but I haven't checked the code or datasheet closely.  What
actually happens if we access that register? An error or garbage data?

Maybe we just turn the power on again in the thread handler? Vast majority of the
time that will just be a ref count increment and decrement, but in the race
here it will turn the power on again so no problem accessing the device.  
Or a local flag to say if accessing that fifo register is fine - if it's
not just erroring out on trying.

We do have internal infrastructure to close down races around
teardown (see the exist_lock and how iio_dev->info is set to NULL
which acts as a marker of a device going away - maybe we need to make
that available to drivers (though I'd rather not as it's easy to use
wrong!) I'm not aware of any core interfaces such as accessing the
buffers or open chardevs etc that are not appropriately guarded so
hopefully the races you are seeing are just at the driver
level. The usual route to handling this stuff is to make the interrupt
handling safe to the transitions that occur on tear down, not reorder
things to stop the handler running.  Note that making it safe
can absolutely include simply returning errors from accesses that don't
work due to power conditions.

> 
> Free the IRQ at the start of remove so that no handler is running while
> the rest of the driver state and hardware resources are dismantled.
> 
> Fixes: 55637c38377a ("iio: bmc150: Split the driver into core and i2c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 2398eb7e12cd..2adddc965650 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1766,6 +1766,9 @@ void bmc150_accel_core_remove(struct device *dev)
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  
> +	if (data->irq > 0)
> +		devm_free_irq(dev, data->irq, indio_dev);

If (and it is a very big if) this is the right thing to do then it must
be accompanied by documentation of why we need the remove to not be in
the reverse order of probe.  Also, rip out devm registration and
move to none devm for everything after the request of the irq.

Note that because userspace interfaces are still up at this point
we may well get normal operations generating unhandled interrupts, potentially
resulting in the interrupt core taking that interrupt offline.

It is for this reason that we generally disable userspace interfaces
first and then remove the interrupts.

Thanks,

Jonathan

> +
>  	iio_device_unregister(indio_dev);
>  
>  	pm_runtime_disable(dev);

