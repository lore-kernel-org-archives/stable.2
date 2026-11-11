Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361020;
	b=fnAaLSvbWBuUt+M71l2foyxp6WkAEM/6zjXUivRqsIvIxRYV81hhHz4pGBLoVIPjhBWy
	 73NM4EleKDLDBCJfL1Fs3fZ4oV0sBnD05cNjWfIZn4KMaysFmix3YH4553pZnnQrBhuRl
	 WNXV52zTPOfBkpE1NsRkn2zJJcYFs+NVjIZOK4bpF1rGf+I9c3bOmM64ImnDc//FbSZCB
	 DXHsEADEcChLklvbsfujHe5Ftgsf++SmhZ/l+8vsFnj2ApDvWAMJ3XB30tL9Vex8LqFLj
	 1eBsvZ9VI1vTYPjoyq2rpR7a+8T/BBSg2WFW6k7i72TvygZYSgzX1AYCsSGL2TBgYhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=fmd8pZhTX1jp07WLrA39wwhl3cP5kgTKffdM12tuCUI=;
	b=FAF+RHRntWEmn56ANRAw/Ba+BnT8OQqYmW+TV8xZpPddNFSm1cITH6SBEoNE1mizp0NU
	 A2X8g+Z9+IIF6sNf9A/N7O1BfqKE5aeYhxKsxPJJsRg8tng/rC7xRB9IgaTQqtWoUhU0k
	 45+I6rLDcATQXRf+eYDrT+kmoQq6+MVLiPr9O2rL86c0I2Hg2ph7p4DoFsNJ0o2Jz1y5R
	 GtfiwhOAx0dHXOC28Jo7LCFOFi8pRvdD85QTN1uKRsUewWph1ZwS/rDyewW8iW5zwgP2L
	 85osjOPaFnhDf6WZ0ZHx36MOgddEbclCuZAbRpKjxfRKCsADxswZmeLzSalDLDdbTJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLxMka16;
	arc=none smtp.remote-ip=74.125.231.136
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DA606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 371DA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLxMka16
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-71709d85f83so944942eaf.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794361018; x=1794965818; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fmd8pZhTX1jp07WLrA39wwhl3cP5kgTKffdM12tuCUI=;
        b=hLxMka16eVXreCfIEvee7CMN/TrWw4EFupfQ4Z1ifyiofqBJw53rkoHg8s5j28eql4
         LKifHe3ZAwC1Vv3vCAWjG4uLGzsI05wVv37rHfPCH0bh/VdgfPAoiz2oaQB6d5efd0Ss
         myI9fSB+g3Q7mezC2Ht2sSS4kCZetMBFd1iKEUYoK1bgkzUZip+rc7C/dNdFNyTvQ3Zl
         O7zZOdBaaDk+UsDX6Yb4HA4kFC4FE5G2iHPDPo4ETP+X6NVFBiDw1lDiPBdYVPEphZ76
         q1VpV2jA7wyH1mv0XvRRWf0rohxvuQ5Qt8aGQ0/gUjRK1ESwzOtOaNPGmhYnkaKN3E5h
         AGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794361018; x=1794965818;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fmd8pZhTX1jp07WLrA39wwhl3cP5kgTKffdM12tuCUI=;
        b=AgsIwVIfccGp/SivKXANqI5H2mkS6KhRsobdUERkA0WuCTMx8p5b619qOLN/Zmq3j0
         666TkKqfc9WBTsA7B49cGlPZ5TjhuQ3f3bcjXRMUTPbIqbA1ii+XoB7A892YZfS8kQQG
         NqakpySy585hOawbDiiXF3/bY6eY2b5aEIRFtjoEo21a/20XEsqGwLm2h4M8fNbsjPmO
         3EwII2fgnmi7xP9xmJaiNwl77/0F+5J30K9/lovVtGqcqopgcPI2M9ZqiSQ5thdPBbNv
         CKtQSvB4z3ouCz1oUNxQzw/dWKzC+C1HbLRNkyhrMKJuo+OhKNcs9NCL8gZLaB0g1/cc
         ppnQ==
X-Forwarded-Encrypted: i=1; AL+hErEsxIw+7Pp76e6YyG7ha71uPteveklY6Hs7/t0e7wFl4U/JeUJVOzepkiR5fLC6HrkZ4k7AMXs=@vger.kernel.org
X-Gm-Message-State: APuU4Z89OeCXpJf/yq55E9QKt93Kliz/yuyPz2ZPpCQoURkkZhBY7CY4
	gL9m9a6PCOeMyPrbcoOYawzJnRJYB+LdTVoHRj5LVrO5eKbV6wYAfYAY
