Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792727924;
	b=bnQJOa3Y2DAVkGOV+YbZ6Pa4JHv/yyvL4XFdEloSYvzy51g3cCXWlhS1caBTUHPnr434
	 4GeQNtz1qFx2T08rMG636AfzSFZ0lirdgDl3iI+UpKP35HVHwtJ3rM3oT0fJ5XGbo/Fzh
	 TFNk12mKfTuGy7rLm9+tEt9vVGK89nFsDAeMLZzvbPdjUTQibYewtmZe37djwJoK7yYAZ
	 ubKtYm0AIGauPzv7wUlwfxfLyLhtklCNRqgc7N2+RUqUIiubJ9HuxzHpf6NeUXkD6exOH
	 /CzovAfnJdx582a7dMq2qZVJq0SVytDanhDPxr1ALIyqZkvBtDuopOZLyXUMw19a3eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792727924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NwQB+K0m+GVHe1I8OheGGsFKNnF6rubBvY7XUeZM4Hk=;
	b=jb9kVdActhdmtXmJBJQVMZcz4pFfHYSSyQVjQShdYafJr1211Iyl311RjGD0fjQm4b0J
	 cyr/x6buvH+5QizwZ7ZQEkVtvI19ddEHZZEVwbY0bJw14TnK/IHwZm6cfXGwHfVyDOQR4
	 t+gYUZoQWX0gAvcxgb0Ks0MTA4DzpXpw5L/cTm0CvFrUZJN5YYCys6jSJGHhOv9ZwQXVA
	 yvZTrl0POyms5seXaGr4B5COxvhJX0TZE0OWZIM4k3XxcW5nCT5fEgkI0HNLSZrMNgF/E
	 k7D6L+jxlD1X9AM6UCArAjTHZIF6VvhXHSWJzkKwweHyIzXbRxNMfrOcqzy8qgT9SdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UNDqVvlC;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0A606A319
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 03:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B0A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UNDqVvlC
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c263415982eso59214766b.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 20:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792727923; x=1793332723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NwQB+K0m+GVHe1I8OheGGsFKNnF6rubBvY7XUeZM4Hk=;
        b=UNDqVvlCh+ujQq78hHk9kK7DGfZhW22U4Vq8+6bM3GH7ESYm1AotpckF8FmOF8vfLb
         vXsQr6/KewQia7yHh4Jz2CTM3rxxYQeYmt2zlm5/+BWjztRyZ/CKgUQOOATFJwwgSFb+
         gZgKX/GrlYKahLRfQM7Gw9LJttmffFkpqBZg/WrEbd0UNq8Q5xAGryDn94WfFm1AxTNI
         qk3DT+VbW3/gNGeOh20YpbNsiDjjCUsKGEgB7mqDR0SMaH8nQFjsuUhIvIiXulY6/7MH
         qy9qaEU7I6dU1212oavFHfBw/C0HbjdKvT8eSXPbHDmug9IY2qaLJs3MG4aswbTZtSry
         LYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792727923; x=1793332723;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NwQB+K0m+GVHe1I8OheGGsFKNnF6rubBvY7XUeZM4Hk=;
        b=2iBGp8namjET1duasFmBRhQe+UMxL0nxydayK32R23YORHpi8ZBRjpTyzyIj5jt6IH
         lfoVJPTPXxRP+on3wFX2FGzrj1k7CERkGa2IrbbFhLEaSNMFB7Tpf9rIKFmI0vN9eNv/
         Dk4CWrk5akouJVBGkJTV2SNBuylxfM8IKSoCCBiDLngI49a+aFzmtCqVpc+W6FppSr1Z
         /GoL/Ffx9WK2t6FMZKvKYHBRD+jjG5lPjAg+lirS6UohTssqYsbrrm7/BKaxwaO6g41S
         99WsGQVT79CcOy5cMS7jYuSsMDqgrFt0rhU60Oo7c1o81D3Vz3vbOZ235+A/0ksGeCeT
         lM+A==
