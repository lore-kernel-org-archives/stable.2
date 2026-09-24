Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466133F599
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258900; cv=none; b=MqAJIJ6F+uhFf4J0WUJW1DfO9lOyJdooMovBH9HImP5XHz3SvdS1MeH6tTeZeGWgJBb2OXbF7XWtydKlFmlVHqLmO7HNoqmMzEqKvCZH+HtlYBu78ma/u4DTijU6tIZUOnLEngGOhMuk1NcJdRCWQoPHIE0QQySbojNGeJHckUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258900; c=relaxed/simple;
	bh=Zosx0/qtM2U93wY2yvl2h75cV7USyTkdpcN6VQSTV+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBwPfDAC/xwMf0DjBGJQ30FCaSw/5hRp14Op4rdY0NXcufoF9msCkxf3dGQf3a9f3Mli6qb/keWqFKF2osK6Jn9kC4HGnfYEroSquN9iwYvZ1t6VjjErU9LTvpBHNftI9t2qrpShSGd8X0Ql4UNBGl4mKLWWOjTOobLNFWL252s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OwmX0wpK; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OwmX0wpK"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso1984939d50.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790258897; x=1790863697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vfI1NR8Tep8AKRWcGdJ4Ave6RFunEN3KZDqYuNUnkYI=;
        b=OwmX0wpKIMrGOhySBo1IqYmpPYxZNf0k2COzcFGMy3G9pTBwcspZTzGNiI8D3WhQSb
         WnAgFCSqLFRPQwxhosIhcPCxFYmTGLaIWEl4CyLWRRPbN1uQuJuruNoY4P1//QJkrqwa
         48xn0hRL164exARZesHNyZYp1TbhvIHUJC3npErpx2O5LQ0dOCAlcHi2vyP2LEe/nXkn
         tvHPz/jYULdTCB2Vf+Z1Zrdzp3gB5LojnnDZTJDxllnUKXpFHu81F/ECOCu6KlhDjsvI
         wIjy+1HHV4nK8+bx2FDU8qt8TpPm84X6/QmVdhomL0GaHhTTZ4Zs0Kve8T437rdGGWeu
         zpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258897; x=1790863697;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vfI1NR8Tep8AKRWcGdJ4Ave6RFunEN3KZDqYuNUnkYI=;
        b=Oww/wnxDG0fwwtoig7VqjIfurD6+ofCxIv4C2axdFsIwGdN9QWbboQumzrocuyl4/p
         s1fpNLNmhpBO02eGGIc83k4AzSXg4eLFFQJl1KSjLVffRMrNqunNU59O+mpPBm8SlF7E
         a9eTmoHyjrLstHfYoABREUzR5GJRZVU9EfxAdE/ocxfe3Rl9XY0O8O28wE23LwhKeaNE
         KuebkMJcxIrQXHEGHiwV+QJbtYUkgfCxJqJOxHvE5eDbBBIwfg2E3DaDf5QHs9cfxV4T
         DMOocE231IKMXeOYsV8hunq4rZHLpAcnoJgBgu9K+CJgoz6Aac1EgGNDSap3T6Fx8mzt
         jsHw==
X-Forwarded-Encrypted: i=1; AKwUvBwcBlk1Us5WH5TbL9azfXYc7w4Jh8V/hxY8LnFDMzo0ONrwSA/rWvVeShXcs3tw/UedpU2dXBQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nKtS857+lnK2PApGe4Ah8TYwd4/X71rlfsHV48GDIyc4IbLQdI
	WllxVaTnCDa0725Wy+0hOIj2v/cJOXgNG8KN6o0zyC1PIkXGTqVCVU7VGzZ0YVXUDR8=
