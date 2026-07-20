Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81313E8C5A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586931; cv=none; b=RTF8hE17RWaAujaCUt5G6kV7zZzZO27CMFZrFhaxshMh+Dw59+rLck93M6xxZ8oCwR5zT+R7m++lHHlj2zK9EMr9m/vfYTmArNRLkuPsD0qh4oX6thdrfzkASH2zU0aK/Croi7xGMvmTi2x+izrm/eezzfKy6frO+IqI1wvNGLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586931; c=relaxed/simple;
	bh=uEt1ZfvOIhSMqFSrDpNNSXy46Xl2tf08xHqmp84nOOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lH7XioHwDF4YcADNhsvATfe8BAdxtAzFSTOd9AKHtno5qm7nSLhPKFQy0esM1jb1rUOKxWnM3mydKdBLLd0fievmvpGDjmtNHY6OZ3hQj8SylAtgVizIgpsRY42cxQmyGXiWQwra21nF80ukogcf3L2BGnJqzOaR2tZxOH1PvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DsAjVZfr; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DsAjVZfr"
Message-ID: <da89a51e-3e42-4bcb-8e80-c992b1887ac8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784586917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAO7nuZkrP3BMOm91ZZdHZhzuQlIkM/mfZwP7l71+Qk=;
	b=DsAjVZfr469v8pMSmbbGyECgAwBZ3f4GOYlNpIx/ceMvaI47P/pNIi+XKtlb+aZxSmWV6a
	eScinbjp6saWNc93weSfamlyY/7a3cL+RMyBH/Zx7wgGYi7T5kr0pdbWvIiLR5mFurDTiD
	/0CY7Ze8Fnt9cZbc4O72ikHV9R6H0c4=
Date: Mon, 20 Jul 2026 23:35:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH can v3] can: gs_usb: fix hardware timestamp state for
 mixed channels
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>, mkl@pengutronix.de,
 mailhol@kernel.org
