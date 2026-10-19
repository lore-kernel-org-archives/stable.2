Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379594E36EF;
	Mon, 19 Oct 2026 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415305; cv=none; b=YdSRIUUaiTlaTj1Y+uiLCUxxDIW02Uo9ywLiACdBnIxKA2rwUppKcxhY9dV//F2ayIdz/8JpLjJBcxzumDHgFr8gmh4giDQfA7x/OA4K69EpQbX4Nrb6+HvlKAHtrHWN0N2dwJ58Ei+mgAJaRWwIOu3hAL2ESA1SoNyxbnJowko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415305; c=relaxed/simple;
	bh=cQH7Myqc3TJED3SK7T4soSB58N/1C7iOjU60cCn7/J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIGOEHNguEvpic6dHsVo9QyyWLUkWBr646tqD+eSIyzco0+f0rz9Dgu9nUoZX6sEIZu2sieOmw60RqLbns8m4A+dvkjfSDgyC7BfMMMA5UO4IUz2BDXbOwkJ2LS/bFH5uc8fznglGhq82xLV6NIigfJNZ9TU2rtzWJSoCKbdjGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSgajLTA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSgajLTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B1C1F000C4;
	Mon, 19 Oct 2026 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415303;
	bh=Y7+xc7CqbMAhub7lX8DG1k2csbnM3j0TLRffLKya47M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FSgajLTAZeXn5A01iZXGoYK8XG7npOWfg563fUJ+cq9oV+IIjOYg7eUn+sWJacDF4
	 2vICGBizFbYeKImBsyeh9DzYHweQxvNegirpRqqRWh4xxzrGkgIRz/TE9PwXP6U+/f
	 dLQQG3LRlYdjyc7jCL4zmpNRFBm5CMaZf2oOGLl1/kPTjHV5DGPnl1Dl0Emxs1R5Be
	 wcQZ+CNkhzumEylqtyJmDWxShrjl3AyQCx175iPny6nqaacsPsgImjwpWGaMuryyGa
	 2aH/NHAczFjPT5lXI3RE9bgFmLgBBwy3MSTHDBpqAeM5zewf4KfZMtJVo87nrTqQ3i
	 PLKbO4V4RTFxg==
Message-ID: <e5af5247-b90c-41a2-a4a2-46b80361f8b9@kernel.org>
Date: Mon, 19 Oct 2026 15:08:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_balloon: initialize wakeup_lock before virtqueues
 are set up
To: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>, mst@redhat.com
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, stable@vger.kernel.org
References: <0e69abdc-0127-45dc-9bc1-bf48772cc7ea@kernel.org>
 <20261016025429.901-1-zhaimingbing@cmss.chinamobile.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261016025429.901-1-zhaimingbing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 04:54, Mingbing Zhai wrote:
> Since c578123e63da ("virtio_balloon: Treat stats requests as wakeup
> events") the stats_request() virtqueue callback takes vb->wakeup_lock
> via start_wakeup_event().  init_vqs() registers that callback and even
> primes and kicks the stats queue, so the lock is reachable from irq
> context as soon as init_vqs() returns, long before the driver sets
> DRIVER_OK: vring_interrupt() dispatches to the callback without any
> DRIVER_OK check unless CONFIG_VIRTIO_HARDEN_NOTIFICATION is set, and
> that option depends on BROKEN.  syzbot hit it from a threaded irq:
> 
>   INFO: trying to register non-static key in stats_request
>   ...
>   assign_lock_key
>   register_lock_class
>   lock_acquire
>   rt_spin_lock
>   start_wakeup_event drivers/virtio/virtio_balloon.c:150 [inline]
>   stats_request drivers/virtio/virtio_balloon.c:435
> 
> The lock is only initialized near the end of virtballoon_probe(),
> after init_vqs() and several steps that can still fail and unwind
> through del_vqs(), where a racing interrupt still finds the callback
> registered.  Until then it is whatever kzalloc() left in vb: lockdep
> complains about the unregistered lock class, and wakeup_signal_mask
> and processing_wakeup_event get updated from irq context while probe
> is still running.
> 
> The rt_spin_lock() in the report is just spin_lock() on PREEMPT_RT;
> any PROVE_LOCKING build takes the same path.
> 
> stop_update_lock(), which the same callback also acquires, is already
> initialized before init_vqs(); do the same for wakeup_lock.
> 
> Fixes: c578123e63da ("virtio_balloon: Treat stats requests as wakeup events")
> Reported-by: syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=13df72e0dc4be5c62215
> Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
> ---
> 
> Hi David,
> 
> On 24.08.26 14:57, David Hildenbrand (Arm) wrote:
>> I don't really understand what's happening here, Is the
>> register_lock_class() trying to reguster a non-static key?
> 
> It is: the wakeup_lock that stats_request() ends up taking at that
> point hasn't been run through spin_lock_init() yet.
> 
>> I don't immediately see how virtio-balloon is doing something odd
>> here, all it does is a spin_lock_irqsave(&vb->wakeup_lock, flags),
>> that was earlier initialized with spin_lock_init(&vb->wakeup_lock),
>> before the device was ready.
> 
> Right, the lock is initialized before virtio_device_ready().  But if
> I follow correctly, stats_request() can already fire once init_vqs()
> registers it as the stats virtqueue callback, some 100 lines before
> the spin_lock_init().  I also don't see anything on the guest side
> gating the IRQ: vring_interrupt() calls the callback without any
> DRIVER_OK check unless CONFIG_VIRTIO_HARDEN_NOTIFICATION (which
> depends on BROKEN).  So a device raising the interrupt while probe is
> still running would take the zero-initialized lock.
> 
>> virtio-balloon in an RT kernel/environment, unlikely in pactice ... :)
> 
> I don't think it is RT-specific, though: rt_spin_lock() is just what
> spin_lock() compiles to on PREEMPT_RT, so any PROVE_LOCKING build
> should hit the same register_lock_class() path on that lock.
> 
> stop_update_lock(), which the same callback takes first, is already
> initialized before init_vqs(); the patch below does the same for
> wakeup_lock.  Does that look reasonable?
> 
>  drivers/virtio/virtio_balloon.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index ab3e3d887e..8c1b47ec17 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -942,6 +942,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	INIT_WORK(&vb->update_balloon_stats_work, update_balloon_stats_func);
>  	INIT_WORK(&vb->update_balloon_size_work, update_balloon_size_func);
>  	spin_lock_init(&vb->stop_update_lock);
> +	spin_lock_init(&vb->wakeup_lock);
>  	mutex_init(&vb->balloon_lock);
>  	init_waitqueue_head(&vb->acked);
>  	vb->vdev = vdev;
> @@ -1049,8 +1050,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  			goto out_unregister_oom;
>  	}
>  
> -	spin_lock_init(&vb->wakeup_lock);
> -
>  	/*
>  	 * The virtio balloon itself can't wake up the device, but it is
>  	 * responsible for processing wakeup events passed up from the transport


That looks reasonable to me!

-- 
Cheers,

David
