Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8F5013C7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463754; cv=none; b=QEjChsi3DRcDwnwxCvM28SdRxy0YvTVTHcpol6JhxsKZdzXwK3VCzWKhaBonhe/rziELYyXVFCCyT5u1lFU2jsNa6vLpXWwuKOvP80hFw4zBr0uDAtMstbsnqzBUNLljK7RJvDYbq8x9YqJCNF4GW//dvVSV7Dlb3ra4Sd47pTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463754; c=relaxed/simple;
	bh=fsYz5O07GzGmgwwe1sPStMp3OsWvR/GGbE19QoClzwo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pVINueNeSy43wEpMR9JurhvoCqnRjJFmfdyfsy/PzPuaOlvZomasYwQOAeoVVCZe45XI9NzwxW3jT6JC4uoQCHlFHjM26rgJZllXg3f+ni8I/nZVrE7q4PYKxJKcYoECvOyKjkaTUq/iiQrekeGz5oHhveu1+Ulhmjh8HX6Ksh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tvgyRBmB; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvgyRBmB"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-867a943b149so4781187b3.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788463741; x=1789068541; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OoR6pZN72NJ64+H4OXZZkiF8k8btvvNHA2jXryPOS7Y=;
        b=tvgyRBmBtxZz60TkrvlqOvLWw5qyTkJFsxxYvIzMERY65FlA7CK6NeF6vkk6yTaGyg
         VKJgQT0yZe1l21GxffPnczAagosGBl2vSJHclNC95H2LdZPpeBikh7hIwAgFXOfuk10E
         V4j78NQCHG5XBjwOMqDe5hOOlIuWzMlY2y7fgA6sSqO0o/paAqnqau/tauraBP8i2V+a
         X1gdH1MweqljTDLzelBWycJ+requwg2K88b2KWyk+fZaTBriTfRv5rBm5vCt3YFxLmxB
         f//CeuyUiO/zqcgsvoBaNEiNzjIdn4lBn89ublFMWdIHTwYtHHJFNKwQs0jUYkYE32/n
         c+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463741; x=1789068541;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OoR6pZN72NJ64+H4OXZZkiF8k8btvvNHA2jXryPOS7Y=;
        b=ZmigfU1N7s5oz+sXY4VIBY+u3T0wvhNXSEFyGOWo782ucfWwaP156x5qFR18bxcMzl
         xn8RMdBiDJhql+QeyqOdH/SUt1SvKQ76nJsb/c4h9xwSaXoFD89tKBSln7kGSruI+1xX
         CftJ7z/cu2wH2RITkVqhT2y8aqqSPnJ68MpDbpyXRVhz68XQGGx1oQDKUD+EEbRcoKnD
         yQWnImQ2OUN2fGxUP8DMoioEc7Adlf+rurnfLC0kyJN1jnUird3LUN+bKa2SlMKqzNQv
         6F4qd+ZBuagmrqMUyOQW69OmWhTpxgcp6EjgV+RSiiEcXFdRsC8sfHkiy8OCmhW/LK14
         sQhw==
X-Gm-Message-State: AFuF++leMy/REdrikGEA3dkM07G00oI87MFEGuYVNCoAxK8ftXE7Ts+z
	0O8nSPK+XgKWEAZON2hG3qBl/xhHqeiZOfGB0Llwl+zoAgEvUADGGE7O1us9bID2GEPV24Z1pDY
	gBjdDsqn7irA=
X-Gm-Gg: AYBFou3Ys0dqq9izGAkrv9jKg1AjVWcGazR+mqlbMfWC7BFVSnngsIUCz/YVg9thN76
	WwJkm5HjLd8utbBKhDy/CZqopmSxWwFBejRBAGq9N6xuEWmqGyRS7moPa2Cn9tb9zIvzF9BBPTP
	/yAnWfwssMwHZBkAk8DZDGwkOuOEREdUQaVJp3R5wlYkkzGNBaA8gyB4O3Cc/GPqHz78Ni/OMAd
	5UBBNGiYKAYjVOIV5wu2yEvb9FulEmUK1+QyPTF+JJ+htEge6sWiLfde1R98l3+g+VkfivwYN2g
	PQ7WUdCZvDxk0NLNzvFV3g1q+ypCJYDqYgrlTvHlEnwUX9Qb7tR4IOtJvbDQK7jM/C3q25Xg8Fr
	OcqOA8pAgeRohhG2YJLCsZRmEzu7kzwZbuaejP2RG62yZZK5h7nTF7jYI+uEkEZKtgFNNAmms+J
	anVOAaSaSboFJFu49p6o8pMzKAiweG6sTe9jOUGEetOZW1G/7RGELMFo49paFYPzcrf8nyBi+IH
	XupnUlObmIbDvsNnb1SPhL17DuUVyAVXtMmrn8RYFYPP/ol
