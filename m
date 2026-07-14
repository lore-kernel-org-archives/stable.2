Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C33749F9
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001325; cv=none; b=amNzPaGPRTNSbgo5DoF0r+EC1LajbWzUB766FkCQrvvfPBz8XyzKSxYp/utCESgoojrUusNt2NT7dxXFB3NhWxLEZXopq80+MVAzSDd/y6EX9lOn0NLxleN4G/oAyGtI04BjAiSa5XRX70qZCvOiVw0y7vidM235HesVBpsj2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001325; c=relaxed/simple;
	bh=LIV2Dmxm/DZast0sm9DvkteGvraS2Zi6VKxnBDE5X8M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=u6v/XTm3oZzJw/ot1PjHqbNZh9tIFPAAHrM2EaqoykrkRwjyUIng1YXDXbkwWFDDWK8a65zpSOFiVQe4z9wHIxRS2dcyr+sUjU3dWZMZvDLiHmeR1LLVTteZvyJ+ETgA557ESkefKiZvN2lXewp0MkWAOxUOn0xqNeVlhl7reQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rp3sJxsE; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rp3sJxsE"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784001319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OeVWSaO4WQATBC/4qX0BBqStbi2xbbwcGw0Xf5MNwig=;
	b=rp3sJxsELk9vdzoluWh+F/6SnC38h5CF5R9Az5l/xYl8L7Xxz4B92u1aI4Ujic84MweDNn
	OMi8nZnmQ9fNO9JJHmBtcJWeea6LCYHXJofGuekUkmbm0nH19pK9yDAZpZtRXF0e66aKn/
	Yj21CvubIXCwcD8IBSd4rhHz6uW7xAk=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 1/2] mm/hugetlb: fix list corruption in
 allocate_file_region_entries()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260713171456.300518-2-caixiangfeng@bytedance.com>
Date: Tue, 14 Jul 2026 11:54:28 +0800
Cc: akpm@linux-foundation.org,
 osalvador@suse.de,
 david@kernel.org,
 richard.weiyang@linux.alibaba.com,
 baoquan.he@linux.dev,
 shuah@kernel.org,
 linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FB61ABB-6299-4EBE-93DC-BFAE855EE5F1@linux.dev>
References: <20260713171456.300518-1-caixiangfeng@bytedance.com>
 <20260713171456.300518-2-caixiangfeng@bytedance.com>
To: Xiangfeng Cai <caixiangfeng@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 14, 2026, at 01:14, Xiangfeng Cai <caixiangfeng@bytedance.com> =
wrote:
>=20
> allocate_file_region_entries() tops up resv->region_cache with freshly
> allocated file_region descriptors.  The allocation uses GFP_KERNEL, so
> resv->lock is dropped around it: the new entries are gathered on a
> stack-local list head, allocated_regions, and spliced into
> resv->region_cache once the lock is re-acquired.
>=20
> The splice used list_splice(), which moves the entries but does not
> re-initialize the source head, so allocated_regions is left pointing =
at an
> entry that now lives on resv->region_cache.  The top-up runs in a =
while
> loop that re-checks the cache deficit after re-acquiring the lock.  =
For a
> shared mapping the resv_map is shared by every mapper of the hugetlbfs
> inode, so a concurrent region_chg()/region_add()/region_del() on the =
same
> resv_map can consume cache entries during the unlocked window and =
force a
> second iteration.  That iteration calls list_add() on the stale head =
and
> corrupts the list; with CONFIG_DEBUG_LIST the __list_add_valid() check
> trips:
>=20
>  list_add corruption. next->prev should be prev (ffffc900011ff7f8),
>  but was ffff88814c281460. (next=3Dffff88814c545640).
>  kernel BUG at lib/list_debug.c:31!
>   allocate_file_region_entries+0x191/0x420
>   region_chg+0x267/0x300
>   hugetlb_reserve_pages+0x387/0xc80
>   hugetlbfs_file_mmap+0x2ce/0x3f0
>   mmap_region+0x1348/0x1a80
>   do_mmap+0x85e/0xb90
>   vm_mmap_pgoff+0x18c/0x330
>   ksys_mmap_pgoff+0x2a1/0x3e0
>   do_syscall_64+0xd7/0x420
>=20
> Without CONFIG_DEBUG_LIST the bad list_add() silently links a =
kernel-stack
> address into resv->region_cache, leading to later use-after-free.
>=20
> Use list_splice_init() so the source head is re-initialized empty =
after
> each splice, making the retry loop safe.
>=20
> Fixes: d3ec7b6e09e5 ("mm/hugetlb: use list_splice to merge two list at =
once")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Xiangfeng Cai <caixiangfeng@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.

