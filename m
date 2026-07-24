Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1E440A3A;
	Fri, 24 Jul 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905799; cv=none; b=d91rZHJrdB2ExAlplM20JBP23Bm2PIaIwKQHY81vnE+XJD63RU+2KMlwYxgwHAxx9hNuRc/kV5Rg+rIutzOQez+bXH9Wl24qclHNOw8kFX2MsXMHBh3GbT8uHafREq65keT05Q8eTRvYVIJrrI5vULTUOea7qLUEe/A9tBLYH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905799; c=relaxed/simple;
	bh=LrK6XCzPn9w/pAkja+a0sS+++36AUS3xetGkCJHXVDU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=i3nJStOMIRhydh21kUhq/h47cyxe8cXL1vVPKvbDKNtizJr3gInTeAN52HjBBj7IxfrtCQ6PupiX146t+2ZCWha496ITqDhHfM2a/HmmTKK02l3uC7nMkeOBK2j6kveLeZ/D2aaPe5gRAYLgRHl9XfZKCcC5xoB+Z4fJi0O2AIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QRhPdMVj; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QRhPdMVj"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784905792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrK6XCzPn9w/pAkja+a0sS+++36AUS3xetGkCJHXVDU=;
	b=QRhPdMVjufPUbcboXkrdt8XctcYEM20T/lv8n4fB4pJg/op1fAff/SrlEj5S5EJHIa/Urh
	71XhM44Xfy0b64c4KZt9KBbhXtd6Ytu1QVagsDFKPz3bIHbLROc6drVAaS+ZkwVC5fsI42
	MBkWvQuxE/buLUIjLWWP5itdXz1HQxM=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 15:09:49 +0000
Message-Id: <DK6WANTYCK4H.CRSXHW3ST1Q5@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Johannes Weiner" <hannes@cmpxchg.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>
Cc: "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko"
 <mhocko@suse.com>, "Brendan Jackman" <jackmanb@google.com>, "Zi Yan"
 <ziy@nvidia.com>, "David Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, "Mike Rapoport"
 <rppt@kernel.org>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] mm: page_alloc: fix non-movable reclaim storm in
 defrag_mode
References: <20260722150006.3848560-1-hannes@cmpxchg.org>
 <20260722150006.3848560-5-hannes@cmpxchg.org>
In-Reply-To: <20260722150006.3848560-5-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed Jul 22, 2026 at 2:56 PM UTC, Johannes Weiner wrote:
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

Please forgive the noob question, I'm still struggling to get a really
good mental handle on this stuff. But what about compact_first here?
When we're promoting the order for compaction does it also make sense to
promote compaction itself?

I'm aware you said "minimally viable bug fix" so it's fine if this falls
outside of that, I'm just trying to poke around to improve my
understanding.
