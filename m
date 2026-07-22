Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC953B635A;
	Wed, 22 Jul 2026 23:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762529; cv=none; b=QaCL7eNMWSS+RMHFTFbToUFmDymwVG2BSFNbmnyy0rQ4c132nCvux6QbEQU4CZ+fTfYYf0fKf9LDH6Om2vM/ja6z+5HJ0Nx4d0q6j6KvniWP9SdInt4voNza2h2EtG44YJYA+++x4nbN5R3hLZHUPJAwDCCtQR4vZ3z52r/dxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762529; c=relaxed/simple;
	bh=jWFZNZ1EgV8oRVw84ullJ9fhzGi7rwBngqRUl9DN0pU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lOzqlfOXtTDMYLLjmgjsAvnm+TW8dk20qW3Sf//D5rL8sIhL8t4f0QdS4fI5hxNbH+1isGUKMnx1K2bDHc5tLDMAGP2Jc1vcdI9jsLx+yBQXAQgjRrM8Rkhq+pcUSfl7SrgEet1ZODB9mQTUsiu9udsSxuBz74JrhH4LaUR0d/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z/I3qCih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z/I3qCih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83DC1F00A3A;
	Wed, 22 Jul 2026 23:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784762528;
	bh=fY1Ru2zC/iJcoq3b+FNLhPaZonLcvPq0ZmyTt7fDVBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z/I3qCih2+SIO1TN3z9hZ/HcIz/TrW4SD33YNXg69bh5XvDTT2/f5sQ9dIlaja9i7
	 8D9B5aCITCzWsQGORFtLN/exM8ElKkeewacV90P4Kl4X/Ppc5lCMemuYT0YIorRhrt
	 a4/svc1oWR4Jhjj3TkOjjmj7wu+Ye1FBfVya3Qsk=
Date: Wed, 22 Jul 2026 16:22:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: page_alloc: fix non-movable reclaim storm in
 defrag_mode
Message-Id: <20260722162207.31a2c491ffaf36d1e8948c14@linux-foundation.org>
In-Reply-To: <20260722150006.3848560-5-hannes@cmpxchg.org>
References: <20260722150006.3848560-1-hannes@cmpxchg.org>
	<20260722150006.3848560-5-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 10:56:47 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> As we deployed defrag_mode into Meta production, pressure spikes and
> excessive swapping were observed on some workloads. Tracing confirmed
> that this is unmovable/reclaimable requests spinning in the allocator
> and direct reclaim, causing excessive amounts of swap.
> 
> The initial plan for defrag_mode was to rely on kswapd/kcompactd to
> produce blocks, and if those are overwhelmed under high pressure, let
> the allocator fall back (__rmqueue_steal()) after its retry loops.
> However, that retrying results in more reclaim on some of these
> workloads than we'd hoped, sometimes excessively so, spurred on by the
> !costly order conditions in should_reclaim_retry().
> 
> The storms are dependent on the request type. Reclaim will inevitably
> make room in existing movable blocks, since that's where the LRU pages
> live. So if movable requests retry on reclaim, they make progress.
> 
> When non-movable requests spin in reclaim that isn't productive. They
> cannot use the individually freed pages, and the process is unlikely
> to accidentally free whole blocks to meet the ALLOC_NOFRAGMENT bar.
> They spin and overreclaim excessively, which tanks performance and
> triggers userspace guards like swap exhaustion or pressure based OOM.
> 
> To fix this, send non-movable requests, regardless of order, into
> pageblock reclaim/compaction. This way, they help move things along to
> meet the ALLOC_NOFRAGMENT bar. After this patch, the reclaim storms
> and excess OOM rates are no longer observed in production.
> 
> The longer-term plan is still to have all requests, including the
> movable ones, help make blocks to spread the cost of defragmenting
> more evenly and fairly; combined with proper watermarking to reduce
> allocation latencies in the common case. However, doing this naively
> unearths scaling and concurrency limitations in compaction that need
> to be addressed first. Promoting just non-movables for now is the
> minimally viable bug fix for the above issue.
> 
> Fixes: e3aa7df331bc ("mm: page_alloc: defrag_mode")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

This cc:stable fix doesn't apply to current mainline because the
preceding non-cc:stable patches get in the way.

This means that the -stable maintainers will have to ask you to redo
the fix to make it backportable.  And you'll then be preparing a patch
which hasn't had standalone testing in mainline.  All very cumbersome.

So is it practical to make the fix come first, as a cc:stable hotfix so
we can upstream the other patches in the next merge window?

(An alternative would be to put cc:stable on all four patches.  That's
a bit abusive but we do it rarely).

Either way, I'll get these into mm.git for testing while we await
review on [4/4], thanks.

