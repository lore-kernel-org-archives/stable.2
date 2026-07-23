Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073524DB54A;
	Thu, 23 Jul 2026 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815145; cv=none; b=c73YRKk+6Kp0xEJUWoED+ijBuwQJbBzT9QEf3fnVPp6vRQ8PsFmWVfUtkUyjdrpeWixcLFrTmHeUedDHosyjUar/pyaCSpoJsMWEeGNoeXCNuhK8oVo6IsRfE/75CBdJTwkdVddgopc401CojdKUAfy/PkqIeLiR4y3iowrssFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815145; c=relaxed/simple;
	bh=dPISo5F5Xw1PfBlOBSFPQUSkHdg5cx0n5Ru7nwTbrrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xc9WPyJnxW/Qo1rr8dkYG2kzeYMCK7ZcOsNSQdB8HaRfRHWTh2Wl9oBsoeJzX15WgAHP03hrpMl2+DE435kcdgT8f/nNk98QYmy/Jpqtmdi84o28WxtmfuwihntJmM5TYBbTtz7BhD1l2Q/F40puliyd60gLEvFyHzq8vkCgX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERhMjkmW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERhMjkmW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7957A1F000E9;
	Thu, 23 Jul 2026 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815133;
	bh=RN1NtJOwTVSgpxHY//v/9VWJtoDg49Eyw88g5AHlfDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ERhMjkmWNoCfLWJJQZYrRy9rnbdsyN2ndJnz65r0gmZHV2dzuPimeFSJS1ThfaCW5
	 OSnzQ5XTdmEevYnfLqu+3uwd9ludS8elGYRokfxdFGEkzCmEEwy9QX9a8NZ1FJN1Cp
	 HJ7OmSHeDjOD5B521Dm861rYuX6zcz/LIpQLLA8e+ef4DDiMjK+sH48o9NtjUjtQWE
	 dEIRGkUhZV6dLvnTKG1iWDWg2IOohBPIc1fiDZA5QZbZOjE3jyoAz+2yXOgrYSsHrK
	 eATPih/9roizU6pyIHir7VLisS5+8EiHDY7TpDLV7RFZVNzErwnScZpT4LzOd3bf2M
	 cSJz/u4bquQ1g==
Message-ID: <04d259ed-a874-435d-9046-cca55856fd60@kernel.org>
Date: Thu, 23 Jul 2026 15:58:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slub: fix missing debugfs entries for caches
 created before sysfs init
Content-Language: en-US
To: Li Xiasong <lixiasong1@huawei.com>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, weiyongjun1@huawei.com
References: <20260723115532.761920-1-lixiasong1@huawei.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260723115532.761920-1-lixiasong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 13:55, Li Xiasong wrote:
> slab_debugfs_init() creates the slab debugfs root at device initcall
> time, while slab_sysfs_init() moves slab_state to FULL at late initcall
> time. SLAB_STORE_USER caches created in this window miss their debugfs
> entries because do_kmem_cache_create() skips debugfs_slab_add() when
> slab_state <= UP.
> 
> The affected window is:
> 
>   slab_debugfs_init()
>     slab_debugfs_root = debugfs_create_dir(...)
>     list_for_each_entry(s, &slab_caches, list)
>       debugfs_slab_add(s)
> 
>   kmem_cache_create(..., SLAB_STORE_USER, ...)
>     do_kmem_cache_create()
>       if (slab_state <= UP)
>         return without debugfs entries
> 
>   slab_sysfs_init()
>     slab_state = FULL
> 
> Initialize the debugfs root and add debugfs entries while
> slab_sysfs_init() holds slab_mutex and walks slab_caches. This gives the
> sysfs and debugfs initialization an explicit order and prevents caches
> from being created between the debugfs scan and slab_state reaching
> FULL.
> 
> Since the debugfs root is now initialized later, a cache may be released
> before the root exists. Guard debugfs_slab_release() in that case to
> avoid looking up the cache name in the debugfs root directory.
> 
> Fixes: 1a5ad30b89b4 ("mm: slub: make slab_sysfs_init() a late_initcall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>

This is better, thanks. But I think now we have a problem that debugfs
enabled and sysfs disabled (which is possible), debugfs will not be initialized.

So we might need a more generically named late_initcall function that's
executed with either sysfs or debugfs enabled, and wrap slab_kset creation
and alias_list processing in functions that have an empty no-sysfs variant.

> ---
> 
> Changes in v2:
> - Move debugfs root and cache entry initialization into
>   slab_sysfs_init() so both use the same mutex-protected cache walk.
> - Guard debugfs_slab_release() against an uninitialized debugfs root.
> - Update the commit message accordingly.
> 
> v1: https://lore.kernel.org/linux-mm/20260720145124.3684976-1-lixiasong1@huawei.com/
> 
> ---
>  mm/slub.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 9ec774dc7009..70e9aeda6a8f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -339,8 +339,10 @@ static inline int sysfs_slab_add(struct kmem_cache *s) { return 0; }
>  
>  #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
>  static void debugfs_slab_add(struct kmem_cache *);
> +static void __init slab_debugfs_root_init(void);
>  #else
>  static inline void debugfs_slab_add(struct kmem_cache *s) { }
> +static inline void slab_debugfs_root_init(void) { }
>  #endif
>  
>  enum add_mode {
> @@ -9771,11 +9773,16 @@ static int __init slab_sysfs_init(void)
>  
>  	slab_state = FULL;
>  
> +	slab_debugfs_root_init();
> +
>  	list_for_each_entry(s, &slab_caches, list) {
>  		err = sysfs_slab_add(s);
>  		if (err)
>  			pr_err("SLUB: Unable to add boot slab %s to sysfs\n",
>  			       s->name);
> +
> +		if (s->flags & SLAB_STORE_USER)
> +			debugfs_slab_add(s);
>  	}
>  
>  	while (alias_list) {
> @@ -9985,23 +9992,16 @@ static void debugfs_slab_add(struct kmem_cache *s)
>  
>  void debugfs_slab_release(struct kmem_cache *s)
>  {
> +	if (unlikely(!slab_debugfs_root))
> +		return;
> +
>  	debugfs_lookup_and_remove(s->name, slab_debugfs_root);
>  }
>  
> -static int __init slab_debugfs_init(void)
> +static void __init slab_debugfs_root_init(void)
>  {
> -	struct kmem_cache *s;
> -
>  	slab_debugfs_root = debugfs_create_dir("slab", NULL);
> -
> -	list_for_each_entry(s, &slab_caches, list)
> -		if (s->flags & SLAB_STORE_USER)
> -			debugfs_slab_add(s);
> -
> -	return 0;
> -
>  }
> -__initcall(slab_debugfs_init);
>  #endif
>  /*
>   * The /proc/slabinfo ABI

