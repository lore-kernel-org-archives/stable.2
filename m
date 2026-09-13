Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EAE1A3166
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789265646; cv=none; b=KiA2KjdktDCZXwQ6VlSVNO30VnYJq2nKQ9VZD7nxRCo+OUPZCjeU5OW/z0RwuR8iHwkSeUhkQUV21U6AhnT7kwVsSaBxwhtPv5atHwdUzU3+/GdmY4S9hfiO9BPX52IqTLcimmqdwvjfURmUjtJ1aSvgD7GkofImcv+LpAbbge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789265646; c=relaxed/simple;
	bh=+0JcbwgDBAnCe37S1lbW1di/g8nThyfXp0uPh67aoJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGyr67bIObb0jrLBAhmy2y1EiiS+On0wgI0w/FGIvRghypgFidUEMF6g/gz4sVhGjUechtbYpBy+S7Ko5m4TGTYFDuYS/BBBhB9iUrFFWTmoD+avddKAxuyX0cI2Yril4fjrdndUHc/nq5iOXMrG6HzlBa5pHx2D2ABV7TRXGzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptsTaoOg; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptsTaoOg"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a0fd41a7bso53796285a.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 19:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789265643; x=1789870443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=88ICzwtScsGBN29oTXuL8hAaTuiJVGtZYlaw6P8iREg=;
        b=ptsTaoOgWBFz21BIqyw2zsxvI+XBkXCYeB1zkpDXlZ87Uhv4zQJinlkUe/ReTPUYsU
         yo1mv/fDtq++xQ+G7cG7xkCfqYaEOf/TrFnUwjTow/tmlNvQ0JauY8ZqVDwEiCrpHoqw
         U8tK8dSwItuiutFGjU8nTLHN3wYYNWHrTtYHiHXLRkJ7hAbxzwbdVZTXX09j9H2yypU0
         tNLs5OykV0qL+Bjvtz2FBsfmbLoxVHd3iR4RETuPMYJlinK/w07IF5WB7+Yoym/F48Gv
         DN+1DhBqew6V9aJbfu7SWZin3nshKS5VpqcvbmltIwrGx8NCX7H008H47weSdidA8AG0
         D2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789265643; x=1789870443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88ICzwtScsGBN29oTXuL8hAaTuiJVGtZYlaw6P8iREg=;
        b=jlvXUboPV6yg8KtqMpCGTGMywK+x5SvDNk6nVhmI6tBfxFlZ3cBNE+M9nJICtsd8bu
         sEyaFLoRYvXW3UrBytKrogXR13edHzqZgNZtn/HL5aN7URCGJGNpAl80gPUOW0oZZzty
         /0038CFCRee9y9u48HZCG3tkBFm8nIFf1JugZ4cyFdNQm/gLID6uI3rbX8tFVDXFpeMD
         3JyldsMLTuLwIkcP1s8XWdWuF0IDsO/3WGppxe4jeNEqJHub+WYpgc9HYum86JPxPfbM
         l8NyrmN9bRLyUObJZs5vqCoB8/11hBaLcsGYraBhT2jLYYKvWnqTNeCVhOFKaHeJtfOa
         UwIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPIQPh9jhq/WnOCPcHbXUujGJ5RjmSGigyDy+rWLrdr9lGEfggljeQvfau3caO0dIFutdqS5Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lRxyqILc7q1uiQ+ZLJaFLNgyYJWDzndwazxxS8kB78sIo9NpHr
	58LhoO3Uu2Ali0vlcbTRmH38Wq+/vZbJ2wMa7wcraZxHDBb6+0Lfya+UQK//koWL4A==
