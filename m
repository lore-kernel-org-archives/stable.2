Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651194B66E6
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212235; cv=none; b=OOAdu5FdP5QfMis38a6erjBqT3/NDqcBi1PIu1xULmDXQdwR8elTh40loXaZ4yjRBtOJwLxftFTX++QbUpjifWfHBY4LIR8pBbsv6HAk8nxxhe6rkrWl9Cs1/rMgWinjOiorG2HNeBOLrt1nkmuWtFF9Sb2DY2Rshx3/l+UreEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212235; c=relaxed/simple;
	bh=FMrXe/9HNIFartbyyMu9VZn+wu81MOmHAKIrVmSVCH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PppCCAivMlBVMXMB9FyuS3yHduAQtKVHuHP838itwn7YESFXyRgyfec+YL/VPuArV3db3/jjHpaA0CKfd/bKjPO7cdEaL1YjrDFlmpOrRINKo/Yqhr7QeVOWZhYulqlw9h581WsVnMlj8woqfwzCZ2zXfo6iOrOiKSjd7CxfmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaTz7gnG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaTz7gnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D8D1F000FF;
	Mon,  5 Oct 2026 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212231;
	bh=4f5QpK421S3iQiB0VwXq4qcl1SypOdrR/I6lRg1jblc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YaTz7gnGEzU9LS+GGApA3+5kfMZdFiFx40qf9x9I+4svKpnTRV7St8VZF/Db6ZS1h
	 r0uxFuOYkQzpRLewmNVi2sdg4NUQ3U+dl02qe/IEgsAU4m99oJeob08xenQBNvZUbZ
	 2f3cT1YCpxW5bfoC5u9zwn6ZRMtULdvlwmRMym987nqdZihmyCA6ijeyIh9tA6EO7K
	 dY5Rkcg9z6bt3b+GNHii57mmWnK4WLu0uo9zCDhBUY9QTQZGVwy/E23FjaBDQXyC8S
	 vo1f6ta2DKM3CHlgqgA5YkLPjG6X2hzO9i+10y5G1o4KHHULdIrjWrJBYwFoyPv9a8
	 j3xH29Y6XaPiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Willian Oliveira <williandossantosdeoliveira287@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amdgpu/gfx6: fix firmware leak on teardown
Date: Mon,  5 Oct 2026 10:57:08 -0400
Message-ID: <20261005145612.2994689-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100550-achiness-flaky-b759@gregkh>
References: <2026100550-achiness-flaky-b759@gregkh>
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
[ sashal: Replaced unavailable amdgpu_ucode_release() calls with inline release_firmware() calls and NULL assignments. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 37592cc9f2c50..c0e513f5b6220 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3219,6 +3219,15 @@ static int gfx_v6_0_sw_fini(void *handle)
 
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

