Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553434;
	b=pKmhQjX+zzGG6RQmJ+MpdzFaNzbBLIR6nGlpFehBryQ3cwcH9/73BottrykcYCHe2kGv
	 20KCUWoWZgTiupp1q/P4aCK1JaBDhZ8i2bREMj8Jd5rsLzuFu1YXymLV4YWHVjXTrVVrJ
	 mBfzpFDvvzVluKDvLbugoruceY+YorfzjTtY4Jz2mDnaebNjG+dN6gAJHcSjgoelcCem3
	 QCDfMiaR9XIT/4rR58mcD796tq2+ksd+uJXHaYP7S39Xwj7mZogLGAeB3oY3tIoYId6Ye
	 kSrjYFI56LZ8z8XPo9ILUz3zBT3mHUWs64K/S2ZeaOIpjJMRSSvMrjP0xiPjvHORLZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553434;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=T2Cmoxzb1brkU2WAWgFepmyhPPY4h/7fNR3QOaBug3M=;
	b=aqXUzSR7MNQ3AZb0shcTVZUdkVthPMUXHBUTGinHvsHSp/XSM3EmSoEV2u0JZSN+QxaQ
	 nAj3j0yGuWXSOusMoHS4Ks7R82XNbWvgQq4fKnSs3Am+lkIRn+6cAijp2XivtpsKq3eKz
	 ivL3BylnBNbLSL+uri1wFf/dEucEH7VOd3ztw484amnLmbkdoAuvvJLQ3O/yVMjALSLgt
	 leNi5Kujj0rbB5gElvzcIN5hUT7doOEQyJueQwjj25KMPdaOIyK94sBpWScoo4CYU32NC
	 aiY2M9tnMfRrRqWzPvMIEvv1Km/fzReQca1B1Rn5HkgjYm9XGtb8Sp4M94zXHkkQNgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YCg5P/RB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F0606A33B;
	Tue, 24 Nov 2026 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YCg5P/RB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2871F000CF;
	Tue, 24 Nov 2026 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795553433;
	bh=T2Cmoxzb1brkU2WAWgFepmyhPPY4h/7fNR3QOaBug3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YCg5P/RBuE55E35xzbd0kZaokZyw6ayV60kuDkUiFuO6G7cWbSpYDRGaSM4dPOPHW
	 P+y1v5KL4nMjTiZdAbQyRoi+DwAJV5cg8lpblEcJLp/8MFBZXAZ+QNmoowupyj6O2h
	 sKc56OsXhASUxLZ4Rv0gucd6qhFdCy38w+SuBEGsOq9rQAwDOCQgO4dYjhKQlk6EG7
	 XpLFP9fKcvwDnz5rUrwxqNIDNoZG2svmMk5m4Z7mC9UDaLuFStKgkqrQRMSNhyFJs0
	 cc7AFk1RH226ltMpj9f2dPkz8V6tigdgxZm6jKdCj9amCMlJuQZenetpgwYWqOVc6L
	 FMeK7NARKo4BA==
Date: Tue, 24 Nov 2026 20:50:31 +0000
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
	Kirk Swidowski <swidowski@google.com>
Subject: Re: [PATCH] mm/rmap: avoid reusing batched TLB flush generations
Message-ID: <awXQg94rksZvexZe@thinkstation>
References: <20261124-rmap-v1-1-e3dc48a4b527@kernel.org>
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
In-Reply-To: <20261124-rmap-v1-1-e3dc48a4b527@kernel.org>

On Tue, Nov 24, 2026 at 10:39:11AM +0100, David Hildenbrand (Arm) wrote:
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
> TLBI, riscv: fully-ordered xchg() in ptep_get_and_clear()) imply a
> barrier. This should be cleaned up or documented separately.
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
> Fixes: 5ee2fa2f0636 ("mm/rmap: fix potential batched TLB flush race")
> Cc: stable@vger.kernel.org
> Reported-by: Kirk Swidowski <swidowski@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [ david: use atomic_t instead of atomic64_t, adjust description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Uh, I spent a couple of hours to review and make sure this is correct.
I thought this is correct but then my claude flagged a race during fork.

dup_mm() copies the counters with memcpy() and it doesn't know the
ordering. When flushed and pending fields sit in separate words,
dup_mm() could read them in two separate loads, but in the wrong order.

It's especially problematic in a very rare (IMO) case where
flushed == pending + 1 becomes true in the child (which means the first
pending flush in the child might not be flushed properly).

fork				reclaim			another process
memcpy reads pending = X
				pending++ (X + 1)
							truncate()
							-> flush_tlb_batched_pending()
							-> flushed = X + 1
memcpy reads flushed = X + 1

Maybe reset the counters after copying mm_struct?

-- 
Cheers,
Harry / Hyeonggon
