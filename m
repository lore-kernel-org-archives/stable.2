Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF9413254
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599914; cv=none; b=ZfczTAoRKWfL3oXJ1VXfpJ6jyiJU99fqza1HD/IE/7ixvjFp/T3CBqhCNUtpLLh7CzRSvGHgnd9Ki0BKoWARuaNaoucHI+pIdYhCZigOVWPeoiAS4kZQba2xQWBwOCmbnItFJt/7GbQkOgiOpcQDPjb0ep7uIvk+PGTnbgTGbyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599914; c=relaxed/simple;
	bh=y9cAnsHqNIYb0P++QnO5XIYO7nF4SS978HjjVVaE8xE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nDFfADJWMBW1w9tiCHfu/nEde9GcJsJjtsHdc8NAuAf1DBH0vOMV3Xhp5l4I9bux7AaqWyOxhACZler/E3zglloeChGofYQGfr95eAmDiXE20OsxSsvPfG4+E7fC+AjCL2nivvupEx7hEPod7zYeHe2nOXSVY5bkn6XlZQ2iUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9q6o9zt; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9q6o9zt"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b015b2d792so951296e87.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 05:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783599911; x=1784204711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vu/X/SkKCf8BDgHCKFoN7Pak7eOCPEtAIjSdYOyjR7k=;
        b=L9q6o9ztCekmPSt8fmsF9PoiTQPD5RVZXoKzbNRaDc6VENSNqt22iJojfsvxQRoYsV
         2M8RmBSWbvXQG0ObRiG2wovGENL67NqRI+PpjW7ggOJWFEFGQS4fFcCjP6F2/ZJI7Bp2
         3dolaU2g/kZU+RRieN4/8IqbPgF75JRqP0KGQsKuOmicu35WNG6wdnL2NL8UBHiOVWqb
         0FP+NFAheqNpGGxd0sF7fCBDbD2W+lJ/DSF0uISK9bii+dHaiKZzcAFj/OL1Zkj49F7m
         u6DfEE3KbVd2HOamYD7H6XJsJcrKJ648fptuJpBw44B4mD04OnqA7ZtfYgaNJGou+IQq
         P7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783599911; x=1784204711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vu/X/SkKCf8BDgHCKFoN7Pak7eOCPEtAIjSdYOyjR7k=;
        b=ETLtlJ+l5FRalss8YmsQAeRLC1Fd2nep1c5ed+DLPJXV9cR+3VFhhlSxFLcH4azdnL
         9nY1BoUkKi4ORmWPygyd5+Hz1zLoyR7bIYGhxho3s2MkDiaDdo8IWH/d4x0y8dMQ/37O
         CMriwkAwP6fs70FdvLPfbLbh/vTpw5XomwTZ4Qu729ZwpPFFyoEpFKJixzdRNHKnjJqE
         y9uTNYhDFutHlIuBDMPsMdCyrmr0JPqgSlZHBwrGMZCHIJaaoqMGiQTsSO6qRepSxise
         /5Yrdl0UmDuCo7s1dZqUj5QZY3Hh+AjgH8qnKXAP6pr4g2O+vpibh+sYItMu9EP4SaWj
         pMBg==
X-Forwarded-Encrypted: i=1; AHgh+RqcrZ5+a1w8TVCv8HAhdZ68KhiE2QYDP7KjF6K2CXJ2JNMii8cZoKOuD42HV+JCu+IA0CYfyaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/YAMqzkoZSAXWABS3e8YhaiecAKm9j1PnBrgF1WOjc348cov
	LZ9at4EWNIgr8t9oEBcHyNXzCeCwj4DF4ahWI6nuPtSQCVmEJxhvIiFL
X-Gm-Gg: AfdE7cnzR1yXl80NZN5Wi9mVpM/fThQve2I/Xxccm4dNQ06g6aIW2ymmeLeqyc+r2M/
	AdTSlGyon3NALLIZo5ND60MlmwPUTO83n6Mjw1NydMPpDBqN/fko8QO/GXyynMCKi1lkJVs6p33
	qcOgyAc0qpTD7OoI3oJnFLM9ivFL04YPV16R8iweRkGfr67BJvimiCWqSHUnimF4yMQxhWMENRd
	cl5OWXkckwecJsYMLxgPYR/2Sf73qsAmJRfHz+M5wYDW8LgjlWf9BdDEfQnGR6tHm/M8LScKX4v
	+ZiDRl0lFRQl4P5dlGozTHZkFxvYSNE9f3jVb+yo9C97JcQbzGGcxODFioWKqkntv1QMoiFGdkO
	v6IuGVFc4QVQNVMpH0pNH0wH5XP3oabIY+fvw7Kh32cZ7TVu2UHp1U4Vgk6lO7X2YTSBMBkBRAN
	x9KwmCPckeVPC4zBBzmc8XDEGbKTV6SE/B3BsEjizUorwPMfJZBcqQGbxha4p/C6kBgzJzJ7kE
X-Received: by 2002:a05:6512:2c93:b0:5b0:197b:9829 with SMTP id 2adb3069b0e04-5b0197b99b7mr332166e87.41.1783599910888;
        Thu, 09 Jul 2026 05:25:10 -0700 (PDT)
