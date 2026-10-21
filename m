Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627159;
	b=5B5GrWdehmvhdVpAyBgH/M2Y/JMK/ky0NA4QuXD2YCbMC/4MCp2RS8shpqI7ClcMRJ/H
	 Ww5l6IE1jTbyabV/8u39M3Id55Nr6j2iqW96mjDKga1lOLn6GP6kSHSBOZS7RHOtvbEVY
	 K43lIYtwHBpANeN60QA5v9rK9oR03dNYveHbfzjYeSQKSqcCS/8RtG7I1Rlf1xKLB7WrK
	 EEI6WRC/BfnO2YDFG4RFpdiT5fqW8uP6NrAu1ebLWjFhN2AFHIzaIM1ukDwl1kTuRSt8F
	 Qr54Nu3CmF0DoN8SSHshiaNl+fvDhYCuEPSjzNHEWOsRTISm/MnMZukBZFZy/b4dznQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627159;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ksEI+I5nWbgBGU6Al2imyLpHdZLmo2q8PfxF1UceYPU=;
	b=b56tb91CFT41gjeIj0DmFRiMLv3M1G8ubGtdXFnDgsnbyL5euk6UsgSaHBsiY6W4lgJf
	 E8walx8qXbY/uYu6rxgLPItSpP/A+B4Qv7cGDgNkBLWpvAEiFZ5PVFb4ExzF+oPHND66R
	 2HT49sA0gRkMsZT5MyudrY36cjhTwu4ZmRqEOjbuDMhE9kqquF7GolEgU2+K8GRYVL0O/
	 e1MtyJYjmRGyFfg/UHTLLzK3N5TsFiFhrzO9bTcn+QJq35Qlfh8SbEbF9v1BdeFETfR6a
	 Xr0sAtvyD6uppuTTzVAEiJI5whVJXuks39xhZm9sTeXAOVHX9Q/Jt8ShtznRBR3hYFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=0xYKEwSB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7562B606A31A;
	Wed, 21 Oct 2026 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=0xYKEwSB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0F11F000C1;
	Wed, 21 Oct 2026 23:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792627158;
	bh=ksEI+I5nWbgBGU6Al2imyLpHdZLmo2q8PfxF1UceYPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=0xYKEwSBu66dnnJ9HcvJasewpGZc84uS97nT6nqlUpEiIGU4UO4F9Yx5Lpy95VaXw
	 bT5j8IbaUvNr7+0bTwVoQv+E0xBT/Uccgz3hCrqURvefxtS8IxXKoE4D/qvgV3JtrJ
	 xXtcvhf2Cvz4ppddQdBQ+/CgxdCgSlx+zS5UQNKw=
Date: Wed, 21 Oct 2026 16:59:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hongfu Li <hongfu.li@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Steve Sistare <steven.sistare@oracle.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hongfu Li
 <lihongfu@kylinos.cn>, stable@vger.kernel.org, Daehyeon Ko
 <4ncienth@gmail.com>
Subject: Re: [PATCH] mm/hugetlb: charge hugetlb cgroup and memcg in
 alloc_hugetlb_folio_reserve()
Message-Id: <20261021165918.da553bb0879c110847c232f5@linux-foundation.org>
In-Reply-To: <20261020-for-alloc_hugetlb-1020-v1-1-e6eac82dd754@kylinos.cn>
References: <20261020-for-alloc_hugetlb-1020-v1-1-e6eac82dd754@kylinos.cn>
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

On Tue, 20 Oct 2026 16:46:30 +0800 Hongfu Li <hongfu.li@linux.dev> wrote:

> From: Hongfu Li <lihongfu@kylinos.cn>
> 
> alloc_hugetlb_folio_reserve() hands out a folio from the hugetlb pool and
> consumes a global reservation, but unlike the fault path it never charged
> the folio to the hugetlb cgroup or to the memcg.  Folios allocated for
> memfd_pin_folios() through memfd_alloc_folio() were therefore silently
> bypassing the accounting: they are never charged to the hugetlb cgroup
> usage counter (hugetlb.<size>.current) nor to the memcg (memory.current),
> so both limits (hugetlb.<size>.max, memory.max) are bypassed.
> 
> Charge the folios to both the hugetlb cgroup and the memcg, just like
> hugetlb_alloc_folio() does.
> 
> Test with a process that creates a hugetlb memfd and pins pages through
> UDMABUF_CREATE. The counters were read while the folio was still pinned:
> 
> Before this patch:
> $ echo $$ > /sys/fs/cgroup/test/cgroup.procs
> $ ./memfd-alloc-folio 1 &
> $ cat /sys/fs/cgroup/test/hugetlb.2MB.current
> 0
> $ cat /sys/fs/cgroup/test/memory.current
> 1351680
> $
> 
> After this patch:
> $ echo $$ > /sys/fs/cgroup/test/cgroup.procs
> $ ./memfd-alloc-folio 1 &
> $ cat /sys/fs/cgroup/test/hugetlb.2MB.current
> 2097152
> $ cat /sys/fs/cgroup/test/memory.current
> 3313664
> $

Thanks.  The before-and-after output is useful.

However there are potential interactions with Daehyeon Ko's
"mm/hugetlb_cgroup: prevent use-after-free during cgroup offlining". 
https://lore.kernel.org/20261020100345.1677643-1-4ncienth@gmail.com

Your patch adds another caller of hugetlb_cgroup_charge_cgroup(), which
has the cgroup-offlining CSS lifetime race addressed by Daehyeon Ko's
fix.

An existing memfd reservation can belong to cgroup A while the task
pinning the folio belongs to cgroup B. A's reservation CSS reference
does not protect B's usage CSS across charge and commit.

Also, the accounting bypass predates 26a8ea80929c.  The original
memfd_pin_folios() implementation already used an uncharged allocator,
so the Fixes tag should reference 89c1905d9c14 instead.

The memory.max claim should be qualified: HugeTLB accounting in memcg
is conditional on the cgroup v2 hierarchy's accounting configuration.

Daehyeon's fix is in the pipeline at present, awaiting a minor fixup
and maintainer review.  Everything is rather swamped at present.

So please assume that Daehyeon's fix is present and rethink your fix on
top of that?

