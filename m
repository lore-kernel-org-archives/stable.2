Received: from mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151733CF1F6
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787641966; cv=none; b=WBSnb/ySGs5ngIkmvuJhNvvrwATnjTilS+4ExSFGWLykazstN31b6SnSYrdx0Ecz8lj5c2yVeGutCsio7oRPKbzilfUZ4xE8j+mj0t4rB/I6joJ0g2Dv0AEjik79e2ipU6/6syKY3vdkVV3lBVvgmPIc+/2guFIkW/EDCmtqhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787641966; c=relaxed/simple;
	bh=vrqAFbQm5tBczLY4hb4nFOlOxMC1/kc+DDXxwinK16Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyhTf4AAvP04R+v8zOiFXkhKOArYKSfka6LXvaCHEsBN1zqIe70ZYvlSWfJXmxyWp/BWfLxXjHvMZg5cZAnOvRUcn3HbBscd2hHEk/XFcQNCRRfJ/YKluWh5AQioGgEVVYSZUIt0z1yP0uVujTnC6DgawZ1obwbT35XIu1cmv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RZ2vBCYU; arc=none smtp.client-ip=91.218.175.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RZ2vBCYU"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vrqAFbQm5tBczLY4hb4nFOlOxMC1/kc+DDXxwinK16Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787641961; v=1; x=1788246761;
 b=RZ2vBCYUJdlQ2ouUbpplBqf0V0IfdZLhmUhRPBFubqs5J7C1o2Tl/sLF4DvU+JPz3goGPA4R
 RSBGovrjrO7ZisJXlZQiZkwYt42mBOr1XRwPC7WU1sU6cVt7G1eSIrfHWh2tFlOetQZGPNxIwu5
 EOiCcFpU4qevjltscGqgZmaE=
X-Envelope-To: stable@vger.kernel.org
Received: from [IPV6:2620:10d:c085:21d6::12f9] (2620:10d:c090:400::5:e4ca)
	by smtp.migadu.com with ESMTPS id 29ba699e53c601c6;
	Tue, 25 Aug 2026 07:12:41 +0000
X-Mizu-Trace-ID: 29ba699e53c601c6
X-Migadu-Flow: FLOW_OUT
Message-ID: <556337a8-5e2b-45fe-a1ba-90a90c1f3c4d@linux.dev>
Date: Tue, 25 Aug 2026 00:12:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] x86/mm/pat: CPA fixes
To: Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>,
 Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Pedro Falcato <pfalcato@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Steffen Dirkwinkel <lists@steffen.cc>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org, syzbot@syzkaller.appspotmail.com, x86@kernel.org
References: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
Content-Language: en-US
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/13/26 2:01 AM, Mike Rapoport wrote:
> The first three patches are urgent, the third patch fixes BUG() reported
> y several people and it depends on the first two.
>
> There were no bug reports that the last two patches fix because bug
> manifestations won't yell at users.
>
> TL;DR version:
>
> There are a couple of CPA fixes floating around:
>
> Denis Lunev fixed races between split and collapse of the large mappings:
>
> https://lore.kernel.org/all/20260715183453.2381141-1-den@openvz.org
>
> Lorenzo Stoakes fixed UAF caused by races between CPA and ptdump:
>
> https://lore.kernel.org/all/20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org
>
> and an issue with stale page tables in IOMMU:
>
> https://lore.kernel.org/all/20260721-fix-cpa-kernel-pagetables-v2-1-2b255deed710@kernel.org
>
> Mike Rapoport fixed a check of RW attribute in lookup_address_in_pgd_attr()
> used for the verification of RWX:
>
> https://lore.kernel.org/all/20260715144519.934289-1-rppt@kernel.org
>
> Pedro Falcato closed a race between text poking and collapse of large
> pages:
>
> https://lore.kernel.org/all/anCK3eWFMwZqq5ka@pedro-suse
>
> Some of the fixes got merged into x86 tree, some of them got merged into mm
> tree and some are still hanging in the air.
>
> The changes here are collected from all these fixes into a single coherent
> set on top of tip/x86/mm:
>   
> * fix for races between CPA and ptdump causing UAF
> * update to the fix of the race between split and collapse of large
>    mappings
> * fix for races between CPA and vmalloc_to_page() in text poking
> * fix for stale page tables in IOMMU
> * fix for effective RW computation in lookup_address_in_pgd_attr()
>
> ---
> v2 changes:
> * rebased on the current tip/x86/mm that includes peterz's changes for
>    DEBUG_PAGEALLOC
> * added fix for CPA vs text poking race
>
> v1: https://patch.msgid.link/20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org
>
> ---
> Lorenzo Stoakes (ARM) (3):
>        x86/mm/pat: acquire init_mm write lock on collapse to avoid UAF
>        x86/mm/pat: acquire init_mm read lock on attribute change to avoid UAF
>        x86/mm/pat: allocate split page tables as kernel page tables
>
> Mike Rapoport (Microsoft) (1):
>        x86/mm/pat: fix effective RW computation in lookup_address_in_pgd_attr()
>
> Pedro Falcato (1):
>        x86/alternative: exclude text poking against change_page_attr()
>
>   arch/x86/kernel/alternative.c | 39 ++++++++++++++++++++++++---
>   arch/x86/mm/pat/set_memory.c  | 61 +++++++++++++++++++++++++++++++------------
>   include/linux/mmap_lock.h     |  2 ++
>   3 files changed, 83 insertions(+), 19 deletions(-)
> ---
> base-commit: 7da514d819a0afb148634aac92b3d190f34947c3
> change-id: 20260727-cpa-fixes-d3c73c075672

Reproduced and verified this series (patches 1-3) on 4vcpu guest running two different kernels
1. mainline (commit: 77ae27fd98f3)
2. Ubuntu Resolute 7.0.0-26 (production kernel hitting the issue in a VM)

The Reproducer consisted of
1. A debug patch a cmdline-gated stall between the two *pmd reads in vmalloc_to_page()
2. One taskset-pinned insmod/rmmod worker per module over stock cfg80211/dummy/veth modules

With the above reproducer, both BUG within seconds in unpatched kernel.
1. Resolute in 0.71s at alternative.c:2564 (BUG_ON(!pages[0] ...), RAX=0)
2. mainline at alternative.c:2473 (BUG_ON(memcmp(addr, src, len))).

With patches 1-3: zero splats across 10 runs each (600s/11,378 module load/unload cycles on mainline and 1200s/55,980 module load/unload cycles on Resolute).


Tested-by: Atish Patra<atishp@meta.com>

> --
> Sincerely yours,
> Mike.
>
