Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598352;
	b=wlfPUh3Hx6RZrAi2KMWtGTIj1zv6cJ7QuD1GWKePTtHA4hK+ivw5Mo55HFAV6cVvMWZ/
	 hkPk7uf+hdrOR2OzGAdhzpkSr34QN7LAbjR4ojkvYcUtueofHK/CQw35mbIXQQ5ZxUVvQ
	 SSlEeNrcOQs0i+5fxD6CVN6JtvBxFoKzlfF8c6y3MoKnps52mEBQmE5bVIc6YTHLn4hsY
	 eTQdPv25b7J+6b83s8ozoBc9b3hZIoj8PI0NcguJEPVnMPrzCJTQHYRP6gFOLwADF6cbd
	 dNti77xoNcMza3B4bsXLZDuO1W9+czleToxKLBKCkvJtKq+mPnQADBVqQzcAQNKcPCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598352;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fAo+SUdWw8IPNJsn0IwIsl5VrDmLwF+WpUivd2tJar4=;
	b=01So5RZvW1ra/rZIy45yWgi8sDFXurnIfeYSUQ27S8x5KumWu0OJqNOfamYhdTGczAyy
	 +wIdg1mgR/pULQdKNg4WIYcSW/Dz7W99yfGqekDYc9g1CcFugQfAkRLnYAGPZFZAWpSdl
	 BOquz6SAaV2Oyjft5zcNR93N7oH0N/E4knTLL6JKjGj0z116+4pGo90ZedcCBGSNxJxL0
	 ULHfU01zgMQ4EEb3tts77evOn78PmRy6hKCDCbd6D7/TzSIqJ+r+OtPneIVjzS5fwMTtO
	 yS9tUsY0IJo05clwYNkz4aeL/IEGq48uZIebZL0MXFrLTk2ZybktrKFLy4n8QW4dubA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieRYNdSd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2749606A68C;
	Wed, 25 Nov 2026 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieRYNdSd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57031F000D8;
	Wed, 25 Nov 2026 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795598352;
	bh=fAo+SUdWw8IPNJsn0IwIsl5VrDmLwF+WpUivd2tJar4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ieRYNdSd01MN6n81no8M7mgH5h/kK3WEx1KRbfDdae6DKqHvU9SprXC7utnqZJU/1
	 CsRVgCmoPEAGue+cPNYXtJZwG3RFa872GCFNk5z/2QbAQtxcvJ4VYbEIySxPSp+ys8
	 ul16TYZGMBJB68fRtdfjCl3YDnqutlL5JMjBAwSdDeMTRRSwmuviq99GuevyYmH9fi
	 gR8AJxmXh9mA2YvZJJoTd7t8wWbVDmY5au5yaYQCmXuLzlZTYyRv4mo8iuvFW4dWYy
	 mAZxxKYjNmaqJDCuUp4sqZJg98vWiTb7vm7hH+F8QwYMVM5qI/VJdXEmN1hZklv00W
	 4yUngMTr0gtyA==
Message-ID: <7b89db31-3c69-4845-a46f-6bf42b3ab0a1@kernel.org>
Date: Wed, 25 Nov 2026 10:19:02 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: avoid reusing batched TLB flush generations
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Ying Huang <huang.ying.caritas@gmail.com>, linux-mm@kvack.org,
 linux-rt-devel@lists.linux.dev, linux-riscv@lists.infradead.org,
 stable@vger.kernel.org, Kirk Swidowski <swidowski@google.com>
References: <20261124-rmap-v1-1-e3dc48a4b527@kernel.org>
 <87a4mxthsn.fsf@DESKTOP-5N7EMDA>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <87a4mxthsn.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 09:51, Huang, Ying wrote:
> Hi, David,
> 
> "David Hildenbrand (Arm)" <david@kernel.org> writes:
> 
>> mm->tlb_flush_batched packs a 15-bit pending and a 15-bit flushed
>> counter into one atomic_t, and resets both once pending gets large.
>> flush_tlb_batched_pending() updates flushed with a cmpxchg() against the
>> value it read before flushing.
>>
>> If the counters get reset and reach that same value again while
>> flush_tlb_mm() is running, the cmpxchg() succeeds and unmaps that
>> happened in the meantime are considered flushed. A later zap can then
>> skip the flush and leave stale writable TLB entries behind.
>>
>> Use two separate counters, never reset pending, and let the flusher
>> simply store the pending value it read before flushing. To keep pending
>> from wrapping around to flushed, pull flushed to pending - 1 once
>> pending is more than INT_MAX ahead.
>>
>> Preventing the wrapping is primarily required because
>> try_to_unmap_flush() as called from migration and reclaim code does
>> *not* go through flush_tlb_batched_pending(), as it does not iterate
>> MMs. So if nothing in the MM triggers flush_tlb_batched_pending(), there
>> would be a problem.
>>
>> As the separate counters are no longer read atomically together, we must
>> read "flushed" before "pending" (acquire/release), so a reader can never
>> pair a just moved-forward "flushed" value with an older "pending" value.
>>
>> We'll leave the barrier() between clearing the PTE and incrementing
>> "pending" alone for now: it should be a smp_mb__before_atomic(), but
>> existing arch code (x86: inc_mm_tlb_gen(), arm64: dsb(ishst) before the
>> TLBI, riscv: fully-ordered xchg() in ptep_get_and_clear()) imply a
>> barrier. This should be cleaned up or documented separately.
>>
>> Note: if a flusher stalls between reading "pending" and storing it,
>> while "pending" advances by an exact multiple of 2^32, the counters
>> could compare equal and we could miss a flush. The same applies to a
>> writer that stalls while moving "flushed" forward.
>>
>> That is irrelevant in practice: both hold the PTL, so without PREEMPT_RT
>> they cannot get preempted, and wrapping within the ~20s soft lockup and
>> RCU stall timeouts would require more than 200 million batched unmaps
>> per second on a single mm, which is impossible in practice. Even with
>> PREEMPT_RT or long vCPU preemption, we would need minutes of unmap and
>> refault churn while the stalled task stays off the CPU, which is highly
>> unlikely and not a realistic attack vector.
>>
>> This effectively adds 4 bytes to mm_struct. However, on common 64-bit
>> configs it fits into the existing padding, leaving the size unchanged.
>>
>> Fixes: 5ee2fa2f0636 ("mm/rmap: fix potential batched TLB flush race")
>> Cc: stable@vger.kernel.org
>> Reported-by: Kirk Swidowski <swidowski@google.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> [ david: use atomic_t instead of atomic64_t, adjust description ]
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> Except the fork issue pointed out by Harry, the patch looks good to me.
> Thanks for fixing this problem.  Feel free to add my
> 
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

Thanks!

-- 
Cheers,

David
