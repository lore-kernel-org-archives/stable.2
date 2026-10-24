Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820836;
	b=bcA+HjVYLWa0RZYHQYQp90ItwCkrlPmIOlUJ0pc6FIRWSVdkApwsZz7CCIHbuAjUBtt3
	 41fVKbn1wSro1sukZ0I4nfKZbuCLP57a4VNJsv8N3KxTmP+AxjuV2FcKRuGN3YkF+OS3N
	 o/VVMp0ziGgGUv//JQx3xZlLD+tsPuFIhLF39tOH03v8XeUAS597w8cg8kizoYL8EwsGy
	 ka8IiTCtWeTFow/0mPs/5RUz2vpPmzquBOc+Smt/32k009rOq35DzV622UZyocaaj9yP6
	 O6qjAysUjhSvyGsdv/4TD2DvrVufYnC0xoidFJXVY5/Q2OUV9M0uayvgKshigE32USg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JVRdE/3Jnet+h8SyIDy0Hc/nWbQ9iRRU6k7zkm9yJs4=;
	b=TeUZEBKc7s5+k4tV8A6GNP+WUQw24YWgh2J0IVRigsaCOSFQd65jcXScVGiQDSHIymve
	 msXYZu9c+VDU4Cai75k2O2Drqu0QwlILWzjLgU2sqE+KBRoi3jzI9wHPdOlLU2LkJsPcU
	 gPwwrxlwI+JNQUouR3m0buIPOo1C3CtAUW02VcEeVUY3wPo3tdWl9ef4EY35DBikiXiqk
	 ykos9gwEijKnol0KufbUQLl0dZIu7NIFsn8pPKvQ/wHEhEnxzbJTMlpKLUHY4asEfvMIH
	 Lq9yV44S2tqUoLzpQ7Jk0DRjwph5/rrv7rUoBEBvW0iCY8618yww13TUNofJssAW11g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yuw4ixgJ;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033D606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 05:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2033D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yuw4ixgJ
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so8186245e9.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792820833; x=1793425633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVRdE/3Jnet+h8SyIDy0Hc/nWbQ9iRRU6k7zkm9yJs4=;
        b=Yuw4ixgJc6bzy2bcfbKthETR1aV1KVTchu3ycgR7/NVAXtHhd80u0bNyC3XZmU5Q9a
         7nFiaAO0SGPvpxkbtFvr78kqPDoSRpZv2OEHpVI02E2vHo7FxiTuzkjPayNJtmPZqWPu
         GBfVz7OixWqhoxpGPbjn/yKao1ZNgwJfR/BZz7I9T9WJQL3q6LTUJnlN0xQHRHvcS+WO
         SSVrq+yFdxDUZiy8dppA4CwpQhMpykb7hlaaWmamK3wFMyzjbNpwSAcTcx1ydkZYBmW1
         PCp9BnH1oKZKB3XpPCVEwsM2E+ahQikbxi5VLFV1ZVihHYexv6mQuxAXi5DF7PfLP560
         Uv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820833; x=1793425633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVRdE/3Jnet+h8SyIDy0Hc/nWbQ9iRRU6k7zkm9yJs4=;
        b=RCugk8G2FXQ6WCza1pvCxGRekpefk1HwOws5fukJqj1926GTE1Ne/KPKxr4I3wdLG7
         UFNqCkLlhaoCW9LEpCw//DmU9QLx5LDUJCzydMT6OId2licW/BSD4Fgi0Ru7zkYxjzOB
         ssWbV186s3zjoEpCy4K6dpaV1VOmQgmmr2y0SWagA5P822hcj3QBRN1ANfdjvFHGrgCP
         HuPN2PMKyREcsSBzkd0OdCyLFnm17+J5r031VLd4T/Tv3RWb5d/UGEVzuLqs2v1+/HYk
         X5lreyD5DAC1Q/HSckgrPt7hy3HpkL6ZIMZbLwmPf8+uNBv9zX7gYRAVpw7j2phJd8zA
         PB1w==
X-Forwarded-Encrypted: i=1; AKwUvBxrFXrs26Iimp3AONh1hzeWuY+nMLLkV55jlKRprhTtvn/zucm0J2l7m6BzNR59MjIitQ9nGuI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBtk1bw4m0VkM1W6Q2kd9OAKfTtc+2OABkYzeLULRBcPJMe2aZ
	LN5O25or9Lxg3eqxS/QZvCUkO2kvT9SHHCvSGbczc0tNDOa9HktQWvez
