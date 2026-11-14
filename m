Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699896;
	b=peopQzEr1k+gFC6MRPRt66wpGhFQrzov8E6VHoyRspnNWWTyODT/cDfvi4cBfHRuTd1j
	 OAE+Iy8Tset58Ud9wePbttRi1RxfhkkqPnIH4KkFoBKyhnHoSjM+dtHyUEBERabo36vNf
	 OOld4sOWWcjD61TIqbO1Lka9afOUNeD2532kw7D/L1bPeU0UA+renEeSD6gCzNNIMWwBM
	 s2K9FNmezSYOaITqi2jMek5nZA58kGbeOO7NMuuPZWacfFrgKmY9wt0oEaqEnoBc8byw0
	 PRSc7lhthjvZF3vGfoT5YeoZw8bB1SUg4TTu4EPcY0BvboaAV0/ONRnwQjaYoZth9pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699896;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5bWsGC2du21OrImt9Txe5+Ol5ehaXR8e/YBmGJEznO0=;
	b=uYxKDq5F9fhKLvDS/JO5+nLXdwZKZVj0jA5pdtXlz72oCI25CC8TWlF/q2IVOZt60S9I
	 4QfPeYrd4BptZ8RNcch2N3wH1ulKTANIYj4FS/kPuXfMM4VRkXE3jtKVG/YEUeZh7kDhU
	 7rXc7QTKj9i67vVTT0sCp8XvfJI/HdDIYCKbiF+GoQgOGD2Ks2Ls3PqMp3p9wiRI9xE7X
	 jQMQl/89OS+St6w9VMdc1zl2EgwTMp3/5u8ZbpgHLqy/4rsq6PD5g4BVDUNJmCGVsGK7v
	 gUVkKIo1BiEmAbUaukJioOfmaRYUkqynTuuNPdNAFpKsn3MmXRrYJw9rqFTGEG+RR7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eg60c64u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B19606A33F;
	Sat, 14 Nov 2026 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eg60c64u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F931F000C8;
	Sat, 14 Nov 2026 23:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794699895;
	bh=5bWsGC2du21OrImt9Txe5+Ol5ehaXR8e/YBmGJEznO0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Eg60c64uu5PLBzR0FvHOlRSiUtBZKcV3l6UzV+uOxEldsdR5rWerc+kYPCppQcqBN
	 5NPEr8+z0GtxNdMi7pdDY9sTK2M5D6yLGLQ66XqK9eYrl1fCfcpLRfFCJSfco6dty5
	 pGqEvjPEUOAckTlzW3/a+8lUtEJi30aO09Ct14+qK/LpMf/OBkmDdKZqMCywXMU9hR
	 k2b+WAHqPkoGbL0zWs0xS3g/P12fJ1YLg8AjUfv+/xqJDrtHz3oviJ/5DQ7Jf6ZjCG
	 HqkOvAkFpuLL1BEDiVJmS3nXfBjyZtXNGjSWa6n7mIbgmHrQXEfQ4nqpYunCfTZPYu
	 Ws8/OA5NfpUWg==
Subject: Re: [PATCH can-next v6 6/6] can: gs_usb: fix hardware timestamp state
 for mixed channels
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Sat, 14 Nov 2026 23:44:54 +0000
Message-ID: <179469989471.488853.17149179530175481087@kernel.org>
In-Reply-To: <20261113-gs_usb-fixes-v6-6-0c039e1bfd74@pengutronix.de>
References: <20261113-gs_usb-fixes-v6-6-0c039e1bfd74@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds an RX-path change that the commit message never
  mentions.
- [Medium] gs_usb_timestamp_start()
  (drivers/net/can/usb/gs_usb.c:504-536) always sends the…
- [Low] The commit message describes the old behaviour inaccurately and
  understates the impact.
- [Low] The fix relies on disable_delayed_work(), enable_delayed_work()
  and disable_delayed_work_sync().
- [Low] The new counter struct gs_usb::active_timestamp_channels
  (drivers/net/can/usb/gs_usb.c:345), and the rewritten tc_lock comment…

--

can: gs_usb: fix hardware timestamp state for mixed channels

This patch initializes the HW timestamping infrastructure in
gs_usb_probe() if any channel has GS_CAN_FEATURE_HW_TIMESTAMP set. It
reworks gs_usb_timestamp_start()/gs_usb_timestamp_stop() to count opens
and to init the timecounter on the first one, reading the initial
timestamp before taking tc_lock. The delayed worker is disabled and
enabled to prevent rescheduling while stop runs.

Closes: https://sashiko.dev/#/bug/linux-b39360f9-6cd8-4f47-83bb-f0f78331f308
Closes: https://sashiko.dev/#/bug/linux-5f8ecd4e-344e-4ceb-9b46-886f4942a5f6

> Currently both the initialization and shutdown of the HW timestamping
> infrastructure is tied to the flags of the first channel opened
> respectively closed. This leads to problems if the first channel opened
> doesn't have the timestamping feature, but the second channel has.

[Severity: Low]

Is "first channel ... closed" accurate? Before this patch, gs_can_close()
only called gs_usb_timestamp_stop() once active_channels reached zero. So
shutdown depended on the flags of the last channel closed:

	parent->active_channels--;
	if (!parent->active_channels) {
		usb_kill_anchored_urbs(&parent->rx_submitted);

		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
			gs_usb_timestamp_stop(parent);
	}

Could the message also say what "leads to problems" means? The old code
seems to have two crash cases.

