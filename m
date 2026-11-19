Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107652;
	b=EIknIrrOhrCSuGyMP0iScEcGA9tMCkDVuEY612pdYPrs7j9rO6y8jHTuNbhHO5awsgW8
	 HD4KvhT29JOlVwDYhegvWcuSUTD8YZbkfIYZPOvyw0BLZj56bhxU7jy7EEwHmRs9UpJMs
	 lEL98CJec8F1P2kCdkQQskmzLqWjwkGlwfMkMoe1fe3l0l/3zNrFzIxFe9i17wqAQ4mrP
	 D104hrYSuTchqEXB53igEvkSsF2d2THdvmX6av6F24nzS3PvlhptSPDdYXS39iDlTQWcw
	 19R2fSuZCDWhmcHJPprJ1qfTJ2u7yF40W1fH32i0fo3wYSuRiD8yYzJjNe0lt76f+aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107652;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZAGuNfK4PGkEBhiPgllG38LiVsfLG3yw/JzSv5KJ1FY=;
	b=2KAGlMD+KUYrav0uALPELv0OZOJOv7/3HtyCn4UXuuPUOnvEOyF28khQS0lyxUJ5WkxW
	 uSECpm+rVxg1Ny7Y7XUJ9u03grNHLjY1R4YbV7pEXvu5zVZPgqcHD9CttbVI8xLh6auPr
	 qVB+7ObExPde6D4eLLZaFPILTw5eJtudyEtlTcvZaACcQirHPBopNV73stXDD0gMGJO4m
	 5i8FsASEngiyc7bvxcO0I99EUyjVi+FoG2JXVQ9/uHyZg5Dh8Bnmk4aFMo5OhJoLXo7vr
	 P9g17CGBR/Hq2hYW2+2sbVarstgMPXJ1GXSCB4Nd/0HDifPgbNrJxDHRLGQb1TL+Slw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=LkGb8lMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4A606A324;
	Thu, 19 Nov 2026 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=LkGb8lMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649FE1F000C4;
	Thu, 19 Nov 2026 17:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795107651;
	bh=ZAGuNfK4PGkEBhiPgllG38LiVsfLG3yw/JzSv5KJ1FY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LkGb8lMGrcmpPfcxmFdF4FwE6VN7ukOvtg016rCSOGbcS5HWRH58fh0XjLJyeXm30
	 tOBPIIZy6TPV3JEmcklLtPc/oax9XC0iKigQYdzgT6GaAy6I5XpCe3MVuEH6HhSjG8
	 kc0mE9oC7MNHp1oO0lIASjx9P4W2ZCLOwMgaT1CQ=
Date: Thu, 19 Nov 2026 09:00:50 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>, Miaohe Lin <linmiaohe@huawei.com>,
 Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Joao Martins <joao.m.martins@oracle.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Sashiko <sashiko-bot@kernel.org>, Jiaqi Yan <jiaqiyan@google.com>,
 "Jose A . Perez de Azpillaga" <azpijr@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] mm/hugetlb_vmemmap: Fix HVO races and deadlock
Message-Id: <20261119090050.6858fd2871d2756c6d3c809a@linux-foundation.org>
In-Reply-To: <20261114112523.75208-1-songmuchun@bytedance.com>
References: <20261114112523.75208-1-songmuchun@bytedance.com>
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

On Sat, 14 Nov 2026 19:25:20 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> This series fixes three HVO issues reported by Sashiko.
> 
> The first patch serializes HWPoison updates and removal against HVO
> remapping so raw_hwp_page state cannot be lost or freed while a
> replacement vmemmap head page is being installed. The second patch uses
> an HVO-private rwsem to prevent deferred PMD splits from racing with PTE
> remapping before the TLB flush. The last patch switches the vmemmap walk
> to the lockless walker so a PMD split allocation cannot recurse into
> init_mm.mmap_lock through reclaim.
> 

Thanks, tested in a VM.  The series did everything it claimed to do and
the LLM couldn't fid a way to break it.

Tested-by: Andrew Morton <akpm@linux-foundation.org>


: I tested the three patches in x86-64 QEMU guests. A had the series
: removed; B had it applied. Both used the same kernel configuration and
: fresh boots. The main tests used four CPUs, two NUMA nodes, 8 GiB RAM
: and 2 MiB HugeTLB pages. I added the same temporary delays and log
: messages to A and B, guarded by the test processes' current->comm, so
: other processes did not take those delays.
: 
: [1/3] mm/hugetlb_vmemmap: fix HWPoison state races during optimization
: 
: I put a three-second pause immediately after HVO copied the vmemmap
: head, then poisoned a tail page during that pause. On A, the HWPoison
: state was lost and the huge page remained in the free pool; B kept it
: out. Poisoning the last 4 KiB tail page gave the same result. For the
: reverse race, I also paused before the copy to poison the page, then
: unpoisoned it during the post-copy pause. A left stale HWPoison flags
: on the head and tail; B cleared them.
: 
: [2/3] mm/hugetlb_vmemmap: fix PMD split TLB flush race
: 
: I put a three-second pause immediately before the deferred
: flush_tlb_all(), after the split PMDs had been published. During that
: pause, separate processes allocated huge pages in the affected range.
: Temporary log messages recorded the old and new backing PFNs at each
: remap. A changed PTE mappings before the flush; B did not. Four
: simultaneous allocations repeated the early remapping on A across
: both split PMD ranges. I did not observe a processor using a stale
: TLB entry.
: 
: [3/3] mm/hugetlb_vmemmap: fix deadlock during PMD split
: 
: This test used a separate four-CPU, one-node, 4 GiB QEMU guest. An
: emulated QXL device initialized TTM. Because QXL's own pages were
: cached, a small test module used TTM's page-pool interfaces to return
: 512 write-combined pages to its pool. A process held about 2.5 GiB
: of guest memory.
: 
: I created an init_mm.mmap_lock writer before HVO entered the PMD
: split. At the split, I released that writer, paused for 300 ms to let
: it wait on the lock, then called TTM's actual shrinker from the HVO
: task. A reached set_pages_wb() and blocked trying to take
: init_mm.mmap_lock; the huge-page allocation did not finish. On B,
: the writer completed, the shrinker freed the pool pages, and the
: allocation finished. The shrinker call was forced at this point.
: This tests TTM's page-freeing path and the lock order, but does not
: show that ordinary reclaim would select TTM at that instant.
