Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848C37F33D
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088361; cv=none; b=U0Q59IiN6JF//QqJ+ifhKUyV0poNDb98LsEC2KDFeINOn+yxXxCBPntKoBjT/z+/LZ2V5KQipuymAqnUGspRrpgJkkcuzq2une9HTcRxrYJgSulylKkG9051RU5M3VlfpqvdRItJJPuGdfOxJHUdgSncu/LB7TNhiWY8oP+3a9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088361; c=relaxed/simple;
	bh=iyNecklT/MbMkGmZ8PwGDffRMfiDlI8VD87qxxMSHcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWpQAI1ArMvIpD+9Dd0o54E/YwHCFc3zZaeO5HGu1w6+P7XhRbDfBOijesR+JoBUduasGkhK1J5m+BTrgYUA+tMp0E82TCXR84fkHJ5bXrog8PUGo1ysZEV+lWz5QADf3RoyMcnSJ29XaiK7hVUDJwZs4Z31G55PsI5ge1RCQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9p9ZC4a; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9p9ZC4a"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c247f6687dcso854114266b.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792088357; x=1792693157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lEhb3zN1lMktgIigAcsrDFhn7TsuN5FvDjBWQSOK/08=;
        b=W9p9ZC4aZvdJ3mom52epdx34ynpmYesmxZZL3W1QgQCqm6KF75gHb7fJZHjG5dJ7zx
         4X1uxKjKE523tLfF52tPp65YVBVCqsGiVQPM43EdZubhNZq4dDzvPmUf29PUhuGoMjfj
         EYvT71oj8rcmPS02oF1TZ8RlZKWhMz8A8eOK1A3pAl5uJRLkB1do1JhtFoA9jKOoexgG
         phxmeF7MjfqkITcASTkb/e05UjK73cnF96Hv1UpwA/3/cY7QvEjXCO4SXTj8kz/bSSUp
         DqOOQ29oZuNHTKNR2MsI+1RxSA6sRb2V8zc48z9MLTprs8s5cNWlkMgdqLu/7XNfll/y
         /nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792088357; x=1792693157;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lEhb3zN1lMktgIigAcsrDFhn7TsuN5FvDjBWQSOK/08=;
        b=hBt0YZF71QVVGTtKhGP+h8o+y8BvUadJOx/wl3QE3UN8lxv3SDPQ//Q0VF1SbYNLQK
         Di+5UiMrvStecJjHezAVxrkZeqG5EWtRTQ+IhVLP9zsZY1ieOreVeZMZ7Gn5fvawYoCn
         2IzBXY//pF/QLC/BrGKUk4aC7Bm2yzVEA3lcPLm3lF/rHVG8Ui52fkWTYUwQPxEJb7oi
         m8JGnAZljOZO/YnO2kjBSO8Q6pyryG61wgHy3EYLbqZYN4Ss3LXlzIpaz8bZIW1snFoh
         GnTtT1N7jE5LQHu6MTDHvN5HX49CmOXdBCWMm/33uL9ICLO7XLn1qWDMhy71h1ThCF2a
         qRRw==
X-Forwarded-Encrypted: i=1; AKwUvByXxnp0y7igq12PZ6MewhkXCo03nkCuaQt6CFFQ5WbCecSOGg0q2Mqed+HTKPQzrYKTvHYBWUk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBId3qDw9Ekxy1uvFQrxBo1OPGEufcUnZcaALy79nKE+fStcCE
	/OjJd/vj8Kh/Q3AfXL0AgPh9+ngWxm+4bjR21ZPBnCaeayy5/dEEi213
