Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743513;
	b=QaARzRqPH3rWkaMbRwkBMBOBgxr/9Pbyw4XdXeXNlJd2PrH5caUKRdQwVJn238GihsG9
	 SPTqTceBRLDecDFQQCViUqNKaaqkuu4ktseI953jjB/mVnc+BnmwVKR3UXxsRATOHHODJ
	 XXO6PKC4ryK9s2vmPKFT3K2gVuLTAGvAhtrvYSfplR1Zho/fJG71EwMIctCX4JbfbV0j9
	 xyprNUrB5Ni6TZxjCggrvAAqVDu+Tz6tsACJ+gnmHzXzJCILikyQEltpcYqd63H3XEIma
	 j03N6fQk38LeXPrqAS0lp1PEQekpSFs4a2kNgSirqjOZqjwuLbybXaCjVYqwl6msDag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=n5vPrfbmjtB4d4z+h+75wRb54w4l+pZIgRZmf289DF4=;
	b=ANaMd1LJ1ghvrx8+q+CtTrGzH7RW+NCXvHWbYKraTyprdZuz0xBEpVSwiHB3EKMiC5EP
	 Gre2rOhxwD1To3kNlNpmQ2yKB+uynNCc0t1UqZ84YTZkLtA6zSPUaoFD4sFurL0HUiJoX
	 62G4qv0lIn4YKNOnpcoFx5qasGR38G222rRH0q4CGSe0GKrPUyUSzM/WnBA3iw6S7koZ5
	 rZ+1V6OuLm0V8oAHTLf7XEdYFqUFkXa+2wpjPqZtSfttjQrBpy53ozAV/QE6x0cnZpRoD
	 tVGOTgAXiM3UlPDXgMgpcByfrSZ9hrBznHsY6rdy60U1ITjG/+TMAqgEMKAxQJzhZAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U5UB5jg0;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C6606A32F
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 157C6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U5UB5jg0
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so378073a91.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792743512; x=1793348312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n5vPrfbmjtB4d4z+h+75wRb54w4l+pZIgRZmf289DF4=;
        b=U5UB5jg0MQlQYbNuXux7dTw0ltZUfisJz2vPD77hmiYC1LgyP+lRIaq9jgJJOZgBOi
         gKtT3TZaCHB7A/dhbwoNvRDF4oaHHMlqvxpddr+A0+3m7zKvAXqKRmqEcGoEYpQ/o/gB
         +F7BMs1HeZFjJGro8fl7JS9LqgHF3wpYFr46oxMDCyC6d28VJAeAounbfIyUm2Xu2yPN
         Uk4vecIvihbZNNs5Av71eI8AfdKv2CWnvfXkDOJge03MnA9oyBYWFyvokDyZ8fd57e7J
         wXWLOIURgjr3thaczfszRlW0Xtk7WsPb+OhrYw6/k1gpMsguNmvnK3LCFFHiI8tTqmIL
         csTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743512; x=1793348312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n5vPrfbmjtB4d4z+h+75wRb54w4l+pZIgRZmf289DF4=;
        b=Isi+nvfImz+8zn4mPR0OKmIWpQBfQGm+bVThziBg0ZnyYv+iLx7pOZxDzoNqdlKDR6
         7DmMChG7l9vgCV1W4ibLa0t4gII5hGAyJgVOCx5h0GcOuO10/E1mQ424RZ21FL+Wc/CI
         x0sSNcjNaKoHSYN4s/F7zK90Ynvnn0IKjrLYXrbUyIuyZIL/QO7DmwRX+0uMkITy0p0G
         bQnnNYt1YKwxxPEdSvynRvFN7AKrULuwWenV0QZw/0X7/QxzccZ1Ox/WlRCIYyLbZ+Lo
         jRON3yfiOyzhTx2bgRz9ZKgVXem2tTmMCrv7SFA/pOVXg7S5WWv2bXk81WuEmTb9E8Jv
         +rlA==
X-Gm-Message-State: AFq9FYICL6D1hfvuHl+RPwI9NUCWBuvGuRiFeUWMLpuDagZOkS4c0HKf
	43fNQYq1yu52HjtHYgHabIFtwNPE8y4dB+D+KVo8sd33K9q/lb0GeNns
X-Gm-Gg: AYBFou1beYSERQnrRQ89X2Ec4A50+T/oXcoYGPS3vH8Q4d+X8gvyMija3TzfHQ/LOVW
	IImXj21xeFW68krgbcFdjvadFjBg3KEvbQ0VVxbTdPwaLyWqGdTro2lijQ1Z2XV+FnByDFd7Yyc
	nokwTPy+f05SpNABE6ljXHeMeMdgN6TYPW1Mhct8z3wiUx8XcqbSO8mf1yFax4UveUE6IKU2o+F
	QlnxzM+IlsrXlohtg6NTqhwe6vSJy0SE4SyTs4mXUfznhoya+U+fBHY179PoGAJGvTJcDF3smaP
	wnooiJLMZk2m0cjt5cckrnymM3sIhDXJljIHM2jBZLVKwbS03+vc3fJcrMfc1swcywfmL1XiEAN
	r3cwG9LKJ/wC/kTja0YzG8X9tluVYuemT9BYoWrvrO5+6t6AT7503eK4y3OhLkTRBS/CGZ99Ri+
	RAAx4Ke/ro3GH3rchHA9XlftBl5girgRYhSdLfOMMSZ6csFhHgWKqZdaDhoLD51aHt+4I7qoF8J
	dXq2UoXEBi8AoAU/KXL8d9V0gZnhZvHv4IXcx2uniCiQvpxNcoQSd+2oWhpyCFKfEiqaGnK0lNC
	W5RG/eG+KprIUxfQLhQ062ZmhXNKizkkDlPPtpWwAXD7T2TqFqle
