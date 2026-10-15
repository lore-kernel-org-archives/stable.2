Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A525172CE
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058307; cv=none; b=unWta6uDTYNO6ZUI7tzkVQavSKgk+406lYSzx4NOCcgZAKzuzznb2nB6PJS7SRsgcDUAm0hYbCB+wmhE7Pubgf5yN7P8NgWTr27oFZM2PNN8N9eNfqL+BNB8k22P4GuQGGC3HYisLmob/F4l1onsF9z169ivvkXPKpXvyOb66tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058307; c=relaxed/simple;
	bh=VZqqBLEnxS9ugMOxGQFBfi1P40DrM7Kg1GXdf4F60Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jThwveZFq/zFlVrhPzT9P9Pop0PDzNE1bNa3SFcrWN+Y2B4RRQyVrjC7jsifEgpDJIoaKHsFaHInhgqitFsvCdjKDmk+Luq0ult4sD+eCIehiTgTyvfxGUB+3agP3kZWM+kEgnEFK4IlY7j8FpJas45vjQBP+CRyAdtbJmWWttU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKRyeZEr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKRyeZEr"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6aa9164072cso7625348a12.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792058301; x=1792663101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0BT3ak9vMatktLwT+0i2Bx2HTKVL1fUGlR0dbooOuoI=;
        b=RKRyeZEruE8B4bWLKENnN1VaFb2X3pZewnDOHRy9FDn2rDANvCl3Qzm1kmx4JocQYE
         cXd8ej4KKCLaZU/cVANYZXEK/4ieOLlWmSFoqICOgflFZjq9dXkLKPGEtaFJKefiH7W8
         5oYkyuNilurGNvwDZ/FznzqtDlQ3flSO4yt7jAADiETP727RNQkYWS2VTecybTRcGVRw
         Im1qbjVaEQOsx1NO6JkjU5Ow4yZMEv9CnqZ8avoE7rp7MLbAASEVKzZ5gnKXykwmv1D4
         rKmH7MZGIRTyg6MYYB2vL5w1dq3ErfuIG3Ir7736Axmbv7airc14lpNdj/ebrJlIS1gy
         Corg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792058301; x=1792663101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0BT3ak9vMatktLwT+0i2Bx2HTKVL1fUGlR0dbooOuoI=;
        b=Rvasj3VhyXVMNLPK6mPUKlgBgsNeavHfhPQMPKRua2jAM77iugTphEEvUV4qtCzVsb
         R/ulP73//0RJELTPMSryzm8FGv7b6SL90mUIBmMYMowklilj4kQyX1ebwDWHq55Sd6Ru
         zZaLH4inWTaQfo3XwrHDxvndl13vEs4T/ZzMsN4PoPNXpbPxzik7e1Fn8HrQzku+0vf7
         /jTiwwtjOl4H/JwN/RlsyQfBIxiXC/sS9naQF2cAByLp8lSeO2SxEe0Yl6eQGQcXkTKY
         lSgImGShVhkjnRGgzWi2JkJksBPP9C5/Pr8yoUMybV+0M362D7G19XocKowrbYd2kcz6
         Bfsg==
X-Forwarded-Encrypted: i=1; AKwUvBx3vZ0Em8/dG09uu6L4YQPqjlii7g1O1R44zapEC3uAjQN3daaNRhiBhM/uxVzQfXvoBNQhHtM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5jujD1VPvEDWc3NjCxkAW1urgnsn2UxXTJ0VEfHhYTxEY9cwl
	rPe+gBqvmJcRY1UTJ98uX2z7IsbdvnU+mxFmVwMijqHn25inzSDeFF9L
X-Gm-Gg: AYBFou29gAZ1rFyNn56YR8LugNL1wAtXkNnK4N2fPLzjpPXwpyuse9LGXxFqUi/viI8
	sf0XcaKTzT+dcex2cPBGuW0i79c91Zt3dFzJaRqXtJCq7rFhbGF1iXy2cvk/BekFc07ReJzsFMe
	SKzSUwLkP8xqn6XA2B6CpkC7QeRUXIvcBwEi7blXvh55+HnauaZrZ1KYpJtb0XoytxTBcGUOxzT
	JoS895MlY85vvqun91WnRIfaQ5a/iMOkwNHyF0IPXXLr8NVGU9HkBcMxee4zHEZ5KFx8sqZ4joU
	ajCbARaJY/HJxEhYNMZbDrEsRtlw4xUYjIGxfrl8bNo7gpG0CvLCTrjnrTIzBT79pj6HwclmcaQ
	zqBs4KXciiNSJIO5LtGMofEY3WnuCtNlT2ikZvcsPSwgLaimNWXMDt+viNhQOnYCrIHR0LsqyaF
	3ThpkKrum3sd0roXbzOeNmNasGL5pejb50NE7lYEiz3pe0P9vApXDU8Dz5zAiSaRt4qc7w8FMT8
	u8N9jKWFQ7gtUJOj+xe
X-Received: by 2002:a05:6402:321d:b0:6aa:f198:4e39 with SMTP id 4fb4d7f45d1cf-6b17c294025mr15477544a12.44.1792058300579;
        Thu, 15 Oct 2026 02:58:20 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b2038aa1aesm2182227a12.32.2026.10.15.02.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:58:19 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Maciej Kucharek <qchcio@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] drm/amdgpu: reset CIK ASIC on Apple boards with VRAM at 0
Date: Thu, 15 Oct 2026 11:57:12 +0200
Message-ID: <20261015095713.20560-3-qchcio@gmail.com>
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
address 0 when the iGPU is enabled.  A later post (S3 resume, GPU
reset) moves VRAM back to the VBIOS default.  The SI fix resets and
posts the ASIC at load, so the driver uses the VBIOS layout from the
start:

  "drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0"

No MacBookPro has a CIK GPU, and no affected CIK board is known.  Add
the same test to cik_need_reset_on_init(), so that SI, CIK and VI
handle this firmware layout in the same way.  gmc_v7_0 reads
MC_VM_FB_LOCATION once at init and does not reprogram it.  A CIK board
with VRAM at 0 therefore has the same problem as the SI boards.

After the reset, FB_BASE is not 0, so the new test does not fire again
on a module reload.

Only compile-tested.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index d29991a4a..e1029239b 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1927,6 +1927,16 @@ static bool cik_need_reset_on_init(struct amdgpu_device *adev)
 {
 	u32 clock_cntl, pc;
 
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
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
-- 
2.55.0

