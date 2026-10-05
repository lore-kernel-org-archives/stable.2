Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89130EF91
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 05:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179705; cv=none; b=WkpBPYAqyDij8zHuUfUhx3Omxpm/uzq3TwqzQANH8aw3yWVQt0Pbz3W3SS6iqVpECZIqmmG/uxMPKrEZkJWhECrtbL6pWk27CjkjlGIwr8pdr/w0tWRJdFyrl45tFKX4jd6E0YGazZ1NNz1iajMSdI8Le5Os8plHLCULcLRl6Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179705; c=relaxed/simple;
	bh=83Mi4SsZo+QdKUXzamfbXcZtg0H47QSB/stlHzfJ0/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HUSKhoC21hnCVp7kEOXdLTICB2IBnSS6riI/yPxT8J9ZTCcuC4iguoeD3BxG4fEjMVrMv4QuXsIyW+Ok6YLNa5IBLHZSYBqfXWdckIaFdxuUDQ6UIfuj3+bi6r1AeDW25HLfSjoiTlVRxIPSsmhO5inST0A4el6duJtIFeTtHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d51itECR; arc=none smtp.client-ip=74.125.231.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d51itECR"
Received: by mail-oo2-f0.google.com with SMTP id 46e09a7af769-824040a3379so997367a34.0
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 22:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791179702; x=1791784502; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lhTQnb1kgZA65UjKBvAFkiBVW/FpkzMZCe1zIAscI2s=;
        b=d51itECRdaTZFxtrgUHIoZs/4WHUpVu5DmjkoDkeQc0GCJTe3pBr98LJwtL1yZ1lt/
         M474fNQ1L/wtGHDdFIplnt3DWh43pEsqS3yORFg3oXAQcUKvioTvMEWY05OniH21CXXN
         WhmJvVvoOX9hMGccc+AoRZ7uvV1uTKegBmWZsmSP4fUsAnPx0argfTox/IRz887nGgAc
         PhHRWrWURc/MQ7w8tcsa/ci57pGGlVs63CbAM+C8em/M5TI5PSoXdHsu9bMmqcAazB42
         CInweWmLQmrjCWqIvrpfERmfM6zr9Us8LrHkL09ch8xIpQ+7djBuCLU6JdP7dpGbY9Tr
         FSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791179702; x=1791784502;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lhTQnb1kgZA65UjKBvAFkiBVW/FpkzMZCe1zIAscI2s=;
        b=xQad48AZ0x79ekfZSblJhE+zwybG0Y8IO01SyKSBmBwGZzoa0lwqrjnrRQu7Jo7pdS
         Nwhtms3rWZKIaN8QKunXPuIB2ozRtgTZtSemPgfUYX9IWEfsed16bsG3hFTAgE0KBB9G
         556gs8p8Bp0HvSrRGB/Pn9dw6qhP5T9gtfu861bPyYaC0wYnoVkwsY+z76TTDVoNEuR/
         bkzDXyObk09VOyResaGfv2M03IAtXMDRfxy9MFBUFcDaYD5RLw06ZXFPWfXXbHO0LXJK
         LLdqKaF4gIQyJaeL7Lft88lXZeMs0GFxu0uB5rlGAPUG8bxfCXl5P7ZrAkUCLgHI/MbO
         Tjyw==
X-Forwarded-Encrypted: i=1; AKwUvBxsciJr6UWQxW1izNwi2NztX4YDRpoKMKWwHtjX0itlGCHBGCF4QmZ3Q+0wAuaEfL8oJHUfbK4=@vger.kernel.org
X-Gm-Message-State: AFuF++mAacIdmGDnBNa8edYiHBR3IXlPh0E1O6mhcavcwuTTuw9LyToE
	daf0vIfT5RRP81HENnHo6mBxk5xJwR22GJy7h02Fy4jrDu4mHF++bCPz
X-Gm-Gg: AYBFou0vzKablDUk+jAknp75ZiaGdvcVXuWuhLeZx/Ng9ilvDY4ajGC66F+Y3FMIlIH
	3HR13PNmSyURDBK+IKrLIm6p5+YZTL4A/wiZG/t3ydXNmRFta0Dnxawqkjjfn15CY/GkpIbryFB
	p6yuIcSWNxpNrIAdtbpYJ1EG3jY4McYcXLJSg3L0a1YDMVxsv8p3cCjKUqEox2MY7pZeX8Z3XRB
	e6vkmSSIHlA3t9HAyG3ZpBKyTSc3p24s38ZWErP9H8HVizYpGT4NCalc+Lg4RBiAMkz9dipWE9G
	DEZXUODoDCciNbHDBggIlEvGOpoqPQ59lvcfpBaKIQY0mrD215zAIuq5X5F7w7MS6VTb4Pcsgcq
	FZltkSPa2umytBpPsGr5oucg6UNxninv8J7BeVeiQZ5l/jFKQ3qGP7YQRufaWEhJFFl314K4r90
	LFWs6x9aeM+Ft3S0FLFqw93zpdJGqcF3VdbLcXzwGKkgpKRxJcysrXgEi6FRiNNFul+w==
