Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353EA14A8B;
	Fri, 10 Jul 2026 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670895; cv=none; b=bQUxYUsTkRfXzXrWYwgLMMhIVX+wAc4f2UmBttlyCpxqd0c3EbJDi3q+ELgauoCriY4oFAIBYeUTDYnEGt53QLLvsbZlTfbZ5vRUo4DnPHndvv3xWlf5CDPiGbXkqf3haLuFzwvMT9PNkMGXNZ0tLvlLUwWa5LBUXFNXy1Im8g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670895; c=relaxed/simple;
	bh=Q+Yo2U7XnAZ8syfZgsKOmvbelG+Kcsw6H5GTya/Onh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyzFQAdww9WA3OBMi4ljitutTgJJYqUS8daAC/uARYV18H0GiEOFfrveM9cq2a+fDXBK25lYVpxDq+XzACZWZveXaL95fkJJDqwNqaTF9LQI5ze16G7d0WcXfTZSBzsseZLszD6ouqRcbdpdVM0E3/nZhmXvomMsG9qVcJk1hbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t4RXXSZO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L7RASeSB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t4RXXSZO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L7RASeSB"
Date: Fri, 10 Jul 2026 10:08:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783670892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fkSyy0EdFmNm6HCxvkwcn7o7zQaNKDDJtxQq1O2JCQg=;
	b=t4RXXSZOG4/jeKiAzEv1ALEKmJ+Ini0iOxcLJZqaZmVeYE5U4uem7GtZeVKd+TL8Y63XhI
	cNqEN4VFPncgwC3sUg9y1PHLHxDG1VnsNdGb/jsJhizQNu7eNbLudoCtkr6n5IPBjYq0fc
	mVEnEeUVJy8cODTgP2BshrLuGDAGp8i7FTEdq3UPnf7ZL7Q6iLaNpxDHlVsyKIQfgXD52D
	e/8FWfyyu/KnwDpn9MlsEdO4m7O4gbbeK7FtCyahML7vUuFJ7/B+HncDUAKArnvgysZi/f
	SzaU5yVxZQh+ms7AsLnA8MqAHzywuxoWfQ6KHnpW/3lqfgBMj2JirpmpwnML0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783670892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fkSyy0EdFmNm6HCxvkwcn7o7zQaNKDDJtxQq1O2JCQg=;
	b=L7RASeSB1pg0ErWTO9R22yZfLDm/ij6BAdmUQWm62sy44X+9prX96j6sAMFjHFIfM0yXWr
	h7THdymrkjYSh6AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
Cc: christian.taedcke@weidmueller.com,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kevin Hao <haokexin@gmail.com>, Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: reprogram TBQP after shuffling the TX
 ring on link-up
Message-ID: <20260710080810.ipWXip53@linutronix.de>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
 <20260706150422.-wYiCBuE@linutronix.de>
 <4c0570d2-5018-4389-ab63-5f829cc41f32@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c0570d2-5018-4389-ab63-5f829cc41f32@weidmueller.com>

On 2026-07-07 15:36:24 [+0200], Taedcke, Christian wrote:
> Thank you for the quick review! This is my first Linux kernel
> contribution, so I appreciate your feedback here.

You are doing good.

