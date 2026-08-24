Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCCF380FF3
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596091; cv=none; b=lc2bndLMf8eijFe2wg6Ggka30+z9MacQtome+2OfM0ZNm+D2CjXP3e+fvpujrezuwDQujj4nDJpbmZ4YCHDNdJk8w2BWx/9IqLL2rlcfyLaK44G8dteGLaM2X5HjFk1mcnFmOL1Swa3bnzTsVIZwGjHY1jhuEXD9QKJdRhrOlyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596091; c=relaxed/simple;
	bh=HG6rH94OlwxK6qbxTAJviNgBMgI0geoA4/zKdgSc2Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDKN3m6JZVR+ndLWrMpUdWt1nbnrV4fwZRlCFCtWyTYa9usdA+zx/A+V5qqXWHdJBknoMJ2j/n+zyx0MyUc1VcfU6EDmlm4UzF0QwpCE68aEQeI8gAT79DVSBjL7fOxh9HCjFqemF34eezAEfu5Q/vWtgLq/a/6kehd1gQxcpKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nznjg6SH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nznjg6SH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02A61F00A3D;
	Mon, 24 Aug 2026 18:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787596090;
	bh=JDo/Bw9hLY5yczKBiwe/3eIR+Eo88QQEYPZ6Tm50ma4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nznjg6SHbAIUErQmp3oNZNk+JDYf82TJXs/LuFA3AKqXjuhm7aEyylSIm6kOihEZ8
	 64Jpi004zPe1k+MkYQ7g5He2OW86vXPT/nhdLyGVtA7SfYfAAsGO0hSsV3lA748f2o
	 mBCrFXYnoZ74WypI7waS0L7eE8PLAZaZ2C6bFPuc3OOXq+teC0HrE35HRzVkneMNKa
	 qs2xKvjz2d0y/0MsvgkffHsuEQ/ZeEaxgOJ/LiL7b5V34UBuQaIckPhWaue++xEN5+
	 QltvV3Z0GMjX0DhEAYwk/d7nKabSmjawsCoZFzh/+n8vrVmjH4h/eNGvuSx2cTWUon
	 0X0nOo9I+1T7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] drm/amdgpu: Allocate coredump ring buffers per ring
Date: Mon, 24 Aug 2026 14:28:07 -0400
Message-ID: <20260824182807.271396-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824182807.271396-1-sashal@kernel.org>
References: <2026082041-sporty-underdone-82eb@gregkh>
 <20260824182807.271396-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit e40ff9840fa8a633d149f0242df10cae5e518062 ]

Allocate each ring buffer separately. A single allocation summing all
ring sizes can exceed the page allocator's MAX_ORDER limit and fail;
per-ring buffers stay small enough to satisfy. The existing allocation
style doesn't capture any ring data if the huge allocation fails.
Splitting into multiple allocations helps to capture as much data as
possible for the core dump.

A failed ring is left with a NULL buffer and skipped when formatting.

Fixes: eea85914d15b ("drm/amdgpu: save ring content before resetting the device")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Code
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3e8e92b7892a6377bef86106bfff1b98cf586aee)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 50 ++++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  3 +-
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 5ae9fde80e510..029f678e59b7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -339,7 +339,7 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 	struct amdgpu_ip_block *ip_block;
 	struct amdgpu_ring *ring;
 	int ver, i, j;
-	u32 ring_idx, off;
+	u32 ring_idx;
 	bool sizing_pass;
 
 	sizing_pass = buffer == NULL;
@@ -439,7 +439,6 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 		for (i = 0; i < coredump->num_rings; i++) {
 			ring_idx = coredump->rings[i].ring_index;
 			ring = coredump->adev->rings[ring_idx];
-			off = coredump->rings[i].offset;
 
 			drm_printf(&p, "ring name: %s\n", ring->name);
 			drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx RB mask: %x\n",
@@ -448,12 +447,18 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 				   ring->buf_mask);
 			drm_printf(&p, "Ring size in dwords: %d\n",
 				ring->ring_size / 4);
+
+			if (!coredump->rings[i].ring_dw) {
+				drm_printf(&p, "Ring contents unavailable\n");
+				continue;
+			}
+
 			drm_printf(&p, "Ring contents\n");
 			drm_printf(&p, "Offset \t Value\n");
 
 			for (j = 0; j < ring->ring_size; j += 4)
 				drm_printf(&p, "0x%x \t 0x%x\n", j,
-					   coredump->rings_dw[off + j / 4]);
+					   coredump->rings[i].ring_dw[j / 4]);
 		}
 	}
 
