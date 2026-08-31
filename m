Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7944BCB4
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198770; cv=none; b=Vjw/xZUrVt1gP4j0ycT5J6Cma31cWdLSH4qMZdQOQkwxyZ9+og9HPMCimKxbTc6KnZoS2kM9OamlzWGEW1sP8cLhY6lV5AsweWWU6ogyGgVueK8ApIaOcH7Tl6J85mXLDeZ2T5GWWV7HKYWkOuFKtwhJpli8mnqHEDzzC6qYHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198770; c=relaxed/simple;
	bh=BsIgtLWDoXUh0LcK2P6/hUTeOlcXonOAihqw77WsqZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O632DBUkI8oQGPgCy3w7jrT9UpB19PiBonDCLpcElvEjYFVeDT0jpwDslPVF3UyaG8Jt1+M9N7EaIKPUTUS8NmYx9LBlKgLuI2jI0wehm6R3MblqoojFs47h+d4lMj44INBD5TMqwy+Rk1NRudWE49rfbvqUXRBoqCiTqqRLD8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r0PtDBGA; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r0PtDBGA"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BsIgtLWDoXUh0LcK2P6/hUTeOlcXonOAihqw77WsqZc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788198765; v=1; x=1788803565;
 b=r0PtDBGAj5IPiBeH2SDudqKC2RXht5AJf1i3TPIM/ShKr5UjrEIGzrrxlSrd7WLEKYlzWB16
 8ZFqnJNkT8PXguO8dx98psj1ayqOCFBGVAA2noX3QcTfBj44bjJjTPBWRHbWtRupMXyjD9gc1fW
 rsl4nnMe6fS1JxEiL9wo2eOk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d7054335f12e2924;
	Mon, 31 Aug 2026 17:52:35 +0000
X-Mizu-Trace-ID: d7054335f12e2924
X-Migadu-Flow: FLOW_OUT
Date: Mon, 31 Aug 2026 10:52:32 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joe Damato <joe@dama.to>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] mm: memcontrol: raise MEMCG_MAX for charges that fail
 without reclaiming
Message-ID: <apW_N1urVjfCLmbZ@linux.dev>
References: <20260831174836.3102406-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831174836.3102406-1-joe@dama.to>

On Mon, Aug 31, 2026 at 10:48:35AM -0700, Joe Damato wrote:
> Charges that exceed memory.max and return through the nomem label can
> raise no event and simply return -ENOMEM.
> 
> A non-blocking charge can hit the limit, get rejected, but is not
> visible in memory.events.
> 
> This was noticed in a production setting where bpf_mem_alloc() attempted
> to refill its per-cpu freelists, which triggered a non-blocking charge
> while at the limit.
> 
> Commit d6e103a757fa ("mm: memcontrol: do not miss MEMCG_MAX events for
> enforced allocations") added raised_max_event to cover charges that are
> force charged without ever reaching reclaim, but charges that are
> rejected outright were left out. Getting an allocation failure without
> the corresponding MEMCG_MAX event is unexpected and makes debugging and
> monitoring harder.
> 
> Raise the event on the way out for rejected charges as well, by routing
> the -ENOMEM return through the same exit path that already covers forced
> charges. The existing behavior of raising a MEMCG_MAX event on every
> charge/reclaim/retry iteration is left unchanged.
> 
> Tested with a module that performs accounted GFP_NOWAIT page allocations
> from a task in a cgroup at its memory.max, and measures the resulting
> memory.events:max delta. Without this patch the rejected charges raise
> no event at all; with it the delta matches the number of rejected charges
> exactly. A GFP_KERNEL|__GFP_NORETRY control, which reaches reclaim, raises
> the same two events per failed charge before and after, confirming the
> existing charge/reclaim/retry accounting is unchanged.
> 
> Fixes: d6e103a757fa ("mm: memcontrol: do not miss MEMCG_MAX events for enforced allocations")
> Cc: stable@vger.kernel.org
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Joe Damato <joe@dama.to>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

