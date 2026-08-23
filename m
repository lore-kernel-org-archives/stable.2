Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A972DF144;
	Sun, 23 Aug 2026 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787477415; cv=none; b=SHNyj1xRlzX+7sa3fFq2dwf9oruptZSfWHAPFuw91herozRJWeXLo1+vrNOwxKJKSWuvRPmGrcazMDRtbDzwH4E6VeH8x+R4tAUb3xYskhCx4GGfX/Nd123NLIC8oqu3lHm6jW1WEiOiHxK2WCCXdADEHicVs37Afz7W96QBGAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787477415; c=relaxed/simple;
	bh=655xFNDjwdaRJw2DcZRdJ/eQ8Vf6i6wGHetWsHK0bB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FT4Gx4zPRYKnZ/WVnt+ClLc2sD+T+UqiIIJk0Qy66SHVjVAwIFp1uy5/jdUFblg9DbrE9Bo7o32UI/zfeq1S54ArPouqOFhLC8FYmnP3vyqZNjeaaRw2crbesTzIzK4MRdbz2g1mA9pumPs5PTu4oaSDYHlDLUfTqlNGvURuhVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=eW+pI3Mr; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="eW+pI3Mr"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4af9abbbe;
	Sun, 23 Aug 2026 17:29:59 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] drm/amdgpu: return reserve errors from amdgpu_gfx_kiq_init()
Date: Sun, 23 Aug 2026 17:29:36 +0800
Message-Id: <20260823092936.992430-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa02df497e303a1kunm6a20afce1f1049
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTk8YVkhNQxhIT0NLHRpPTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=eW+pI3Mrp1r5JMSqBpNa3D4T4dbvWhTTDQaGT0NyzTgARDKDi68gASyeAnsFWVOylz+9y8Ncfre/p7bit68wZL2gBFcyLDVe3J1sgYEucfMDB1kwxOIxRvJWbxWPelJk/lotEiECsEFmxeYLFfsGvxTstDhkKJQX9vG7GNGcxnA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=DZCF195lvOLI9A+UGOu/tEfVuLdJBg6brLP10koFIis=;
	h=date:mime-version:subject:message-id:from;

amdgpu_gfx_kiq_init() reserves kiq->eop_obj after mapping the buffer.
If amdgpu_bo_reserve() fails, the code still unmaps and unreserves the
BO and then returns success.

Return the reserve error, but keep the kunmap cleanup. Only call
amdgpu_bo_unreserve() on the successful-reservation path.

Fixes: 71c37505e7ea ("drm/amdgpu/gfx: move more common KIQ code to amdgpu_gfx.c")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c5aa465231c4..630d0fd9ac13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -241,8 +241,11 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 	memset(hpd, 0, hpd_size);
 
 	r = amdgpu_bo_reserve(kiq->eop_obj, true);
-	if (unlikely(r != 0))
+	if (unlikely(r != 0)) {
 		dev_warn(adev->dev, "(%d) reserve kiq eop bo failed\n", r);
+		amdgpu_bo_kunmap(kiq->eop_obj);
+		return r;
+	}
 	amdgpu_bo_kunmap(kiq->eop_obj);
 	amdgpu_bo_unreserve(kiq->eop_obj);
 
-- 
2.34.1
