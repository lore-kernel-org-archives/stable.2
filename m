Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B05388E5A
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790450703; cv=none; b=pHLSQtdBrroKse3bVmjf13mZV9yvl4GmAfzKVdE8z6LyXt1XgaHBKv9luLeOQ1ivwADzTHqBhByiSLoUl+pAudKhiDt033xWTeUsq07Wbd6Mee3EDarvS4EV8niTnjwPlMTG0Rh6YhrchQTCYppSYgGpDwXjJyFatTUwNmMXKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790450703; c=relaxed/simple;
	bh=oCFJ8eagL1YdjxsPUSetCl7HDigF8OCJNgKYHZIE3B0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhrLc3h4YR8oyw5fZPmKS1bAEIBG7VmqJXi3CQF9WYZKlrf82mPflQsaklQd8hAY925IX0dhyl3OGIQ409Obo0wkAbYhj1JmuXR9fnRNEusOzibLTagzzDYmVPdduxevuU1WGEvmDU+gf3oGQYplY+/MrMSuVPZowUrrrzGv31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=TpdUp71e; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="TpdUp71e"
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8F58C3F4CC
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1790450697;
	bh=aAoDWVuRpxNlTIg9DRKgevYj0ImdfdGD3NJ5Lik81No=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=TpdUp71eKEG/ywXMeLpBTOgcv1iaMO8MoiwvOZ5s0zvInPq7Hgsd1cWNJPqgryobH
	 6f6Y5XwsHdHSQhKhuLVVcTptQxUfL8S9HgKljlNXYlYUUCb9IiFdXe3Pv0gGMV4wqN
	 DJbMg/cMkeiRyURVQeTCCs5Gir1YynueCzA8ZBvib6HK9UZonlEp/fIZUvV39hRUu1
	 hetZ8AR6LBkDDF3vAft4JZeYFKOjZxH6sWXtCYXRWNoDT44v94vS9MKA1U7HiXeloA
	 Z+Lt3C9gER45hIFIazu7iC8v+wXGC5+e4I8rAcWvjHNl42j9LGcxXs4JbcnOmz9Fk3
	 ONY6r2Fnt1qc4EB0bDOVu9JzgCkBy+ZuKH40DtLNTGMCeEj3J5kz+KGpEXph7SaIzi
	 fbGePWZghQteKIP0yd+qzOX+BYVfaRnC7f6T6R1q9stfZvcJT0ZCt2Tu81bbKd9xe0
	 hPB9a9HdMnZ0EkeTRN4snurm1oBYuUIPWyu9JDSZGZOSHy73br637NmpxLY4ZbZ0Xb
	 VuAWmj+k4E/pluW+5PjpJCiUH6AhVDeZsWcLS0Fvz0sO2AkBxnIVE4pBSry+OMFshX
	 YLNuY1JYE/a/N3zeR5QBNwoBxCE8F7uANugDrEomFURxnlcf1TLH277v3tIhPDKpGM
	 LM4yLMCa00B2MOeXnGWLCqAo=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49ffdac5e6dso2428815e9.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 12:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790450697; x=1791055497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aAoDWVuRpxNlTIg9DRKgevYj0ImdfdGD3NJ5Lik81No=;
        b=bDolQO0yeJB6HxAbvkQy88COj/dta9bL+hWCneB3gLLKZEYhHlZij2/fqZnU4qgLjw
         rxLe0P9svG/wN6I1m8cHVlhkpRvS0Pp/usqSFeQ+SkQOS/qMjAuVEiwbzXBCdou0SsK1
         f/boUa5wfk7E3FTtIaLUeLin9Y3kg2oAFwJULBIipLTQLGok+hf+EOF31VEPrMG5dfjD
         8CdrVH2ZhCbBgP7RBRljVRvBEBY+U7Od160R8yv/iABCP6ij4dt4tGVM+UfxBvDrM+Db
         da43Ow7n9BYv8tLPpsBNWKULZgtu7hIC2JcGyMfVfWCHRmqH2UewdGK5wJcaKzMFgT+G
         k3YQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEyY6m4gAggqBgGfywblgx7BlklZQDK2Uy81iBrJ55xKhOJH+ydS1/03iv8acA6MIASwECEjc=@vger.kernel.org
X-Gm-Message-State: AFuF++nXASR24m354oxtwFcL862kNBUtJvn4x8ILpculIxrn7HTMieDN
	lUzRlDyfMHCKkFqmQhjJAW4q6x3SydBOR2U+2tRVBRuUhciCbLwujt6AsHuk5uitFH9mm/L68Qf
	DUm5bGFA8kByCg8xY2pbevG22JacJWg2jTv4WuZoI4ZdELYMPhTIl3m+L5/Igsn4QZMOmtzeYoA
	==
