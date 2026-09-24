Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B74A385A;
	Thu, 24 Sep 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263428; cv=none; b=epVQmLJ6lF6m6HGsaYymi0SoWQUg8MjaZekXduRWWTa1vdgpRTdkqc8rSOqwjxytyri+lKysJv+eZ8idGjZ1C0pgWxGGp4OmYtluTmCMnB6ZWqL0dvtDFYSmp92dHmS03qWMbWqAWBZv/et9zu/3K9wueioRHOGoP7dJ7fyrIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263428; c=relaxed/simple;
	bh=VIOar8DoKO8Cgwr37NLwU4VayOAgDY8g14FMGD/RwkI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=JMi4VBAZ6UGckX5oO/bs8hiNHVeaHTPhz9MjU9BVpTueynXx7i8hIvu8D0utNs2vZeq5EwFcvk5xWD8ugC3i9XyE663xp/fpy0+Q9otf8kkTHYV3KQH5tv5spvoM9EL9vioZ5T1D7uVufE2RistMBpytSFk8gsMqO7zF7V4a/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ek3CXq4r; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ek3CXq4r"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CECCE1A1004;
	Thu, 24 Sep 2026 15:23:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8FBB260341;
	Thu, 24 Sep 2026 15:23:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3233010329474;
	Thu, 24 Sep 2026 17:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790263415; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TmsUK41hhOPuARlnGgT0/OebgCutGmEVVkygiHo/owk=;
	b=Ek3CXq4rJXRTDawsq2288hje6ZCU8T9kvRTt123ZLVaPU6kkqWhAvqjcu4oxusPlibQzDp
	iTtnJ4ORNrmLCTpntSP9JNBFHBH44SrpEIzFgMznJJuNrfVCNCdnp3QdFPWqvCBhBBp0f9
	riQNB2poENgDhWMu+i8HYfLOPTtkFL5vtc8iz7iLsfFrBw+IBCYG+qcyKAHMypBNARonL+
	IIyYdV6DfXjSvTvfXb9sObRZuI8cenuHjXu9jSh2Yx4raVGx7diOWmRgbMkDswOs46rMMq
	JYmKhEdnARo6nri9MiwJ5ps3P1OqLYT/5VHx1IT2gnZqkuppd2qznzGLLq8JKQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 17:23:30 +0200
Message-Id: <DLNNEWZ86ZFC.IGKHJWK3W0RS@bootlin.com>
Cc: <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <nicolas.ferre@microchip.com>,
 <sean.anderson@linux.dev>, <atenart@kernel.org>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <nb@tipi-net.de>,
 <vladimir.kondratiev@mobileye.com>, <gregory.clement@bootlin.com>,
 <tawfik.bayouk@mobileye.com>, <thomas.petazzoni@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <stable@vger.kernel.org>
To: <netdev-bot+sashiko@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net 2/3] net: macb: propagate RX ring refill errors
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260918-macb-close-v1-2-05e32ce98813@bootlin.com>
 <179010942168.2160803.12593263624100762709@kernel.org>
In-Reply-To: <179010942168.2160803.12593263624100762709@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello netdev-bot+sashiko,

