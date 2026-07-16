Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4641A795
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202181; cv=none; b=Tkk/bf9c0w7/LJNDIqQBCKPOoD4Xa61Rb+naKK4CLe7pPuo6UpTTdiH20wENqbusC2nKOJdwvzpm+LJnAS0dn/adPtn3DyUberAI1HLTrwO47qQNeZuSIaAEv+sXgKzJ2jGie97aqXsNLKIj+WXekZ0jhHc9SBKkRjQMU0sai3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202181; c=relaxed/simple;
	bh=W1t4EN1pEr1A9vmeHgqHTXAlzgYQpK0uUduE9QytYsE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fx3Ww6j8S0TnV7omNbWaU5JykjVajcfHp/seT1z+z50Ky1i60nkCjoUBfjf2cEQVggFx2WOKl7IH1Y8jNgAEhgfK045+rUPbc9r4I7P1vPa4hmd1KwXNzRoZx9m2hdqD9fYYhufY9nlPHKrNgV1+Kaa237uMdbcRlDWtMJJjA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N9YUsjag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N9YUsjag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9AD1F00A3A;
	Thu, 16 Jul 2026 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202178;
	bh=82SMkYyX8bReDzj1BJ76i81cMk6MAPq9XEWM5yxnyuM=;
	h=Subject:To:Cc:From:Date;
	b=N9YUsjagoWiWOw/9e971nFQ4gHZDSfn3/EP0ziwfge2JlsM2QXHdN/gt36JbSrmXs
	 yIkSLlDepo6ivmv8IYvhYKoHmHVlsWf9y69lRjNb9M9okdVIyN2QyRb2kt0ZGTj4Nh
	 raIP7nSTnzQN5y0UZW3qdystu/8nsJ4FvF0ibjrA=
Subject: FAILED: patch "[PATCH] dma-buf/udmabuf: skip redundant cpu sync to fix cacheline" failed to apply to 6.6-stable tree
To: mikhail.v.gavrilov@gmail.com,vivek.kasireddy@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:42:51 +0200
Message-ID: <2026071651-preorder-shawl-7dbc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 504e2b4ab97a51d56d966cd36d0997ad30b65b2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071651-preorder-shawl-7dbc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 504e2b4ab97a51d56d966cd36d0997ad30b65b2d Mon Sep 17 00:00:00 2001
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 31 Mar 2026 11:16:57 +0500
Subject: [PATCH] dma-buf/udmabuf: skip redundant cpu sync to fix cacheline
 EEXIST warning

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

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 94b26ea706a3..bced421c0d65 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -145,7 +145,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 	if (ret < 0)
 		goto err_alloc;
 
-	ret = dma_map_sgtable(dev, sg, direction, 0);
+	ret = dma_map_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	if (ret < 0)
 		goto err_map;
 	return sg;
@@ -160,7 +160,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 static void put_sg_table(struct device *dev, struct sg_table *sg,
 			 enum dma_data_direction direction)
 {
-	dma_unmap_sgtable(dev, sg, direction, 0);
+	dma_unmap_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sg);
 	kfree(sg);
 }

