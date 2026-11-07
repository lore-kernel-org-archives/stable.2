Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048736;
	b=tYoRBhoAIzXdKXIaARQrmf7cnVDZXCw2nPxDbJE6+inqyHlHfJB1fFJA1kFaXsfpg07l
	 hg9pUDJx++ASmspya+obmk+AA/CFPHBRC1qVgvn71wXrTATI4ZizMs/jJAvQEIyVCSg2Q
	 GKHCMJl7hyql0xTLqTz/piN87BuAO2mGw28jF1hCaSm38REu/lVgr1bY9Ci22hfHRdZJS
	 PMIEdpQQmirw4VDopvrJrt1smawSfW3/VvmO6DMm7iuf8eFmD8nVixD1UTP6qIfNfWVxa
	 NMrF0zManeGhQ4M/Ah0smI2ZjoYPkCEOjBBmxDhMyNEqUFh3i8wf0QIaaeSzzkaxw+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048736;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tiCrwlM5Oe5MT4MR9RTKq5PmgWc0wgto87ctuWF5fAk=;
	b=CViksx1FCW7xuW7JT6uOLaDcHXaYAYk8PZBBw90P3sNtcRXamh29cpa2YlJAwzIF7Fvs
	 I69o71M0xL8dxNpGOn5Rmd5/ijWX2t5+nEey77Bsz4e7eoC1D0kHjlNYUuTr9Ped/wTcN
	 oHdAYme3QBF+KtOQXnay9hwm3FIUkS+8hiUrfbV/Wk0lzhc23e/+iTIeF6FeTZVOexfgc
	 OrgN4pOpGkwJMeFMOANGZGShDpIaWeNHTSkQC3N05ZDIkqvJxrUZ6UC93RzSOeHk5/1B9
	 rKZ3NS3G/zPngCnmjSHGKuFHg4n5ySE8XkZzRx0Yr/6hGASapz3CilCkCDIxjbUXkiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyyVsggA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2101606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyyVsggA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4121F0089F;
	Sat,  7 Nov 2026 10:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048735;
	bh=tiCrwlM5Oe5MT4MR9RTKq5PmgWc0wgto87ctuWF5fAk=;
	h=From:To:Cc:Subject:Date;
	b=CyyVsggAifkY7gl0wqFYhhMxGZbj9FTEgwszX6TZ7YwXveFNddR+76BeV1sBv/OhV
	 2vzEk91qzwF+UFlCTZy/36quu+MyJJkEqt2ILbXdwCDOq63YYdvoLSBMBOLaMdI8gi
	 /VKgtLI08UaTjiT6IMJVkCJS9fbVI1znCnxAVeAD3SGQj5J77IW4taeTkHH7PuDrRg
	 fW7N3E4fhXH+iUzD2XZ5jyMpzlHIuT47bQPTlgtbt4W38FGGOojll7b1anPUV1lJuf
	 FLVEbeNvbTKVEqoGJN9MN96cNlHiHXWibOu/w0B4jcYHYn7wbA4S71UCrN1YGsg5BJ
	 gtUY/hIKQVxuw==
From: Sasha Levin <sashal@kernel.org>
To: qchcio@gmail.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:52:14 -0500
Message-ID: <20261107055213-failed-6.1-5b56ede88031@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5b56ede880317bd912f914d5cd38ba1d357677fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055213-failed-6.1-5b56ede88031@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