X-Received: by 2002:a05:6808:67c2:b0:4d6:9293:9bc3 with SMTP id 5614622812f47-4f52a572fc0mr8970595b6e.61.1791179701812;
        Sun, 04 Oct 2026 22:55:01 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::2620])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f523d9e947sm9334247b6e.3.2026.10.04.22.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 22:55:00 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Mon, 05 Oct 2026 00:54:47 -0500
Subject: [PATCH v3] pci: Add broken-GPE quirk for some Lenovo Legions with
 Nvidia GPUs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-broken-gpe-legion-v3-1-f49f465d48ec@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2MQQ6CMBAAv0L27JJtESie/IfxUMoCVaGkBaMh/
 N2iicdJZmaFwN5ygFOyguenDdaNEbJDAqbXY8dom8ggSRaCKMfauzuP2E2MD+6ijZWpWlXqXFX
 KQOwmz619fZ+X64/DUt/YzPtoN1rvBpx7z/r/JiWFJCqoTAspsqNAgY/30vDZc9PrOTVugG37A
 Irx4r+wAAAA
X-Change-ID: 20261005-broken-gpe-legion-9c9f87a5898c
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lyude Paul <lyude@redhat.com>, Ryan Brue <ryanbrue.dev@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791179699; l=5640;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=c05AaGWDZKzjXa+WhVJk65Zt6xdn0T7JDM0GokWQMdo=;
 b=olXC+Jmtb1R5QjvWm3MWfQWKr30nDcCDpueqGqFQ+k1ulyp+WNZfu1IYO0dTgOqk3rZHM0IBC
 u2IH593ewWfDSg11vJaYMGSva5tFxDLlMaEeRMKnlfGwKhZkj5Y9Xl/
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

From: Lyude Paul <lyude@redhat.com>

On certain Lenovo Legion devices (including the 16APH8, 16AHP9, and
15AHP9), the firmware appears to enjoy firing a GPE on the parent PCIe
port of the nvidia GPU very shortly after the GPU enters D3Cold. This means
that every time the GPU is runtime suspended, ACPI firmware immediately
wakes up its parent PCIe port, which then wakes up the GPU. Once it falls
asleep again, the cycle repeats.

Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
nova as well, and it even seems possible for this to happen without any
driver loaded.

This seems to simply be a bug. Luckily, there is nothing that we actually
need ACPI wakeup events for on the GPU. Events such as display connector
hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
affected by this quirk.

Reported-by: Ryan Brue <ryanbrue.dev@gmail.com>
Link: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
Co-developed-by: Ryan Brue <ryanbrue.dev@gmail.com>
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
V3:
* Add the Lenovo LOQ 15AHP9 to the quirk table (@jindalpratik on GitHub)
* Also match Nvidia RTX 4070 Max-Q (0x2860), which similarly refuses to
  stay in D3Cold (@inigo001 on GitHub)
V2:
* Don't forget to actually use parent_adev with acpi_remove_pm_notifier()
* Check if parent_adev is NULL (could happen if booted with acpi=off), just
  consider it a no-op if it is.
* Base the patch off Linux master instead, I based it off drm-misc-next by
  mistake because I'm too used to working on DRM drivers :).
---
Tested on all the modified Legion devices. The Nvidia dGPU properly goes
into D3Cold with the patch, whereas without it, the dGPU will wake up
shortly after going to D3Cold. See the linked open-gpu-kernel-modules
issue for more details.

Lyude gave me permission to send out the v3 with modifications, as she has
been busy.
---
 drivers/pci/quirks.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..f0ea0a722183 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6169,6 +6169,94 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
 			      PCI_CLASS_DISPLAY_VGA, 8,
 			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
 
+#ifdef CONFIG_ACPI
+#ifdef CONFIG_DMI
+static const struct dmi_system_id nvidia_dgpu_broken_gpe_quirk_table[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "15AHP9"),
+		},
+	},
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
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x2860,
+			      PCI_CLASS_DISPLAY_VGA, 8,
+			      quirk_nvidia_dgpu_broken_gpe);
+#endif
+#endif
+
 /*
  * Device [1b21:2142]
  * When in D0, PME# doesn't get asserted when plugging USB 3.0 device.

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261005-broken-gpe-legion-9c9f87a5898c

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

