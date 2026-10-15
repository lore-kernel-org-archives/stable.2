Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB83E63BD
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088358; cv=none; b=NpPM9iT2yJXhZULCwftWqzHMozPKnBcUeums8G65GokILBPGrN/oOacqGSrpEofhzKdMHlPZTXTGw8lBBl96Sr8T1+4t3IHdB7bhLU0nKtI6K3c/D222Pvk6bzDlReUVZX02dh7AE1fiJetKHfflw1iwSQemthcjG+UwMmMndxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088358; c=relaxed/simple;
	bh=VZqqBLEnxS9ugMOxGQFBfi1P40DrM7Kg1GXdf4F60Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJ28617naZQUEe+mZUR8xGQfQawLBkNNHj56fnSZknVePxVw4/tclMx7Gr04EeL0FbcIXv0hPS3B+EBClQRe/b940CZkeegbxjlH20wyscKzybLE1h7/2Q97ZdR+pIy3psdeb6dsjwlyJRUqefOcYliptHzAZeIrdNWOHjPR2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPTJDvjm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPTJDvjm"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2e3846d1caso906694566b.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792088348; x=1792693148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0BT3ak9vMatktLwT+0i2Bx2HTKVL1fUGlR0dbooOuoI=;
        b=rPTJDvjmDoh9UYUJO306JGop53KEm5Y6H6xTuUe+KqThHJ2hHAwPVBla7XZI0jVBe8
         vwsPMlwGGZYTBr9hJ4Z8tuoSXs6dgjWybWDJI9ndztthW/CyVwxeJuACbFRcwqGzCENm
         Dtyev+SOkkKch956kdsBpG1dKNOAXv8FO7xssrMSjlHR05ar1QmhdWHah7LejewnV5QC
         HJFiFgDZR6RcLj3k8CeFyxczfsxYULrE4qv8XYNsWI2TALmq+bxQlHQdJUtbY9rxJ0XQ
         lqdRaSY+yfYp8uHRjSBAvwVJ+a7glxKcR7mbDcD6RzMl2E2t3G3x1engYNuq3Rz7gsdP
         WyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792088348; x=1792693148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0BT3ak9vMatktLwT+0i2Bx2HTKVL1fUGlR0dbooOuoI=;
        b=k4A09KgBciqPGRLf/sE8QdflXCkBaqMQlpQLHzhitK+Ud2FclybE8Zil9u/PYGG/nl
         KgpO1A1h9k5a/FdJPfKsyJ/9azuzEB36zsPx/Az3vqUZE4GdlyaOnDPXQKMbx0CSXN/0
         UfTDioVTOuOogBAQ94l7WekqqZHLJzgM0mvrdhS8TRSutkeq3sySCxlvfKIFEgHx5EUS
         ZJolOuDf68pn4MmrLlieDVtqo2a6x3NA1ZUo37flEncb5CX/xgBkPwE6teHaTz860OQN
         +9lOviPHoveYID4tY4IBLrD4CJPH77U/fsDlXjisav1TV6XLtjKjet0YetCIhrhN/Acl
         acCw==
X-Forwarded-Encrypted: i=1; AKwUvBwelPE+rPESPgNYdHKmwRrQMUAv5qVuE43DVj1ShK4uPu2R9mSOL+EL5qmU/7Mlr5/jG+aX8Lo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyLCWwpZcuZRqOFOS+R6DZk06s8AxjwN8ZN0xfRSuphulENFOT
	LOR7x720I/FN2IZTi2DLraAQTviCR08eNcSV1yM4gMCB5zP5n8jddPge
X-Gm-Gg: AYBFou0S2eouQT0op8tF56tFWGC9lvys1bADmISlc3mLTGZw6eSsAXLMGTAV9/f04U+
	5U1iMFfT6WYL2+ks/rDyD77YN9xBWxnIpYOTr0Y6SyCNaVkI7LUEA1U1ZLy1e9VTq4pPFklTtGK
	vm2f5h2wuez1lZhWcYOYxgaSCNa9Gr1qC5ya4Dab/JmnGEiVWgbY8C3YReHmK9PGq7ZjDh6KFnZ
	lS/WZ4vcNK8rOd1tB2L8MokHz9hbOeKXvlvzHswQ1VNG4ldA200lN4xAfYVLGi66TYtGWmUJoi7
	NO5kVupPxYyUGZOfNPncVySKlHWivlQzJc+fKheWqyALl2rvu0Loo9LanTwGiaoOivkBP1aU4LM
	GGEZVhkvNJdnBYcu6cs+oRr8AjYNFJHoLr8v7xOaush4B5cK966JJAJkisAktuQdYIPDe9etlps
	yBN2c5+80KPtKb4UBcWQa1G/71MWIrvgLfUHEMyCAFP3jW0Sn2ei8LtM6d+TMMq1lYuFjwuprvX
	UG5qoYQTk34iRfvQnWj
X-Received: by 2002:a17:906:d54f:b0:c2e:7fe7:289f with SMTP id a640c23a62f3a-c31a9d31c9dmr1819431666b.25.1792088347810;
        Thu, 15 Oct 2026 11:19:07 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed9b33006sm161790066b.32.2026.10.15.11.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 11:19:05 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Maciej Kucharek <qchcio@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] drm/amdgpu: reset CIK ASIC on Apple boards with VRAM at 0
Date: Thu, 15 Oct 2026 20:18:36 +0200
Message-ID: <20261015181837.41690-3-qchcio@gmail.com>
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

