Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937144;
	b=A6ld2oXRdbiPqOL90iueZzi5GPI2TM/yi82dl3JtMCHuWQvjohPcf9IU9HBBMcEhtE+t
	 M0O60tC0/bzGRAIl3dZHSiL6G4NCbr65TDdUetbMy34NDdqO02IZxMF8QrmkspX5zPuXZ
	 c6VtOsiVSSTZXk+mD0WB8khXSW6yq/H1S2azDEuJVPQGI5q9qUW/H2a91aAI2f5E/gQfn
	 sr8UdJxdflAxIeFC8SkhwMd4bdE84CPizczfDQb9NgoCjnSh4duaUsYnynbXGJHQ06WUk
	 mEAbIbP32doYwIePrJuct9sKcverZPeCSLeigueOQ8+jyNjKI6TwBb31MdJi1swBZ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6M57yKhoY3Idsde7aIN+UT8pB+NIBM6sX908TuhLKcI=;
	b=lc988PylKSfmu/oJQBqztJQxon09LuEPY5a91XsaVCi4QNs47pG6JBD5PNDGwZlWPhiC
	 1YvFCAbpLA1PgbPF5+GgZ3k+NSYsDX7YHY7U8a9/FjGJaaqhRj5tDI7mEnSnb1nGh7vmv
	 E/aGx6/ObGivkAQMbkb9N09BG0ucF0ldGjcLx8E9DfNZpUggVSpiNdhnUMWAOU08m3XUA
	 jZazmXQ9WWXY71/Hs63qc9hdYoSHjT340kGP5KlROmGbEocAsKaksc+YVICSs7SYf11sA
	 VYbuyrSWXFLD8oqi5A+Udn1IpRkfJ3HpuddyIZGEImhX/d9e3ekgO/rg16chmfASNZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=unSSAAxE;
	arc=none smtp.remote-ip=74.125.231.193
Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25903606A894
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25903606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=unSSAAxE
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-539d2baa897so1662681b6e.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937143; x=1795541943; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6M57yKhoY3Idsde7aIN+UT8pB+NIBM6sX908TuhLKcI=;
        b=unSSAAxERqfoOoboKgBEzpLaA16dBomXkSiCBJp51rj/PSK4U/eOOkYNc30RL2fMXB
         iu2KACeCcmc6p3hhGZaNZgB4/qF9qr5HwmZRm+FegnELhi2KWCCklKM091uGM2bnCn3W
         h3nkteQqs2eSr8LgAmJWEiK1TnuDOnlY3VDnzxBQzUMlUkeZtM6v3faSK2b2hVlNU+pg
         Q3Nu9W1nYYmPk2TIizqmevmE2vnY+aW1wCo4EwwHobeHXM7ELX7zyI8nPP7gTLzvZLnd
         Bm447+caDdOwHF7MX6iHXSIOWYrJdBsImYOajDQh5TkfflDbC6fgcpIPw2G1TVHQGL6d
         amtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937143; x=1795541943;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6M57yKhoY3Idsde7aIN+UT8pB+NIBM6sX908TuhLKcI=;
        b=KuwlWJ1k09oh+6NiZbkP6lBpLvUKM4lC/UGmhmtlppW4uzEW4WeQF7kHJkzYV94PQN
         d2KJJb7BQKpavHAqX3+TdYOfCMZWlpdQcfwPWZfjABDBV61izNfDF4CwRCjLTTFEjnf1
         aBpcBBdYTfuCUtzgDZna90ZOQVo2at5N2S2AVMbxF00jcf1xy0tc5Y4c9s36B1KFuoOm
         hr2oghObxvqHTQ0oEHsECtIryr26uHOgoT6E6AoX8sbHH1G6BDTr7TCN4cUvluxtCaTZ
         Ck74E4a2R+PVk14M/15HqkvSj8ctydVXSCAAX954g7RBbK+thyfU9fEFLuKSAg3GpE3Q
         PbYg==
X-Forwarded-Encrypted: i=1; AL+hErHbkmJF7PNynaavnurpz94DaDX1ye43k+myl7x13yArDQVKARRfTLZk/HF6zwWmI9Bu5TsOLEw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gfgSEDpjBksxykYVF4Bi5R3bGg0o3ZOziZ+gqsmwElgm0kqUu
	bxEh22i3EeSeimfPZhOW15KV47P+d0C9gwefEXPnO8600Mfjf8hQ8V1O
X-Gm-Gg: AYBFou25Gm3Js2H25y1bHgxKJXbtCSGQGgpq7Iw1VYZNLcNfD05F61O0DENDvEEchpB
	mESojl2lfvvDoIAM+qP23DY9u9xuBrQEFWAXVtWDV85cyV0V2mQKE1nqEXH40Lc/3lXmtKUUvtV
	6c50RM4GXoEE/gpOGZW0cFDeJ55ozRRjfRqCtMfS21Rq97PzJC2eM7C91j9n6VcDOPwQpTcb/5A
	DpkJnKWFnAMSQhTdIgtLF6XI8bpb9blyhmZoaTfkq31LmcQ1Y05UwrpiRaG5tWOY0sFfOjV7Oh9
	iV+xN1eHmcPnXbN137yVFnmBZbEXjD8tRF0/hk6LfJGLvVktSKCTO4UF+cLIsNtNgBzJ3rUdsd0
	P891teSmo0t4dAZTeiEhBZLRyMtTZfcAH5cSVo5tqm3IbsUYfr2hAl7Hr8gv5EOlwNyO50LSv8i
	+2WPGO9ktBuV+iuFONmaNDVU4atuXf3/ZflNjjrtwRwjOEJji6giYTCVNoLsczgQgB96GRjCDIe
	xRJ/MCkJ5sr44TCz03dubS9ryonr5UL2jPASKbTEEtK2xyb+RC5SzvZXMyYm+qPU9br2YjsTOrx
	q4iAl+dXfNKftmh00HlHiIHJ