X-Received: by 2002:a05:690c:6605:b0:868:505e:b96d with SMTP id 00721157ae682-87121cc38camr6875837b3.2.1788463740113;
        Thu, 03 Sep 2026 12:29:00 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714a49a660sm2560107b3.27.2026.09.03.12.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:28:59 -0700 (PDT)
Date: Thu, 3 Sep 2026 12:28:57 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Sasha Levin <sashal@kernel.org>
cc: stable@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
    Qi Zheng <zhengqi.arch@bytedance.com>, Zi Yan <ziy@nvidia.com>, 
    David Hildenbrand <david@redhat.com>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Wei Yang <richard.weiyang@gmail.com>, Harry Yoo <harry.yoo@oracle.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>, 
    Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
    Lance Yang <lance.yang@linux.dev>, Liam Howlett <liam.howlett@oracle.com>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
    Nico Pache <npache@redhat.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
    Ryan Roberts <ryan.roberts@arm.com>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y 2/6] mm: thp: use folio_batch to handle THP
 splitting in deferred_split_scan()
In-Reply-To: <20260903182650.1451393-2-sashal@kernel.org>
Message-ID: <07ec4d72-eb75-8b75-bbeb-88172af0567e@google.com>
References: <2026090356-glacial-cornball-be8c@gregkh> <20260903182650.1451393-1-sashal@kernel.org> <20260903182650.1451393-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 3 Sep 2026, Sasha Levin wrote:

> From: Muchun Song <songmuchun@bytedance.com>
> 
> [ Upstream commit 776bde7caf80f6af72b087cafe7d9f607b14716d ]
> 
> The maintenance of the folio->_deferred_list is intricate because it's
> reused in a local list.
> 
> Here are some peculiarities:
> 
>    1) When a folio is removed from its split queue and added to a local
>       on-stack list in deferred_split_scan(), the ->split_queue_len isn't
>       updated, leading to an inconsistency between it and the actual
>       number of folios in the split queue.
> 
>    2) When the folio is split via split_folio() later, it's removed from
>       the local list while holding the split queue lock. At this time,
>       the lock is not needed as it is not protecting anything.
> 
>    3) To handle the race condition with a third-party freeing or migrating
>       the preceding folio, we must ensure there's always one safe (with
>       raised refcount) folio before by delaying its folio_put(). More
>       details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>       split queue not partially_mapped"). It's rather tricky.
> 
> We can use the folio_batch infrastructure to handle this clearly.  In this
> case, ->split_queue_len will be consistent with the real number of folios
> in the split queue.  If list_empty(&folio->_deferred_list) returns false,
> it's clear the folio must be in its split queue (not in a local list
> anymore).
> 
> In the future, we will reparent LRU folios during memcg offline to
> eliminate dying memory cgroups, which requires reparenting the split queue
> to its parent first.  So this patch prepares for using
> folio_split_queue_lock_irqsave() as the memcg may change then.
> 
> Link: https://lkml.kernel.org/r/59cb6b6fb5ffcff9d23b81890b252960139ad8e7.1762762324.git.zhengqi.arch@bytedance.com
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: c299a2285d9d ("mm/huge_memory: use folio's memcg inside __folio_split()")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Oh dear, more of these Stable-dep-ofs. I just happened to be Cc'ed on
this one, and after commenting on the pincount ones, I'd better comment
on this too: we definitely want Zi Yan's XA_FLAGS_ACCOUNT fix, but
deferred split queue is tricky: so I'd judge that this should not
go forward without explicit Acks from... whoever knows best.

Hugh

