Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD0370AF3;
	Sun,  9 Aug 2026 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299655; cv=none; b=PDVH5qao8kdMS8mW1XED4ZaFGR1DmEV4UUu1fvYkzqtj3rv0cuKe6xu6Dbvx9VpnH12YmhFhaoPu5tQxxc5YqU4o9kBz2fyEL7tghvjv/mpBOLxw3JT2eEa+Pdb8NCZ8qziFNGWb3MMs2g0ZD+zHi46OcmTYAZOdgOC8KJq6NwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299655; c=relaxed/simple;
	bh=uVDRWvB0hecQ54QUK+46kx6joRcXYUSo6QriuvTZ8Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuiQc/fmFYACMWB/OFfMjJCCyeuum1kgT2N6Y2fHswryRdoDqfHFxRCKqR25eRkBDMRuKo7VmfJ2mr2fod9wyb04mxOG0uorGp+p2yZus5pye090GR4yd8F1jMdOLzGGOH26gjAKS5kVOXpqBJ1OsVs8bxFYI7gb+nOofGRiTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svWBbLj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svWBbLj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504351F000E9;
	Sun,  9 Aug 2026 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786299653;
	bh=mb9QDC1iQYi8pCNJ4G320686nkqpM1gwPXkt8iVgfOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=svWBbLj9LgUQ6eYjQAVWVPSZJzQwjcxZeJhN9tA478vWx+FfqqxH68PSUumwQnSnh
	 94l1VieS/lE4E8lUU8U/+G89u/dV5fCq8Ky3+jnJHu7J4fqxgG3voG7O9y1CiNFIdN
	 DJcc1yOWnjVAGMx+tiWU1iJInJzFhQ+ka3paCteM=
Date: Sun, 9 Aug 2026 20:19:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?=D3scar_Meg=EDa_L=F3pez?= <megia.oscar@gmail.com>
Cc: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v4] Memory leak error in qxl unbind
Message-ID: <2026080941-edge-lurk-2146@gregkh>
References: <20260809165326.164763-1-megia.oscar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260809165326.164763-1-megia.oscar@gmail.com>

On Sun, Aug 09, 2026 at 06:53:14PM +0200, Óscar Megía López wrote:
> I discovered an OOM after run the script below
> (I updated it and added a sleep to allow enough time for the cache to
> recover):
> 
> while [ 1 -eq 1 ]; do\
>   i=$((i+1)); echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/unbind;\
>   if (($i%1000==0)); then\
>     echo i=$i; free;\
>     grep nr_free_pages /proc/vmstat;\
>     grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
>     sync; echo 3 > /proc/sys/vm/drop_caches;\
>     echo 1 > /proc/sys/vm/compact_memory;\
>     sleep 10s;\
>     free;\
>     grep nr_free_pages /proc/vmstat;\
>     grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
>     uptime;\
>   fi;\
>   echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/bind;\
>  done
> 
> The OOM isn't just a simple leak; it's a refcount corruption which renders
> the list_lru fix dead code after the first mid-init failure.
> 
> Here's the chain:
> 
> Bug 1: ttm_pool_type_init() does not check return from list_lru_init().
> 
> Fix: Check the return value from list_lru_init() and propagate the error.
> 
> Bug 2: ttm_pool_fini() does not destroy list lru with list_lru_destroy().
> 
> Fix: Add list_lru_destroy() after ttm_pool_type_fini().
> 
> Bug 3: ttm_pool_mgr_init() does not check ttm_pool_type_init() return
> and does not free pool if returns error.
> 
> Fix: Move up shrinker_alloc(), check ttm_pool_type_init() return and free
> pool types and shrinker if non-zero and return error.
> 
> Bug 4: ttm_pool_mgr_fini() does not destroy the list_lru.
> 
> Fix: Add list_lru_destroy() after ttm_pool_type_fini().
> 
> Fixed check for an empty shrinker_list.

Why is this not 4 different patches as part of a series?

> This patch depends on patch ("[PATCH v3] drm/qxl: fix use-after-free in
> qxl_irq_handler on PCI"), link [1] below.

That's not going to age well in a changelog text :(

thanks,

greg k-h
