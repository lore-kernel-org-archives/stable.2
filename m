Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB836384223
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335944; cv=none; b=jLFzkxba9CAOXMLi4dWUgUjFxDnvR0xgIEoO91byxmRdEu7Q22KcSUHwV9AwmfEf6QwLkNyEen79LheeNWl8gvEQALCWbHMPIf4q2PsO4OFr5HcOVCEYJoLO1rhT34YQLFmbuCB9G9E7awKb2QELyLKu6K8yxHYhCRXTHVUvMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335944; c=relaxed/simple;
	bh=BoChgZVVkg0gnBLDsOrZTh2w5ju4zzorggWTcLKTTwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iiIdUvtNZaVB99JGwtJiRW6Vh5+NtqFXeT8ZKrES6ocgOaSvpjDWmXaKxOPvnzLSby6gq9cKLrAIUokwR+nJhFziumGfEHMgI+dsCbLvEt/OvHBKFVru3leQDkyUCLG3UIMf1z2JMQnXd1g7X1w5PLXLMR+d6CSAkmxECLjih/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Self8/Ba; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Self8/Ba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787335941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IcYpvMnU+f4BloPrmC94lFULP58QvHDNnxfJki4ZTvo=;
	b=Self8/BaSYlkw2zThcedB83tR3sAgTMf8lZ3y5PoENakVS/a0qbfhs5Myuwiwj89P5VE64
	bMhnRIHtaVa3AU/7MZS+oCaeIj0m/mUeIi6ZXyOXH3M+13ixKlol8BSHILWNtn9xKw//el
	qeIrcHdDPTd7TW6Vxw2UZpZseLbrEWk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-TPEhSOn1PcatEO2OR-pqVA-1; Fri,
 21 Aug 2026 14:12:18 -0400
X-MC-Unique: TPEhSOn1PcatEO2OR-pqVA-1
X-Mimecast-MFC-AGG-ID: TPEhSOn1PcatEO2OR-pqVA_1787335935
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 403A1195423A;
	Fri, 21 Aug 2026 18:12:15 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.80.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64CE61955F70;
	Fri, 21 Aug 2026 18:12:12 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Timur Tabi <ttabi@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Ryan Brue <ryanbrue.dev@gmail.com>,
	stable@vger.kernel.org,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH] pci: Add broken-GPE quirk for Lenovo Legion 16APH8 and 16AHP9 Nvidia GPUs
Date: Fri, 21 Aug 2026 14:11:59 -0400
Message-ID: <20260821181203.82722-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On the Lenovo Legion Slim 5 16APH8 and 16AHP9, the firmware appears to enjoy
firing a GPE on the parent PCIe port of the nvidia GPU very shortly after the
GPU enters D3Cold. This means that every time the GPU is runtime suspended,
ACPI firmware immediately wakes up its parent PCIe port, which then wakes up
the GPU. Once it falls asleep again, the cycle repeats.

See: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905

Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
nova as well, and it even seems possible for this to happen without any
driver loaded.

This seems to simply be a bug. Luckily, there is nothing that we actually
need ACPI wakeup events for on the GPU. Events such as display connector
hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
affected by this quirk.

Reported-by: Ryan Brue <ryanbrue.dev@gmail.com>
Co-authored-by: Ryan Brue <ryanbrue.dev@gmail.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Fixes: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
---
 drivers/pci/quirks.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846fc..4d1f1565b61d3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6165,6 +6165,82 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
 			      PCI_CLASS_DISPLAY_VGA, 8,
 			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
 
+#ifdef CONFIG_ACPI
+#ifdef CONFIG_DMI
+static const struct dmi_system_id nvidia_dgpu_broken_gpe_quirk_table[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "16APH8"),
+		},
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "16AHP9"),
+		},
+	},
+	{}
+};
+
+/*
+ * On the Lenovo Legion Slim 5 16APH8 and 16AHP9, the firmware appears to enjoy
+ * firing a GPE on the parent PCIe port of the nvidia GPU very shortly after the
+ * GPU enters D3Cold. This means that every time the GPU is runtime suspended,
+ * ACPI firmware immediately wakes up its parent PCIe port, which then wakes up
+ * the GPU. Once it falls asleep again, the cycle repeats.
+ *
+ * See: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
+ *
+ * Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
+ * nova as well, and it even seems possible for this to happen without any
+ * driver loaded.
+ *
+ * This seems to simply be a bug. Luckily, there is nothing that we actually
+ * need ACPI wakeup events for on the GPU. Events such as display connector
+ * hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
+ * affected by this quirk.
+ *
+ * So, workaround this by disabling wakeup events for the parent PCIe port of
+ * the GPU.
+ */
+static void quirk_nvidia_dgpu_broken_gpe(struct pci_dev *pdev)
+{
+	struct acpi_device *parent_adev;
+	struct device *parent_dev;
+	int ret;
+
+	/* Just to be extra safe and make sure we don't try this on an eGPU */
+	if (pci_is_thunderbolt_attached(pdev))
+		return;
+
+	ret = dmi_check_system(nvidia_dgpu_broken_gpe_quirk_table);
+	if (ret == 0)
+		return;
+
+	pci_info(pdev, FW_BUG "GPU PCIe port has broken wakeup events, disabling\n");
+
+	parent_dev = pci_physfn(pdev)->dev.parent;
+	if (!parent_dev) {
+		pci_err(pdev,
+			"Can't find PCIe parent? Your Nvidia GPU will have broken runtime PM\n");
+		return;
+	}
+	parent_adev = ACPI_COMPANION(parent_dev);
+
+	/* The spurious GPEs will be sent from the ACPI device for the PCIe port this GPU is
+	 * connected to, so remove our PM notifier to turn them into a no-op.
+	 */
+	ret = acpi_remove_pm_notifier(ACPI_COMPANION(parent_dev));
+	if (ACPI_FAILURE(ret))
+		pci_err(pdev, "Removing PM notifier failed: %d\n", ret);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x28e0,
+			      PCI_CLASS_DISPLAY_VGA, 8,
+			      quirk_nvidia_dgpu_broken_gpe);
+#endif
+#endif
+
 /*
  * Device [1b21:2142]
  * When in D0, PME# doesn't get asserted when plugging USB 3.0 device.

base-commit: d3d1e0c4343385fb343a552e4f3b6b97d5762fc2
-- 
2.55.0

