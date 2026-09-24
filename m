Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB304A840C
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265785; cv=none; b=Uln/aLpKFUZNRgSauDtmCH5CSwMmdXvY0eBAzYG2lUFjupRITbVF++1rxADRB+dokdJ6nIyGZEkuO6Lai8d2WrFGLQWRNHGkMx6jjhUkraDkZlL5gUbagTr9lWgKDRntn9OiOLOV+kDcFt4g3UfGERH6K0YwWpW8GNKn/02nAzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265785; c=relaxed/simple;
	bh=PI9WxX6Hs5eY3/prLxsCB7uv//MkTGW3D6wACjsV1kY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=rEA77gQK7kLoWRisbCjtaba/pDckrKMEKRxg0Bl8ADXY75uGh7Yq2LqED9lrqmSdFVDJxRU0aEB7ay4q8wGaWWH+K6gjzCDooKWS+Pg56/sa41oErW4ZIRftAlDnG//nEBZI4NOZitNjBWj54Rw051vex3+tjXWXRiaa/2jtQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SuLCfYj/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SuLCfYj/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 75C091A1002;
	Thu, 24 Sep 2026 16:03:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D98460738;
	Thu, 24 Sep 2026 16:03:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF6FF10329450;
	Thu, 24 Sep 2026 18:02:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790265774; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=31Pz2WasmTyS3PmhBsofr0EqPzewlEwdRxWXsLlXZes=;
	b=SuLCfYj/neF5rxoOvPNano4rwpDWS6duqjGHsPBzLtp81Fz9eqg+oFdX0UgpyNJB4OE21S
	gbto5FmCL5NVm5xQQ3hueTQs0RWwXdt2T9zUK/I/jKM148CL2VU1+dME4ivRrJPHrjQgLx
	id4jL61W+fde7/wUFBZn+wUE4C2Pob7SnojogOTmSRudI5hbP7NWYXFLn3FunM8rZ9ygsK
	kSPh+Pb4aRdHsgcArr5O+C+ABfx2XQgJ44gk7EGszW+oTZJknJoCEgs0el6Cgh8WEps+4X
	sIp1+NfX24FY+bMHTOJbpAh0FnpxJTgwo4ke7Gp/EJ9NKDYLctDwUGTyGdaGQw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 18:02:48 +0200
Message-Id: <DLNO9025LKHA.YJ9XCMRCRF52@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net 3/3] net: macb: quiesce IRQs and drain BH on
 interface close
Cc: <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <nicolas.ferre@microchip.com>,
 <sean.anderson@linux.dev>, <atenart@kernel.org>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <nb@tipi-net.de>,
 <vladimir.kondratiev@mobileye.com>, <gregory.clement@bootlin.com>,
 <tawfik.bayouk@mobileye.com>, <thomas.petazzoni@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <stable@vger.kernel.org>
To: <netdev-bot+sashiko@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260918-macb-close-v1-3-05e32ce98813@bootlin.com>
 <179010942347.2160803.5970158668197373074@kernel.org>
In-Reply-To: <179010942347.2160803.5970158668197373074@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello netdev-bot+sashiko,