X-Forwarded-Encrypted: i=1; AKwUvBwaJKxCG/CpcZk1f7cCUKuo4SgKuuZEc8zl0ClUSQnfE9Gh8OpG18ZhysrfqSm5YuYd2eiyd3s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJpxBjVVFlZc7t7hQ4vWVkQsTbHRvV8/UY+bmYqv463ybpgld4
	lRKT5/R4M62gHQVt4Kb1b45prPaKg0NzsQ4vtt4Ay6JV/gDnpEoPDZOW
X-Gm-Gg: AYBFou1CbpUzLcgu9HT95i3go3oTzIsrVWFE/DmCX+G40YS/W7XhiP8GlSREN2eHljs
	yZepgsLqQ0t5MTrweF4ORPMzRGV2jM9Vj4ZosXscY5EpS34Ldn473OdNK5o7u2SMFrNFObkTgqQ
	udZk6gP0MS9bEA4oK4nl+KAz2XU2nmJn83SR1Ra3aW6tfIyB2JtojLbUUR6Bsl47rTm8dxuKc8I
	k+TfZfSXarZbqx6G1XfdLIVoJKgqzUCDqHbZs4okdsg+vXhD4UlPW3aqNMjsqPXP6eXRUDjPGPh
	pFAXCPbatu1LNpLLnEu4h1VX7BcrUvZ12MWNyH5s7UsjYd5CL8iNLrulpL7rLC6U5gu8aReISsr
	Rnl82QJAQRtC9L6RezZMxhKq4xAPHDvtIC+obXdFbz6pr0m2sS+uSw44icCRF0qgZ3ZmhrjPJZq
	RClXG6zkxcYN8m54rrohEp+GgZVRO0WJ6VQ3Fi/MrFjHbuFkvrSqFKwyFMwkyeKLe95c8KylCDr
	1USAiQXj7f16iMnxXQFbRFRg0yh1JZsobhmrpn5/7ldsV5ZSh/TuVaIi2wjCnPN1rWW43GVEqiq
	Qq/pWn6zjdvB47JoHLFO/1git5UWcZuv
X-Received: by 2002:a17:906:c10c:b0:c40:38b5:d784 with SMTP id a640c23a62f3a-c46a91fa71emr168512066b.22.1792727922729;
        Thu, 22 Oct 2026 20:58:42 -0700 (PDT)
