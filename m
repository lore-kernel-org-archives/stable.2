Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F850277C
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739983; cv=none; b=Tll14uxF2kJzXuWJxGGccrKVwk49JJN0SRPbfGVF5nv1SiP1m3QHuoA4jgRIjzetx6NOq/Ngcn1d6CJ3X72WBncUwLj5DU+cg3emVsJJHwRQLkOZwADxlnh+Az8l5nEtXEl3OA7Hi2dOCDRCsGu2QVk24r2GhccQ4KNceeolW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739983; c=relaxed/simple;
	bh=ke3ZCKM47ww6KNrh7xwOWcB9U0ZOh3zBVE7s6lPa5As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INsX2Q6TPNtqWDRui4SGPbLuLgrdDlmseaNbDyT9d1/B/YcLh3Fz5FQhAYUm34gfL68yBNxHwg5px7wFkVbAH2Wo8Kaw+rHgRk3+5kYxPj8/EuM8cri8XX5qbzS9I535Liw+I2uCJTK5uLGOSNaiSUD7283+UnAXlgb7SnifKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Rg5dgeqC; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Rg5dgeqC"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910ca5aa8so73913585a.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789739980; x=1790344780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FSS2u3Aow+SobxUjbVcIwPVLjVRkiJichXhPV/h32Jg=;
        b=Rg5dgeqCBo6iYNpnBxzFVvDaWnDuLnkdFY6tmwnghwRHCpnFgBwgWYkDoJkW45pi+d
         4v+tCJnd0//avbeU9TJxKmJztEtz7Xz0woyUEsJ1AJMKrxVm4nSoDGhVZQ6zL+5Sgyzx
         jchJpxGiAcgmBjlSeGVbJXMJbFqmkMGFd3vnS5BxMFw83luqYtjZBAkJQzWGmZnCMl7J
         g4tuOOPRexHW1N/+QPP+XjrmZlpSgGfL2WBey5N17r19qHzlpDyPtE+Qq8rRI1srpuH6
         rqUpEoGsi+uGinAw3pTU0/mKddzOySUYjXJc7e1b/QX1DlR7geJTZSHygfKmvUJkhDRk
         WsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789739980; x=1790344780;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FSS2u3Aow+SobxUjbVcIwPVLjVRkiJichXhPV/h32Jg=;
        b=nVtHPDHgXRtchnmw0b6W+HmBX5G/IiClH+qwrfOEAmL9G9kv/+c64/T8yu5Z62AcmA
         neF57YLiqvrmek7HAjUNgBPB9dcbGAlj0v2r/gFOkgDsYlTAJ8q7y+86mqN86tJ7Z7Do
         LpIK8FO+krP7n2UJ5dokHOWjOs7ckEcX8mu+IwqvJdR7OXbKpKZz+JDrAXqpds9UGhP6
         K8khNv/EQLKiMlYGHuByf9JGZXBVNmApVOu0r6mTJExRjd4uWAoW140h7sIAtpb+EetP
         qinU1wSat8O5BIudFioK1hcdoUEuR9yQhYHwYxgOKXnLQLLT6/1+ybNsMylvIJeeLqvh
         X96Q==
X-Forwarded-Encrypted: i=1; AKwUvBw6zQ0YRf8QgEJFzQHt+6d44glxgEbSErOa9h7HWZhE5gTXcH9wXdi22En4Nh5qToH13X0+iWo=@vger.kernel.org
X-Gm-Message-State: AFuF++kamAKZVTsHMnqt7/F2H3qytrcEi8zKKg7JvgcK3FFA32JXxN8p
	+rRBPNONv6p4qvUEOlffRVUifCYAto/PXQKZLb7BvrnD95kOEdO9W2DHcmGyqJcVs0M=
X-Gm-Gg: AYBFou2bnuJpmP9fjBmfA38NjxRb0amJ6B8xe+qsQSiXG8haMrqJsQ25xTuXKSyj/n6
	GrIT68JJkYooyvLyTo5CX4nQs2OB3cDnRhhBe2a023jXH2DC3cdHNxzc6tt/j5ROBF2bxRNBeUP
	SkGJb2vAK3ORAIFqVBqhSozCWRO2LyBvH4sA0tuua7/aOIdvHJP9xVPx3jo8mRd+zMjNc+jcnEH
	JPdNDrSMQ5xowUjGuC3ycYBWS4uJa2hkEhYvMIWtadtug2+Z5e7sfUaKu9LR5zXUEyHeeZtVRa9
	BPp7b/49P+deXLBAzcRLyIISmDxIgIkE2rU3t6XpW2/41RZJFZwjVEe1+zKu3OYznindGCPJnvk
	gxbR4ZltbN0AonJZHL3wzTIz8DgQ1fcJpfcNy+QW7Dyg/vCouNy5eAvRGUcCSWVdUiax2Dm5yHz
	G1QfuuDMp/M61hxekXiYWLK2m4JZN12tWlJpKjTLXtNJAUD1kXPYbVEOg65k+12cFeWDyu6cCOn
	na/hlMvFSa5kpbDmPShpRWscjEf3la4BWIXUCD+2WFr1lv7npswySg=
X-Received: by 2002:a05:620a:8909:b0:933:aa0:bb83 with SMTP id af79cd13be357-93bdc747954mr358888885a.34.1789739980266;
        Fri, 18 Sep 2026 06:59:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0e508a2sm143621485a.11.2026.09.18.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:59:39 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:59:37 -0400
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
	osalvador@suse.de, hannes@cmpxchg.org, raghavendra.kt@amd.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] sched/numa: do not let VMA PID activity gate
 promotion
Message-ID: <aq1DQfuI2XPJQ54f@gourry-fedora-PF4VCD3F>
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-5-gourry@gourry.net>
 <e2695249-ea36-4a4e-a5ba-22bb5f7299d6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2695249-ea36-4a4e-a5ba-22bb5f7299d6@kernel.org>

On Fri, Sep 18, 2026 at 03:01:34PM +0200, David Hildenbrand (Arm) wrote:
> > -		/* VMA scan is complete, do not scan until next sequence. */
> > +		/*
> > +		 * VMA scan is complete, do not scan until next sequence.  A
> > +		 * promotion-only scan reached the end of the VMA but did not
> > +		 * sample placement, so it does not count towards the starvation
> > +		 * horizon in vma_is_accessed().
> > +		 */
> >  		vma->numab_state->prev_scan_seq = mm->numa_scan_seq;
> > +		if (!promo_only)
> > +			vma->numab_state->prev_placement_scan_seq = mm->numa_scan_seq;
> 
> 
> This is all rather ... messy. I mean, just look at that promo_only() computation ...
> 
> There must be a cleaner way ;)

I tried 3 or 4 different ways, this is the least ugly thing I could come
up with :\

The scan sequence thing is particularly confusing, and numab=3 mode
(NORMAL|TIERING) makes trying to reason about this whole thing really
painful.

I can see about making it at least a bit easier on the eyes.

~Gregory
