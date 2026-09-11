Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6D832E696
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135702; cv=none; b=r81NBLOhx4wb7D/W6r3ZP9TbgrftZU2fLiqC/spqQ+viCQmUGflLfkHZPesdkwiV7igrW1c00jUgmm80znqiUpH8xEDVThQa3ka63sioLfzxa3ouTa4yX6Aw82Gcf123YyC/Z4FdROZJs2hAl/OAc0rlLn+gB9jkbKWr4Riy5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135702; c=relaxed/simple;
	bh=Y5gzuVoI9szX4PY+8YRQV966EhlHioE/3pQ9KAz2CMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nh75o4KFpz67zrUKC5PPSJzqN0pnZlGKY/ba4NpfTbsC3Evj+Ln23AF1RWN6tvyx2+RCJraBvoKA2Wl939bHDMuJmAhFWnwlnqMWc9s8BJzhjZxmsyRLxr5Lyx2kGzM2P/8MQLjPQjOnBxRCLBj+EUq8ZfL+mVbavvg4qRNlCc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLRIG3RE; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLRIG3RE"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f3f52143cdso1002215a34.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789135699; x=1789740499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZjLf6+iZ0PXye5aRZ/dUkHiadjJGzqPf0A0418Uc0K8=;
        b=OLRIG3REq2p+2XcSz8bZvRR3cDprZNf7MPqID+6uoJPCjERFU3OcRdrnPXUSjxW6rm
         f70bg4gC1LiKxt5YiVNiyJjdXqB/ezdWi+UVsISuteMqwNTNZevpRnmtP25LrEx1t/us
         Rp2OoIBGmSOn1fUb9h1eztaCeE8VKi9Mua9kBHVFIBngTmla7ob/j+fwfS4mB6b8ZZ1/
         JwEIBNpSGt19U+nCcE5pFGknei+RTiWLL0clp2/ACe7BJNoNE0sPikZPyeEha0e7RE1U
         BTrV1eS20JMmqhLYZgXrAB+a629O44aHiT7zRJg5LIJKX4b9NzhXXIML/Q17Ooh/Ygoa
         F9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135699; x=1789740499;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjLf6+iZ0PXye5aRZ/dUkHiadjJGzqPf0A0418Uc0K8=;
        b=T3JzEd/BtETcJyl2gqV62TNSukfEKxfsEijlX4y6VL5Xh4f1mO/S9vC1da4SCM8Myl
         /CyFZePvxI/YEKweTPik3kUXFOPFgyQllv6w10YccSvhqF/NRE9mEly2th3gACyt41iK
         kM95HIWnczKaJCLx7NF5anCWVr7iVFLcSFIzwmSNQdAW1iDVTSpoCIQtRYxMHQm00F6O
         IBo+fUovCNbg305kTAJlNQisAXPbONlYBMBxuAOk1uuW3sHr4QrZEoNKT81FEylfmoqZ
         EHAKqVZWdR9wOOZQ3Qfu6W98cDBHjaHj6yiMTLDgCf5xZjPnQ3s+a6fnuC6fXzcH9Ew7
         u04g==
X-Forwarded-Encrypted: i=1; AKwUvByQPB060Y8oMcRKXWMsUy6zhWE/RQZRsH6oNxm7lAQEe2Dn0MOkH2vwp6U3CptFh+H8ffFiulE=@vger.kernel.org
X-Gm-Message-State: AFuF++lBi2PgY5jK2/62jr75egw2c6tOmpPvWQ1KNK4A0kzSIWgeOQ/J
	gPhxRNHbLo5jqSbcMqrZUA8hmM5Lg5vhp0BcOze1B0ni6UGo/etgEXXT
X-Gm-Gg: AYBFou2nrziPfTd/uLaDe2LZ8WaorlpgkCId7bH+qd4Pq4SFFDrlXNFnYD7ZB52SxZj
	Bo0WNtj/z3MXoeulPmZqJfqS3tluI8gEX3pe3cqNAvgKpefghCWuyqBp+xl+mpmXjH6f6C0aJ8t
	Qv00yNNGDWpyJuHxrr4/lpWFr/r68qTfZjrC3ATKBQBpy1kgPudG6bAWV36czfTzWH7ss9MkLly
	P9scMkjn9D7EScLUthhn0bHTebvD/HeslP/yziR00iNa3JQwVeA/yB9KvJHFed0pim2zV6viZBx
	4NmCqoZ/JMtgkqV8ZyRAwyq4GMl5lImlmww/vHMHKG2mISQEIQYHPX310ZjJ1xSlvGYKotdu7qn
	oTOsDL+4Xy2UsGuwvvLmsYXDu7Pg2HWU6gpb5VTwTzs05k3Ch8Xr44SdtAW91J4tt4bhWCBekMZ
	1rEDlbGKSpzhewlbk1YktW0DXv3l/mrqvCw9Qb3f2kHW1de6XTHdjkcMVsdIKxIESbJV956inXs
	Y55L2J8MRx/QWmy0jcBMaGujXEEDg==
