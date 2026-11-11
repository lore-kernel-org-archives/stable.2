Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365031;
	b=W3+tI8UM9ujpNmmiOX+g+sgZCh0moyfPqx7x40YLbC7Y9btHQJDsVfVLoY/XbzyNRdWR
	 Mv6XMoms271B2V64wWQIfNHXj6H58/o1rXe2DgR48dohlrhYU2SpJ4ZsdtAw/g3mKQeUX
	 Qd3hxy4zC2SuUGMCGDHeyR1TcPBLP0BJ/Ss0NKMyK1rm5UbePjEaQ2kV2+X+ywMbzQTDW
	 3onoJvhN1TblqnOeH4pd9N2dE79m9DMPUyFvjqn2iFntSqaag0LnNIqH2l8s1zAiPYGDH
	 masImLxXaxwnMxaXq6XBj4uIMakEZNKCkBZjbM98kjmPg60N+b3S6+e4Rt8b3rKa9tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365031;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0ZEV3KjGoXEL2H9oQPo+XzW7pH4zkWyALH6WWtiMIeQ=;
	b=HBvkKXVJpoxKFJCkqvqV6FGJ7f1S1cau0WpPKyueDeryKS6/5EKNn0JLYHtLPYiIpgUz
	 9VxmJBxNiPGT4tDVMY4gR5EoRex70tjF72X0evSM2LDADekjp5na0LSwK6ZelHfH03mpN
	 rUyzolMMX4o9jm+32thctbLt3iuTdayZYWv6avb97hNPbFvQDrJAHHqz7oy9ukzB0Ok2F
	 3p1lO0v9pR4mpoGQgPf1Tt2j9qqwQYQ/f+ebYTt372id8WWFkMxoDUIy89hZyMgU7AJ5F
	 DkW5PRDg0ymyhMSGzRRAfhmSUUD8fbcycftN/CEOnGhohJEGBIfkzfyNZClyN0/I7wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhiO3UUu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA820606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhiO3UUu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F731F0089F;
	Wed, 11 Nov 2026 02:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365031;
	bh=0ZEV3KjGoXEL2H9oQPo+XzW7pH4zkWyALH6WWtiMIeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VhiO3UUuDoyXK8su6N/EKPxDVa+juXTCWZ4+5NV0GwApROUvxHd1bZkP8ruhYdEk5
	 rzhr8XmBrNr34FspTR3z8spA7CsSJyPSfSjXgelw8WAJYnlckH1KHL4wX87nh2uTc5
	 HckegUyg7cg0P9Tpdbo/emdLC4lAQAMLq3yrL17PlLruo//ZS3HovQzQ7vDqFz1c9/
	 6Wt61AQVAD5xWz2/XqjfefE9qYjZtUr64OPYXo5IHXqIfFbWQnHbg8Z3BmsH3eCk8x
	 A4VqENh7YPDe4rtJJAi7v4aSnLgy+V78RBBiMRksAPX5Ic7TSkL4CfsY6im5jMYYI5
	 0VJO/UxLIes5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maciej Kucharek <qchcio@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
Date: Tue, 10 Nov 2026 21:43:49 -0500
Message-ID: <20261111024157.707600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060922-failed-5.15-5b56ede88031@kernel.org>
References: <20261107060922-failed-5.15-5b56ede88031@kernel.org>
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
[ sashal: replaced MC_VM_FB_LOCATION__FB_BASE_MASK with its equivalent literal 0xFFFF to avoid conflicting header definitions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index fd34c2100bd96..c63f1b7162d34 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1509,6 +1509,16 @@ static bool si_need_full_reset(struct amdgpu_device *adev)
 
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

