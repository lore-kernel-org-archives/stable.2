Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8182931C6
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411618; cv=none; b=DNpKjXII0sxbzx7PubcFigziunHfKlBVra7+TtrwETSqG2odHU+8StSvoRe5xMTwzpq5K2fDfQwqYsMvFn7eqFm4BMG36MIfrW0/zAdPoPloZ7dt8C4ElfosGH6I81w71wddPF46HyExthM8/5OUuv21DZRb5RlmAzrybc/OWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411618; c=relaxed/simple;
	bh=XMrQ8/z1+wcExU4gcvLsAiqVjd/+XCz+DMRcI0Y+4B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jf6bwVSmZYcYOee8a+ugjVpxp/PpVmQXMrQhopvaCpjQyLimc6PX/M5VR4Ip9MwK/eXdLXZT+cvyas093LjrgfnN2qvQr4wazPMA30QN/F+7O7qb5am9ZpndikHdqgakNck/IzMLLS8o3fh+VqPn/jc1CYKEQ2s8TJJWZ5NorKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fyb+ct0T; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fyb+ct0T"
Message-ID: <adf0ae9e-8681-4b81-94d1-0d2f8f76801c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784411613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpZfzoXtPw4Z7lD1gySJT9ETLBvmkwWJwC66ZcAxZqw=;
	b=Fyb+ct0T4lyIi8g68HPeavTNGtk9/evHFeDYQCozNjCb6+EuNLXg4mZMiTmICAKZF11tHC
	nnT2+BUjBVYlb1Jc8BzMez3cwjfVEMxAsUByn345+8yJ7lDMbRY33SrxmuLjs7T5S49kbF
	/tlWtxjJbF5zTQId7ms5IOmY4Z04LlU=
Date: Sat, 18 Jul 2026 22:53:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH can] can: gs_usb: fix hardware timestamp state for mixed
 channels
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: Celeste Liu <uwu@coelacanthus.name>, Kees Cook <kees@kernel.org>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260718052815.2507496-1-shuangpeng.kernel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260718052815.2507496-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18.07.2026 06:28, Shuangpeng Bai wrote:
> The hardware timestamp state is shared by struct gs_usb, but gs_can_open()
> and gs_can_close() tie its initialization and teardown to active_channels
> and to the feature bits of the channel being opened or closed.
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
> Track whether the shared timestamp work has been started in struct
> gs_usb. Start it whenever opening a timestamp-capable channel and the
> shared state is not started yet, and stop it when the last channel closes
> regardless of that channel's feature bits. Initialize the delayed work and
> lock once during probe.

With this code, the gs_usb_timestamp_work will run even if there are no more
timestamp-capable channels are open (after multiple open/close calls). I think
it would be better to implement counter of timestamp-capable channels and rework
timestamp code to use this counter as an indicator of when to start/stop worker.

> 
> Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> ---
>   drivers/net/can/usb/gs_usb.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index ec9a7cbbbc69..bf956fef0d19 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -337,6 +337,7 @@ struct gs_usb {
>   
>   	unsigned int hf_size_rx;
>   	u8 active_channels;
> +	bool timestamp_started;
>   	u8 channel_cnt;
>   
>   	unsigned int pipe_in;
> @@ -480,19 +481,23 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)
>   	cc->shift = 32 - bits_per(NSEC_PER_SEC / GS_USB_TIMESTAMP_TIMER_HZ);
>   	cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
>   
> -	spin_lock_init(&parent->tc_lock);
>   	spin_lock_bh(&parent->tc_lock);
>   	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
>   	spin_unlock_bh(&parent->tc_lock);
>   
> -	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
>   	schedule_delayed_work(&parent->timestamp,
>   			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
> +
> +	parent->timestamp_started = true;
>   }
>   
>   static void gs_usb_timestamp_stop(struct gs_usb *parent)
>   {
> +	if (!parent->timestamp_started)
> +		return;
> +
>   	cancel_delayed_work_sync(&parent->timestamp);
> +	parent->timestamp_started = false;
>   }
>   
>   static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
> @@ -959,6 +964,7 @@ static int gs_can_open(struct net_device *netdev)
>   	struct urb *urb = NULL;
>   	u32 ctrlmode;
>   	u32 flags = 0;
> +	bool timestamp_started = false;
>   	int rc, i;
>   
>   	rc = open_candev(netdev);
> @@ -980,10 +986,13 @@ static int gs_can_open(struct net_device *netdev)
>   
>   	can_rx_offload_enable(&dev->offload);
>   
> -	if (!parent->active_channels) {
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> -			gs_usb_timestamp_init(parent);
> +	if ((dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) &&
> +	    !parent->timestamp_started) {
> +		gs_usb_timestamp_init(parent);
> +		timestamp_started = true;
> +	}
>   
> +	if (!parent->active_channels) {
>   		for (i = 0; i < GS_MAX_RX_URBS; i++) {
>   			u8 *buf;
>   
> @@ -1094,11 +1103,11 @@ static int gs_can_open(struct net_device *netdev)
>   out_usb_free_urb:
>   	usb_free_urb(urb);
>   out_usb_kill_anchored_urbs:
> +	if (timestamp_started)
> +		gs_usb_timestamp_stop(parent);
> +
>   	if (!parent->active_channels) {
>   		usb_kill_anchored_urbs(&parent->rx_submitted);
> -
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> -			gs_usb_timestamp_stop(parent);
>   	}
>   
>   	can_rx_offload_disable(&dev->offload);
> @@ -1155,8 +1164,7 @@ static int gs_can_close(struct net_device *netdev)
>   	if (!parent->active_channels) {
>   		usb_kill_anchored_urbs(&parent->rx_submitted);
>   
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> -			gs_usb_timestamp_stop(parent);
> +		gs_usb_timestamp_stop(parent);
>   	}
>   
>   	/* Stop sending URBs */
> @@ -1577,6 +1585,8 @@ static int gs_usb_probe(struct usb_interface *intf,
>   	parent->channel_cnt = icount;
>   
>   	init_usb_anchor(&parent->rx_submitted);
> +	spin_lock_init(&parent->tc_lock);
> +	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
>   
>   	usb_set_intfdata(intf, parent);
>   	parent->udev = udev;

