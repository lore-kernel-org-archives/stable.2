Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556475;
	b=RkrRtcIwDli5Tb7OatMU4vG5dtauaClF5F4WBU/l5JiY46gKC5s2XWWpi2JyI9lRIxRR
	 iL1j0mmNZxBAep81TlfuhEQ5kihE85XZCxTBFynkDekhvrXLR2ENBxzAtlQ53MJs4UVoF
	 tdZA3frrc2xgZIIrOy+4wpLdSwMdVqHpXqq4D0l20VVg+mJF3jfV3SS0/We3KeLGuMa3J
	 rT8+/kRWmHwCsJxSMFr2F8HAHqtonV0CPb1HAW83FoYTYsA1OPE3NoIyqlGXEJEfxhbOm
	 IR7fJ8GU9bn+nH6pMCiP6N84PIQbT5DeWf91jvK1fWcF36tr9ta/zEAVDLr5WLh4XqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556475;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wtVX074xn4Ax9Ym2W5G9udDOf7jc7SoXAtiT9SubY18=;
	b=uEJbrJLU9m2w68KNEI7WL9YZVYAXRYI70pyEywBOrBAFqnh8M3cA7qWXlyHPRYSpNp80
	 yYMCgJpitcMy1CDMsiWdjrrTUpmwhbHnqxsdDRfBz+/ZfepBqQkRkanf+sI5KfbAUIHrg
	 LA38CIy0p+S9z3RQd550KaKc+hRqgZjZKuyIvUw+kAsWZjbkhnYt50Z3NZdDewHYhOvob
	 ELC8MxHmt6hrp0H3SLKtT+FtYQ3pgubDQNIl5M7U+CZI4sNd9OEWwp4p8oxPAxfcPXTq2
	 jyePAagXZbEog85Ar3tCGsQniQQOOgfNd+Ddgk7+GEqD+stBg+PVonEndqpMXlVpeRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1TzP+oE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FF2606A324;
	Sun,  1 Nov 2026 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1TzP+oE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB141F000C1;
	Sun,  1 Nov 2026 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793556474;
	bh=wtVX074xn4Ax9Ym2W5G9udDOf7jc7SoXAtiT9SubY18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h1TzP+oEyvUummX3FBrsaDg6F/T4dtjOssjippILdgLc7Pshpgl+k71VVqaBz6gjZ
	 00qb4JZ7RpQTw0jGCW58RLWfO0T5DtrzR6+rMbQoflSGjSFxieCo+wMTb+EJjHvCi5
	 eIQtv8k/EQhMV6LSRI7w+VcB8+BQz/JoJ0xXSate5ZZjFePTzGCy21AkAtA0p9FizX
	 oXzFJvR08nY5j30ATR+qwIwRpHL1JHdIHYUoH6sbE1KL/lCb78SSctsV9H1wDwCQ49
	 DOqFTmi2w9Ews2UgoYCcuMGExZtqCXiMR5A6SVQ6/GPcu92wLeFjhk3KCkrIXrwD7I
	 lDYKLzlxbvAqA==
Message-ID: <54617273-262f-4e17-b912-8b07113ca45c@kernel.org>
Date: Sun, 1 Nov 2026 19:07:49 +0100
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
Subject: Re: [PATCH] fs/proc/task_mmu: check THP exclusivity for each subpage
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: "Liam R . Howlett" <liam@infradead.org>, Lorenzo Stoakes
 <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <4c1b393a4b04bd94e4f1c7879ae04e1793eb0931.1793552446.git.zhangxp1998@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <4c1b393a4b04bd94e4f1c7879ae04e1793eb0931.1793552446.git.zhangxp1998@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/26 18:01, Kelvin Zhang wrote:
> A PMD-mapped THP can contain subpages with different mapcounts. For
> example, after fork(), the child can unmap only part of the THP. The
> parent retains its PMD mapping, while the remaining child mappings
> are PTE mappings.
> 
> pagemap_pmd_range_thp() passes the same initial page to
> __folio_page_mapped_exclusively() for every pagemap entry. With
> CONFIG_PAGE_MAPCOUNT=y, this applies the first subpage's exclusivity
> to all entries, falsely setting or clearing PM_MMAP_EXCLUSIVE for
> subpages with different sharing.
> 
> Pass page + idx to check the subpage corresponding to each entry, as
> was done before converting to __folio_page_mapped_exclusively(). The
> index already accounts for reads starting partway through the PMD.
> The conservative whole-folio check without CONFIG_PAGE_MAPCOUNT is
> unchanged.
> 
> Fixes: eb16876971ea ("fs/proc/task_mmu: remove per-page mapcount dependency for PM_MMAP_EXCLUSIVE (CONFIG_NO_PAGE_MAPCOUNT)")
> Cc: stable@vger.kernel.org # 6.15+
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
> ---
> Tested on x86-64 under QEMU/KVM with CONFIG_TRANSPARENT_HUGEPAGE=y
> and CONFIG_PAGE_MAPCOUNT=y, using the same test binary before and after
> this change. After fork(), the child unmaps the first, second, middle,
> or last 4 KiB subpage, while the parent retains a PMD mapping. Both
> bulk pagemap reads and reads starting inside the PMD are checked.
> 
> Across three repetitions (12 cases), the unmodified kernel fails 24 of
> 84 assertions; with this change all 84 pass. Fully private and fully
> shared PMD controls pass before and after the fix.
> 

How was this found. Through an LLM or because there was actually a problem in
practice?

Why do you care about this information to be reliable.

If the answer is "I don't care, I don't care, an LLM reported so I blindly
submit a fix" we might just perform the switch to the CONFIG_NO_PAGE_MAPCOUNT
variant directly.


https://lore.kernel.org/linux-mm/20260412-mapcount-v1-4-05e8dfab52e0@kernel.org/

-- 
Cheers,

David
