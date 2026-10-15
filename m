Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735437F33D
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088352; cv=none; b=EEEkcRm4Zb3Bnqy/bviQqPaF3X5aCSt0jqT2ALI7T8yht5TCRFwEAFUo8JZmvYn0NLkPYOzxCNcTF00b9cZXMhenNpVXdtBKxfSAaLZJclUiZR6s40tcq+sbF1wRPuMf9Oyepn4H9JIFN6V/toFAwD0oVy5FixU65wP6WtIAebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088352; c=relaxed/simple;
	bh=m0+m2PdAtboqHvkuBmD4v1Vd0wz20cNJ1WorEo9pD00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyHcQVUPp7bDb7SJoUkL2CiQTuWd1pFP0f/zK543lyvFgYd2gy0hRi7ZGR8jyWUZak6bPGPZUQOC2tSks1CEdYj/EPMDXuYh7l4n5NMarMMsuC9IZRJ5yNd1pgSVxdVuqnOJGjTW9ZlCXZgOAmZ75xpdiLnKsRhUuVSf/A79WrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqLyZBzi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqLyZBzi"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c315729ad50so916811866b.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792088343; x=1792693143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9AM0Gv89/jti2Z4oloYI+pxfIXugphtFed7imqnHYeQ=;
        b=EqLyZBzi33VSrxkI8soQBfewPP7BZQ6MPb8/jeT2blfXa+A1ByBBCbFtn0Ev7kRu+j
         bKK2v7oKxBAuOvcduWit34tmJWRxSXZg576LQfUx7i3JZ4QR6C99ZwtV/qyXnoBIlyUl
         CazjDYkFD+R2FdCobQ51aMSyrPS72uK+tiAj/RxQj0h9jinotpJxlL6zz0Lv7fnsyMYw
         ht3Q9EVtzQOfrXPp6fBNU8ofuZLTEZUECA9XuHlvhQWl+k0CzCxv1sORqzS/4gl/Bs3T
         Kd54VhQ1pQe8OJ1biPe+T4/QaKyDtJOia3It8gw0GgJJEZDV8Uu3gwyqBbwpH5GLu2C5
         J08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792088343; x=1792693143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9AM0Gv89/jti2Z4oloYI+pxfIXugphtFed7imqnHYeQ=;
        b=YKV9iyhBDtanv0H7N+bwXDFhP0EvM4rbRe8inxj12MNBq6kYfvdpDSXMy9B0Ch3KYG
         yoURyTXjzAX+SSo5cQ/5H9v6I2ErsBWN2WTnEMZdgNA+kmSf2x+T1gNnGQGxzcQihOyG
         0FJWvGhnoe/NUa1rrJIJaSeUppNgj38UUea7TZbvuskvTeE2RAs7Ynm5BQziZcdTPe92
         VDse7yoaLZMPlZBUvDyy2iImrTvF8bsmAaEAmf/qdQTgGuspsnyP2DjIcOfsw33dUtkH
         Bimi1nWVHSu8g6N5YxKn5e83KvVd2H7psbluYJnfOaMyCHYTlixS1wEc1UaNULuRrUBJ
         l/GQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMuuBvKiSM1MTk+TTBtghD9RIa4cuUGsoQnTCmQbNk3x3DerHNsn0xkOMMkTHouyp1VD9Y8g8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIV7n70ceIWj6JkTeYNuwHThkk58rj4ffSdIoqOcaOr8ekAkktn
	tVTjgiarSRXHdktP5meUVWNylmUhmRfPhpbr8sHtQLdLmiLikJDpgcjB/E73Rto0Ft4=
X-Gm-Gg: AYBFou3xL14k/m8zP8VvvG/FUR60edo4VkgFybO6HlXKHeIBnSvipUSBo4CykxM7yWB
	h8KliQBsgUAVGTEY5IEMFh5i2I/pn/3RjP+2qiZrcEDrqkk5yQmBWIbTq62yqGtimnLt9WnzY6q
	jgubF7OrSRQMl8Tzc1cME+o2aRC0kywfxrN9l6EXIqQS9ijg+v4Qq1kfm7hRahe1Z3VVe2+GW76
	yPia92YmR9kz7p6EKk7RAW50814m3NkoGwSpxxLY6EsqQb9jmRBhW6Vnr+2CNzt61IpNA1z3TYo
	t2HyJRfoLlU7DwjNwWRGHbwS2dGjieYdUXo1YMOBOxFqIO22pvrKpzyIci/6A41aLqyXd78aU7e
	TZyOS0/6CJPOu0T2IufF0Gkl8ODTBUfmiLJG+XzevqtmnJTGWufYZwdcIVoUN1/BtCk3oXiBqLN
	mz0g6ZVjZ4WDJoyBarxUVtTuzM5HO+jfR9kc3Pqq0AelPPWsZvYNRVXF4XdTYpOZC6aL3Sjg1dG
	BhyjW1sB1fhwq5LMqOT1EmiCF6M4Ng=
X-Received: by 2002:a17:907:2d12:b0:c2d:b9b4:f4d1 with SMTP id a640c23a62f3a-c31a9a29d5bmr1742275266b.6.1792088343237;
        Thu, 15 Oct 2026 11:19:03 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed9b33006sm161790066b.32.2026.10.15.11.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 11:19:01 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Maciej Kucharek <qchcio@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
Date: Thu, 15 Oct 2026 20:18:35 +0200
Message-ID: <20261015181837.41690-2-qchcio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181837.41690-1-qchcio@gmail.com>
References: <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
 <20261015181837.41690-1-qchcio@gmail.com>
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

