Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B777477280
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840174; cv=none; b=XP8yPqqb5/7058an+UnMPSUh7suPJQjr28AggruJhvUBeCz3y4ZscNn30mo8wMygQ7I3lXbDv/0geSXW8zMgKnW37KN3VsYcY4SELugJc2HRI+Z+mYTj7DuYltGoX7i8E5qaIdn+LzaIypfddtiIyO3PfeCm70rzTooOKFAhC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840174; c=relaxed/simple;
	bh=AdoxcsSG8MqZdrkqtRD5a/Lc5TO2Q0+hl0JpN6zOIO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYXxpOfnwtEGSu/CA8W9Lhb2LXvBf6MPjo/zxSXNKe4HjRSyRCEO6KK4NgWd85ZKam3mnReTPUfHloFZFRadMC3t9Fxfxg7g0w77jjvMyKdnKd6l7vmdrmhACOp6ZXp+V88n/bDTURcL0b4g/W8J5m7jQyw9y1wpz5hFzz3nalI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ECrHisqp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ECrHisqp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso10887445e9.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 07:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787840169; x=1788444969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CVoIwDlF3yETw9iWFWyYa/WcXPQgoIbsjIMm89Vx28E=;
        b=ECrHisqpiMyd8VTdx6Y93vwc1JGlIwBTzO6nZDxmrU6cCWgABxzXU/GfeCRc3PLWQu
         RQ7mK3HHLr+8ZOdlUrZ4dQehbV+Rc4z12POYmkErQZBIMsJ2sPUBUmshJu19FCHErd4i
         jejWWGRPpd2ltgcXDfoieXb8ys/ZpjAL1W+PKvcRJV9yG/ZnTt9b8NSD9RO1DU67Bfpg
         9Bx38/drzBKTob80+W6klawHHUHQcy3BeXBl4n8cxLp7Z2tVDrWFMhfkwHMCvtxhdubB
         lir4M6WJyWh3VjUKFncnRuojyK5YTuMW4YN9EutnG0Nm1DComk5N2lP0PfwcvHAtLrst
         appw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787840169; x=1788444969;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CVoIwDlF3yETw9iWFWyYa/WcXPQgoIbsjIMm89Vx28E=;
        b=hyF/+KVZpHidVa4aou5ZPWsEvzdOhqASqmel0TsgJcx2xFz5EV6Re366yH9rSyXO7J
         mos4fsRCcWYFlpEoSBLZaTb/mKFuhpV8YK6n3jGuvbhleST25edMDteRI2ZmLS+G2vPD
         twaXTlPL9YXWxqbIJs1JA/lzt5W3vcikGhQEPCHotn+9wc/NjkjaNhGpSMILgxXUczWS
         ijSR8w9LumhhXgDWqLVAL4SKoD1sLmIN5Qct1DV3GJ2gPQgnG6WVHR+Pt85dcx/cnHZK
         +b3/oK9EZShOis26WDDUDdHPuTOA+MI/QP4ZwmpnBZ0U/J653NsMbRH0FXPeJJu8KtSV
         QpUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqynReGBKg5kYmTPH7qmwspe6/Yx678lZKFFtEDzhICXTa9ro9A7t+9NFf/dlox3f8mmn4yFKc=@vger.kernel.org
X-Gm-Message-State: AFuF++klZJxtNX2DMtN9IQEHdQjyYRdLk6CJdnvZNgK1e6bhVbjE85Mz
	G8PjLi9jI927JD7ZkawvJRbcvVGhFILUmjXj1f97t3JXwe3umkCM2DNm4nJXS5CmR3Y=