X-Gm-Gg: AYBFou1HqoOSAzw19ds6I9RobBU8WJZexejvvvVmm/m3gF/z9U/n5UACCDJQbUBhQdI
	xsY0pBO6jTi06F3NQNbDHNYEvxAG+oZ7Nx7EoGYBJlF6WbB4s2h2TxzLyX1NINUG+MnS0NAeF7P
	/lVnRLYpzwPdRp61cGdSe4RNMwexmzq9r9byUmJCIp1dXe7mJ9wZffYOlEanloLIK1DU4s2No4p
	h3RfDTZDZywdCo44Y9R87TfsIbgSUSGHqrQx9h8J4gHJ9aLX1idp/J3sP4YPW3D8btsaVCTMFKC
	DzCDsnymW6W1wBzaYlKxMVu8LM2UeflTRv9OIvDzA87SAQ2dzF+ZOlkv4cP5MUU9J6/XwoRSUsU
	DOP/kP0IEk9hJfUljsqUGBjFWy3vvEekU2Q==
X-Received: by 2002:a05:600c:1d0d:b0:49c:f4e1:4c2d with SMTP id 5b1f17b1804b1-49fe66f144fmr165830535e9.16.1790450697039;
        Sat, 26 Sep 2026 12:24:57 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0d:b0:49c:f4e1:4c2d with SMTP id 5b1f17b1804b1-49fe66f144fmr165830285e9.16.1790450696753;
        Sat, 26 Sep 2026 12:24:56 -0700 (PDT)
