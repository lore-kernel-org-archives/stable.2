Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE046EC76
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659754; cv=none; b=phbdVtNt2ZcOb6HSaIi1Dy1eNYluu23m1YrOgSCFIyMC3ZslVgVwb01ZNPDjrmFw+cF3cEIMvp+mop6yyO0wBc7fUvh4GhjvcWlYOqP3RrvSD5A1Z1gwx6itFSoNn0gf6vRZD8uuBquuWGA2s+vdlie+b27XiEoyGwzi57OOfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659754; c=relaxed/simple;
	bh=Jhw6j3vJwyvphX0lGgc8xVPcu4qBRKl8G59TZkTJGLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtKTw/QQ9CC/z3lgAYNDhKu2ExXIP9GxZ47hK4+ivM2odpRJMLP2Bm3fGnqhcX/DOuXoLzdQkhTnEZ44Nh5dg3uO3gsCL3IbLodmdbdrYm9khh/9q+Za3pNC6SIlgl196JkwxAXw5XnbHID46Q2TVLmqTEt1A+6D/dJWp2IW3c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSs7RSOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSs7RSOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B151F00A3E;
	Tue, 21 Jul 2026 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784659752;
	bh=L2wI6RtmeFHg6GLdN6/FlAlRFvulzKtxKZq9BWeDFa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JSs7RSOTjsPX9dFJUXjseLUY+iDAB+NnKIlTTfIA45hrO+PY9+fiamC/IjMMAM/zo
	 of996ZNTZmUZFvdAe+SUK5PFJDZWoTNZfdvRXADAb/mV2g4BxvukDMVAtzXAzPobVc
	 8qkgnPVgk5yTVhJ6GA7vgg484phkTRqcSwW2EOb2kYF274r2QEZIQu1egC+6BxVFpG
	 464IM+M8KnQsXRXaikXrw+poDwUq5H5kx/VnZrNaq8wxavzlhEz+HTdb4wExuzwArt
	 SxX7T1R4WmN7MVayPh+s83MI7O3JYpoB/DBhV1J+pdV1kao12HnwkW+/R/uBD1emvc
	 nEjSPHt+fyQpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] dma-buf/udmabuf: skip redundant cpu sync to fix cacheline EEXIST warning
Date: Tue, 21 Jul 2026 14:49:09 -0400
Message-ID: <20260721184909.383278-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721184909.383278-1-sashal@kernel.org>
References: <2026071651-ditzy-durably-4f3e@gregkh>
 <20260721184909.383278-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

[ Upstream commit 504e2b4ab97a51d56d966cd36d0997ad30b65b2d ]

When CONFIG_DMA_API_DEBUG_SG is enabled, importing a udmabuf into a DRM
driver (e.g. amdgpu for video playback in GNOME Videos / Showtime)
triggers a spurious warning:

  DMA-API: amdgpu 0000:03:00.0: cacheline tracking EEXIST, \
      overlapping mappings aren't supported
  WARNING: kernel/dma/debug.c:619 at add_dma_entry+0x473/0x5f0

The call chain is:

  amdgpu_cs_ioctl
   -> amdgpu_ttm_backend_bind
    -> dma_buf_map_attachment
     -> [udmabuf] map_udmabuf -> get_sg_table
      -> dma_map_sgtable(dev, sg, direction, 0)  // attrs=0
       -> debug_dma_map_sg -> add_dma_entry -> EEXIST

This happens because udmabuf builds a per-page scatter-gather list via
sg_set_folio().  When begin_cpu_udmabuf() has already created an sg
table mapped for the misc device, and an importer such as amdgpu maps
the same pages for its own device via map_udmabuf(), the DMA debug
infrastructure sees two active mappings whose physical addresses share
cacheline boundaries and warns about the overlap.

The DMA_ATTR_SKIP_CPU_SYNC flag suppresses this check in
add_dma_entry() because it signals that no CPU cache maintenance is
performed at map/unmap time, making the cacheline overlap harmless.

All other major dma-buf exporters already pass this flag:
  - drm_gem_map_dma_buf() passes DMA_ATTR_SKIP_CPU_SYNC
  - amdgpu_dma_buf_map() passes DMA_ATTR_SKIP_CPU_SYNC

The CPU sync at map/unmap time is also redundant for udmabuf:
begin_cpu_udmabuf() and end_cpu_udmabuf() already perform explicit
cache synchronization via dma_sync_sgtable_for_cpu/device() when CPU
access is requested through the dma-buf interface.

Pass DMA_ATTR_SKIP_CPU_SYNC to dma_map_sgtable() and
dma_unmap_sgtable() in udmabuf to suppress the spurious warning and
skip the redundant sync.

Fixes: 284562e1f348 ("udmabuf: implement begin_cpu_access/end_cpu_access hooks")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Link: https://patch.msgid.link/20260331061657.79983-1-mikhail.v.gavrilov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma-buf/udmabuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index d871157e2cced1..8b620e3aaab183 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -73,7 +73,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 	if (ret < 0)
 		goto err_alloc;
 
-	ret = dma_map_sgtable(dev, sg, direction, 0);
+	ret = dma_map_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	if (ret < 0)
 		goto err_map;
 	return sg;
@@ -88,7 +88,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 static void put_sg_table(struct device *dev, struct sg_table *sg,
 			 enum dma_data_direction direction)
 {
-	dma_unmap_sgtable(dev, sg, direction, 0);
+	dma_unmap_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sg);
 	kfree(sg);
 }
-- 
2.53.0

