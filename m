Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887433515CD
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565368; cv=none; b=bMC73I8YHAtNZE1eF81M7EnrmkcLoikqKFXWZJMXyGYPiFZY3ZlnBcvRLJNUvbhGljpOrhXJL3iNGkSBRhyv+DRztlGGXwNEeSUv7/OowqtSW8HSgUUQntCdzbkUL1BDCSZBIkbCUiUHCPWkYY9O911BArrO9dPa3qGM9151TYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565368; c=relaxed/simple;
	bh=bA71VTc8VLu5Ts9Eeap0P57mTulLBPYY5ASFK3M1SuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDKQprHb5Z7sOhjdGj8oQK4aYBKpxQ558c4n00M7BH6d3Pwiphb50B1RC/c1ykOhpZSdiFKCwiP6Wd+71ZbkBpFf8G0afA4XnlZlT97guspeR/iyh58uoh8g8DUXNFUPX22omV31VOG1e0vZIBdiZUgXlVAdWbI8VJfUQwsS2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+hIeGMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+hIeGMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE1A1F000E9;
	Mon, 24 Aug 2026 09:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787565367;
	bh=dEUD+CkFbiFIRHopI13waZeMGAjqgAYbNCnNnCFJpPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T+hIeGMr71QJ2kB5vFLKmz305Omqnb004VH8UzWRnG+6UWQviXHQ/bVPqWCR/YeFQ
	 P1GK84xFZxrM0ad6Y0Fgi474nWHKU4+P8FNqc9/4VJ0lPirhu6Z+hzAidew4hRVxAV
	 SfH2Hlf85x3P7kQVQc9NIjxt2znVzFiOMCRI9xKBn0z97IhStpl8tEgdrTURgU1Iok
	 tNUGvprPorCJzaz339fV8nX3djtXO+Fpq/NI9e7l9O0oo4Zdqv0gREVgZhhugHPQbk
	 AyRALSY3ptdxwMZxOoAWuRUQEVjUXMneAjVJnUkyolB2GiH+6dsuhdz3fzscQRnFqh
	 Ip+z7MUZkKu/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kenneth Feng <kenneth.feng@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] drm/amd/amdgpu: disable ASPM in some situations
Date: Mon, 24 Aug 2026 05:56:04 -0400
Message-ID: <20260824095605.4065946-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082029-wanted-saddled-c60e@gregkh>
References: <2026082029-wanted-saddled-c60e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit c770ef19673fb1defcbde2ee2b91c3c89bfcf164 ]

disable ASPM with some ASICs on some specific platforms.
required from PCIe controller owner.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 2a9c5154a565 ("drm/amdgpu: check ASPM on the dGPU host link")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 54 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/nv.c            |  2 +-
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 78426f8c5420d..0d2f7be98dd44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1300,7 +1300,7 @@ int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
 bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
-bool amdgpu_device_aspm_support_quirk(void);
+bool amdgpu_device_nv_aspm_support_quirk(void);
 
 void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
 				  u64 num_vis_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8672838fb67ca..eea9b7e348aac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -84,6 +84,7 @@
 
 #if IS_ENABLED(CONFIG_X86)
 #include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #endif
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
@@ -1283,6 +1284,46 @@ bool amdgpu_device_pcie_dynamic_switching_supported(void)
 	return true;
 }
 
+bool amdgpu_device_nv_aspm_support_quirk(void)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
+#else
+	return true;
+#endif
+}
+
+static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (!(adev->ip_versions[GC_HWIP][0] == IP_VERSION(12, 0, 0) ||
+		  adev->ip_versions[GC_HWIP][0] == IP_VERSION(12, 0, 1)))
+		return false;
+
+	if (c->x86 == 6 &&
+		adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5) {
+		switch (c->x86_model) {
+		case VFM_MODEL(INTEL_ALDERLAKE):
+		case VFM_MODEL(INTEL_ALDERLAKE_L):
+		case VFM_MODEL(INTEL_RAPTORLAKE):
+		case VFM_MODEL(INTEL_RAPTORLAKE_P):
+		case VFM_MODEL(INTEL_RAPTORLAKE_S):
+			return true;
+		default:
+			return false;
+		}
+	} else {
+		return false;
+	}
+#else
+	return false;
+#endif
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1305,20 +1346,11 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	default:
 		return false;
 	}
+	if (amdgpu_device_aspm_support_quirk(adev))
+		return false;
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-bool amdgpu_device_aspm_support_quirk(void)
-{
-#if IS_ENABLED(CONFIG_X86)
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
-#else
-	return true;
-#endif
-}
-
 /* if we get transitioned to only one device, take VGA back */
 /**
  * amdgpu_device_vga_set_decode - enable/disable vga decode
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 82709e692f4cc..56e5a9eaf0c61 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -513,7 +513,7 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 
 static void nv_program_aspm(struct amdgpu_device *adev)
 {
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_nv_aspm_support_quirk())
 		return;
 
 	if (!(adev->flags & AMD_IS_APU) &&
-- 
2.53.0

