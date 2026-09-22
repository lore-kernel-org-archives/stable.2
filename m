Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89BF33ADB9
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103076; cv=none; b=ct5+sFZ7NNdbpJ6nrKqvSHITELp1eTcn0BMBjdNbL22rNf5HRU28RipnM36ZdmZW5rRwavdYUmBgENo5G7Expjf8jDdHwrDs3mMLo3VUN9KgEDt2AzX8tlG9dQ8o1DGAXuWeh1sGzLN0yuTKG38jBbMm/Ke46FLm8LZjbPkf5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103076; c=relaxed/simple;
	bh=uSt5HGENkSzKeLM7YG1zvQiFhZ9kGV9pPmTU7v2wUrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyMKtUnfGJWqmkJVXQpmPX2BNNEcY+BwzlifTfLwH/1+mlGyugqxL4sIIFECrZuHkiJYUi+pRgnglBWUXB1zRBa2TZkvpVUDOHq46V1tqGizgze5xtHZH+KiqcQgaAy6xkk9qpxEUfJ/u3fC9XDgYNEEoWHZEYriqdiwDVgoq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkKAHqK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkKAHqK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC221F000FF;
	Tue, 22 Sep 2026 18:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790103074;
	bh=iTI6mIfA6bQJ+X7S2ZebytqveyZYZpU1Gl4veF5ZvtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WkKAHqK5GzV5AvOPm3ut2OyDTaRnjAGV0Waf4sWHgpAsrjno7Ewhc/VLHghPqY3Cw
	 GiTU1u3qQCG1T/earxF622Xvukc5FQxK6/xxRXjfk4IzeWmjnHeP6/Ge92+zCwYQxn
	 CaWJ1PFydQhlf/rHHIanV6McuJKcRcATSG9PBk3+whLR+oVhn/u312f6NBwDh/cbuV
	 +jNukLLCHKnp50YzGN6g2yBYYXqSeQowl+E1KooOpS2ncK9t673WHk1kqc69ZvtAmc
	 +wRo7sf3lIlIs0RW/kXBBlGIT/beYkkdXd4O4fx27iVatqEdfcoXNkwugeiRsE/TSx
	 HVDHcl/zwEEBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] drm/amdgpu: lock bo before calling amdgpu_vm_bo_update_shared
Date: Tue, 22 Sep 2026 14:51:11 -0400
Message-ID: <20260922185112.3837468-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092254-cactus-employee-2903@gregkh>
References: <2026092254-cactus-employee-2903@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit 36ffc58b8a8704e690a0ce679db26baa5759256f ]

BO's reservation object must be locked before using
amdgpu_vm_bo_update_shared otherwise dma_resv_assert_held will
complain in amdgpu_vm_update_shared.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 636139603b99 ("drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index f20d4bc58904d..83fed04436ad7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -81,6 +81,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	struct drm_gem_object *obj = dmabuf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	int r;
 
 	/*
 	 * Disable peer-to-peer access for DCC-enabled VRAM surfaces on GFX12+.
@@ -98,8 +99,14 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
+	r = dma_resv_lock(bo->tbo.base.resv, NULL);
+	if (r)
+		return r;
+
 	amdgpu_vm_bo_update_shared(bo);
 
+	dma_resv_unlock(bo->tbo.base.resv);
+
 	return 0;
 }
 
-- 
2.53.0

