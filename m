Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FD541E7B
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993237; cv=none; b=NAkNt28+8P7K8Y46FEZrLR8GVEL4Z/G8F0eFLB/dFgLuFtSQCQh4vToY3E6Y4XZBhuop7NstfiZkSvfm607bRp9YAlciM1PbNmztO0iYEbIK2mAGuMe3VCm87/H6wh9TcGXK9L/L/cgPZNJuftd9ncih4ECWcgj2ATg6JpjX2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993237; c=relaxed/simple;
	bh=p+hCb4x/CFHYwH9yYx44YPMASd0huLS2Y6U4//JRKyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLtETN1HZCa+Woh8jEovurLLGhUKZBsKaVwv+XF88ymrgUFmqtSIpyOK3EmC3wgUR01bgtNB/daTfwjCEn7rhCnynK17kyRv4N19+sOTRAze7JKU2VERnSzpuFT6+LQq4U34MlJklFEuQK2W1CtrHsjN5eRWb1st9rKbokRmS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JWi6jDbf; arc=none smtp.client-ip=91.218.175.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JWi6jDbf"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p+hCb4x/CFHYwH9yYx44YPMASd0huLS2Y6U4//JRKyY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791993233; v=1; x=1792598033;
 b=JWi6jDbfkkiKxiJT+LNK+N0Q+ku06M+R0Wt1SskBPpelXFgsycEMyt9XS+MnbE+g0eAtzfM5
 rx4gPrdptXFp19gddFYWNAAntyhOjzMPlku28voKkb+7jdNJAy1m5EOjiieen0tnIkLvW23aA66
 49GiVSVZKSJUk22pwJCXNiTY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4026790dd114785a;
	Wed, 14 Oct 2026 15:53:52 +0000
X-Mizu-Trace-ID: 4026790dd114785a
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	benh@kernel.crashing.org,
	a.p.zijlstra@chello.nl,
	riel@redhat.com,
	ngocthang2710.1999@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+49b1021becba70c1f3f6@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: disallow ioremap'ing ordinary RAM in generic_access_phys()
Date: Wed, 14 Oct 2026 23:53:41 +0800
Message-ID: <20261014155341.36130-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261013-generic_access_phys-v1-1-b3963ef76e37@kernel.org>
References: <20261013-generic_access_phys-v1-1-b3963ef76e37@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Oct 13, 2026 at 01:41:24PM +0200, David Hildenbrand (Arm) wrote:
>generic_access_phys() can end up getting called on CoW PFNMAP mappings,
>resulting in it trying to ioremap anonymous folios, which especially
>the x86 code doesn't enjoy, and which is in general just odd/wrong.
>
>E.g., with a CoW mapping of a PCI BAR:
>
>ioremap on RAM at 0x0000000045623000 - 0x0000000045623fff
>  WARNING: arch/x86/mm/ioremap.c:216 at __ioremap_caller.isra.0+0x4c2/0x5f0
>  Call Trace:
>   generic_access_phys+0x130/0x4d0 mm/memory.c:7178
>   kernfs_vma_access+0x1ce/0x280 fs/kernfs/file.c:437
>   __access_remote_vm+0x58f/0x890 mm/memory.c:7256
>   mem_rw+0x2a1/0x670 fs/proc/base.c:912
>
>But more generically, we should disallow access to anything that looks
>like ordinary RAM in the system: including allocating memory (e.g.,
>alloc_pages) and mapping them in a VM_PFNMAP.
>
>For pages with an online memmap, allow only pages marked as reserved
>(PageReserved). This also includes memblock allocations, however,
>distinguishing them from other MMIO is tricky, and nobody should really
>be mapping them in a PFNMAP (except someone abusing /dev/mem, which we
>do not care about).
>
>So only allow access if there is no online memmap, or if the pages are
>marked reserved. Reject other pages with -EINVAL.
>
>Note that, just like other pfn_to_online_page() users, we won't care about
>concurrent memory offlining; mapping memory that can concurrently get
>offlined is highly dubious.
>
>Reported-by: syzbot+49b1021becba70c1f3f6@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=49b1021becba70c1f3f6
>Reported-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
>Closes: https://lore.kernel.org/r/20261001152524.171115-1-ngocthang2710.1999@gmail.com/
>Fixes: 28b2ee20c7cb ("access_process_vm device memory infrastructure")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice work!

Tested-by: Lance Yang <lance.yang@linux.dev>
