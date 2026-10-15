Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B951597B
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058315; cv=none; b=cEoCSUxwoh7k8tOEJYa1/0Jokid8Z8STZYg3Cw//iOJMXeSKc+B9qWSaY+a1lPjey2dUV+uUWHHM3OnfrLr2wrh9ie8UBhib+c3VM2AiKh1dahfwg42TAgK6QRbeIfzgHjms2TkWf1Jg+FOLT4mF77QPi1A+7RaDSZpmph4CtQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058315; c=relaxed/simple;
	bh=4ZOrYyFHg/exQvjokWHu5/sj7jqkK9j7Yp7aCk5u+Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMu23FienlU2QPTJpCmRb4+htY25IFk/KzVaoSpmlFBpe5KWkR4+vqDwjRmZ11GKnpNSzUjNrnvsP0QMMXonJzszrzWIiePgDxgxDcTRLhoLOZ6WlG6fOuGb58mY6TSeTUt0NoMMPBXaU3OGwaaXlpMpw4PNCICEc0lZwZTlhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRMbbxoa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRMbbxoa"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so7390591a12.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792058309; x=1792663109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W6qvl8uPBElqhzytuAE7BkBQ1TnHFeTQQ5pxPHhsWis=;
        b=jRMbbxoaHlkYgCfEezNL28VBM6F41pPwxYYwX6M/SLV1WUoTUpu3JVSBJbcnjGNzuV
         sFzgigFOIJsjadUvk9EvVHVt0qHSxQZip/7ugTQ/gUd8zTbvYM+d+1kBC84PtVezty41
         rnjqnH89vO8xX9bR7htWM1SigqwaNxldoD08l9bHe9kVCjXcRcLsmoY+N0aGYNKcbNYh
         C1FuZyvk0kcxQF1BmGbg5SspwMWfreV4c9oHUZ2r+FxDuh6a2aYoc5jEiF+RwSBWi/dr
         EWnr3ugKU2r5gOGa0NprJ3Syho9hReNyNv328RKWLF61uPzCtg5La7e5exQOpO2jCOMK
         jLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792058309; x=1792663109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W6qvl8uPBElqhzytuAE7BkBQ1TnHFeTQQ5pxPHhsWis=;
        b=haKuL6bATt6xjePIyvl6wC8shaZ+Ya8WIoqzwnIthueIzZ5xxdMSUETIkuVtILbhpD
         7ulQlakdZvoI8/zEK9Hhv+17p8gkHuONS6OD8oC/aeG35rIHjY27qWShij0d6JRpMG7L
         5MQBEnO/Zl6nA4lSbf9KaE8CJxSMYsPeokWZJGDXPg/tPNo0hHZDGFok7YAEWusnjAx6
         lfE1Ujkms8cj4gU04tUzarNIbMxvEJK9Zt5AOC1Dd/OSB1uzsVY8pN99cGsWLPHnjXAI
         lbnsK1zNYerQq3de2/FQhcduYUdUBBCDy2FxMGfsgPcTUXBkrNTbBtlFvmG4aTDbDDMi
         7MsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvNbSx8Nf7PIK98DBAv957A79apSUJY4hUz7zK18KTgIpAt2wAPSuRq15qjW3BHPtBe96/3p4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAXrpL9zHdmUbeGfniepAa1vxq9NGfzvJuzUXvFBsosY/nHWQt
	adz1M6RJ43mPht8TdkZMjNUAXQnyeTePoUDF5cn3G+bSPP1KOTR+G2Cx
X-Gm-Gg: AYBFou0vqlwV3Zl7S7y7gxzzPOu6cYcSpXsE7T1r7p0id/Q+g+MZaEo/a0IVrcyDxaK
	8LRzxVKGX2yHoSfSttSH7JrqPfJLefa//tGVJdKVoH/c1NT0simsG61hkSAlwYPfLqxVLEQw5SM
	laMqhEC708pXxj+9CFobYyzgegpaj/oGJwDGuyfJsIg0zZugjwpKK7/yG/dKBxy2rjd767E+1l3
	j42itBm4A/npV6k7cD+Zs1dqZ1S5q2z7q0gOEDKK9gvLtwfXUxwLbVamPB/bG8CUKacjWgzIF3V
	Yxb4PF/BOMXD4jr7zgRmtBvic0myvdmJqSWAy21G7TW/cPOvwcT2HwvOdHrCGCyO2Qi7U7cCEGe
	dyho0oGM5Xml1TO1nxR0VvqBm3GtfqAWzH/n00jM6JZrlWhA1TsP4i83n6bMZFvOUf2qZM2U7cy
	sizjO/avec5q8ecRaGuM5gaPdD6fPPWVE6MWml4ZW90Y6V/Gw0IcbZkiNVti924+pzRb4nkjT54
	v3jdKUwFREB6dQzVxwc
X-Received: by 2002:a05:6402:4341:b0:6aa:9830:aa21 with SMTP id 4fb4d7f45d1cf-6b17c27b50cmr13522035a12.39.1792058309194;
        Thu, 15 Oct 2026 02:58:29 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b2038aa1aesm2182227a12.32.2026.10.15.02.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:58:27 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Maciej Kucharek <qchcio@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0
Date: Thu, 15 Oct 2026 11:57:13 +0200
Message-ID: <20261015095713.20560-4-qchcio@gmail.com>
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
reset) moves VRAM back to the VBIOS default.  gmc_v8_0 reads
MC_VM_FB_LOCATION once at init and reprograms it only on SR-IOV.  On
bare metal, the driver then keeps using the old layout.

vi_reset_quirks[] handles this for the MacBookPro14,3 by PCI ID:

  commit a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")

Add the test that SI and CIK use: an Apple subsystem vendor and VRAM at
0.  Other Polaris MacBookPros then get the same reset at load, for
example the MacBookPro13,3 if its firmware leaves VRAM at 0.  These
boards are not tested.

Keep vi_reset_quirks[].  Its MacBookPro15,1 entries fix a different
failure, a module reload after S3:

  commit a5be7ad8f5f0 ("drm/amdgpu: reset VI ASIC on MacBookPro15,1")

VRAM is not at 0 at that point, so the new test may not cover it.

After the reset, FB_BASE is not 0, so the new test does not fire again
on a module reload.

Only compile-tested.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a0435fd55..cad6bbfce 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1405,6 +1405,16 @@ static bool vi_need_reset_on_init(struct amdgpu_device *adev)
 	unsigned int i;
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
 	for (i = 0; i < ARRAY_SIZE(vi_reset_quirks); i++)
 		if (adev->pdev->device == vi_reset_quirks[i].device &&
 		    adev->pdev->subsystem_vendor == vi_reset_quirks[i].subsystem_vendor &&
-- 
2.55.0