X-Gm-Gg: AR+sD10tLT7sWYndOfWl0/XJGOiMbEGgU3pZlLEruGuyFnGtuVY9gnZnUcf9lOB6Mu3
	Pa+VQNVfq8orRWDsQDHOApBEtgOZL+k8y5jkLVw9fpRJGA/KB6t3vg2xma37EXfJdodPPuBdSwL
	+jK+hPJNiAt83+ly743lmy7xzfDLXLi/DTUZrPzVEg1gySCXZ8CLtfegWYlSzvrC7sonnV5rSCU
	UiL2NY2fdBH7BMMEqdx+tR1Wd1Y75bfpCySzyWQHad7iPmSp5232AuATcx1dasP/q4hafX1W+xr
	qHvIW79ulFogL0o7K1k0A7nzte9d/A1QfDWvL3eWUTgQuTQYEtvuNy34RDue/pIvakF936qK2Qm
	alm6rhlBmjOOwVcir3gs9n3dcIm0g7iHOWc/r5mXmiJYGBap8GVquaQzJfhy0CTfn6QkAfTkwcr
	RGbieLoSHVjw2s0KhD5D9WecP0kGc0ImM/l2X2SVOo4BoWGENnh9x3OeeRrDF40RxPa8kftTzJv
	24=
X-Received: by 2002:a05:600c:3f08:b0:499:d513:e507 with SMTP id 5b1f17b1804b1-499dc6efdf9mr208752205e9.2.1787840169409;
        Thu, 27 Aug 2026 07:16:09 -0700 (PDT)
Received: from localhost (109-81-32-216.rct.o2.cz. [109.81.32.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b0dd3e148sm44345705e9.1.2026.08.27.07.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 07:16:08 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:16:07 +0200
From: Michal Hocko <mhocko@suse.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, stable@vger.kernel.org,
	syzbot+ced4d9a8cadb5ef3adae@syzkaller.appspotmail.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry@kernel.org>, Chris Li <chrisl@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: fix data-race on reading jiffies_64
Message-ID: <apBGp2BF1RJVYiXP@tiehlicka>
References: <20260827025457.116191-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827025457.116191-1-jiayuan.chen@linux.dev>

On Thu 27-08-26 10:54:56, Jiayuan Chen wrote:
> KCSAN reported a data-race between tick_do_update_jiffies64() updating
> jiffies_64 and mem_cgroup_flush_stats_ratelimited() reading it directly.
> 
> Unlike jiffies, jiffies_64 is not volatile, so raw reads are plain
> accesses and can even be torn on 32-bit. Use get_jiffies_64() instead,
> and fix the same pattern in mem_cgroup_flush_foreign().

Yes, this looks more correct. I do not expect this to have any
practically visible effects, right?

> Cc: <stable@vger.kernel.org>
> Fixes: 508bed884767 ("mm: memcg: change flush_next_time to flush_last_time")
> Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
> Reported-by: syzbot+ced4d9a8cadb5ef3adae@syzkaller.appspotmail.com
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> feel free to drop Fixes tag.
> ---
>  mm/memcontrol.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 11b85f4b6828..5a3fe057debc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -757,7 +757,7 @@ static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
>  		return;
>  
>  	if (mem_cgroup_is_root(memcg))
> -		WRITE_ONCE(flush_last_time, jiffies_64);
> +		WRITE_ONCE(flush_last_time, get_jiffies_64());
>  
>  	css_rstat_flush(&memcg->css);
>  }
> @@ -785,7 +785,7 @@ void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
>  {
>  	/* Only flush if the periodic flusher is one full cycle late */
> -	if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
> +	if (time_after64(get_jiffies_64(), READ_ONCE(flush_last_time) + 2 * FLUSH_TIME))
>  		mem_cgroup_flush_stats(memcg);
>  }
>  
> @@ -3945,7 +3945,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
>  	unsigned long intv = msecs_to_jiffies(dirty_expire_interval * 10);
> -	u64 now = jiffies_64;
> +	u64 now = get_jiffies_64();
>  	int i;
>  
>  	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> -- 
> 2.43.0
> 

-- 
Michal Hocko
SUSE Labs
