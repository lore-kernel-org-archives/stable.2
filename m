Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596720;
	b=GfF56hu52iaHXtrQO4TtsPex4uFBBjPwwNipAuysTjpGtvUKNch23XKR8dmNt73813LJ
	 Pp74ny62qKXnOjozfLhIlbTHuV+fk/k0t1jviul0GquNln5E0XW3DaEfalVcDljPVp3Pv
	 7hWAigPaRRfPi7Imh2cs8q7XYImJiZf81BBxZZuiUJmKdjkI4SE250vo5DMA1IiWk+yyD
	 CzJsj9KxTRBEptsOLGuGYe4EBp3n7qN/mrYwy4thXzHi4gwL2jX+xHKXOrXdfTRvGbNZs
	 6SJjaCwwvjrTLxrM6yCYGk8hHl5eIbHcr3WbluXQmJ5l+ccdwlL8s2szSEgp9oaiWuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596720;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type;
	bh=CpS23/nwi76U/xfd1RwGp9LbeXJvRV6wntw7x0C4i80=;
	b=K9J+E408/p8W0zPN+OfroNTyhr6wHwKlbfFEzsdqMel7wuvUWu9OwD63mZM+eZ4GnxGr
	 D1+BU/jl5mry1VcAQUgzOpHN7DS5y009YYWptHeUm7qjsy5li7LDCRa9PYu2SD3v17/2/
	 xjtXBrACsTuTtJsefnIxM/lDiUonYSLl0Kd6HFdIn/kB1kQmsKkQO664UklrFn3Ey5kFg
	 WlH8/qfkrB9AUuvL0hfyglq/kLeVVbIjxyuWmSlXNcTfPrjzQaFRqNhmNukqQUIT89h0r
	 ADjgd5wtW2LZMOtPpEb1biyGG1S85lowHMwW5GE+mw8T5N1G0XzO91L3uDGFrqVXWQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PrrfGIvG;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF2606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17CF2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PrrfGIvG
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795596716; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=CpS23/nwi76U/xfd1RwGp9LbeXJvRV6wntw7x0C4i80=;
	b=PrrfGIvGAojPJfNqzNx6ZEACFlbhf/Lz4t7tDDYchvTPSO5C0FaW4+vd0I7zJOhukwi2TxBzVbAn1bR6xaCI8LI/hNtkiTGR31ZDCgDvYEZVE3SU1iNhItzBGYJVxV96vpnbXi2lZL38lWO+8sXUaoEFTDnElRZyRQBU7AzwpQc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=ying.huang@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0XFR2tqg_1795596713;
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0XFR2tqg_1795596713 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 16:51:54 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,  "Liam R. Howlett"
 <liam@infradead.org>,  Vlastimil Babka <vbabka@kernel.org>,  Mike Rapoport
 <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@suse.com>,  Rik van Riel <riel@surriel.com>,  Harry Yoo
 <harry@kernel.org>,  Jann Horn <jannh@google.com>,  Lance Yang
 <lance.yang@linux.dev>,  Andrew Morton <akpm@linux-foundation.org>,
  Sebastian Andrzej Siewior <bigeasy@linutronix.de>,  Clark Williams
 <clrkwllms@kernel.org>,  Steven Rostedt <rostedt@goodmis.org>,  Paul
 Walmsley <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert
 Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Ying Huang
 <huang.ying.caritas@gmail.com>,  linux-mm@kvack.org,
  linux-rt-devel@lists.linux.dev,  linux-riscv@lists.infradead.org,
  stable@vger.kernel.org,  Kirk Swidowski <swidowski@google.com>
Subject: Re: [PATCH] mm/rmap: avoid reusing batched TLB flush generations
In-Reply-To: <20261124-rmap-v1-1-e3dc48a4b527@kernel.org> (David Hildenbrand's
	message of "Tue, 24 Nov 2026 10:39:11 +0100")
References: <20261124-rmap-v1-1-e3dc48a4b527@kernel.org>
Date: Wed, 25 Nov 2026 16:51:52 +0800
Message-ID: <87a4mxthsn.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, David,

"David Hildenbrand (Arm)" <david@kernel.org> writes:

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

Except the fork issue pointed out by Harry, the patch looks good to me.
Thanks for fixing this problem.  Feel free to add my

Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

in the future versions after fixing the fork issue.

---
Best Regards,
Huang, Ying

[snip]
