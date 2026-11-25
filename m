Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614739;
	b=wHmm9ILfwT4iYwYjRNqu2dIbmwudeXkbq8HydS8pQIIL0EVm1BLAQ7np4rWyrQmaxw+k
	 E75VQXHk9MyMldgqmkaMvVJdx5m8Bc29sBrunbyiT2FYq/2BrN/nRbr1MhVmTMNMXlhZC
	 GeONTdHJKX8XLnrOzGQ1Dcj4kaQ3gx5SXLcgVuX+7TTduloIdd8tPWKXaCzx0+/A7Xomb
	 eAcHYp4zhL5/yb3UsVlS5Ipz5U7HH9biljsqVBcrejTTN69VeRwyJXQ1ER7pV9IApxu1A
	 z3Uf3/aF2E1gWdHHhNVRJX9ZlzwurwP0SE6E+UxeVLJHjAlzUlKslpm7KNa98PA0iKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614739;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ih1VDTrU3FeJ2fsbtiUZSy/fzpLqeBrB/3Ho1Q8Vksg=;
	b=0dSug2NULdRwEjeAAffRM86Pw62P+Wz3vDwCQmGdmyIBZ7nGWsSEbkFepklUmbfXdJl8
	 rHS7gHY1Wf6MOrVVD1rsvvv7HXhMLklmLh/RZ259M3sbpmPDh0wG2y3IySjQftTPKl+2y
	 gJwqC9VpITcAe8a3cUky71alAjZEo9FhJYg8qgJ3Ff3mO6BsGmw7aYBZCqAg0mqN3ES1b
	 O2He9XBDohE2hoDmZissvIwwHODzMLOPyqi1oYQu3QpcHPQ/fzrYRJmI/61Ow49dfEIwF
	 KKQ1R+BvCI/HwseBLdGvXE4imyUmh8m7p18RIKWMIpjjFlKo32ZQyyUJFHPLwS5GxtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eassQ+eh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774A606A330;
	Wed, 25 Nov 2026 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eassQ+eh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21D61F000EE;
	Wed, 25 Nov 2026 13:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795614739;
	bh=ih1VDTrU3FeJ2fsbtiUZSy/fzpLqeBrB/3Ho1Q8Vksg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eassQ+ehtNlIg7BCYm6d9K32YvY8qw6Lw2o1T2KIXMP1nElqmQXlEYtZ3auoJRGPs
	 RuPLl0AlZn5mOfaiPEATfDF5yS2c9jSNMDDvEc2aB3teBrAHDvhqvQ0MilTw5woUrX
	 r+0qd3DgUr8J04D3fhgoVd1Mx84QADjJiEWYndLt5edAv7x6+DpeHV7Vl+aDd+IcQh
	 1ojyxYxC1kYLPCYAitx6iV/dJHFlHDlAbFcQmP57isDtbEc1BaI4smiZPDCiSmq5VS
	 ltAC3lonKaXHrHdjEBqyBOf1CebpOHDeQUX4mcBbO+VEv83fNq1eCllKZOuRXUuBGD
	 YyMs/2wdpZIAg==
Date: Wed, 25 Nov 2026 13:52:17 +0000
From: Harry Yoo <harry@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, Jann Horn <jannh@google.com>, 
	Lance Yang <lance.yang@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Ying Huang <huang.ying.caritas@gmail.com>, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev, linux-riscv@lists.infradead.org, stable@vger.kernel.org, 
	Kirk Swidowski <swidowski@google.com>, Huang Ying <ying.huang@linux.alibaba.com>
Subject: Re: [PATCH v2] mm/rmap: avoid reusing batched TLB flush generations
Message-ID: <awboAcnWHZfsy8bg@thinkstation>
References: <20261125-rmap-v2-1-0ba817662eac@kernel.org>
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
In-Reply-To: <20261125-rmap-v2-1-0ba817662eac@kernel.org>

On Wed, Nov 25, 2026 at 10:34:46AM +0100, David Hildenbrand (Arm) wrote:
> mm->tlb_flush_batched packs a 15-bit pending and a 15-bit flushed
> counter into one atomic_t, and resets both once pending gets large.
> flush_tlb_batched_pending() updates flushed with a cmpxchg() against the
> value it read before flushing.
> 
> If the counters get reset and reach that same value again while
> flush_tlb_mm() is running, the cmpxchg() succeeds and unmaps that
> happened in the meantime are considered flushed. A later zap can then
> skip the flush and leave stale writable TLB entries behind.
> 
> Use two separate counters, never reset pending, and let the flusher
> simply store the pending value it read before flushing. To keep pending
> from wrapping around to flushed, pull flushed to pending - 1 once
> pending is more than INT_MAX ahead.
> 
> Preventing the wrapping is primarily required because
> try_to_unmap_flush() as called from migration and reclaim code does
> *not* go through flush_tlb_batched_pending(), as it does not iterate
> MMs. So if nothing in the MM triggers flush_tlb_batched_pending(), there
> would be a problem.
> 
> As the separate counters are no longer read atomically together, we must
> read "flushed" before "pending" (acquire/release), so a reader can never
> pair a just moved-forward "flushed" value with an older "pending" value.
> 
> We'll leave the barrier() between clearing the PTE and incrementing
> "pending" alone for now: it should be a smp_mb__before_atomic(), but
> existing arch code (x86: inc_mm_tlb_gen(), arm64: dsb(ishst) before the
> TLBI, riscv: fully-ordered xchg() in ptep_get_and_clear()) implies a
> barrier. This should be cleaned up or documented separately.
> 
> As dup_mm() copies the counters using memcpy() while they can get
> updated concurrently, a newly forked child could end up with "flushed"
> being "pending + 1" and we could skip a later flush in the child. In
> theory, this might have been possible before (load tearing), but two
> separate counters make that easier to trigger. So let's just reset them to
> 0 during fork(). Put it into the existing init_tlb_flush_pending() and
> rename the function to make the name better match the wider scope.
> 
> Note: if a flusher stalls between reading "pending" and storing it,
> while "pending" advances by an exact multiple of 2^32, the counters
> could compare equal and we could miss a flush. The same applies to a
> writer that stalls while moving "flushed" forward.
> 
> That is irrelevant in practice: both hold the PTL, so without PREEMPT_RT
> they cannot get preempted, and wrapping within the ~20s soft lockup and
> RCU stall timeouts would require more than 200 million batched unmaps
> per second on a single mm, which is impossible in practice. Even with
> PREEMPT_RT or long vCPU preemption, we would need minutes of unmap and
> refault churn while the stalled task stays off the CPU, which is highly
> unlikely and not a realistic attack vector.
> 
> This effectively adds 4 bytes to mm_struct. However, on common 64-bit
> configs it fits into the existing padding, leaving the size unchanged.
> 
> [ david: use atomic_t instead of atomic64_t, reset counters during fork(),
>          adjust description ]
> 
> Fixes: 5ee2fa2f0636 ("mm/rmap: fix potential batched TLB flush race")
> Cc: stable@vger.kernel.org
> Reported-by: Kirk Swidowski <swidowski@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
