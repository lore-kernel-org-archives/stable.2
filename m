Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF246C4BC
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660353; cv=none; b=ctSfIbN1CIoYZZ9msR3RzvHRG7VAxv+YvC+Oo1BIrpIPkUwDGERwclbhKTNFg//hKx16bnl8fozrxF8KH+EwnmqZZYUehbhuji4hb8w3iO/+KEzp5O8NAIo5c/V4RG5YT0mqwpIU+aCAbMIgEKYJIW+souGnkiB8FJtXfw3zsSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660353; c=relaxed/simple;
	bh=EzPj6s+LOwBuzumgfTubt2qQor3yQZI5LBfK5uIBntA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXXzEQTJ5+tFx4cHeT29UjHGru/pieXnCQ6Peb9Fmq7JFrEV/Dh5Serw6ETFLMbF9O+5rCQ4h9KM655XIKkL0NPUOCx6TkaCGigPZarSd1FG1yXnXOpVTJTzxk7EFLkKTryYUlrMsh9qQX5VcHO/6KYk99m3d5B4ZZbhROySP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmNlCCwn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmNlCCwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0001F00A3A;
	Tue, 21 Jul 2026 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660349;
	bh=2TCqFz5uQmSI9a1R6ZrsEia6/ThTF0g48t814vf69fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bmNlCCwnyfYBCK3zVjSmeowWr9z2vPYFX6Hyq/+cSeR5RmtqkTITY28di2aj7Ts2c
	 rkfCNCK7iHjek19C82DseHmC/h2iiyqAHPyl0OU69xangYCrm60SMifZ50tpB9Q0ig
	 pT4gGaSTAMMUBvdtD9jFeie7vNRR9DRX5KyTCf70KLgjX4dCcfIGvNWhzelqRnNMjn
	 aS1czIg23uMtPsUL2dGYE05ZamdoFwFV1/gS/5voUKYhkfc40+eLUQa+oBLnCvTMQ4
	 YrLfyLTRQULX2W9qtcbS1UBe9DF81Ygg/oBiG+GPYp7eQ9XHaFlmFu+tXs8nmrTeeb
	 Ay3bymtu/GAiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] dma-buf/udmabuf: skip redundant cpu sync to fix cacheline EEXIST warning
Date: Tue, 21 Jul 2026 14:59:06 -0400
Message-ID: <20260721185906.397615-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721185906.397615-1-sashal@kernel.org>
References: <2026071652-dandelion-handbook-8d52@gregkh>
 <20260721185906.397615-1-sashal@kernel.org>
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
index 3cd9c4a84e76fb..68ffa01ced63db 100644
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

