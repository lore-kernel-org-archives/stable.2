Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439843;
	b=rLe7v8nUlHLrqxIWX5u6BpXJnoKeMZcbz24n1ofDp32+IDuEiWlpjF/KMKT2Ombxk4tk
	 REqJn5wjjktAK2bacsPhtQ9Et3pqhumQQ6r93uQzc0uI525F5zBPz/ILCrLtOe7OQNQ+S
	 cbifj3vk2coB/KbK1rjayFYQl4qu/mgTFuU1llV7s/D9KvTjQJ98/eCcvk9023imY4nJx
	 fPuP5mpw+KSDLpNZ7QGwKYLZs6n9/8vI8ZJQmzGQES+B5USuO1cJlwPhpXppfXU5MLU76
	 EJ/D81xcZ6W6oiD+MHvIQLNyTwYiOp5PWQ5/1ZC1F3BNlvNVrGBl2cdfezlo+tTW8Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439843;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zWNa7hT8dt83dYZn73hxoHnub6DPe/pvvAFdWzST1Iw=;
	b=vDqwM04PnbIEn+XjcGA7KykQQPVZPk3tBbeGr0JTxtzKaLTk6DhNIp3Qmyo8DLvux6Ce
	 0M6xnnCimHImTp1BCPWoYLyZ3HiNkdoc75Cf73f6u9lUs6qtbbwEqTO7h7EOhAQgKOgyM
	 Uhd+b9vopMBdEQekEG7l7Vi9HwkK/ikkcuH249Oi+r6BEA6IEm6FnKFKhOkNiytFyJVPs
	 slqNU1xbnMpHBqHk6HkcYmck2+jOMtRxrkC+fEITeQBTJdGbidxYIS16nGMkW9DxIfTmq
	 hPFPfnwATmibl789xO0Cdes7hD0ymuawRBSojJxQ4i/S4QzQqIiojfQjGOk8PwEZUKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdnGpdL0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B73606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdnGpdL0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DFD1F00A06;
	Wed, 11 Nov 2026 23:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439843;
	bh=zWNa7hT8dt83dYZn73hxoHnub6DPe/pvvAFdWzST1Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PdnGpdL0sji1Bnizg/s5/PkF6J+irm+ClGlVFZrgoVJa3Mnf+hnZg9ePGc9WIxW31
	 07JqbCnYuwboybRCFPiL+y0m6mSI7aa9nrU8fu+5L0lgi65zLdnDWESBetmz+A9shK
	 qeZTsDeLi3SFKg/o8+Kk26N71zbDCy/FYG0k/T0IXC14ImlN/unUgA8qT0nVFcMapZ
	 VdOyvE3WG6w/S7PTMFAO1tB1MEFb/wPqUINAfuV+R2+tsSYF2pI0oq4zC3ooqnlkgk
	 TUPDjkIvej7u/jA92DPCUWxSExTnV3cXg+JTEswgWC6XPRghkkT8xHTI12PRu9zGHA
	 Py5KnjRtCqAYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] drm/amd/display: Test dm_dmub_sw_init
Date: Wed, 11 Nov 2026 18:30:40 -0500
Message-ID: <20261111233031.397897-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200203-failed-7.3-5b3717a14ef6@kernel.org>
References: <20261109200203-failed-7.3-5b3717a14ef6@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit b0098f52a38d045a4c60db475f1cd19823954b0a ]

[WHAT]
Add KUnit tests for dm_dmub_sw_init(), covering the ASIC to DMUB service
mapping for all 19 supported IP versions, the memory domain choice, a
complete successful init, the BSS data region variant and the PSP
firmware load registration.

[HOW]
The framebuffer allocation needs a live TTM device, so add
amdgpu_bo_create_kernel() to the indirection table introduced for the
firmware request. The ASIC mapping and memory domain tests force that
allocation to fail, which walks every ASIC through DMUB service creation
and region calculation without a fake framebuffer.

Grow the fake firmware so its instruction constant region is larger than
two PSP footers. The footer probing in
dmub_srv_get_fw_meta_info_from_raw_fw() walks back from the end of that
region twice, so a region smaller than the footers underflows the size
and reads out of bounds.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Keep the framebuffer allocation call rename needed by the DMUB memory
placement revert. Define dmub_bo_create_kernel as a direct alias for
amdgpu_bo_create_kernel so allocation behavior remains unchanged.

The firmware request operation table and fake hardware access helpers are
absent here. Omit the KUnit operation table additions, new tests and fake
firmware changes that depend on them. The allocation alias supplies the
required patch context without introducing any functions.

Stable-dep-of: 5b3717a14ef6 ("Revert "drm/amd/display: Allocate DCN32/1 dmub memory to GTT"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c   | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 9ff25bc8ee5ae..440759cd456e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -65,6 +65,8 @@ MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
 MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
 MODULE_FIRMWARE(FIRMWARE_DCN_60_DMUB);
 
+#define dmub_bo_create_kernel	amdgpu_bo_create_kernel
+
 /**
  * dm_dmub_aux_setconfig_callback - Callback for AUX or SET_CONFIG command.
  * @adev: amdgpu_device pointer
@@ -659,11 +661,11 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 	 * Allocate a framebuffer based on the total size of all the regions.
 	 * TODO: Move this into GART.
 	 */
-	r = amdgpu_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
-				    mem_domain,
-				    &adev->dm.dmub_bo,
-				    &adev->dm.dmub_bo_gpu_addr,
-				    &adev->dm.dmub_bo_cpu_addr);
+	r = dmub_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
+				  mem_domain,
+				  &adev->dm.dmub_bo,
+				  &adev->dm.dmub_bo_gpu_addr,
+				  &adev->dm.dmub_bo_cpu_addr);
 	if (r)
 		return r;
 
-- 
2.53.0