@@ -494,10 +499,12 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 static void amdgpu_devcoredump_free(void *data)
 {
 	struct amdgpu_coredump_info *coredump = data;
+	u32 i;
 
 	kvfree(coredump->formatted);
+	for (i = 0; i < coredump->num_rings; i++)
+		kvfree(coredump->rings[i].ring_dw);
 	kvfree(coredump->rings);
-	kvfree(coredump->rings_dw);
 	kvfree(data);
 }
 
@@ -539,9 +546,9 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	struct amdgpu_coredump_info *coredump;
 	size_t size = sizeof(*coredump);
 	struct drm_sched_job *s_job;
-	u64 total_ring_size, ring_count;
+	u64 ring_count;
 	struct amdgpu_ring *ring;
-	int i, off, idx;
+	int i, idx;
 
 	/* No need to generate a new coredump if there's one in progress already. */
 	if (work_busy(&adev->coredump_work))
@@ -581,7 +588,6 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	/* Dump ring content if memory allocation succeeds. */
 	ring_count = 0;
-	total_ring_size = 0;
 	for (i = 0; i < adev->num_rings; i++) {
 		ring = adev->rings[i];
 
@@ -590,38 +596,34 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 		    coredump->ring != ring)
 			continue;
 
-		total_ring_size += ring->ring_size;
 		ring_count++;
 	}
-	if (ring_count) {
-		coredump->rings_dw = kvzalloc(total_ring_size, GFP_NOWAIT);
+	if (ring_count)
 		coredump->rings = kvcalloc(ring_count,
 					   sizeof(struct amdgpu_coredump_ring),
 					   GFP_NOWAIT);
-	}
-	if (coredump->rings && coredump->rings_dw) {
-		for (i = 0, off = 0, idx = 0; i < adev->num_rings && idx < ring_count; i++) {
+	if (coredump->rings) {
+		for (i = 0, idx = 0; i < adev->num_rings && idx < ring_count; i++) {
+			struct amdgpu_coredump_ring *cdump_ring;
+
 			ring = adev->rings[i];
 
 			if (atomic_read(&ring->fence_drv.last_seq) == ring->fence_drv.sync_seq &&
 			    coredump->ring != ring)
 				continue;
 
-			coredump->rings[idx].ring_index = ring->idx;
-			coredump->rings[idx].rptr = amdgpu_ring_get_rptr(ring);
-			coredump->rings[idx].wptr = amdgpu_ring_get_wptr(ring);
-			coredump->rings[idx].offset = off;
+			cdump_ring = &coredump->rings[idx];
+
+			cdump_ring->ring_dw = kvzalloc(ring->ring_size, GFP_NOWAIT);
+			if (cdump_ring->ring_dw)
+				memcpy(cdump_ring->ring_dw, ring->ring, ring->ring_size);
 
-			memcpy(&coredump->rings_dw[off], ring->ring, ring->ring_size);
-			off += ring->ring_size / 4;
+			cdump_ring->ring_index = ring->idx;
+			cdump_ring->rptr = amdgpu_ring_get_rptr(ring);
+			cdump_ring->wptr = amdgpu_ring_get_wptr(ring);
 			idx++;
 		}
 		coredump->num_rings = idx;
-	} else {
-		kvfree(coredump->rings_dw);
-		kvfree(coredump->rings);
-		coredump->rings_dw = NULL;
-		coredump->rings = NULL;
 	}
 
 	coredump->adev = adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
index 63f27337c09ad..cb874d8c33947 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
@@ -34,8 +34,8 @@
 struct amdgpu_coredump_ring {
 	u64				rptr;
 	u64				wptr;
+	u32				*ring_dw;
 	u32				ring_index;
-	u32				offset;
 };
 
 struct amdgpu_coredump_ib_info {
@@ -53,7 +53,6 @@ struct amdgpu_coredump_info {
 	struct amdgpu_ring              *ring;
 
 	struct amdgpu_coredump_ring	*rings;
-	u32				*rings_dw;
 	u32				num_rings;
 
 	/* Readable form of coredevdump, generate once to speed up
-- 
2.53.0