X-Gm-Gg: AYBFou0UTyjEBLZr5AcIsc3watLiglTM0XyBY9iAQhNz43+a6iY41Uj0fLATqWSa1fy
	uro99q+wZ6bU+BbHpTfN8cVGSiapR5BQRjDpyDTDqy7yt5MDw3YHTpCjDI8Mt1vJShagh4jOzaI
	oirSLllUT+59GbVqo18Ww86HoWfLzUYs3kHlKMsTqeR0yLNof7UzuvgBgOd2KnFe8eCZ5TaYBnZ
	I3RT0ALZxVQQInSQMDZMjr4FmoqJW8MYPaEIbwZ8UloVbQ8yabGNpTHL2xuabyoruTuFx9MvnHD
	fkKnrkHhZU/+0aSkvsTR+vGmPW5cvr8JJNeGQ6aMwRYoNonOjSaLmkHS/yHJfwdzo55xdAnTUCq
	TR+Qs6JOKTsjU08rb69/1bT9VCqYNK1zawEonl69Puzin8YMTwtQEXMaA0KC6Q9gAmwP0/CFqzG
	Emng7ZxLw0K1Ot8qlkFojcNoEQeCFueqW9q36OTI6DPNMenxnkZhaolTe+euDhEbv9/XcRs0dkp
	U1StLINxKRG3DCFNoqI8UXuxwGAgMd//s/8lNue32XogO32lhISCwFS/qeTN7I/ns3WwsoUkImi
	pHlcbVRHmxgQKh8EJfPQg5El
X-Received: by 2002:a05:6820:c0d4:20b0:6d7:a325:35f7 with SMTP id 006d021491bc7-71917963ac3mr467673eaf.81.1794361017863;
        Tue, 10 Nov 2026 17:36:57 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22f6a1c7sm2462267fac.6.2026.11.10.17.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:36:57 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 10 Nov 2026 19:36:48 -0600
Subject: [PATCH] drm/imagination: Wait for the firmware's interrupts before
 stopping it
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-rbrue-suez-upstreaming-pvr-fw-irq-handshake-v1-1-8872686d14d0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3NUQ6CMAwA0Kss/aZJQTSyqxg+NimsMc7ZOjQS7
 m7iu8DbwFiFDbzbQHkVk0cG79rGwTWFvDDKBN5BR92pJepRo1ZGq/zFWuylHO6SFyyr4vxG0Se
 mkCdL4cYYzzQcDxwH6iM0DoryLJ//dhn3/QeQ1M4/fQAAAA==
X-Change-ID: 20261004-rbrue-suez-upstreaming-pvr-fw-irq-handshake-b80953eb904b
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sarah Walker <sarah.walker@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794361016; l=6676;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=UU+/DlUPZcdKbo5wZeicD1NjDIpa69zyRxMNYLyF5Rk=;
 b=iCYmXiI6nZQFvfT/rzhvhgqrx7Fg/JKpqoCaCXsfk5SCXdvphmefsouyNfMit0Ogz6jxhqSHu
 p2CYksSC3DUA4lVjalQ41zdZMeRelKO55wgvMDWkcmWujrBtnqCk+8T
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

Once the firmware has acknowledged the POW_OFF request, a runtime suspend
disables the IRQ and stops the firmware straight away, even if the
firmware has raised an interrupt the host has not taken yet. On an
MT8173 (GX6250, META firmware), the SIDEKICK_IDLE.GARTEN poll at the end
of pvr_fw_stop() can then time out. The suspend fails with -ETIMEDOUT,
runtime PM latches the error, and every later pvr_power_get() returns
-EINVAL. The recovery reset that follows can fail the same way and lose
the device.

The firmware counts the interrupts it raises in its OS data. Sample that
count in the IRQ thread after clearing the interrupt, and before
disabling the IRQ for a runtime suspend, wait until the host has seen
every interrupt the firmware counted, as Imagination's DDK does. Clear
the host's copy when a hard reset clears the firmware's.

Fixes: 727538a4bbff ("drm/imagination: Implement power management")
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Found on an Amazon Fire HD 10 (2017), an MT8173 tablet that's not upstream
yet. Its GX6250 (4.40.2.51) is not on the driver's list and runs with
exp_hw_support. With a compositor running, about one desktop start in five
hit this before the patch. A debug build that logs timed-out register polls
named the poll, SIDEKICK_IDLE read 0x7a, GARTEN not idle.

Only META firmware on this one GPU was tested. Each failing suspend in the
instrumented runs was off by exactly one interrupt (for example firmware
14320, host 14319). Why the META core then can't go idle is inferred from
the DDK, which waits at this point; a fixed 1s delay in the same place
also stopped the failures here.

The hard-reset part is untested at runtime. A forced hard reset of this GPU
times out before the firmware objects are cleared, so the stale copy it
guards against can't arise here.

