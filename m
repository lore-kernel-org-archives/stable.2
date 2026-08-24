Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5213749F4;
	Mon, 24 Aug 2026 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547608; cv=none; b=fLkCSQj147KuSqa0J/qD3NrpiC60YnacJno80AB6oCtityZF9hAa2duuLhlsmXSzbUI9oV7ZJEUXPJ8fdHzFvUNblPWDKJjtrImWsf6gLqxFb5dWsT/kioMA1Zt6HU2X5gbU0Vd62HEIstGDb4RWsgF2Ly7V51zleyCDPkfkxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547608; c=relaxed/simple;
	bh=RWs8mTbLJgqu/Fkk55Fv0q2rBFlmUShscweawdaqxrk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOHUx+7vjdZWD47QBJXSayGJE0NxOLQwmHtIB86MrKee8hjON3QnLsBdS79M/f1NIU7o1LNLCtW2/pGpREI6BR5XHZ4Pa9r4+8YD12ebjhz1+90ZTriTb+QgbwwlKWLnRj3qy78iC6Qz0ibLKXMBLq+v+SimhpNmNDVLjFS4y+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RUzOWYsU; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RUzOWYsU"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 99ED320748;
	Mon, 24 Aug 2026 07:00:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YUPn9RYHB6sT; Mon, 24 Aug 2026 07:00:03 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0E0072050A;
	Mon, 24 Aug 2026 07:00:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0E0072050A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787547603;
	bh=ZpsIx13iiJhi+xdvoVFT++JH+PhlUy2haj/loKZwOPk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=RUzOWYsUBWf5JZlYbUbGGjEEUJ2YybSbEAzTcZoJRwDDMReKnnpmnmXkw3ytOh9z+
	 nNsgYxSRcVatltPUyMas8cG2nEIO0uQbo8TtRh9eOhgT6sWrazPKLuepUQLsSq9iFA
	 a1iTrSNjc3LWVzEftcCHpWZjTmgz5NInFvj9ajy5mTeUBgFTOiJQHEeN3nJDuA83Vn
	 twG6hn8P6wluIqPLe3RkMp7lCAEM5CGrU8SkEugot+XzNSE0uODtNZhJ/9ZhtF9lAX
	 WROpL4kFpiDayxrD9r1AiT2rGCRyGaffu52PXmieDsZM4HHBJamX7dIm26eS5db3v0
	 sdmfbwF7XpArQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 24 Aug
 2026 07:00:02 +0200
Received: (nullmailer pid 652096 invoked by uid 1000);
	Mon, 24 Aug 2026 05:00:01 -0000
Date: Mon, 24 Aug 2026 07:00:01 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] xfrm: serialize state GC with device state flush
Message-ID: <aovP0ZKcUaQlQryp@secunet.com>
References: <20260730103543.2077749-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260730103543.2077749-1-nicoyip.dev@gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Jul 30, 2026 at 06:35:43PM +0800, Chengfeng Ye wrote:
> The deferred-device pass in xfrm_dev_state_flush() finds states under
> xfrm_state_dev_gc_lock, but drops the lock before calling
> xfrm_dev_state_free() because the driver callback may sleep.  The device
> GC list does not hold an xfrm_state reference, so the state GC worker can
> destroy the same state concurrently.
> 
> The race can proceed as follows:
> 
>   CPU 0                               CPU 1
>   find x on the device GC list
>   drop xfrm_state_dev_gc_lock
>   read x->xso.dev
>                                       xfrm_state_gc_destroy(x)
>                                       xfrm_dev_state_free(x)
>                                       xfrm_state_free(x)
>   continue xfrm_dev_state_free(x)
> 
> Both paths can invoke the driver callback and drop the device reference.
> CPU 0 can also access the xfrm_state after CPU 1 has freed it.
> 
> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in xfrm_dev_state_free+0x24c/0x2a0
>   Read of size 8 at addr ffff88810bbaa960 by task poc/102
> 
>   Call Trace:
>    xfrm_dev_state_free+0x24c/0x2a0
>    xfrm_dev_state_flush+0x353/0x400
>    xfrm_dev_event+0x26d/0x3a0
>    notifier_call_chain+0xc0/0x280
>    __dev_notify_flags+0x169/0x250
>    netif_change_flags+0xe7/0x160
>    dev_change_flags+0x96/0x220
>    devinet_ioctl+0x7f4/0x1880
> 
>   Allocated by task 87:
>    xfrm_state_alloc+0x1e/0x5c0
>    xfrm_add_sa+0xe7f/0x5820
>    xfrm_user_rcv_msg+0x4f3/0x940
> 
>   Freed by task 57:
>    kmem_cache_free+0xcb/0x3d0
>    xfrm_state_gc_task+0x4a8/0x650
>    process_one_work+0x63a/0x1070
> 
> Serialize xfrm_state destruction against the deferred-device pass with a
> mutex.  Keep xfrm_state_dev_gc_lock limited to list operations and retain
> the existing callback and device-reference release ordering.
> 
> Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Applied to the ipsec tree, thanks!
