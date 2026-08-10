Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC417352C28
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786392138; cv=none; b=PRBntlYnYn1BfpuY4HWq8mVqnK0AjhHIfmqUn+FR/WFwMK+BLxhtGQwou7NoKWqM8/x1ODRvigsGcD7CXBZQEUVchigyHj1S41o0fl62L6/GPRsBzfbbyuXBv0LaFDCjDphG5Wc0ICqdr8tDkhZgFQFJZ06JO8ydYld/kYm8PJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786392138; c=relaxed/simple;
	bh=I5CVrHKHtn+Ok4r9FI96wZD4tNmwRFrnOH1dgO7/mAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jiye6qr4BjJd9kq0SYqOR34W+MZa6cHRJT7kWZlcSWXtJqYNFNaaH6F7wsXc4CYAlLXi6zIS9J8+uyr/ToEs9B+EUGPx2/g7+x9VZVbZG86S081a/yQgMYdY1ftd/4vQ22XiiDWNi6pEKpYYZF3x7b/Gs057doH6yL95m598jyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=YA68/DA9; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="YA68/DA9"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92f03daaa97so116201785a.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1786392134; x=1786996934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yh4/X5pvcL1g5XfmsNkooR/puMOXNnCQI2y0I6XlIQg=;
        b=YA68/DA9XVFvrlM1CIPl7Q7fqoHRAsUtDqCE/Zc0Dxx3I0hxuEcxeFWvPOLgn3TjZD
         vjncpGnMzZWezVxHG/YDBflgiInp1F7wLt10M4mNs8fQDR7vjDHSGU5Y/nU9YD+LhgF8
         Bzg8FhcDMkebzv/FGof3qZGuuJA1x4Z4kzdaVqwAkJsnz7JwpwBLJ8O1/3JX8l14HEH7
         ypKbXgGTLbP+WryifdrpIH8LSO6PBwYujxKGDabE8g8tReDGuT/2ExZAHUUzOfhkCSLb
         Yx5h+LlcmBatWgoFVbPrecEOdZOCZgpOAt+BdCn8w00qOD4CQjggwXr1U8p9+034BoWq
         Qgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786392134; x=1786996934;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yh4/X5pvcL1g5XfmsNkooR/puMOXNnCQI2y0I6XlIQg=;
        b=SAq7/6TZjBLf7yeJh6p6KvuPN69o8XU1kKFNolrMTi6Mc2VTjEJ+lnttJRGvQtUHJ4
         wT7yI33EnQuGpWgHsZK3k7RiFphrI2f4tnlDKArkXDcfxk+Nmw+boniqe+AtSukR2gJm
         QGO5DmVZJz9sdK5YxewvcDGqcHSBNuFZWYnOc128/+PxSyMMJpH2Hr5p7FORivDB+okd
         l6zKNPYdKXxyC3IPefOUZzLrww87FwRUJ4+cX5Y9lVmhpt9668U4pvx+6qOEQaKD0bw7
         mLjKXVWiZ1f+qZcEqmA4CkMlZcttL42UTKF2zHcKGfQI0PPO5NyTN8Q7zZdKQmsNxwsF
         ZxJA==
X-Forwarded-Encrypted: i=1; AHgh+RoUiInnHAL/FluFCkQ0Hth6hOo4sAv91eqIlHtz4ki0bfGQp6vvE7u1zck+91Nta1sAog1OZw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynTFam3Dox2AAiw2UBnYKReKCyXld0BGQ219eY1GFqQFAjTQw6
	4TgHcO3D1q9zbBEV4RiOTpfHTHi17Q59wKMFnNaMIIVcAlJnMD+gPLdfgfXkxWCBnSA=
X-Gm-Gg: AR+sD10Pz+4u65oxvL2n3CaQ2xryFLCv5uax626Fv7GUfj1ndauZXG95ZC0qLRFeYHG
	maq0WDbW/XUnV9GBeaap51uq9uW0dtGp9gtPbQfExKndk9eI9Z7VaaADkFQsdmx1dJoZgBRloNA
	KDVmKJ6ayC0xOCv9pgZSOtm+TWESF5znrJB3Jtioc2AbDzP11sfhnxeHaSCpXxBcy92bQFvxGfy
	Bl1135a20HKA2WteZdlnMc7TlzxFQIWSb9BQznAYBXCD18n15awWJ4vhdryWaXuhW8MvoFjlgUr
	f9zM136xpFXKADLzOqB81z/A/j7Jj90CZdm+wPSe81jZcyR4D06SExn+KsEe0qHwpC5va8JvBd6
	7W2RILVsc0HtO8F0syoDBnb3b5tOK2hM0FVIiH1OLg/0VQJ686a9gjNHJgY0xQBnoAaizCfyMx0
	d8d3uNHEZIO99C9omGqSIqcBRIeFRiGGHZGanDhkIKXpXFxlvrJFDJTb+ihWo=
X-Received: by 2002:a05:620a:450c:b0:932:fd59:3e57 with SMTP id af79cd13be357-9369d240172mr474598485a.41.1786392134192;
        Mon, 10 Aug 2026 13:02:14 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e229787sm861811585a.22.2026.08.10.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 13:02:13 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:02:09 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	paulmck@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: report RCU-tasks quiescent states in
 shrink_lruvec()
Message-ID: <anouQR89Q-pDAfyt@cmpxchg.org>
References: <20260810-rcu_task_shrink_lruvec-v1-1-4d9f7d5251cb@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-rcu_task_shrink_lruvec-v1-1-4d9f7d5251cb@debian.org>

On Mon, Aug 10, 2026 at 02:57:36AM -0700, Breno Leitao wrote:
> I am seeing some rcu_tasks stalls in the Meta fleet during reclaim.
> 
>   INFO: rcu_tasks detected stalls on tasks:
> 	0000000088620d09: .. nvcsw: 6735/6735 holdout: 1 idle_cpu: -1/8
> 	task:GlobalCPUThread state:R  running task  pid:2552016 tgid:2524552
>   Call Trace:
>    shrink_lruvec
>    mem_cgroup_iter
>    shrink_node
>    do_try_to_free_pages
>    try_to_free_pages
>    __alloc_frozen_pages_noprof
>    alloc_pages_noprof
>    pte_alloc_one
>    __pte_alloc
>    handle_mm_fault
> 
> Nothing promises direct reclaim returns in bounded time, and the scan
> loop in shrink_lruvec() only calls cond_resched(), which is a no-op on
> PREEMPTION kernels.  Involuntary preemption is not a Tasks-RCU
> quiescent state, so the reclaiming task never reports one and becomes a
> holdout.
> 
> Upgrade it to cond_resched_tasks_rcu_qs(), which reports a quiescent
> state even when cond_resched() does nothing.
> 
> PS: This has been discussed in [1]
> 
> Link: https://lore.kernel.org/all/amdWVTs0WKOxguxP@gmail.com/ [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
