Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4103563EB
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784453181; cv=none; b=bmQgivZxRtbCbaqhKWjghJx9Itjc/CgtU7+yjBnju5ILjrJE6qJ+cxfo6JXVVjo4TfdYZTmca2TsACO90Ngmp1c8ggR1EBfDqaPIAMZdXeBPM/bKVzTrXrjiWVvhBHTszeOzqX45Gdxb1FVFDNk+dcjLyza6xoOHUlqaxGgxsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784453181; c=relaxed/simple;
	bh=WHTosAEBkKeHfZPFAJNRYfRewxUmvZjjyzeVjk3Hhbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRteOa9WgSceQ32DSAr1fFVTAcT6nfE61GW+Vf3PJIB0jGDOT6Tc0Wtfttjx2KuFDKyxuEH5eraDQcmatfqkUBWPdJLOstYAZ3SqEP5oFJAba3OQWd8kIhdOVeZIdohIMOw2R0I3LMgetipdOKjbz5OPB7KkiAmDMMtWAN5pt+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bMQtCGpz; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bMQtCGpz"
Message-ID: <60fc9d67-50f8-46f4-b40a-8cd01999b86d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784453175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMDbXEPT9HVFE46E0Kn2ocp0XNAdBGRS7bCopOkI/6g=;
	b=bMQtCGpzwzfnKPwhL9QRD+oXgsu7rQ45g32B41JHeq0/TPTBroxZqnl17aIvhJcdVxLlb2
	zsOKZC6ekjEIP8Oz/PJT28IsQCy/pPdzvN6TjXww1HOarPOTVs9KgWxOgCgQ3ysOUVGjCE
	DhZUmjvjDm+rnL3OPK3J+ngHZCmU1iw=
Date: Sun, 19 Jul 2026 10:25:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH can v2] can: gs_usb: fix hardware timestamp state for
 mixed channels
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: Celeste Liu <uwu@coelacanthus.name>, Kees Cook <kees@kernel.org>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260718052815.2507496-1-shuangpeng.kernel@gmail.com>
 <20260719030000.3667449-1-shuangpeng.kernel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260719030000.3667449-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19.07.2026 04:00, Shuangpeng Bai wrote:
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
> Count the number of active timestamp-capable channels. Start the shared
> timestamp worker when the first such channel opens, stop it when the last
> such channel closes, and unwind the count if open fails.
> 
> Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
> Cc: stable@vger.kernel.org
> Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

no need for this tag, I didn't suggest the idea

> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> ---
> Changes in v2:
> - Count active timestamp-capable channels instead of tracking only whether
>    the shared timestamp worker has been started.
> - Stop the shared timestamp worker when the last timestamp-capable channel
>    closes, even if non-timestamp channels remain open.
> - Unwind the timestamp-capable channel count on gs_can_open() failures.
> 
>   drivers/net/can/usb/gs_usb.c | 28 ++++++++++++++++++----------
>   1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index ec9a7cbbbc69..9cc197803e0d 100644
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
> @@ -980,10 +981,13 @@ static int gs_can_open(struct net_device *netdev)
>   
>   	can_rx_offload_enable(&dev->offload);
>   
> -	if (!parent->active_channels) {
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
> +		if (!parent->active_timestamp_channels)
>   			gs_usb_timestamp_init(parent);
> +		parent->active_timestamp_channels++;

I think it would be better to move active_timestamp_channels management into
gs_usb_timestamp_init()/gs_usb_timestamp_stop() - it will simplify code in main
functions.

Please, start new thread for each version of your patch.


> +	}
>   
> +	if (!parent->active_channels) {
>   		for (i = 0; i < GS_MAX_RX_URBS; i++) {
>   			u8 *buf;
>   
> @@ -1094,13 +1098,15 @@ static int gs_can_open(struct net_device *netdev)
>   out_usb_free_urb:
>   	usb_free_urb(urb);
>   out_usb_kill_anchored_urbs:
> -	if (!parent->active_channels) {
> -		usb_kill_anchored_urbs(&parent->rx_submitted);
> -
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
> +		parent->active_timestamp_channels--;
> +		if (!parent->active_timestamp_channels)
>   			gs_usb_timestamp_stop(parent);
>   	}
>   
> +	if (!parent->active_channels)
> +		usb_kill_anchored_urbs(&parent->rx_submitted);
> +
>   	can_rx_offload_disable(&dev->offload);
>   	close_candev(netdev);
>   
> @@ -1152,13 +1158,15 @@ static int gs_can_close(struct net_device *netdev)
>   
>   	/* Stop polling */
>   	parent->active_channels--;
> -	if (!parent->active_channels) {
> -		usb_kill_anchored_urbs(&parent->rx_submitted);
> -
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
> +		parent->active_timestamp_channels--;
> +		if (!parent->active_timestamp_channels)
>   			gs_usb_timestamp_stop(parent);
>   	}
>   
> +	if (!parent->active_channels)
> +		usb_kill_anchored_urbs(&parent->rx_submitted);
> +
>   	/* Stop sending URBs */
>   	usb_kill_anchored_urbs(&dev->tx_submitted);
>   	atomic_set(&dev->active_tx_urbs, 0);

