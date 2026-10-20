Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792485663;
	b=hdXGwhXP9zlfp5i6mzmY/d1du6K19aN5KT7VOMSW4m51dt3ngEOoYGTQvbuz55Pg+qMc
	 G9RHsug7DmWDxy4/cR+aDcY4dEBf+hZoHCWcOfhFXOXBjsXMSk7XUsiRXUi9FTmdxF51k
	 Y17XTWJzlxS0trW2XuZujIOhB8ABd1kZHLpmbggT1wdYzsxJi3vSOTH/pzUW13esr51A1
	 /7YQqs8paA4gKNeJr2Z5cYnph1Lc+VqL/Tksx37M+R1HZEQZz/jc50m6wGptGbMu4kGv+
	 MmhaxNxFT9UE/WNgdTOYwbw7uxSSu8s0E+BkLDLo2Gm0L2g0w/cyfKYvAOODFLmZcug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485663;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pffISxaztRWKYcckfYU/SHcbK5rMl4mTn1LIc62eib4=;
	b=lts3gNfp2qzmtUMGAk4XYx3gJjYpraJnlxu1YCpz9WFqfuXhBJdhqox9Y1EDAzA6VHrL
	 I0IiLICwdlURc7y22u2biEppA4KHVNfs8PuGgNglegvHDT6sLGPC4YcaORn82K/nfxqtI
	 x+vy0uGfyii4+iFh+9YDiShWxTqFPZjytl7vpQrOa39Gp4YJG05vY+ZqHkBQmLaAjkeFG
	 RNgGMS76H+43D2K2jGTVqYTHY9FvykkMLUM9fFVSDHg3it5E1P8pDvU217+P5P/mQhuDR
	 pKGjVepFj+44jypF28+ZaARsHgMQWa7Qz2/QHEmODjuT9uGYUq4XYKHV2xWphEbckag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amjw9E6n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EEE606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amjw9E6n
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792485663;
	b=lATvxu5zRBPW5YGwz3mY5aSlpW496rRmlY0Qq20HpBwoTjHDQ0aNzcctmxTGmReLUjht
	 OitHKgSk9ZPkhYTVvzCBq6vdmH8tUTXhTXPEZJ0obvVUikTT0LpIwCbKE1XVkVJ7vvd+q
	 gN7ZT60F8owIS0XBCm3CEg+etwWw2To5DIo6eBtv3bDtKffPCGTuuYAKzZDCQ5ijBB3K5
	 Bq7o0o6UW1tZSil5OsX0BRbnlC/is2EtWpEl393oYObrCl6sHhau0C0jLrFbWp03nr7O9
	 Ep7Fnc66FrcRjc3kEOLk1HA6Wfv1/j+yG7cfhJPHZaExrddIapopXgK04xzjZeEGdNw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792485663;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pffISxaztRWKYcckfYU/SHcbK5rMl4mTn1LIc62eib4=;
	b=VTuS6D52uWpNN7oliJGp1p+BM8pfdgCtznJtzVnLJ0EU5PFARni7N7DFxYc2UBD4UkJv
	 2q2NGUPf4QFflrItgiaTGmy6tWEEZu7IP3KF/41AixY2IenXnnJcnwkz0R/5mbLMjn0Zm
	 p2dUBk3WqfG6roveAEV4JzuT6y7zojgRDITS2mRUk0QqBaw3koxq7q/sIBGiD6+/WULlH
	 iVZdjJqx697S85GB5vqdWYFftUMD8dtqfFwP9sh8zugQ+9K4T6/efKKSTSwp58f9DGUpz
	 j2DtFX6Qjz2FIY57LLbE3AxRsW+3hv8xmEjYOSn78UhQH5Es/Dyc6C21gVKXR1hJgFg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A12CC1F000C5;
	Tue, 20 Oct 2026 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485663;
	bh=pffISxaztRWKYcckfYU/SHcbK5rMl4mTn1LIc62eib4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=amjw9E6nYdyLVAXKCnnxnRvzxRirinV44nZdfj31XQcTbuvGcnxZR7iB/EiE1Sd+M
	 ZxmZnyYHOx6qL3MrVvb9hIDDv1lhqfuQCB6IDLiiRiMSw/9wYyl7P6kkoowebQN4dj
	 jbNq8PbaxPE22TrOKTIXEqWjk6O62WpEt2Ha/S2czV1igoaCovIdBCAf+QM3zwBlpb
	 dCkvdA1R2ZjdCEHpQUpPFPJxvYELTsVqwfvZAzCv0m/kFxcbtYVzMZ/iebG2h3eFEf
	 iJBYlj8pCM4HhpKZajy83DiBbT99dkHWyNkexvLC2zQfjlIcbLVhJ/0aZ0gTp2hKFm
	 AiJoY/3o8XvHw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 05D8A40612;
	Tue, 20 Oct 2026 08:41:02 +0000 (UTC)
From: Brad Drury via B4 Relay <devnull+drury.brad.gmail.com@kernel.org>
Date: Tue, 20 Oct 2026 16:40:59 +0800
Subject: [PATCH] drm/amdgpu/gmc6: restore FB location and HDP non-surface
 programming
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261020-gmc6-writes-only-v3-v1-1-70730a302504@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMPQ6DMAxA4asgz7WUH8HAVVCHJBgwglDFQIsQd
 ydtx2947wShxCRQFyck2ll4iRn6UUAYXOwJuc0Go0yllVHYz6HCd+KVBJc4HbhbtFaX2rngfOc
 hl69EHX9+1+b5t2x+pLB+V3BdN2T+Y1l3AAAA
