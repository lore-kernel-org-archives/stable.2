Received: from mail-qv2-f34.google.com (mail-qv2-f34.google.com [74.125.230.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A027FD43
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296507; cv=none; b=t8BMvKZl2zR1igWHbbB0CY0H0zal23neZeRlBo+NwO3Wre33DXKuOTQ2v43slHfKNgPHk9PV/SmkMxCQmytYxsgcE6Og2tASSkgkYFEnuDIfTJeCHy5DGTSoeNnhLswMt+tj+L+dzFyez4swuFBWZ28qKLyZGDdT460CytkeSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296507; c=relaxed/simple;
	bh=5Yn/V49OL4qwBUPSEZYOuA2XjrtAYM/2F6LNKtkgSDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaaBvzNg9vPWpEOw6oZiL152YNecAqsqIUh1XwfbugFyr76kyWLfw9vSYG821lUZA+oAdIM96bVxAr4CRA5jrprFrDYfVkjm5Sfe833a7zWHv93WDh60c9RCC9f207T0+AiQlCvJF4D8dOijD4Y2sJeBQ704wjNIenxieVS8rbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WLD7tQHO; arc=none smtp.client-ip=74.125.230.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WLD7tQHO"
Received: by mail-qv2-f34.google.com with SMTP id 6a1803df08f44-9142d333875so1585176d6.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790296505; x=1790901305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hT0C0mvf6r5FuTfZclgfx4VcRqH28SXA1w/+lQNjyOc=;
        b=WLD7tQHOyBfqxqtDoY3qRt1kj7PPbcQjEO4xUXy/bAKwNG8fFRq7CW3rIzwdv2l55h
         K+I9GnM/kC738ny7I3M+oyw84ofe/t45Taj2BASl3+TMOlRkEXZ8oFb75YRwPqeyozMM
         0VcGxz2f09l2Vi+BtfkHFmddylYue2zfedGPQmVULqKfBKkpDhF26YELoKspi0lW0UNi
         m679EVCoTx2xixvKNYxHZQWy1vyO/A8K3DfL/GwuZkvnDsK+M4T7sDetZiyjxFdWVz8+
         YxAwF+BgM0mXXpqI19dI7oRGWMPD1wDfATG2pC6fJnEZnHYi8ybaacO5ZOPzfSEV7el6
         7TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790296505; x=1790901305;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hT0C0mvf6r5FuTfZclgfx4VcRqH28SXA1w/+lQNjyOc=;
        b=TGxEQCrU2cnMCu9jKoQK7bVml1sM14xk2fW0Jd/x/GEgnRR+hspzef0AQ7nNHAFC9Y
         qkHgT/ObOptpbGrKYUn9Da60I6521lAWAu8uPvXdB0eAkM1O1xiAxl77khW1d4CLBI/w
         PhHTinYHhECNaF/wApzS15H4L3SomjlEGqwL0X1rOSVvX+tZYs7Pee4K2x4MEbeUyzYD
         MopXNamCF28MlKjQOdyCgcuRa5gHaFLPjPJNHRMivPXP+t9RLRvZytkDzeHP+PJlElR/
         aJp0rV4KCK/f50udIWlr4umxawXjf/dvLVwV8yjtpYWskUmFOZHCAnwOgYv0XVZvCsDc
         yxSw==
X-Forwarded-Encrypted: i=1; AKwUvBxSjND3HgVxZnHfRF+3aQfhSfYGHfBIZD9IUZkZXk45BP0LdEfJ46X9wER4m6mb1baqxfZstOk=@vger.kernel.org
X-Gm-Message-State: AFuF++nuEPuc/YMFjlfD9rnTkiTfrJP+ZBUY0ivEvrCj4KvSWn26H3uu
	rmrMWpSkuxi9reHL93fspuVu5zgy9h6JStkAmqH9FRAJCJgCUEDhuBu94DXDdkqkpMA=
X-Gm-Gg: AYBFou2tRMozsAmhZyLcpQ6QY3faw42nlS1Vufg/KY7IPaoOTLG6Dfb4Ka9hf48hIgb
	8ZiVPriG+x8CQQ2xaWQjE4/ZM0pOpK4TrV231r5YpIlkucKOHDqJfTp33p8hsmdFkHxXgYQqL6h
	UZoTjKhy0CrYY0qyFLEOFyuq3x4m79obazpdFESMBs1CtOBZpAxBJhoQPgdVGAYVwcbtXzSGLay
	6JIB+K/eqp9WJRjBzwysI3WgdVVZU+tK29gBvHAoeQKuG9289qyXefoeS/dcHTckHy60XeE9lMk
	8/AZbo0JlfVeDcmzy96fG+/Bkbz3TDEtp98/Wz0MOGqd5DpISrWlE9v5xHzHBAn8GTefSX72ziK
	2HZuT9J04RxlZyqg4Gabjf+0tQu2/EbaokD4iGAo0f7woQTKBG9dMdk2cvM87GR0mDMaXGFGxvo
	KASGWroMh9f2jSuYu62J3YKV0mVMta0iOq8FTc4+Y8x3W1kycTdM7amnRvyCvkv/BDacf497Ulx
	yOqPOaw5rNdFQGpr8TTjmn5qFrXk4NxSB2gvDJROblbied+S+3hys4=
X-Received: by 2002:a05:6214:5910:b0:912:bd1:49f5 with SMTP id 6a1803df08f44-9142f681cf9mr18652786d6.10.1790296504108;
        Thu, 24 Sep 2026 17:35:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430e87fa4sm5357886d6.41.2026.09.24.17.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:35:03 -0700 (PDT)
Date: Thu, 24 Sep 2026 20:35:01 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, 
	hannes@cmpxchg.org, shy828301@gmail.com, raghavendra.kt@amd.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/7] sched/numa: scan read-only file mappings in
 tiering mode
Message-ID: <arXBari1QNJ-aIW8@gourry-fedora-PF4VCD3F>
References: <20260922182928.2199090-1-gourry@gourry.net>
 <20260922182928.2199090-4-gourry@gourry.net>
 <c73021d4-60c8-4446-9c08-f9d7807a3a0f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c73021d4-60c8-4446-9c08-f9d7807a3a0f@kernel.org>

On Thu, Sep 24, 2026 at 10:53:56PM +0200, David Hildenbrand (Arm) wrote:
> > +		placement_scan &= numab_mode & NUMA_BALANCING_NORMAL;
> 
> Do we have to update placement_scan at all?

in the following commits this composes:

	placement_scan &= numab_mode & NUMA_BALANCING_NORMAL;
	if (scan_started)
		placement_scan &= vma->numab_state->placement_scan;
	else if (tiering)
		placement_scan &= placement_due;

But i'll think about this when I update the function name.

> 
> Can't we do:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a4687f67d82f..fc8862ee31442 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4121,6 +4121,7 @@ static void task_numa_work(struct callback_head *work)
>  {
>         const unsigned int numab_mode = READ_ONCE(sysctl_numa_balancing_mode);
>         const bool tiering = numab_mode & NUMA_BALANCING_MEMORY_TIERING;
> +       const bool balancing = numab_mode & NUMA_BALANCING_NORMAL;
>         unsigned long migrate, next_scan, now = jiffies;
>         struct task_struct *p = current;
>         struct mm_struct *mm = p->mm;
> @@ -4313,9 +4314,8 @@ static void task_numa_work(struct callback_head *work)
>                         continue;
>                 }
> 
> -               placement_scan &= numab_mode & NUMA_BALANCING_NORMAL;
>                 cp_flags = MM_CP_PROT_NUMA;
> -               if (!placement_scan)
> +               if (!placement_scan || !balancing)
>                         cp_flags |= MM_CP_PROT_NUMA_PROMO_ONLY;
> 
>                 do {
> 
> (maybe I messed up my boolean algreba, it's late)
> 
> -- 
> Cheers,
> 
> David
> 
