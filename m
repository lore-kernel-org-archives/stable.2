Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED223CF68F;
	Tue,  9 Jun 2026 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985477; cv=none; b=ORBwgCoXIvdjYrsE6AaA07aexXzgRPvy9iL1MfwUmzViKqcA3v/8PBS/ZY2NZLbQFNuzP4t36qj7WmaoU2ffsQUuh7/7Q3dYvh+aBVpiueFMyxTl0IX44vknuA/fpBlnmtGzRUI2FV+hf9pvecMIlKiTVkiSmn0udzH3LeJsnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985477; c=relaxed/simple;
	bh=HkA1pEUhpZbEJcneCmnMHnwMYMEb4HuvDulQJ4B2SZc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKacYb8qKWp9eWfs2teFdVA+vG8R/5i0KmcCAL5jxkbVuX5/e1xUdR1cjt8J4iKagDAlFVC4GMYB0FrsLUG5YwdX7vkhH0DBh5ulYBPUE1t/l+G3r1y3qK9PCw0vCQMX199bVx8il79fW2nGFS762MairjexX+Vw7krju6cypOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=IPj/+n8R; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="IPj/+n8R"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 621D42068C;
	Tue,  9 Jun 2026 08:11:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id scRy18CLMhRr; Tue,  9 Jun 2026 08:11:03 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A6F27205E3;
	Tue,  9 Jun 2026 08:11:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A6F27205E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780985463;
	bh=NWNfB5nYuGhmJVzZG9lXM2H5udUQ1e6W9BK9FXO+17A=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=IPj/+n8RMQkrNBnwiHbhHA47tL9bQDO558uOzKrlhRuQ/pLMZ/wD+5ojZ5nAC1QPd
	 2DgHEJYTAZdQGhWSJSPAWHRDk/3WwpPRMpDMxTDqzN1GlrVNkXIsOy9ocxRRWAvaqE
	 iDleB6VXP9Q6HM1Jr6VCWLT9Sl6RIc1Foryr3WBLPD8bxY+CFlodjfHbq6WXfXCh8C
	 z5Sclpc+cVvlAlO22V626PWnn36I308elhUky8APAu4n5NlQjjMMssJu5mkh15Spn8
	 DTWZy52khqXzD1N3stmWQUz2wSiVQrP7tGJEcE4gyxKBKCRZUS/EQVntUx/sIXyo+C
	 SyHX2fZqxSOgw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 08:11:02 +0200
Received: (nullmailer pid 890243 invoked by uid 1000);
	Tue, 09 Jun 2026 06:11:01 -0000
Date: Tue, 9 Jun 2026 08:11:01 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tristan Madani <tristmd@gmail.com>
CC: <herbert@gondor.apana.org.au>, <chopps@labn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xfrm: iptfs: fix ABBA deadlock in
 iptfs_destroy_state()
Message-ID: <aieudfqz9T-FzxHy@secunet.com>
References: <20260528160318.2631699-1-tristan@talencesecurity.com>
 <ah6rCd7up8i6173I@secunet.com>
 <178042060186.32887.17301018074622852112@talencesecurity.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178042060186.32887.17301018074622852112@talencesecurity.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Jun 02, 2026 at 05:16:41PM -0000, Tristan Madani wrote:
> Hi Steffen,
> 
> You are right - the lock/unlock pair around the drop_timer cancel was
> only needed to serialize with the timer callback, which hrtimer_cancel()
> already handles. Since the xfrm state refcount has reached zero by the
> time the destructor runs, no concurrent iptfs_input() can be accessing
> drop_lock-protected state either. The empty lock/unlock is dead code.
> 
> v2 below removes it entirely.
> 
> ---
> 
> From: Tristan Madani <tristan@talencesecurity.com>
> Subject: [PATCH v2] xfrm: iptfs: fix ABBA deadlock in iptfs_destroy_state()
> 
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
> Fix by calling hrtimer_cancel() before acquiring the respective locks.
> hrtimer_cancel() is safe to call without holding any lock and will wait
> for any in-progress callback to complete.  For the output timer, the
> lock is still acquired afterwards to drain the packet queue.  For the
> drop timer, the lock/unlock pair is removed entirely since it only
> existed to serialize with the timer callback, which hrtimer_cancel()
> already guarantees.
> 
> Found by source code audit.
> 
> Fixes: 4b3faf610cc6 ("xfrm: iptfs: add new iptfs xfrm mode impl")
> Cc: Christian Hopps <chopps@labn.net>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Applied, thanks a lot!
