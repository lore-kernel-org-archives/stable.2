Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC473101B0
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001886; cv=none; b=b5Z8EivtRPC4FWz2x1LYFwaJ/3JdDNMDNNI2y3RqFIK5LhqOlqLa5eeagxTDHwgcbN54XgYd6MT4dwIN3/WCR5QGFFrHQwGypmEwS2mJHWwSXa0RX3by8ZujpqnHc7DFm6F1ObyPjXSZOEtN0TWjUDCGt+A5dSQQEReQCiBJYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001886; c=relaxed/simple;
	bh=AugSZYsFMggDMCIziB5aYKV7JU4P5TZdNwMEd+h310Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aAQ3rYUdz2onXbOEEQddd2TYjGTmtYQzmERkgw8CQHqcFgTLsaSTGmXKXEnMaCD2IhLaJozIE2edg5/bpo2wYlACPvHfrtaollSIKvS8g+IFIWGnE4x5oqDhvZaRzRWI11K3tLNiJuIym4PsQrvki5SMd+tkoa575lI2SVCwTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uk1WSl1b; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uk1WSl1b"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784001873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8e5QwFzOEE3DTcxaJFQ4C1se1WuaDb4/2mYW5ZmvOI=;
	b=Uk1WSl1bZgrN/S9B8wc/UXqr44eSqfDcnIkTgpqhfZXIea2daRtcBrV6YEWiD+ncupy3Sy
	P51KVc1qBaBq4zNfWTsAVu0tQ9b4laiIUJnvW20yBO64PFn3kKUqz3R5qvA3N8sUY73GTQ
	EU/RG6SaY++MB26rPfL5CHwVamUlFEk=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 2/2] selftests/mm: add hugetlb_region_cache_race
 regression test
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260713171456.300518-3-caixiangfeng@bytedance.com>
Date: Tue, 14 Jul 2026 12:03:49 +0800
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
Message-Id: <1C8560A1-1F70-488E-BB62-2407B115F7B5@linux.dev>
References: <20260713171456.300518-1-caixiangfeng@bytedance.com>
 <20260713171456.300518-3-caixiangfeng@bytedance.com>
To: Xiangfeng Cai <caixiangfeng@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 14, 2026, at 01:14, Xiangfeng Cai <caixiangfeng@bytedance.com> =
wrote:
>=20
> Add a regression test for the list corruption in
> allocate_file_region_entries() fixed by the previous patch
> ("mm/hugetlb: fix list corruption in allocate_file_region_entries()").
>=20
> Triggering the bug requires a concurrent reservation operation to =
drain
> resv->region_cache while allocate_file_region_entries() has dropped
> resv->lock for its GFP_KERNEL allocation, forcing its retry loop to =
run
> again.  As the mmap() and fallocate(PUNCH_HOLE) paths serialise on
> inode_lock, the cache has to be drained by faults from a separate =
address
> space.  The test forks several processes sharing one hugetlb inode via
> memfd_create(MFD_HUGETLB); each mmap()s and faults ranges and punches =
holes
> to keep the shared resv_map fragmented.
>=20
> Two modes are provided:
>=20
> - default: a safe single-process functional check that exercises the =
buggy
>   line without forcing a second loop iteration; safe on any kernel.
>=20
> - --trigger: the concurrent reproducer, which panics a vulnerable
>   CONFIG_DEBUG_LIST=3Dy kernel and is therefore opt-in.  It faults =
pages in,
>   so it needs as many free huge pages as the file is large.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiangfeng Cai <caixiangfeng@bytedance.com>

It looks like this is a regression test case for a very specific =
instance of
list corruption.

In my opinion, selftests should focus more on functional testing with =
clear
expected behaviors and results to users. I don't think it's worth =
maintaining
a test case for a minor issue like this, especially since code changes =
happen
so quickly. Once the code evolves, this specific list corruption might =
never
occur again, and the function itself could even be deleted during a =
refactor.

Therefore, I wouldn't recommend adding this as a selftest.

Thanks.

