Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877E514747
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058296; cv=none; b=P2w84dNnrVYm5BzKGuWO8ctxaTEcgrGdau2lq1FW38vzzlb8J/qElxcZqCtdGYZOsRTUwJyBZSB9oRslHNt439DUIdCdeT24wWvMYhQl02A+TuNqROoR+oZ0g0020lIaEpHZViKZmLLY1cZ2Z1lNRoFpl1EgVR4yz6q2MimvnW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058296; c=relaxed/simple;
	bh=m0+m2PdAtboqHvkuBmD4v1Vd0wz20cNJ1WorEo9pD00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqMD8P/bjwb64VRM1lRQUy7eSDf60oQ6cHySNPqYktIYXMqtDOpzdf9NmsEC46IeD8fZdb9ScWhGzGHGrVHQobbAFW3QLHxNUc5ATPhn9cNXXuGE9qZ6KVqPTC9nm6pg/9F7S49B7ABWhyhkCaEA77DMyQCwejt16VN1Zlp8i0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRA+8sZ0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRA+8sZ0"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6aa9164072cso7625098a12.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792058289; x=1792663089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9AM0Gv89/jti2Z4oloYI+pxfIXugphtFed7imqnHYeQ=;
        b=aRA+8sZ080KZfTt2/jWV5G9k47CLN4mBChgSHCDGmOwkPilWyDbFyxzcMDDHuUAyPE
         JS/Ezyo2SSGrDrBadRQ3DxfKTPzfbZ2ZUHvJld/cf6mzHY8RZCWps299b40AD6yBK8iD
         gknB+WI3jrfmibTdGDpgrdXYW06O9tVcRulvxgOog+c7L4oBY8VR46U3cbltTz32j9Ez
         OhnbH9jgDDDshUXoxeq4VZhKOXU2Pdyk0yNz+N/lRrXsDgecev7M4pee0RgpEBr3aE5D
         nrVgy5ntKZGrNZjS672yAFuPKcfv8lMkEikDlRQcV6owdqLYNJoYkuFlZdMAbSrBwwdB
         3x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792058289; x=1792663089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9AM0Gv89/jti2Z4oloYI+pxfIXugphtFed7imqnHYeQ=;
        b=fejBNZbax1l8jSb9tCGKUyiDACxT7dHyzh02W3tv1dAXOJAoriNpO+PMNV9AoyDWIN
         M0ni6bJAqFZOKrXOgkJroo2SL2ZeDX+zsvobiOiVEEEVD/6wCKCGNSuZNqNLP296rXT1
         KhedhZRSZb6z2l2rHVGz6S2bzMOUPV9ZtDLSlYNSG3JvMC3LlV4X+i7+Kaz7OsIDI+Ix
         JKtvo8xwCNwygyGxl27HKFoZhNiPQnN33zkdGXPw9lWC457fo63WrygITQe/cjCtsL4h
         XhXfJ7J+JtWKU/8M57N2pwVPDYK8rYNdKOo21J4m++wc1p9N8hTZ4dJotnt4RSq3jXde
         9ugA==
X-Forwarded-Encrypted: i=1; AKwUvBy0AXljqpSJVhncziZxUCOBEFX6Yhijn3GMSyY+MqX7CwNgSdJT7nHxt3RnI5R/UhJPSikSRxk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvCkTK1j/vdLM3kt67hm4ok/G4QABevaVjhncLBxhI3Q1cDJOE
	4PC0cKo2f+bILIFT6dJA+bcbnTGrDh0aVh9kYYzHJwUnb85glCiVtkQa
X-Gm-Gg: AYBFou1z2SwasHz5YQzMFnkFjxTtfNKlEkwSBBfWyIuzW5GtRRvNnEba40ZX4Ce0Bkr
	rpbPcCCelg7bx/O4AGWV/Neay/hoTnOPt8qwXMfVd2flayLhqOfMxvy7+48MHvUCUF+RgIAAIBE
	Cftey3gQYXEEsgrvDbP1x3fOD2woXtQ6NeT2nNfel9E3DPJxBsfPYTKdFi6NbqqQqJ/RqawE+Ip
	7VCeOu3yOf9HpQD032mQCIabG3hvMiD1ipxLCHA2dDnggXpCQ4xSyLtTjtkGMAzTQmvp5U7xdgI
	xcmO/hApyRiDWJQwHY81TImF2yPhVmIoL/60bpgJRbf2P9FHd6BVurFvcSfAOOsNeRWkzqsyEOV
	dxq+H7BFIfqztpMbzxW92+KdUhyusmRBrmGhBXgc+r6zZ90LCbznfbvWIrL0C4WUG7uewsD5Uvi
	39B0VMbp3P04SXjQlb+yVLZfQwwRaxuApgASbahBAwUZKqq9a3Wk9fGbjrovBcBn0oB+ZguwU76
	63KrXntYfvZz9WsgWkz
X-Received: by 2002:a05:6402:c51a:10b0:6b1:801e:e01b with SMTP id 4fb4d7f45d1cf-6b1801ee296mr10367300a12.20.1792058288503;
        Thu, 15 Oct 2026 02:58:08 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b2038aa1aesm2182227a12.32.2026.10.15.02.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:58:06 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Maciej Kucharek <qchcio@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
Date: Thu, 15 Oct 2026 11:57:11 +0200
Message-ID: <20261015095713.20560-2-qchcio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015095713.20560-1-qchcio@gmail.com>
References: <BN9PR12MB514681E5EDA768CB4497EACFF79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20261015095713.20560-1-qchcio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

The test is the same one that commit c7f44ec5c4ec ("drm/amdgpu: make
Mac FB workaround generic") uses: an Apple subsystem vendor and VRAM at
0.  The VI quirk for the MacBookPro14,3 resets at load for the same
reason:

  commit a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")

Other Apple SI boards get the same reset if FB_BASE reads 0 at load.

Tested on a MacBookPro11,5 with 7.2.5 and this patch: the panel comes
up at boot, and 4 of 4 deep S3 cycles resume.  Without the patch, S3
resume fails every time.  The GPU reset path is not tested.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5978
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 0adfd4b10..e5e590425 100644
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
2.55.0

