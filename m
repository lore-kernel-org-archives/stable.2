Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047863;
	b=H/I/fNr5F7VFItZDmalSgQQRIBoWu3Ny8HFKXdEPAtFKu8RGl68WV+H6OO00p8/0EE8P
	 KHwKEgoaddJlqXedB0j8TvSQ7hdvJ5jO+QUCgX7UFgXJtwXx0JvEu99eGlF+u2+fQEVid
	 WWj8kUzbipB/hLstypbVpA0hDZZ8ZQKsxjO1iEzI9L9oFA5mYU9JrcG2ryVqypHWRUiIf
	 94A6TqUptIsBNipp2xGKBWdmmwrBmOejv2aBtBdQFRONNDFJTZ/kEoEIhRcl8RFYGXCsI
	 hzBibQ8tibPo139nie4+PlsjxAUc+4I6Bxaof9jRoLEi4PXamMGwNcOCI8yQosDLkag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mejKExHAZNujeN0Ai5L6OMzlnpVudZhaE4KpNnxZdw0=;
	b=01d02HGb/qCllaeF99SJSJLmF7JzT5rvx0Bt1DXUiSRUwPu0uoUi+kA9qWuMuy8AstYG
	 lMktpMycJshWrqV9q8leX9CE/DC2nYc/2+9/X8ljMnLL9AS/oEDTOw4OsHuNZN5bYUb1H
	 WtGW/9Og/X4tn4jGBM5ZSW8k4urOFGmvWn+KnWqhBUl7u/gaNwwbs61fN+zZxUk1kPgYq
	 fgpnrQ4nucBCvt6ih27/h20ysiFMPnBVFJmgRgVtnP2uY9NJGUmEY9XvglvksTNfYrTkw
	 5spmGIQGn7hYLcU17bU9BZQku3JTNs4MMgUnR7NvIo0yXMTGxhacAUKooj6ND4dlFbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEJJjmjo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF5606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEJJjmjo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C831F0089F;
	Sat,  7 Nov 2026 10:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047863;
	bh=mejKExHAZNujeN0Ai5L6OMzlnpVudZhaE4KpNnxZdw0=;
	h=From:To:Cc:Subject:Date;
	b=UEJJjmjoDLz9n2gmxE2N5xDrRsdgANqHayTI4X2laZ3nXIbaqE8KYZE7m2VSzHgzE
	 ij7aGnoniHiKminJPSReIKvp6qZgjesLtah8Sw3dF0uemYSAT3gfkWQRh9znbkX4rc
	 od+VMBZOvUpVTGDTi/xBgz4j7KJB3t8vwdF0fxiHgfYE3NA3dWdnIHHbwi/I6WcTXC
	 izPHBXqsBlfVTsHGwtu8ZXfk3lVdOjNbmXCL7vMEjveRmtC/V2BNJ/zoUx1RDrutdx
	 5YupKJnYkTq2Su/6ycBRDkDa0o1xm/SzPXb3d2CSNjJR/srf5GNydtoqkYqyzxtbRy
	 uLZFA+QwlprZw==
From: Sasha Levin <sashal@kernel.org>
To: daniel.phillips@amd.com,
	felix.kuehling@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] amdkfd: Fix memory availability double accounting of kfd pinned objects" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:37:41 -0500
Message-ID: <20261107053741-failed-6.6-16df12d7158f@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 16df12d7158fb55f20d6e985abd1996cbabab9f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053741-failed-6.6-16df12d7158f@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




