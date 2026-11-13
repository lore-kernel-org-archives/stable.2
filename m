Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551678;
	b=ZtQzgLvlm5qWWtYBkfuHC5VTrMwEZ565Q+lK22bDJ4sIp9qzRitVjJwzbi323GmCiMs1
	 sTwjJr5VIJPuw8gLpaExgpCrSX9fzjcEM0oDbJSzbY48lYafgvHXUjgEVFaUS43vGohc6
	 LJeEJA3XShUpuA/w27n6pFOnN0u8FxxqzFP8dwqt6Gt6aIQDVoZ/l+CWImmsjL6TDFO17
	 UOyZqEXEJckwkq//DiOupVnJQvJ/Qs3Rru5x/RkPvlSEIxQ5KqFW9T8Wuu6fXFWd33+6T
	 +89qZugWmVcRz2GzJ1Jd3ebIJh91vrvIBgJiXRT5JME4VfccTRs+ogtr1XJj68Of45w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GOfNEqSfoT59QxdKyBFLdjbrDM/jdxFlBB/CFZZqigo=;
	b=2hqPzPMH/OTZWuQGT6TkA0JwmMcjIQ8Nis19ICHIh54uChn6uysy2z3+hiXhVIT1uyoR
	 HDOUh/EyyP8LMXAONNkD21AJFJGN3XqcXs2HR8btnnN4falGcjiTQP6BA/FJjYGWcLgw1
	 vhLEWF69eeMrPL5ju7QlvCH7Z5qc6TGWTkqATm/xB6A4/Uk07saMwri2wDT8ZiGeXxjlh
	 9V9uQn4WACooOl7cOC8EDNOOs4ig51LTODIvl3/7Sc/Mz7+mL0KXP64Kf4BGILybTO2c8
	 NS/bid+WCT7BpDPGFD/ExzWIF18aPGXS6bwKhRbgR28aSIrhWcRJJRy/OrGruSh9A2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3Loi+yZ;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F7606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 06:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 891F7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3Loi+yZ
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37605faade6so83191eec.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794551678; x=1795156478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GOfNEqSfoT59QxdKyBFLdjbrDM/jdxFlBB/CFZZqigo=;
        b=J3Loi+yZKa0+P4Zo53EZvQDMuRxiuWsWDWXTJSFSt/2USleNVCFUgBgh7yT6OHZnCx
         3AFDPYUMu5C097q+gFZ7ZlobUPJFRCNLnrIjRgZ3iH3nA5SUH2ifkkQ5cPxSS6i/ee42
         RiUDcx5MdY63uLkqIFf98yOd3oiSnrYoZFxNRxaYmOQ0B1XlvBiwR7JVj/b6hvFHDlZ2
         a7RqBczAb3A7xq4SXez4R0hikQMrVSGJN6D5ibsqkh1t61u+VjTz+GH7e7r9uNb144C7
         Dou4inIMVRNHxP14Usf+enIc7BIB7haVm4Jp9uJHH+913uVLkzBkeyyXb3vhQ+77y/+F
         vjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551678; x=1795156478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GOfNEqSfoT59QxdKyBFLdjbrDM/jdxFlBB/CFZZqigo=;
        b=00Wz69Ye4hyPkuVmSzWib5cvQ3YzYkGEStEych+39SNDpyvpJL8aiQ9GKGOqgKNe24
         BukLwkby+twdZVQ/LhElVfcTLI/ALKBJ1HQ4yLssm3Ol8GHJi0A8feRaeInWUmGrCxgB
         beSeMOjYUqQzwd17YzRlXnHZT9+2nX/uIq50gx/WD8hRP4H5ZvopaIOPVlz+weqErFzS
         EPfHs5PnwzKG2o8Tn/muYWQwxjeDhnFpBYogeWjPxdE4WQQOhvE/QznXYB25/8gpjUkh
         5I7Jh0y5I8WV7UByresFgaRPJiUsY3KzxVIBih5+o2i1iSxkf0XaEEASJ1W3W3VjV+t9
         kjlg==
X-Forwarded-Encrypted: i=1; AL+hErGR+xgEhOO0YZivagTrKmQkAlDOo1+TqLvvsX6v2TRVTVj74Nd+1re9H68jEsm2+TlwfnxyIxQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aWbmxBBTjDl85pjJpFYGqUIqs8lWkv8iPoF/of5elvqCUWXQl
	MTDiC3SUsgdZ/j2LIhM2XYRhZmRwqXHr7hEaehiMptLpyDF/6xhPiv63
