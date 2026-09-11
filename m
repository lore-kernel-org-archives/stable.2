Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6927A4766BF
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130328; cv=none; b=ACFf5X/rhcd2ZpvOXopb5fz56Vw6+FsgIPPGAy2ZsnT8AK+Ejm6UWe6ZTiRW20TSt+YiPC2oLoEuJf7+9jobDoEM8C+md8odBF0ZWZdmty4d2SsmN73lxdfYBiLy/g49YrAttD/zk+7QLITtGWTmpc+QsKFGV9gnBZ8NPb5jBag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130328; c=relaxed/simple;
	bh=yTqmSMbLb0OvMgYNxijHRMmHQGbFV2IWD0uImUPkkNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL1dSTjiArFRcp9F9Y/6hMSdq5UvpbxFNNt8FYUrF28ghYJzETfmj+cMYNbi83+VDyBsl15VKxT8WINz+B6wrG5zml/rdH1ZMF4OFonf92NHEj7TUalcsx9zvEl92FfINtqMUtvEt9V/5g3kK4OnQ6lVVbFn7t748FiFJaKxEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=GM3iIoZb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=huwImyr9; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="GM3iIoZb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="huwImyr9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 38C371D00089;
	Fri, 11 Sep 2026 08:38:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 08:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789130325; x=1789216725; bh=rBl6DzYun6
	r2SkV9cV4YuXAflBkBK7kf4IxqEkEz77k=; b=GM3iIoZbJLqAjyliCPw3UH8Afp
	yiFoNSrfDYbPaCU4tCq4qIUfWURDh1wTHT7m7l2nDvZLB3Jib6cK3yVxjy9qEs3Y
	M32QPKoYdLJjBNz96bChJn90yAoWx9VXUXw+74mnZCp/4wBGcWRwexexeHi7Bvh2
	SZVxzNVFa++MF6scehvTqvL9ehmiYwZnTDQ7LitLDjOWqH00BDELied6ieAmMRsR
	MtINTQS4PA9tLzFnT37o0dyAge8KxnbrSh9eohGDRONN0oP2vcs7HX3XPQUwIt9s
	JFfBO8UbKbPeQ0nYRfmOVhVeOC4aNLNXKLzR9PV5pGznEnkWNo3aj72f6OAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789130325; x=1789216725; bh=rBl6DzYun6r2SkV9cV4YuXAflBkBK7kf4Ix
	qEkEz77k=; b=huwImyr9GnWE9WvqH9m+w6spEgTaxFinyYLpDnUtHzMLC5mTjAu
	MwTZdMtNOw111DqON8aGMUhDO02FKPi5PvzJXPuIFV8e7ZueJvS0DrP6IAbknj7l
	4Oy22DI7llPVgiEohACLIBacyjW8uzISuOsvX7I37FmpsRSvdofUFc4+V5UhXCid
	fWVmihGbhsvi62AY4Vcgn99qwsSb7dKKBk/9obuyxfCNvo8Xrac/JNUvUo6nyKNI
	mfe48ge5DZWEfF/BU9fKtUHWo0WtdvfSoOl/XDhiuobOhaz3Hj9QA3zalPvGwvqm
	1FSgnT5weXZEzmngMzQfEgCvzK10cTBinXA==
X-ME-Sender: <xms:VPajauR475D-ScTCu5RLW5yadqcaIDyqwtNaJMBApPPqMT3_HzUWqQ>
    <xme:VPajatxurHuH8HqyNGt8h4mBPXy2ioanYk2JB__BAQXvbU8d2rq_CsvDvjukRSLac
    gzJJTG5J5b7KUVmckGGEYjHNDHQ39zJ8lJWpw9YjH_Edkce7rE>
X-ME-Received: <xmr:VPajaidqE7cM77piUeW2EupJfmsVizcCYH7KXGIDXl4qf-7tRKIXxhyRBvKYQDn5B6GqTBHTZ8GY0atRa_jsD4AA2TmotkgvdPXd0YIFvfY>
X-ME-Proxy-Cause: dmFkZTE8Zgj8JwqVsQBOsd+QJ+sDqI0oizWB8zi9FKl4YPa0N6vjuOp+u2ViG/V2nrLNjd
    fKvmKfcry8Xopkv50UBvW2AAawrhX3erV2qim39bbathxKg5AOM/owc/NyqcrUeM77EkTo
    d9+0iThD3276aUp2C063dTNvwEtS3/fjFn+SIsAXL9kYqjMM7miwUr4YuL05toPTuL1N2l
    x8oFQyKRn4mg5vF0zaBta5t9aSxU8aSFuNYN5uHm4lfhVxTcyFiNFlKBSB9T44ENcyAi52
    wmtrGiu0DcT/vWg2llY88A5DoqHDas/P+Tqusuap6lgZ0gvGvj3zQBMGsBJmlHq56APHZ1
    Yd4Zjm5FwCqmKMJQzUMnYV2LJ9RkoLY16gycO4Z+e9gnRVg7QLvmqKQOevJyHjpY9UvAv3
    kmIB7UzsX8GPzDn3cUJ10xy9Hgs9MWPBfBq9GoD8fZZ6L4c6DuJYkSr8Q5KpB8+RWmCQSW
    v64PMaVTGoZxtyahlOpTsyGSGpQfcZsc1jrOI0BUs6NQQOCp2y3TsHU6b0Xah2ccGzdu46
    SHb7e6nq5sJs+obAVQc9CFWcOdW348c1/dIAdckWzP5zknR1rzhGS1OiF8cMZLrBo4rTkD
    78/tXyoNWsWYifFhyByBtG0PQjD3Hi3X1YBBSDhSQE+JCyBJm0ztMfvidbfQ
