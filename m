Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851695;
	b=MYoj5NH3CsgMLSuXLzU85jVDg/kbaYvk/IhIdYV4uvV0s9/bPOo4CiS6l2Sll4WU24jd
	 Qzx4qZo29IOn4F+A05aZwLDn4IYHmhnuQfsZox8CRSxHrYOyLWNSxVh3uyNAni8qrfcGz
	 9In2CRhagMELwZFn1IvN2zSBSyD2hEH2BQAY3elL/UEHfBGKEcOfzUB/PjW+a8KWKfCQv
	 B0GZ7tN6FWxspNIgUBk2Mury4MuIJaPTBxeeL+whfVf6gyJ5egfrYTqUPzXrE+GfmoeOE
	 YHsNnYa/vlYYUxEll13qoli7vbBKY+kr+GluMUgjIc+StGJxhWErWX7F+CfNVPDnjjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851695;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7GrZJSLMSTaY7SkaFZ0uijDSfH3F6ZTWMMqOxToPn0s=;
	b=DZR/Emg1QsNphSRnR3Au44XTRUmIuiPk/Q4f5lzpo/2OBALfljLyDU9hzWIxn7qSMp5/
	 VEoTrC+rfXGR6kmcmtX/sHMbog5//kvONxxa/Be+WkJSZ9d3Nf5stduDySpUGUHuR2p3A
	 HMH1zBwqqmfbFuUWNkQPt/zoOCOgHXH0+a8HigAqcKjq99a832VtkAg3iwHKd9VOdJ9Cn
	 de0YBuRZjrQnJwR4GX1yJOtu2NsQwkVBz6Gxj6JJz1a+4qPxhhZNG68QwWKHhXn6GEDTR
	 f4PF8FhmHmn9tZuHe8J+wT04zVaYhvtY2ti30PTEyj65CySJdsAletOQkJ63OVDVLEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=epfnCIBm;
	arc=none smtp.remote-ip=91.218.175.15
Received: from mta0.migadu.com (out-15.mta0.migadu.com [91.218.175.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588A3606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 588A3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=epfnCIBm
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Alk5PnLb93phS/NG/b1nkAJfppoj1kE8R+vJuoaKDh0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793851691; v=1; x=1794456491;
 b=epfnCIBmVysud4BWPuiYphnUHipz+x+hK5PFhSK0kbOjAhVRnBUISTQhTNnjqHTu90uAoC3z
 2I8LmQPXIfv825QP4NQrjTmuMnduc1ghTn9nyJ8IZZXUiTpq2xdxvImJh1jarrsFsKo3kTTmjAH
 6uz59nKYiczWuoihtWQ+CcZI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ed0532ae4a2af54b;
	Thu, 05 Nov 2026 04:08:10 +0000
X-Mizu-Trace-ID: ed0532ae4a2af54b
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
Subject: [PATCH v2 1/4] x86: hugetlb: disable default CMA reservations on 32-bit kernel
Date: Thu,  5 Nov 2026 12:07:43 +0800
Message-ID: <ece5aebe95f6565046d17ffb738670feb3202943.1793850539.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1793850539.git.zhengqi.arch@bytedance.com>
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
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