> ---
>  mm/huge_memory.c | 130 ++++++++++++++++++++++++-----------------------
>  1 file changed, 66 insertions(+), 64 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 11a58a93f361b..27d97afd22be1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3686,19 +3686,21 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	bool is_anon = folio_test_anon(folio);
>  	struct address_space *mapping = NULL;
>  	struct anon_vma *anon_vma = NULL;
> -	int order = folio_order(folio);
> +	int old_order = folio_order(folio);
>  	struct folio *new_folio, *next;
> +	int extra_pins;
>  	int nr_shmem_dropped = 0;
> -	int remap_flags = 0;
> -	int extra_pins, ret;
> -	pgoff_t end;
> -	bool is_hzp;
> +	enum ttu_flags ttu_flags = 0;
> +	pgoff_t end = 0;
> +	int ret;
>  
>  	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
>  	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
>  
> -	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
> -		return -EINVAL;
> +	if (folio != page_folio(split_at) || folio != page_folio(lock_at)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
>  	/*
>  	 * Folios that just got truncated cannot get split. Signal to the
> @@ -3710,14 +3712,12 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	if (!is_anon && !folio->mapping)
>  		return -EBUSY;
>  
> -	if (new_order >= folio_order(folio))
> -		return -EINVAL;
> -
> -	if (!folio_split_supported(folio, new_order, uniform_split, /* warn = */ true))
> -		return -EINVAL;
> +	if (new_order >= old_order) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
> -	is_hzp = is_huge_zero_folio(folio);
> -	if (is_hzp) {
> +	if (is_huge_zero_folio(folio)) {
>  		pr_warn_ratelimited("Called split_huge_page for huge zero page\n");
>  		return -EBUSY;
>  	}
> @@ -3725,6 +3725,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	if (folio_test_writeback(folio))
>  		return -EBUSY;
>  
> +	ret = folio_split_supported(folio, new_order, uniform_split,
> +				    /* warns = */ false) ? 0 : -EINVAL;
> +	if (ret) {
> +		VM_WARN_ONCE(ret == -EINVAL, "Tried to split an unsplittable folio");
> +		goto out;
> +	}
> +
>  	if (is_anon) {
>  		/*
>  		 * The caller does not necessarily hold an mmap_lock that would
> @@ -3817,21 +3824,22 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  		struct lruvec *lruvec;
>  		int expected_refs;
>  
> -		if (folio_order(folio) > 1 &&
> -		    !list_empty(&folio->_deferred_list)) {
> -			ds_queue->split_queue_len--;
> +		if (folio_order(folio) > 1) {
> +			if (!list_empty(&folio->_deferred_list)) {
> +				ds_queue->split_queue_len--;
> +				/*
> +				 * Reinitialize page_deferred_list after removing the
> +				 * page from the split_queue, otherwise a subsequent
> +				 * split will see list corruption when checking the
> +				 * page_deferred_list.
> +				 */
> +				list_del_init(&folio->_deferred_list);
> +			}
>  			if (folio_test_partially_mapped(folio)) {
>  				folio_clear_partially_mapped(folio);
>  				mod_mthp_stat(folio_order(folio),
>  					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>  			}
> -			/*
> -			 * Reinitialize page_deferred_list after removing the
> -			 * page from the split_queue, otherwise a subsequent
> -			 * split will see list corruption when checking the
> -			 * page_deferred_list.
> -			 */
> -			list_del_init(&folio->_deferred_list);
>  		}
>  		split_queue_unlock(ds_queue);
>  		if (mapping) {
> @@ -3941,8 +3949,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  		shmem_uncharge(mapping->host, nr_shmem_dropped);
>  
>  	if (!ret && is_anon)
> -		remap_flags = RMP_USE_SHARED_ZEROPAGE;
> -	remap_page(folio, 1 << order, remap_flags);
> +		ttu_flags = (enum ttu_flags)RMP_USE_SHARED_ZEROPAGE;
> +	remap_page(folio, 1 << old_order, ttu_flags);
>  
>  	/*
>  	 * Drop the mapping while the inode is still pinned. @folio stays
> @@ -3985,9 +3993,9 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  		i_mmap_unlock_read(mapping);
>  out:
>  	xas_destroy(&xas);
> -	if (order == HPAGE_PMD_ORDER)
> +	if (old_order == HPAGE_PMD_ORDER)
>  		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
> -	count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT_FAILED);
> +	count_mthp_stat(old_order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT_FAILED);
>  	return ret;
>  }
>  
> @@ -4230,35 +4238,40 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  {
>  	struct deferred_split *ds_queue;
>  	unsigned long flags;
> -	LIST_HEAD(list);
> -	struct folio *folio, *next, *prev = NULL;
> -	int split = 0, removed = 0;
> +	struct folio *folio, *next;
> +	int split = 0, i;
> +	struct folio_batch fbatch;
> +
> +	folio_batch_init(&fbatch);
>  
> +retry:
>  	ds_queue = split_queue_lock_irqsave(sc->nid, sc->memcg, &flags);
>  	/* Take pin on all head pages to avoid freeing them under us */
>  	list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
>  							_deferred_list) {
>  		if (folio_try_get(folio)) {
> -			list_move(&folio->_deferred_list, &list);
> -		} else {
> +			folio_batch_add(&fbatch, folio);
> +		} else if (folio_test_partially_mapped(folio)) {
>  			/* We lost race with folio_put() */
> -			if (folio_test_partially_mapped(folio)) {
> -				folio_clear_partially_mapped(folio);
> -				mod_mthp_stat(folio_order(folio),
> -					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
> -			}
> -			list_del_init(&folio->_deferred_list);
> -			ds_queue->split_queue_len--;
> +			folio_clear_partially_mapped(folio);
> +			mod_mthp_stat(folio_order(folio),
> +				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>  		}
> +		list_del_init(&folio->_deferred_list);
> +		ds_queue->split_queue_len--;
>  		if (!--sc->nr_to_scan)
>  			break;
> +		if (!folio_batch_space(&fbatch))
> +			break;
>  	}
>  	split_queue_unlock_irqrestore(ds_queue, flags);
>  
> -	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
> +	for (i = 0; i < folio_batch_count(&fbatch); i++) {
>  		bool did_split = false;
>  		bool underused = false;
> +		struct deferred_split *fqueue;
>  
> +		folio = fbatch.folios[i];
>  		if (!folio_test_partially_mapped(folio)) {
>  			/*
>  			 * See try_to_map_unused_to_zeropage(): we cannot
> @@ -4281,38 +4294,27 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  		}
>  		folio_unlock(folio);
>  next:
> +		if (did_split || !folio_test_partially_mapped(folio))
> +			continue;
>  		/*
> -		 * split_folio() removes folio from list on success.
>  		 * Only add back to the queue if folio is partially mapped.
>  		 * If thp_underused returns false, or if split_folio fails
>  		 * in the case it was underused, then consider it used and
>  		 * don't add it back to split_queue.
>  		 */
> -		if (did_split) {
> -			; /* folio already removed from list */
> -		} else if (!folio_test_partially_mapped(folio)) {
> -			list_del_init(&folio->_deferred_list);
> -			removed++;
> -		} else {
> -			/*
> -			 * That unlocked list_del_init() above would be unsafe,
> -			 * unless its folio is separated from any earlier folios
> -			 * left on the list (which may be concurrently unqueued)
> -			 * by one safe folio with refcount still raised.
> -			 */
> -			swap(folio, prev);
> +		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
> +		if (list_empty(&folio->_deferred_list)) {
> +			list_add_tail(&folio->_deferred_list, &fqueue->split_queue);
> +			fqueue->split_queue_len++;
>  		}
> -		if (folio)
> -			folio_put(folio);
> +		split_queue_unlock_irqrestore(fqueue, flags);
>  	}
> +	folios_put(&fbatch);
>  
> -	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> -	list_splice_tail(&list, &ds_queue->split_queue);
> -	ds_queue->split_queue_len -= removed;
> -	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> -
> -	if (prev)
> -		folio_put(prev);
> +	if (sc->nr_to_scan && !list_empty(&ds_queue->split_queue)) {
> +		cond_resched();
> +		goto retry;
> +	}
>  
>  	/*
>  	 * Stop shrinker if we didn't split any page, but the queue is empty.
> -- 
> 2.53.0
> 
> 