X-Received: by 2002:a05:6830:6af8:b0:7f8:9fba:2cd8 with SMTP id 46e09a7af769-803ff332991mr3304795a34.9.1789135698444;
        Fri, 11 Sep 2026 07:08:18 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f5adf69csm2520486a34.7.2026.09.11.07.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:08:17 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Hongxiang Lou <louhongxiang@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wupeng Ma <mawupeng1@huawei.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	fvdl@google.com,
	jthoughton@google.com,
	rientjes@google.com,
	vannapurve@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Ackerley Tng <ackerleytng@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: hugetlb: Track used_hpages when getting/putting pages from subpool
Date: Fri, 11 Sep 2026 07:08:14 -0700
Message-ID: <20260911140816.3236725-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909-hugetlb-subpool-always-track-used-v2-1-30c5d83b572a@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 09 Sep 2026 14:49:26 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:

> From: Ackerley Tng <ackerleytng@google.com>
Hi Ackerley,

Thank you for working on this fix / simplification! 

> HugeTLB subpools currently only track used_hpages when the user
> configures a size limit.
> 
> This is buggy since when there are existing allocations from the
> subpool that would have satisfied the minimum reservations,
> hugepage_subpool_put_pages() will still restore a reservation to the
> subpool. See below for an example of a false reservation.

I'm not sure if I see the false reservation example, could I be
missing something here : -)

> In addition, the subpool is considered free prematurely, is freed, and
> this ends up causing a use-after-free.

That doesn't sound like a fun time!!

> The fix is to always track used_hpages within subpools, which is also
> beneficial in general because with that information, reservation
> tracking is also fully managed within hugepage_subpool_put_pages().

This is an increditly reasonable approach and I really like how we can
get rid of a lot of the if (spool->max_hpages) ... special casing.
Having different conditions for checking whether a subpool was / wasn't
free was also a bit strange to me as well...

> The subpool always knows how many pages were allocated through it. Every
> page allocated through the subpool increments used_hpages, regardless of
> whether a reservation was taken from it.
> 
> Conceptually, now, every allocation involving a subpool uses a page from
> the subpool, which must be returned to the subpool. Every page taken from
> the subpool tries to use a subpool reservation. Restoring a page to the
> subpool reservations only if the page was taken from subpool
> reservations. (If used_hpages >= min_hpages, the page must have not have
> been taken from the reservations.)
> 
> Always tracking used_hpages provides the subpool with information of both
> used and reserved counts to make the correct decision for both max_size and
> min_size correctly.
> 
> With used_hpages always tracked, subpool_is_free() can be simplified, such
> that the subpool can be declared free if there are no more pages in use.

Awesome!

> Also update the
> 
> + Documentation for used_hpages in the subpool struct, since it no longer
>   matters whether the used pages count against the maximum.
> + Docstring for hugepage_subpool_{get,put}_pages
> + Documentation to use active voice, and remove some details in favor of
>   having details documented in the docstring
> 
> Also update statfs reporting. Previously, if max_hpages is negative,
> used_hpages is static at 0, so returning max_hpages - used_hpages returns
> -1 and is always correct. Now, if the subpool doesn't have a maximum
> requested size, indicate no limit for free pages (-1). If it does have a
> maximum size, report the difference between the requested size and the
> number of used pages. This difference is always positive, because if the
> mount does have a maximum size, hugepage_subpool_get_pages() ensures that
> the subpool usage never exceeds the maximum.

> Fixes: 1c5ecae3a93fa ("hugetlbfs: add minimum size accounting to subpools")
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Cc: stable@vger.kernel.org