Cc: uwu@coelacanthus.name, kees@kernel.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260720184042.1712217-1-shuangpeng.kernel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260720184042.1712217-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20.07.2026 19:40, Shuangpeng Bai wrote:
> The hardware timestamp state is shared by struct gs_usb, but
> gs_can_open() and gs_can_close() tie its initialization and teardown to
> active_channels and to the feature bits of the channel being opened or
> closed.
> 
> This is wrong for mixed-channel devices in both directions. If a
> non-timestamp channel opens first, a later timestamp-capable channel does
> not initialize the shared cyclecounter/timecounter because active_channels
> is already non-zero. Timestamp RX then calls timecounter_cyc2time() with
> parent->tc.cc unset.
> 
> Conversely, if a timestamp-capable channel opens first and starts the
> shared delayed work, then closes while a non-timestamp channel remains
> active, disconnect may close the non-timestamp channel last. The old
> teardown check skips gs_usb_timestamp_stop() in that case and frees
> struct gs_usb while the delayed work timer is still queued.
> 
> Count the number of active timestamp-capable channels instead. Start the
> shared timestamp state when the first such channel opens, stop it when the
> last such channel closes, and unwind the count if open fails.
> 
> Initialize the shared timestamp lock and delayed work once during probe.
> The first timestamp-capable channel may be opened while RX URBs are
> already active, so guard the count and timecounter access with the same
> lock. Keep the count zero until timecounter_init() completes, and make RX
> and delayed work skip the timecounter while the count is zero.
> 
> Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> ---
> Changes in v3:
> - Drop Suggested-by tag.
> - Move active_timestamp_channels management into the timestamp init/stop
>    helpers.
> - Protect active_timestamp_channels with tc_lock, and keep it zero until
>    timecounter_init() has completed.
> - Make RX timestamp conversion and the delayed work skip the timecounter
>    while no timestamp-capable channel is active.
> - Initialize the shared timestamp lock and delayed work once during probe.
> 
> Changes in v2:
> - Count active timestamp-capable channels instead of tracking only whether
>    the shared timestamp worker has been started.
> - Stop the shared timestamp worker when the last timestamp-capable channel
>    closes, even if non-timestamp channels remain open.
> - Unwind the timestamp-capable channel count on gs_can_open() failures.
> 
>   drivers/net/can/usb/gs_usb.c | 81 ++++++++++++++++++++++++------------
>   1 file changed, 54 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index ec9a7cbbbc69..be25d82cedcb 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -337,6 +337,7 @@ struct gs_usb {
>   
>   	unsigned int hf_size_rx;
>   	u8 active_channels;
> +	u8 active_timestamp_channels;
>   	u8 channel_cnt;
>   
>   	unsigned int pipe_in;
> @@ -447,14 +448,20 @@ static void gs_usb_timestamp_work(struct work_struct *work)
>   {
>   	struct delayed_work *delayed_work = to_delayed_work(work);
>   	struct gs_usb *parent;
> +	bool active;
>   
>   	parent = container_of(delayed_work, struct gs_usb, timestamp);
>   	spin_lock_bh(&parent->tc_lock);
> -	timecounter_read(&parent->tc);
> +	active = parent->active_timestamp_channels;
> +	if (active) {
> +		timecounter_read(&parent->tc);
> +		active = parent->active_timestamp_channels;
> +	}
>   	spin_unlock_bh(&parent->tc_lock);
>   
> -	schedule_delayed_work(&parent->timestamp,
> -			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
> +	if (active)
> +		schedule_delayed_work(&parent->timestamp,
> +				      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
>   }
>   
>   static void gs_usb_skb_set_timestamp(struct gs_can *dev,
> @@ -465,6 +472,11 @@ static void gs_usb_skb_set_timestamp(struct gs_can *dev,
>   	u64 ns;
>   
>   	spin_lock_bh(&parent->tc_lock);
> +	if (!parent->active_timestamp_channels) {
> +		spin_unlock_bh(&parent->tc_lock);
> +		return;
> +	}
> +
>   	ns = timecounter_cyc2time(&parent->tc, timestamp);
>   	spin_unlock_bh(&parent->tc_lock);
>   
> @@ -474,25 +486,40 @@ static void gs_usb_skb_set_timestamp(struct gs_can *dev,
>   static void gs_usb_timestamp_init(struct gs_usb *parent)
>   {
>   	struct cyclecounter *cc = &parent->cc;
> +	bool first = false;
>   
> -	cc->read = gs_usb_timestamp_read;
> -	cc->mask = CYCLECOUNTER_MASK(32);
> -	cc->shift = 32 - bits_per(NSEC_PER_SEC / GS_USB_TIMESTAMP_TIMER_HZ);
> -	cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
> -
> -	spin_lock_init(&parent->tc_lock);
>   	spin_lock_bh(&parent->tc_lock);
> -	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
> +	if (!parent->active_timestamp_channels) {
> +		cc->read = gs_usb_timestamp_read;
> +		cc->mask = CYCLECOUNTER_MASK(32);
> +		cc->shift = 32 - bits_per(NSEC_PER_SEC /
> +					      GS_USB_TIMESTAMP_TIMER_HZ);
> +		cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ,
> +					       cc->shift);
> +
> +		timecounter_init(&parent->tc, &parent->cc,
> +				 ktime_get_real_ns());
> +		first = true;
> +	}
> +	parent->active_timestamp_channels++;
>   	spin_unlock_bh(&parent->tc_lock);
>   
> -	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
> -	schedule_delayed_work(&parent->timestamp,
> -			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
> +	if (first)
> +		schedule_delayed_work(&parent->timestamp,
> +				      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
>   }
>   
>   static void gs_usb_timestamp_stop(struct gs_usb *parent)
>   {
> -	cancel_delayed_work_sync(&parent->timestamp);
> +	bool last;
> +
> +	spin_lock_bh(&parent->tc_lock);
> +	parent->active_timestamp_channels--;
> +	last = !parent->active_timestamp_channels;
> +	spin_unlock_bh(&parent->tc_lock);
> +
> +	if (last)
> +		cancel_delayed_work_sync(&parent->timestamp);
>   }
>   

tc_lock serializes active_timestamp_channels updates, but this work manipulation
is not protected. Imagine CPU0 doing gs_usb_timestamp_stop while CPU1 is doing
gs_can_open:

     CPU0		   		CPU1

gs_usb_timestamp_stop()			gs_usb_timestamp_init()
   spin_lock_bh(&tc_lock);
   active_timestamp_channels--
   last = true
   spin_unlock_bh(&tc_lock);
	...				spin_lock_bh(&tc_lock)
	...				  timecounter_init()
	...				  first = true;
	...				spin_unlock_bh(&tc_lock)
	...				schedule_delayed_work()
   cancel_delayed_work_sync()

And the device will have no worker while active_timestamp_channels is not 0.

I think we have to find another way of synchronization here.
							

>   static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
> @@ -980,10 +1007,10 @@ static int gs_can_open(struct net_device *netdev)
>   
>   	can_rx_offload_enable(&dev->offload);
>   
> -	if (!parent->active_channels) {
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> -			gs_usb_timestamp_init(parent);
> +	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +		gs_usb_timestamp_init(parent);
>   
> +	if (!parent->active_channels) {
>   		for (i = 0; i < GS_MAX_RX_URBS; i++) {
>   			u8 *buf;
>   
> @@ -1094,12 +1121,11 @@ static int gs_can_open(struct net_device *netdev)
>   out_usb_free_urb:
>   	usb_free_urb(urb);
>   out_usb_kill_anchored_urbs:
> -	if (!parent->active_channels) {
> -		usb_kill_anchored_urbs(&parent->rx_submitted);
> +	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +		gs_usb_timestamp_stop(parent);
>   
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> -			gs_usb_timestamp_stop(parent);
> -	}
> +	if (!parent->active_channels)
> +		usb_kill_anchored_urbs(&parent->rx_submitted);
>   
>   	can_rx_offload_disable(&dev->offload);
>   	close_candev(netdev);
> @@ -1152,12 +1178,11 @@ static int gs_can_close(struct net_device *netdev)
>   
>   	/* Stop polling */
>   	parent->active_channels--;
> -	if (!parent->active_channels) {
> -		usb_kill_anchored_urbs(&parent->rx_submitted);
> +	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +		gs_usb_timestamp_stop(parent);
>   
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> -			gs_usb_timestamp_stop(parent);
> -	}
> +	if (!parent->active_channels)
> +		usb_kill_anchored_urbs(&parent->rx_submitted);
>   
>   	/* Stop sending URBs */
>   	usb_kill_anchored_urbs(&dev->tx_submitted);
> @@ -1577,6 +1602,8 @@ static int gs_usb_probe(struct usb_interface *intf,
>   	parent->channel_cnt = icount;
>   
>   	init_usb_anchor(&parent->rx_submitted);
> +	spin_lock_init(&parent->tc_lock);
> +	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
>   
>   	usb_set_intfdata(intf, parent);
>   	parent->udev = udev;

