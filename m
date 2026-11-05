Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855899;
	b=3Xeb4q5fc3THRvY61DDSDbBnWbV2RAl1JpQSxAzk8As66sd47IC67pWRrvkKQ1GMFftv
	 rljeQS8wq1qnWCg+yi1BTHPWrse8sznAes4jseGsFz2pICd/iIoUlgf71JyPOCgyPUYuH
	 lVdlhh2c+YOzKQbE0hKIJhRedciiSwJYMM1iuDJAR0ichFnv2TuoQrwt0P9Ou6Va6ggPN
	 DdyfvG5Par0vBSksCbnGWKOA0UxjrL5oBeU3lilgwBqVMsNIcgLHqupXAqlfqMPqdjuc8
	 pLlD9L0fLwnl6/2uwgWvNY6ckKxBV8NaF6KNGTPWrSmvwDcB8W0vsZ244Enc+Vhuw7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855899;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=EHHTNOyGnr1PE5k2wGmLgV3xyiVaxO8J8/TzziII9T8=;
	b=ou1OLd8d1lL6A9Vg+UeG4IcYpyimpnSKl96jYR2L7b0CDZ0ucPEgYMdu/DEmLASt98hO
	 PLNOvQspsdWp5PsKo5WTmbjqxTGs1QUatqrLTdHh4KH/2e130voi7Ur1cQHIQy6k0xKBJ
	 vmy3zFJMeu2K4mzYcuI/7mQE2RmROkIlZ2Uz+xt3bPKFSWwbERFZI1hoRWtLt+S3MGCjJ
	 fk3OhqnFE0ZrSu4SmCz8kLm61E+7mzWTTZrSqGbGTYHodhdQxlN4bMgeYZ4/h2MJG0+Vx
	 7DbaoDORFX/lpE1ZH6XyRLVOfiKmJY/83mPCtgz1wNvw/ocVK+W0nXs9/Vbr+ZCIcUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iIUY62sq;
	arc=none smtp.remote-ip=95.215.58.166
Received: from mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8ED606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 05:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE8ED606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iIUY62sq
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=c1YgwgSqOv/daQ+67ELiYNYLj7qD2N3amAckkdhSUFU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793855896; v=1; x=1794460696;
 b=iIUY62sqPmW2pMv6ePdgQW66I8R2QKho+cZ+beRy3JpXoTHp1SmyC4FJVzNpsPofkSrP0ZbF
 df3S1o3gvdk74hb8luIwDiYBP8G02Sx9Vqc11wtqZLLaKXVxU55pcUCk5gZvanh67ffmnd6I87Z
 GwYBa0qIXYejXkd6Yb2mZ/vU=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 6facb84ef91715ec;
	Thu, 05 Nov 2026 05:18:16 +0000
X-Mizu-Trace-ID: 6facb84ef91715ec
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
Subject: Re: [PATCH v2 3/4] mm: hugetlb: fix GFP mask propagation to CMA
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ac2de9b321f68c1025333e92e3ce94beadcb0b6c.1793850539.git.zhengqi.arch@bytedance.com>
Date: Thu, 5 Nov 2026 13:17:57 +0800
Cc: osalvador@suse.de,
 David Hildenbrand <david@kernel.org>,
 akpm@linux-foundation.org,
 azpijr@gmail.com,
 Lance Yang <lance.yang@linux.dev>,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <711211AD-BD2A-497D-8541-B63C68509920@linux.dev>
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
 <ac2de9b321f68c1025333e92e3ce94beadcb0b6c.1793850539.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 5, 2026, at 12:07, Qi Zheng <qi.zheng@linux.dev> wrote:
> 
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> cma_alloc_frozen_compound() uses GFP_KERNEL, allowing direct reclaim
> during the first MPOL_PREFERRED_MANY allocation attempt even though
> the caller clears __GFP_DIRECT_RECLAIM.
> 
> Pass the caller's GFP mask through the helper so CMA respects its
> reclaim constraints when trying the preferred nodes.

More natural.

> 
> Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