X-Received: by 2002:a17:90a:d007:b0:3ac:9a5e:9ce9 with SMTP id 98e67ed59e1d1-3adce02dfbdmr1235557a91.29.1792743512400;
        Fri, 23 Oct 2026 01:18:32 -0700 (PDT)
Received: from hostname.tail4fb79.ts.net ([2401:7400:c804:b668:65cc:625f:9c43:1e88])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3adcb1b134csm2532052a91.8.2026.10.23.01.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:18:31 -0700 (PDT)
From: Ho Jie Feng <hjf3108@gmail.com>
To: basavaraj.natikar@amd.com
Cc: stable@vger.kernel.org,
	Ho Jie Feng <hjf3108@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: amd_sfh: Use shared interrupts
Date: Fri, 23 Oct 2026 16:18:02 +0800
Message-ID: <20261023081803.21761-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The AMD SFH driver requests interrupts without IRQF_SHARED.
This can cause VFIO PCI passthrough initialization to fail
when a passed-through device shares the interrupt with AMD MP2.

Request the interrupt with IRQF_SHARED. Check for a pending MP2
interrupt before clearing and acknowledging it, and return IRQ_NONE
when no MP2 interrupt is pending so the interrupt can be shared with
other devices.

On an AMD Ryzen 7 7735HS host running 7.0.0-38-generic kernel
from Ubuntu, trying to pass through an xHCI controller
(1022:161d, 0000:e6:00.3) fails with this message:

  genirq: Flags mismatch irq 45.
  00200080 (vfio-intx(0000:e6:00.3)) vs. 00200000 (pcie_mp2_amd)

QEMU reports:

  vfio 0000:e6:00.3: Failed to set up TRIGGER eventfd signaling for
  interrupt INTX-0: VFIO_DEVICE_SET_IRQS failure: Device or resource busy

With this change, the passthrough is successful through VFIO
on the same host.

Fixes: 7f016b35ca76 ("HID: amd_sfh: Add interrupt handler to process interrupts")
Cc: stable@vger.kernel.org
Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_common.h |  6 +++---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   | 18 ++++++++++++------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index e8cc7f1d289cc..4481a50359de6 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -85,7 +85,7 @@ struct amd_mp2_ops {
 	void (*stop)(struct amd_mp2_dev *privdata, u16 sensor_idx);
 	void (*stop_all)(struct amd_mp2_dev *privdata);
 	int (*response)(struct amd_mp2_dev *mp2, u8 sid, u32 sensor_sts);
-	void (*clear_intr)(struct amd_mp2_dev *privdata);
+	bool (*clear_intr)(struct amd_mp2_dev *privdata);
 	int (*init_intr)(struct amd_mp2_dev *privdata);
 	int (*discovery_status)(struct amd_mp2_dev *privdata);
 	void (*suspend)(struct amd_mp2_dev *mp2);
@@ -100,9 +100,9 @@ struct amd_mp2_ops {
 
 void amd_sfh_work(struct work_struct *work);
 void amd_sfh_work_buffer(struct work_struct *work);
-void amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata);
+bool amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata);
 int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata);
-void amd_sfh_clear_intr(struct amd_mp2_dev *privdata);
+bool amd_sfh_clear_intr(struct amd_mp2_dev *privdata);
 int amd_sfh_irq_init(struct amd_mp2_dev *privdata);
 
 static inline u64 amd_get_c2p_val(struct amd_mp2_dev *mp2, u32 idx)
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index b3cb13b8c5e87..f48a096a6d2bc 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -103,25 +103,31 @@ static void amd_stop_all_sensor_v2(struct amd_mp2_dev *privdata)
 	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
 }
 
-void amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata)
+bool amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata)
 {
 	if (readl(privdata->mmio + amd_get_p2c_val(privdata, 4))) {
 		writel(0, privdata->mmio + amd_get_p2c_val(privdata, 4));
 		writel(0xf, privdata->mmio + amd_get_p2c_val(privdata, 5));
+		return true;
 	}
+
+	return false;
 }
 
-void amd_sfh_clear_intr(struct amd_mp2_dev *privdata)
+bool amd_sfh_clear_intr(struct amd_mp2_dev *privdata)
 {
 	if (privdata->mp2_ops->clear_intr)
-		privdata->mp2_ops->clear_intr(privdata);
+		return privdata->mp2_ops->clear_intr(privdata);
+
+	return false;
 }
 
 static irqreturn_t amd_sfh_irq_handler(int irq, void *data)
 {
-	amd_sfh_clear_intr(data);
+	if (amd_sfh_clear_intr(data))
+		return IRQ_HANDLED;
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
@@ -129,7 +135,7 @@ int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
 	pcim_intx(privdata->pdev, true);
 
 	return devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
-				amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);
+				amd_sfh_irq_handler, IRQF_SHARED, DRIVER_NAME, privdata);
 }
 
 static int amd_sfh_dis_sts_v2(struct amd_mp2_dev *privdata)

base-commit: 2c2fe95ab19b09bef7391e3e5cdf8146d09792b6
-- 
2.55.0

