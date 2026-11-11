Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365676;
	b=AAWm1Y+aiX3CyX6q2UhPVFaZGvk+uGq03F9VpHhgFITIxwVoC9oHtL0ogjp78vnx2rz9
	 kqFeK6LI16fVIakI+XVQVOf8Yr/BzoyvFATOM4XEg1EAs4HJ2Oo7NE780Gh+BJZCfyS2m
	 gVbD79YPP9corK/P4FukTfWw+YR9HpNbVroefNhWsgmTcW0NiFtm/UQVls8RLB8pE5gXv
	 z/YUgOYFt+yHUfu2qrkab874f3Yd8bVMzHtgudhpPU8BLDKruWU5S7npaGutrOm7Ci51r
	 qPgv8Qd3ok3FdgvDkQ18c3VmDXdwhLEahk8jD6vhZcSVkzW5Jcz1wBwFhMK7NEe/TQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365676;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jZPLYWbCEwgtHa3wfHCuWBMVc2r9n+nZVBqNhKNfDTs=;
	b=u+MRj2VvINFzZkYIyEhrZM76/gfin5I9ouYavPaL1NGUahFb+IKjZnJDVX/Acs+LOFXZ
	 Z/Cto91C4lo/JDxAoFvihZlCU+f5nXHROAqg05pWbIE200QvbvYGmQjcVQ+cis9QxTVKr
	 2t94R6HMhcDQLNut57JSbmCkbPiWlDmBcWrUzL72g5fZAvqPGRL1bkfbgEFJK/86I0ylJ
	 ftuXx//3Ihg8DYn1+9HBZz/4CP1SdwjNxJmYmjSLrifNYl2CfmXlRJwDTY/5amoItCyXG
	 0NGcSl/W4PQ/lKjD1jO7HRvDkhbEQqu8bQhHHTI6NvyBShn7/msMi2WPXnJQQgPjwHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnlNuoO6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A0606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnlNuoO6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACECD1F0089F;
	Wed, 11 Nov 2026 02:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365676;
	bh=jZPLYWbCEwgtHa3wfHCuWBMVc2r9n+nZVBqNhKNfDTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FnlNuoO687Xw7okZIfgsppvuJid7SkJgUZ1B8WkC1xGXebX0auiJgwpZbkGRTHLxC
	 Fu54kdmvx2QEcUJgJmOYZste8MPb4ssC3psaAEM/1zVo4RJmpm3zZwAUg+YUIUlUDd
	 Zv0RRBJomuFkgkiEGIPN6mhBBm4/aXTcLjweY2RMR+PLgIX03gjGkJfQ5rmdRsDNBT
	 uZ4gp0cDztwW9RKp+psNK1VS+krqUwfBaZVv9m3l2kpGN6J3mdYWZW242kL80I6BXD
	 LPQYYK1t753aRRVtOXPdjIH27Wuh2bI8mz11Ywhv1qNrKVgVlk95AjOPjbNFKUiEPS
	 jH5DmAXm7L97Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maciej Kucharek <qchcio@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
Date: Tue, 10 Nov 2026 21:54:34 -0500
Message-ID: <20261111025257.771233-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062620-failed-5.10-5b56ede88031@kernel.org>
References: <20261107062620-failed-5.10-5b56ede88031@kernel.org>
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

From: Maciej Kucharek <qchcio@gmail.com>

[ Upstream commit 5b56ede880317bd912f914d5cd38ba1d357677fa ]

On MacBookPros with switchable graphics, the firmware puts VRAM at MC
address 0 when the iGPU is enabled.  The EFI stub enables the iGPU on
these machines through apple_set_os().  On a MacBookPro11,5 (Radeon R9
M370X, 1002:6821, subsystem 106b:0149), the driver adopts this layout
at init:

  MC_VM_FB_LOCATION=0x007f0000, HDP_NONSURFACE_BASE=0
  VRAM at 0x0-0x7fffffff, GART table at 0x1400000

The driver posts the ASIC again on S3 resume and after a GPU reset.
The VBIOS asic_init table then moves VRAM back to the VBIOS default:

  MC_VM_FB_LOCATION=0xf47ff400, HDP_NONSURFACE_BASE=0xf4000000

gmc_v6_0 does not reprogram these registers.  The GART table is then
no longer in VRAM, and the gfx ring test times out:

  amdgpu: ring gfx test failed (-110)
  amdgpu: resume of IP block <gfx_v6_0> failed -110

Reset and post the ASIC at driver load on Apple boards with VRAM at 0.
The driver then uses the VBIOS layout (VRAM at 0xf400000000) from the
start, and later posts keep it.  After the reset, FB_BASE is not 0, so
a module reload does not reset the ASIC again.

The test is the same one that commit c54e4d105077 ("drm/amdgpu: make
Mac FB workaround generic") uses: an Apple subsystem vendor and VRAM at
0.  The VI quirk for the MacBookPro14,3 resets at load for the same
reason:

  commit b6b1d9721851 ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")

Other Apple SI boards get the same reset if FB_BASE reads 0 at load.

Tested on a MacBookPro11,5 with 7.2.5 and this patch: the panel comes
up at boot, and 4 of 4 deep S3 cycles resume.  Without the patch, S3
resume fails every time.  The GPU reset path is not tested.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5978
Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 60dd16ae10f286cb9cce5b6027b2d5ee869637af)
Cc: stable@vger.kernel.org
[ sashal: Replaced MC_VM_FB_LOCATION__FB_BASE_MASK with its equivalent literal 0xFFFF because the defining header is not included. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index b7e1201d46f97..e34620eefc468 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1393,6 +1393,16 @@ static bool si_need_full_reset(struct amdgpu_device *adev)
 
 static bool si_need_reset_on_init(struct amdgpu_device *adev)
 {
+	/*
+	 * MacBookPros with switchable graphics put VRAM at 0 when the iGPU
+	 * is enabled.  Any later post (S3 resume, GPU reset) moves it back to
+	 * the vbios default, so reset and post on load to start with the
+	 * vbios layout.
+	 */
+	if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+	    !(RREG32(mmMC_VM_FB_LOCATION) & 0xFFFF))
+		return true;
+
 	return false;
 }
 
-- 
2.53.0

