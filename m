Received: from outbound.baidu.com (mx13.baidu.com [220.181.3.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 536CC429016;
	Thu, 24 Sep 2026 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232941; cv=none; b=a48ah50naKlaa3XXSx17xwI6Hk6Ix6oYyCob3NtBesZCbeyBuy3R8a1s57aKIpG10HP3b6jPnppzo0lswjq/FcVVHQ7F7mqVMg6FdUrYDtxpl5d55m8ohxG1/PbYlJEFBk8O2KoHW+5XhqREWqXsP9wqtWcC/BIwUNVhs5Z46So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232941; c=relaxed/simple;
	bh=GpBnwmE01WoGFM+2bEx4FfJj/a4LONygOrp5vkIOgx4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RS5khh5jd84zRjn+RYPpzS/1VVUg+7ENZ59v5IOQcHlVxkTNdZn4j7fyDvRwrPG+8V2yomy7+VsaY0oqgS67dKiJNFJLfFaTmhIUppvSubEWGMvqkGAGWlo96sLUHKQ55UTQrSFd2hjU+Mk4mMH/iV/ir2/5LDpcDv39h+0cd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=oFRG05uI; arc=none smtp.client-ip=220.181.3.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="oFRG05uI"
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Ankit Agrawal <ankita@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>, Yili Zhang
	<zhangyili01@baidu.com>, <stable@vger.kernel.org>
Subject: [PATCH] dma-buf: Fix IOVA offset when linking phys vecs to sgt
Date: Thu, 24 Sep 2026 14:55:08 +0800
Message-ID: <20260924065508.27245-1-zhangyili01@baidu.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1790232920;
	bh=DB4sZkh5fDZtNwjNkl/1Uhukpv9zgpTbwOF9bC8zHew=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=oFRG05uIIqOIBHfa96nq3OY7qKqvEX3k2qvBH29LF5cVwEF5rGQIUBSdg8AA+Op36
	 12+dRoAaPKvg4nT2DDTWVZ2s6IMsy+vyX/p92llPuUqC8TXSrFKNdBQx3WshCJifaS
	 b0L4kb7U8p7ONBacMFiJKMdEruZX73QOxq+oGIL/Prvrx5lReAcI243Dxtq4h60Bz5
	 fRATjBLxk/8imwK/k5PLLrLzrVP79L4RCfsCFNUCRwYXFg/2I+cqvIg5WrWHoevby/
	 BcM6zPsGumoDYqd3IvyawQSLajoZVM5MNr4uBgZE2btLQ9sqncPQkXZK3B6NH4TD3L
	 q+NrrVa4AuPHQ==

The dma_buf_phys_vec_to_sgt() routine links every physical range into
the allocated IOVA space at offset zero instead of advancing the offset
by the already mapped length. This breaks the THRU_HOST_BRIDGE flow
whenever phys_vec contains more than one entry: the second and
subsequent dma_iova_link() calls try to install mappings on top of
PTEs that already exist, which fails and makes the whole conversion
return an error.

Fix it by passing the accumulated mapped_len as the IOVA offset. This
matches the pattern used by all other dma_iova_link() callers and is
consistent with the rest of the function: dma_iova_sync() and the
error path in dma_iova_destroy() both operate on the [0, mapped_len)
prefix of the IOVA space, which assumes that the ranges were linked
contiguously starting at offset 0.

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
---
 drivers/dma-buf/dma-buf-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 833be519e1e6..ef0f22854d01 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -156,7 +156,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 						       phys_vec[i].paddr);
 		} else if (dma_use_iova(dma->state)) {
 			ret = dma_iova_link(attach->dev, dma->state,
-					    phys_vec[i].paddr, 0,
+					    phys_vec[i].paddr, mapped_len,
 					    phys_vec[i].len, dir,
 					    DMA_ATTR_MMIO);
 			if (ret)
-- 
2.27.0