X-ME-Proxy: <xmx:VPajaoM6T_OrlZvofDgYD19EKiiQc6Zwmx6PJPY_35kr-rgIVqHgZg>
    <xmx:VPajalvs1NTE8A6MZlpiAnHaJ6f9DqbQzJ5xxpGGbwg5q_udB0O19Q>
    <xmx:VPajahBFmutWzrntIBxNTq5uhvn2yWCNgDbP6vdSMWpPqfYVluNNfQ>
    <xmx:VPajasacmfwV1-yp3X4ltRwjlHu5IAh4eEMJXYsHTZhxHQnuM_24Ng>
    <xmx:VfajannXq4-kjC2QTk2rQYnjoukdWfi1trB7oV4-aGW5b3VHitSYbkvF>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 08:38:43 -0400 (EDT)
Date: Fri, 11 Sep 2026 14:33:27 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Bryam Vargas <hexlabsecurity@proton.me>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH 6.18.y] dm-pcache: validate seg_id fields from persistent
 memory
Message-ID: <2026091121-blizzard-subsidy-7367@gregkh>
References: <2026090437-wok-unstable-1b2e@gregkh>
 <20260910001811.3749965-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910001811.3749965-1-sashal@kernel.org>

On Wed, Sep 09, 2026 at 08:18:11PM -0400, Sasha Levin wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> [ Upstream commit 90c990a68460d7b5720e5634cf650eccdf0f4098 ]
> 
> cache_pos_decode(), cache_key_decode() and the last-kset branches of
> cache_replay(), the writeback worker and the GC worker take a cache
> segment id from the cache device metadata and index cache->segments[]
> with it without checking it against cache->n_segs. That metadata is only
> CRC-protected with a fixed public seed, so whoever supplies the cache
> device on a table load (CAP_SYS_ADMIN) controls the id; an out-of-range
> value forms a wild pcache_cache_segment pointer that is dereferenced and
> written through -- an out-of-bounds read and write driven by on-disk data.
> 
> Add cache_seg_id_valid() and reject an out-of-range id at each decode
> site, failing the operation with -EIO instead of indexing past the array.
> Bound the id against the initialized-segment count (cache_info.n_segs)
> rather than the physical device total. A forged cache_info.n_segs below
> seg_num otherwise leaves segments[cache_info.n_segs..seg_num) as zeroed
> structs whose data pointer is NULL, so a forged id in that window would
> still be dereferenced. A later patch guarantees cache_info.n_segs <=
> seg_num, and a driver-created cache sets the two equal, so valid images
> are unaffected.
> 
> Fixes: 1d57628ff95b ("dm-pcache: add persistent cache target in device-mapper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> [ adjusted cache_replay() context to preserve the existing hop-limit check before segment-ID validation ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/md/dm-pcache/cache.c           |  4 ++++
>  drivers/md/dm-pcache/cache.h           | 15 +++++++++++++++
>  drivers/md/dm-pcache/cache_gc.c        | 16 ++++++++++++++--
>  drivers/md/dm-pcache/cache_key.c       | 11 +++++++++++
>  drivers/md/dm-pcache/cache_writeback.c | 23 +++++++++++++++++++----
>  5 files changed, 63 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/dm-pcache/cache.c b/drivers/md/dm-pcache/cache.c
> index 887157fde68da..502acf2451779 100644
> --- a/drivers/md/dm-pcache/cache.c
> +++ b/drivers/md/dm-pcache/cache.c
> @@ -118,6 +118,9 @@ int cache_pos_decode(struct pcache_cache *cache,
>  	if (!latest_addr)
>  		return -EIO;
>  
> +	if (!cache_seg_id_valid(cache, latest.cache_seg_id))
> +		return -EIO;
> +
>  	pos->cache_seg = &cache->segments[latest.cache_seg_id];
>  
>  	if (latest.seg_off >= pos->cache_seg->segment.data_size)
> @@ -158,6 +161,7 @@ static int cache_init(struct dm_pcache *pcache)
>  	cache->cache_dev = &pcache->cache_dev;
>  	cache->n_segs = cache_dev->seg_num;
>  	atomic_set(&cache->gc_errors, 0);
> +	atomic_set(&cache->writeback_errors, 0);
>  	spin_lock_init(&cache->seg_map_lock);
>  	spin_lock_init(&cache->key_head_lock);
>  
> diff --git a/drivers/md/dm-pcache/cache.h b/drivers/md/dm-pcache/cache.h
> index afc112b79496a..d9e3e09f18e32 100644
> --- a/drivers/md/dm-pcache/cache.h
> +++ b/drivers/md/dm-pcache/cache.h
> @@ -180,6 +180,7 @@ struct pcache_cache {
>  		u32 advance;
>  		int ret;
>  	} writeback_ctx;
> +	atomic_t		writeback_errors;
>  
>  	char gc_kset_onmedia_buf[PCACHE_KSET_ONMEDIA_SIZE_MAX];
>  	struct delayed_work	gc_work;
> @@ -420,6 +421,20 @@ static inline bool cache_seg_is_ctrl_seg(u32 cache_seg_id)
>  	return (cache_seg_id == 0);
>  }
>  
> +/**
> + * cache_seg_id_valid - Validate a cache segment id read from the cache device.
> + * @cache: Pointer to the pcache_cache structure.
> + * @cache_seg_id: Segment id decoded from on-media metadata.
> + *
> + * On-media segment ids are only protected by a CRC, which an attacker who can
> + * format the cache device computes over their chosen value. Reject any id that
> + * would index cache->segments[] out of bounds before it is dereferenced.
> + */
> +static inline bool cache_seg_id_valid(struct pcache_cache *cache, u32 cache_seg_id)
> +{
> +	return cache_seg_id < cache->cache_info.n_segs;
> +}
> +
>  /**
>   * cache_key_cutfront - Cuts a specified length from the front of a cache key.
>   * @key: Pointer to pcache_cache_key structure.
> diff --git a/drivers/md/dm-pcache/cache_gc.c b/drivers/md/dm-pcache/cache_gc.c
> index 3088cfef951bc..a167892be7cef 100644
> --- a/drivers/md/dm-pcache/cache_gc.c
> +++ b/drivers/md/dm-pcache/cache_gc.c
> @@ -74,11 +74,17 @@ static bool need_gc(struct pcache_cache *cache, struct pcache_cache_pos *dirty_t
>   * @cache: Pointer to the pcache_cache structure.
>   * @kset_onmedia: Pointer to the kset_onmedia structure for the last kset.
>   */
> -static void last_kset_gc(struct pcache_cache *cache, struct pcache_cache_kset_onmedia *kset_onmedia)
> +static int last_kset_gc(struct pcache_cache *cache, struct pcache_cache_kset_onmedia *kset_onmedia)
>  {
>  	struct dm_pcache *pcache = CACHE_TO_PCACHE(cache);
>  	struct pcache_cache_segment *cur_seg, *next_seg;
>  
> +	if (!cache_seg_id_valid(cache, kset_onmedia->next_cache_seg_id)) {
> +		pcache_dev_err(pcache, "invalid next_cache_seg_id %u in gc (n_segs %u)\n",
> +				kset_onmedia->next_cache_seg_id, cache->n_segs);
> +		return -EIO;
> +	}
> +
>  	cur_seg = cache->key_tail.cache_seg;
>  
>  	next_seg = &cache->segments[kset_onmedia->next_cache_seg_id];
> @@ -94,6 +100,8 @@ static void last_kset_gc(struct pcache_cache *cache, struct pcache_cache_kset_on
>  	spin_lock(&cache->seg_map_lock);
>  	__clear_bit(cur_seg->cache_seg_id, cache->seg_map);
>  	spin_unlock(&cache->seg_map_lock);
> +
> +	return 0;
>  }
>  
>  void pcache_cache_gc_fn(struct work_struct *work)
> @@ -130,7 +138,11 @@ void pcache_cache_gc_fn(struct work_struct *work)
>  			if (dirty_tail.cache_seg == key_tail.cache_seg)
>  				break;
>  
> -			last_kset_gc(cache, kset_onmedia);
> +			ret = last_kset_gc(cache, kset_onmedia);
> +			if (ret) {
> +				atomic_inc(&cache->gc_errors);
> +				return;
> +			}
>  			continue;
>  		}
>  
> diff --git a/drivers/md/dm-pcache/cache_key.c b/drivers/md/dm-pcache/cache_key.c
> index a3bb1f95afb90..47338a4df36fc 100644
> --- a/drivers/md/dm-pcache/cache_key.c
> +++ b/drivers/md/dm-pcache/cache_key.c
> @@ -94,6 +94,12 @@ int cache_key_decode(struct pcache_cache *cache,
>  	key->off = key_onmedia->off;
>  	key->len = key_onmedia->len;
>  
> +	if (!cache_seg_id_valid(cache, key_onmedia->cache_seg_id)) {
> +		pcache_dev_err(pcache, "invalid cache_seg_id %u in cache key (n_segs %u)\n",
> +				key_onmedia->cache_seg_id, cache->n_segs);
> +		return -EIO;
> +	}
> +
>  	key->cache_pos.cache_seg = &cache->segments[key_onmedia->cache_seg_id];
>  	key->cache_pos.seg_off = key_onmedia->cache_seg_off;
>  
> @@ -801,6 +807,11 @@ int cache_replay(struct pcache_cache *cache)
>  				goto out;
>  			}
>  
> +			if (!cache_seg_id_valid(cache, kset_onmedia->next_cache_seg_id)) {
> +				ret = -EIO;
> +				goto out;
> +			}
> +
>  			next_seg = &cache->segments[kset_onmedia->next_cache_seg_id];
>  
>  			pos->cache_seg = next_seg;
> diff --git a/drivers/md/dm-pcache/cache_writeback.c b/drivers/md/dm-pcache/cache_writeback.c
> index 3df8687e2382f..c34db79fcefb4 100644
> --- a/drivers/md/dm-pcache/cache_writeback.c
> +++ b/drivers/md/dm-pcache/cache_writeback.c
> @@ -196,12 +196,18 @@ static int cache_kset_insert_tree(struct pcache_cache *cache, struct pcache_cach
>  	return ret;
>  }
>  
> -static void last_kset_writeback(struct pcache_cache *cache,
> +static int last_kset_writeback(struct pcache_cache *cache,
>  		struct pcache_cache_kset_onmedia *last_kset_onmedia)
>  {
>  	struct dm_pcache *pcache = CACHE_TO_PCACHE(cache);
>  	struct pcache_cache_segment *next_seg;
>  
> +	if (!cache_seg_id_valid(cache, last_kset_onmedia->next_cache_seg_id)) {
> +		pcache_dev_err(pcache, "invalid next_cache_seg_id %u in writeback (n_segs %u)\n",
> +				last_kset_onmedia->next_cache_seg_id, cache->n_segs);
> +		return -EIO;
> +	}
> +
>  	pcache_dev_debug(pcache, "last kset, next: %u\n", last_kset_onmedia->next_cache_seg_id);
>  
>  	next_seg = &cache->segments[last_kset_onmedia->next_cache_seg_id];
> @@ -211,6 +217,8 @@ static void last_kset_writeback(struct pcache_cache *cache,
>  	cache->dirty_tail.seg_off = 0;
>  	cache_encode_dirty_tail(cache);
>  	mutex_unlock(&cache->dirty_tail_lock);
> +
> +	return 0;
>  }
>  
>  void cache_writeback_fn(struct work_struct *work)
> @@ -229,6 +237,9 @@ void cache_writeback_fn(struct work_struct *work)
>  	if (pcache_is_stopping(pcache))
>  		goto unlock;
>  
> +	if (atomic_read(&cache->writeback_errors))
> +		goto unlock;
> +
>  	kset_onmedia = (struct pcache_cache_kset_onmedia *)cache->wb_kset_onmedia_buf;
>  
>  	mutex_lock(&cache->dirty_tail_lock);
> @@ -241,15 +252,19 @@ void cache_writeback_fn(struct work_struct *work)
>  	}
>  
>  	if (kset_onmedia->flags & PCACHE_KSET_FLAGS_LAST) {
> -		last_kset_writeback(cache, kset_onmedia);
> +		ret = last_kset_writeback(cache, kset_onmedia);
> +		if (ret) {
> +			atomic_inc(&cache->writeback_errors);
> +			goto unlock;
> +		}
>  		delay = 0;
>  		goto queue_work;
>  	}
>  
>  	ret = cache_kset_insert_tree(cache, kset_onmedia);
>  	if (ret) {
> -		delay = PCACHE_CACHE_WRITEBACK_INTERVAL;
> -		goto queue_work;
> +		atomic_inc(&cache->writeback_errors);
> +		goto unlock;
>  	}
>  
>  	cache_wb_tree_writeback(cache, get_kset_onmedia_size(kset_onmedia));
> -- 
> 2.53.0
> 
> 

Did not apply :(