X-Gm-Gg: AYBFou19BEphP11H5Km0wq3TVodpDxFkB9WQlE0vsKQNJIQWBMzLYiZBI2Wsd5cKlWL
	fUdVLl3CeFyIjDJBCB+ytbOeTpihM26XDLgfVm7wEz1DVA81KVtXRoO2IHaL23ZPN8d7Bt+LPXs
	lZz0Syois63cwIe3MjYt88hgWgv9DYJRn+CXFuOimjIRMoqIHHWgBOqnIlT5LYf6EbyuNsXG2Z5
	/P/A9BqIY4jCnTWwThC03Y4cvgGu2GyaHIjOOf10zINlwGPpmcYYt8DcWihliEBwInX4G9s3Pvz
	MCzhyZfWKxsFY9oRXlzqyUHCEwBmPxflqMv5osz5X603zZfGQ9UaB2uleeIeh192NXFtguCefo9
	U6pBQs9LlyYUYVU4pRpeILxY31ZfLct3V0J7a1iG/707Cp1A5vUGaLyhM/dUhAi89tZQGtY3UXu
	h26wHQXaw5gBgClD401CeHIeaI2M/TEAquWvumsaPOm0O3t+vmCDR00y8Kq7A7YHVgiKOqj9uZl
	kKN742BHJP40mfftkU1
X-Received: by 2002:a17:907:c60f:20b0:c32:4e81:fe1f with SMTP id a640c23a62f3a-c324e820e1emr1129681066b.27.1792088356858;
        Thu, 15 Oct 2026 11:19:16 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed9b33006sm161790066b.32.2026.10.15.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 11:19:10 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Maciej Kucharek <qchcio@gmail.com>,
	Andre Eikmeyer <dev@deq.rocks>,
	Frederick Morlock <me@freddy.us>,
	=?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0
Date: Thu, 15 Oct 2026 20:18:37 +0200
Message-ID: <20261015181837.41690-4-qchcio@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On MacBookPros with switchable graphics, the firmware puts VRAM at MC
address 0 when the iGPU is enabled.  A later post (S3 resume, GPU
reset) moves VRAM back to the VBIOS default.  gmc_v8_0 reads
MC_VM_FB_LOCATION once at init and reprograms it only on SR-IOV.  On
bare metal, the driver then keeps using the old layout.

vi_reset_quirks[] resets these boards at load by PCI ID:

  commit a5be7ad8f5f0 ("drm/amdgpu: reset VI ASIC on MacBookPro15,1")
  commit a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")

Replace the table with the test that SI and CIK use: an Apple subsystem
vendor and VRAM at 0.  Other Polaris MacBookPros then also get the
reset at load, for example the MacBookPro13,3 if its firmware leaves
VRAM at 0.

On the MacBookPro14,3, MC_VM_FB_LOCATION is 0x007f0000 at load, so the
new test covers it.  The MacBookPro15,1 entries fix a module reload
after S3.  With the reset at first load, later posts keep VRAM where the
driver expects it.  The reload failure on these boards is then expected
to go away, but this is not tested.

After the reset, FB_BASE is not 0, so the new test does not fire again
on a module reload.

Only compile-tested.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Andre Eikmeyer <dev@deq.rocks>
Cc: Frederick Morlock <me@freddy.us>
Cc: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a0435fd55..999aeb797 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1387,30 +1387,19 @@ static uint64_t vi_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
-struct vi_reset_quirk {
-	u16 device;
-	u16 subsystem_vendor;
-	u16 subsystem_device;
-	u8 revision;
-};
-
-static const struct vi_reset_quirk vi_reset_quirks[] = {
-	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X */
-	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X */
-	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x017a, 0xc7 }, /* Radeon Pro 555 */
-};
-
 static bool vi_need_reset_on_init(struct amdgpu_device *adev)
 {
-	unsigned int i;
 	u32 clock_cntl, pc;
 
-	for (i = 0; i < ARRAY_SIZE(vi_reset_quirks); i++)
-		if (adev->pdev->device == vi_reset_quirks[i].device &&
-		    adev->pdev->subsystem_vendor == vi_reset_quirks[i].subsystem_vendor &&
-		    adev->pdev->subsystem_device == vi_reset_quirks[i].subsystem_device &&
-		    adev->pdev->revision == vi_reset_quirks[i].revision)
-			return true;
+	/*
+	 * MacBookPros with switchable graphics put VRAM at 0 when the iGPU
+	 * is enabled.  Any later post (S3 resume, GPU reset) moves it back to
+	 * the vbios default, so reset and post on load to start with the
+	 * vbios layout.
+	 */
+	if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+	    !(RREG32(mmMC_VM_FB_LOCATION) & MC_VM_FB_LOCATION__FB_BASE_MASK))
+		return true;
 
 	if (adev->flags & AMD_IS_APU)
 		return false;
-- 
2.55.0

