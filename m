Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048761;
	b=LyelSh8ku8cPpBZaNWQ8XLZCxX18/rxfpQk3nBfiRZNjEW9cE10/I1BUxlFn51RUNHI2
	 zlZ07PsdzRFugGiSuh369lQMt3wkeug+CqKdwbXVf4HpBfPVP82+yFgyeOr77M9RePaJi
	 rVSIiyYXJw/LeoAkPIqiq3DvB9mSk5PWgDslqL1tkTkbNz4IS4mQ5AbeVVSq5XQLWyVhc
	 FnOkXUoV1RyL9NIc02TgKsSl59Ab+FyvEP5LucgNRCVgmWWXBT7kFvkOxgDAARr53qrl3
	 McR8bpl2jaXmS/RU/EJw7gQpgE8IQcac0cfPeACetUicqKMIgZkYOWTXZmfSXax8RMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048761;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4C2DIzByo7V5SLw0cZHdo7aOEp8Czj2BUQP97gusdSA=;
	b=PAqv9264P4Q7CAXJ4W+dJrSiCMAixKFyFafExQZ+IO1vn3Dp6a7mxY10zlFOvpFuFIdv
	 vz1rFix1VpTbmBiHgFDOyWFgEw2VQEiKmZGZZoFBVSCk3s8ucsxvuYEMr5FZqEsW9ehJ5
	 g8GmwPUUjrXGF4SEIsiGaMfs4knNVKLGbGcimH/gKek41KsBBSOyZeqe4UNl7lSFM/Qpn
	 gGuHsOQzoC+/C0zVukhYNNkIB0amzSkDIglTQ1ujWMTwlE9Kb6OqbcsL3w1ns2styiRxs
	 TACfsLQAlug9CYbQzx0r6V5cT0nBgEu4gOWYbM5snCBO7m00NX6+u/nGw998nAVNS5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6IgkwGN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6IgkwGN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4279F1F0089F;
	Sat,  7 Nov 2026 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048760;
	bh=4C2DIzByo7V5SLw0cZHdo7aOEp8Czj2BUQP97gusdSA=;
	h=From:To:Cc:Subject:Date;
	b=X6IgkwGN3PMy7xvX6ZC2S/oANGMtgS5NU9uPVglPepRLWWDUzNvhr3LFhLlhwDRjb
	 zO1Zdit6NoLcoZydnoLXoPhUhH6QfLrFW32eUwIenMlApuNtWQBLQvoORQvlbQY9FV
	 6H57o+2vBTd4/MtRP+Uu7XADwtLIhnEiuJ8uy8w1Io4+W7tzMifPtIkBt1fmZF3ttl
	 2GH2ABvpTmogdIekiqsLyuTiJTbraz+oSgzEUiYa20yHOqXIAjpT3peFmDRkJ84DYc
	 odbnTuBdbw39lS0lFGeQxchBHxLEqZKjz1GomJFgo4NPEScwPkDU7wy9SR9vuBFxV3
	 EiufV447/99Og==
From: Sasha Levin <sashal@kernel.org>
To: daniel.phillips@amd.com,
	felix.kuehling@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] amdkfd: Fix memory availability double accounting of kfd pinned objects" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:52:39 -0500
Message-ID: <20261107055238-failed-6.1-16df12d7158f@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 16df12d7158fb55f20d6e985abd1996cbabab9f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055238-failed-6.1-16df12d7158f@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 16df12d7158fb55f20d6e985abd1996cbabab9f8 Mon Sep 17 00:00:00 2001
From: Daniel Phillips <daniel.phillips@amd.com>
Date: Sun, 5 Mar 2023 22:54:35 -0800
Subject: [PATCH] amdkfd: Fix memory availability double accounting of kfd
 pinned objects

Pinned objects that are not kfd objects reduce the total vram available
to kfd, so we subtract the total size of pinned objects from kdf vram
availability. However this double counts objects pinned by kfd itself,
because they are counted both as used and pinned. So track the total
size of objects pinned by kfd and add it back to kfd availability to
remove the double accounting.

Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b8257bdb26ca5d9a75f4b81f629422f17afa221b)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index e3da382ceb3c0..a53d7e4a1eb5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -106,6 +106,7 @@ struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	int64_t vram_used[MAX_XCP];
 	uint64_t vram_used_aligned[MAX_XCP];
+	atomic64_t vram_pinned;
 	bool init_complete;
 	struct work_struct reset_work;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9a7e14a3c7197..129acb88dc11e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1536,6 +1536,11 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 		pr_err("Error in Pinning BO to domain: %d\n", domain);
 
 	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
+
+	if (!ret && bo->tbo.resource->mem_type == TTM_PL_VRAM)
+		atomic64_add(amdgpu_bo_size(bo),
+			&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+
 out:
 	amdgpu_bo_unreserve(bo);
 	return ret;
@@ -1558,6 +1563,11 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 		return;
 
 	amdgpu_bo_unpin(bo);
+
+	if (bo->tbo.resource->mem_type == TTM_PL_VRAM)
+		atomic64_sub(amdgpu_bo_size(bo),
+			&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+
 	amdgpu_bo_unreserve(bo);
 }
 
@@ -1679,6 +1689,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 		vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
 			- adev->kfd.vram_used_aligned[xcp_id]
 			- atomic64_read(&adev->vram_pin_size)
+			+ atomic64_read(&adev->kfd.vram_pinned)
 			- reserved_for_pt
 			- reserved_for_ras;
 
-- 
2.53.0