Feel free to add my:
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> ---
>  Documentation/mm/hugetlbfs_reserv.rst              | 17 +----
>  .../translations/zh_CN/mm/hugetlbfs_reserv.rst     | 11 +---
>  fs/hugetlbfs/inode.c                               |  8 ++-
>  include/linux/hugetlb.h                            |  4 +-
>  mm/hugetlb.c                                       | 73 +++++++++++++---------
>  5 files changed, 55 insertions(+), 58 deletions(-)
> 
> diff --git a/Documentation/mm/hugetlbfs_reserv.rst b/Documentation/mm/hugetlbfs_reserv.rst
> index a49115db18c76..d244583fdcbc3 100644
> --- a/Documentation/mm/hugetlbfs_reserv.rst
> +++ b/Documentation/mm/hugetlbfs_reserv.rst
> @@ -314,21 +314,8 @@ huge pages.  If they can not be reserved, the mount fails.
>  The routines hugepage_subpool_get/put_pages() are called when pages are
>  obtained from or released back to a subpool.  They perform all subpool
>  accounting, and track any reservations associated with the subpool.
> -hugepage_subpool_get/put_pages are passed the number of huge pages by which
> -to adjust the subpool 'used page' count (down for get, up for put).  Normally,
> -they return the same value that was passed or an error if not enough pages
> -exist in the subpool.
> -
> -However, if reserves are associated with the subpool a return value less
> -than the passed value may be returned.  This return value indicates the
> -number of additional global pool adjustments which must be made.  For example,
> -suppose a subpool contains 3 reserved huge pages and someone asks for 5.
> -The 3 reserved pages associated with the subpool can be used to satisfy part
> -of the request.  But, 2 pages must be obtained from the global pools.  To
> -relay this information to the caller, the value 2 is returned.  The caller
> -is then responsible for attempting to obtain the additional two pages from
> -the global pools.
> -
> +hugepage_subpool_get/put_pages() use the number of huge pages passed to adjust
> +the subpool 'used page' count.
>  
>  COW and Reservations
>  ====================
> diff --git a/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
> index 20947f8bd0654..ae1f1f31477fc 100644
> --- a/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
> +++ b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
> @@ -246,15 +246,8 @@ hugepage_subpool的min_hpages字段中被跟踪。在挂载时，hugetlb_acct_me
>  被调用以预留指定数量的巨页。如果它们不能被预留，挂载就会失败。
>  
>  当从子池中获取或释放页面时，会调用hugepage_subpool_get/put_pages()函数。
> -hugepage_subpool_get/put_pages被传递给巨页数量，以此来调整子池的 “已用页面” 计数
> -（get为下降，put为上升）。通常情况下，如果子池中没有足够的页面，它们会返回与传递的相同的值或
> -一个错误。
> -
> -然而，如果预留与子池相关联，可能会返回一个小于传递值的返回值。这个返回值表示必须进行的额外全局
> -池调整的数量。例如，假设一个子池包含3个预留的巨页，有人要求5个。与子池相关的3个预留页可以用来
> -满足部分请求。但是，必须从全局池中获得2个页面。为了向调用者转达这一信息，将返回值2。然后，调用
> -者要负责从全局池中获取另外两个页面。
> -
> +它们负责所有子池的统计核算，并跟踪与子池相关联的预留。
> +hugepage_subpool_get/put_pages()函数使用传入的巨页数量来调整子池的“已用页面”计数。
>  
>  COW和预留
>  ==========
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 7611a8470ea26..5113f743f6fc7 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1109,8 +1109,12 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  
>  			spin_lock_irq(&sbinfo->spool->lock);
>  			buf->f_blocks = sbinfo->spool->max_hpages;
> -			free_pages = sbinfo->spool->max_hpages
> -				- sbinfo->spool->used_hpages;
> +			if (sbinfo->spool->max_hpages == -1) {
> +				free_pages = -1;
> +			} else {
> +				free_pages = sbinfo->spool->max_hpages -
> +					     sbinfo->spool->used_hpages;
> +			}
>  			buf->f_bavail = buf->f_bfree = free_pages;
>  			spin_unlock_irq(&sbinfo->spool->lock);
>  			buf->f_files = sbinfo->max_inodes;
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 16c4c4caa126c..4551ff3023640 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -39,8 +39,8 @@ struct hugepage_subpool {
>  	spinlock_t lock;
>  	long count;
>  	long max_hpages;	/* Maximum huge pages or -1 if no maximum. */
> -	long used_hpages;	/* Used count against maximum, includes */
> -				/* both allocated and reserved pages. */
> +	long used_hpages;	/* Used page count, includes both */
> +				/* allocated and reserved pages. */
>  	struct hstate *hstate;
>  	long min_hpages;	/* Minimum huge pages or -1 if no minimum. */
>  	long rsv_hpages;	/* Pages reserved against global pool to */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4f6f58bf3db6c..e72e22f887478 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -130,12 +130,8 @@ static inline bool subpool_is_free(struct hugepage_subpool *spool)
>  {
>  	if (spool->count)
>  		return false;
> -	if (spool->max_hpages != -1)
> -		return spool->used_hpages == 0;
> -	if (spool->min_hpages != -1)
> -		return spool->rsv_hpages == spool->min_hpages;
>  
> -	return true;
> +	return spool->used_hpages == 0;
>  }
>  
>  static inline void unlock_or_release_subpool(struct hugepage_subpool *spool,
> @@ -193,13 +189,18 @@ void hugepage_put_subpool(struct hugepage_subpool *spool)
>  	unlock_or_release_subpool(spool, flags);
>  }
>  
> -/*
> - * Subpool accounting for allocating and reserving pages.
> - * Return -ENOMEM if there are not enough resources to satisfy the
> - * request.  Otherwise, return the number of pages by which the
> - * global pools must be adjusted (upward).  The returned value may
> - * only be different than the passed value (delta) in the case where
> - * a subpool minimum size must be maintained.
> +/**
> + * hugepage_subpool_get_pages - Get pages from a subpool
> + * @spool: pointer to subpool structure (may be NULL)
> + * @delta: number of pages to allocate or reserve
> + *
> + * Check and update subpool page usage counts when allocating or
> + * reserving @delta hugepages.
> + *
> + * Context: Takes spool->lock using spin_lock_irq().
> + * Return: Non-negative number of reservations that cannot be
> + *         satisfied by the subpool, or -ENOMEM if the subpool maximum
> + *         limit would be exceeded.
>   */
>  static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
>  				      long delta)
> @@ -211,15 +212,14 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
>  
>  	spin_lock_irq(&spool->lock);
>  
> -	if (spool->max_hpages != -1) {		/* maximum size accounting */
> -		if ((spool->used_hpages + delta) <= spool->max_hpages)
> -			spool->used_hpages += delta;
> -		else {
> -			ret = -ENOMEM;
> -			goto unlock_ret;
> -		}
> +	if (spool->max_hpages != -1 &&
> +	    spool->used_hpages + delta > spool->max_hpages) {
> +		ret = -ENOMEM;
> +		goto unlock_ret;
>  	}
>  
> +	spool->used_hpages += delta;
> +
>  	/* minimum size accounting */
>  	if (spool->min_hpages != -1 && spool->rsv_hpages) {
>  		if (delta > spool->rsv_hpages) {
> @@ -240,11 +240,19 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
>  	return ret;
>  }
>  
> -/*
> - * Subpool accounting for freeing and unreserving pages.
> - * Return the number of global page reservations that must be dropped.
> - * The return value may only be different than the passed value (delta)
> - * in the case where a subpool minimum size must be maintained.
> +/**
> + * hugepage_subpool_put_pages - Release pages back to a subpool
> + * @spool: pointer to subpool structure (may be NULL)
> + * @delta: number of pages to free or unreserve
> + *
> + * Check and update subpool page usage counts when freeing or
> + * unreserving @delta hugepages.
> + *
> + * Context: Takes spool->lock using spin_lock_irqsave(). May release
> + *          and free @spool if its usage count and references reach
> + *          zero.
> + * Return: Non-negative number of reservations that the subpool cannot
> + *         absorb.
>   */
>  static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
>  				       long delta)
> @@ -257,19 +265,24 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
>  
>  	spin_lock_irqsave(&spool->lock, flags);
>  
> -	if (spool->max_hpages != -1)		/* maximum size accounting */
> -		spool->used_hpages -= delta;
> +	spool->used_hpages -= delta;
>  
>  	 /* minimum size accounting */
>  	if (spool->min_hpages != -1 && spool->used_hpages < spool->min_hpages) {
> -		if (spool->rsv_hpages + delta <= spool->min_hpages)
> 
> +		/*
> +		 * limit is the maximum number of reservations that
> +		 * can be restored to this subpool.
> +		 */
> +		long limit = spool->min_hpages - spool->used_hpages;
> +
> +		if (spool->rsv_hpages + delta <= limit)
>  			ret = 0;
>  		else
> -			ret = spool->rsv_hpages + delta - spool->min_hpages;
> +			ret = spool->rsv_hpages + delta - limit;
>  
>  		spool->rsv_hpages += delta;
> -		if (spool->rsv_hpages > spool->min_hpages)
> -			spool->rsv_hpages = spool->min_hpages;
> +		if (spool->rsv_hpages > limit)
> +			spool->rsv_hpages = limit;
>  	}
>  
>  	/*
> 
> -- 
> 2.55.0.1007.g17ff1f9808-goog
