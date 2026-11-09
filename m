Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228020;
	b=Y+R7V5crM1/U8s5qDLX84IiBgtgoRV5T/Xwha/w4X7omIhPWCvBcB9vDq7MtdB2nK6kw
	 RbNTp4Hpy3DdKCkUdXtSZbQtRQUTvbtjZr/3iRlURxUkNfL0iO/J7XDHAcX/CuKNdia+E
	 1ZEcg1vvO7a/A17Hiuv5d7exkKCiCUS/uxFszIbc5sMglc95KW6O7tvYWkreMoKbUvQ5S
	 qv8o7Lh/9x+Y8zlmuMeFCfiASDX0DP2ZKuJNLJXhsQE6dbUuG+Tl4gVShGVQ/2O+gYmCc
	 kMGxTXkYonUzaHsUfVPwDX5i3c+ygaSlx/LM7gA1YgkzrYU1JBxQ+LNEHLh5oOODgeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228020;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=E8rh+A8iUf9NcUV78g/qTQWXpMrMp374iBAZJigpqcI=;
	b=04tbztmHDxUTaPn4L310fv//c9dmnbb6PP95QaxxSoJz9u1oWKIdFcZuV3kH61ipG7gH
	 TkzTMuBYV2o3z9HoS7viEkW8VzoVFcHRw8VlAf8Vvquh3c3zRBIplFxeYbkhjmrABmhrE
	 3Cj85KGrdz786O/JeU/vojclxCtPFgMoGeJ4T1h18xkmJz34xVoM+PtiNEbaTQqoSwlmo
	 jDN/Y7EzZqUrgN+IviQxUHd8VfflcVBHnV1+QIs0v/KrQq1RpizLfQMTt/sI6m/8H+NeB
	 TJfa2gXXFupPvPqRZ7jgDlIjD1eih+JJPTwDP3Tb/eHcvVgFJ024R217xL3JE5fMiAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IXpQjYCc;
	arc=none smtp.remote-ip=91.218.175.100
Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76C606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F76C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IXpQjYCc
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AKZh4nPPHH+Z+tE3EwhpBYD5fzfCHy+nEnXWG119NSE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794228017; v=1; x=1794832817;
 b=IXpQjYCcDFyFubs7q5Cm2oZ88M/Kw3pGcxyHIhIVF0rq3C+ucPwERlz2AVyE4kkUMXNIF/ZK
 c7fN9xOQ7EHaIOp1kmmzkSHzcWarnANbzsQepXVgy3MTOHjlvD0Rcp87g4nzctQRKibUfsbbMkr
 4gskPFnzqbldwYMKkMy/8AAA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3d236e2422131cd7;
	Mon, 09 Nov 2026 12:40:16 +0000
X-Mizu-Trace-ID: 3d236e2422131cd7
X-Migadu-Flow: FLOW_OUT
Message-ID: <b2c7d556-a6f2-4b3c-b141-49c3b558da87@linux.dev>
Date: Mon, 9 Nov 2026 12:40:14 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v5 6/6] can: gs_usb: fix hardware timestamp state
 for mixed channels
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>,
 Eric Evenchick <eric@evenchick.com>,
 Maximilian Schneider <max@schneidersoft.net>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
 stable@vger.kernel.org
References: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
 <20261108-gs_usb-fixes-v5-6-d52dd4940d46@pengutronix.de>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261108-gs_usb-fixes-v5-6-d52dd4940d46@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/11/2026 20:47, Marc Kleine-Budde wrote:
> From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> 
> For hardware timestamping, the driver manages the
> infrastructure (cyclecounter/timecounter) for the entire USB interface,
> assuming that all channels share a common time base, even though each
> channel individually indicates support for hardware timestamping via the
> GS_CAN_FEATURE_HW_TIMESTAMP flag.
> 
> Currently both initialization and shutdown of the HW timestamping
> infrastructure is tied to the flags of the first channel opened
> respectively closed. This leads to problems if the first channel opened
> doesn't have the timestamping feature, but the second channel has.
> 
> Keep the initialization of the HW timestamping infrastructure in
> gs_usb_timestamp_init(), and move initial time init and the initial
> scheduling of the delayed worker into gs_usb_timestamp_start().
> 
> Initialize the HW timestamping infrastructure in gs_usb_probe() using
> gs_usb_timestamp_init() if at least one channel has the
> GS_CAN_FEATURE_HW_TIMESTAMP flag set.
> 
> Extend the functions gs_usb_timestamp_start()/gs_usb_timestamp_stop()
> to track the number of active timestamp channels. Enabling or disabling the
> delayed worker prevents concurrent rescheduling while
> gs_usb_timestamp_stop() is running.
> 
> Call gs_usb_timestamp_start()/gs_usb_timestamp_stop() based on the
> channel's GS_CAN_FEATURE_HW_TIMESTAMP flag, rather than relying on the
> number of active channels.
> 
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> Closes: https://sashiko.dev/#/bug/linux-b39360f9-6cd8-4f47-83bb-f0f78331f308
> Closes: https://sashiko.dev/#/bug/linux-5f8ecd4e-344e-4ceb-9b46-886f4942a5f6
> Fixes: 5886e4d5ecec ("can: gs_usb: fix time stamp counter initialization")
> Cc: stable@vger.kernel.org
> Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> Co-developed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes in v4:
> - switch to enable_delayed_work()/disable_delayed_work_sync()
> - move starting from gs_usb_timestamp_init() into gs_usb_timestamp_start()
> - polish ref-counting/locking
> - Link to v3: https://patch.msgid.link/20260720184042.1712217-1-shuangpeng.kernel@gmail.com/
> 
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
> ---
> 
> Picking up Shuangpeng Bai's work, I've ported it on top of other fixes for
> problems identified by sashiko.
> 
> Marc
> ---
>   drivers/net/can/usb/gs_usb.c | 54 +++++++++++++++++++++++++++++++-------------
>   1 file changed, 38 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 6327069f63c9..0a1cd14c940c 100644
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
> @@ -481,18 +482,35 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)
>   	cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
>   
>   	spin_lock_init(&parent->tc_lock);
> -	spin_lock_bh(&parent->tc_lock);
> -	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
> -	spin_unlock_bh(&parent->tc_lock);
>   
>   	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
> +	disable_delayed_work(&parent->timestamp);
> +}
> +
> +static void gs_usb_timestamp_start(struct gs_usb *parent)
> +{
> +	scoped_guard(spinlock_bh, &parent->tc_lock) {
> +		parent->active_timestamp_channels++;
> +		if (parent->active_timestamp_channels > 1)
> +			return;
> +
> +		timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
> +	}
> +
> +	enable_delayed_work(&parent->timestamp);
>   	schedule_delayed_work(&parent->timestamp,
>   			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
>   }
>   
>   static void gs_usb_timestamp_stop(struct gs_usb *parent)
>   {
> -	cancel_delayed_work_sync(&parent->timestamp);
> +	scoped_guard(spinlock_bh, &parent->tc_lock) {
> +		parent->active_timestamp_channels--;
> +		if (parent->active_timestamp_channels > 0)
> +			return;
> +	}
> +
> +	disable_delayed_work_sync(&parent->timestamp);
>   }

That's quite defensive code. You have both disable/enable delayed_work
and active_timestamp_channels counter just to be sure to schedule
timestamp worker only once. Just wonder cannot we keep this worker
running regardless of channels?