X-Gm-Gg: AYBFou0JKFBa5NLUD53bLlX6cGveQLA7id+mKbOMsmWpwZ9L5SLWsTyGOKdX3MOJLmG
	f3xz1AgJDff0IxjgQ6jjSLB2gXAkxPT2M29In2WkILho+X2yDStpRXkMJrF8FNt1gEYJSmcf7jm
	i135Gkcatkn7H/LIMIxcGD1p7Pom9penxi32h7lzvCYrgsN3ibA6rePAvb5B8JY3Cb2hvfEngZp
	O3+Bl/jdQJz+e6GSv/9ICZv8x07vvtEW2LQpIFrmoOtp2Cod51IN2kQ89UzxA0IA3DOnFISa7m9
	+7NiEXid9amBnXG0dsl/CkSVnCyx8jD28ubzrVHgMsvASUUxCtMy7wPfW0QxATU839om9BxXFQK
	gi9at4TKIZnCAzQBjMvhqMGB49S+eOFgWXup5e+g3YXFJup7sz21jnbw6bDtQKEfQ+Zy+EJ1JCh
	U5q9HerkgDcW2HBn3qC8apP/r1vAtJ8A0rQg+RTK6UvbTPQ0WEqMsFUTSBiQbjGYni1AflGY9p0
	rXhm3S3NULfnhLnFNg0pTJ3mdNF1xEwDZwy6cKMvzLThtbgnf83hqLS
X-Received: by 2002:a05:690e:169e:b0:667:b503:4d2e with SMTP id 956f58d0204a3-672ed1d4e4bmr1602236d50.37.1790258897201;
        Thu, 24 Sep 2026 07:08:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e217944sm17455606d6.9.2026.09.24.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:08:16 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:08:14 -0400
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
Subject: Re: [PATCH v3 1/7] mm: support promotion-only NUMA hinting scans
Message-ID: <arUum9WcKl8qF0UC@gourry-fedora-PF4VCD3F>
References: <20260922182928.2199090-1-gourry@gourry.net>
 <20260922182928.2199090-2-gourry@gourry.net>
 <8699eba1-21cd-420e-a992-51a90ba62b71@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8699eba1-21cd-420e-a992-51a90ba62b71@kernel.org>

On Thu, Sep 24, 2026 at 01:45:24PM +0200, David Hildenbrand (Arm) wrote:
> >  - Opting VMAs out of scanning because they became inactive obviously
> >    breaks tiering - because the intent is to identify when a VMA
> >    becomes active.  Applying it in tiering modes causes
> 
> Incomplete sentence.
>

oi

Applying it in tiering modes causes VMAs to become permanently stranded
on lower tiers.

> > 
> >  - Opting Read-only file VMAs out of scanning is just incorrect for
> >    tiering modes because its intent is to prevent bouncing between
> >    sockets (east-west), while tiering controls tier migration
> >    (north-south).  The result is hot read-only files can overload
> >    lower tier bandwidth.
> > 
> > Add MM_CP_PROT_NUMA_PROMO_ONLY and let task_numa_work() select the type
> > of walk. Build the change-protection flags there and pass them unchanged
> > through change_prot_numa() so its PTE/PMD paths use the same decision.
> > 
> > Have folio_can_map_prot_numa() derive the single-threaded private state at
> > the point of use instead of adding another precomputed boolean to the
> > protection-walk interface. This keeps the interface focused on scan intent
> > and avoids plumbing VMA-derived state beside cp_flags.
> > 
> > The tradeoff for the cleaner interface is an atomic mm_users read for each
> > folio, rather than once per PTE range. Check the promotion-only top-tier
> > exclusion bit first as a mild optimization.
> > 
> > The scan-intent interface is required by the following memory-tiering
> > fixes and must accompany them when backported.
> > 
> > Fixes: c574bbe91703 ("NUMA balancing: optimize page placement for memory tiering system")
> > Cc: stable@vger.kernel.org
> > Suggested-by: David Hildenbrand <david@kernel.org>
> > Link: https://lore.kernel.org/r/4d2853c9-edf4-4685-b186-7214ed6abd84@kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> > ---
> 
> LGTM
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> -- 
> Cheers,
> 
> David
