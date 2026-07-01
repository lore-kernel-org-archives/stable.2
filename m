Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B5B492525
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921564; cv=none; b=S5Fi6kkLbivjWRp4iD/j2gypZsG1KBQyXZ+8TGAKhHKcbxFR5Oc4IIymAKBsjd+IkhR0nyucgKQRBT59jrsC0ynh+m80/rme9RI9r+i3wSukxKRehG+Ajq/IJKLm/y4IaMehFPx3dLjeKGMkA6dpD8ZcIVDAZF3fBb7nEYTfUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921564; c=relaxed/simple;
	bh=5T4/pKY0LtS/6S8SyWxnzU3YlBIM3TDxZgiVRrQ4OUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d251g+zk1RMRiUFTHuHBaw/vgR4Wnrh0hLnCGIhfD+Z8//DRHhM1+tf3kiV7h3BMZKYioHgxt2xWm/9NPUQH3YO/VGOQXeTzUptVLxSEWazkgTJsGueKEdbKeFWOgSKsNBSIuUkkKNWYzhJM83rtxuifVkRFOO7CUgycI6eT6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=chCZt+ry; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="chCZt+ry"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2a76536bso3481151cf.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1782921560; x=1783526360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vW5yMQMtKuZNWOL3QxEXaq9d8mHdlESmK4dMn+saK1g=;
        b=chCZt+ryIq+cSxRLWU7NCKDYWdueyreLVfatEdImJdAT6omN3uB5LDp+g2EerWVyYt
         3vVAH7DqbWnGAyRbFhXlWPv+UWg68hvudUJ5OM6e1u1ykjAIDlmjEQGBVKHWcz6R/C0c
         HwHon7NQ7F40Ja0b/HNHK9iuOFBkc5l3u14WjPtVLcrR39ytBIEHsT2x/3DsremNnIQK
         H8/tSdw3j8Yjek4WfENop+Qmd6XHUywcJgze5QnB7Kgv4x2b1mHkHu5PVzuzc9KwwNw3
         wgnP8gIU/JROKW9q9vDHeJMs1bn5nrx6Rj/wAPAzk0d1FZbyd+/otWWRZ4FkMh2WEMgd
         Fz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921560; x=1783526360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW5yMQMtKuZNWOL3QxEXaq9d8mHdlESmK4dMn+saK1g=;
        b=K7+LmKIwOSiX5IieGjUwyqBqDcSf8xyzybeYnDgakGEE5MgJWUjy1d++y4xSn06oYl
         w80/Fjw4TKJFfqUqqtMacR36Oxu+iEOeKdj4eKrjDEG4o0niUt/NxO1OoZkAlsM6MP8k
         w0X4BvJXT6ZEagk3X3XQ1AvXAge492Gp2yMgNFk/TaheElqo1Htx8kd8xd/EBTREFZDR
         eLkJHeFnPwdRfq9shsolxVJgnN4H3xg1ODFKsiRBrq6X5201CxFecEmX7ZSUlfCAH3a1
         o3CarXWD6hpo23ip0aTSHrmpbckA/xdn5fSNCPpAQwtGz/FYmc8NlZhsAjKq2cRvVJ7b
         FhTg==
X-Forwarded-Encrypted: i=1; AFNElJ+0GschKmKQTESUS6eH8xEi2nJi8Ne/i7Onsl8dHzSOSuT5P1exSBqZoMQ3ksNNel4EDpEvI+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlftEf/JZLVjA5S4gVVadBCOen3HhHVVP3Vk3+tbI9zzyyjAEj
	89hz7XP7XrBtQcQi/bSQDKlUcxoJes82KLPaJVN5NxFUnmJOthcUepslxpTbtI7rfcM=
X-Gm-Gg: AfdE7cl6ZXYwccvt1rtLlPCdajNVSMgOPgIbJirD+a3iSgWhZ7QGS58KQA/bpJ++B+Q
	sJfZnk0iIOb3AnCCooYy3RiY/2U31+JQ32PssOlrvAfHgx6zqJzaolpQsvuoBYWIsFbX1EIhxJC
	so6JjocqeK8i+V8CxdgIrL269YZt+N39sqw9yfDZDpvtKUmCy9tB+ulzTtVQN0DAEpmBFwqX7Kv
	dDfd/6HLSpfjwMf/rK8/b0mDABOd4Mo8DU21UthDBjg1LMkLl+utj9YzxsX6lfaLgyOwkRs6pu3
	7SP9C+emFE0Gve1Ftv2USncHnvfvJhXeFSYhFeLGzJOMXRvG7q0WeNmwPeVSk9GxKqpLT1b2k0K
	yl7PNOwa1kcDrbpklTVs0roPVJ0Qu7EAjkDt2iUwHv43HCBioab4tR44ChvIcViYHYsdqBJQ3FO
	l80QvtopVVKa8=
