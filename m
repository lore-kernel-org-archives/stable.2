Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460006;
	b=XsZrRf9T8i3gmczdZH3KMA2hmFWoOeoQibhKdIbpnEVnmgZEcR8PFSu7LC4543gonOrN
	 e3ukhpIzr9uNjMUG5FAM0xVHBkLiXofca3Ypvk4lNwpvUjR4nJO1hkzsp8oyjMXnKnISt
	 MIKDTWyXtL+ZzKutqQioHYFDTiGB1QktBFNjbAVvzRDxkqs/j4vdtybA+mjKokpwqCM1p
	 tj+rR92wThqeVXs4XIYSkuaaGTE0ht/gb+axJa5sotjf376zcPEYecMQ5O9X7MewDo+yZ
	 XCV4qGi6XBMDhi5QHVxPLH/VhoG7U1uFLWskgLyjw/AudvULyKwA8pi92Tq1CpNQ0hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460006;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=snwenA2UEFoTVk0mC7EykivyD6INKAnjMBdo6EmcVu0=;
	b=3Mhytx5WaHBeQ+PTq/6lzOx8BCzlI9yRh0sJfVCNZooVUUigBBKgsKwZxI4Ygf8CcmZJ
	 AYJrgpr917c75VsrbsD49RLzhhbE1qy8/4ffJbyPFcnr9g/Gz5ff3/TY6rgUKsa3quLm+
	 fhL2ewvYqJT1wJuQoo2B2Jv/by3+9BVOsVNBFE6C5pS811cHxSh32OvoP/THymg3PK+PW
	 NZ7dmKGGWMGX2cF2BcSV2QV/SgBK0KU2M90Opkc27V1C52gCFJIaycaOGD8ZYPZkvU/CQ
	 e2+Fm+MemE+6Jm1lO6vSCbYln7lAhxnD/ApPYjK/MaLk372wCtH+rKeUS/sPLbOyWwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtYRBPT2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44160606A330
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtYRBPT2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7441D1F000CF;
	Mon, 23 Nov 2026 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460005;
	bh=snwenA2UEFoTVk0mC7EykivyD6INKAnjMBdo6EmcVu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UtYRBPT2fidmnfFd9lwQ5yWQ0czmOAkmsZ4J1HCHaXNpHtcAFHKLD0Cn6Rr8lPeQd
	 whrCJdnobvEi3WA/AITWyDz9hmjV4WIR+wU0REwZWDUWpnpq9ISz6xPSQYS93PrM35
	 FP3ociNIhDaRxwiPNKWaGMUQvSr7Ft+oqfsshYlLDYlAENl3oUMdJyZ8tdRvkp8Rm9
	 gASedpvdkibfmqVpntYQEq9+JIrezBO8YA8TBpXIrRg4Sn4OnLPMlm9fCUAftrJlw+
	 r9sIux4Vfes6j6QV9KjuZl5jOiuVd1wGqkhpwsQrss/4H256wCzbwUavufZCMMNAg6
	 +bag++oazM6oA==
Date: Mon, 23 Nov 2026 18:53:23 +0000
From: Harry Yoo <harry@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Usama Arif <usamaarif642@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, stable@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 1/3] alloc_tag: handle a NULL tag in
 alloc_tag_set_inaccurate()
Message-ID: <awSLYc39oOG3EpiI@thinkstation>
References: <20261119-alloc_tag-v1-0-efcccfd3a9c9@kernel.org>
 <20261119-alloc_tag-v1-1-efcccfd3a9c9@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-alloc_tag-v1-1-efcccfd3a9c9@kernel.org>

On Thu, Nov 19, 2026 at 09:52:20AM +0100, David Hildenbrand (Arm) wrote:
> With memory allocation profiling enabled after boot, a slab allocation
> can dereference a NULL pointer if current->alloc_tag is not set and
> allocating the slab object extensions fails:
> __alloc_tagging_slab_alloc_hook() passes current->alloc_tag to
> alloc_tag_set_inaccurate(), which does not handle a NULL tag currently.
> 
> One way to trigger it is through rhashtable: rhashtable_init() records
> current->alloc_tag in ht->alloc_tag, which is NULL while profiling is
> disabled. Once profiling gets enabled, alloc_hooks_tag() sets
> current->alloc_tag to that NULL tag when allocating a bucket table.
> 
> Fix it by handling NULL tags in alloc_tag_set_inaccurate(), just
> like alloc_tag_add() and alloc_tag_sub() already do, and drop the now
> unnecessary check in __pgalloc_tag_add().
> 
> This has low urgency.
> 
> Fixes: b9e2f58ffb84 ("alloc_tag: mark inaccurate allocation counters in /proc/allocinfo output")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
