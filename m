Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699007;
	b=vl4CFMBbQc4MOOqrrHgxCjzsXU7JPK7yzKO2gh2fM9YwHAtkBfBCnECTQYxj4zzvl8QP
	 TTPlbQIhShTUAVe9V5MtvG9EV/goMFn0DDmuiiOJpaZuSFzzLk1CxghO3Uw6bsm/79EgE
	 WjT+eUzc5NCGhA6y2/EEOG2vNdg2sBqdeLJiiNaLZ8QWraQf/ad3sn/QRvNw6x7YMjgx0
	 N6s+VfnQjuLqfZYiOXhvTlL1imle3BK9/G2wYURJOu6dNjpxnvkjwl8GSM6FXSH13YZRD
	 JL4+/2djVbGzK0diNhU3yzUi0BrEtYxbuJaQMPFYhhMN4PU3N0m9qgJlJd9JEUf5s2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699007;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=ehgUlTp55qdmB35sLa7A0/qjO2eVfa+LAyFNNpEVErI=;
	b=BHw65P3H+FlJbK8O6TGMfIm1yd4YADEaZ5uCqjqf/WCvdgQe2nXOVoyrRu/3Lw/HrMCD
	 7wENYes1oMtxRZIjcouqnjORFvuFXBWTqX2c+0CPdM995ymd/d+I8sjnAzFY8f8ziPaCu
	 m9G2CwkXM+cpG1c67qQ8zg4ZFH1Hp0w2he4bU3iPzn8gK0s40VNwdsOubnOd01nUCankX
	 K50rQyQ9A+oWRmt+zHjTCuoBYW9OJOw4EOqQA0VmWvY1W52up0cM4D7IG8RJFMin3nE6w
	 aLViuiU3A8qmDN2GadH0GJwOlPyy9LHOVrtdhKi6m72wMt4t25S3JQe6xL/4vK3btuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvP5uzYV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC99A606A31C;
	Thu, 26 Nov 2026 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvP5uzYV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9831F000ED;
	Thu, 26 Nov 2026 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699007;
	bh=ehgUlTp55qdmB35sLa7A0/qjO2eVfa+LAyFNNpEVErI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hvP5uzYV/M6mmd/34FK8Mg1hVQnnl7JC2syiVD/BCJPbcQp3xGy130d5votP+66EJ
	 EsvedPNywuwHqx5NqtnpvSMSf/jkHTaBQY/227R6kE+zjV1gjZYJLpsp+0qqKp+X7B
	 oNkrrvENLDIjUizp276GwgI7eEwHlDQq/5LfJ7WOoX4xhuTaPGuzD7f/W0oD742UyM
	 Nq+RqD+6YlalFBxPPmOY0QLfvp1DpnYLGVGRhJK8Hp87iU26p6rFZ6EZdgTxNMSgA0
	 ldiATGL8MtNaTSC07F3eijcyEFPH5wdsLgWIwu0kREDBOBabUR4G0xnVf6NM5zPTrw
	 TCmxqQUbporXA==
From: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Ying Huang <huang.ying.caritas@gmail.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
 linux-riscv@lists.infradead.org, stable@vger.kernel.org, 
 Kirk Swidowski <swidowski@google.com>, 
 Huang Ying <ying.huang@linux.alibaba.com>
In-Reply-To: <20261125-rmap-v2-1-0ba817662eac@kernel.org>
References: <20261125-rmap-v2-1-0ba817662eac@kernel.org>
Subject: Re: [PATCH v2] mm/rmap: avoid reusing batched TLB flush
 generations
Message-Id: <179569899881.7893.12894803575730359323.b4-ty@b4>
Date: Thu, 26 Nov 2026 14:16:38 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Wed, 25 Nov 2026 10:34:46 +0100, David Hildenbrand (Arm) wrote:
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
> [...]

Applied, thanks!

tree: mm/core.git
branch: for-next-fixes

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/rmap: avoid reusing batched TLB flush generations
      https://git.kernel.org/mm/core/c/40e0fced

-- 
Cheers,

David

