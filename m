Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9E429803
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985519; cv=pass; b=DJyq/c43ozTqb60LpLmhaAv85f7zWsm9eS429nZ1VclkWQR0AUQiGc+bmyylvGoJRqE5ZBNxhyzCymezAmT3RLohtITAnVZR5yCL/1mcmOXzews4CXwmtTCX3hOGiBr1spkxj5BB7+AEMrI6drldWj27VN+AnhlDOqnL8256h4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985519; c=relaxed/simple;
	bh=QoW7AnyixuM599yTqpXsOt8aI1xn2JRyg2Xq5kcrCwI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfAm88JTELQGdmaxkLi4Q+8hdWwYm5QBxod6JTBJ5WsU26qInM2KI97qO36QW/LfhLHRW3fr8ftcGWdUddgZqTz0YiIsdhBrNWvwr99KfROrXqpe7tCrtpLMwwWfhARN7bETyReMNL3S0j0mvTq4Ig7wQBNzV3Pr4hQVy9IFx/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qURk5P93; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qURk5P93"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9106ffe17e9so11626786d6.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 13:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788985510; cv=none;
        d=google.com; s=arc-20260327;
        b=VzB7MC6z8sx/m0AP5ZJT7fsCue/TN0JxOGDBTQfLawwoq6l5IA3kqtVcFSIQQCSU4n
         Y7SctpNgssUczFqtjoO+FjYAPESlPxauot3fDnnCuGH4ADHv353+igeABJErARaANDaf
         3/6KYjU7QKF6yvqCDZOJM/a+jNvyyU+/xdkPXf1NnDd+8vh5Y0ziz5jA0lUJyMT+nYur
         Y4YSwLQNorAZd3lLxqPwkRW4WtMzpsBiyzOPZSNr8L/USob0uoSV9oo4OIh5ybBuP8b3
         Z8yg7WneFE46coW0XuqOwcgXVxL1tMa374RGLjwoVZZKYEd1yT9pkyIIkxH5PGpEm5W+
         0sVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=sAJgjokaArCH/jUJWMU61BMeLKssOx+oevwPJuJSlB4=;
        fh=U5IL7J+kkiCbSntHzW669ZdiovePXvEuGPQZ745rDGA=;
        b=F0RYDUexQdRrs37cdfxZGFbjrT23H4Md71aAWQ1aKseWHgeK6JfiDb1SOboFUxxwQp
         ns+KiFWXvd3g8B5ptqBIiRxyCl5sWa8fJIXR9pVkEKawgljfe5WRlkXSZoEQOuPzhc+Z
         x/5V4/cs39EVjq/z1Wce6kRTmhChlY73Lmr0yQRaD5OpShtEUFJWtFVHHa+QxkUvU16l
         WO7cuIlDdURttnrGP0BZ1XXcb3nanrdn0OHxC2KiHtp6xvdOeWhET8WZ202v/TFLEvZI
         IgDcyZwRAZT5iLxEDhn+u5vskaiG+wMJIcqx4gpTOIa7YlZqtLHzzpxpca52IBDOWDaT
         JrbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788985510; x=1789590310; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAJgjokaArCH/jUJWMU61BMeLKssOx+oevwPJuJSlB4=;
        b=qURk5P93NaTtt5trLDbmc1BUPFr6x0gCMMduokoE3cnwaIvRpYlj1jHU2jfkX04ZZV
         IjmUKbODrxIHTMwc2xqWpO+XpkI221Fe/HEVbMyG6yV4a4xCB4ehvS5Ql3vvSOGIcx/i
         WW3MAsBkFyCvPBDTJxnuGl43uWah6KrhZHLD87lv80j5xL/cR46XqWvERDWjyuG9Chf5
         NabDWspzgakCSj8oBmZuuGRXtbRy9z7N/j9vzPhViK6Smilf25fEUMzDGF3vkviviEyT
         oXUKtSNK98SLRWm+OmhfzoszLZrlmo5+rBWLZTkedbvCpZNWpqLgWCjsR0jflmW1JHm/
         ciAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788985510; x=1789590310;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sAJgjokaArCH/jUJWMU61BMeLKssOx+oevwPJuJSlB4=;
        b=VEuu72H/mzN07eupL+PIk9AigqbQ9zreFrlG0xM8Y2nMJvMpxAPQ3FsmidN3cjMOgV
         0Ua3V1w2y+5QJoUnA0WJ1wTM7W7Sspnrk4y93eGT8OkiLPRlooELLBTDDmuzZxoFkuQk
         Hg5e7/mZIrV+k5jGfhmFaZXZrSNnF4s+JeTPAnrde3o9DR1erKJW1WHl0bdVkrWZ/IY0
         iSzXXWqyELHt+3JG0i+tdupaCZ1bISDaw5BsFijYomIcRZwGYk85yDyV+plHxmdpz6Hp
         Hnhqk3N6SYP3z2NHyltaVcVS0RYoHizWm9id89N22quYMRKZ2etlviBfmJ6exW9NqAKc
         jY/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxF5eXqwBHnYlWxPJjPmtJwkVua+eJl8m1UEWGrFah8ANWKeu1cOzIO+HLRIvb3jE0d8Q2Xrg8=@vger.kernel.org
