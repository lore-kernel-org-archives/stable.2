Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362375;
	b=IEzNN5qhuQl1fBEncUBblPHlT6w1J0CgkObyCuQpP/CqcW7bU9OxaeV04Gw1X19K8wWl
	 ydHbHQIYAE7M4lnxzuAhAWydXveFB7Vk1vNmH8l3r8CjqNn+8CE8jzpAgcqObSkhp52xk
	 6BLK/e3KC/Ps5z+FlizkG4yb09XYKfzTuKrWjcYqtLg1qmzUrqOpkU/Pycw/Q5IQQk/ae
	 i8VC9WGgCw4cmQIEleH7CJiFICGIOcQXDPR6tJeCjQ7zA2JpkdfnSwHiiU5A8rGclu3Sp
	 Z81aP0CAyE5FxustsqcjIyLW81/0Sbii2m+59SFelnzTn5a+C09a9Ww17k5Mi66/1oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362375;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I8qVrLMecOzk2awXIciCGyWi9q7J7waym5WjTkSFPKw=;
	b=MC3PgWuC0qwX4uRExPPeQOJhrMIblzJbo9hpj0JPvy0NGQoAyIsSbiwVKlPJt9xuqCa5
	 xiZmd8An4BUuTBoQPEsFtiBEZdlcGIMa0mvIzsnI1mRi2GvmlhTHCZ3iJU3VSQfFyr43Y
	 PW1Oc7Ept8bMx5D3ks1pQQEUfNo4ZRd39vwpd5QaCPkUpYlBnaA0J4VHgF/9z7HoFWb0K
	 X4b2/+ep9ALfw4niBrVMpFfM8a16sISDbwWYemhYuZJx+rqxakln96t7uQovB8f+LgX4v
	 JLCaaTBBCVvMD2+0xUG1I2VkBmVYQfLTDUHQ/TsurkXX7f5f3dGSRpMa14EFTo79lKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMf4eE99;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705E4606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMf4eE99
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F4B1F0093D;
	Wed, 11 Nov 2026 01:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362375;
	bh=I8qVrLMecOzk2awXIciCGyWi9q7J7waym5WjTkSFPKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FMf4eE999AB942MB3TM4O7pLsVsunmMyMQxVfjRqsVyGBlzrJDWRwTdKmyjGIWK/H
	 Yo+ZO/MqJ3ABfRlcqeNNCsvKhVdW0k1DlsaU53j2Ait8BVHe0JbhwpUWb9pnlkNYid
	 XLLzpZHzJMq9a7UgpT2bEU3qq6J5a0TxfZ6qht51Rt4hdsBLNni4OPeG/Q9hQDxHEW
	 PnFgoRaID6oq4roAgSl19U0AA6lMVfffWSMo+H1GHoy/GAZM1sfXEk3nZC4ebnkQu3
	 rw2q+UCvlIukH6Ek6Caip/EPKNILyuyFF1x5lmbtvIZf6hVlLEEZi8qtDe6CIfNnfT
	 UewjXuDMWeR8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maciej Kucharek <qchcio@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
Date: Tue, 10 Nov 2026 20:59:33 -0500
Message-ID: <20261111015822.444495-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052443-failed-6.12-5b56ede88031@kernel.org>
References: <20261107052443-failed-6.12-5b56ede88031@kernel.org>
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
[ sashal: replaced unavailable MC_VM_FB_LOCATION__FB_BASE_MASK with its equivalent value 0xFFFF ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 93c68abf447a6..dc0102db46336 100644
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

