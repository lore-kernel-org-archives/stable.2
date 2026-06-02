Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376912DA759;
	Tue,  2 Jun 2026 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376975; cv=none; b=ZDNtI37jswGyy1UFsBqPaXz96HcaUflIoq4weG0aSEi0xhJClr0itwSLGNIKus2sPNNFad8HG4ZUDsTA100qbi8EVm6PMG8xbfEIBadOh52TQqGjC4iNUw6Nm9WedG3BBKd0MyQcxC20esMjzyVam+OX91V4UCXGKGvY6lv/Cp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376975; c=relaxed/simple;
	bh=Qt4cnTAcUdjy3wEVaZhzjOTQVPC1tGRaVX2tb1jacN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfiP4WyDM8i7tB+r810NUpMiMwrV2Xbf7sXR0iRT4/6EMgID/BY0fKkiAOqMwwBB7DPBllEpnHF0YbAPtJ4Ioms1ZCnaEtBURFJSKOmKZbBoLnkiyur4U0zptrQD6mq7LYeZGpgLY/0ki1L5274smAxOUolZHPfKGsms35Qwxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=MKydO2UR; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="MKydO2UR"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40b387ce2;
	Tue, 2 Jun 2026 13:04:19 +0800 (GMT+08:00)
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
Subject: [PATCH 1/2] drm/amdgpu/mes11: fix queue init wptr reset
Date: Tue,  2 Jun 2026 13:03:53 +0800
Message-Id: <20260602050354.2237095-2-runyu.xiao@seu.edu.cn>
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
X-HM-Tid: 0a9e86b7e7c603a1kunmb7f79aef178bd9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQx1MVkMaSxkZSUIdGE9OS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=MKydO2URJvMNqsbFPbiRAoftsZowajUZtt6lsy9k19RG7YsszGIn5LmMGQaosIYM6+c/S90Sw7gnIha8QPsAH7wbK62uz0Y1nb4ZsfK7VNOj0rmdrGd8LuTi0jdW/B+evOnS7Yt+QL1E08BXd52T3SvimSJ7OUNN5AiOgG1+y4A=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=A2XxhCSxRVdO/XEV+e5GPXDXNkjjX++njluVS+LkACU=;
	h=date:mime-version:subject:message-id:from;

mes_v11_0_queue_init() resets ring->wptr_cpu_addr with a plain 32-bit
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

Build-tested by compiling mes_v11_0.o.

No AMDGPU hardware was available for end-to-end runtime testing.

Fixes: d81d75c99936 ("drm/amdgpu/gfx11: enable kiq to map mes ring")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a926a3307..e2f762c2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1308,7 +1308,7 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 
 	if ((pipe == AMDGPU_MES_SCHED_PIPE) &&
 	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
-		*(ring->wptr_cpu_addr) = 0;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
 		*(ring->rptr_cpu_addr) = 0;
 		amdgpu_ring_clear_ring(ring);
 	}
-- 
2.34.1