If a non-TS channel opens first and a TS channel opens second,
gs_usb_timestamp_init() never runs. The TS channel's RX frames then reach
gs_usb_skb_set_timestamp()->timecounter_cyc2time() while parent->tc.cc is
still NULL.

If a TS channel opens first and a non-TS channel closes last,
cancel_delayed_work_sync() is never called. The self-rearming
gs_usb_timestamp_work() can then run after gs_usb_disconnect() frees
parent.

The Cc: stable tag rests on these, so would it help to name them?

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 6327069f63c95..9eafdf63a4ef0 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -332,11 +336,14 @@ struct gs_usb {
>  	/* time counter for hardware timestamps */
>  	struct cyclecounter cc;
>  	struct timecounter tc;
> -	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */
> +	spinlock_t tc_lock; /* spinlock to guard access tc and active_timestamp_channels */
>  	struct delayed_work timestamp;
> +	u32 initial_timestamp;
>  
>  	unsigned int hf_size_rx;
>  	u8 active_channels;
> +	u8 active_timestamp_channels;

[Severity: Low]

This isn't a bug, but does active_timestamp_channels really count
timestamping channels? Three places call gs_usb_timestamp_start() or
gs_usb_timestamp_stop(): gs_can_open(), its error path, and
gs_can_close(). All three check only the parent-wide
GS_USB_PARENT_FLAGS_HW_TIMESTAMP flag, never dev->feature:

	if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
		rc = gs_usb_timestamp_start(parent);

So on a TS-capable interface the counter just mirrors active_channels.
With only non-TS channels open, gs_usb_timestamp_work() still sends
GS_USB_BREQ_TIMESTAMP every 30 minutes. Opening a non-TS channel also
does a synchronous timestamp read.

The commit message says the functions "track the number of active
timestamp channels", which doesn't match this. Would a different name or
comment be clearer?

[ ... ]

> @@ -475,24 +489,61 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)

[ ... ]

>  	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
> +	disable_delayed_work(&parent->timestamp);

[Severity: Low]

Will this backport to the stable trees covered by the Fixes: tag?
disable_delayed_work(), enable_delayed_work() and
disable_delayed_work_sync() arrived in v6.10 with commit 86898fa6b8cd
("workqueue: Implement disable/enable for (delayed) work items").
5886e4d5ecec dates from July 2023 and is in older stable trees such as
6.6.y and 6.1.y.

A mechanical backport would fail to build there. Swapping in
cancel_delayed_work_sync() by hand would silently drop the protection
against gs_usb_timestamp_work() re-arming itself. The commit message
relies on that protection ("Enabling and disabling the delayed worker
prevents concurrent rescheduling while gs_usb_timestamp_stop() is
running").

Could a stable version annotation or a note for backporters be added?

> +
> +	parent->flags |= GS_USB_PARENT_FLAGS_HW_TIMESTAMP;
> +}
> +
> +static int gs_usb_timestamp_start(struct gs_usb *parent)
> +{
> +	u32 timestamp = 0;
> +	int err;
> +
> +	/* read current timestamp, might be used later for initial time stamp */
> +	err = gs_usb_get_timestamp(parent, &timestamp);
> +	if (err)
> +		return err;
> +
> +	scoped_guard(spinlock_bh, &parent->tc_lock) {
> +		struct cyclecounter *cc = &parent->cc;
> +
> +		parent->active_timestamp_channels++;
> +		if (parent->active_timestamp_channels > 1)
> +			return 0;

[Severity: Medium]

Should a failed GS_USB_BREQ_TIMESTAMP read make every channel's open
fail? gs_usb_get_timestamp() runs before the active_timestamp_channels
check. For every open after the first, the value is thrown away. An error
such as a timeout, -EPIPE or -EPROTO still reaches gs_can_open():

	if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
		rc = gs_usb_timestamp_start(parent);
		if (rc)
			goto out_can_rx_offload_disable;
	}

On a mixed device, opening a channel without
GS_CAN_FEATURE_HW_TIMESTAMP now also depends on this request succeeding.

Before the patch, only the first open of a TS-capable channel read the
timestamp, through gs_usb_timestamp_read() inside timecounter_init(). A
failure there was only logged with dev_err() and did not fail the open.
Later opens sent no request at all.

Open and close are serialized by RTNL. Could the count be checked first,
with the read done only on the 0->1 transition? Or could the old
non-fatal behaviour be kept?

[ ... ]

> @@ -654,7 +705,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  	if (!netif_device_present(netdev))
>  		return;
>  
> -	if (!netif_running(netdev))
> +	if (!netif_running(netdev) || !(netdev->flags & IFF_UP))
>  		goto resubmit_urb;

[Severity: Medium]

Is this hunk part of the timestamp fix? The commit message doesn't
mention it.

__dev_open() sets __LINK_STATE_START before ndo_open(), and sets IFF_UP
only after ndo_open() succeeds. On close, __dev_close_many() clears
__LINK_STATE_START before ndo_stop(). So the new check only has an effect
while this channel's gs_can_open() is running.

On a multi-channel interface with another channel already up, the RX URBs
are active. Any frame for this channel that completes in that window is
now dropped and the URB resubmitted. That includes frames received after
the GS_USB_BREQ_MODE start request at the end of gs_can_open() but before
the core sets IFF_UP.

With this patch, every open on a TS-capable interface calls
gs_usb_timestamp_start() before the RX URBs are submitted, so the
timecounter should already be valid. If this hunk fixes a different
problem, perhaps one of the Closes: reports, could it be described in the
commit message or split into its own patch?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-gs_usb-fixes-v6-0-0c039e1bfd74%40pengutronix.de
