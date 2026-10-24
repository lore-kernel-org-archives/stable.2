Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820033;
	b=symjGwCrL36tWouk1tIMFIa2GUsKyyvd15LRZTgFGQkle7vzkP+XxvWYHlP7VP93Bx9O
	 iSlxhY5IMQ2YQgW8wR8D9GVeO0C8HJjaTTlkSv5Qxure/ze4qlccVZveNDytzlOi9mn2g
	 jAKYrDQsu4KB1+GgpQDhJqhfcAlVzIMYBd4kQMtzm85YI7ylvk6ELOAkAGiKZE4Ykqcxb
	 7lVEm+MpTwJjoLrf9eRDwKX5FzZCcRieImhYF50Kuu3xniR1Jl94IwpXDYKKwqjqSOS8p
	 ClhoGKwRvYQNtYAQCETDXrm4cwVgHO5JjhXtuNEmKEaVAoEVUEuMRbrHFiJTYSVHV/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820033;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bD4W43pUpXqutJS8BdTi6cNfD5w9bG7qp9SO761d/FM=;
	b=OA2eMQDeXXTILDuLL4V8mYf4lSwQjmqKW8NRfZKAP6O8MaEgIvFZCk+oFg/Nen/WOLq7
	 vcUDgH7CIPOhnFAT/8pIDcKYMUr9pmL3hLjyArOGpRB0m13BGllnM4ev+xWBsRNiFryZR
	 XrRJ+iIYK+q0pkVXHEq7zTNrnMDloDDd1gZzljlbvnVYa2uy1GQS4x3wRywkpqYEReolz
	 8p7Ntk3i754dpbOf2/CBxebW9HZnrsJK1GeJ1SQCKnwdqSMqzR8e98pY/gpY1mnC46IL9
	 Sl2qTrk8ZkEYSQ0+Me1MwLnICxVIpcwKqWtueE6S0j9DcvCD1juonU6tFW5SoIFW7kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=jj7imCxL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57925606A32A;
	Sat, 24 Oct 2026 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=jj7imCxL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9681F01829;
	Sat, 24 Oct 2026 05:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792820033;
	bh=bD4W43pUpXqutJS8BdTi6cNfD5w9bG7qp9SO761d/FM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jj7imCxL/O2GcEZ6WAJ2fvkEkHX/X98ciZQtykNn3xUJflybmBO/Fmqph0y2S7MRo
	 BwytBJZ2Lyic/envHpJqoguzNSwUyfYaUHhPZpZ1IYp7Tv9Cy/NAaezxTS/P39AiqA
	 PB/OxnWHFrW0BB1qhvb2JNJ7YoBokrnB/4fJI0RM=
Date: Fri, 23 Oct 2026 22:33:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Samarth Narang <samarth.colleges@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Xu Xin <xu.xin@linux.dev>,
 Chengming Zhou <chengming.zhou@linux.dev>, Peter Xu <peterx@redhat.com>,
 Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>, Lance
 Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/ksm: keep soft-dirty when merging a page
Message-Id: <20261023223352.c6de9f2b58fe999814e5bb17@linux-foundation.org>
In-Reply-To: <20261021182157.1873726-1-samarth.colleges@gmail.com>
References: <20261021182157.1873726-1-samarth.colleges@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 11:21:57 -0700 Samarth Narang <samarth.colleges@gmail.com> wrote:

> replace_page() maps the KSM page with a PTE built from scratch, so the
> soft-dirty bit of the PTE it replaces is lost. A page written since
> "clear_refs 4" then no longer shows as soft-dirty once it is merged, and
> a soft-dirty based dumper treats it as unchanged.
> 
> Copy the soft-dirty bit from the original PTE to the new PTE.

Thanks.  My LLM review thing says:

: There's a separate, pre-existing problem with the KSM zero-page
: path which is worth pointing out.
: 
: When use_zero_pages is enabled, replace_page() constructs the
: replacement PTE using:
: 
:     newpte = pte_mkdirty(pte_mkspecial(pfn_pte(...)));
: 
: The dirty bit is deliberately set so that KSM can distinguish its
: own zero-page mappings from ordinary zero-page mappings. However,
: on x86, pte_mkdirty() sets both _PAGE_DIRTY and _PAGE_SOFT_DIRTY.
: 
: Consequently, a process can clear its soft-dirty bits through
: /proc/PID/clear_refs, perform no further writes, and subsequently
: have a page marked soft-dirty simply because KSM merged an all-zero
: page. Userspace then sees bit 55 set in /proc/PID/pagemap even though
: the page hasn't been modified since tracking was reset.
: 
: Your patch doesn't introduce this problem, but it doesn't fix it
: either. The new pte_soft_dirty(orig_pte) check cannot help in the
: zero-page case because pte_mkdirty() has already set the bit in
: newpte.
: 
: I don't think this should hold up v3. Losing soft-dirty when merging
: ordinary pages is a more serious problem, since it can cause
: incremental checkpointing to miss modified pages. The zero-page
: case instead produces false positives, causing unnecessary copying.
: 
: It would be worth addressing separately, preserving KSM's internal
: zero-page marker without manufacturing a soft-dirty indication.