Received: from [10.30.2.99] ([194.224.86.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5c81c1bsm55431866b.44.2026.10.22.20.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 20:58:42 -0700 (PDT)
From: Victor Carreras <vicajilau@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rafael J. Wysocki <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Victor Carreras <vicajilau@gmail.com>
Subject: [PATCH] PCI: Disable ACPI wakeup on MSI MS-1592 and MS-1594 dGPU root port
Date: Fri, 23 Oct 2026 05:58:39 +0200
Message-ID: <179272791966.20251.3697951431087014523@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On MSI Summit E16 Flip A12UCT (motherboard MS-1592, BIOS E1592IMS.111)
and MSI Prestige 16 Studio A13VE / Summit E16 Flip A13VET (motherboard
MS-1594, BIOS E1594IMS.115), the I2C touchpad (ELAN0305:00, 04F3:31FD)
permanently stops generating interrupts as soon as the discrete NVIDIA
GPU (0000:01:00.0) and its parent PCIe Root Port (0000:00:06.0,
\_SB.PC00.PEG0) enter D3cold.

In the platform's SSDT (MSI_NB / AdlP_Rvp), \_SB.PC00.PEG0 sets its wake
GPIO (WAKG) from the BIOS NVS variable P1WP, which erroneously points to
GPP_A20 (INTC1055:00 pin 62) -- the GPIO interrupt line wired to the
touchpad.

During boot, \_SB.PC00.PEG0.PON() calls \_SB.SHPO(WAKG, One), setting
PAD_CFG0_GPP_A20.GPIROUTSCI = 0 and HostSwOwn = 1 so the OS GPIO driver
owns the pin. However, when the root port runtime-suspends to D3cold,
Linux enables ACPI wakeup via \_SB.PC00.PEG0._DSW(1, 0, 3), which sets
WKEN = 1. Subsequent evaluation of \_SB.PC00.PEG0.PXP._OFF -> POFF()
executes:

  If (CondRefOf (WAKG))
  {
      If (((WAKG != Zero) && WKEN))
      {
          \_SB.SHPO (WAKG, Zero)
      }
  }

This switches GPP_A20 ownership to ACPI GPE mode (HostSwOwn = 0,
GPIROUTSCI = 1), silencing the touchpad interrupt until the dGPU wakes
back up to D0. Under Windows, _DSW is not armed for S0 D3cold on this
root port, leaving WKEN = 0 so POFF() powers off the dGPU (\PIN.OFF(PWRG))
without touching GPP_A20.

Add a PCI quirk for boards MS-1592 and MS-1594 on root port 0000:00:06.0
(8086:464d on 12th Gen Alder Lake-P and 8086:a74d on 13th Gen Raptor
Lake-P/H) to disable ACPI wakeup capability. This keeps WKEN = 0 so the
root port and dGPU still reach D3cold normally while leaving GPP_A20
owned by the GPIO driver.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220725
Cc: stable@vger.kernel.org
Signed-off-by: Victor Carreras <vicajilau@gmail.com>
---
 drivers/pci/quirks.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1aa87a3..4e26674 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3941,6 +3941,56 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
 			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
 			       quirk_apple_poweroff_thunderbolt);
+
+/*
+ * On MSI Summit E16 Flip A12UCT (board MS-1592) and MSI Prestige 16 Studio
+ * A13VE / Summit E16 Flip A13VET (board MS-1594), the BIOS SSDT (MSI_NB /
+ * AdlP_Rvp) assigns the touchpad's GPIO interrupt pin (GPP_A20) as the PCIe
+ * wake GPIO (WAKG / P1WP) for the dGPU root port (\_SB.PC00.PEG0, 0000:00:06.0).
+ *
+ * When ACPI wakeup is armed on this root port via _DSW (setting WKEN = 1),
+ * subsequent D3cold transitions (\_SB.PC00.PEG0.PXP._OFF -> POFF) call
+ * \_SB.SHPO(WAKG, Zero), switching GPP_A20 ownership from GPIO driver mode
+ * to ACPI GPE mode and permanently freezing the I2C touchpad (ELAN0305:00).
+ *
+ * Disable ACPI wakeup on this root port so _DSW is not armed and WKEN
+ * remains zero during D3cold transitions.
+ */
+static const struct dmi_system_id msi_peg0_no_wakeup_dmi_table[] = {
+	{
+		.ident = "MSI MS-1592",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "MS-1592"),
+		},
+	},
+	{
+		.ident = "MSI MS-1594",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "MS-1594"),
+		},
+	},
+	{ }
+};
+
+static void quirk_msi_peg0_no_wakeup(struct pci_dev *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
+
+	if (!adev || pci_dev_id(dev) != PCI_DEVID(0, PCI_DEVFN(6, 0)))
+		return;
+
+	if (!dmi_check_system(msi_peg0_no_wakeup_dmi_table))
+		return;
+
+	pci_info(dev, FW_BUG "Disabling ACPI wakeup to avoid touchpad GPIO (GPP_A20) takeover in D3cold\n");
+	device_wakeup_disable(&dev->dev);
+	device_set_wakeup_capable(&dev->dev, false);
+	adev->wakeup.flags.valid = 0;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x464d, quirk_msi_peg0_no_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0xa74d, quirk_msi_peg0_no_wakeup);
 #endif
 
 /*
-- 
2.55.0