X-Gm-Gg: AYBFou1GTyZM6s8khn417zEyUwDW1EKG9E/8ODljM8JGxfUIXoE8Pu8b0jvDdmUUZ0M
	1QufMV2kkUg9PeOeLCkCdtNEruEJl7rzr2WLaUlY2E9+lsCPmvyg4SuPiiwTMvkGQVlxwv8eCp1
	ZAcWa8jzutW+iXGty8e5OxbxCxt7jKxzjkBQEZVpoU2LTZhL32eBaizk/8BPW4ItXQwRDEWEnbX
	j/vbbTZqR/mx3xLm2hjCTIrl3g5nx22AmE2GCRvz5lS54mszyWHJWIB+tnaWTYzighXfghOM4Av
	KODjOJH4bON0BoPDxbcYOoKwsbxCsiuGoYCjDlxz8DwRDDzA2Z9XNxuaZdxVnWcJQFCc0oZGHzT
	KvJkOQo0zUXQMhgAR61bpcJwmA/Znwfd5hkGCb/OW1s5rJSxGc/sbNiyAaj6hgPGQH9/90q5WVD
	tv5b3OlYz32qT/k0Y+ZW+4lxIPrkXmofW6weciBx84fjKiEYogr3bBmGHJcW5kc8wUSh6cMAH13
	4OmWjVBTSUw9dDn9B2T6cNLtkZEr8jaQPN5mraa5+6tmSCXmcMLGMFVMk0r1G2saMx+YJ2vHDmq
	qH/f6Rp786rFLKGEfiiG09/OjDrwp3x/Dw==
X-Received: by 2002:a05:620a:838b:b0:939:9bcf:8d35 with SMTP id af79cd13be357-93a03886412mr757341585a.35.1789265643185;
        Sat, 12 Sep 2026 19:14:03 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e8045d9fsm629778085a.19.2026.09.12.19.14.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 19:14:01 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] soundwire: qcom: quiesce runtime PM before removing bus
Date: Sat, 12 Sep 2026 22:13:56 -0400
Message-ID: <20260913021356.60079-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm SoundWire controllers enable runtime PM after registering the bus,
but remove tears down the bus and iface clock while runtime callbacks and
the main or optional in-band wake IRQ handlers can still run. A controller
that is already runtime-suspended also has its iface clock disabled, so the
unconditional clock disable in remove unbalances that clock.

Disable runtime PM first to cancel pending requests and drain any callback.
Free both controller IRQs synchronously before deleting SoundWire children,
then disable the iface clock only when runtime suspend has not already done
so. Record the powered-down state for a later rebind. Bus deletion does not
require a resume: the Qualcomm master has no put_device_num operation. The
core disables slave runtime PM before unregistering each SoundWire child.

A pending runtime resume can run while runtime PM is being disabled. Make
its clock enable failure visible to the PM core and restore the wake IRQ in
that case, so the runtime status continues to describe the clock state.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 74e79da9fd46 ("soundwire: qcom: add runtime pm support")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/soundwire/qcom.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 55678a30c..35e552cc0 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1713,23 +1713,42 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 
 static void qcom_swrm_remove(struct platform_device *pdev)
 {
-	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
+	bool suspended;
+
+	pm_runtime_disable(dev);
+	suspended = pm_runtime_status_suspended(dev);
+
+	devm_free_irq(dev, ctrl->irq, ctrl);
+	if (ctrl->wake_irq > 0)
+		devm_free_irq(dev, ctrl->wake_irq, ctrl);
 
 	sdw_bus_master_delete(&ctrl->bus);
-	clk_disable_unprepare(ctrl->hclk);
+	if (!suspended)
+		clk_disable_unprepare(ctrl->hclk);
+	pm_runtime_set_suspended(dev);
 }
 
 static int __maybe_unused swrm_runtime_resume(struct device *dev)
 {
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
+	bool wake_irq_disabled = false;
 	int ret;
 
 	if (ctrl->wake_irq > 0) {
-		if (!irqd_irq_disabled(irq_get_irq_data(ctrl->wake_irq)))
+		if (!irqd_irq_disabled(irq_get_irq_data(ctrl->wake_irq))) {
 			disable_irq_nosync(ctrl->wake_irq);
+			wake_irq_disabled = true;
+		}
 	}
 
-	clk_prepare_enable(ctrl->hclk);
+	ret = clk_prepare_enable(ctrl->hclk);
+	if (ret) {
+		if (wake_irq_disabled)
+			enable_irq(ctrl->wake_irq);
+		return ret;
+	}
 
 	if (ctrl->clock_stop_not_supported) {
 		reinit_completion(&ctrl->enumeration);