Received: from maverickamd.dyn.int.numascale.com (fwa5d93-21.bb.online.no. [88.93.147.21])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5aed13c3bf2sm5277697e87.69.2026.07.09.05.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:25:10 -0700 (PDT)
From: Steffen Persvold <spersvold@gmail.com>
To: Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Steffen Persvold <spersvold@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: host-generic: Fix NULL pointer dereference on 32-bit CAM systems
Date: Thu,  9 Jul 2026 14:24:46 +0200
Message-Id: <20260709122446.3151899-1-spersvold@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 32-bit systems the config space is too large to ioremap in one go, so
pci_ecam_create() maps each bus segment separately and relies on the
->add_bus callback (pci_ecam_add_bus) to populate the per-bus mapping in
cfg->winp[]. pci_ecam_map_bus() then uses that mapping as the base for
every config access.

The generic ECAM ops (pci_generic_ecam_ops) already provide the ->add_bus
and ->remove_bus callbacks, but the CAM (legacy) ops in pci-host-generic.c
do not. As a result, on a 32-bit host using "pci-host-cam-generic" the
per-bus mapping is never set up and the first config read dereferences a
NULL base, crashing during bus enumeration:

[    1.430647] Unable to handle kernel NULL pointer dereference at virtual address 00000800
[    1.439441] Oops [#1]
[    1.442152] CPU: 0 PID: 1 Comm: swapper Not tainted 6.9.7+ #43
[    1.448753] Hardware name: Digilent Nexys-Video-A7 RV32 (DT)
[    1.454968] epc : pci_generic_config_read+0x40/0xb0
[    1.460652]  ra : pci_generic_config_read+0x2c/0xb0
[    1.534729] [<c038db9c>] pci_generic_config_read+0x40/0xb0
[    1.541096] [<c038da04>] pci_bus_read_config_dword+0x50/0xb0
[    1.547623] [<c0391e94>] pci_bus_generic_read_dev_vendor_id+0x3c/0x1ec
[    1.555010] [<c039245c>] pci_scan_single_device+0xa4/0x11c
[    1.561273] [<c0392570>] pci_scan_slot+0x9c/0x23c
[    1.566716] [<c039388c>] pci_scan_child_bus_extend+0x58/0x2f4
[    1.573275] [<c0393db0>] pci_scan_root_bus_bridge+0x64/0xe8
[    1.579650] [<c0393e54>] pci_host_probe+0x20/0xc8
[    1.591396] [<c03bc6f4>] pci_host_common_probe+0x144/0x1e4

Fix this by giving the CAM ops the same ->add_bus/->remove_bus callbacks.
Since pci_ecam_add_bus() and pci_ecam_remove_bus() are static to ecam.c,
move the CAM ops definition there as pci_generic_cam_ops (mirroring
pci_generic_ecam_ops) and export it for pci-host-generic.c to reference.

Fixes: 8fe55ef23387 ("PCI: Dynamically map ECAM regions")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Persvold <spersvold@gmail.com>
---
 drivers/pci/controller/pci-host-generic.c | 11 +----------
 drivers/pci/ecam.c                        | 13 +++++++++++++
 include/linux/pci-ecam.h                  |  3 +++
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index c1bc0d34..9e85c6e9 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -16,15 +16,6 @@
 
 #include "pci-host-common.h"
 
-static const struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
-	.bus_shift	= 16,
-	.pci_ops	= {
-		.map_bus	= pci_ecam_map_bus,
-		.read		= pci_generic_config_read,
-		.write		= pci_generic_config_write,
-	}
-};
-
 static bool pci_dw_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
 	struct pci_config_window *cfg = bus->sysdata;
@@ -60,7 +51,7 @@ static const struct pci_ecam_ops pci_dw_ecam_bus_ops = {
 
 static const struct of_device_id gen_pci_of_match[] = {
 	{ .compatible = "pci-host-cam-generic",
-	  .data = &gen_pci_cfg_cam_bus_ops },
+	  .data = &pci_generic_cam_ops },
 
 	{ .compatible = "pci-host-ecam-generic",
 	  .data = &pci_generic_ecam_ops },
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 119de32f..a9b3bce2 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -208,6 +208,19 @@ const struct pci_ecam_ops pci_generic_ecam_ops = {
 };
 EXPORT_SYMBOL_GPL(pci_generic_ecam_ops);
 
+/* CAM ops */
+const struct pci_ecam_ops pci_generic_cam_ops = {
+	.bus_shift	= 16,
+	.pci_ops	= {
+		.add_bus	= pci_ecam_add_bus,
+		.remove_bus	= pci_ecam_remove_bus,
+		.map_bus	= pci_ecam_map_bus,
+		.read		= pci_generic_config_read,
+		.write		= pci_generic_config_write,
+	}
+};
+EXPORT_SYMBOL_GPL(pci_generic_cam_ops);
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 /* ECAM ops for 32-bit access only (non-compliant) */
 const struct pci_ecam_ops pci_32b_ops = {
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index d9306514..044f67ce 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -81,6 +81,9 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 /* default ECAM ops */
 extern const struct pci_ecam_ops pci_generic_ecam_ops;
 
+/* default CAM ops */
+extern const struct pci_ecam_ops pci_generic_cam_ops;
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 extern const struct pci_ecam_ops pci_32b_ops;	/* 32-bit accesses only */
 extern const struct pci_ecam_ops pci_32b_read_ops; /* 32-bit read only */

base-commit: 53bf92818a8362815708fc7b18e6d2c6a5fc665b
-- 
2.40.1

