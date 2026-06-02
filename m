Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B92BD5B4;
	Tue,  2 Jun 2026 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394775; cv=none; b=uO3+2lDNZrx86C2T6nU3+hmidSaSqXViJ3tOaYV2kA0Xe/eemK2L7/ZTOFFxQ4s9V4HezswBrdVuvdgZAlxC/vdiHhPUkueFWWdoCwvPRMRhY+45L96E6Thvz/0fJ4M3F+UcT2FIxpYdYXsaO2e+5YYE1bgfVEERiLm/rxhdrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394775; c=relaxed/simple;
	bh=BEdbwmGbIBnnbQ+wIL9cNcKcyM+hW5MjQ/S/FB5eMII=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6jcyKWC+h7MAZ9qFziF8A3GYG7ts8E8UQJZb6CgKQv9uHJCPtnNrruhmgZFqNWx7y2CewaKSCcHOqzm7Ovm8O/ZrfpESXj9bzQDK3bcYsZnsuRltxEEuq2o64p/bCl39o/BLsWRK4BdKhR+eJUDMCm3yiyp+6pkMumQRRZ+xOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SM3HDZGy; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SM3HDZGy"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B97AC2074F;
	Tue,  2 Jun 2026 12:06:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3MQyhY0hl7PI; Tue,  2 Jun 2026 12:06:03 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1361C20508;
	Tue,  2 Jun 2026 12:06:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1361C20508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780394763;
	bh=acdeYbVitHm7oHVUpkd4RKXf1Knk3DzGdPy8GFVCVvY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=SM3HDZGyWDrEr6DgHdoQ87pQMTdvnHdRy/TfMxFXVww2iSzh0Ry/iZ9jDsWBBvCI0
	 GTx6TJt7VIrpwXHneUA9++3dwI6B9GM/pFEvQ1Vwrn2Tk0rG4SbNh+5F3mPKG7APzj
	 t1gGhg9PNRGsKpI+8wmBu19R3YjeCcI41uK02zsVOY9TswpMvqI2hEGP3E1uGn7MrY
	 22eH501UmKTRd7BT2gvPd2C+8+E5bFrySL7FdT1Sn6xGLvEKziU8muyO7Qe2cYld+C
	 qNJe5d4NVlqEdzhOIH9K+LEuyoNhz3wpiy+SJDrnQF/Eo6EgEiTEK75Q8QbrhgDLjc
	 1v6wHS90FVIBg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 12:06:02 +0200
Received: (nullmailer pid 523192 invoked by uid 1000);
	Tue, 02 Jun 2026 10:06:01 -0000
Date: Tue, 2 Jun 2026 12:06:01 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tristan Madani <tristmd@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Christian Hopps
	<chopps@labn.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfrm: iptfs: fix ABBA deadlock in iptfs_destroy_state()
Message-ID: <ah6rCd7up8i6173I@secunet.com>
References: <20260528160318.2631699-1-tristan@talencesecurity.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260528160318.2631699-1-tristan@talencesecurity.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, May 28, 2026 at 04:03:18PM +0000, Tristan Madani wrote:
> iptfs_destroy_state() calls hrtimer_cancel() while holding a spinlock
> that the timer callback also acquires, leading to an ABBA deadlock on
> SMP systems.
> 
> For the output timer (iptfs_timer):
>   - iptfs_destroy_state() holds x->lock, calls hrtimer_cancel()
>   - iptfs_delay_timer() callback takes x->lock
> 
> For the drop timer (drop_timer):
>   - iptfs_destroy_state() holds drop_lock, calls hrtimer_cancel()
>   - iptfs_drop_timer() callback takes drop_lock
> 
> Both timers use HRTIMER_MODE_REL_SOFT, so their callbacks run in softirq
> context.  When hrtimer_cancel() is called for a soft timer that is
> currently executing on another CPU, hrtimer_cancel_wait_running() spins
> on softirq_expiry_lock -- the same lock held by the softirq running the
> callback.  If the callback is blocked waiting for the spinlock held by
> the caller of hrtimer_cancel(), a circular dependency forms:
> 
>   CPU 0: holds lock_A -> waits for softirq_expiry_lock
>   CPU 1: holds softirq_expiry_lock -> waits for lock_A
> 
> Fix this by cancelling both timers before acquiring their respective
> locks.  hrtimer_cancel() is safe to call without holding any lock and
> will wait for any in-progress callback to complete.  The locks are still
> acquired afterwards to synchronize with any in-flight packet processing
> before tearing down the state.
> 
> Found by source code audit.
> 
> Fixes: 4b3faf610cc6 ("xfrm: iptfs: add new iptfs xfrm mode impl")
> Cc: Christian Hopps <chopps@labn.net>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  net/xfrm/xfrm_iptfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 97bc979e55baf..fd25b2b230793 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -2708,8 +2708,9 @@ static void iptfs_destroy_state(struct xfrm_state *x)
>  	if (!xtfs)
>  		return;
>  
> -	spin_lock_bh(&xtfs->x->lock);
>  	hrtimer_cancel(&xtfs->iptfs_timer);
> +
> +	spin_lock_bh(&xtfs->x->lock);
>  	__skb_queue_head_init(&list);
>  	skb_queue_splice_init(&xtfs->queue, &list);
>  	spin_unlock_bh(&xtfs->x->lock);
> @@ -2717,8 +2718,9 @@ static void iptfs_destroy_state(struct xfrm_state *x)
>  	while ((skb = __skb_dequeue(&list)))
>  		kfree_skb(skb);
>  
> -	spin_lock_bh(&xtfs->drop_lock);
>  	hrtimer_cancel(&xtfs->drop_timer);
> +
> +	spin_lock_bh(&xtfs->drop_lock);
>  	spin_unlock_bh(&xtfs->drop_lock);

What is this? You take the drop_lock just to release it in the next
line.
