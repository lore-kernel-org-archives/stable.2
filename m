Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7537F006;
	Sun, 18 Oct 2026 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792351996; cv=none; b=mljz7SU8TTxFZqmODTV5TGYbyrgBFf2VbDHPbloJz9g4DMwRls7p0lpm26EN1CXO5tvZH4Q2RSqz759LJ0whtzUc8U/uao9sW/+tYJnadziGoqW5yk29FNt12p2Kt8ldsuV9Wk2L2mti14L6oEVBMG6JP2I0A4+7pl8o2vC6V/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792351996; c=relaxed/simple;
	bh=Fy5a8Ad8FtrT8omW95QZc/qDCW8ifkTkmipY4hokQc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOeZ8Nd9/WjkTDJVGuuE9LfPybxbIJ2MHudR/f6ZcBw/JCrvAmHMHt0QDCITBdMv4rYFFseL1PyUoACAf+kX90BOJZJWQdx1BspoP0jRzbxHAEbEXKHVhwGkdx/kRwfODTRFP7VDmPHgHEYu37pAmdG6TN1tFKP/6I6dOWFhrKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm/nNQaq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm/nNQaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA741F000C4;
	Sun, 18 Oct 2026 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792351995;
	bh=0Y/IZW4Yvf2IYqTkZ7FPQ1fSSBeRzp2TYz5EWjKxgpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rm/nNQaqrU9QS5vsTZbbaAdH8/8sooHXLr6vCsPorKD0J0WOShS8XmhhT05oyUBjg
	 KrAUiprJqUZK+ugiQFND4UCCUknkMfRNCJKgJM0AbHsivNt0oubTCh8AO+g8jhVQWU
	 HjlU816yOGoGg+ETNtDsd74uMizSwF7H6tZvYVepAY6j6HKAtvMt8ioFEQ3fst4xxe
	 8jnxlcKW1ZW5n5pf/Ynnrmemdeafnsy72p49eqRJNrPKvmWB2orsMFwS3EzL2uU4qO
	 kKso+Ki2bsQ/1YD3A1H894mbhDyPnI96V/uarou1Pi1Thbz2vYH7DWgohZQCVekjD8
	 WkbI+fT9ylH0g==
Date: Sun, 18 Oct 2026 20:33:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, nuno.sa@analog.com, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: temperature: hid-sensor-temperature: Use
 per-instance callbacks
Message-ID: <20261018203309.40dc466a@jic23-hlaptop>
In-Reply-To: <20261007184423.622445-3-ch@murgatroid.com>
References: <20261007072329.27806-1-ch@murgatroid.com>
	<20261007184423.622445-1-ch@murgatroid.com>
	<20261007184423.622445-3-ch@murgatroid.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Oct 2026 11:44:22 -0700
Christopher Hoover <ch@murgatroid.com> wrote:

> hid-sensor-temperature keeps a single static struct
> hid_sensor_hub_callbacks for all instances and overwrites its pdev in
> every probe.  With two temperature sensors, input reports for one are
> delivered with the other's platform device; once that device is
> removed, platform_get_drvdata() returns NULL and
> temperature_capture_sample() dereferences it:
> 
>   BUG: kernel NULL pointer dereference, address: 00000000000003a8
>   RIP: 0010:temperature_capture_sample+0xd/0x50 [hid_sensor_temperature]
> 
> The oops happens in sensor_hub_raw_event() with the hub's spinlock
> held, so the hub's removal then hangs.  It reproduces with two uhid
> devices that each declare a temperature sensor, one destroyed while
> the other still sends input reports.
> 
> Keep the callbacks in struct temperature_state, as the other HID
> sensor drivers (accel, gyro, als, ...) do.
> 
> Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christopher Hoover <ch@murgatroid.com>
Good find. Ouch.

One trivial suggestion inline that I think makes the change
a tiny bit more readable.

> ---
>  drivers/iio/temperature/hid-sensor-temperature.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
> index 5e3262e461f4..35b8643305b9 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -14,6 +14,7 @@
>  
>  struct temperature_state {
>  	struct hid_sensor_common common_attributes;
> +	struct hid_sensor_hub_callbacks callbacks;
>  	struct hid_sensor_hub_attribute_info temperature_attr;
>  	struct {
>  		s32 temperature_data;
> @@ -181,11 +182,6 @@ static int temperature_parse_report(struct platform_device *pdev,
>  	return ret;
>  }
>  
> -static struct hid_sensor_hub_callbacks temperature_callbacks = {
> -	.send_event = &temperature_proc_event,
> -	.capture_sample = &temperature_capture_sample,
> -};
> -
>  /* Function to initialize the processing for usage id */
>  static int hid_temperature_probe(struct platform_device *pdev)
>  {
> @@ -237,9 +233,11 @@ static int hid_temperature_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> -	temperature_callbacks.pdev = pdev;
> +	temp_st->callbacks.send_event = temperature_proc_event;
> +	temp_st->callbacks.capture_sample = temperature_capture_sample;
> +	temp_st->callbacks.pdev = pdev;

	temp_st->callbacks = (struct hid_sensor_hub_callbacks) {
		.send_event = temperature_proc_event,
		.capture_sample = temperature_capture_sample,
		.pdev = pdev,
	};

>  	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE,
> -					   &temperature_callbacks);
> +					   &temp_st->callbacks);
>  	if (ret)
>  		goto error_remove_trigger;
>  

