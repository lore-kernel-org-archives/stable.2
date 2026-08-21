Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24E337107
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342781; cv=none; b=Enr60vkrG4yZoBIMvJXoyQQ32Tz38ryb++vYQD7Uiy+gSATqaRlqRtYQ07KILvaWc2EjM85uN215Ic/sq+5jZ0YVIYhKmwnqiATQj1sZ9hbELBKtc6fj6yNYVE2BDR/Pyw/c8rZIGTMLaCpzeC7LclHLZb7a8PoUR8XWfKCpt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342781; c=relaxed/simple;
	bh=Deysu6za0mBKUURfnCfq0+2INVdFgYbsn4st/YxRJwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8gRN/nzgSyNSSmkBZ+nebACSCVycwB2EDlRkRsJenSgklOuYmgGPZr89ttIgJsFFQf+x8DNBTPAeri1EHwR7IPNmtV4lB5nMEgcHsxehxEim8Ink1PW0gJR7QRfNBjBxpE4+Zj840uDijsKEAjpieAqAbU7kfIYrVwXYDu/7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKqeQt7r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKqeQt7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787342776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Edr5cAtYcXCdnLa7oLzVihOqQYUUfcaDCBdJd9wwpE=;
	b=SKqeQt7r9u2Hwpdqy74j1P8YOY7vnVw5n3LJ6chbm6KTrK1BB2sCp2PeOA1VJvbREGmefF
	yztd/FEPtYvj7FoD7HKavDRLOSLSR8HDFihP2Pcj5wEWC29sW9yEFQoyTAidC5WmWEOy8h
	hYYpo9uWXPwu/1IbDy4pjgWM97bKPDY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-A8Al9uYjPEyH8ezlI4yzgQ-1; Fri,
 21 Aug 2026 16:06:15 -0400
X-MC-Unique: A8Al9uYjPEyH8ezlI4yzgQ-1
X-Mimecast-MFC-AGG-ID: A8Al9uYjPEyH8ezlI4yzgQ_1787342773
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28AEB1956073;
	Fri, 21 Aug 2026 20:06:13 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.80.7])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 702DA426;
	Fri, 21 Aug 2026 20:06:11 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Timur Tabi <ttabi@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Ryan Brue <ryanbrue.dev@gmail.com>,
	stable@vger.kernel.org,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2] pci: Add broken-GPE quirk for Lenovo Legion 16APH8 and 16AHP9 Nvidia GPUs
Date: Fri, 21 Aug 2026 16:04:51 -0400
Message-ID: <20260821200607.621341-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

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
V2:
* Don't forget to actually use parent_adev with acpi_remove_pm_notifier()
* Check if parent_adev is NULL (could happen if booted with acpi=off), just
  consider it a no-op if it is.
* Base the patch off Linux master instead, I based it off drm-misc-next by
  mistake because I'm too used to working on DRM drivers :).

 drivers/pci/quirks.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846fc..b6d8ba5e4c2a6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6165,6 +6165,85 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
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
+
+	parent_adev = ACPI_COMPANION(parent_dev);
+	if (!parent_adev) /* No ACPI? That means no GPE, and nothing to do here. */
+		return;
+
+	/* The spurious GPEs will be sent from the ACPI device for the PCIe port this GPU is
+	 * connected to, so remove our PM notifier to turn them into a no-op.
+	 */
+	ret = acpi_remove_pm_notifier(parent_adev);
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

base-commit: 2be02a7c996aa733bb36e29e07715621b0de9736
-- 
2.55.0

