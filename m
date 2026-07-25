Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F921F2B88
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784982894; cv=none; b=Pw2zk0vOOkF/I5sMAPgq7ggJ5D3CkrXMIAV5yokNtw+kPKKlGZ5PN8Ztczu90Rn8MDiYXkqNmV/pIZbMkVa9oqDAd1l6nxNQrs2nBzkuCtUOEBpHf0OXUtRw8LXpfoteaIrTcUnufdIKFDt9cI/7UttwNuQIfz7/W8A5jj+2jcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784982894; c=relaxed/simple;
	bh=vS0pGql9awyRGT95IiRORcsJ5LmaVC4RuVzluPKLk9s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XnGy0+xRHJ2t2bBBxY9wfAK3jYhheYpey1IpZPDhdQ1xAVX6iCsYYeHnZlVZY8QpUuyqHs9zHRwNQKIfN28LrPhICsC/DbPvfuMxlVMX/hpfAZTCu2ktLUeobJ/PwlE10uQfC9uxFXIbj8yX2wMdNQ3raKhjlxtnvr1WbqGOPl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ALV/u6lo; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ALV/u6lo"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784982877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4DKSBe6gBg9NpOljhRHmSDeJ/S4jLtsYwVLPovDP8M=;
	b=ALV/u6loawzgaAOeUKoTBEZiF0fdJTuauRBaojnTcEvDW19TwfPHaQ0ng0Pv/5U1ImHfZ7
	KrvaY9pYQ2kWkc9/6+g6kDUIMCB/jsDQ1P3L5HMinU1M5CkX//40NgJNYSo2ovGqty3Hoa
	am7oY+SAh7d2fNfyg4queB/HMVNGUyE=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Jul 2026 12:34:29 +0000
Message-Id: <DK7NM9RPUJOD.11PNJJ5N2OBED@linux.dev>
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
> @@ -4169,8 +4185,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsign=
ed int order,
>  	barrier();
>  	WRITE_ONCE(current->capture_control, &capc);
> =20
> -	*compact_result =3D try_to_compact_pages(gfp_mask, order, alloc_flags, =
ac,
> -							       prio, &capc);
> +	*compact_result =3D try_to_compact_pages(gfp_mask, compact_order,
> +					       alloc_flags, ac, prio, &capc);
> =20

Nit: the comment for try_to_compact_pages() is falsified by this,
we need something like:

diff --git i/mm/compaction.c w/mm/compaction.c
index 0568623d9384d..ca57403dc1522 100644
--- i/mm/compaction.c
+++ w/mm/compaction.c
@@ -2823,7 +2823,7 @@ static enum compact_result compact_zone_order(struct =
zone *zone, int order,
 /**
  * try_to_compact_pages - Direct compact to satisfy a high-order allocatio=
n
  * @gfp_mask: The GFP mask of the current allocation
- * @order: The order of the current allocation
+ * @order: The order to try and make available
  * @alloc_flags: The allocation flags of the current allocation
  * @ac: The context of current allocation
  * @prio: Determines how hard direct compaction should try to succeed