X-Gm-Gg: AYBFou3LAr/TNcpOJJd1P6jMfLLCMwsJ9Ib5agSZ8O5qnaTvOY8uW2S0+sFBczaE6no
	ekYWMYsdISMqWgeG2CTz/cJDFQOOYnLBrEdXSOhrwTrU8cj6TqDAA4IkbykBefywImr1F+1mi11
	ZlJkEsgvJqWp+37pQpSfOZ8FNABqmdwOBuCyI5vC7BkZF18Iv/J4MmSsCRDLxSm7YMP3zAmV61S
	ufe8ro24VoTEz+2aMRArT1RtOjfTByYjBEjWgOm0rAnehUvgpO+7PrBZLxC4UvAK8cTF75Fvup0
	YAVgqSR0sn5skLdQv4ATMQ10+dEtSsfijc5RSg52YWZSwWhounxEZWAeNWVIBnViOgbunjmLk8Q
	XtrHW3N+tMUiSLedwFr/8wlEuZdMdbSZS25bKH3/6fTjy0OYOJjThfquKohUeeBH9wTkHpYKeaN
	ki2MGY9sCWuLrNpDLLVacG1lUC5GZJ7LqHtRueO/ItBoKb8iH0UhDwpttqGI9bMuCPzxJ35e+tS
	1YJn+sqkW33Q4AI523ym5VBIMDBKkmcYuXby1f9tT7xHKcx4SkvpOw53CdD2W01+7d0FMOfUOMX
	TPeozUwc21V1nJGkDIVAz9wozdJCQptxVXAIHgmIgiiGKnM/U8sk
X-Received: by 2002:a05:600c:8b72:b0:4a1:e11f:b2d5 with SMTP id 5b1f17b1804b1-4a35ac3948emr13955165e9.2.1792820833100;
        Fri, 23 Oct 2026 22:47:13 -0700 (PDT)
Received: from Sheldon ([185.4.35.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a00e1b0sm25917465e9.3.2026.10.23.22.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:47:12 -0700 (PDT)
From: Victor Carreras <vicajilau@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Victor Carreras <vicajilau@gmail.com>
Subject: [PATCH v2] ACPI: x86: Disable wakeup on MSI MS-1592 and MS-1594 dGPU root port
Date: Sat, 24 Oct 2026 07:47:11 +0200
Message-ID: <20261024054711.21587-1-vicajilau@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179272791966.20251.3697951431087014523@gmail.com>
References: <179272791966.20251.3697951431087014523@gmail.com>
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

Add a PCI quirk in drivers/acpi/x86/utils.c for boards MS-1592 and
MS-1594 on root port 0000:00:06.0 (8086:464d on 12th Gen Alder Lake-P
and 8086:a74d on 13th Gen Raptor Lake-P/H) to disable wakeup capability.
This keeps WKEN = 0 so the root port and dGPU still reach D3cold
normally while leaving GPP_A20 owned by the GPIO driver.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220725
Cc: stable@vger.kernel.org
Signed-off-by: Victor Carreras <vicajilau@gmail.com>
---
Changes in v2:
- Move the quirk from drivers/pci/quirks.c to drivers/acpi/x86/utils.c
  as it is x86-specific (Lukas Wunner).
- Drop clearing adev->wakeup.flags.valid in the final fixup so ACPI
  power resource dependent tracking between pci_acpi_setup() and
  pci_acpi_cleanup() remains balanced.
- Link to v1: https://lore.kernel.org/r/179272791966.20251.3697951431087014523@gmail.com

 drivers/acpi/x86/utils.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 4189516..84a6ca7 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -665,3 +665,50 @@ void __init acpi_proc_quirk_mwait_check(void)
 	 */
 	dmi_check_system(acpi_proc_quirk_mwait_dmi_table);
 }
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
+ * Disable wakeup on this root port so _DSW is not armed and WKEN remains zero
+ * during D3cold transitions.
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
+	{}
+};
+
+static void quirk_msi_peg0_no_wakeup(struct pci_dev *dev)
+{
+	if (pci_dev_id(dev) != PCI_DEVID(0, PCI_DEVFN(6, 0)))
+		return;
+
+	if (!dmi_check_system(msi_peg0_no_wakeup_dmi_table))
+		return;
+
+	pci_info(dev, FW_BUG "Disabling ACPI wakeup to avoid touchpad GPIO (GPP_A20) takeover in D3cold\n");
+	device_wakeup_disable(&dev->dev);
+	device_set_wakeup_capable(&dev->dev, false);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x464d, quirk_msi_peg0_no_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0xa74d, quirk_msi_peg0_no_wakeup);
-- 
2.55.0