X-Received: by 2002:a05:622a:4088:b0:517:6804:3732 with SMTP id d75a77b69052e-51c26b0fceemr29104571cf.55.1782921559721;
        Wed, 01 Jul 2026 08:59:19 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10a37dc5sm49375091cf.31.2026.07.01.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 08:59:18 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:59:17 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Harry Yoo <harry@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, muchun.song@linux.dev,
	peiyang_he@smail.nju.edu.cn, mhocko@kernel.org,
	roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] mm: mglru: fix stale batch updates after memcg
 reparenting
Message-ID: <akU5VdOBkLGInh_t@cmpxchg.org>
References: <20260701145736.3785016-1-usama.arif@linux.dev>
 <2fb5ce53-666b-4b0a-a4ad-2b3a28c54768@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb5ce53-666b-4b0a-a4ad-2b3a28c54768@kernel.org>

On Thu, Jul 02, 2026 at 12:36:42AM +0900, Harry Yoo wrote:
> 
> 
> On 7/1/26 11:57 PM, Usama Arif wrote:
> > On Wed,  1 Jul 2026 15:52:51 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> > 
> >> From: Qi Zheng <zhengqi.arch@bytedance.com>
> >>
> >> The mglru page table walker batches per-generation size deltas in
> >> walk->nr_pages while walking page tables without holding the lruvec lock.
> >> The reset_batch_size() later folds those deltas into walk->lruvec under
> >> the lruvec lock.
> >>
> >> The page table walker can run concurrently with the memcg reparenting path
> >> as follows:
> >>
> >> CPU0                           CPU1
> >> ====                           ====
> >>
> >> walk_mm
> >> --> walk_page_range
> >>     --> update_batch_size
> >>         --> walk->nr_pages += delta
> >>
> >>                               mem_cgroup_css_offline
> >>                               --> memcg_reparent_objcgs
> >>                                   --> lock lruvec
> >>                                       lru_gen_reparent_memcg
> >>                                       --> reparent child folios to parent
> >>                                       unlock lruvec
> >>
> >>     lock lruvec
> >>     reset_batch_size
> >>     --> child lrugen->nr_pages += delta
> >>
> >> This will trigger the following warning in lru_gen_exit_memcg():
> >>
> >> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
> >> 				   sizeof(lruvec->lrugen.nr_pages)));
> >>
> >> And the user-visible impact of underestimated nr_pages in MGLRU was
> >> premature OOMs because MGLRU does not try to reclaim memory when nr_pages
> >> reaches zero, but there are still more pages.
> >>
> >> To fix it, make reset_batch_size() check CSS_DYING under RCU before
> >> flushing the pending batch. A non-dying memcg keeps the original lruvec
> >> stable against RCU-delayed offlining; a dying memcg redirects the deltas
> >> to the first non-dying ancestor.
> >>
> >> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> >> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
> >> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> >> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> >> ---
> >> Changes in v4:
> >>  - re-implement lock_batch_lruvec() in a simpler way
> >>    (suggested by Johannes and Harry)
> >>  - collect Reviewed-by
> >>  - rebase onto the next-20260630
> >>
> >> Changes in v3:
> >>  - re-implement lock_batch_lruvec() by checking CSS_DYING under the RCU lock
> >>    (suggested by Harry)
> >>  - update the commit message (suggested by Harry)
> >>  - temporarily drop the previous Reviewed-by tags
> >>    (since the sync method has changed)
> >>  - rebase onto the next-20260624
> >>
> >> Changes in v2:
> >>  - update the commit message (pointed by Barry)
> >>  - collect Reviewed-by
> >>
> >>  mm/vmscan.c | 41 ++++++++++++++++++++++++++++++++++-------
> >>  1 file changed, 34 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 35c3bb15ae96..ca1e2a870d51 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -3262,10 +3262,40 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
> >>  	walk->nr_pages[new_gen][type][zone] += delta;
> >>  }
> >>  
> >> +#ifdef CONFIG_MEMCG
> >> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
> >> +{
> >> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> >> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> >> +
> >> +	rcu_read_lock();
> >> +
> >> +	/*
> >> +	 * The memcg can be NULL when the memory controller is disabled.
> >> +	 * Otherwise, the caller keeps the memcg owning @lruvec alive.
> >> +	 */
> >> +	while (unlikely(memcg && css_is_dying(&memcg->css))) {
> >> +		memcg = parent_mem_cgroup(memcg);
> >> +		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> >> +	}
> >> +
> >> +	spin_lock_irq(&lruvec->lru_lock);
> > 
> > Do we need an rcu_read_unlock() here?
> 
> lruvec_unlock_irq() does that.

Yeah, that tripped me up too. And it makes me think Shakeel was right
after all: this should live next to the other lruvec_lock() primitives.

Sure, MGLRU is the only user, but it's still much easier to understand
this if the code sits next to the rest of the API (and the unlock!).

lruvec_live_lock_irq()?
