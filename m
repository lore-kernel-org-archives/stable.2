Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794102207;
	b=o7Pk1czaG07bj4NqNBoIqrZBxaSrQRmEOpciRKd8Meimibaf0+Q1uoFqcbMbwq0uq7K3
	 WlBprK05g72BAuS7MNClhEKDAlvis27Kpstb6TBFMvhCvmhz3Hcg47W72apN+9bODiY+4
	 iBZskL+VafD6szSQfNXVHDiIrLSf9CC0YYEurgLKyATnZNUK7Z/0ZRACyLo8xk6a/FhV6
	 FP8kS6Ho0EwlTAWxLkHmZiHHDknK7w150qa3ICc/urhaPctZA9o5okULDVIBEcS0IYaCO
	 IlFHPYhqbRl7jywR4RO+wYQ7ppfy/dvQsk7SSD3a57j3YsLv/XRHeh8khBD2wtFCTFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794102207;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZQi+wcGN8BItwBcnAAUfIFwj+xckksHXa0HxYHO7oKU=;
	b=k3n0kf7dl/GnzIGqYjTzc+Rqx8peVegDakQyvm9LL4nnjbqLcMIkUdag5YfnScofRTIM
	 W1SfdSj2HlGJY8/H58XN8reGUzUcnJKDn9Nuf8HnqomVBWYPs8EpykrPHJ6JflC0yCvdD
	 95j/iVziZ0UL0uNHvt1er4ezCaQ2AfwKfxL4m79d2KRxnRDOkR0CUINiV4whTNOLWGn5S
	 Xdl5noG59bGAL7Z48UsXA48Y248eGo78B7cat6S2KVgWNZGoBp3U784jCHRd++Yewzlyz
	 iiNA92pzaCuLD6zDsUEpCZV++uKy8Cc9f2d2j3mdPennEWXlofFGu8icvY10ZhRG3Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zswwzr1b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3196606A326;
	Sun,  8 Nov 2026 01:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zswwzr1b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A091F0089F;
	Sun,  8 Nov 2026 01:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794102206;
	bh=ZQi+wcGN8BItwBcnAAUfIFwj+xckksHXa0HxYHO7oKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zswwzr1b91kHAuL5JCCtAuMU22HLbhIViY10SDT8yb0U90JcrVuYn+wr/XVz8hAOH
	 zkWpFgYuE5hooD+3UcFXvuqaO9OpGqcCgBd/ixM5cogtSh9K4d38LFzsnzrmwMeyaW
	 M9nJgQttR5LEUAvzBmowUcsv7Fq9XiczLabjfdRywMhZtVZh0iorNC2CHxvkKad074
	 N3GBt32vYaCaTppksqq42tEkSVTDUdAGpxPiZNxp43TelIEHsz5zS2VcpJpZgFOyd6
	 wKIh3YzBeuCEGtFF0GFwP+MoW0E+Dy3JMUUPSpoX5iy6CNp2Hy4PNRbK8pKOEKOwzp
	 mUgE1PZQLtqCg==
Date: Sun, 8 Nov 2026 01:43:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yu Zhang <yuz08559@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: fix use-after-free in
 current_trigger_store() on concurrent writers
Message-ID: <20261108014320.3f437f2c@jic23-hlaptop>
In-Reply-To: <20261102034532.33246-1-yuz08559@gmail.com>
References: <20261026100246.68005-1-yuz08559@gmail.com>
	<20261102034532.33246-1-yuz08559@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Nov 2026 13:45:32 +1000
Yu Zhang <yuz08559@gmail.com> wrote:

> current_trigger_store() holds iio_dev_opaque->mlock only around the
> INDIO_BUFFER_TRIGGERED / trig_readonly checks and then drops it. The rest
> runs unlocked: it reads the current trigger into oldtrig, acquires the new
> one by name, stores it into indio_dev->trig, and drops the old trigger's
> reference with iio_trigger_put().
> 
> sysfs does not serialize writes to the same attribute issued through
> different open file descriptors (each open has its own kernfs_open_file),
> so two threads can run current_trigger_store() on the same
> .../trigger/current_trigger concurrently. Both read the same oldtrig, both
> overwrite indio_dev->trig, and both call iio_trigger_put(oldtrig). The
> extra put drops the trigger's refcount to zero while it is still in use,
> frees it, and a concurrent writer then dereferences the freed trigger.
> 
> With two sets of writers hammering current_trigger between two software
> triggers on an iio_dummy device, KASAN reports:
> 
>   refcount_t: addition on 0; use-after-free.
>   WARNING: CPU: 3 PID: 3467 at refcount_warn_saturate+0xbb/0xe0
>    kobject_get+0xf6/0x100
>    current_trigger_store+0x15c/0x4b0
>   ...
>   BUG: KASAN: slab-use-after-free in current_trigger_store+0x168/0x4b0
>   Freed by task 3468:
>    kobject_put+0x125/0x220
>    current_trigger_store+0x2cc/0x4b0
>   Allocated by task 3454:
>    __iio_trigger_alloc+0xc7/0x100
>   ...
>   Oops: general protection fault
>    __module_get+0x27/0xd0
>    current_trigger_store+0x192/0x4b0
> 
> Hold mlock across the whole operation so that reading oldtrig, swapping
> indio_dev->trig and dropping the reference are atomic with respect to
> other writers (and to buffer enable, which the -EBUSY check guards).
> Acquiring the new trigger with iio_trigger_acquire_by_name() under mlock
> is safe: it only takes iio_trigger_list_lock, and the buffer path already
> calls iio_trigger_{attach,detach}_poll_func() with mlock held.
> 
> The trigger swap itself keeps its goto based cleanup of the newly
> acquired trigger, so move it into a helper and take mlock with guard()
> in current_trigger_store() around the mode checks and the helper call,
> rather than mixing guard() and goto in one function.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
> ---

A process thing.  The change log that you have at end of
the file goes here.

Also don't send a new version in reply to a previous one.
Sometimes it confuses tools, but more relevantly it
ensures that your thread is way way back in a kernel
reviewers email so by the time the reach if if they ever
do they are half asleep!

Otherwise nothing to add on the actual patch to what Andy
already sent.

>  drivers/iio/industrialio-trigger.c | 60 +++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 76926fe..cfc6af0 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -421,37 +421,14 @@ static ssize_t current_trigger_show(struct device *dev,
>  	return 0;
>  }
>  
> -/**
> - * current_trigger_store() - trigger consumer sysfs set current trigger
> - * @dev:	device associated with an industrial I/O device
> - * @attr:	device attribute that is being processed
> - * @buf:	string buffer that holds the name of the trigger
> - * @len:	length of the trigger name held by buf
> - *
> - * For trigger consumers the current_trigger interface allows the trigger
> - * used for this device to be specified at run time based on the trigger's
> - * name.
> - *
> - * Return: negative error code on failure or length of the buffer
> - *	   on success
> - */
> -static ssize_t current_trigger_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t len)
> +/* Must be called with iio_dev_opaque->mlock held. */
> +static ssize_t iio_trigger_set_current(struct iio_dev *indio_dev,
> +				       const char *buf, size_t len)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	struct iio_trigger *oldtrig = indio_dev->trig;
>  	struct iio_trigger *trig;
>  	int ret;
>  
> -	scoped_guard(mutex, &iio_dev_opaque->mlock) {
> -		if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
> -			return -EBUSY;
> -		if (iio_dev_opaque->trig_readonly)
> -			return -EPERM;
> -	}
> -
>  	trig = iio_trigger_acquire_by_name(buf);
>  	if (oldtrig == trig) {
>  		ret = len;
> @@ -492,6 +469,37 @@ out_trigger_put:
>  	return ret;
>  }
>  
> +/**
> + * current_trigger_store() - trigger consumer sysfs set current trigger
> + * @dev:	device associated with an industrial I/O device
> + * @attr:	device attribute that is being processed
> + * @buf:	string buffer that holds the name of the trigger
> + * @len:	length of the trigger name held by buf
> + *
> + * For trigger consumers the current_trigger interface allows the trigger
> + * used for this device to be specified at run time based on the trigger's
> + * name.
> + *
> + * Return: negative error code on failure or length of the buffer
> + *	   on success
> + */
> +static ssize_t current_trigger_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +	guard(mutex)(&iio_dev_opaque->mlock);
> +
> +	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
> +		return -EBUSY;
> +	if (iio_dev_opaque->trig_readonly)
> +		return -EPERM;
> +
> +	return iio_trigger_set_current(indio_dev, buf, len);
> +}
> +
>  static DEVICE_ATTR_RW(current_trigger);
>  
>  static struct attribute *iio_trigger_consumer_attrs[] = {
> ---
> v2:
>  - Move the trigger swap into a helper, iio_trigger_set_current(), and
>    take mlock with guard() in current_trigger_store() only, so that
>    guard() and the goto based cleanup of the newly acquired trigger are
>    not mixed in one function (Jonathan Cameron, Sashiko). No change to
>    the locking itself.
> v1: https://lore.kernel.org/all/20261026100246.68005-1-yuz08559@gmail.com/
> 