It reproduces within a minute with vkcube --present_mode 1 on the
compositor's display and the GPU's power/autosuspend_delay_ms set to 1.
---
This patch was developed with the help of an LLM. I know there's a Mesa
policy against LLM use for the powervr driver there, so if there's a policy
for drm/imagination too, let me know.
---
With continuous rendering and a 1 ms autosuspend delay, a suspend failed
this way within 22 seconds in 7 of 7 unpatched runs. Three of them were
instrumented: between them they made 2711 suspends, and the three that
failed were the only ones with an interrupt still outstanding after
disable_irq(). With this patch, 8 of 8 runs lasted 60 seconds without a
failure, and in a further run the wait was needed in 15 of 6925
suspends, for at most 6.1 ms.
---
 drivers/gpu/drm/imagination/pvr_device.c |  6 ++++++
 drivers/gpu/drm/imagination/pvr_device.h |  6 ++++++
 drivers/gpu/drm/imagination/pvr_fw.c     |  3 +++
 drivers/gpu/drm/imagination/pvr_power.c  | 27 +++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 992509d95d28..99a3842c2783 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -215,6 +215,12 @@ static irqreturn_t pvr_device_irq_thread_handler(int irq, void *data)
 		pvr_fw_irq_clear(pvr_dev);
 
 		if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
+			struct rogue_fwif_osdata *osdata = pvr_dev->fw_dev.fwif_osdata;
+
+			for (u32 i = 0; i < MAX_THREAD_NUM; i++)
+				WRITE_ONCE(pvr_dev->fw_irq_count[i],
+					   READ_ONCE(osdata->interrupt_count[i]));
+
 			pvr_fwccb_process(pvr_dev);
 			pvr_kccb_wake_up_waiters(pvr_dev);
 			pvr_device_process_active_queues(pvr_dev);
diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index c246122b4caf..91cf2bde589f 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -176,6 +176,12 @@ struct pvr_device {
 	/** @irq: IRQ number. */
 	int irq;
 
+	/**
+	 * @fw_irq_count: Firmware interrupt counts, as last sampled by the IRQ
+	 *                thread after clearing the interrupt.
+	 */
+	u32 fw_irq_count[MAX_THREAD_NUM];
+
 	/** @fwccb: Firmware CCB. */
 	struct pvr_ccb fwccb;
 
diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index c7988278df3f..7b42a898aa00 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -315,6 +315,9 @@ fw_osdata_init(void *cpu_ptr, void *priv)
 	struct pvr_fw_mem *fw_mem = &pvr_dev->fw_dev.mem;
 
 	pvr_fw_object_get_fw_addr(fw_mem->power_sync_obj, &fwif_osdata->power_sync_fw_addr);
+
+	/* The firmware's interrupt counts restart from zero, and so must the host's copy. */
+	memset(pvr_dev->fw_irq_count, 0, sizeof(pvr_dev->fw_irq_count));
 }
 
 static void
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index eb4b6ecdf4f4..2d0fbcf457f6 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -89,6 +89,26 @@ pvr_power_request_pwr_off(struct pvr_device *pvr_dev)
 	return pvr_power_send_command(pvr_dev, &pow_cmd);
 }
 
+static bool
+pvr_power_fw_irqs_taken(struct pvr_device *pvr_dev, u32 thread)
+{
+	return READ_ONCE(pvr_dev->fw_dev.fwif_osdata->interrupt_count[thread]) ==
+	       READ_ONCE(pvr_dev->fw_irq_count[thread]);
+}
+
+static void
+pvr_power_wait_for_fw_irqs(struct pvr_device *pvr_dev)
+{
+	bool taken;
+
+	for (u32 i = 0; i < MAX_THREAD_NUM; i++) {
+		if (read_poll_timeout(pvr_power_fw_irqs_taken, taken, taken, 100,
+				      POWER_SYNC_TIMEOUT_US, false, pvr_dev, i))
+			drm_warn(from_pvr_device(pvr_dev),
+				 "FW thread %u has IRQs the host has not taken\n", i);
+	}
+}
+
 static int
 pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspend)
 {
@@ -107,6 +127,13 @@ pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspe
 	}
 
 	if (rpm_suspend) {
+		/*
+		 * Let the IRQ thread take every interrupt the firmware has raised
+		 * before stopping it, as the vendor driver does. Without this, the
+		 * META firmware processor can fail to go idle in pvr_fw_stop().
+		 */
+		pvr_power_wait_for_fw_irqs(pvr_dev);
+
 		/* This also waits for late processing of GPU or firmware IRQs in other cores */
 		disable_irq(pvr_dev->irq);
 	}

---
base-commit: 476d658928af91f5ccb455957be60763d8b00fd3
change-id: 20261004-rbrue-suez-upstreaming-pvr-fw-irq-handshake-b80953eb904b

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

