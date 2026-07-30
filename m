Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87791374A1D
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438104; cv=none; b=A6b113xTgl6UEslPcmGNeQWt039OvTEzyL8tzMpG2nVOWk7LUOIStxl5Hwm0Z8QltPTCPkpyewrc0TLRadNsurLYydTSQIQHU8fQrEy9CTOD4neO0H0eFT3bO7FZCNzQbATHmYsIQT3NK63WTrXsDGBsCaxoVohkpCRRecMtn0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438104; c=relaxed/simple;
	bh=013H1I9/4OHiS5zhZMxrwaHnsOF1mfy4INGhmCqtxrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHbVLKcBwWITaJi7g47rI5BrnWCwn51mTVIxTYPE7LWHFuQEBcoBePddVBLEFETvhbAvtghkkC97eLFYOhqO8YC5emPmpZEh1qnumlIwUwfp2yaA02N3t7InCwMf6n5e2qtqacVCSKuMKH3qkfZpAx10xYnyo/Q25z3JTJtLup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=t0j1bdJ5; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="t0j1bdJ5"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e6c4a867cso16355985a.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1785438101; x=1786042901; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n1yOof5RfumCoH1r75oUvzt/UONr8poJqHsdkRardoM=;
        b=t0j1bdJ5o743l5w0dDi/Bj47EM77W33CFx9kI0xt4NttxMcDjHSgqpTg9AerF3Wzw1
         +7fV4tRiyA7+feArNJv7nAz5gHXaaoEJeo9UfSepa6bPPFYvuig7EvlqeoY7H1SaHqti
         TYEHtC/9lXBamtMScPE/EOGH1pMEaHs6pAKYfI39t2/DOLdW4seqBGdn54wCpOsUME2D
         L0NY6DPk+QG0M6kFh8GrsQUKa9//0r05U20w2Faua3xZjWbKbTOXODMAQOw2tM2Rx7uk
         98tyq+vibK9SZz9MFjNMFqRc64MAbsEW97U6fCGy3L9bv5igbBWW6gCAJOnfUQkl4orF
         U5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785438101; x=1786042901;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n1yOof5RfumCoH1r75oUvzt/UONr8poJqHsdkRardoM=;
        b=rEQ+lUGVOIApb+E5SfuOJPrK3wwlMXthFLxOY7Ud3Sp7reL7NDiw1hx3b4ckPNZJcz
         FomH2FP61qOkhw1yEMJelQiwHBex1lgQxXZIwE4i0xmSs7wmM4Rfr9tGsf45g1qii1ok
         QBGGbNbAwufOV+s/J0qK0GgMkOyp6eAZBGGEWow7AnO3JUb5YMqf/LwQ5Sq6BlJJUi7t
         pxuPFf3I0B7L8PPwPTj/f90smz+gak89A7h17JbSdxX372oiDNnZ8qhNkmPqLmAXtYUp
         hMWqhkHXWw5kliJ0/fvANiyaPGzgqhw92ryLT105gBddgFli1Rnj/X8T+FIwsSGdMAzb
         gkgg==
X-Forwarded-Encrypted: i=1; AHgh+RqC64c1oB/5sxANsCelk7atQ81tfs1r/LfxOgA0wtB3yuC/EEPp4KumiMMBsySp1KsUaUOHjVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkFRPdzH7gXjrzE7j4FKL73C5iRHpLHALZosEmo9ejsUwIZqY5
	obxASPFE6H/UPmMx6BfsJebIKKgewJ6iKGgrxUv9T9BRpYbRHk0ohYljZciBiHnp/GU=
X-Gm-Gg: AR+sD11asGNk0TxX0id5RVCapRNFvyEzF2hKsIk3PGs7B07xM4FaJK4J/vyxXizDEOu
	Z2JBcq6UG82R+vbV+ZVKcm9a+4lQoWfOv+HWN0Mds0g+/NJ0SLeEMmpijerbQ41tmm79Tg1lnQk
	mGlylKRfFjZfdclxeILely+UdarNms0fawaL5PVtoJ6xz89uwPAyH+myIOSx6CWonhGUOkRFD5O
	SlNwGQokSZjMdR9h4rd2fxKozbhYPxv1WKAlIvwmuuERq1ItLDWb0QKm4sPKZYPiobHroTBKRY5
	vb1hWKzVEzw7sic2n2C5aZUifdsxiNKCrizqvBPRGFisHSM/03WVwL/qe6cvpLVlXXKyr/0XWYQ
	UrDa0GCC6DKT486oCMOEj4YzZCF84DBwiSIxrdoSclrrsDaCias6SRpwdpkN/YaElaln6hFbJJl
	8TCTx199V7uH0/sskYVH9MHIqyIKN3V4KL2GPojgYM8Y82ooS+xQtnFZSShtE=
X-Received: by 2002:a05:620a:460a:b0:932:dd83:c54 with SMTP id af79cd13be357-93485ff2ecemr442630085a.42.1785438095030;
        Thu, 30 Jul 2026 12:01:35 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e712fc05sm475477685a.29.2026.07.30.12.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:01:33 -0700 (PDT)