> On 7/6/2026 5:04 PM, Sebastian Andrzej Siewior wrote:
> > On 2026-07-06 16:02:14 [+0200], Christian Taedcke via B4 Relay wrote:
> >> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> >>
> >> gem_shuffle_tx_one_ring() rotates the software TX ring so that the
> >> tail sits at index 0 and resets queue->tx_tail to 0, but it never
> >> reprograms the hardware transmit buffer queue pointer (TBQP). Other
> >> paths that reset tx_tail to the ring base (macb_init_buffers() and
> >> macb_tx_error_task()) also reprogram TBQP to queue->tx_ring_dma; this
> >> path does not, leaving TBQP pointing at a stale descriptor.
> >>
> >> gem_shuffle_tx_rings() runs on every link-up from
> >> macb_mac_link_up(). After a few link up/down flaps that leave
> >> un-completed descriptors in the ring, the stale TBQP keeps pointing at
> >> a descriptor whose used bit is set. When TX is re-enabled on link-up,
> >> the GEM reads that used descriptor and raises TXUBR. macb_interrupt()
> >> schedules the TX NAPI, macb_tx_poll() makes no progress (work_done ==
> >> 0) and macb_tx_restart() re-issues TSTART, which makes the controller
> >> read the same used descriptor again and re-assert TXUBR. As the MAC
> >> interrupt is level-triggered, it never deasserts and one CPU is pegged
> >> at 100% in the threaded handler, eventually triggering "sched: RT
> >> throttling activated" and a dead network interface.
> > 
> > But this should also happen with !RT at which point the interrupt runs
> > at 100% CPU and the softirq has hardly an chance to make progress, no?
> 
> Problably yes. I had issues reproducing the issue since it appeared only
> on specific test setups when a lot packets where sent to another network
> device and this device's power was cut. And even then on some test runs
> the issue was not visible after a few hundred iterations. But after a
> restart of the whole test setup (including cold reboot of all devices)
> the issue sometimes appeared after 5 iterations.
> I only metion RT here because it was the only thing i tested. I only ran
> the RT kernel.
> Should I change the description?

It makes a difference if the problem you are facing is limited to
PREEMPT_RT (and so does not trigger on !PREEMPT_RT due to $REASON),
or also effects !PREEMPT_RT but may or may not trigger easily on
PREEMPT_RT.

> >> Fix it by reprogramming TBQP to the ring base on every path of
> >> gem_shuffle_tx_one_ring() that resets tx_tail to 0, mirroring
> >> macb_tx_error_task(). The early return for an already-aligned tail is
> >> left untouched as TBQP is already consistent there. This is safe
> >> because the shuffle runs from macb_mac_link_up() while TE is still
> >> disabled, so the transmitter is halted.
> >>
> >> Fixes: 881a0263d502 ("net: macb: Shuffle the tx ring before enabling tx")
> > 
> > This is v7.0-rc4. So that RT tree of yours has some backports or did you
> > run into this while trying to reproduce it upstream?
> 
> There were some backports. I ran this on the linux-yocto kernel
> https://git.yoctoproject.org/linux-yocto branch
> v6.6/standard/preempt-rt/base.
> The "Fixes:" commit was backported as 0a47c3889fcd before their version
> of 6.6.130.
> 
> The kernel i reproduced the issue on was linux-yocto branch
> v6.6/standard/preempt-rt/base after 6.6.142 was merged into it.

It is usually good to reproduce the issue on vanilla ensuring that the
problem was not introduced by a backport or was solved differently
upstream.

> >> Cc: stable@vger.kernel.org
> >> Assisted-by: Claude:claude-opus-4-8
> >> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> >> ---
> >>  drivers/net/ethernet/cadence/macb_main.c | 9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> >> index fd282a1700fb..b11cb8f068b7 100644
> >> --- a/drivers/net/ethernet/cadence/macb_main.c
> >> +++ b/drivers/net/ethernet/cadence/macb_main.c
> >> @@ -820,7 +820,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
> >>  	if (!count) {
> >>  		queue->tx_head = 0;
> >>  		queue->tx_tail = 0;
> >> -		goto unlock;
> >> +		goto reset_hw_ptr;
> > 
> > This update is even needed for count == 0 case? I kind of do understand
> > that you need to updated if you shuffled the descriptors around.
> 
> This was my understanding before researching more because of the email
> from Kevin in this thread: count == 0 may happen anywhere within the ring
> (e.g. when both the tail and the head point to the middle).
> Resetting queue->tx_tail to 0 but not resetting TBQP results in them
> being out-of-sync.
> But as Kevin mentioned in his email TBQP is reset to the original
> value when transmit is disabled (by setting bit 3 in NCR register).
> 
> I will investigate this further why my code change fixed the issue for
> me, but according to the documentation in [1] it should be a no-op.

I see.

> [1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm pg. 1040
> 
> Christian

Sebastian
