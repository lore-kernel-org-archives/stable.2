Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692888;
	b=wuaF05yd/3yZuOW7R37o+0u9BbNIZPz8PGw0g8s535Eq5UlFStLM+hPYeMdlsEg0+C2j
	 5r+ijogQvBzM/YejoEZYzqZGizFiVy96AIGJX/Ue+oCVBn45EQ/Kj4L5xeA4jGpR++MRv
	 76DeLAG1hd9W4AUf7BMh+3A5qdutfZcVObrDNYVxcpvNX1k2YDDwNMZdbtZe9pCW++blQ
	 aYEk0AWeoZ8tvfErTrS0xXQ7MQeT+xjS5R3sUEYhn4Q2mDKjXB4tYHfFK+W0LZ9oftPVi
	 DkgOX7wZm6WF6aOgpStYKHxRZi5RSH08X8PJ9RTu2B2IGI/A0LB+w9Q1G/i4WODwVEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692888;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=avBDojeTtqVdC12fvsBVa2erBplXlUMS7WzAD6rXRAg=;
	b=RHluW+yLRlOJ6cGz8KHMBTO5ZZZQ/EgZAElXCE85FGQN+l+JdfqjxsdmF1e84ObsNGzv
	 oczwzPrKb+0s6tq/xUjo0uT+xK1kr/1/1jJ/hGTzvUOAZ2i8pBdiLrIy3N0WAofPNqcrR
	 JZp3hegIZKdjveEpJXDZTCg4EhjeveWzzMwh2jLHPHuj3pM3R8cZh0ttNySUCmTVoU7pX
	 qvSagxOdM9NCIRa54lnAJm7oYDvWSxsis9W6zRJz4BZk9DtLK1YvhUS/vgh6ugwkSHRFu
	 E39BZrwcWfX18J+LH+BfROmkRxfdlIVIFpXlqyVdre8S9MPRwED1/65BRKi1FTqsmgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jWoauCfG;
	arc=none smtp.remote-ip=91.218.175.99
Received: from mta0.migadu.com (out-99.mta0.migadu.com [91.218.175.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED96606D80D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AED96606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jWoauCfG
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PWiNWmetA1DkyT9l9rdGAugffi5Wf5dqd79+o7YbD5c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793692885; v=1; x=1794297685;
 b=jWoauCfGTO+gIny/5CNf5uG05lZ92YPtEogZpqH/yyrXY+mQnsDxi5XzvjDt7Age/HM+1BQR
 ZD80ADAroBsKP1RERYY+NV/PQiLrO9vx8H4KGgZ89TGve7rAkbGIgLlPFg5FKyXALTnmznIsbuz
 PBVM6IukCnCVdd9Dr4f/EX7k=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cc10530678a8dbff;
	Tue, 03 Nov 2026 08:01:25 +0000
X-Mizu-Trace-ID: cc10530678a8dbff
X-Migadu-Flow: FLOW_OUT
From: Qi Zheng <qi.zheng@linux.dev>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	azpijr@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 1/4] x86: hugetlb: disable default CMA reservations on 32-bit kernel
Date: Tue,  3 Nov 2026 16:01:04 +0800
Message-ID: <61eee83da19a87337e68a7747fc0b89ee5d0393b.1793692578.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1793692578.git.zhengqi.arch@bytedance.com>
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
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
Cc: x86@kernel.org
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
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