X-Gm-Message-State: AFuF++kVI9mcMa89eoj/hvHcK8HvKyU1YwS/9MnXJdnTkp3Dqy2oapqi
	0iDraPV5B51lLeUxY6d+mzIqS/eJPFfbuzHTGybSNsvcSpf9Sv1pn3i0Zu+pco9wWEMIksYqWmW
	qnslxLqCESNHIgR3nw+VhPCzFQ9u5AZiz/WBvp2rW
X-Gm-Gg: AYBFou1avALe758KOkFz9zYSv1F8PMhL/Zyrv7mydwnbJEikv7WOZfPhvdhs16H61Rl
	Ut6lgSo18I8L3cOWntM4K8tF2//wW2zw2rbFHcUPyYBx7B8IH2KpKFThX0xovs9DV/SAUiG2oUp
	end17/W5ZtDS35IRD5Em+jo8Kji+Cu3IbgeksxwsLNY9nOHWyiaQWrXcQurx3wfzgp0t4swJpZN
	kB8I828bKGSzfkNi3U3Or5xhpq6f83tV8iuFtFrj1Pb/xMISXZi2deokwY4WzkQIofvBhLAJCFl
	9m1pwaYc2RID4sK5d2RLZIsNHWPQWJFgYUnp9RM9cCXxAdmMw0JtFjtOGD9mnt7eUJekJoEpty+
	2ZHDj2yrBlBt+tYQ6tQnba8vzGYDQcKr9T+leSCtc
X-Received: by 2002:a05:6214:2028:b0:910:70e1:e73e with SMTP id
 6a1803df08f44-91070e1e8eemr54547936d6.36.1788985508825; Wed, 09 Sep 2026
 13:25:08 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 13:25:08 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 13:25:07 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260902-hugetlb-subpool-always-track-used-v1-2-de1cd14bd713@google.com>
References: <20260902-hugetlb-subpool-always-track-used-v1-0-de1cd14bd713@google.com>
 <20260902-hugetlb-subpool-always-track-used-v1-2-de1cd14bd713@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Sep 2026 13:25:07 -0700
X-Gm-Features: AcwNN1WKF_ytLnZvmqYqok7fCFO9k5UkC6wmjaHMYmOMsaT-t0wpYlqa0Qxgl0M
Message-ID: <CAEvNRgGGW+D2GWwjUj5A_L69aeUaaWFn4vx6FE7Q5gkd278+nA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: hugetlb: Fix out_put_pages subpool reserve calculation
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Hongxiang Lou <louhongxiang@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
	Yanteng Si <si.yanteng@linux.dev>, fvdl@google.com, jthoughton@google.com, 
	rientjes@google.com, vannapurve@google.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

Copying Sashiko's comments here for discussion :)

