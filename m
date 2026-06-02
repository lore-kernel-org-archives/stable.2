Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C72D7DEA;
	Tue,  2 Jun 2026 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376989; cv=none; b=rzvTjf0j6YMjmINdzFZ5PN9dlM1z6I2StasI42oBP0uBAsl54DHwo1OMsL7sKmfL01OESu1t59h1EMNlXtL+aXh7B6Pxr01AOCthm2zzfsUpuXWkSQetJ55xkcav+KELoON9eobGD+7sUR8TuXiv/hqFAfblqrGKw34i9y8RebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376989; c=relaxed/simple;
	bh=1sdhyNwedp3nB+fvuVo8riohKlXgGy0/Fcp4a3geIbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/CuDn8UeAnjayvZjCvp/W0bz4Ojvyd2EEoXEBKWlkAvrWfxDPMR/VXPsd5ugAcqaHdsjeVjMlmwRkztUlFErV4B4YZcGZoa+TqcWzVPdXDhVRTGNc1AUJwuTZUAfzIdzf7imiNY54PcSdADfma4echLM9q9qVD1iEJvqljphfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=EWm+v6Wp; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="EWm+v6Wp"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40b387ce5;
	Tue, 2 Jun 2026 13:04:23 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	kenneth.feng@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/amdgpu/mes12: fix queue init wptr reset
Date: Tue,  2 Jun 2026 13:03:54 +0800
Message-Id: <20260602050354.2237095-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602050354.2237095-1-runyu.xiao@seu.edu.cn>
References: <20260602050354.2237095-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e86b7f5ff03a1kunmb7f79aef178c11
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQkJJVkIfHkgeTUIdSk5LSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=EWm+v6Wp4FQK2zA0zKjBoe6WZIbg1GLxC77rp9x4rOA7jma/PQApAPonjXeJxRjIhW3h9+rqihkc7+SGMXo1yVBo6927wrOhGwcEyCCxlKvEhEzkzfKzNv/Rrw+/KOWitjp99jh5BGxmwZBKZzz6yV0ZL5HBVbNCjTSOwE4yjFo=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=D3xcZv25/w2ySOWXApKK8LTp/+QDmMdOM7MaVAFD9Og=;
	h=date:mime-version:subject:message-id:from;

mes_v12_0_queue_init() resets ring->wptr_cpu_addr with a plain 32-bit
store in the reset/suspend path even though the same carrier is
accessed with atomic64_set()/atomic64_read() and support_64bit_ptrs is
enabled.

This is not just a missing atomic annotation. The MES queue write
pointer is a shared 64-bit carrier, and *ring->wptr_cpu_addr = 0 only
clears the low 32 bits. A later atomic64_read() can then observe stale
high 32 bits instead of a real zeroed reset state.

Use atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0) so the reset
path updates the full 64-bit wptr with the same access family as the
existing readers and writers.

Build-tested by compiling mes_v12_0.o.

No AMDGPU hardware was available for end-to-end runtime testing.

Fixes: 785f0f9fe742 ("drm/amdgpu: Add mes v12_0 ip block support (v4)")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 023c7345e..22ed7bb51 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1476,7 +1476,7 @@ static int mes_v12_0_queue_init(struct amdgpu_device *adev,
 
 	if ((adev->enable_uni_mes || pipe == AMDGPU_MES_SCHED_PIPE) &&
 	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
-		*(ring->wptr_cpu_addr) = 0;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
 		*(ring->rptr_cpu_addr) = 0;
 		amdgpu_ring_clear_ring(ring);
 	}
-- 
2.34.1
