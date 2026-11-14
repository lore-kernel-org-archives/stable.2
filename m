Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794700285;
	b=3d31cQ7b7I9fw1s1DHgv4EpRKna3NwjTIPF7+RFZx8LZrhOflPnVPTaNYrroXkjDEpR2
	 Gt4MXPl/tGfyJn7BxRp5zMPqzSeZzprwwl9caU7xfjHaVTNudhDyDLeYunMDEH2evAK6U
	 32I+8XpBy5lzgiW5pDonaf1aqg/URJaAtmoBA1RYyXtpaUzU4X6VnI6BndOfaYxX9SdXN
	 COfDD5QL3NQT7eeZLLIMQJfX7E9KT/ked2JVrLxHUW29XMhCwv764b1XZuipUOhV3haXg
	 ZX7xcE9lTw9sXEdlfii7095SyWQEFn0Wp9rKud6Ui3+FsLXe/A880ZfqMzTOAHIP0jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700285;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HF4qsdT3pDO/lfjF2ZH17P5CQ+es7odDj7yyFf89T9Y=;
	b=ncozLKWInEAhLLbJELgs7FhlKtiYNy/8hVdVuURWop4eJPWnx0eYwRshaCLBu1XyOvae
	 kPLoyUGibK22KWaE29e7TT1QT0iprDQPe74sxnta83euvauxJltrrroQp3FvUshqrSvYO
	 OrxZ3RqIMuKVlvxCVrtHbpHmfk+dx+t2nKsjRpISbWhKD0GwB94ZMNir3N+iKczhofUPO
	 v1EOaXs8p+2x7z5/svBrDDrVxFLjhc9r9y3AuKwfkQmisPtbLZQm8wlgmdcvf91EVkDyY
	 +mdBJKSTPVx7rQhGBbQ2QrNesy+Qqh8fIHosZppU+qQ2k6+4udP3Am9ZbOnb+Z3UtmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDRtAQ5X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E3606A32C;
	Sat, 14 Nov 2026 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDRtAQ5X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403AE1F000C4;
	Sat, 14 Nov 2026 23:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794700285;
	bh=HF4qsdT3pDO/lfjF2ZH17P5CQ+es7odDj7yyFf89T9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UDRtAQ5XHWLxrVTJ0yTwuHz5KYEDGJg1pARtih6ncqeAocahr/ruYBqh47vBNhIze
	 pAPV/ulqN0jDWY0EtpX5arM+3FIMrgUL6ZXV+MArH9ZwxO730/TeZWMXM/oKNgjhXE
	 74WNisa6xCt9jx+B7Gipw9lSvcQcunfh+aFJA2rTiby5tHtzV7Eubxe6Q6uWM7AvSU
	 bxlOi2uhSLbh6KA4++h0QrQihC4TWW1RM6Dw66ckIjSc67CG3aiqn8s+tYgUv85vAC
	 etYZ2Zf9npP+XyYew9qEILl9975XQecDBRdncK+lh80ahnp9S4mjr9aJOURgIicQyG
	 Bz2ivr9F2+fUw==
Date: Sat, 14 Nov 2026 23:51:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yu Zhang <yuz08559@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: trigger: fix use-after-free in
 current_trigger_store() on concurrent writers
Message-ID: <20261114235118.4414bd1f@jic23-hlaptop>
In-Reply-To: <20261109095728.59024-1-yuz08559@gmail.com>
References: <20261109095728.59024-1-yuz08559@gmail.com>
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

On Mon,  9 Nov 2026 19:57:28 +1000
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
Sashiko quite right calls out that this should have a fixes tag.

Probably goes back a long way but please check and reply to this
thread with a suitable tag.

I think this patch looks correct but given it affects the core code
I would like to leave it a little longer and hopefully get some more
eyes on it!  Hence I'll not pick this up just yet.

Thanks

Jonathan

> ---
> v3:
>  - Add a blank line after the -EBUSY check and drop the one between
>    current_trigger_store() and DEVICE_ATTR_RW() (Andy Shevchenko).
>  - Move this changelog under the --- marker and send as a new thread
>    instead of in reply to v2 (Jonathan Cameron).
> v2: https://lore.kernel.org/all/20261102034532.33246-1-yuz08559@gmail.com/
>  - Move the trigger swap into a helper, iio_trigger_set_current(), and
>    take mlock with guard() in current_trigger_store() only, so that
>    guard() and the goto based cleanup of the newly acquired trigger are
>    not mixed in one function (Jonathan Cameron, Sashiko). No change to
>    the locking itself.
> v1: https://lore.kernel.org/all/20261026100246.68005-1-yuz08559@gmail.com/
> 
>  drivers/iio/industrialio-trigger.c | 60 +++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 76926fe..74058f6 100644
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
> +
> +	if (iio_dev_opaque->trig_readonly)
> +		return -EPERM;
> +
> +	return iio_trigger_set_current(indio_dev, buf, len);
> +}
>  static DEVICE_ATTR_RW(current_trigger);
>  
>  static struct attribute *iio_trigger_consumer_attrs[] = {

