Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59693A48C2
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613428; cv=none; b=NB2omBHkywdoPII22jCbEJTgNRY6tBsTg28DM1ZYdNmFFW9MdZaSEQ9LA6PlCJ4POe5H3ThcPJK8ds5RrcHBiuLAerCfAgXCohuFPyUOqE3RH+Ry0gM+9tcG3OI0GHBXxo4Qm90xXCdjh2Xvpvy5xycBtisx7xzp8RuaL3N8Z0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613428; c=relaxed/simple;
	bh=JDc84cboVSPNVJCpNpcaHY9U+8pvB/PVE6VNaNLa000=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqPB0zYO7MRfqQWvkOMOjLilN9Q6r1TPxE9myLkhGF2+6o53iuxwyOxrUyOhW9w438g32iU9BPtcdcQc07X5KUugy1OtIhaMPbA/5ni8yLoZHcdl3QSYRaEpK/F5DCWfjNmVjleJh9ME3YafmOcV7AtYGKpByynsyEoxqbWa5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnmMZlK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnmMZlK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162221F00898;
	Thu, 17 Sep 2026 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613415;
	bh=c6jO2vDtjjQ7jW7FJ0wTiCgpwwoHT3MmUzbQg3+Nhzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CnmMZlK1Pe+D5oXwJ6EtWT3hi4WldstXn/5sYmqGB+cE2gowbze7rPGkXfJ6HwI/O
	 JovN6poZOb2+wOPxFFOy4RTNkmZkjR1bqbkdMxlkvRUz24rQIZsJjD7PSY6JTGvjdo
	 MEnY2d15e+t39WYHM7vo3A6YEdOzxiryUsMCKI9bPJ4xj2DRAeIuFoVqwLsjtg4bKX
	 i4Id5xdD4KOgvZXsoBDro0xrb1UueMxihzxUnbczXtsS7x5Dy6TCjxUCuRjr7d3E2/
	 R2Q9sNzBxm63vpd1mN0eHDRCd/Wtft/x8UkJZIWeAsNUTJgtSPtcvn3xm0jCipEq7+
	 3+ErSB2WKMjnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] page_pool: disable sync for cpu for dmabuf memory provider
Date: Wed, 16 Sep 2026 22:50:10 -0400
Message-ID: <20260917025012.3917055-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025012.3917055-1-sashal@kernel.org>
References: <2026091638-excretory-liquid-7149@gregkh>
 <20260917025012.3917055-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mina Almasry <almasrymina@google.com>

[ Upstream commit 7dba339faae991a23c54f7b93a58798c58f8c16f ]

dmabuf dma-addresses should not be dma_sync'd for CPU/device. Typically
its the driver responsibility to dma_sync for CPU, but the driver should
not dma_sync for CPU if the netmem is actually coming from a dmabuf
memory provider.

The page_pool already exposes a helper for dma_sync_for_cpu:
page_pool_dma_sync_for_cpu. Upgrade this existing helper to handle
netmem, and have it skip dma_sync if the memory is from a dmabuf memory
provider. Drivers should migrate to using this helper when adding
support for netmem.

Also minimize the impact on the dma syncing performance for pages. Special
case the dma-sync path for pages to not go through the overhead checks
for dma-syncing and conversion to netmem.

Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/20241211212033.1684197-5-almasrymina@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: b814dfbfeb0a ("bnxt_en: Propagate TPA buffer allocation failures in bnxt_queue_mem_alloc()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/page_pool/helpers.h | 35 ++++++++++++++++++++++++++++-----
 include/net/page_pool/types.h   |  3 ++-
 net/core/devmem.c               |  1 +
 net/core/page_pool.c            |  1 +
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 60a5347922bec..036a5cca8379c 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -418,7 +418,21 @@ static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
  */
 static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 {
-	return page_pool_get_dma_addr_netmem(page_to_netmem((struct page *)page));
+	dma_addr_t ret = page->dma_addr;
+
+	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
+		ret <<= PAGE_SHIFT;
+
+	return ret;
+}
+
+static inline void __page_pool_dma_sync_for_cpu(const struct page_pool *pool,
+						const dma_addr_t dma_addr,
+						u32 offset, u32 dma_sync_size)
+{
+	dma_sync_single_range_for_cpu(pool->p.dev, dma_addr,
+				      offset + pool->p.offset, dma_sync_size,
+				      page_pool_get_dma_dir(pool));
 }
 
 /**
@@ -437,10 +451,21 @@ static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
 					      const struct page *page,
 					      u32 offset, u32 dma_sync_size)
 {
-	dma_sync_single_range_for_cpu(pool->p.dev,
-				      page_pool_get_dma_addr(page),
-				      offset + pool->p.offset, dma_sync_size,
-				      page_pool_get_dma_dir(pool));
+	__page_pool_dma_sync_for_cpu(pool, page_pool_get_dma_addr(page), offset,
+				     dma_sync_size);
+}
+
+static inline void
+page_pool_dma_sync_netmem_for_cpu(const struct page_pool *pool,
+				  const netmem_ref netmem, u32 offset,
+				  u32 dma_sync_size)
+{
+	if (!pool->dma_sync_for_cpu)
+		return;
+
+	__page_pool_dma_sync_for_cpu(pool,
+				     page_pool_get_dma_addr_netmem(netmem),
+				     offset, dma_sync_size);
 }
 
 static inline bool page_pool_put(struct page_pool *pool)
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 092e52b7eba70..2b6fd84fac6f8 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -171,7 +171,8 @@ struct page_pool {
 
 	bool has_init_callback:1;	/* slow::init_callback is set */
 	bool dma_map:1;			/* Perform DMA mapping */
-	bool dma_sync:1;		/* Perform DMA sync */
+	bool dma_sync:1;		/* Perform DMA sync for device */
+	bool dma_sync_for_cpu:1;	/* Perform DMA sync for cpu */
 #ifdef CONFIG_PAGE_POOL_STATS
 	bool system:1;			/* This is a global percpu pool */
 #endif
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 55f27a9ed1214..1763af1901cb0 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -343,6 +343,7 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 	 * dma_sync_for_cpu/device. Force disable dma_sync.
 	 */
 	pool->dma_sync = false;
+	pool->dma_sync_for_cpu = false;
 
 	if (pool->p.order != 0)
 		return -E2BIG;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ce35c859e0ffb..ce4569a568870 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -203,6 +203,7 @@ static int page_pool_init(struct page_pool *pool,
 	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
 
 	pool->cpuid = cpuid;
+	pool->dma_sync_for_cpu = true;
 
 	/* Validate only known flags were used */
 	if (pool->slow.flags & ~PP_FLAG_ALL)
-- 
2.53.0

