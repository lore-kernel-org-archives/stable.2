Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047085;
	b=MM1Lug3x24JvQUo53Qg6CJV2amd9D3E7IsYTgD6mrGdb+46Lh8kHR4+CfJ1Kq4jsVmWG
	 v+BC8c9hJEI1TjhaTNPpuIQbmJgpzSUbWGS0NKPc1mQHnQ0Yqb6lpYIbvqTeshIkGVw2j
	 NAaOu7U/sJ8/Okvr+0ZbeUCPWDRKZ+pLJNj1PSqNWMM4Ll5qH5fBiD6NINeCN2eO/fSRD
	 AjkfL73PFGOR6q/8d/IC9uPbot4u2mDgaoadP5ymVr84ptnJROgtu5uOpPBLb1gXeI/j0
	 aGD2Wb9cJ7Bnq15TJdv/yWfR0Dxj3yfXW2sEL1y1hVuCbEc8YqE9oPYtRU0lPSO4iwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047085;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=q7DBSeaKNVLt3wVLeRbK6enCgxxtvoHFqh6UEcWYh5s=;
	b=C2F+b62xeBEgEO0q9+gyiaWwIrgPBVJGznzjgHvaBEHTedxIFi9a+c3mWW21Q997XOSh
	 Z/5QpSK6oTJghErCrwS4RGnJbc/dZ4NXGWNsTa3DWDFBuiDz/LKcBnQdtOFDdDWzQn/LQ
	 Xvxbn/W3vJ1doiJF1hf0YrEf/yJmu/O6R+y4tAby3TaY2a6NHpM3SxBGv4Df8KiJVf0ej
	 DQXDQ3R3ho05KvcBMhnNcHSH50lZ24erU4wQo0dLH7E6BdA37ZPCOO41wgA9tBckj7/8P
	 KQaxbFoy+IBgeKZ2gUzcadm8de850BoyK8mtsK7mnaWf2WK6hs20x7Vv7XDlNAJNn2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iw37a1tK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703D606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iw37a1tK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C481F0089F;
	Sat,  7 Nov 2026 10:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047084;
	bh=q7DBSeaKNVLt3wVLeRbK6enCgxxtvoHFqh6UEcWYh5s=;
	h=From:To:Cc:Subject:Date;
	b=Iw37a1tKOA15R3+jEHa3xNixS/fvqCg+71j2uU0Y/b6HEHULSyuhkx+DAL8MjGTAc
	 cDJQPV+zX641uNyuy7/cmksJaReX9TU49S+mWS+VBsxoJivtBBRS7AiLgQk2wO3Q9V
	 PGc1BTuIjuuf091i0srtNuYx6Pru4PTajRnryXpdQtdUOSQNN4GqREqpK13yFCAJg4
	 FFcx9BYhurV0x6p3Wtr4agar1oKwU4sUd0Gu2kP7Iht1kliWhJGF15ObRfzLzCiLHe
	 QEuV4PE28/U4qqC/per2NRz1GxJMOQnpibK9lUmkbwBKJBoAp3rMigZGnf/3E0r2I2
	 LAetZ2g55vcmA==
From: Sasha Levin <sashal@kernel.org>
To: qchcio@gmail.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:24:43 -0500
Message-ID: <20261107052443-failed-6.12-5b56ede88031@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5b56ede880317bd912f914d5cd38ba1d357677fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052443-failed-6.12-5b56ede88031@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5b56ede880317bd912f914d5cd38ba1d357677fa Mon Sep 17 00:00:00 2001
From: Maciej Kucharek <qchcio@gmail.com>
Date: Thu, 15 Oct 2026 11:57:11 +0200
Subject: [PATCH] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0

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
---
 drivers/gpu/drm/amd/amdgpu/si.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 0adfd4b101aaf..e5e590425f42e 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1512,6 +1512,16 @@ static void si_invalidate_hdp(struct amdgpu_device *adev,
 
 static bool si_need_reset_on_init(struct amdgpu_device *adev)
 {
+	/*
+	 * MacBookPros with switchable graphics put VRAM at 0 when the iGPU
+	 * is enabled.  Any later post (S3 resume, GPU reset) moves it back to
+	 * the vbios default, so reset and post on load to start with the
+	 * vbios layout.
+	 */
+	if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+	    !(RREG32(mmMC_VM_FB_LOCATION) & MC_VM_FB_LOCATION__FB_BASE_MASK))
+		return true;
+
 	return false;
 }
 
-- 
2.53.0