> From: Ackerley Tng <ackerleytng@google.com>
>
> When reserving pages for a mapping fails during global accounting, the
> error path rolls back the adjustments made to the subpool.
>
> Currently, this rollback was performed in two separate steps:
>
> 1. Returning only the portion of reservations originally satisfied from the
>    subpool
> 2. Separately adjusting the subpool used pages counter for the portion that
>    was requested from the global pool.
>
> In (1.), because the used pages counter had not yet been decremented for
> the global portion, the subpool observed an inflated used pages count. If
> the mount was configured with both a minimum size and a maximum size, this
> inflated count prevented the subpool from recognizing that usage fell below
> the minimum size guarantee.
>
> As a result, the subpool failed to restore its reserved pages counter and
> instead returned that a global reservation should be dropped. The
> mount-time reservation is permanently destroyed, leaving global reservation
> counts depleted and causing an underflow when the filesystem is eventually
> unmounted.
>
> Additionally, if concurrent threads modified subpool usage during the
> reservation attempt, calculating the rollback amount using stale local
> variables could cause global reservation counts to diverge.
>
> Now that used pages are always tracked within the subpool, return the
> entire requested page count to the subpool in a single call. Global
> reservations are then adjusted using the difference between the
> reservations originally requested and those returned, fixing the issues
> described above.
>
> Fixes: 1d3f9bb4c8af ("mm/hugetlb: restore failed global reservations to subpool")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  mm/hugetlb.c | 49 +++++++++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 26 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 66b6601abb069..d84ef044d1346 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6674,12 +6674,14 @@ long hugetlb_reserve_pages(struct inode *inode,
>  		struct vm_area_struct *vma,
>  		vma_flags_t vma_flags)
>  {
> -	long chg = -1, add = -1, spool_resv, gbl_resv;
> +	long chg = -1, add = -1;
>  	struct hstate *h = hstate_inode(inode);
>  	struct hugepage_subpool *spool = subpool_inode(inode);
>  	struct resv_map *resv_map;
>  	struct hugetlb_cgroup *h_cg = NULL;
> -	long gbl_reserve, regions_needed = 0;
> +	long regions_needed = 0;
> +	long gbl_resv_get;
> +	long gbl_resv_put;
>  	int err;
>
>  	/* This should never happen */
> @@ -6754,9 +6756,9 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	 * the subpool has a minimum size, there may be some global
>  	 * reservations already in place (gbl_reserve).
>  	 */
> -	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
> -	if (gbl_reserve < 0) {
> -		err = gbl_reserve;
> +	gbl_resv_get = hugepage_subpool_get_pages(spool, chg);
> +	if (gbl_resv_get < 0) {
> +		err = gbl_resv_get;
>  		goto out_uncharge_cgroup;
>  	}
>
> @@ -6764,7 +6766,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	 * Check enough hugepages are available for the reservation.
>  	 * Hand the pages back to the subpool if there are not
>  	 */
> -	err = hugetlb_acct_memory(h, gbl_reserve);
> +	err = hugetlb_acct_memory(h, gbl_resv_get);

[GLOBAL ACCOUNTING]

>  	if (err < 0)
>  		goto out_put_pages;
>
> @@ -6783,7 +6785,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
>
>  		if (unlikely(add < 0)) {
> -			hugetlb_acct_memory(h, -gbl_reserve);
> +			hugetlb_acct_memory(h, -gbl_resv_get);

Sashiko:

Does this error path complicate the rollback logic? By explicitly freeing the
previously held global reservations here, it guarantees that out_put_pages
will need to re-allocate them from scratch if the subpool absorbs them. Does
this increase the likelihood of the subsequent hugetlb_acct_memory() allocation
failing?

Ackerley:

Yes, it does. Restoring gbl_resv_get here is the correct thing to do, to
undo the [GLOBAL ACCOUNTING] (see above). It does look weird that
hugetlb_acct_memory() is called twice, but the hugetlb_acct_memory() in
out_put_pages is actually purely meant to follow up after
hugetlb_subpool_put_pages().

Everything is mathematically correct. Sashiko is also right that this
could result in allocation within out_put_pages.

I'll add another patch to clean this up, see next revision!

>  			err = add;
>  			goto out_put_pages;
>  		} else if (unlikely(chg > add)) {
> @@ -6819,26 +6821,21 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	}
>  	return chg;
>
> -out_put_pages:
> -	spool_resv = chg - gbl_reserve;
> -	if (spool_resv) {
> -		/* put sub pool's reservation back, chg - gbl_reserve */
> -		gbl_resv = hugepage_subpool_put_pages(spool, spool_resv);
> -		/*
> -		 * subpool's reserved pages can not be put back due to race,
> -		 * return to hstate.
> -		 */
> -		hugetlb_acct_memory(h, -gbl_resv);
> -	}
> -	/* Restore used_hpages for pages that failed global reservation */
> -	if (gbl_reserve && spool) {
> -		unsigned long flags;
> + out_put_pages:
> +	/*
> +	 * Return all that was requested from the subpool, let subpool
> +	 * tell us the new number of reservations that need to be
> +	 * returned to the global pool.
> +	 */
> +	gbl_resv_put = hugepage_subpool_put_pages(spool, chg);
> +	/*
> +	 * There may be a difference between the number of
> +	 * reservations to consume and the number to restore now if
> +	 * there are multiple threads interacting with the subpool -
> +	 * restore the difference.
> +	 */
> +	hugetlb_acct_memory(h, gbl_resv_get - gbl_resv_put);

Sashiko:

Does ignoring the return value of hugetlb_acct_memory() here lead to accounting
divergence? If gbl_resv_get > gbl_resv_put, this attempts to allocate global
pages. If this allocation fails (e.g. out of memory), the failure is silently
ignored.

Could this lead to the global resv_huge_pages counter diverging from the
subpool's rsv_hpages counter? If a concurrent operation drops the subpool's
used_hpages below min_hpages, hugepage_subpool_put_pages() would absorb the
returned pages into rsv_hpages to satisfy the minimum size constraint. If the
re-allocation then fails and the subpool is later unmounted, could this
divergence cause resv_huge_pages to underflow, inflating available_huge_pages
and potentially enabling a system-wide OOM denial of service?

Ackerley:

Yes I agree that ignoring the return value of hugepage_acct_memory()
could result in issues, but this isn't unique to this code path. The
return value of hugepage_acct_memory() is ignored in similar cleanup
paths.

>
> -		spin_lock_irqsave(&spool->lock, flags);
> -		if (spool->max_hpages != -1)
> -			spool->used_hpages -= gbl_reserve;
> -		unlock_or_release_subpool(spool, flags);
> -	}
>  out_uncharge_cgroup:
>  	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
>  					    chg * pages_per_huge_page(h), h_cg);
>
> --
> 2.55.0.970.g62bdec98f9-goog
