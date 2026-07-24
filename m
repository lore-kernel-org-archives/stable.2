Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037012EEE96;
	Fri, 24 Jul 2026 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899495; cv=none; b=OvIepaeVd/CA2vUlyLyUEvECFJAVZeCp5DbWcJK2M/Fc5auvmLdcUgGvHy/or660wMBCcMJX88zYOgBI3IlHU2Yt4WLfunhZbyvKMYcyPO554EXNzKzFui+InojDrL4J7Gv8dN0alLLf/3hJtkHxEzVfXOB1lpR5d2mCFQi56SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899495; c=relaxed/simple;
	bh=jH+6VgF4tg9zZFJmm92BOsq9zr6ImqZ0PasRn9M37WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNHtIhyf6iwbN94maJUu2IQesQIvu61eJ/6EbXCF9a84Yv6lrr0okpQ359xt3Wf1aYL4KkmyPTHkwC850YtI2htbQyHVVgOucMubntxV9urzJ1RHtz5OMIXDGd683lhBVpsCNDuNnfxFbT/hzEOnH3mtFYUSfjv4DJ6Ft91dTec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqWNBTh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqWNBTh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198871F000E9;
	Fri, 24 Jul 2026 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784899493;
	bh=VAXplxER5b45j+IBM1fC1H5H0FBqGWeyMGYNF8/R+fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IqWNBTh5PzM38Fj7eDcn7+P/F2ZeGgD+3XZsQkBsWViibBaP/q3wxK7LM2dcNsisM
	 iXRVYEB2GnsK/1BTuyYgNZoG7FIYmfLM3VZqOZXKETzCULur3TureEEBmM1xjQ5xM7
	 49cTi9saIeiFwZoGNnmi12gFsVCh2GcTNYy+mZJw7aOGyzzuRiA0i6L7VtXVQzBcLq
	 bAdMRkeZv5f0n0/irt0ogEnOWgz+vtUPfveqM+16bCSmSuPu3RcRWo2ljNicbvjVMx
	 vdaYcIQHR9mc8IyHqz2FXpxkDQ+DLF+EjzDbt6IMPd17Wua9Xb7IvnLLLEqqAayOB/
	 5q1Z2q9yfz3VQ==
Date: Fri, 24 Jul 2026 14:24:48 +0100
From: Simon Horman <horms@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robert Olsson <robert.olsson@its.uu.se>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: pktgen: fix proc entry use-after-free
Message-ID: <20260724132448.GK418547@horms.kernel.org>
References: <20260719145740.2888967-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719145740.2888967-1-nicoyip.dev@gmail.com>

On Sun, Jul 19, 2026 at 10:57:40PM +0800, Chengfeng Ye wrote:
> pktgen_change_name() replaces pkt_dev->entry while holding t->if_lock.
> pktgen_remove_device() removes the same entry before
> _rem_dev_from_if_list() takes that lock.
> 
> This allows the following interleaving:
> 
>   CPU 0 (NETDEV_CHANGENAME)       CPU 1 (kpktgend)
>   if_lock(t)
>   proc_remove(pkt_dev->entry)
>                                   proc_remove(pkt_dev->entry)
>   pkt_dev->entry = proc_create_data(...)
>   if_unlock(t)
> 
> The kthread can pass the stale proc_dir_entry to proc_remove() after the
> rename path has freed it. A reproducer with a widened race window reports:
> 
>   BUG: KASAN: slab-use-after-free in proc_remove+0x78/0x80
>   Read of size 8 at addr ffff8881478fea70 by task kpktgend_0/67
>   Call Trace:
>    proc_remove+0x78/0x80
>    pktgen_remove_device.isra.0+0x11c/0x4c0
>    pktgen_thread_worker+0x1214/0x6bc0
>    kthread+0x2c6/0x3b0
>   Allocated by task 95:
>    __proc_create+0x204/0x790
>    proc_create_data+0x72/0xe0
>    pktgen_thread_write+0xd61/0x1510
>   Freed by task 28:
>    kmem_cache_free+0xcb/0x3d0
>    proc_free_inode+0x5b/0x80
>    rcu_core+0x50a/0x1850
>   The buggy address belongs to the object at ffff8881478fea00
>    which belongs to the cache proc_dir_entry of size 192
> 
> Move proc_remove() into the if_lock-protected list removal helper. Keep it
> before list_del_rcu() to preserve the ordering required by add_device().
> The rename path must then finish replacing the entry before removal, or
> it observes that the device is no longer on the list.
> 
> Fixes: 39df232f1a9b ("[PKTGEN]: fix device name handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

