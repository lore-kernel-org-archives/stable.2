Received: from mail-wr2-f27.google.com (mail-wr2-f27.google.com [74.125.225.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F4414427
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234289; cv=none; b=SGYXMyKcyI0zSjSoMz/QRNgmp96ts0FQeJCz03v2LQmNPW3Jnzv7U1HIGlgWCif8DfWNps9svEVWHOlhpXkeoEPsHb31N/okGQqD7yzEEQOxQFwH0A7FcpN+IsrC2OJGwusom37LroBTDB9Z7krzrXjjf9dUMvsTuJpB54pHLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234289; c=relaxed/simple;
	bh=rzUGhvKXG1QedQRI9Pa8yyhEiMF19LqXarJtEqui360=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=btGeHfQxPrKjuQyxHiY4JcaXzBQCuRaOJN3UrLCcRSBP0IayjldBMrW26TtMiZyZOeqz/DsFoQl0XWOVun1tbJl/sq8G0dlTQvTGADxuKKMobHsxt6s8pDrQratxCLt8gRpYi2XTTj8lITia5uKCmSEqQEP+DpUZLiYNwB81/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJVYgoT2; arc=none smtp.client-ip=74.125.225.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJVYgoT2"
Received: by mail-wr2-f27.google.com with SMTP id ffacd0b85a97d-4843796e373so1138012f8f.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790234278; x=1790839078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDX1YWZgv2v5Sh7tItNyghYlDCdlCLpMr/PsN3YN948=;
        b=FJVYgoT2djl4EtEfa2goUejQgqCeke6F2rPGYxnuoVaskxOyORR3AofB0gI2fJTno9
         FAZUQmIp97H1gQnEpMBAdBcNxSO2GqtY7wbfRJh6fk6VjL2VtBRlOFu+DTPxxBv/fPPm
         EC64mJ/8p7Rt2I0bpi19dbWVoFxE3mI2af+mMiJR0cpJV77bWHYgWFRPIhJ+C8tzcwEa
         i8SL+xUkWolUy2EadJtSSBaw7C3cZh1i3UtWdPhdw3xvmRM/LnFrRzXWOOgqPE+rnM8I
         HV8tN0uZ+/aOls7V2KKOI48Kbn1pZsVjIYuvzFLsI0gDcaU4VUsJUGltQ4WTOg1VS4gW
         khow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790234278; x=1790839078;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mDX1YWZgv2v5Sh7tItNyghYlDCdlCLpMr/PsN3YN948=;
        b=X5YPrfekQXoY+qA+6Mh6JT+i1bP6F8E+/GBqyB7Zbp9zifnMc6bi/dau423njzON1q
         gBzXBCnxBogfAcvDcOZxALJKq/BJRLfNPlR1WLbt/L2TGYK+71KIzeyiUEc6xLJA+ikT
         tbRHxhKMPU4hHRM133ftnaH/rUh2UbITvLdn1oo2vXMZnlR8Q6sdZm10/dOPwQLLw3UH
         BfU0XxKE5zN+EzSPI+Ir+Rlu38QQF2mjjq27vWgizyUbSwPoYD3RkrqrVP5kBwvrXrkt
         +W6Nh/3+nSsuClvc1hxzPOppxxVy3sK9DAGU2G1fjPD/AULz2jbL3WBm8IQ8RoM359fz
         cJ4g==
X-Gm-Message-State: AFuF++k382EdLr+sQZtc/LPxmgJoGVfWPARAblRJHY1dwVKAUjRUc7kA
	nIJLmfgOkKTFkMknDyUCdunlwTUUyczNKymgi1zrUfoZGX/WQm1YPJre
X-Gm-Gg: AYBFou3oIMVsCOQouDZ+91oQQzXVAcHuu0XPNxVVzBTmm15u2DGNjJJGPCsCx9Gg5pX
	G3CSGbBHvSEdLyh2he6V90kRaQv29zdbT85zCG/hpwhAbRIkvjtswBhnKVhU9GsEC+AqkWElu3O
	uI5rQnWfyXLC3eHP0royT8HJR0Ux9+68UsKELS52OJ6wJf/Sy4EQpTA5Hm1YXoDjkbMriAnw7jV
	H/zOgvTNqB0Mo/G6Xx4tleagbnagDVZE6FhEeBm9z/cdtvhFdkModxoUoDbfOn54LAYNzJ+d+NA
	Y2a1STsCCB3TDOk++8LB8vjhRmf7jL6klzKB5vsqI/AsjMWOOR6dmAaNR+9c9LDuWwmRVWL4TMr
	cIKAjFF7gITMTYNSZcSuLa4jm1Eur7sWIdAThVpI3eMMWP5UqWe0vFP5g545g0DPJSo5QOXaKTn
	2nZIW1OFIOc35Syy+H4h47Tj78wp6Z2mDYtI4L/xlDW26L7K6SlyykxIaWXgvGXdmVrad1BUStF
	ffj+4v9gN68DEkqBRAijNDjgoBEfq9YxTmGaXaTPjas1WqKgkdR1o77qrvi49IOYAPl00BQxxfc
	g2qlOc9camssdzXXoNo0fEPw4UoDsb+AZ39m7OsvUnxw3xkM7G8R76z1LxY=
X-Received: by 2002:a05:6000:1889:b0:487:2329:9d0a with SMTP id ffacd0b85a97d-488716f417amr2555483f8f.33.1790234278385;
        Thu, 24 Sep 2026 00:17:58 -0700 (PDT)
Received: from AHERLNXVDANI01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488688856f0sm12169213f8f.30.2026.09.24.00.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:17:58 -0700 (PDT)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: danividanivi@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] rtc: zynqmp: Enable crystal oscillator in initialization
Date: Thu, 24 Sep 2026 09:17:52 +0200
Message-ID: <20260924071752.79314-1-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable the RTC crystal oscillator bit in the control register (RTC_CTRL,
offset 0x40) during driver initialization.

Although the RTC_OSC_EN macro was defined when the driver was originally
introduced, it was never asserted in xlnx_init_rtc(). On cold boots, after
battery exhaustion, or on platforms where firmware does not pre-initialize
RTC_CTRL, the oscillator remains disabled and the counter never ticks.

Asserting RTC_OSC_EN alongside RTC_BATT_EN ensures the oscillator starts
without relying on bootloader initialization. Per the Zynq UltraScale+
TRM (UG1085), bit 24 (OSC_CNTRL) is a static level enable for the crystal
inverter rather than an edge-triggered reset; re-asserting it when the
oscillator is already running is a non-destructive no-op that does not
glitch or reset the ticking counters.

Tested on Zynq UltraScale+ hardware, confirming that the counter freezes
when RTC_OSC_EN is cleared, advances reliably once enabled, and is
unaffected when re-asserted while running.

Fixes: 11143c19eb57 ("rtc: add xilinx zynqmp rtc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
---
 drivers/rtc/rtc-zynqmp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 5bcb7536e973..278705ec09f5 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -167,9 +167,12 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev)
 {
 	u32 rtc_ctrl;
 
-	/* Enable RTC switch to battery when VCC_PSAUX is not available */
+	/*
+	 * Enable crystal oscillator, and enable RTC switch to battery
+	 * when VCC_PSAUX is not available.
+	 */
 	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
-	rtc_ctrl |= RTC_BATT_EN;
+	rtc_ctrl |= RTC_BATT_EN | RTC_OSC_EN;
 	writel(rtc_ctrl, xrtcdev->reg_base + RTC_CTRL);
 }
 
-- 
2.53.0

