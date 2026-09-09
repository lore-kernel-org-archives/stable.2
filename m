Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6105C3DD87F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967619; cv=none; b=Ch/AukecnEQ2xWyCy5kzgA8DRl5kh4UVdJf05cK7NKsGBPU/ifEi12PJ4mk7VjnscIz9JYT/Mh4RkTGwVZMCRkOqqoJrokAnEdplwOOVUG5+96YmkHwakix7bcPKxMLHVVjgOjpMP6t+khWUGzJw8+OXSBM7FxeHIhMRKeWdIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967619; c=relaxed/simple;
	bh=8IWRGuJB27JQntsOKFz+EresHsv7pRs8+lXe0A0vvq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFXw1vdXdaYXXBprWVWRddJEkYsTjX4PFddb2D7GqM52309xnIM3uZunU/dyVjHX/uMKZ3xzh1Ie4Bd4YcHf0sh4ukxTnpK+xZCcBvb/v1CeIWTCLpSRXF1E18XCTn1sCPWiDDJVEI992LuGu21l0GCr8cANpyC8HbYaNIngRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7FSvJw7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7FSvJw7"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4843e9c5960so5730334f8f.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788967616; x=1789572416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LW1s8UaLa5lVEYEH+LErOL0dEAs8vOkfroCHFQDUI7c=;
        b=Z7FSvJw7fUI+xE4+tXlqGNywZOvMjuSQGzinfouYwswtRivL7NqSySuWF8PvkY2a+h
         HfTRYGphKqkqFZdh6zo7EFYXdi6DUpo9DoOEx0iEl4RyFHK2ANgLZR116kmTgpu1HH/n
         ogZco4YUw3AlTGkv0qL70QzkFjS0vbJTj4PD7ANV9Gu8R7T/KT789Hqfm5qZM1YKiyYV
         g28Pa0N2BpuT2b6Re+jEbr5Drr8fwFiiyXMzIZ896thvaBs6m4dYqGkAIU4qBJrxXSef
         qikBzM6I3FkjmmXxy+DJ/LWpBIPler5G3sQ1at0/nn0Va8XKY+mUu2hcNXs1IWa72E07
         la1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967616; x=1789572416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LW1s8UaLa5lVEYEH+LErOL0dEAs8vOkfroCHFQDUI7c=;
        b=IWV6V+43Lzl8nCBSOrJ8LPU3ysBumhgyHDHBmQkq8tOu/OYygweB3jgdVrI8e8+kzE
         FcQkQmY2tQOSGgO8qN98/L6chlmQnSIxFiGH0IbFUfmE2w6deiJMtkR0xt+EFIRKpOB9
         osSrlcMFFCZWuU6W7gNhaXTy0Ovy3iKGu641AZjLhQ0f9RvoTy2cGqAOKU9gGyzfbny1
         1VjSDQiovw9D0LtGoJ7f4O+S4OwSFNHSO1ZcV8mz4ZumFGY8Ap/uFbrAGOzomYIdZNWY
         B4+c3cRvZnsuc2TFQ9mDeOE2MS0XGrTqmDxYVvyBT+lf0ADngl+lg8JlQTruwGEIuW4a
         DDiA==
X-Gm-Message-State: AFuF++kVoJuA/+QVSJpmR+SH2g6qcYbAemZzAxkmJGHvCyx6hV14tOY4
	yyOwNCrQhnrBkMC5szN7vnjUQFhQ/aH3IRgEx5/Igox8EOvfNS1RGOjFqC217ikLY24=
X-Gm-Gg: AYBFou3IuorzxG4tSITeQi4WX7FGcQjw/0HXrZehcPpHClkj89kaAGAkT1afVfjgCjb
	KKo0SCgSFX1p2VTYVdn2HHNl0z+hugDI77R//SY3EBczvn3Rfy7ydH6zOoEEKarFtabDYsQZBGD
	c1zInmKQvAzI7+MGe6J3G9BqGt9pRKJBbXTCpym5ZhHjb4qFaGxtsrVQgdwSJ+yb18/wVMkHPgK
	EOm61TKCoNVOgMuvMLTKwkNlGJnssoVg9IP2vAsvmChau3LWP9Jws/bFFqxrmvhtg0Wbkd5rScK
	IlqcveJcAecosXyOPqY4ZT0zCow3vTiAh1Uf30H4ygxM5IDx+zJAS8XRy63w3kbKhqU/zpto9y+
	JnuBAMXXsloOoxy0fzMtUFz48Hf/MygYoKcvJ3Ymjp94qkkIGss7j07xPKYbQQOlC1uDeXFQg4v
	RpNYRiSc+Id7P4G/ZzTfYHM6yF0kH4m83ZZnRLTSw8s2Nw77Wd7jOFaHKWRqAj7CBE8dkG8TZLW
	6nsHuJJ84zvldXF+Q6VKIVgbAn2cRezJR3nXxVbb0c3LOw9R4QGmTJ84q5+dg==
X-Received: by 2002:a05:6000:715:b0:485:8c16:5ef5 with SMTP id ffacd0b85a97d-4858f0b188fmr27699493f8f.47.1788967616299;
        Wed, 09 Sep 2026 08:26:56 -0700 (PDT)
Received: from cachyos-x8664 (h37-122-44-64.dyn.bashtel.ru. [37.122.44.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485aa2c9acasm8901719f8f.36.2026.09.09.08.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:26:55 -0700 (PDT)
From: Akhmed Zhitaev <zhitaevakh@gmail.com>
To: stable@vger.kernel.org
Cc: alexander.deucher@amd.com,
	mario.limonciello@amd.com,
	superm1@kernel.org,
	Akhmed Zhitaev <zhitaevakh@gmail.com>
Subject: [PATCH 6.18.y 2/2] drm/amd/display: Scale custom brightness curve from full range
Date: Wed,  9 Sep 2026 20:26:35 +0500
Message-ID: <20260909152635.83860-3-zhitaevakh@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909152635.83860-1-zhitaevakh@gmail.com>
References: <2026090900-lip-ribbon-1726@gregkh>
 <20260909152635.83860-1-zhitaevakh@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 6fd83a1c2cdea48c396f600795217fbdfb8124f6 ]

Custom brightness curves use an 8-bit input signal.  After exporting the
full PWM range to userspace, the curve normalizer still divides requests
by the physical PWM span.  On panels with a nonzero minimum PWM level,
this can produce a curve input greater than 255 and send an invalid
backlight level to DC.

Scale the userspace [0..max] range to the curve's [0..255] range
instead.  This retains the full advertised range and keeps the reverse
readback conversion unchanged.

[ Backport note: In 6.18.y the brightness helpers still live in
  amdgpu_dm.c, while upstream changes the later amdgpu_dm_backlight.c.
  Apply the same semantic change at the old location; the logic is
  otherwise unchanged. ]

Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
(Move to amdgpu_dm_backlight.c)
Link: https://patch.msgid.link/20260813170959.22073-1-zhitaevakh@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 03ebb8001f..09fd92d2ce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4952,10 +4952,10 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
-/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
-static inline u32 scale_input_to_fw(int min, int max, u64 input)
+/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
+static inline u32 scale_input_to_fw(int max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
 }
 
 /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
@@ -4968,7 +4968,7 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 				      unsigned int min, unsigned int max,
 				      uint32_t *user_brightness)
 {
-	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
+	u32 brightness = scale_input_to_fw(max, *user_brightness);
 	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
 	int left, right;
 
-- 
2.55.0

