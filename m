Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362332;
	b=RQRFrWFoXuy2/BIMZyMIHicKLpGf4/dvc9MZ40MPeZyPwOFlvjnNPLZjwrCQImSEcBVn
	 +qLU8b81QraO53RrmGzygKq7NGv1op5c4mOfx0hZN0y1ILmFwQvYS/cNH6V7/E4tVtHd6
	 0JCXbiH4qpFD8gCkMdJmbP6+/sOfy2rZDQFx/5gPKHkTMLHZ+UscsLUxgHf6oihGkC96n
	 3bHgg90eqxLaZtwUHKgs7xZm6pnZ835qZW2jI7E+qyY2he2MBPf23mc6MrLMe/QB52amF
	 i4SSuNrAew/mS/a2BPV2L1ECLojTdJW45IMRuhdk//bsKI4koNnnoABg/aWBAefL8/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xVY9Wj4Bi88UcgFUPGAWU4HWTtYjfgZmL2uHdSwjBm0=;
	b=NGNzNamrt+VxrmESltcgwd7lifAoST9VukWUsgBsLrxm58zp7tFQPsvy0Qot0ubjf+rW
	 zkf6OuN3O8fKtLTELyQOMzsU0Zs7WPrEIs6GUUfScXwIxzdP76IWb2wza1ZT/ZNbGGK10
	 qBJWZQDZo1b5lJG5sf1ZlHrWAC5/Zt55ACkYIkck/NZobxwmX/WQ/BNSDsqzBia9GKCk4
	 v3PxnXs4xM1qAUR4BGvb//lWgLBJBimuvLWE4bdKsaL7u7lR7C/zogMu24B1SywSxxMT1
	 uqv/Ooc5+dGa/rvrVGUp4QyDIAtB24rHnDtDlto5rZO6H5sLrCFnlVmIiOI2n/D5Idw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eG36F5LY;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AB606A332
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 047AB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eG36F5LY
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c5133831027so349929366b.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795362330; x=1795967130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xVY9Wj4Bi88UcgFUPGAWU4HWTtYjfgZmL2uHdSwjBm0=;
        b=eG36F5LYMXGT8HJvpO1igQt4qwvvVGzep2x9Ome7Hdz22Q4r56lb53Z2e4IgbuGCRK
         EmZ1AuU1G+bPjCaiqrsmhSWRV3xmk8KJPApRZ0qc8738Ylj2GrkoQ1TpygqsqwmEz4ZK
         p+4WAqMhwrC51gNgN/66AjK6wlX+vxIXSMdOxLP0yuEP7rxfFxFmy6UeOmWv4t3NpzBh
         37ma2cvSdGqrH9HSOWv79VjtpcWcOBRFGN+FuZnZor+k0wbFyFxsZ7ES3C3sKaB1ODpH
         JZEdy13Ll6N6O3KuupWyPk47kCak8o7bZU1G6p4MZJuwHp1JmakZfsDxoK/NThe6Szp4
         Th/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362330; x=1795967130;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVY9Wj4Bi88UcgFUPGAWU4HWTtYjfgZmL2uHdSwjBm0=;
        b=Btljgb+miLPVDglAWzLFtiAwimpvzWf0maKdPOOmPiTCRxl0aqqiNaReNphD9zlH8j
         DTRWczkrMAM9Dj2g6hUwx+L/fwHBrA+8FfmJCO/huJ9t5KTHwc1iZ8cq62+HinoMKowC
         /o8w4UCtGsef3nLpY/OFk9XAa7azcQd0VPg07Jz4IbGqjzVFtHPae9VWIQvfoq6MQGbA
         8aBWFpUQo2NFrZ4syMFrX2cUMvbI48qPq0KDO1JO+qUZ7NOH2WsUfOdyoZfXAg3byedX
         Afa3dLZ6tBWRBszN4oS0B8e2QMAv7mCfZQgjnCk7gqgmrKH0eCQ/+K6DzT66pYXhnjRm
         s6lg==
X-Forwarded-Encrypted: i=1; AL+hErHnjS2TNT85HnNdD+KVVoFMkLidJmwkBA9OO/UyPOgQ4R8VExzG2o1KtamvDWQ+fHqdEHkRZAU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9M1fErJvRgKyqsqLRyVz+Rgu7/2Jaz+EKww+bgo7kKlcg6IHdy
	W3K4RL6IEiuTjANZLzIXAdnF7rodegxWqsLlCrq1PmaHiU0KsGHUPn1Z
X-Gm-Gg: AZFdTZdp+lx+XEBD94LDU2k4kXGzwBso/m+ZS5faYxbK3tUBM5ZDLCej5JmP4JfB6/x
	aq4qLY0SORdk/O5rVv4GAfQygB/YWxyGffDvPYW1u36ESRU418L7RTYCK93e0pRwM1xPS4Go4Ho
	dOh3yhd3m68caQ9SgaZ7FgC6FXFmm+ZRomqIBJsXQZYL6mPam0FGPxyvgzA7rj738CMOHG10xKJ
	NuToNH2h33+2cHa8okgSGqdfVqx8bu7JJkZZSytlkVftpJUYxpXRo/IkO2vvCxAyvs8RueUNj8q
	fJqjTg452OCOoy4ITAwVBhXMxQvmNiEbsB98QsujR4SvTe5ClrOINBc8tN97X6Zr/NyLDvjmCuQ
	HcyCuJr/TrJpZLgV7vW2+WfNnfgIv4wrDh4Aop64WR4k/HwxfHPN07naEZqKp/+9js3ApmgpzJ0
	l4P8YKlBmcit6d7J547fQchLcYMIe2RmARPPwiNe1pYWMHSbfcPMxF38auDsJgEPhCAwu6wH6TM
	zKH3+MKWSx8W9R/wgpCwiHpawzWmbKC09RAAtAqPt4UHtV15ATdQtSlD2rfTjs2lEDM5Q==
