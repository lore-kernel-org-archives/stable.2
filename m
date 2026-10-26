Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008484;
	b=NJn6Q1ImUx7ztnn5NtA7OiYj6C5A+QJm370H3T8N6S2z9fk4C3CgKuPslGKiOvi7cb4Z
	 rXVgB1mHT6r4essAc6xkuKNxNe2FiKXHszFJctoTpmQIMz3mywTU73arB8F24TFa3V2FP
	 kk85/dLbFB4cjJIUa08mSPSaHNCl9491E9N2oEvoOuk+IIzvmXXUj/xJTixyBFOlj+BUZ
	 Fak2rnxWgmv59c217+Is54/Pj3gY3MGto8HAxqwxjrkkce/6VZYNjqY3q31jle8DROBLX
	 jcbD/SroX0ud3CmCa5xwEcMJKRsT32nVOk+ZgHiaGfLd3qWGkaOdAyqeuSFks/8s85g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008484;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=g5F29CYGzpyaMphPr1Ay74PbWfybCTO72tr2DJLko5s=;
	b=e9B++HGNuky4T/tgU2UesPqgAB5dcaLG1Exj4X3285Jlb1WY8/P4e8aOnO6UY03e2oVi
	 zUhAJfa/Y4jkALhJB432QpkmhObVm3EjLEaCcwrDC+y47RNnL05LhYm4P1YbJ6FCA9sxp
	 1OzH8VoYEGK9HHzLr0rFH7jhw7JRjaMZgc924cz89dIUuOkfuQzFKP3lVjeA6wAu9tr9m
	 HSDe0B5wtkGyMNXXVzbNw2RT9Q0QD3JKt+LQyKyhMeOk20xi1znSHx5azDQMiSLOiS6/W
	 mqzKgj2DrqKlGj60twoFb/52PfF33FJ4Uuco8XAOiuubpldb5HFZlx5mfw/rMCfSoaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=N5471TYt;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092F60A2610
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F092F60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=N5471TYt
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261026095436euoutp01e6102c449b133678278109c5b8479715~iC7WQ9P_C0332403324euoutp01D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:54:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261026095436euoutp01e6102c449b133678278109c5b8479715~iC7WQ9P_C0332403324euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793008476;
	bh=g5F29CYGzpyaMphPr1Ay74PbWfybCTO72tr2DJLko5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5471TYtW/Bvg2rh6h+9Jn+zRI1gbZgVz2KdzEVVHtgYPr0Ezik+/HpzY73JhIkWH
	 ZTRuGlbScG2djCzyme/XfoXYFFytfipvNxXncQ+zHEt+UTirB1XXgE5HbKQ/H9b+mq
	 eFl+m4EXbN5mlJq76bubqdl6mggriZKlpObKrSfY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261026095435eucas1p129baa137891d2e9f5408b47afd6c556c~iC7WCHumN1950419504eucas1p1Q;
	Mon, 26 Oct 2026 09:54:35 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261026095435eusmtip2bcc574f43d3f9a26c454413514223b14~iC7VuXSvW1096710967eusmtip2Q;
	Mon, 26 Oct 2026 09:54:35 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik.ext@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] dma: swiotlb: Remove default pool from the pools list
 on exit
Date: Mon, 26 Oct 2026 10:54:14 +0100
Message-ID: <20261026095423.966856-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026095423.966856-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261026095435eucas1p129baa137891d2e9f5408b47afd6c556c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261026095435eucas1p129baa137891d2e9f5408b47afd6c556c
X-EPHeader: CA
X-CMS-RootMailID: 20261026095435eucas1p129baa137891d2e9f5408b47afd6c556c
References: <20261026095423.966856-1-m.szyprowski@samsung.com>
	<CGME20261026095435eucas1p129baa137891d2e9f5408b47afd6c556c@eucas1p1.samsung.com>

With CONFIG_SWIOTLB_DYNAMIC enabled, the default memory pool is added to
the io_tlb_default_mem.pools RCU list during initialization. When an IOMMU
takes over DMA translation, swiotlb_exit() tears the default pool down and
clears it with memset(), but leaves its node on the pools list. The list
then contains a zeroed entry with a NULL next pointer, and any later walk
of the list, for example mem_used() when reading the io_tlb_used debugfs
file, dereferences an invalid pointer and crashes.

Remove the default pool from the list before freeing it, and wait for an
RCU grace period before clearing it, so that no reader can still see it.

Fixes: 1aaa736815eb ("swiotlb: allocate a new memory pool when existing pools are full")
Closes: https://sashiko.dev/#/bug/linux-f75998aa-65ea-4596-9bb4-fa83773012a3
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/swiotlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index db731f7891b7..51fb2d34f6f2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -665,6 +665,12 @@ void __init swiotlb_exit(void)
 		return;
 
 	pr_info("tearing down default memory pool\n");
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	spin_lock(&io_tlb_default_mem.lock);
+	list_del_rcu(&mem->node);
+	spin_unlock(&io_tlb_default_mem.lock);
+	synchronize_rcu();
+#endif
 	tbl_vaddr = (unsigned long)phys_to_virt(mem->start);
 	tbl_size = PAGE_ALIGN(mem->end - mem->start);
 	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
-- 
2.43.0

