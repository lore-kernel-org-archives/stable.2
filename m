Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E79218ADD
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648269; cv=none; b=uZR6AzCRRw5BWlBoywqO7UjUdotCoxPNAmaZWuL7O6J++3KKajyMv8n6ItxrzDhda6ho5oROXD4CW1CjVMUllEHLaFt26RmfhVraKNFFAO/nGOEa5uY9Xyxj7BxnB15dqrJt7LXwV3lY4rG2eYzobphmCkouOZkpEkX2QK0dpdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648269; c=relaxed/simple;
	bh=DCJpZQ4qpkoxvbMb/MtS4QB9mAhXuEiRwLsib1+qfgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQpkJQe8JamOBllD65LRc7yIi3pbeUwTfOpFkdm8KE4Y6Vdjthh0wW1XTIt/HVABB2wmO/tiWQOy245tAe0Nb46AqpEqAYHwC3V7Qt+LwpdjOx/z3DqzLMgvap9KBNEOQDPnPF78w0FxnJU6Im7cLai0/MO+kp40YznSg1Q0NVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=rDM4Fy7k; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="rDM4Fy7k"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92ed19f4d60so27439685a.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 18:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783648265; x=1784253065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E8GxFNbQsVrb+BIXdmdxnEvt/Qb6Rl8NGz4M/Bm/cIA=;
        b=rDM4Fy7k6AuX83OGHYHFM0hkE6gBXFDDln6w4m9nDcdd6xqwFS6UIpoPLP0Obe/Kv0
         gQllcGEHM3g7YyGEX9tEOKil5SDwbOQM78CjzS5ggE6+DrlwP0mbzc3ZkpNYO+Pq6sBt
         6dV7geQT5akMOt2npdIvX4liSn9pmcc6f/8/QcubyYqLjEEVCZHjRHTi2OiAIcTO7ESU
         GIw1gDAGLBPR92KgP1lBlmFHsMUb+WKRSpSkaKF/jL8+Dbvkpqm6m2ENl8pGt2CXP2N2
         u2YMG1+VfyPngAQf06jPOWpwqcr5rc4hhzxMmVSXCnO+ZO4WmlnoYvWGribuCRd6fASz
         bb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783648265; x=1784253065;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E8GxFNbQsVrb+BIXdmdxnEvt/Qb6Rl8NGz4M/Bm/cIA=;
        b=HJtNWr1Kmq1Ji8RoePKTdjZNL6hGZcSHdAuEycHcnUdo0i9GsoE4oFYuiCr2FZ8xmP
         Lt1aDi2QsnyfFRVcb8/PsozFmW8Cfgj9OF2XHovET+vm0PmHAfv3usfVPn7E/0FqCAfP
         c9XzKuwveFKhZX/3C4FeEIaib0d+zDJQneM6KL3q2syVke0VhJ+zA0NNuXLLLpfkt4bf
         w+EGjSsNAcVHnnhk6BH37PPewNKiktqtlZWMmaqUMjLt/K39zNZXvxNyKy3rlIdwNS8s
         IhJ+lzHC8SP//95d/p88aW4tAeqS+LjvaE4qsF1m5OvDLic3Lfe4bnn77WkZ/vSjjFWK
         r/HQ==
X-Forwarded-Encrypted: i=1; AHgh+RonZxgJ6EsHh5pMBK+bENqKzRgyVXu+mp3WWja5XX4/VMgqUzPv1HTQqV5SlEiBGfFDpqeHqC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXceW4B/mne8yGkFnrb7HwrhERAuA+7dHpZREQEA9N2AJm9SH
	lSyLD2zQ1eZkXXGes3VNXBvGdry1v66xYcqvMvIV5wltUxdS1vYqqHN/ZWStwPwKmbQ=
