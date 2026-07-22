Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38F43CE7E
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740276; cv=none; b=isgJTNGEi08lAi8GySTKQwaU2rxiDTHo9VX0DjYLLQh2LrrehRznDlWoCngrW2qu7azr7a48tyFg51/VDINDohIZ++0uqTBJyOrTniOvuI18bE0U72P/8T+syBp04gEqb6nFgK3mx+CpSevI/Y1VtWJq3vzHJr1zm+OjmClIlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740276; c=relaxed/simple;
	bh=fW10j5ZOn2YlrXHCpCLgSjE4oo74ZZ7Fu380qiiGmZI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YtpkrxbyxeiivTAKa/aFKbE03gnshh3Lmy9UepfcPzrhJnvkyyCM+Rx0qDHCFMeDlSSWO9f2HuROyanMB/F9XyFAPxEONWtAzbOA74M8P7z3YPOARoW7HhZiK4rnuCAa7aclQ0y0P3TBI6hp++wQ0iNCjCOUl5gAAxPnhhKAUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LVvRpmEZ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LVvRpmEZ"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784740257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW10j5ZOn2YlrXHCpCLgSjE4oo74ZZ7Fu380qiiGmZI=;
	b=LVvRpmEZ7sWk0oPATEPFLd77SRo1pl2mZf8svyLk5An9WMOdeFr2VR8DAjJAY/JsZ2w1Th
	/dp2jQyTc9rnjiQyoHG2HqQyp8W+0scGwhBdaMh2m8nojhUXXI2Lm14pJ64Tqh2g6+L9ap
	sj3n0CzgAZRW9dn1CAYBazoYTwg5RR4=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 17:10:53 +0000
Message-Id: <DK59M9QYZ6CE.397V5ZU7P13UD@linux.dev>
Cc: "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko"
 <mhocko@suse.com>, "Brendan Jackman" <jackmanb@google.com>, "Zi Yan"
 <ziy@nvidia.com>, "David Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, "Mike Rapoport"
 <rppt@kernel.org>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] mm: page_alloc: fix non-movable reclaim storm in
 defrag_mode
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Johannes Weiner" <hannes@cmpxchg.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>
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
>
> Fixes: e3aa7df331bc ("mm: page_alloc: defrag_mode")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Just a note that I'm rebasing my ALLOC_UNMAPPED series onto this, per
the discusison here I have similar needs re making compaction run on
orders above the allocation order:

https://lore.kernel.org/all/17f2f1e7-36ee-4d90-af1c-1fbca6f94025@kernel.org=
/

I think the way you've done it (i.e. use the capture_control for the
"other" order) is good.