Date: Thu, 30 Jul 2026 15:01:30 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org,
	shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
	chengming.zhou@linux.dev, muchun.song@linux.dev,
	roman.gushchin@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/zswap: Fix global shrinker when memory cgroup
 is disabled
Message-ID: <amufiuAaZbuDdKkQ@cmpxchg.org>
References: <20260729084206.77793-1-jiahao.kernel@gmail.com>
 <20260729084206.77793-2-jiahao.kernel@gmail.com>
 <20260729155858.c7aabff48166a9bca4d68ac3@linux-foundation.org>
 <CAO9r8zNhBCghP8T_98z2p==Cfs_=kamcRN_3ROxaj3R8PN2Qvw@mail.gmail.com>
 <c4c95102-72e2-a44f-f16e-4134ba6bb060@gmail.com>
 <CAO9r8zOSTYC3D_2CxapgvXGaZRUdnGetPGz2XgdUO8OygfuEiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9r8zOSTYC3D_2CxapgvXGaZRUdnGetPGz2XgdUO8OygfuEiw@mail.gmail.com>

On Thu, Jul 30, 2026 at 10:48:38AM -0700, Yosry Ahmed wrote:
> > > Yeah, it isn't. Probably we should drop "Closes". I assume Hao added
> > > it because checkpatch annoyingly complains if you add "Reported-by"
> > > without "Closes", so Hao just linked to the thread where I pointed out
> > > the bug.
> >
> > Yeah, checkpatch will complain if it's missing.
> 
> We often ignore checkpatch if it's unreasonable.
> 
> > >> AI review asked a couple of questions:
> > >>          https://sashiko.dev/#/patchset/20260729084206.77793-1-jiahao.kernel@gmail.com
> > >
> > > The review on patch #1 is something theoretical, we discussed it at
> > > length in previous versions.
> > >
> > > For patch #2:
> > >
> > >> Does this batching logic break NUMA fairness?
> > >>
> > >> Because for_each_node_state() always starts from the lowest node
> > >> ID and breaks when the scan budget is exhausted, subsequent
> > >> calls to shrink_memcg() will restart at the lowest node ID again.
> > >>
> > >> If the lowest node (typically Node 0) consistently has enough
> > >> items to exhaust the scan budget, wouldn't we exclusively evict
> > >> pages from it while ignoring older pages on other nodes? Could
> > >> this cause LRU inversion across nodes, keeping older pages in
> > >> memory on Node 1 while hot pages on Node 0 are evicted?
> > >
> > > Yes, unfairness is possible.
> > >
> > > For global shrinking, it's probably not an issue. We reclaim until we
> > > hit the acceptance threshold and it's very unlikely this will happen
> > > before iterating all nodes (given that the batch size is 32 pages).
> > > However, with the shrink_memcg() path, we only reclaim one batch, so
> > > there's a chance we'll always reclaim it from node 0.
> > >
> > > Maybe we should just drop the early bailout and accept potentially
> > > doing more writeback than needed. Hao, WDYT?
> > >
> > If we scan and attempt to write back SWAP_CLUSTER_MAX zswap entries per
> > node, it might lead to excessive writeback on machines with many NUMA
> > nodes. Furthermore, I'm concerned about introducing higher latency in
> > synchronous shrink paths like zswap_store()—especially on systems with a
> > large number of NUMA nodes, where it could end up writing back hundreds
> > of pages in a single call.
> >
> > Maybe we could do something like this instead? That way, in the
> > worst-case scenario, it falls back to the baseline behavior without
> > introducing any extra latency risks.
> 
> This basically errs on the side of honouring the batch size
> (under-reclaim) instead of doing more writeback, right?
> 
> I think I prefer erring on the side of doing more writeback, as it
> would ultimately result in less LRU inversion, and we are already
> doing writeback proactively during reclaim through the shrinker.

Yes, LRU inversions are worse than reclaiming a few extra pages from
the cold tail of the LRU. It's not cumulative after all, it just means
we take a bigger bite and can take more stores before the next shrink.

> The other option we can explore is keeping the existing logic with the
> bailout, but start iterating the nodes at the folio's node in the
> zswap_store() path. Basically pass an nid to shrink_memcg() and always
> start there. This will avoid always reclaiming from node 0, and the
> node of the folio being stored is more likely to be under pressure and
> need the writeback. I am not sure how complex this would be and
> whether it's worth doing.
>
> Johannes, Nhats, any thoughts on this?

What happens if simply we do a hard SWAP_CLUSTER_MAX on each node?

With cgroups, we put the zswap entry on the list_lru head of the node
and memcg where the incoming page was.

So if you're going after one specific cgroup, it's not like you
*actually* reclaim 32 entries on each node of the system. You just
write back from nodes where that cgroup has entries.

The global shrinker also does one cgroup at a time (zswap_next_shrink)
before checking the limit again, so that's fairly fine-grained too.

Without cgroups, you could have zswap entries on all nodes. But if you
have so many nodes that this would constitute hundreds of pages,
presumably that's still a drop in the bucket compared to overall
memory capacity. SWAP_CLUSTER_MAX isn't that big a number.

So I don't think we need to get fancy. Just do SWAP_CLUSTER_MAX on
each node. Delete that nr_to_walk carry-over between them.
