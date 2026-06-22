Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D699390234;
	Mon, 22 Jun 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116699; cv=none; b=G5TWlBn/b+HWra5pJSn4hWID9NQf3rDUiC/Ku9+N4y6Q05wgtTZItQO1moUYzcxDMLC9FyYjN3CUw9BnmxePupgd5J7fEXpZmi5hKEbzrjjWqs70vPI8zHabLm2WFsjXw0Df0SP2pnY17SCEwddxhH1FkxYDrhkyL0zlYQra+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116699; c=relaxed/simple;
	bh=Pg7hW6UKHEUVKYo53Yka4oI7nfp4gN1bRWO+XPjuT9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAgRudcliNUJNAMbRtbfM94OsSV4Aq12acMxffyRft2O+YWvw30VwfP/Nd6dQ/dRsMfa8BBB2J/VwrRCEwLQH/i1/eySCPSv0ME8UqjMBXBIVH7PA1hPQLgzkPbA22O5V7LvAXA/eD8X+ELR5MONT96OjdfeUTqysRYaVvdgFVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=LGvAaws2; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="LGvAaws2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1782116671;
	bh=aFSO6AHP6WYDaFwfcRLcXH+hUoEb893SICpnQ5kYTyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=LGvAaws27AHu5l3g7y7vx5mnEf7fsvlp5HoEAq4RJdscwG7lhZAniJjhLgTBJ3ZVA
	 Zi/3MwaBvTgicfWQRJnALukNLjmIXWiNfRtqqKMXmsG3lvA+Ub2lGfbh2Z2IRsbkYb
	 OwFrMQ8kwIQv8tzxxbrrvIdHsjjQz+5T1yO2nI6U=
X-QQ-mid: zesmtpsz5t1782116664t87087744
X-QQ-Originating-IP: aohLYNy9A2EbmAsTJnCfZLbDfB7g8+Zs+Hv+rcxIqUU=
Received: from [127.0.0.1] ( [202.119.42.245])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 16:24:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16359244240173991143
Message-ID: <F5EBCFC495955241+61489c47-c792-43de-a8f8-4b1030f4ab6a@smail.nju.edu.cn>
Date: Mon, 22 Jun 2026 16:24:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Qi Zheng <qi.zheng@linux.dev>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, harry@kernel.org,
 muchun.song@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn>
 <20260622073703.79258-1-qi.zheng@linux.dev>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <20260622073703.79258-1-qi.zheng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OQZoPFOgkfDq/kPAOy3/RxrWZFlsA9EHBX8QVE48UKrEBG1WQVOIAsex
	xUbTTnGc83b1BDi2Nr9TLjgO7qW4oNsgKmB35/UqAgf6JmPFJ6KgtK5E9NOc/kcoLzQYnmm
	YdCqitMs+tvLX3LmeM5d32YT4f7fL7TXXipzISgw1SC7Ih9z20r+97PXXut+OQU24PyYlYV
	Ipkiy4OfnNZR/ooA+4pfoMWzAZoasqT6TUkJPfh+stbJzyyciDAuWUw+xVMEYpeVy1+H1UA
	4p9CbR/vXTJzBIFEis7VKfJ4avP/qyxOhvzqkP0Wc2gSv4gBBW1yv4cW2e3E8Ut/gsWCcLK
	7/6sz2ZZhxlHc+iGcbzd+gEXxhs+3ZZD56kJ/hKbV7vY/5mvGa+po1R1ZgZBUf+8CIaWvBX
	1QDmBCS7Ea4ET/JYBs9WiN37mW/nRw+VjhVZ6zrYfl4YFS9jlPSTtQidN3cXHv5puLx577+
	HtPpQ7YkKa1TyDc6szstWt0wggtP3g7FxDIWXUz0psXQAq0y3FD+uPb+noSGHhbPaXifL6B
	5EeWncPaQT8RZu1y41ccY1rvNgCEf0zGzq8NQ59gALiNw/hrC7VSx1KWQvOm+Pcy9yWr59h
	owsuQn5mAS9hHhD7Xf8mXiwIKLrVQcdskAHNsgtT2ZmTDsk4iAYbzjUs5K1PyzCha6KHe8y
	oP6HWz8PtX3Ym5qnRZiBUriARxqro3vUaxXxatKlu+nXkTMYqE0ytEEFvv9Tl/2kKJcpiV1
	46S2BUsdmRCdkRUfpTZlc2FAx7MFZCFZRXYOQTbHEhjgzu2PRRD48NKhrBEb2CeRivBtlHO
	+LpaOf1DVIxXFJ6slMbcXSvuupTULTb0x3OfCs8FCEj08B+l6PseshMyZKJPIFE/clCI0OL
	cy6Cl7aBYMO9OuV5zrHBscZwH6QFDioQD0xblj9jkKZzwDDx119CYpL1CmTBDJTNWjwAueI
	nwuxz2gMYXVVxTgplHh7JQcysMeGa/csDhmZBEVx4KsI4ucRcKprXU1My6xmE+LizR2QHtZ
	aZmKkzV7S0dx6lPfT0t9dl0Q8w86Wa8GKQezbSnxcO+cGY53EbzZyFt4g78AKxcXSiOE29n
	DOyIGY4LmV1
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Hi Qi,

Thanks for confirming this bug and proposing the patch. The fix I previously proposed was indeed incorrect. I have applied your patch and tested it using the PoC script that previously triggered the warning; no warning is observed anymore.

Best,
Peiyang