X-Change-ID: 20261020-gmc6-writes-only-v3-33151aacabfb
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, 
 Brad Drury <drury.brad@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792485661; l=4500;
 i=drury.brad@gmail.com; s=20261020; h=from:subject:message-id;
 bh=raIwOSTMc66p8OsMKySvOqV197RJo30SgKnIRMjJUaQ=;
 b=qlVrHHTaGlVubwyQsxPbVgSl3AaxIXEaz/lqwKoS7+P5x50WLXNJ14ZTm1bfd+0lrSqB2kgjn
 OIMTgBeU860A32iXHLG698uljaE/S7HWIQmJB7CfWs59s23lcMRNWAn
X-Developer-Key: i=drury.brad@gmail.com; a=ed25519;
 pk=vbLeVFkpkhLWuDhWMxes9in024/YW681CJos0eosnVQ=
X-Endpoint-Received: by B4 Relay for drury.brad@gmail.com/20261020 with
 auth_id=1247
X-Original-From: Brad Drury <drury.brad@gmail.com>
Reply-To: drury.brad@gmail.com
Content-Transfer-Encoding: 7bit

From: Brad Drury <drury.brad@gmail.com>

On a MacBookPro11,5 (Radeon R9 M370X, Verde, PCI 1002:6821), used as a
headless PRIME offload GPU with the panel on i915, every S3 resume with
amdgpu fails:

  amdgpu 0000:01:00.0: [drm] ring gfx test failed (-110)
  amdgpu 0000:01:00.0: resume of IP block <gfx_v6_0> failed -110

followed by SDMA timeouts and a failed GPU recovery.  The GPU stays
unusable until reboot.  radeon resumes the same card fine.

Instrumenting the resume path with a write/read-back VRAM probe through
MM_INDEX/MM_DATA shows that VRAM is still intact after the driver
re-POSTs the card and at the start of gmc_v6_0_hw_init(), but is corrupt
at the end of it.  The gfx ring test failure is a consequence.

Commit 71086a3e8470 ("drm/amdgpu/gmc6: drop fb location programming")
removed the MC_VM_FB_LOCATION and HDP_NONSURFACE_* writes from
gmc_v6_0_mc_program(), on the grounds that the vbios sets these up.
That holds after the system firmware POSTs the card at boot, but it does
not appear to hold after S3, where the card is only re-POSTed via
asic_init.  radeon's si_mc_program() still writes them on every init and
resume.

Write them again, with the same values as radeon, after the AGP aperture
registers.  gmc_v8_0_mc_program() already does the same for SR-IOV VFs.

Unlike radeon and the code removed by 71086a3e8470, this does not black
out the MC around the writes.  The old gmc_v6_0_mc_stop() relied on
amdgpu_display_stop_mc_access() to blank the CRTCs first, and that was
removed by commit e4f6b39e8bcd ("drm/amdgpu: remove *_mc_access from
display funcs"), so restoring the blackout now would stop the MC under a
live scanout.  On this machine the writes alone fix resume; a variant that
also restored the blackout behaved the same.

It is not established which of these writes is the one that matters.
At boot on this machine FB_LOCATION and HDP_NONSURFACE_BASE already hold
the values written here, but HDP_NONSURFACE_INFO/SIZE do not.  The
register state on a failing resume could not be captured.

Tested on linux 7.3-rc7, MacBookPro11,5, amdgpu.si_support=1
radeon.si_support=0, mem_sleep=deep, with this change alone on top of
the stock driver:
 - 7/7 S3 cycles clean, from a few seconds to 10 h 49 min asleep, on
   battery and on AC, including two back-to-back cycles woken by the
   RTC alarm
 - DRI_PRIME=1 glxinfo (radeonsi), glxgears and vkcube (RADV) work
   after each resume; no ring, -110 or reset errors in the log
 - cold boot unaffected

The variant with the MC blackout passed a further 6/6 cycles, up to
9 h 40 min asleep.

This patch applies to amd-staging-drm-next with only a line offset from
the tested 7.3-rc7 change and has been build-tested there.

Not tested: other SI parts (Tahiti, Pitcairn, Oland, Hainan), and an SI
dGPU that drives a display.

Fixes: 71086a3e8470 ("drm/amdgpu/gmc6: drop fb location programming")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Brad Drury <drury.brad@gmail.com>
---
I can run further tests on this machine (MacBookPro11,5, R9 M370X /
Verde) if that would help, e.g. register dumps or other variants.
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index a7c353d1a..d6e315f4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -223,6 +223,17 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_AGP_BASE, 0);
 	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
 	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
+	/*
+	 * Don't rely on the vbios having set these up.  After S3 the card is
+	 * only re-POSTed with asic_init, and without these (as written by
+	 * radeon's si_mc_program()) VRAM is corrupt by the end of hw_init.
+	 */
+	WREG32(mmMC_VM_FB_LOCATION,
+	       (((adev->gmc.vram_end >> 24) & 0xFFFF) << 16) |
+	       ((adev->gmc.vram_start >> 24) & 0xFFFF));
+	WREG32(mmHDP_NONSURFACE_BASE, adev->gmc.vram_start >> 8);
+	WREG32(mmHDP_NONSURFACE_INFO, (2 << 7) | (1 << 30));
+	WREG32(mmHDP_NONSURFACE_SIZE, 0x3FFFFFFF);
 
 	if (gmc_v6_0_wait_for_idle(ip_block))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");

---
base-commit: f307e9d20cc7bd6dd54a3fd8c2af767dd7ef2931
change-id: 20261020-gmc6-writes-only-v3-33151aacabfb

Best regards,
--  
Brad Drury <drury.brad@gmail.com>