X-Received: by 2002:a05:6808:14c1:b0:571:3ee4:9a63 with SMTP id 5614622812f47-5773d82f896mr452946b6e.52.1794937142940;
        Tue, 17 Nov 2026 09:39:02 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::d500])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-572e87c152bsm8185329b6e.2.2026.11.17.09.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:39:01 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 17 Nov 2026 11:38:55 -0600
Subject: [PATCH v2] drm/imagination: Wait for the firmware's interrupts
 before stopping it
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
Message-Id: <20261117-rbrue-suez-upstreaming-pvr-fw-irq-handshake-v2-1-780e31f25220@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/5XNSw6CMBAA0Ks0s2ZMi4jIynsYFoUOMFE+TqF+C
 Hc34gncvs1bwJMwecjVAkKBPQ895CqOFFSt7RtCdpAriHWcGq0TlFJmQj/TG+fRT0K2477BMQj
 WD2S5Y2t751t7JSwzfTrsqTzppIRIwShU83PbLkWkoGU/DfLa8mC++nuM0X89waDBLDvGaZY6k
 zh9bjrLt101dFCs6/oBQXWM4eYAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794937139; l=6678;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=0tFJSc1IT+Of15L5cMPlnjMt1GWB/FzbloTs+FUqArI=;
 b=gbRkDO0IzdEtHQdqSrOtbMROgheVI7IodWc11ZSxjoBrIip6/C4MGaVGjXEi1r1GB9gsQBhPU
 nmVodgMLVdYAlyyhxlQomwcEgx33Jne+1q9d4Kg4Ii9jh1SncHN9xiv
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
count every time the host clears the firmware interrupt, and before
disabling the IRQ for a runtime suspend, wait until the host has seen
every interrupt the firmware counted, as Imagination's DDK does.
Sampling in pvr_fw_irq_clear() rather than in the IRQ thread also
covers the clears at probe and in a reset, whose interrupts never reach
the thread, and picks up the zeroed counts after a hard reset.

Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
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

The reset paths were tested with a debug build that triggers a soft
reset and can drop one count before the reset's clear. With v1's
sampling, the next runtime suspend then waited the full second and
warned, twice out of two; with v2 it didn't. A hard reset of this GPU
times out and loses it, so the hard-reset path is still untested at
runtime.

It reproduces within a minute with vkcube --present_mode 1 on the
compositor's display and the GPU's power/autosuspend_delay_ms set to 1.
---
This patch was developed with the help of an LLM. I know there's a Mesa
policy against LLM use for the powervr driver there, so if there's a policy
for drm/imagination too, let me know.
---
Changes in v2:
- Sample the firmware's interrupt counts in pvr_fw_irq_clear() rather
  than in the IRQ thread, so that the clears at probe and in
  pvr_power_reset() update the host's copy too (Sashiko). This replaces
  the zeroing in fw_osdata_init(): after a hard reset, the reset path's
  clear samples the zeroed counts.
- Fixes: cc1aeedb98ad, which put pvr_fw_stop() into the runtime suspend
  path; at 727538a4bbff it only gated the clocks (Sashiko).
- Rebased on drm-misc-next.
- Link to v1: https://lore.kernel.org/r/20261110-rbrue-suez-upstreaming-pvr-fw-irq-handshake-v1-1-8872686d14d0@gmail.com
---
With continuous rendering and a 1 ms autosuspend delay, a suspend failed
this way within 22 seconds in 7 of 7 unpatched runs. Three of them were
instrumented: between them they made 2711 suspends, and the three that
failed were the only ones with an interrupt still outstanding after
disable_irq(). With this patch, 8 of 8 runs lasted 60 seconds without a
failure, and in a further run the wait was needed in 15 of 6925
suspends, for at most 6.1 ms.
---
 drivers/gpu/drm/imagination/pvr_device.h | 15 +++++++++++++++
 drivers/gpu/drm/imagination/pvr_power.c  | 27 +++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index c246122b4caf..9d46c41140b7 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -176,6 +176,12 @@ struct pvr_device {
 	/** @irq: IRQ number. */
 	int irq;
 
+	/**
+	 * @fw_irq_count: Firmware interrupt counts, as last sampled after
+	 *                clearing the interrupt.
+	 */
+	u32 fw_irq_count[MAX_THREAD_NUM];
+
 	/** @fwccb: Firmware CCB. */
 	struct pvr_ccb fwccb;
 
@@ -813,6 +819,15 @@ static __always_inline void
 pvr_fw_irq_clear(struct pvr_device *pvr_dev)
 {
 	pvr_dev->fw_dev.defs->irq_clear(pvr_dev);
+
+	/* A cleared interrupt counts as taken, whoever cleared it. */
+	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
+		struct rogue_fwif_osdata *osdata = pvr_dev->fw_dev.fwif_osdata;
+
+		for (u32 i = 0; i < MAX_THREAD_NUM; i++)
+			WRITE_ONCE(pvr_dev->fw_irq_count[i],
+				   READ_ONCE(osdata->interrupt_count[i]));
+	}
 }
 
 #endif /* PVR_DEVICE_H */
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
base-commit: 41b5458595c60143d0ebaa1e032c9cda5d764dff
change-id: 20261004-rbrue-suez-upstreaming-pvr-fw-irq-handshake-b80953eb904b

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

