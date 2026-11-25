Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646567;
	b=wTX61PrLLoVYbUInPLK0MSb4zXlzThPzKm/YPvBltsQWu4hQPZ6Zaly33eiKZWqW/oVi
	 3egT44YOD2AwxqBaG/NMg/Iji70uS3j5Mg/wrykBWbsfpNTa/8WMY+jWrQd9c9mNqgqVx
	 eNSsYBQAewe8a6cyPWzNYZdy5yiXM2RVsfjCd+b+tvMWtiCXLVc7IpMcyABU0IF9S2h8p
	 VJRLZYc7jyOa8L+quqSPD/TkhACrapIlSmpzsxkB4Q+It5aLGbTogyVGFlTH8rwlwLOVK
	 VyYdHCCy/YB0ubEUc3Db4UQ1jjpLDOzGvLHN31SusJtC0TpugtrrmhnORI3HsQa5SFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wIfAdkxQcsRohaTqE06fnblD43O9O+Djz5eJ6myvDxo=;
	b=nmgMLxeSy+59DeH7VOe4jmPGEPZ34pMFlszhAn9NKqF5nD4Yq6SB72RrbJ1gWkZ6wKuu
	 J8MDRnse6ZN7OEX1I+bjCRfTv2mywe5eT0ZiryZjT+wMYwXhB9bzVMNNI2VJt6W4ldLl5
	 MthW+/xBPO1AXulCJmGS6rKjkpwLeYo1tCPh+b7cyK8RxXGHHDCwJo1EH0B/0QvSHoEsU
	 WVck+nsvzrxB7FlLge8UJheFrnoOVCkq5f6FfoSRHM29JT/eGOJzLSTGonCypa1V8gQsg
	 U+q2PyivUEPbg6x7xFAhlyIJUI4UIelFehXP3nfL8WiTKXm9sgkXHRkIDeqfGff1B2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fOc3quFb;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67BF606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D67BF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fOc3quFb
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e46e449e8so4112077f8f.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795646565; x=1796251365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIfAdkxQcsRohaTqE06fnblD43O9O+Djz5eJ6myvDxo=;
        b=fOc3quFbvMOr8pjf6uuYEU3G7FG3saZ3sIflZpe4/3Jjar+j/YaqYx0MFeMcK3ky5M
         VBx5YCTXm5H43vlqnDw41XCtvMnkwlaEuCYU4zXglbyhQXYTO11Bt7k8yBrwRo8NRcLW
         OpydcC43c+x4htgp/azQefJUEio7e/c0HlB9rnZXyA9CHcBeYwmnYwJf++Q9UsOkhHEh
         kGnSP34qaUSaIjAZHiL022Toc8quFYQ7Ctjw28WP6ywMi2zgxR8IkZRSLajvFAzpqGs6
         Zpp9KvTLcNslNAKnFIT83nVsBCi8g4ONVgk3K4xq8MumPcrD0dQG+Z5+2BMxLIN/sgI6
         68ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795646565; x=1796251365;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wIfAdkxQcsRohaTqE06fnblD43O9O+Djz5eJ6myvDxo=;
        b=M6/spOiY2JAMIykhh56OJMCxrnuEqgB2llS/c6ADkSvLU2P3AfVhwbtjE1LzniXjB0
         wOHgnAz5KmrYmORdfMQJPAQNKKjs3coDGuryul0BNX4a6RvWRltuj3AD6hq+HGlIrael
         dxZ8Dj3pW4bkFKsXVBTCST/QH6mpNbdRkuJIo6v8y/VtHFYpCoM5NWGTkRTOq2tL8GAG
         vdGkuOrgrQklm17FrHTkOY9Af0Z99XCzHD78tXLBltDZGECBtPNrhlcCBkWuF7fr5obd
         Soci5IZY5quoWZYWSR7lfBXTIc/auncd1xexDWs3z4E8bRbGpwoYJwivuJyb6zG49Ern
         m61g==
X-Forwarded-Encrypted: i=1; AL+hErF4vfAM0p/Rcdx87djrUxTu9cb4x8vKVvX8OfHjv0G+LXJZBk4/J0blpBsJzIAlr/1mUEY2gj0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OdNpVUFe0HHm5N2DpIN3XqF00iFdoVqPitlKx1fyWVSF1Bsaw
	qCo5qrVa9sdK/5E2cop57YIY0mDJeG906G4aTvkr1B+gnRGMW0DW8tIV
X-Gm-Gg: AZFdTZe4iI//nIF2ECwXzEbet2vSg3w7GEMRwf6vGkGoyR6j6nRyr7nRNm030mRWwGC
	mTtlFZTvbpBsDN1iS0o73h8dwVv9/0GsqDX4iHf5yHSrRozpfIQq123Ha/5h/WjAQHRc+k8Veso
	tbdmY+8YZnZGlpIAAJMzl6mEjTJ6KJ1TumfmlKFEa/VV/3ernp7idD4xjCh8xcYu9c6PY92nqto
	r6MnsDOhGzHVW2DTG4hcfDseQsMISwJDCcHGkyBQ6IvpL+aUSv17W/PVM2Uj4CT5/FOiO5HV93u
	GvSXzqJS7T3OdeseoyfmFeqTE4RRMPOraQ+TDLMJn8LvnRVECeBN/HjnLdraYNieFWsM/e5nS7J
	rNo+orfiPaCiHsqr7jIAsIDQoTqpjJZtXSkWXrsvuFaRe4SYpGtJkSJVSHNUyPJ5yQuWWcboZlY
	p0wnLmhFAk1RLUpzMI6WGDZulm8NwqMSpBN0UPvnPuIWqUjP6QK1oxuAp6UspeYDF5oCj2NoMEZ
	hh9J9IUxxDDUOHHeSRtcq2rEky+sl9MSMsRIh89y8qQFLP2tFJiGss82ZPd5Lau8RUVdS+cLMLT
	51N2MGEGvWGZ6P4+UnPmz29c4Q==
X-Received: by 2002:a05:600c:5493:b0:4a2:8c5:5e5 with SMTP id 5b1f17b1804b1-4bb8881c734mr412295055e9.7.1795646565114;
        Wed, 25 Nov 2026 14:42:45 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm544402355e9.5.2026.11.25.14.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 14:42:44 -0800 (PST)
Message-ID: <b7c6eafc-43ef-4434-8423-fc8733911571@gmail.com>
Date: Wed, 25 Nov 2026 23:42:43 +0100
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
Subject: Re: [PATCH v2] mm/rmap: avoid reusing batched TLB flush generations
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Ying Huang <huang.ying.caritas@gmail.com>
Cc: linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
 linux-riscv@lists.infradead.org, stable@vger.kernel.org,
 Kirk Swidowski <swidowski@google.com>,
 Huang Ying <ying.huang@linux.alibaba.com>
References: <20261125-rmap-v2-1-0ba817662eac@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261125-rmap-v2-1-0ba817662eac@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 10:34 AM, David Hildenbrand (Arm) wrote:
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

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
