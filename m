Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379654;
	b=NvHpMWR5X5KINAQr5w2Gxo/udb26U0twULA8CqAYiNt8p+GeX3QJBip0CDxAEgwiumTE
	 rtdJdESOYAPrLdnQmoYJv087ay2iSgRV9kDccikJeegbtRSHg5xvheFE0UvD55EGbYj48
	 7qqkfPBE+NeQPj0JQ791lRxI+53ZiCEYeRC12MzxOYimkv4H1MoGEkixiHN0H+3AcnFd5
	 RyWm+Yb0gwG0j8SBY2RR2D3GCcYsz5w4ot0WBBTga5ZTB2WscSxbbCIDPg5gpQup2EUw6
	 5DaR4hhi6kJnRUdIdnUGUVg+MPJyByf6drtQzzAS4xRpmJHgZ077NmKllZaOzwQLsig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379654;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gCifWas0BpuNzXE9zytOMZSgJlGt46sndvW+hr71f/g=;
	b=UCCqTcfTW3NWGClE16l4YAa1qGn4dsOFSdxQ2d7dRB5chkJKlrevCx/Dzl3qVrN1XeBl
	 CkrP1atC2uSpigk2tB++5Oz1+VPYNJnKDJqUylW1S+m3hvQS9fGdgSQdSPDIPrpo4sCS3
	 TTeDsxi+U+cXNoErojyqK0a4G41XRn6PRQgyZ3TuWSzYCQDIjdMKUi/cmPTpBSxhshu/j
	 MVST1bu+rLgAt3RCjYl1gxmKuccegNxZJZ1WLiOG9tek2AscmB2q/4FFnfqxQJqCFoEQ6
	 Ri9tEogBGTOA+hqTN0MKO30h9NSPcvKyCLw5Sc/pH9AeLOUjYAVgglZ35E7Fvf3Rn2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="UC/ScjXC";
	arc=none smtp.remote-ip=91.218.175.1
Received: from mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C59F60A6F5A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C59F60A6F5A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UC/ScjXC
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/MVFvmVwbUPNerAUsqUVWH7M0FSKEB7lNQ5SvFhDebM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794379651; v=1; x=1794984451;
 b=UC/ScjXC8Hg4G/mXfiuxfa+e7FGYJrqxxcEieg3yZJ3L0ECGkSJBOHoxsJe/BVAOozeY9jJS
 mPdc8VcKuAWRz/Fr7QwiMUxksU5oke8rEKDz3LeqCp0sNeopI90PkboxFy454e7lZEKK4e+QcJ2
 TZGbGQusAN8oDJqCi742vz9I=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a60f861f3b7ca6af;
	Wed, 11 Nov 2026 06:47:31 +0000
X-Mizu-Trace-ID: a60f861f3b7ca6af
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
Subject: [PATCH v4 1/3] x86: hugetlb: disable default CMA reservations on 32-bit kernel
Date: Wed, 11 Nov 2026 14:46:50 +0800
Message-ID: <95dc282ff09d27b79086f0a690aac75c93590977.1794379433.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1794379433.git.zhengqi.arch@bytedance.com>
References: <cover.1794379433.git.zhengqi.arch@bytedance.com>
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