On 2026/6/22 15:37, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> The mglru page table walker batches per-generation size deltas in
> walk->nr_pages while walking page tables without holding the lruvec lock.
> The reset_batch_size() later folds those deltas into walk->lruvec under
> the lruvec lock.
> 
> The page table walker can run concurrently with the memcg reparenting path
> as follows:
> 
> CPU0                           CPU1
> ====                           ====
> 
> walk_mm
> --> walk_page_range
>     --> update_batch_size
>         --> walk->nr_pages += delta
> 
>                               mem_cgroup_css_offline
>                               --> memcg_reparent_objcgs
>                                   --> lock lruvec
>                                       lru_gen_reparent_memcg
>                                       --> reparent child folios to parent
>                                       unlock lruvec
> 
>     lock lruvec
>     reset_batch_size
>     --> child lrugen->nr_pages += delta
> 
> This can trigger the following warning:
> 
> WARNING: mm/vmscan.c:5867 at lru_gen_exit_memcg+0x26f/0x300
> RIP: 0010:lru_gen_exit_memcg+0x26f/0x300 mm/vmscan.c:5867
> Call Trace:
>   <TASK>
>   mem_cgroup_free mm/memcontrol.c:3972 [inline]
>   mem_cgroup_css_free+0x76/0xb0 mm/memcontrol.c:4241
>   css_free_rwork_fn+0x125/0x1260 kernel/cgroup/cgroup.c:5575
>   process_one_work+0xa0d/0x1c30 kernel/workqueue.c:3314
>   process_scheduled_works kernel/workqueue.c:3397 [inline]
>   worker_thread+0x645/0xe80 kernel/workqueue.c:3478
>   kthread+0x367/0x480 kernel/kthread.c:436
>   ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> 
> To fix it, add lrugen->reparented to remember the new owner of a
> reparented lruvec, and make reset_batch_size() charge pending deltas to
> that owner.
> 
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/mmzone.h |  4 ++++
>  mm/vmscan.c            | 43 +++++++++++++++++++++++++++++++++++-------
>  2 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index ca2712187147..0d572db2ef64 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -584,6 +584,10 @@ struct lru_gen_folio {
>  	u8 gen;
>  	/* the list segment this lru_gen_folio belongs to */
>  	u8 seg;
> +#ifdef CONFIG_MEMCG
> +	/* the lruvec this lruvec has been reparented to */
> +	struct lruvec *reparented;
> +#endif
>  	/* per-node lru_gen_folio list for global reclaim */
>  	struct hlist_nulls_node list;
>  };
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 35c3bb15ae96..64362cbed814 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3262,10 +3262,37 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
>  	walk->nr_pages[new_gen][type][zone] += delta;
>  }
>  
> +#ifdef CONFIG_MEMCG
> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
> +{
> +	struct lruvec *reparented;
> +
> +	for (;;) {
> +		lruvec_lock_irq(lruvec);
> +
> +		reparented = lruvec->lrugen.reparented;
> +		if (!reparented)
> +			break;
> +
> +		lruvec_unlock_irq(lruvec);
> +		lruvec = reparented;
> +	}
> +
> +	return lruvec;
> +}
> +#else
> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
> +{
> +	lruvec_lock_irq(lruvec);
> +
> +	return lruvec;
> +}
> +#endif
> +
>  static void reset_batch_size(struct lru_gen_mm_walk *walk)
>  {
>  	int gen, type, zone;
> -	struct lruvec *lruvec = walk->lruvec;
> +	struct lruvec *lruvec = lock_batch_lruvec(walk->lruvec);
>  	struct lru_gen_folio *lrugen = &lruvec->lrugen;
>  
>  	walk->batched = 0;
> @@ -3285,6 +3312,8 @@ static void reset_batch_size(struct lru_gen_mm_walk *walk)
>  			lru += LRU_ACTIVE;
>  		__update_lru_size(lruvec, lru, zone, delta);
>  	}
> +
> +	lruvec_unlock_irq(lruvec);
>  }
>  
>  static int should_skip_vma(unsigned long start, unsigned long end, struct mm_walk *args)
> @@ -3779,11 +3808,8 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
>  			mmap_read_unlock(mm);
>  		}
>  
> -		if (walk->batched) {
> -			lruvec_lock_irq(lruvec);
> +		if (walk->batched)
>  			reset_batch_size(walk);
> -			lruvec_unlock_irq(lruvec);
> -		}
>  
>  		cond_resched();
>  	} while (err == -EAGAIN);
> @@ -4563,6 +4589,8 @@ void lru_gen_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent,
>  			mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
>  		}
>  	}
> +
> +	child_lruvec->lrugen.reparented = parent_lruvec;
>  }
>  
>  #endif /* CONFIG_MEMCG */
> @@ -4867,9 +4895,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	walk = current->reclaim_state->mm_walk;
>  	if (walk && walk->batched) {
>  		walk->lruvec = lruvec;
> -		lruvec_lock_irq(lruvec);
>  		reset_batch_size(walk);
> -		lruvec_unlock_irq(lruvec);
>  	}
>  
>  	mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
> @@ -5784,6 +5810,9 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
>  
>  	lrugen->max_seq = MIN_NR_GENS + 1;
>  	lrugen->enabled = lru_gen_enabled();
> +#ifdef CONFIG_MEMCG
> +	lrugen->reparented = NULL;
> +#endif
>  
>  	for (i = 0; i <= MIN_NR_GENS + 1; i++)
>  		lrugen->timestamps[i] = jiffies;