X-Gm-Gg: AfdE7cnqhGTF0xniBrCK63upHJc46wBcTnbMr0s5FE8IUaqEVy7l6xFKDMQi3ZMVQTC
	7tswpoX8c+NDoP+TqmehT5jO90d+Vboy3eCLfM5wwyfrwFSw/sgWkK8DV9EX92nHyI0DK2M8o64
	GhkJT8wBzCB9UKW5ZpDVGOj6s9nvgCBwlvsTB9WIfovhljunhDWI1EaBYZiPYzVG4u/oZt8Pmut
	NomOhA9Gp4oIgpppmd3Lkjgt0staCYcq20uDYT1qfmHfaKZSFinmL2ZFyXYoS+eBhO79n+NpGgX
	dn/f10zsgIYFjyM+TdQ9hRRgAC2gzMThWaBfNf9+MonXNPH7NR/Re3grt4msXwlNSHq6j67qRL3
	m+kqIwaJdQBMWWvpErNRUPIIF34sNssBZR49iHWBSpqMjO43AvMw21rxSlO4AwEONwUnPDSeZ04
	OFkIutrJ+K8Tjsw0vuXmD37g==
X-Received: by 2002:a05:620a:260e:b0:92e:bb71:4e8a with SMTP id af79cd13be357-92ee54af9a0mr182240085a.9.1783648265006;
        Thu, 09 Jul 2026 18:51:05 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm81055985a.30.2026.07.09.18.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 18:51:03 -0700 (PDT)
Date: Thu, 9 Jul 2026 21:51:01 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Harry Yoo <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>,
	akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, muchun.song@linux.dev,
	peiyang_he@smail.nju.edu.cn, mhocko@kernel.org,
	roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] mm: mglru: fix stale batch updates after memcg
 reparenting
Message-ID: <alBQBRWDrVoh9P-a@cmpxchg.org>
References: <20260701145736.3785016-1-usama.arif@linux.dev>
 <2fb5ce53-666b-4b0a-a4ad-2b3a28c54768@kernel.org>
 <akU5VdOBkLGInh_t@cmpxchg.org>
 <cbba6349-55a1-416d-a686-d03ff72cc211@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbba6349-55a1-416d-a686-d03ff72cc211@linux.dev>

