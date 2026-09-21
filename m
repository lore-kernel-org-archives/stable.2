Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F85471D16;
	Mon, 21 Sep 2026 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984502; cv=none; b=ky23voaae1FGRXu81Da0V50Y0D9t33nY7gwvAWtfXwtYRKFVKzZc2cmGwle68QuGKhYAoq+sli/2DVdol/wiNk/eIwNJRR7iHmOgz4y0KhAWrzmBqkDwAGu97CYS4PXDMg4sT39ariZ8U7gMkflvf/bPDGcf6IyocFA3ReO0p/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984502; c=relaxed/simple;
	bh=7tFr5FjdokzetP5ldv/GI4zVZmpjqz3KsTqnTclTAL4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=fVhTavapg2L6Q6a28XTVYNYqJUH+3BMGj3Q5AWrFGzn47nCGQSPcxbcqlXrfZ4XhuzqJb8G1fGeK3KduxpDyh89QXGGJv3K1yJUD0pBh4K1efGd3JzZdfhvc8v2PttdmLtf5HjwIRSyZqtAGKZRWWDSTt//2U8PwA5RHLUOiuDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kv5DvEl3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kv5DvEl3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 02FC34E41021;
	Mon, 21 Sep 2026 09:54:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B937A60339;
	Mon, 21 Sep 2026 09:54:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C52C3103291A5;
	Mon, 21 Sep 2026 11:54:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789984492; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zX58uZu3w+zdG1XL39epL0OZBsWXhoPxyMcNgKxTruo=;
	b=Kv5DvEl3ovOd0EiMggpPrHPaIqH8es1iZTqahh7epnNAz7prajpD4dmcgQJK5d1GcYLIwE
	+LCY9ZtMRjAkyX+YscoyTdIidOZpyj6GSPwMv7MrdjbRtB3AUiJNc7llDRKm4B3g0y78KM
	Q3rBwgyyUXK+nSZcsQWWJOwJOdlCOM+1wgSD7lsSxQ/Vj6GJCzbZ86TY0t6CbDFVXRYf1D
	F90996gsFbkJfNdXdVYDqdKgiLLPxmye8LI75J7dUiZjKOwTXi6jlHWPZv50dGUmuBGhtk
	X/dfJHj/9+NxyGBey91DywGV7C9+4xk+VJ+bOQrXAYEW0UB+q4rcVRBAhw8aVw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 11:54:45 +0200
Message-Id: <DLKWJKREQ9YZ.307UELMFWUL0Q@bootlin.com>
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, "Sean Anderson"
 <sean.anderson@linux.dev>, "Antoine Tenart" <atenart@kernel.org>, "Russell
 King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <stable@vger.kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 2/3] net: macb: propagate RX ring refill errors
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260918-macb-close-v1-0-221d916b7961@bootlin.com>
 <20260918-macb-close-v1-2-221d916b7961@bootlin.com>
 <0eeb123ad32558ac42762827eb509110@tipi-net.de>
In-Reply-To: <0eeb123ad32558ac42762827eb509110@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolai,

On Mon Sep 21, 2026 at 9:05 AM CEST, Nicolai Buchwitz wrote:
> On 18.9.2026 22:32, Th=C3=A9o Lebrun wrote:
>> gem_rx_refill() is responsible for Rx SKB allocation, including at=20
>> open,
>> but its prototype indicates a void return value.
>>=20
>> Therefore we change the code to propagate allocation and DMA mapping
>> errors back up the stack, making sure the open fails if it occurs.
>> Change all those to return errno-style ints:
>>  - gem_rx_refill()
>>  - its parent gem_init_rx_ring()
>>  - its grand-parent gem_init_rings()
>>  - the macbgem_ops.mog_init_rings function pointer
>>  - its grand-uncle macb_init_rings()
>>=20
>> Theoretical bugfix, never encountered in practice. To reproduce,
>> introduce memory pressure (less than 512 SKBs of free memory) and open
>> the interface. I expect the last queue to be unuseable because it has
>> zero usable rx buffers. Nothing will ever trigger a refill on that
>> queue which only happens once a frame has been received.
>>=20
>> Note that other callers of refill (resume, HRESP error task, NAPI)
>> cannot do anything useful with that error and keep their best-effort
>> refill, hoping it will improve.
>>=20
>> Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>
>> [...]
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c=20
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 751fa9e68099..c418f859cc34 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>
>> [...]
>
>>  	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> @@ -2813,11 +2820,15 @@ static void gem_init_rings(struct macb *bp)
>>  		queue->tx_head =3D 0;
>>  		queue->tx_tail =3D 0;
>>=20
>> -		gem_init_rx_ring(queue);
>> +		err =3D gem_init_rx_ring(queue);
>> +		if (err)
>> +			last_err =3D err;
>
> A partly filled queue refills itself on the next gem_rx().  AFAIU only a
> queue with zero buffers can get stuck. Fail the open just for that case?

Ah so gem_init_rx_ring()/gem_rx_refill() would check the total allocated
slots count (not just count of slots allocated on this call). Then we
fail only if that is zero. I agree it sounds better.

>
>> [...]
>
>>  static void macb_reset_hw(struct macb *bp)
>> @@ -3162,7 +3175,9 @@ static int macb_open(struct net_device *netdev)
>>  		goto pm_exit;
>>  	}
>>=20
>> -	bp->macbgem_ops.mog_init_rings(bp);
>> +	err =3D bp->macbgem_ops.mog_init_rings(bp);
>> +	if (err)
>> +		goto free_rings;
>
> macb_set_ringparam() ignores macb_open()'s error, so NAPI stays disabled
> with netif_running() =3D=3D true and the next close will hang in=20
> napi_disable().
>
> Should macb_set_ringparam() return the error?

Yes. I ignored that codepath because I know context
swapping will land soon. :-)

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

