Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6922F8EBC;
	Tue, 28 Jul 2026 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231339; cv=none; b=jlsOIcRCoCWOrWOwKZIcCe07AHJxNWqH9G6/2ErZXo41/Mks9rpUID7PUTLfm+OzGcAYldCQBiM6Ck2QOXAigqHrygaHeGzPmsr9jl8vUpVm4gENsQuCgxp2zrmjkd1LF/XtRD8ECxzcN8Nlu9RQcrsz/B3TCvHaRKNVG3mDK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231339; c=relaxed/simple;
	bh=Ob/coHE8OCK92nlrJkaJc4kArnAe3vSeZjsRkIg+JU4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JLx1RZTbkRJPcMRC+xRwgu3fBGDDcrXhJEA52fp5RT8VyXhdbZU3a9h9+/Z6RNjI+oTCcupJA0EawGbbD5F9AprzTWwAY2s3K0lkUzVDPj+TQUH33Iu4tYqUZxI5v6KxgJfW101pqcEcffG+3910GI8Mvjj8CU3bJpuMe0rCY94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRAztIUk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRAztIUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6919C1F000E9;
	Tue, 28 Jul 2026 09:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785231338;
	bh=lB1j5vjNnb18HYzlPKpxEVTAQb2iWXZs7YH7JqgUJzk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=aRAztIUk82zzNys6oy483oZ8fhU5KRsKHjDOAv1SHuf6GvKD+tZNFWWyqK5yx2ACR
	 CKCsn8cKz03w7YUs+u5Gnw8iLVos3MgzAXVzj4wmBY6Ve6AmneXHwF17YUuBcRzKzp
	 upZjcRyb04XaGxc/jTJ+F7yhdspg9KhAMaEZY9GUQ1DAWlSmxFjpXqxKAN9lxHQoLk
	 AWO3NfnzHgvTgbJyiMvZljhZhNqq2kTGTTmbHqo4D3wgXcBusk+GZpIIgdbJfqgNvr
	 Xgxkx/ik655phstCPkNGmSJknfkuoZeivdMD+3BsE8YcscUMzqTXV7yNhZ4GeOdYSk
	 iVXrOz7XIcNrA==
Message-ID: <a4f5c93d-e323-4926-97fa-f65ddd40bd51@kernel.org>
Date: Tue, 28 Jul 2026 11:35:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v4 15/15] media: rc: Fix race condition during
 rc_register_device()
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1785158244.git.sean@mess.org>
 <5479a9288629888ea5a9f25b5ac03a7384d1dce3.1785158244.git.sean@mess.org>