X-Received: by 2002:a17:907:ba01:b0:c50:521f:13de with SMTP id a640c23a62f3a-c513a897601mr692846566b.35.1795362330344;
        Sun, 22 Nov 2026 07:45:30 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad01ae8sm339135866b.9.2026.11.22.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:45:30 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Sun, 22 Nov 2026 16:45:27 +0100
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: vbabka@kernel.org, harry@kernel.org, urezki@gmail.com,
	paulmck@kernel.org, qiang.zhang@linux.dev,
	akpm@linux-foundation.org, hao.li@linux.dev, cl@gentwo.org,
	rientjes@google.com, roman.gushchin@linux.dev, linux-mm@kvack.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/slab: don't queue the page cache work under
 krcp->lock
Message-ID: <awMOF_uE3cpV9dCn@milan>
References: <20261120083707.296481-1-zhanxusheng1024@gmail.com>
 <20261120083707.296481-2-zhanxusheng1024@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120083707.296481-2-zhanxusheng1024@gmail.com>

On Fri, Nov 20, 2026 at 04:37:07PM +0800, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> Commit 56292e8609e3 ("rcu/tree: Defer kvfree_rcu() allocation to a
> clean context") deferred page allocations to a workqueue. To avoid
> deadlocks with the scheduler, it used hrtimer to queue the work instead
> of queueing it directly.
> 
> Commit d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory
> pressure") later added a backoff mechanism under memory pressure, but
> did not consider that queue_delayed_work() with delay = 0 immediately
> queues the work and introduced the deadlock commit 56292e8609e3 tried to
> avoid.
> 
> run_page_cache_worker() runs under krcp->lock, from kvfree_call_rcu()
> callers that may hold more, such as set_cpus_allowed_force() under
> pi_lock, so it kicks the refill work from an hrtimer. Under memory
> pressure it instead queues the work with a delay of
> rcutree.rcu_delay_page_cache_fill_msec, which may be 0, and a zero delay
> queues it at once, taking pool->lock under krcp->lock.
> 
> With the delay set to 0, calling kvfree_rcu() on vmalloc memory under
> pi_lock after a drop_caches makes lockdep report:
> 
>   Chain exists of:
>     &pool->lock --> &p->pi_lock --> krc.lock
> 
> A zero delay also defeats the backoff, which is there to defer the
> refill under memory pressure.  Clamp the delay to [1:100000] ms, so that
> queue_delayed_work() always arms a timer, and update the documented
> range.
> 
> Fixes: d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory pressure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> v2: clamp the delay to [1:100000] ms instead of using the hrtimer for a
> zero delay (Uladzislau).  The changelog is Harry's version from
> slab/for-next-fixes, with the last paragraph rewritten.  The
> Reviewed-by tags of Vlastimil and Hao on v1 are not carried over, as
> the code changed.
> 
> Tested in a VM on v7.4-rc1 with lockdep: with
> rcutree.rcu_delay_page_cache_fill_msec=0, patch 1 alone reports the
> circular dependency above; with this patch the boot log says "Adjusting
> rcutree.rcu_delay_page_cache_fill_msec to 1 ms." and lockdep stays
> quiet.
> 
> v1: https://lore.kernel.org/all/20261028134647.3176080-1-zhanxusheng1024@gmail.com/
> 
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  mm/slab_common.c                                | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0b3c140babd9..0d1d76a6af70 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5763,7 +5763,7 @@ Kernel parameters
>  	rcutree.rcu_delay_page_cache_fill_msec= [KNL]
>  			Set the page-cache refill delay (in milliseconds)
>  			in response to low-memory conditions.  The range
> -			of permitted values is in the range 0:100000.
> +			of permitted values is in the range 1:100000.
>  
>  	rcutree.rcu_divisor= [KNL]
>  			Set the shift-right count to use to compute
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 41dea01a8c1f..6fb453118641 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -2262,12 +2262,12 @@ void __init kvfree_rcu_init(void)
>  			WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
>  	WARN_ON(!rcu_reclaim_wq);
>  
> -	/* Clamp it to [0:100] seconds interval. */
> -	if (rcu_delay_page_cache_fill_msec < 0 ||
> +	/* Clamp it to [1:100000] milliseconds interval. */
> +	if (rcu_delay_page_cache_fill_msec < 1 ||
>  		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
>  
>  		rcu_delay_page_cache_fill_msec =
> -			clamp(rcu_delay_page_cache_fill_msec, 0,
> +			clamp(rcu_delay_page_cache_fill_msec, 1,
>  				(int) (100 * MSEC_PER_SEC));
>  
>  		pr_info("Adjusting rcutree.rcu_delay_page_cache_fill_msec to %d ms.\n",
> -- 
> 2.43.0
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you!

--
Uladzislau Rezki
