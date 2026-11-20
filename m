Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165466;
	b=Umvmqvbj0q9+mkISVMiGyttFpxXY0M6ZaAJBJKUrEBj9aKO5rBMCoQMix0e0pKbALclN
	 gEj9b9mSHn3YX1wKxvNLgW2cE/+aP8zRA36OK0xw2+yTDA9/RCmDRhnYoB19WCZQSt5kA
	 XSR2Obd8ZzqzylqaLDgPdGbMTQxdmEj68U2274e40r8ev4mr6PP1PP4DOyrpWUkq7mgr6
	 GsMVgfwaWkGN7FNezm2vYb+JWz4lk3CKaS4jZZN6DjuzX2d3P3xw2LAhAjS4yZ3813bVD
	 kfgIIP3ZiC2Wb5J0puSXR2vZLRHK8Cv/q257N0rXK+/6m0KtKd5aKeEfpadJ4/QEM5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165466;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=/4RZB7pvKMGNXZ0e7P/ml5wdFAEeCdJqj2hE14qekyY=;
	b=EUW358OME0niLoUw8KwGuSM5QCNyB7kPb5CvMN83GMtwVyAUbOIXpvz+PdiffWNOLyGp
	 LEFPLZ/MJir4Onn5NlGtb5ltVBvNP9zKKBT2337lMglRkUu/Ju3P1wz2mxN5EDvy8c60d
	 9yfsM0njZZQ2+KN6sazi4yNa6CQ0jieHMSZeDvybiTqIgiIGviQ6jsJB0e6F+KPJRx39G
	 WQf02LiTSj5A5JOdQM/ym9UvbMLdPQCMPeHW3gR9Vh1sU8UMvyFmTErtzxQuTLBfFaugY
	 xI0kkXikFXNi4xvsfuTYwEAYrUzUmBRnwkfiAIxxZx46Omii8YGPoW11oNWjFsKNmqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HdOnQ+9U;
	arc=none smtp.remote-ip=95.215.58.77
Received: from mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C0606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 878C0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HdOnQ+9U
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/4RZB7pvKMGNXZ0e7P/ml5wdFAEeCdJqj2hE14qekyY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795165463; v=1; x=1795770263;
 b=HdOnQ+9UYsKLuCXbzJub0XnPdyqdfFG2A1IAy5FsDFWZj8lPVRo9W4ckjPQ1BHcE3pWFOMO9
 hHH5AJfH3vxXR+ZtrXYjdTGDXKLhOsc3WObAzBixY48M5Zg83bs0cP75PELSdffYhdquax9jCZy
 bHfTT799Ng79w/kxjeaOPAAM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a5ee9e0ab9ccd638;
	Fri, 20 Nov 2026 09:04:23 +0000
X-Mizu-Trace-ID: a5ee9e0ab9ccd638
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] mm: hugetlb: allocate larger early CMA pages first
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261120074701.48298-1-qi.zheng@linux.dev>
Date: Fri, 20 Nov 2026 17:04:06 +0800
Cc: osalvador@suse.de,
 david@kernel.org,
 akpm@linux-foundation.org,
 fvdl@google.com,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <447E288B-0ED0-454B-8390-EE39C1CA83C7@linux.dev>
References: <20261120074701.48298-1-qi.zheng@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 20, 2026, at 15:47, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>=20
> With hugetlb_cma_only=3D1, early HugeTLB CMA allocations follow hstate
> registration order, which can depend on the order of hugepagesz=3D and
> default_hugepagesz=3D parameters. cma_reserve_early() advances =
early_pfn by
> the requested size without aligning the start of each allocation.
>=20
> On arm64 with 4 KiB base pages, 32 MiB and 1 GiB pages share a CMA =
pool
> aligned to 1 GiB. In a 2 GiB CMA range starting at 4 GiB, allocating a
> 32 MiB page followed by a 1 GiB page places the latter at 4 GiB + 32 =
MiB,
> violating its required 1 GiB physical alignment.
>=20
> Simply rounding early_pfn up before the 1 GiB allocation would leave a
> 992 MiB gap and advance the cursor to 6 GiB. cma_activate_area() marks =
the
> entire prefix below early_pfn as allocated and only frees pageblocks =
after
> it. The gap would remain reserved with its bitmap bits set, and =
releasing
> the two HugeTLB folios would not reclaim it, permanently losing 992 =
MiB
> of usable CMA capacity. An alignment-only fix would therefore also =
need
> to track and reclaim such gaps.
>=20
> The same alignment issue can affect non-LPAR PowerPC64 hash MMU =
systems
> supporting 16 MiB and 16 GiB pages, with 64 KiB base pages and
> CONFIG_ARCH_FORCE_MAX_ORDER=3D7. The 16 MiB size then has order 8 and =
is
> also gigantic, sharing the 16 GiB-aligned CMA pool.
>=20
> Allocate early CMA hstates in descending order. Each range starts =
aligned
> to the largest supported size, so this preserves alignment for =
subsequent
> smaller allocations without creating gaps.
>=20
> Fixes: d2d786714080 ("mm/hugetlb: enable bootmem allocation from CMA =
areas")
> Cc: stable@vger.kernel.org
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Muchun Song (ByteDance) <muchun.song@linux.dev>

Thanks.