On Thu, Jul 02, 2026 at 09:38:41AM +0800, Qi Zheng wrote:
> 
> 
> On 7/1/26 11:59 PM, Johannes Weiner wrote:
> > On Thu, Jul 02, 2026 at 12:36:42AM +0900, Harry Yoo wrote:
> >>
> >>
> >> On 7/1/26 11:57 PM, Usama Arif wrote:
> >>> On Wed,  1 Jul 2026 15:52:51 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> >>>
> >>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
> >>>>
> >>>> The mglru page table walker batches per-generation size deltas in
> >>>> walk->nr_pages while walking page tables without holding the lruvec lock.
> >>>> The reset_batch_size() later folds those deltas into walk->lruvec under
> >>>> the lruvec lock.
> >>>>
> >>>> The page table walker can run concurrently with the memcg reparenting path
> >>>> as follows:
> >>>>
> >>>> CPU0                           CPU1
> >>>> ====                           ====
> >>>>
> >>>> walk_mm
> >>>> --> walk_page_range
> >>>>      --> update_batch_size
> >>>>          --> walk->nr_pages += delta
> >>>>
> >>>>                                mem_cgroup_css_offline
> >>>>                                --> memcg_reparent_objcgs
> >>>>                                    --> lock lruvec
> >>>>                                        lru_gen_reparent_memcg
> >>>>                                        --> reparent child folios to parent
> >>>>                                        unlock lruvec
> >>>>
> >>>>      lock lruvec
> >>>>      reset_batch_size
> >>>>      --> child lrugen->nr_pages += delta
> >>>>
> >>>> This will trigger the following warning in lru_gen_exit_memcg():
> >>>>
> >>>> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
> >>>> 				   sizeof(lruvec->lrugen.nr_pages)));
> >>>>
> >>>> And the user-visible impact of underestimated nr_pages in MGLRU was
> >>>> premature OOMs because MGLRU does not try to reclaim memory when nr_pages
> >>>> reaches zero, but there are still more pages.
> >>>>
> >>>> To fix it, make reset_batch_size() check CSS_DYING under RCU before
> >>>> flushing the pending batch. A non-dying memcg keeps the original lruvec
> >>>> stable against RCU-delayed offlining; a dying memcg redirects the deltas
> >>>> to the first non-dying ancestor.
> >>>>
> >>>> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> >>>> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
> >>>> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> >>>> Cc: <stable@vger.kernel.org>
> >>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> >>>> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> >>>> ---
> >>>> Changes in v4:
> >>>>   - re-implement lock_batch_lruvec() in a simpler way
> >>>>     (suggested by Johannes and Harry)
> >>>>   - collect Reviewed-by
> >>>>   - rebase onto the next-20260630
> >>>>
> >>>> Changes in v3:
> >>>>   - re-implement lock_batch_lruvec() by checking CSS_DYING under the RCU lock
> >>>>     (suggested by Harry)
> >>>>   - update the commit message (suggested by Harry)
> >>>>   - temporarily drop the previous Reviewed-by tags
> >>>>     (since the sync method has changed)
> >>>>   - rebase onto the next-20260624
> >>>>
> >>>> Changes in v2:
> >>>>   - update the commit message (pointed by Barry)
> >>>>   - collect Reviewed-by
> >>>>
> >>>>   mm/vmscan.c | 41 ++++++++++++++++++++++++++++++++++-------
> >>>>   1 file changed, 34 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>>> index 35c3bb15ae96..ca1e2a870d51 100644
> >>>> --- a/mm/vmscan.c
> >>>> +++ b/mm/vmscan.c
> >>>> @@ -3262,10 +3262,40 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
> >>>>   	walk->nr_pages[new_gen][type][zone] += delta;
> >>>>   }
> >>>>   
> >>>> +#ifdef CONFIG_MEMCG
> >>>> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
> >>>> +{
> >>>> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> >>>> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> >>>> +
> >>>> +	rcu_read_lock();
> >>>> +
> >>>> +	/*
> >>>> +	 * The memcg can be NULL when the memory controller is disabled.
> >>>> +	 * Otherwise, the caller keeps the memcg owning @lruvec alive.
> >>>> +	 */
> >>>> +	while (unlikely(memcg && css_is_dying(&memcg->css))) {
> >>>> +		memcg = parent_mem_cgroup(memcg);
> >>>> +		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> >>>> +	}
> >>>> +
> >>>> +	spin_lock_irq(&lruvec->lru_lock);
> >>>
> >>> Do we need an rcu_read_unlock() here?
> >>
> >> lruvec_unlock_irq() does that.
> > 
> > Yeah, that tripped me up too. And it makes me think Shakeel was right
> > after all: this should live next to the other lruvec_lock() primitives.
> > 
> > Sure, MGLRU is the only user, but it's still much easier to understand
> > this if the code sits next to the rest of the API (and the unlock!).
> > 
> > lruvec_live_lock_irq()?
> 
> But lruvec_lock_irq() grabs the rcu lock too. :(

Yes, but it's self-explanatory if you put it with those definitions:

static inline void lruvec_lock_irq(struct lruvec *lruvec)
{
        rcu_read_lock();
        spin_lock_irq(&lruvec->lru_lock);
}

static struct lruvec *lruvec_live_lock_irq(struct lruvec *lruvec)
{
	struct mem_cgroup *memcg = lruvec_memcg(lruvec);

	rcu_read_lock();
	while (unlikely(memcg && css_is_dying(&memcg->css))) {
		memcg = parent_mem_cgroup(memcg);
		lruvec = mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
	}
	spin_lock_irq(&lruvec->lru_lock);
}

static inline void lruvec_unlock_irq(struct lruvec *lruvec)
{
        spin_unlock_irq(&lruvec->lru_lock);
        rcu_read_unlock();
}

etc.
