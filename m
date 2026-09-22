Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519347ECC6
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106510; cv=none; b=tFd5jLZFKHugKtBXA3XOIYZjdonnKzEOYvsVazj0ueq/5rd46Zbls8+wq9zupJNxmC8afhRdDODw4SFcZjFV+/2rg8+RRe9rAaVrDtwfWQacqVYhP9XUbtSL8I4Dxsx1C4l3JBtvwgk5+F5OtDDcPdvDwVEBBldhaxyUAmxSef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106510; c=relaxed/simple;
	bh=N48I7qcc+Ik6TxknEfnjZQ8oGqDbzS2vTUSEPXEWdaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXYM0BlsiyBfbiFV4MBhkd6fdvKttT/KJ+/7PnHmu/MmUKs3IT+9mUjM13ILL611cPCZ8R1NyzC5EfoNlx6+A/DWg2APjql/xyKFTvK2nJQj4EmNPC5piwJnwvQ5sNiS2ZICUPqxM+v+mpvlcKZWHteMA+lgVhopKIuwqgkTQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg8+qjvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg8+qjvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4771F00893;
	Tue, 22 Sep 2026 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790106509;
	bh=TxXntS8c1JUYpCfRQbmMUeJH/UojfXj1ZVy5l6lo9c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cg8+qjvp2qqKScm1jwkt/tQJqowI/O5t1uUoErmQVbZnAeHreaNamLclBno2n5JEX
	 y9vowCltJmfP8BEzsCgDsuGS8opBTfbXtm6QYXsTxVmYt22+nDzzRhiitkgbp+3uca
	 Ve9axklS/VwzGWIsti3SYlBP7j1CVLb/DLG4xlpUUDZP/nUAwkR5ZuccR/8LMNTuPr
	 qwmD+5ekjt7iUoUANSaph22eN8/ORbzAteA85U8xNvLk3taYZYfDXXKNq+pMOyoo44
	 nvWIsWCQr2PwUv6CwVaD6Nfbz0bMl/Mce5aQ9nJU6wjmqykNYNmSxXnSNaiVQ0D+Bl
	 tAAYE+ad9hihA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengjun Yao <Chengjun.Yao@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] drm/amdgpu: fix rmmio iounmap skipped on device removal
Date: Tue, 22 Sep 2026 15:48:23 -0400
Message-ID: <20260922194824.87651-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922194824.87651-1-sashal@kernel.org>
References: <2026092241-jolliness-reputable-efa6@gregkh>
 <20260922194824.87651-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengjun Yao <Chengjun.Yao@amd.com>

[ Upstream commit 5155002b03b24ba3ef91c5c313b8cf0171b24904 ]

amdgpu_pci_remove() calls drm_dev_unplug() before fini_sw(), so
drm_dev_enter() is already false there and the iounmap() guarded by it
is skipped. This .remove path runs on both hot-unplug and plain rmmod,
so the register BAR ioremap mapping leaks one instance per unload.

Unmap rmmio unconditionally (guard only on non-NULL) and drop the now
unused idx.

Fixes: 62d5f9f7110a ("drm/amdgpu: Unmap MMIO mappings when device is not unplugged")
Signed-off-by: Chengjun Yao <Chengjun.Yao@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit dd6f86a97260e5207d3329ad03aa89fdad61b1e6)
Cc: stable@vger.kernel.org
[ removed `int idx;` entirely because the isolation cleanup loop requiring `i` is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 908f4539c779d..228aadaf3f4d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4776,7 +4776,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
-	int idx;
 	bool px;
 
 	amdgpu_device_ip_fini(adev);
@@ -4814,11 +4813,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_unregister(adev->pdev);
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
+	if (adev->rmmio) {
 		iounmap(adev->rmmio);
 		adev->rmmio = NULL;
-		drm_dev_exit(idx);
 	}
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
-- 
2.53.0

