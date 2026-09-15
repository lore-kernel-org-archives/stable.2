Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446AE4AEBEE
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475443; cv=none; b=s2i9RsVHGQPSYg9av3ZNAQM7LEszZt2tmQvS9jfp3s1XaZX4LEw67OzxtN4SaexZGZVmd/jH4C6cen460LLRPI3LHjPJoC9cvDu17qObMswCNTmlJ5VLOFE9f/yVnlEvazhSv6Kdjic7xa/rh3Zl9prG1W5caF2kil3t4QRz7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475443; c=relaxed/simple;
	bh=rD24ettfq/yp1pQmJ0kLVwsU5W/LV5RYcqusbnnOepQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifd3Q8fKMmmTVA3eurkVkHWbMjwbi8u3jzWZT3ey+vWpaDWIJAtvgaKhozG6eC4kZDWF3bovCFtAva0TPAN6isYDv6v18BaoItjhdwiLl3Nd/GChlY8oEhPMX1rPndRD4tqo8Aeghq+xPfybpTS712cmn5W/9QoM/X/Ofarf8bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqwyhhm/; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqwyhhm/"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso29982895ad.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789475442; x=1790080242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xqadnkZnQpvwO0yu2aZCQtLbtAViRwE5+Ankys+V6vM=;
        b=Tqwyhhm/qk2uBraPWQOJYiTLghbGUNE3NYtSIKcrYvKSuVXblfX2sPcfo9T1FzVaoo
         u43HBmnROPCzIS8v3l/58yzIckmyoMfVL2AwhqSanHTFeOO9zSAC77Qz0DV1byI08QFd
         YfVE7DuazfFgTYR5/8Qfu4y9jp3sqVkEu+qBhvT+a3NfiU+F8GDDrWz5x1G7079YTWsF
         nyrHXU20Js/xuHeaDjzsEkj/29TpXOvZv9PlBdyaA7d5wDd9Hrxk++1tb+Y7HRJnd48i
         xRz6HdbnAelqUjA/1ilSqqFGyR4vNkIDml4WVM0ir3AXOiSqSvakBZuoOPEnkNAy3Og3
         OqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475442; x=1790080242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xqadnkZnQpvwO0yu2aZCQtLbtAViRwE5+Ankys+V6vM=;
        b=vD1N6tL7kNF5hmKVoP5U442eJFiBhA85rmeCOWoZaucZ99bLATihrIzo8IgMUe1UxD
         Og/rCiiflI1PJvp/n3eCk7h0Ict8Miat8fGuK8QsM8MeoMPx/PcRnQTLLqu14ddN7sjN
         UQd7+0xrDGl6gutXzXU2B6g5ziaO2OjCIJRQkjBnBFbpJvJdy5Aw4LutS2dqLpFi3iOH
         uFTxHdqe00WS5Ge6vsFyETTcQ+65rz5j7bdb40XAhBSe1FTOoTACfhi+uTUidhuJLF3X
         3tL/Wc49/+yc3ipP1PYnqOy2Ms4ZSKCZZzZhpoJvfDvdPFnaB6sxl5hLE3pEBiVRY00E
         ek8g==
X-Forwarded-Encrypted: i=1; AKwUvBzaYgRSYBCJKmG8bbUZ1FD/qrVRZsw+POIn67p2wCGZoeSi0SPw6DEjQJGnLERKx1chdRmpBGY=@vger.kernel.org
X-Gm-Message-State: AFuF++mBu+h2UxS/PeDS8/bp9ptxSjZxP5ve58EpktYTVKQxPW6YAdWN
	/HFppeQf4xQIsmpuFimFGto+2zwfXCS1V9Nu/YFVkiBXIXwW3pSyw8Hz
X-Gm-Gg: AYBFou14VJvxb42l0kaeqmAZRo7R5R4HK3I3aMANbPrnVeWW/BlNffYw0xxBUXZVJ+f
	QCw8N6hvpiAltKNpkrO67MLwghgDVKqOHrzU7yXFHb+EUGpd0T70AlXHk8F1n5pCFInIZ1qI/2C
	kXicjFNQEoF18J1AiR5HRE52J1naUGEE59eNB1S7h4uatnX2dDwtr+ICCglf8M2LXNeCGMYXsnO
	2aLh/aXc8E7Qdv5mWCZUVvzfl1khf/c4X/I/GAGSiy+6OY1vZCn4gd3H2KOCtojaX1HDzB1BphQ
	llRHtxfFgpvX9xLL1fqfy3gJQXEpv8veQ8AnFn2Yn8d2Pbf6uEkDtOT0o6RoWRlpgmD8naxIQrB
	g/ah1uWDCDQ3TcY2HLM63v9vWvuFWAG8fufvyhXjWDh7ziANgWvDBchEdBGylSK+VDtggu5GX3F
	RWYXCd5+2i8nRgaWF/ohqyENvtEHjkN0UN6ilnLxtpCnQiXoz7g/ATKiY=
X-Received: by 2002:a17:902:e54b:b0:2d7:203b:9863 with SMTP id d9443c01a7336-2dd6c5b1084mr131399045ad.1.1789475441464;
        Tue, 15 Sep 2026 05:30:41 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd76fc2c54sm12402345ad.72.2026.09.15.05.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:30:40 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	"Bryan O'Donoghue" <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: venus: avoid HFI resource leak on IRQ request failure
Date: Tue, 15 Sep 2026 20:30:09 +0800
Message-ID: <20260915123009.2420780-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

venus_probe() calls hfi_create() before requesting the IRQ, but the IRQ
request failure path does not call hfi_destroy().

The history patch moved hfi_create() before the IRQ request to ensure
that the interrupt handler context is initialized before an interrupt
can be delivered. However, if devm_request_threaded_irq() fails after
hfi_create() succeeds, the error path jumps directly to err_core_put
and leaves the HFI resources allocated.

Request the IRQ with IRQF_NO_AUTOEN before creating the HFI device so
that the interrupt remains disabled during HFI initialization. Enable
the IRQ only after hfi_create() succeeds.

This preserves the protection against interrupts arriving before HFI
initialization while ensuring that an IRQ request failure cannot leak
HFI resources.

This issue was found by manual code inspection.

Fixes: 3200144a2fa4 ("media: venus: protect against spurious interrupts during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/platform/qcom/venus/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 243e342b0ae7..42348bdc2332 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -432,16 +432,19 @@ static int venus_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&core->work, venus_sys_error_handler);
 	init_waitqueue_head(&core->sys_err_done);
 
-	ret = hfi_create(core, &venus_core_ops);
+	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr,
+					venus_isr_thread,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
+					IRQF_NO_AUTOEN, "venus", core);
 	if (ret)
 		goto err_core_put;
 
-	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"venus", core);
+	ret = hfi_create(core, &venus_core_ops);
 	if (ret)
 		goto err_core_put;
 
+		enable_irq(core->irq);
+
 	venus_assign_register_offsets(core);
 
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
-- 
2.43.0