X-Gm-Gg: AYBFou13L1NqfJ72HqyDy+Mizp2kfRIyTa51St+RscmhOgnfoHT5AOWyJYqVH7dDXQH
	5lUNIE5+l+lDXTSzgTQzcZoGtPsm6NbVqzwPs1sQeOBqYzhoFJNbeYPiVEOgrXxWyl8tcWu0B5Z
	R+p0gWgQtubYs9zEesi8LqwkKIJW4GIzabU6MICR8nMrQyeucNgFxIzyHgFq68OGCcBKATEwZFe
	2NKoDbbOPHohPCSnWn8EHKG1hlxFlhclYYM7+phCOnOGjXTv4L6pHFQYXF9mfJxGbJD4BlNvD1R
	eBiwPlzhwSITIsT+JDpimtBhgFuE/smi7ExL/4FU57aufNfnBtB+qF/9Pd0OlgNL5ioZMvon/Hh
	xByp8NW63RGP5CyaX2xSTPuB+qo/vXd6FzaQSMtkfeJvIid6lHVgecfgHbe+hBJjjPVH/ZbHzwe
	UtmKz1aCqaDZFHzfXTB7k2u9w221ztzwOphe3ig98NEuyjuKHL7sYp/sLjv8jfcdddi7Rnciv+8
	L/Bm62c8Giod2snpstrSU/waHEKjVBqOpZF+NQqT1T6NsZ9Yx+SDkHmvBwKrJ2+TnRP0kbahYII
	wXdrfUOdyPa8I/AAgW8FcZU2o1fvsSASsrzWYDJObA==
X-Received: by 2002:a05:693c:881c:10b0:36d:5fbc:8c8d with SMTP id 5a478bee46e88-379655d503emr2060686eec.2.1794551677672;
        Thu, 12 Nov 2026 22:34:37 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379569b8389sm6745027eec.25.2026.11.12.22.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:34:37 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: linux-usb@vger.kernel.org
Cc: b-liu@ti.com,
	gregkh@linuxfoundation.org,
	nkapron@google.com,
	tony@atomide.com,
	bigeasy@linutronix.de,
	balbi@ti.com,
	shimoda.yoshihiro@renesas.com,
	robert.jarzmik@free.fr,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] usb: musb: dsps: free the VBUS interrupt before the child teardown
Date: Fri, 13 Nov 2026 14:34:07 +0800
Message-Id: <20261113063409.47485-3-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261113063409.47485-1-lui2012qwq@gmail.com>
References: <20261113063409.47485-1-lui2012qwq@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dsps_remove() unregisters the musb child, which deletes
musb->dev_timer and frees the structure, while the glue's VBUS
interrupt is devm-managed and only freed after dsps_remove() returns.
dsps_vbus_threaded_irq() re-arms the timer via dsps_mod_timer(), so
a VBUS event in between re-arms dev_timer past its deletion and
otg_timer() runs on freed memory.

Free the VBUS interrupt first, which also waits for any in-flight
handler, so nothing can re-arm the timer once the child teardown
runs.

Found by static analysis.

Fixes: 369469a92393 ("usb: musb: Add support for optional VBUS irq to dsps glue layer")
Cc: stable@vger.kernel.org
Reviewed-by: Neill Kapron <nkapron@google.com>
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v1 -> v2: no code change; collected Neill Kapron's Reviewed-by.

Build-tested on x86_64: musb_dsps.o compiles clean
(USB_MUSB_DSPS).  No runtime reproducer: requires AM33xx/DSPS
hardware.  Fix written with AI assistance.

 drivers/usb/musb/musb_dsps.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 91d8712efa41..69c8b4b3ffa7 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -942,6 +942,17 @@ static void dsps_remove(struct platform_device *pdev)
 {
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
 
+	/*
+	 * The VBUS interrupt handler re-arms musb->dev_timer via
+	 * dsps_mod_timer(); the IRQ is devm-managed and would only be
+	 * freed after this function returns, while the child teardown
+	 * below deletes the timer and frees the musb structure.  Free
+	 * the interrupt first so no VBUS event can re-arm the timer
+	 * past that point.
+	 */
+	if (glue->vbus_irq)
+		devm_free_irq(glue->dev, glue->vbus_irq, glue);
+
 	platform_device_unregister(glue->musb);
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.1

