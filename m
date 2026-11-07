Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.248
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047472;
	b=c1vs4rZtxVUpyST8uoeZPaUOvYuh3JyM72zblWlP2XTpBJt6e2X5/Pn3nMD2C3bgYfhS
	 eBdUWYPxiZeXIlmrBobNKikVkQfnCAF+lqhZblk2GBLTIUWDMFPHl+deXgm4XspgIqdbj
	 kjVX5HN9JLF309v4a7Ghr6EKfSuDGGc6zd7h330kSjYbLuLtEaDNdIV4n5y0lGJVhaWlB
	 HV4Y7oG9a8P4n0SasuJ2FiNu38JOoIJAWdp5eB5gbmdtTVArdGAYYwzgOrfiH6NGLlr3f
	 Zd2sqyAfx7/j0+cwyx/gcYT6UbFsRtN+5Z3oT3pDkExc3+3ZB0vRpmWMyLGxDzcnJ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047472;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gCifWas0BpuNzXE9zytOMZSgJlGt46sndvW+hr71f/g=;
	b=WS4EuoWrTU2WVu+Udo07qM8OPvPkFm+MsdC7bRAagEQAHGL/V4Der+KrCE3L0avL+WyX
	 +vlxJLwwWF9B0C/xO9BhDPad27sXITTVz9fCYdd9AJalJ9QPyYuDxQ12xLVKiEmNi+FjU
	 XYOCvaZUDsKfqWASRhYA4lykoNhPBYVEV3rXCw8IQMzwl07twZRalsan1pq1BujWjjQit
	 kCURxYWGPB8MZseCrd0OcojsqbEGlKcQVir7veCvJFTFv8l7hApvGODOBTYOTnc1ZVjWF
	 E4FA/ySBrvepx4TCHeHk+irBpeZCx1ZoAUdYoa5sQFV9agcq07MgDexbl2TgvIKKjXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=STyGeFNJ;
	arc=none smtp.remote-ip=91.218.175.248
Received: from mta0.migadu.com (out-248.mta0.migadu.com [91.218.175.248])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E1606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F24E1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=STyGeFNJ
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/MVFvmVwbUPNerAUsqUVWH7M0FSKEB7lNQ5SvFhDebM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794047470; v=1; x=1794652270;
 b=STyGeFNJ81mtnnMMUyJBlgsb5L03K/oYEumc8a10K/CV31QjQoefA5Kl4eacj9dG5I1IudSd
 LQnT2WrxjfzwWMKYPnluLnf+0YBZY/aeFjacgJ+USEdEK3BxjvxS3+qArREXG5dvXqYhCpZEOLO
 mi5fPJmWwts6j25yOC57DXK8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 59b71af0a5b0d19c;
	Sat, 07 Nov 2026 10:31:09 +0000
X-Mizu-Trace-ID: 59b71af0a5b0d19c
X-Migadu-Flow: FLOW_OUT
From: Qi Zheng <qi.zheng@linux.dev>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	azpijr@gmail.com,
	lance.yang@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] x86: hugetlb: disable default CMA reservations on 32-bit kernel
Date: Sat,  7 Nov 2026 18:30:45 +0800
Message-ID: <94ec966eb5be064108a5cbdc8b72f92f8dda6724.1794046188.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1794046188.git.zhengqi.arch@bytedance.com>
References: <cover.1794046188.git.zhengqi.arch@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qi Zheng <zhengqi.arch@bytedance.com>

A 32-bit x86 kernel can run on a 64-bit-capable CPU advertising GBPAGES.
arch_hugetlb_cma_order() checks only this feature and returns a nonzero
order, although gigantic HugeTLB support on x86 requires CONFIG_X86_64.
Specifying hugetlb_cma= can therefore reserve a CMA area that cannot
serve the intended gigantic HugeTLB allocations.

On non-PAE kernels, the folded PUD_SHIFT yields a 4 MiB order, which is
equal to MAX_PAGE_ORDER. With CONFIG_DEBUG_VM enabled, this triggers the
VM_WARN_ON(order <= MAX_PAGE_ORDER) check in hugetlb_cma_reserve(),
warning that hugetlb_cma is attempting to reserve a non-gigantic order.

Require CONFIG_X86_64 as well as GBPAGES when selecting the default CMA
order to avoid these ineffective reservations.

Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 arch/x86/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 3b26621c91286..70726a99ede7b 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -45,7 +45,7 @@ arch_initcall(gigantic_pages_init);
 
 unsigned int __init arch_hugetlb_cma_order(void)
 {
-	if (boot_cpu_has(X86_FEATURE_GBPAGES))
+	if (IS_ENABLED(CONFIG_X86_64) && boot_cpu_has(X86_FEATURE_GBPAGES))
 		return PUD_SHIFT - PAGE_SHIFT;
 
 	return 0;
-- 
2.54.0