Content-Language: en-US, nl
In-Reply-To: <5479a9288629888ea5a9f25b5ac03a7384d1dce3.1785158244.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/07/2026 15:18, Sean Young wrote:
> The correct sequence for rc core is so:
> 
>      rc_allocation_device()
> 
>      /*
>       * setup hardware and now calls to ir_raw_event_store etc are
>       * permitted, as well as rc_keydown. There is no rc device in sysfs
>       * or lirc chardev.
>       */
>      rc_register_device()
> 
>      /*
>       * After rc_register_device(), the rc device can be used now from lirc
>       * chardev, sysfs and IR is now decoded and reported.
>       */
> 
>      rc_unregister_device()
>      /*
>       * User space can no longer access /dev/lirc or the rc sysfs
>       * attributes. They will get -ENODEV if they still have a file
>       * descriptor open.
>       * Calls to ir_raw_event_handle() etc or rc_keydown() are permitted
>       * but they must stop before the call to rc_free_device(), so
>       * this is the time to stop the hardware.
>       */
>      rc_free_device()
> 
> This means that during rc_register_device(), we can get calls to
> ir_raw_event_{store,handle,overflow,store_with_filter}. Ensure this
> is done race-free.
> 
> Fixes: a3572c34da8d ("V4L/DVB: ir-core: Add logic to decode IR protocols at the IR core")
> Signed-off-by: Sean Young <sean@mess.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/media/rc/rc-ir-raw.c | 20 +-------------------
>  drivers/media/rc/rc-main.c   | 19 +++++++++++--------
>  2 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
> index b32f3cff9401..bebb45ffa971 100644
> --- a/drivers/media/rc/rc-ir-raw.c
> +++ b/drivers/media/rc/rc-ir-raw.c
> @@ -71,9 +71,6 @@ static int ir_raw_event_thread(void *data)
>   */
>  int ir_raw_event_store(struct rc_dev *dev, struct ir_raw_event *ev)
>  {
> -	if (!dev->raw)
> -		return -EINVAL;
> -
>  	dev_dbg(&dev->dev, "sample: (%05dus %s)\n",
>  		ev->duration, TO_STR(ev->pulse));
>  
> @@ -102,9 +99,6 @@ int ir_raw_event_store_edge(struct rc_dev *dev, bool pulse)
>  	ktime_t			now;
>  	struct ir_raw_event	ev = {};
>  
> -	if (!dev->raw)
> -		return -EINVAL;
> -
>  	now = ktime_get();
>  	ev.duration = ktime_to_us(ktime_sub(now, dev->raw->last_event));
>  	ev.pulse = !pulse;
> @@ -129,9 +123,6 @@ int ir_raw_event_store_with_timeout(struct rc_dev *dev, struct ir_raw_event *ev)
>  	ktime_t		now;
>  	int		rc = 0;
>  
> -	if (!dev->raw)
> -		return -EINVAL;
> -
>  	now = ktime_get();
>  
>  	spin_lock(&dev->raw->edge_spinlock);
> @@ -166,9 +157,6 @@ EXPORT_SYMBOL_GPL(ir_raw_event_store_with_timeout);
>   */
>  int ir_raw_event_store_with_filter(struct rc_dev *dev, struct ir_raw_event *ev)
>  {
> -	if (!dev->raw)
> -		return -EINVAL;
> -
>  	/* Ignore spaces in idle mode */
>  	if (dev->idle && !ev->pulse)
>  		return 0;
> @@ -200,9 +188,6 @@ EXPORT_SYMBOL_GPL(ir_raw_event_store_with_filter);
>   */
>  void ir_raw_event_set_idle(struct rc_dev *dev, bool idle)
>  {
> -	if (!dev->raw)
> -		return;
> -
>  	dev_dbg(&dev->dev, "%s idle mode\n", idle ? "enter" : "leave");
>  
>  	if (idle) {
> @@ -226,7 +211,7 @@ EXPORT_SYMBOL_GPL(ir_raw_event_set_idle);
>   */
>  void ir_raw_event_handle(struct rc_dev *dev)
>  {
> -	if (!dev->raw || !dev->raw->thread)
> +	if (!dev->raw->thread)
>  		return;
>  
>  	wake_up_process(dev->raw->thread);
> @@ -612,9 +597,6 @@ EXPORT_SYMBOL(ir_raw_encode_carrier);
>   */
>  int ir_raw_event_prepare(struct rc_dev *dev)
>  {
> -	if (!dev)
> -		return -EINVAL;
> -
>  	dev->raw = kzalloc_obj(*dev->raw);
>  	if (!dev->raw)
>  		return -ENOMEM;
> diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
> index dda3479ea3ad..d93e98189c1a 100644
> --- a/drivers/media/rc/rc-main.c
> +++ b/drivers/media/rc/rc-main.c
> @@ -1701,14 +1701,24 @@ static const struct device_type rc_dev_type = {
>  struct rc_dev *rc_allocate_device(enum rc_driver_type type)
>  {
>  	struct rc_dev *dev;
> +	int ret;
>  
>  	dev = kzalloc_obj(*dev);
>  	if (!dev)
>  		return NULL;
>  
> +	if (type == RC_DRIVER_IR_RAW) {
> +		ret = ir_raw_event_prepare(dev);
> +		if (ret < 0) {
> +			kfree(dev);
> +			return NULL;
> +		}
> +	}
> +
>  	if (type != RC_DRIVER_IR_RAW_TX) {
>  		dev->input_dev = input_allocate_device();
>  		if (!dev->input_dev) {
> +			ir_raw_event_free(dev);
>  			kfree(dev);
>  			return NULL;
>  		}
> @@ -1724,6 +1734,7 @@ struct rc_dev *rc_allocate_device(enum rc_driver_type type)
>  		spin_lock_init(&dev->rc_map.lock);
>  		spin_lock_init(&dev->keylock);
>  	}
> +
>  	mutex_init(&dev->lock);
>  
>  	dev->dev.type = &rc_dev_type;
> @@ -1917,12 +1928,6 @@ int rc_register_device(struct rc_dev *dev)
>  		dev->sysfs_groups[attr++] = &rc_dev_wakeup_filter_attr_grp;
>  	dev->sysfs_groups[attr++] = NULL;
>  
> -	if (dev->driver_type == RC_DRIVER_IR_RAW) {
> -		rc = ir_raw_event_prepare(dev);
> -		if (rc < 0)
> -			goto out_minor;
> -	}
> -
>  	if (dev->driver_type != RC_DRIVER_IR_RAW_TX) {
>  		rc = rc_prepare_rx_device(dev);
>  		if (rc)

I don't see what the race condition is you are trying to solve. AFAICT the sysfs
files aren't created until the device_add() function that is right after this line.

I'm probably missing something, but that would mean that the commit log needs to
be improved.

Regards,

	Hans

> @@ -1979,8 +1984,6 @@ int rc_register_device(struct rc_dev *dev)
>  out_rx_free:
>  	ir_free_table(&dev->rc_map);
>  out_raw:
> -	ir_raw_event_free(dev);
> -out_minor:
>  	ida_free(&rc_ida, minor);
>  	return rc;
>  }

