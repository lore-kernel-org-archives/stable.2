Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794075613;
	b=Z254vagHYxMsGdBYzIMiod7eP0qhY/965+DhgD8j0cUvfAKp72SnTE9BD6JO8o0lbvnn
	 HdlmATQu7l+z9Yc+7EUi8UAxaFwBUJrC5rMoe1etMS4V9XH4gxy4kUnE9oeWQFxZm8cx/
	 R9lpB7DKavlDYjVU7ywG7iIJvvX2m8D/iJsGvdkO7y5agHSES0YCgthrlEg3eAEH2TezF
	 9dJyW6rV+FeLaEUcoMKQFyg9nFoL4K5/v6FPaYnhDWGfpLktnzxQfxfhCTfLIVhipdee7
	 pkbFw8JMymL9rKSQ6uWg3eRvczgp1fFe9hiaeKfOkJsw37k2TiXlCOhzVKs8qJsclyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794075613;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=1pjnHje6Qb1kHlz8WaN4eNa2MT/clIj+haAeBAgYG+k=;
	b=MtCgYEs3KG18zItevMV0i479iEKg+BPjMn4VnhG/QjKDoHfu/kuv/LqyzGSb7NU55bVt
	 7xbNgrhA5kikjzZMKe6pGhlvuNcJwK93whaJp1QEGV+RSuzuO/LkmA2FVjWU30Nw65LR1
	 ZGsAcsDUsESZzVBQTyElj6IkRgtfE95YE8N+SM8wm3RtNhdrsYB/dA8xOOZpf7ErYGsxQ
	 WIIVFqg8R/L9Vac5QYv7QOTItT80a3Uf6tOqHLRjSpuYjPr4rbhwxvC23DvbeI9upKPsB
	 4ebZ3IzYQNjaTPR8SpzfUzUnip2j3tY0jPcLs88bKgU8jl9xofcEUfuRN3MbkfYv5zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1sYa023;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F7606A326;
	Sat,  7 Nov 2026 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1sYa023
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0C21F0089F;
	Sat,  7 Nov 2026 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794075612;
	bh=1pjnHje6Qb1kHlz8WaN4eNa2MT/clIj+haAeBAgYG+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C1sYa023IOebqDzktccEL/GnqdyMhlnIn18DNUC1Sgtp9yv+XhSCgYpBawdgnNPGJ
	 1jmy08jxGm7xQR2DKYEEO9QPKbm2XQU3r1B6N5nBPd4HMWoU+CLSk9mGC3982NUaYj
	 0WEc5R8QPvn/ArI2m14ey2IbiN5/k/GUKWBYoD7IV96S6YDdd3ctTYzroOtVACDTPn
	 kCLsaKsYERXgamn3Tv2at/jQX1x0iPX4Pp8A4dLYVt25eXkKVSqioBAPcwYkpQgKy4
	 PHJHTdaktocbt0gsWvH+P9L7jyt0OWP9th65AJD+QgiWizezgsGd0MHJDlQm91ilHr
	 mScwirajJmJQQ==
Message-ID: <af5ad990-bae9-4bdf-9109-1ac3e6c15e94@kernel.org>
Date: Sat, 7 Nov 2026 19:20:03 +0100
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
Subject: Re: [PATCH] mm/migrate: fix softlockup in do_pages_move() with huge
 page arrays
To: shao.mingyin@zte.com.cn, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261107213856462Jx8pIdgdtLvPLfOFTwV4X@zte.com.cn>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261107213856462Jx8pIdgdtLvPLfOFTwV4X@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 14:38, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> mm/migrate: fix softlockup in do_pages_move() with huge page arrays
> 
> do_pages_move() walks the user page array one page at a time.  For each
> entry it performs two get_user() calls, an mmap_read_lock()/unlock()
> around a folio walk, and an optional store_status(); none of them has to
> sleep when the arrays stay resident and the rwsem is uncontended.
> move_pages_and_store_status() returns early while the page list is
> empty, so an array whose entries all resolve to the same node can run
> the whole loop without any scheduling point.  nr_pages comes straight
> from move_pages(), so a huge array can hold a CPU past the watchdog
> threshold on a non-preemptible kernel; with KASAN and function tracing
> enabled, ten million entries can exceed it.
> 
> Add cond_resched() so that long calls yield periodically.
> do_pages_stat() has the same problem and is being fixed separately.  In
> current mainline only alpha, hexagon and classic m68k can still select
> PREEMPT_NONE, and they cannot enable CONFIG_NUMA, so this mainly
> targets pre-v7.0 stable kernels.

Please share a real kernel splat from a real system.

-- 
Cheers,

David
