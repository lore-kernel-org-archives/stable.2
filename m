Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAF433938B;
	Fri, 14 Aug 2026 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689058; cv=none; b=XU+2P+oVDh1Aw6RnSjPRN9z1zOuortqG5aDtkU8w8p042WB9McrzSB0qiUqxTAzCRliv33OnaQFG/vQMg0UxSp69TNKXAS2Fv4anfZrfDBNUPzqx05HGRhi7TrRslpGqVq0u+tTrhCxX7CS8/noGmkypbGLHVuiUsoQSdDiWBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689058; c=relaxed/simple;
	bh=Ei4PqC2OTcR1IwKMO5sp5iFiMayZwV8thkF3iqfhTkI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OHmWOT7Yj+rx6oe2WnnveqwT11tLujuXz8/4JZhITgtQW30nyWZwS2QC2icSkmCYwtwZ5DYI4Mb1dktQckzzgaSO9axR3brdur3ka4rBs+GczNUV1ZFcOvXAsGIsfMKu+8K88B7iuF+R5rbnar1C2f045kFwzL+f41NNHzgnxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=krSVac0o; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="krSVac0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=5ccNSyKHH1BFnt+U2tRSRy9zZz6o5I2byydWT58rQtU=;
	b=krSVac0opkxKF+DEIx0dymEX7DkZh15pp0G2m9P9t/41RWPzIdOEL+lGswkIHx
	biXNYv2CaMBTAlglrvHbNsPiYBDZmAYqb801Ih5o7NGOhSm/hc2pfNtYPtDyuVe5
	TpJth0bjO6p2U61zwf8tRIFWwgJaOZyrsbSUnFq0ekKVA=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3r1zstX5qEtOaFQ--.33853S2;
	Fri, 14 Aug 2026 14:30:05 +0800 (CST)
From: yangge1116@126.com
To: m.szyprowski@samsung.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	robin.murphy@arm.com,
	hch@lst.de,
	liuzixing@hygon.cn,
	Ge Yang <yangge1116@126.com>
Subject: [PATCH] dma-direct: fix type mismatch in dma_direct_alloc_pages
Date: Fri, 14 Aug 2026 14:30:00 +0800
Message-Id: <1786689000-14677-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3r1zstX5qEtOaFQ--.33853S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XrWrKryUZw13WF1UJw4rAFb_yoW8JrWDpr
	4agFy7K3yYkFWxC3ZrZ3WkurZFy34rAa1rGFy7Z3s3Zrn5Wr4fKr1UC34rtw18tFZ8KFWx
	XFs8tF1Fyr4UWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRP739UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/xtbBqQ3i-Wp+te1juwAA3v

From: Ge Yang <yangge1116@126.com>

The pool allocation path directly returned the void* cpu virtual
address from dma_direct_alloc_from_pool(), which is type‑mismatched
against struct page *. Convert the dma_handle to page via
dma_direct_to_page() instead.

Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
Signed-off-by: Ge Yang <yangge1116@126.com>
Cc: stable@vger.kernel.org
---
 kernel/dma/direct.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4391b79..f496568 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -356,8 +356,12 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
-	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp)) {
+		ret = dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+		if (!ret)
+			return NULL;
+		return dma_direct_to_page(dev, *dma_handle);
+	}
 
 	page = __dma_direct_alloc_pages(dev, size, gfp, false);
 	if (!page)
-- 
2.7.4

