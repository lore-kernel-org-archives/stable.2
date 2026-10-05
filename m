Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD35202C29
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208541; cv=none; b=nj/zWnIfKOUqXAKuT3cORQ4UosVZiF7GR0DtMY2NLJBwdpwTLUVs+mtaTjVDXo1cL17drcDa9ZtBibXMJruwqOgiC8KXORmCMA+Cs6Z5ThQihP1vPwneUQriDro3gVWo80ACsPZQfiXYCZmFbb/qnV2VjAHFmzjnSWS6ZATYyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208541; c=relaxed/simple;
	bh=Ap9HpUp0cM0t5GHkBi0Uc/6b6AUhwNZOcIHC+roGt4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecPMVQ3gnPw6x+hIkaThOwjfPHuq4jM6G0MFKSo6PXeR+HQysJ30X9mcBe4iJidCxVszY9Cp1d+32GEBWGNsQRP8jAl5l+tU9OBK71o21bZyzlvzoVD1oHy1QyFi4SdvMSfluyggYZuuJLAbefKrm5qQwH097EPzxvXRzECO1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PohUc8RQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PohUc8RQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66011F000FF;
	Mon,  5 Oct 2026 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208539;
	bh=DNrhJne5KLRucCDw+W2fSJzZapynG9BGSX+30Kq3dfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PohUc8RQppr9LjWSRgmvQZUGGjU9p0/DidCeOh16u0kqquBDrNAX3FRdu3f+IJ8U0
	 HXFj0IJsClIrBBvnvKm9wvP+sBIrCByc0D/2Pjjqfd6UK4Vu31zySICUn1iD7sjFxh
	 NjrkGF55dT8q72+OFz6kaC4LJ+Y7P7Hkjv/lme2rmNmRqw13sPeXS7DCc5FRL/5WGC
	 tGIjM4P1qQ8wVM2GMPti3/BAUVaQYTA5ltVoTZ88r9KZqjnFU+BsSg/JkgrAd4DUnY
	 c14O/RNBpBREXqnFZpcDQyvl2zseRv1kQb8AXPhtNwM/rzaJtip6YQZyWFjpR60saa
	 skcRsHYAI2bAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Willian Oliveira <williandossantosdeoliveira287@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu/gfx6: fix firmware leak on teardown
Date: Mon,  5 Oct 2026 09:55:36 -0400
Message-ID: <20261005135448.2964978-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100502-reprise-spinner-8d6e@gregkh>
References: <2026100502-reprise-spinner-8d6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willian Oliveira <williandossantosdeoliveira287@gmail.com>

[ Upstream commit cc172e177795c5f87bc2d71768d077e1c10633e8 ]

The firmware requested in gfx_v6_0_init_microcode() is not released
when the GFX block is torn down, leaking the firmware resources.

Add gfx_v6_0_free_microcode() and call it from gfx_v6_0_sw_fini()
to release the PFP, ME, CE and RLC firmware.

Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 386e81346f95ab0be5a82c5535de932e7a456924)
Cc: stable@vger.kernel.org
[ sashal: Replaced unavailable amdgpu_ucode_release() calls with inline release_firmware() and pointer clearing in gfx_v6_0_sw_fini(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 8f9a2e9c276ae..8d894a55c5d1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3222,6 +3222,15 @@ static int gfx_v6_0_sw_fini(void *handle)
 
 	amdgpu_gfx_rlc_fini(adev);
 
+	release_firmware(adev->gfx.pfp_fw);
+	adev->gfx.pfp_fw = NULL;
+	release_firmware(adev->gfx.me_fw);
+	adev->gfx.me_fw = NULL;
+	release_firmware(adev->gfx.ce_fw);
+	adev->gfx.ce_fw = NULL;
+	release_firmware(adev->gfx.rlc_fw);
+	adev->gfx.rlc_fw = NULL;
+
 	return 0;
 }
 
-- 
2.53.0

