Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793332554;
	b=MMK2/7HUCZffG7CuV2Bc9t86P+OdV3c0EjClNVHlZZw+reUR5U6rb6/MJj0mcebC349f
	 ToRe6yvZ4s+eF9mlnTjhkCYd7Xsi2WIwkZD9m/lMdXKx63BxwDyfpXAUAGf4HOjq1Ciyu
	 21RUKHNg/5CIx9zYsJDD8Pv/eTHVcU34YtIwB8FQyPmowQhzVImNrPOWsV3ECMUOzFQa2
	 w/nWkXE9wh9mfuOQUlxzcJTaF7tbc+0rELPASFcRPXv/T+v9Le6HCsnyK3YzaqqCrUWob
	 MJLZqX1F4rjH1LwdStSreNH8qyK5e7yPTlHjcYFw2dKcEZtVuvAPntL3LHiNs+laWRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793332554;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ey3vPsJ2dQFhz2BxI4N3mBDHBT7ectNl9BIu9ANR89g=;
	b=0NG+jKR+2RY4jYnhmTiTqR0JHjah2euRY0dlQa4tOLF35+oCj79ssWrfJEjoS0VNv2Ah
	 iw1C/f/yMj54DV3WtTM5vaqwUNUOJ6xrYpwiS7MT15y0/Gb56voCEDGib3EWcKfhe7pa2
	 A/0L4kE9UPhTpUHC4W6CLKJQ/JNGbGig2Z8NYXP2wXGq2sRRrNx6Qr7J743TaSJ9BhXPP
	 sKc8MpKl9v3zTMAfjK5ut4lvsfUyzXDOA8MuprkEe4mZFU5LbpVm7tIrgobRt+aJX6bPU
	 oISkElcY3R6qpyHCHCmlM9mlL80PK+17bUpNnPLNL4HeYx6I2eDlPMmFzTQM2mcXPNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vhd9hkG2;
	arc=none smtp.remote-ip=91.218.175.33
Received: from mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00041606A322
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 03:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00041606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vhd9hkG2
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=U6aEVcyx4cbsQT0ReFIAsX7642J2D1rQ7p5hav7hVYg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793332546; v=1; x=1793937346;
 b=vhd9hkG2nOm1ut6rmXBAumWp/tHKMlW3zjZCCnOvGI1nsCETxLY1hnQ+VXAebOqyqLNP2oO0
 i5lWDnZPKoA32cy7fX/4ShHMGlAAeYNH2KLWQJusKMmkCE2menaoxtuSFIAH8/lfuEwtJU4aX3S
 Ln296bZBOxGQ5C9IvNj4v/X4=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 29251291072b5e95;
	Fri, 30 Oct 2026 03:55:20 +0000
X-Mizu-Trace-ID: 29251291072b5e95
X-Migadu-Flow: FLOW_OUT
From: xu.xin@linux.dev
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	harry@kernel.org,
	hughd@google.com,
	jack@suse.cz,
	jannh@google.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	kasong@tencent.com,
	kees@kernel.org,
	kexec@lists.infradead.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mason@kernel.org,
	matthew.brost@intel.com,
	mhocko@kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	muchun.song@linux.dev,
	nico.pache@linux.dev,
	nphamcs@gmail.com,
	npiggin@gmail.com,
	osalvador@suse.de,
	pasha.tatashin@soleen.com,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	pratyush@kernel.org,
	qi.zheng@linux.dev,
	rakie.kim@sk.com,
	riel@surriel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	stable@vger.kernel.org,
	surenb@google.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	weixugc@google.com,
	will@kernel.org,
	willy@infradead.org,
	xu.xin@linux.dev,
	ying.huang@linux.alibaba.com,
	youngjun.park@lge.com,
	yuanchu@google.com,
	ziy@nvidia.com
Subject: Re: [PATCH 39/46] mm/ksm: fix use of a freed anon_vma at swap-in
Date: Fri, 30 Oct 2026 11:54:47 +0800
Message-Id: <20261030035447.140856-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027-fixes_core-v1-39-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-39-6f74bec9a5bb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> A folio read from a swap slot previously shared by KSM can remain in the
> swap cache after the process that first mapped it exits. Its anon_vma
> can then be freed, so ksm_might_need_to_copy() must not dereference it
> to compare roots.
> 
> Doing so can result in some false-positives, resulting in the reverse
> mapping missing the new folio mapping, preventing migration and reclaim.
> 
> SLAB_TYPESAFE_BY_RCU allows individual anon_vma objects to be reused
> immediately after freeing. A stale pointer can then refer to another
> anon_vma whose root matches, even though the target VMA is not linked
> to that anon_vma.
> 
> Move the anonymous rmap compatibility checks into
> folio_anon_rmap_compatible(). Keep the page-index check and compare the
> folio's anon_vma pointer against the VMA's own anon_vma and root first.
> 
> If neither matches, bite the bullet and walk the VMA's anon_vma_chain.
> The VMA keeps these anon_vmas alive, and finding a match guarantees that
> reverse mapping can find the new mapping.
> 
> Lorenzo Stoakes says in a private discussion:
> 
>   "This isn't quite equivalent to the existing check.
> 
>   Every anon_vma in an anon_vma_chain shares the same root, but if you
>   split a VMA then fork both of them like this:
> 
>                   VMA A
>                /        \         <split>
>             VMA B      VMA C
>                \        /
>         root <- anon_vma 1
>                ----^ ^----        <fork>
>               /   parent  \
>         anon_vma 2   anon_vma 3
>              |            |
>            VMA D        VMA E
> 
>   VMA's D and E both get their own new
>   anon_vma's such that:
> 
>   VMA D: anon_vma 2 -> anon_vma 1 -> root
>   VMA E: anon_vma 3 -> anon_vma 1 -> root
> 
>   And if you found a folio referencing anon_vma 2, the existing check:
> 
> 	anon_vma->root == vma->anon-vma->root
> 
>   Would be true for VMA's B, C, D & E.
> 
>   However after your change it'd be true for VMA D only, as it's the only
>   one with anon_vma 2 in its anon_vma_chain.
> 
>   Whether or not that could actually happen in practice... 🙂 I don't
>   know.
> 
>   [...] after your change it'd be true for VMA D only, as it's the only
>   one with anon_vma 2 in its anon_vma_chain. [...] I would [...] say that
>   you are making the test stricter but more correct.
> "
> 
> If this affects performance when KSM was never even involved, we could
> just track whether KSM ever merged anything and just skip these checks.
> 
> There isn't really a lot we can do otherwise: for mapped folios we might
> be able to use folio_get_anon_vma(), but for unmapped folios there really
> is no easy way to see if the anon_vma is still valid.
> 
> Document the (confusing) lifetime requirements of folio_anon_vma().
> 
> Fixes: ba6f0ff3981e ("ksm: fix ksm swapin time optimization")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/ksm.c  | 36 +++++++++++++++++++++++++++++++-----
>  mm/util.c | 13 +++++++++++++
>  2 files changed, 44 insertions(+), 5 deletions(-)

Acked-by: Xu Xin <xu.xin@linux.dev>