Received: from k6.lan (141.175.65.37.rev.sfr.net. [37.65.175.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff21cc844sm59706145e9.3.2026.09.26.12.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:24:56 -0700 (PDT)
From: Valentin Haudiquet <valentin.haudiquet@canonical.com>
To: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Valentin Haudiquet <valentin.haudiquet@canonical.com>,
	Jian Hui Lee <jianhui.lee@canonical.com>,
	stable@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] memory: mtk-smi: fail larb runtime resume until component bind
Date: Sat, 26 Sep 2026 21:24:17 +0200
Message-ID: <20260926192417.1448813-1-valentin.haudiquet@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the mtk-smi and mtk-iommu drivers built as modules, a consumer
device probe (e.g. mediatek-drm on MT8183) can race the iommu's
component master bind.  The consumer's probe path runtime-resumes its
smi-larb suppliers, and the larb's runtime resume then runs
mtk_smi_larb_config_port_gen2_general(), which dereferences
larb->mmu and larb->bank.  Those pointers are only populated by
mtk_smi_larb_bind() when the component master completes, so a larb
resumed inside the window dereferences NULL and oopses in the module
loader's initcall context.  The module loader is then stuck and the
rest of the boot dies.  On MT8183 (krane), mediatek-drm module init
hits this:

  Internal error: Oops: 0000000096000004 [#1] SMP
  CPU: 4 UID: 0 PID: 270 Comm: (udev-worker) Tainted: G W
  pc : mtk_smi_larb_config_port_gen2_general+0xe0/0x660 [mtk_smi]
  lr : mtk_smi_larb_resume+0xb8/0x1b8 [mtk_smi]
  Call trace:
   mtk_smi_larb_config_port_gen2_general+0xe0/0x660 [mtk_smi] (P)
   mtk_smi_larb_resume+0xb8/0x1b8 [mtk_smi]
   pm_generic_runtime_resume+0x38/0x80
   genpd_runtime_resume+0x118/0x320
   rpm_callback+0x8c/0xc8
   rpm_resume+0x558/0x758
   __pm_runtime_resume+0x64/0xd8
   pm_runtime_get_suppliers+0x6c/0xb8
   __driver_probe_device+0x68/0x230
   driver_probe_device+0xdc/0x1b0
   __driver_attach+0x10c/0x2c8
   bus_add_driver+0x17c/0x2e0
   __platform_register_drivers+0x7c/0x1c0
   mtk_drm_init+0x38/0xfd0 [mediatek_drm]
   do_one_initcall+0x60/0x4e0
   do_init_module+0xa0/0x308
   init_module_from_file+0x10c/0x180
   idempotent_init_module+0x1f8/0x2f0
   __arm64_sys_finit_module+0x74/0x120

The oopsing udev worker exits holding the module loader's locks, so
every later module load soft-locks and the boot dies in the initrd.
The same oops was reported on MT8188 (Genio 700 EVK) from mtk_mdp3
module init.

Publish the bind state with smp_store_release() and check it with
smp_load_acquire() in mtk_smi_larb_resume(); that answers how the
check synchronizes between CPUs.  Fail the resume with -EAGAIN: the
larb stays RPM_SUSPENDED and retryable, the error is dropped by
pm_runtime_get_suppliers() on the driver-core probe path, and the
consumer's first runtime resume after the bind (at display enable,
mtk_crtc_atomic_enable()) re-runs the callback, which configures the
larb ports then.  Failing rather than skipping keeps the larb
suspended instead of marking it active with unconfigured MMU ports,
which would only turn the crash into silent iommu faults.

A failed supplier resume does not break the consumer's probe.
pm_runtime_get_suppliers() is void and drops the error, so a probe
inside the window just proceeds.  The display components do not touch
the larb in probe: mtk_disp_ovl_probe() and its siblings only call
pm_runtime_enable(), and mdp3 only enables runtime PM for its
DMA-capable components (mtk-mdp3-comp.c).  The first real runtime
resume happens later, at display enable: mtk_crtc_atomic_enable()
does pm_runtime_resume_and_get() and the device links resume the
larb first.  By then the component master bind has completed, so the
larb configures its ports and the resume succeeds.  There is no
deadlock either: the bind only records the larb pointers, it does not
resume the larb, so the window closes when the bind completes
regardless of what consumers do.  -ENODEV is not an alternative;
like -EPROBE_DEFER it is recorded in dev->power.runtime_error
instead of being exempted.

The bind state is a separate flag rather than a NULL test on
larb->mmu so that the publication explicitly covers both larb->mmu
and larb->bank.  mtk_smi_larb_unbind() clears it again with
WRITE_ONCE(), which is all the clear side needs since it publishes
nothing, so an iommu removal or module unload can not leave a stale
bound state pointing at the freed iommu data.  A resume in flight
while the iommu goes away is a pre-existing teardown hazard (the
data it reads belongs to the iommu device, whose removal breaks
bound consumers anyway); clearing the flag makes every resume that
starts after the clear fail safely instead.

Tested on MT8183 (krane) with the full MTK stack built as modules:
with this change applied the machine boots reliably, the iommu
probes and binds all larbs, and the display stack comes up fully
functional.

The Fixes: tag points at 4f0a1a1ae351, which moved the port
configuration into the runtime resume.  The device links that open
the race window are added on the mtk-iommu side, but the dereference
guarded here is the one that commit introduced.

Fixes: 4f0a1a1ae351 ("memory: mtk-smi: Invoke pm runtime_callback to enable clocks")
Reported-by: Jian Hui Lee <jianhui.lee@canonical.com>
Closes: https://lore.kernel.org/linux-arm-kernel/20251111124853.2916889-1-jianhui.lee@canonical.com/
Cc: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yong Wu <yong.wu@mediatek.com>
Cc: Jian Hui Lee <jianhui.lee@canonical.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
---

A fix for this was posted by Jian Hui Lee in November 2025, but the
thread went quiet after review.  This revision is not from the
original poster: it is an independent rework of the same fix,
submitted because the same problem was hit on krane and the machine
needed a working kernel.

Changes in v2:
 - publish the bind state with smp_store_release()/smp_load_acquire()
   instead of a bare NULL check, answering the "how does this
   synchronize between CPUs" question from the v1 review
 - fail the resume with -EAGAIN instead of silently skipping the port
   configuration; the larb stays RPM_SUSPENDED and the retry is
   demand-driven (the consumer's next runtime resume, after the bind)
 - clear the flag in mtk_smi_larb_unbind() so an iommu removal can not
   leave a stale bound state pointing at the freed iommu data
 - quote the oops backtrace and add proper tags
 drivers/memory/mtk-smi.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index aaeba8ab2..dfc65b208 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -157,6 +157,7 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	int				larbid;
 	u32				*mmu;
 	unsigned char			*bank;
+	bool				bound; /* set once the iommu binds us */
 };
 
 static int
@@ -171,6 +172,11 @@ mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 			larb->larbid = i;
 			larb->mmu = &larb_mmu[i].mmu;
 			larb->bank = larb_mmu[i].bank;
+			/*
+			 * Publish larb->mmu and larb->bank; pairs with
+			 * smp_load_acquire() in mtk_smi_larb_resume().
+			 */
+			smp_store_release(&larb->bound, true);
 			return 0;
 		}
 	}
@@ -180,7 +186,13 @@ mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 static void
 mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
 {
-	/* Do nothing as the iommu is always enabled. */
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+
+	/*
+	 * The iommu data recorded at bind time is going away; make the
+	 * next runtime resume wait for a fresh bind.
+	 */
+	WRITE_ONCE(larb->bound, false);
 }
 
 static const struct component_ops mtk_smi_larb_component_ops = {
@@ -697,6 +709,19 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
 	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
 	int ret;
 
+	/*
+	 * With modular builds a consumer device probe can runtime-resume
+	 * the larb (pm_runtime_get_suppliers()) before the iommu's
+	 * component master bind has populated larb->mmu and larb->bank.
+	 * Fail the resume with -EAGAIN: the larb stays RPM_SUSPENDED and
+	 * retryable, and the next resume after the bind configures the
+	 * larb ports.
+	 */
+	if (!smp_load_acquire(&larb->bound)) {
+		dev_dbg(dev, "not yet bound to an iommu, skipping port configuration\n");
+		return -EAGAIN;
+	}
+
 	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb->smi.clks);
 	if (ret)
 		return ret;
base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