On Tue Sep 22, 2026 at 10:37 PM CEST,  wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 (1) =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] Incomplete fix: the new errno from
>   gem_rx_refill()/gem_init_rx_ring()/mog_init_rings() is discarded by=E2=
=80=A6
> - [High] macb_set_ringparam()
>   (drivers/net/ethernet/cadence/macb_main.c:3737-3749) closes and=E2=80=
=A6
>
> Pre-existing issues:
> - [High] macb_hresp_error_task() (macb_main.c:1998-2035, BH-workqueue
>   context) calls bp->macbgem_ops.mog_init_rings(bp) -> gem_init_rings()=
=E2=80=A6
>
> --
>
> net: macb: propagate RX ring refill errors
>
> This changes gem_rx_refill(), gem_init_rx_ring(), gem_init_rings(),
> macb_init_rings() and the macbgem_ops.mog_init_rings function pointer to
> return errno-style ints, so that macb_open() fails when RX skb allocation
> or DMA mapping fails. The other refill callers (resume, HRESP error task,
> NAPI) keep their best-effort behaviour.
>
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/=
cadence/macb.h
>> index d6931c41f39d..cfaa0ca49f1a 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -1197,7 +1197,7 @@ struct macb_queue;
>>  struct macb_or_gem_ops {
>>  	int	(*mog_alloc_rx_buffers)(struct macb *bp);
>>  	void	(*mog_free_rx_buffers)(struct macb *bp);
>> -	void	(*mog_init_rings)(struct macb *bp);
>> +	int	(*mog_init_rings)(struct macb *bp);
>>  	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
>>  			  int budget);
>>  };
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 751fa9e68099..c418f859cc34 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1486,13 +1486,14 @@ static int macb_tx_complete(struct macb_queue *q=
ueue, int budget)
>>  	return packets;
>>  }
>> =20
>> -static void gem_rx_refill(struct macb_queue *queue)
>> +static int gem_rx_refill(struct macb_queue *queue)
>>  {
>>  	struct macb *bp =3D queue->bp;
>>  	struct macb_dma_desc *desc;
>>  	struct sk_buff *skb;
>>  	unsigned int entry;
>>  	dma_addr_t paddr;
>> +	int err =3D 0;
>> =20
>>  	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
>>  			bp->rx_ring_size) > 0) {
>> @@ -1509,6 +1510,7 @@ static void gem_rx_refill(struct macb_queue *queue=
)
>>  			if (unlikely(!skb)) {
>>  				netdev_err(bp->netdev,
>>  					   "Unable to allocate sk_buff\n");
>> +				err =3D -ENOMEM;
>>  				break;
>>  			}
>> =20
>> @@ -1518,6 +1520,7 @@ static void gem_rx_refill(struct macb_queue *queue=
)
>>  					       DMA_FROM_DEVICE);
>>  			if (dma_mapping_error(&bp->pdev->dev, paddr)) {
>>  				dev_kfree_skb(skb);
>> +				err =3D -ENOMEM;
>>  				break;
>>  			}
>> =20
>> @@ -1558,6 +1561,8 @@ static void gem_rx_refill(struct macb_queue *queue=
)
>> =20
>>  	netdev_vdbg(bp->netdev, "rx ring: queue: %p, prepared head %d, tail %d=
\n",
>>  		    queue, queue->rx_prepared_head, queue->rx_tail);
>> +
>> +	return err;
>>  }
>
> [Severity: High]
> The commit message says:
>
>     Note that other callers of refill (resume, HRESP error task, NAPI)
>     cannot do anything useful with that error and keep their best-effort
>     refill, hoping it will improve.
>
> Is the "hoping it will improve" part true for those callers, given the
> same analysis used to justify the open() fix?
>
> gem_init_rx_ring() first marks every descriptor as software owned and
> resets both cursors:
>
> 	queue->rx_tail =3D 0;
> 	queue->rx_prepared_head =3D 0;
>
> 	for (i =3D 0; i < queue->bp->rx_ring_size; i++)
> 		macb_rx_desc(queue, i)->addr |=3D MACB_BIT(RX_USED);
>
> 	return gem_rx_refill(queue);
>
> gem_rx_refill() then breaks out on the first netdev_alloc_skb() or
> dma_mapping_error() failure, so it can return with zero descriptors hande=
d
> to the hardware.

Discussed with Nicolai [0]. The idea I'm proposing is that it errors out
if zero slots exist. That way we don't reach that forever-dead state
that only can occur if we hand zero descriptors to the hardware.

[0]: https://lore.kernel.org/netdev/0eeb123ad32558ac42762827eb509110@tipi-n=
et.de/

[...]

>> =20
>>  /* Mark DMA descriptors from begin up to and not including end as unuse=
d */
>
> [ ... ]
>
>> @@ -2793,14 +2798,16 @@ static int macb_alloc(struct macb *bp)
>>  	for (i =3D 0; i < queue->bp->rx_ring_size; i++)
>>  		macb_rx_desc(queue, i)->addr |=3D MACB_BIT(RX_USED);
>> =20
>> -	gem_rx_refill(queue);
>> +	return gem_rx_refill(queue);
>>  }
>
> [Severity: High]
> This isn't a bug introduced by this patch, but it sits on the call chain
> being changed here, so it may be worth a look: is the HRESP path allowed =
to
> re-run gem_init_rx_ring()/gem_rx_refill() while an RX poll is in flight?
>
> macb_hresp_error_task() runs in BH workqueue context and only masks the
> device interrupt sources:

Yes. We introduce in [PATCH net 3/3] a shutdown sequence that the HRESP
task should reuse to make it safe to run at any point in time.

We will not use it yet, this will come later. Let's first fix the big
hole that everyone takes which is close. Once the infra is in place
we'll reuse it for HRESP task.

[...]

>
>> @@ -3162,7 +3175,9 @@ static int macb_open(struct net_device *netdev)
>>  		goto pm_exit;
>>  	}
>> =20
>> -	bp->macbgem_ops.mog_init_rings(bp);
>> +	err =3D bp->macbgem_ops.mog_init_rings(bp);
>> +	if (err)
>> +		goto free_rings;
>
> [Severity: High]
> This adds a new, fairly easy to hit macb_open() failure path that returns
> before the napi_enable() loop.  Does macb_set_ringparam() need updating f=
or
> it?  It closes and reopens the interface and discards the result:

Again, infra is put in place. Be patient. It will be reused to implement
context swapping. One step at a time.

[...]

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