On Tue Sep 22, 2026 at 10:37 PM CEST,  wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (2) =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] macb_close() now calls macb_quiesce_start() (synchronize_irq()
>   on every queue IRQ, cancel_work_sync(&bp->hresp_err_bh_work),=E2=80=A6
>
> Pre-existing issues:
> - [High] macb_suspend()/macb_resume() still open-code the per-queue
>   napi_disable()/napi_enable() loops without setting/clearing=E2=80=A6
> - [High] macb_set_ringparam() calls macb_close() and then macb_open()
>   while discarding macb_open()'s return value and always returning 0.
> - [Medium] bp->hresp_err_bh_work and bp->tx_lpi_work are initialized by
>   INIT_WORK()/INIT_DELAYED_WORK() only *after* register_netdev() in=E2=80=
=A6
>
> --
>
> net: macb: quiesce IRQs and drain BH on interface close
>
> This adds macb_quiesce_start()/macb_quiesce_end() helpers plus a new
> bp->irq_quiesced flag so that macb_interrupt() self-disarms while the
> interface is down, and reorders macb_close() to drain IRQs, the two work
> items, NAPI and the LPI delayed work in a defined order. macb_open() uses
> the same helpers on its success and error paths.
>
> A few questions below.
>
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/=
cadence/macb.h
>> index cfaa0ca49f1a..1cb2778fe49e 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -1382,6 +1382,11 @@ struct macb {
>>  	struct delayed_work	tx_lpi_work;
>>  	u32			tx_lpi_timer;
>> =20
>> +	/* ISR must not drive NAPI & BH mechanisms. True when the interface
>> +	 * is closed. Protected by bp->lock.
>> +	 */
>> +	bool			irq_quiesced;
>> +
>>  	int	rx_bd_rd_prefetch;
>>  	int	tx_bd_rd_prefetch;
>> =20
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index c418f859cc34..75bbde81d62c 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1995,6 +1995,53 @@ static int macb_tx_poll(struct napi_struct *napi,=
 int budget)
>>  	return work_done;
>>  }
>> =20
>> +static void macb_quiesce_start(struct macb *bp)
>> +{
>> +	struct macb_queue *queue;
>> +	unsigned long flags;
>> +	unsigned int q;
>> +
>> +	spin_lock_irqsave(&bp->lock, flags);
>> +	bp->irq_quiesced =3D true;
>> +	spin_unlock_irqrestore(&bp->lock, flags);
>> +
>> +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)
>> +		synchronize_irq(queue->irq);
>> +
>> +	cancel_work_sync(&bp->hresp_err_bh_work);
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but can this cancel_work_sync(=
)
> run on a work_struct that has not been initialized yet?
>
> In macb_probe(), register_netdev() happens before the two work items are
> set up:
>
> 	err =3D register_netdev(netdev);
> 	if (err) {
> 		dev_err(&pdev->dev, "Cannot register net device, aborting.\n");
> 		goto err_out_free_tieoff;
> 	}
>
> 	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
> 	INIT_DELAYED_WORK(&bp->tx_lpi_work, macb_tx_lpi_work_fn);
>
> The queue IRQ handlers were already installed earlier by
> macb_init_dflt()'s devm_request_irq(..., macb_interrupt, ...), and
> register_netdev() publishes the device, so an 'ip link set up' racing wit=
h
> the tail of probe can reach macb_open() -> macb_quiesce_end(), which clea=
rs
> bp->irq_quiesced. From there an HRESP interrupt would let
> macb_interrupt_misc() do queue_work(system_bh_wq, &bp->hresp_err_bh_work)
> on a zeroed work_struct whose ->func is NULL, and macb_close() or the
> macb_open() error path would call cancel_work_sync() /
> cancel_delayed_work_sync() on the same uninitialized objects.
>
> The pre-existing macb_close() already had the cancel_delayed_work_sync() =
on
> bp->tx_lpi_work, so this only widens an existing window. Would moving bot=
h
> INIT_WORK()/INIT_DELAYED_WORK() calls ahead of macb_init()/register_netde=
v()
> be reasonable?

This race is out of this world, but does technically exist.
Let's fix it anyway.

>> +
>> +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> +		/* Must be done before NAPI is disabled: the task ends with a
>> +		 * napi_enable() call.
>> +		 */
>> +		cancel_work_sync(&queue->tx_error_task);
>> +
>> +		napi_disable(&queue->napi_rx);
>> +		napi_disable(&queue->napi_tx);
>> +	}
>> +
>> +	/* Must be done after napi_tx is disabled: its completion re-arms
>> +	 * the LPI timer.
>> +	 */
>> +	cancel_delayed_work_sync(&bp->tx_lpi_work);
>> +}
>> +
>> +static void macb_quiesce_end(struct macb *bp)
>> +{
>> +	struct macb_queue *queue;
>> +	unsigned long flags;
>> +	unsigned int q;
>> +
>> +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> +		napi_enable(&queue->napi_rx);
>> +		napi_enable(&queue->napi_tx);
>> +	}
>> +
>> +	spin_lock_irqsave(&bp->lock, flags);
>> +	bp->irq_quiesced =3D false;
>> +	spin_unlock_irqrestore(&bp->lock, flags);
>> +}
>> +
>>  static void macb_hresp_error_task(struct work_struct *work)
>>  {
>>  	struct macb *bp =3D from_work(bp, work, hresp_err_bh_work);
>> @@ -2137,8 +2184,8 @@ static irqreturn_t macb_interrupt(int irq, void *d=
ev_id)
>>  	spin_lock(&bp->lock);
>> =20
>>  	while (status) {
>> -		/* close possible race with dev_close */
>> -		if (unlikely(!netif_running(netdev))) {
>> +		/* self-disarm while the netdev is closed */
>> +		if (unlikely(bp->irq_quiesced)) {
>>  			queue_writel(queue, IDR, -1);
>>  			macb_queue_isr_clear(bp, queue, -1);
>>  			break;
>
> [Severity: High]
> This is a pre-existing issue, but does the new gating condition need a
> companion change in macb_suspend()/macb_resume()?

Pre-existing. Similarly to HRESP task, the infra will be put in place
and reusable to fix the suspend path which needs to shutdown all BH
features, even in WOL case.

[...]

>> @@ -3155,8 +3202,6 @@ static int macb_open(struct net_device *netdev)
>>  {
>>  	size_t bufsz =3D netdev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
>>  	struct macb *bp =3D netdev_priv(netdev);
>> -	struct macb_queue *queue;
>> -	unsigned int q;
>>  	int err;
>> =20
>>  	netdev_dbg(bp->netdev, "open\n");
>> @@ -3180,10 +3225,7 @@ static int macb_open(struct net_device *netdev)
>>  		goto free_rings;
>>  	macb_init_buffers(bp);
>> =20
>> -	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> -		napi_enable(&queue->napi_rx);
>> -		napi_enable(&queue->napi_tx);
>> -	}
>> +	macb_quiesce_end(bp);
>> =20
>>  	macb_init_hw(bp);
>> =20
>> @@ -3210,11 +3252,10 @@ static int macb_open(struct net_device *netdev)
>>  	phy_power_off(bp->phy);
>> =20
>>  reset_hw:
>> +	/* The netdev stays down: quiesce and drain, as macb_close() does. */
>> +	macb_quiesce_start(bp);
>> +
>>  	macb_reset_hw(bp);
>> -	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> -		napi_disable(&queue->napi_rx);
>> -		napi_disable(&queue->napi_tx);
>> -	}
>>  free_rings:
>>  	macb_free(bp);
>>  pm_exit:
>
> [Severity: High]
> This is a pre-existing issue, but does the new reset_hw path make the
> macb_set_ringparam() failure case worse?

We ignore macb_set_ringparam() close/open when netif_running() because
we know what the right solution is (context swapping) and it's coming.
One step at a time.

[...]

>
>> @@ -3225,19 +3266,17 @@ static int macb_open(struct net_device *netdev)
>>  static int macb_close(struct net_device *netdev)
>>  {
>>  	struct macb *bp =3D netdev_priv(netdev);
>> -	struct macb_queue *queue;
>>  	unsigned long flags;
>>  	unsigned int q;
>> =20
>> -	netif_tx_stop_all_queues(netdev);
>> +	macb_quiesce_start(bp);
>> =20
>> -	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> -		napi_disable(&queue->napi_rx);
>> -		napi_disable(&queue->napi_tx);
>> +	/* Drain the BH contexts before stopping the queues: NAPI completion
>> +	 * and tx_error_task wake them up.
>> +	 */
>> +	netif_tx_stop_all_queues(netdev);
>> +	for (q =3D 0; q < bp->num_queues; ++q)
>>  		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, q));
>> -	}
>> -
>> -	cancel_delayed_work_sync(&bp->tx_lpi_work);
>
> [Severity: Medium]
> Moving netif_tx_stop_all_queues() after the whole quiesce sequence looks
> fine for the ndo_stop path, where the core already ran
> dev_deactivate_many() so no xmit can happen. Is it also safe for the dire=
ct
> caller?

Again, context swapping is the solution. Sashiko complains the
close/open dance in set_ringparam is unsafe, but anyway before this
series macb_close() is super race sensitive and we fix it here. One
step at a time.

[...]

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

