Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494592;
	b=fHd2sBlQl5hPeIElJzqKyNIzJNPGitn5jGk6FCFsbDIHNRh/hiYdCtHq4lNk8nhH++TH
	 +rL6ISwGtZGZ/4RHGeZMAgkwfg0D48VgqcmemrD3GM4tSymtS/yHJ/qdJ+iKGW+WLc+GV
	 lm/dDY9ZHIHdfr1+deZOUlcJ1fe5xp8V2WlthKRtOPA8TMzVPey796yZl6j2r+8POdKla
	 7Nq+EsoW42wrbuuU/loUjwRoPMxiR7v16Sy59aVAVVuvdpCL8hebB0dFe2EeRzCHUlj6Q
	 pMgNs/no+KSd52kTwMR8py9j6MuKw2pJKopHkXzeJFyEBGuhvW2ZmT46MDWse2Kr15A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494592;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=qze9GsVDCuvc0w6qB++Wj9RPinmXFdwTA+6BdCxY1/M=;
	b=2vjUxvmemqAareqxSDmyXhGOZmtfwvq3eE63+/NdzljTIyAW+AQEjy3BEjYcxDG4HZl6
	 1r9Xg3c7oB7cT83dqW7CDtkLd3uuUpeg4A7iHWjfpCXwl5tfrj4s16kdn9Qo/FI4ekRi5
	 NtF3gGP1lvUFqONa1VRvFkMg4Zv3/uQpnp5AEhdJT6H/0PqhkB86FqdknZXSZEOVhYr63
	 IxuNmK65cWnJaJt4lrCqHYMGwidL/cyFVe9N/UTkWdnTPcXoNZcR0qRTfy0jcUA6FvXsl
	 9s8CAZcFcdkl2d/kMmKuTXhaC8wRO1JKot9JkSArBn1sYrgS9Nms4tbkh0vXTQsmp3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=NmWXkX5k;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=QaPbA8Nk;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF00606A323;
	Tue, 20 Oct 2026 11:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FF00606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=NmWXkX5k;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=QaPbA8Nk
Date: Tue, 20 Oct 2026 13:09:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792494589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qze9GsVDCuvc0w6qB++Wj9RPinmXFdwTA+6BdCxY1/M=;
	b=NmWXkX5kiRg47zHcScMu4FDG96YeUHWrE1RYjqbPrQ1ZhB5vy01TKBsfKFr5mFWCPBJ899
	MDXKEuI2g2g0aBFfFdSOkXqkc+QgKfYcDd6jBbrQfr1Y6Z2jKBKS0JjQzxbtXc5FGYteby
	Z9JeX93y8BCaUd5vJpg4+9I3IYqT58hAikmwvmLgku0cyKEYCUCbCvENRTqqCHGPzWVRwX
	a2druN3/XV93Uc8a9HhNkFyJ9/Ufi0TS4H5g4h672pvjDvsTxQLJTL3B5/HLFa/iopNwuw
	BlPUlPEvgu97qvCqRqjQswP/pFcO5/0nooZPxNHGQIAyBLJXCClUO73jO2CZDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792494589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qze9GsVDCuvc0w6qB++Wj9RPinmXFdwTA+6BdCxY1/M=;
	b=QaPbA8Nkwz1OAhyo1nPjOtN2F30jqrtsR5wGbN3Df2I5yvgZqmk1ZxKGT5qns2rGAB7zLC
	mM//MeqmqRVENJCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: skip shuffling and reporting for no-lock
 frees
Message-ID: <20261020110948.wv_yGAhQ@linutronix.de>
References: <20261005063515.6312-1-kmehltretter@gmail.com>
 <f5e7b114-2bda-49e3-974f-170211501203@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5e7b114-2bda-49e3-974f-170211501203@kernel.org>

On 2026-10-20 12:02:01 [+0200], Vlastimil Babka (SUSE) wrote:
> > An instrumented PREEMPT_RT lockdep run forced a random-bit cache refill
> > while calling free_pages_nolock() under a raw spinlock. The unpatched
> > allocator reported:
> > 
> >     BUG: Invalid wait context
> > 
> > The attempted lock was batched_entropy_u64.lock in get_random_u64().
> > Lockdep showed the raw test lock and zone->lock both held.
> 
> In slab we solved this by using prandom - commit a1e244a9f177 ("mm/slab: use
> prandom if !allow_spin")
> Could be better?

I hated it at first but now that I looked longer at it, it is not that
bad.

Sebastian
