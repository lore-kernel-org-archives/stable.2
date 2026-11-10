Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345864;
	b=xg3J4csB4DKzebALln7aokel9FNW3/9WbKBLK8aYlSYdH59FQ7GH3hdHNOKtkqOitB7d
	 QaJyPDvSwTbFW7nhAB/sEOMSr1V2Ct2eqgh7azmHOJLqoBrWndjJ+u/kAsUg4MIDJXr7I
	 W4oXQIknrReHPhxtucJEBD/Kak+L63vEEgxCkoXyYaJfHXhQ1EXE5ByEo/BZ9Outsg3MS
	 6bKBb6lpmb1Cyx1gINfHKQ7EOO9WXe276RkEJIHpa4Jfkw67m6Zvf2V+Q3iVbbtIR0py+
	 hBGnqEDVTfFUJa5oOv6PX2Y7INVAx+Qcr/JCjnLvv3rd8DSZ8bgafRLJCMXGC2BZPWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WjjLn9OW/dh8Ooz1Del+NUReCfrVoH+dbIK19cMu41M=;
	b=EN8C4KhxYsmwuQWOBqscKf119Nc9IXW120UebRKH2ldx3YiWLe7ada5TMCK88QoMMz5r
	 eEJiwdt/0UvMPIrVkM8kcCv0P6ii/zBsaVCBu2GUwZs1YcwJWxQrk6UkgWq+7BOQijBC6
	 ZGeG0SjykmAzhcSSNrHd49djfnn5pQZzyKgV2k86hbbpEgK3bPfQxAAR9LJfKZTLnyxcC
	 apVOpIsUkWkJ04JTZzTrZTG/ZGREXguT9zwMHblirq0GcgiI6Jkd7qthDkeT+PZFleWEh
	 lBvxP1Gr1r/txe4gy+t182kWhcDMo4b+lxz+sg+zAIu4+14jYBh2bCXkis6oZgNVXQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LZeIR7jz;
	arc=none smtp.remote-ip=74.125.231.133
Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6797606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6797606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LZeIR7jz
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-8458555b6a8so794191a34.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794345863; x=1794950663; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WjjLn9OW/dh8Ooz1Del+NUReCfrVoH+dbIK19cMu41M=;
        b=LZeIR7jz+8PUTZOKod2uSPWTzAwELN5uiGu3KaHEfc9cwVEX6Q6WyMgKPfVv1IfFlH
         EM4w8UXaeiFNWUPfd6XbrV+lYhxvTE05jNP6CHVP/cSZE5JaNOyQkSTdlTdbkt+ZI9hv
         HRYtN30DFzuYzCVYLciROC0/i2nW/QtfNXSFjxkXrHJfB5l85Z/Vgkt9XpuG73NOmpE4
         cIq4sar+RMgAtXnejeWfLUb7aXn2e0crn4ZOZXCK0c4cu+yYEyHDMxdYw+DH1uvrfzUN
         AwCJMMUYn4N25gLjH9ylrC5SZS4IlaKRgwdpIGzCuHdFRKfx+QuzyCmijidEp1pzXV1j
         YCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794345863; x=1794950663;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WjjLn9OW/dh8Ooz1Del+NUReCfrVoH+dbIK19cMu41M=;
        b=CXhvs8/DKpmiAOC7aPIaGd8tUByLWSDrBsUXGVQiDYRlD/7POmYiv98cSUmBwlIFyj
         2tfseMwYDv5v4ftYapSR7L6mJgYq+iJwva6PiVb33VWNrrY59fdQWUCLBW3HmC5lBEUa
         CqZwIKx//PWG/O8FVsJeAEHSjbn1+Z2zZ4BC8yuQt2cCE8WtWNmrAh5FRlxWPvBdOKJA
         CfIBY9K2UWI/H4mJ8puGoix58AiyyctFCWpXfNiyhlGvMvS/ldYvABJY41f8Wc2FI/Hi
         CR0pmSE+nPGEKL1l1W5tfVqJvOPYI6aifQH3WGrEdeHDzoafi+VkUvg55hsfmMqGQMFc
         tQsw==
X-Forwarded-Encrypted: i=1; AL+hErF+IFTXVqlx14borL8E8tcz56Z4ZISHrbR/hpBwv+f/hNFx4n6FBWiJyikem+w5ArRvyG0p8Rk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AW3PcuVvyXpWXwUfkrQx3Ia5VxiPNcqJi5UjZQz55lbeDNP0i
	tUHMYYM4cY2aD8RoUnVxZWBMNbqNodQX1dOoYCOqm9Y415Mc1gQLwt0z
X-Gm-Gg: AYBFou0LV/wrKgVDZGfeHyxGjJeY1A3FZz34UcTyMDZZLAI1RaatdIz93Lak8FXMLvP
	NJxAdH1LLwTm6RAwpjxTZdR47vsRUez/BYOfn+nblU8GkWP7u+i+nqXuKoenht5mQj9BrU1VZi/
	qHXDwyjIOLkISQoxfEzyTE6rPzQsW2K5fVxgqNJjC+IDJI8TBy8OH8j6Ws7vhp1OKpOY7cDAai5
	pKd3QR4jW30eC20e96cZA7PUTvuv+osRF5UI/kx9g4BeI0TSbqVmCuNYbYVSAidDORfMY+FDlgo
	zYDXXLBQLbcd57nCSG38ojXiJKzWKW7wEYaCuRiWv48rsUcKN7V60OEoDwKr0ppkhcH1Y8JhA0h
	zwksR8s1zJwFWOH8kii2FpxTIcHoO2v9beaP/IQfpPh29Hu6hT9rtde65gDq88NGw5lARrFR+6F
	q9I5RBD2+7ryQQw1qlPTvtAVA4OgPK5jBXh8St364oG2BUAkaf0yZrplv6HUDdDJ5HLRoFsZZba
	VjcDPZUQ9vDCj6ljQq5bNUUGkrd7DUio59Igg9rjHTudBJ/5cBfveY3/THqgeLFCgsYvqc1MQgM
	M7DHwKWVNizThBpyIQyBLdV0WP6SekUo8fou1HPWSE7X2w==
X-Received: by 2002:a05:6830:4424:b0:80b:6f52:3629 with SMTP id 46e09a7af769-860f25e8e97mr185419a34.1.1794345862778;
        Tue, 10 Nov 2026 13:24:22 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb5f7b4sm2845528a34.4.2026.11.10.13.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:24:22 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 10 Nov 2026 15:24:16 -0600
Subject: [PATCH v4] pci: Add broken-GPE quirk for some Lenovo Legions with
 Nvidia GPUs
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
Message-Id: <20261110-broken-gpe-legion-v4-1-c672bb1c4d91@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/32OQQ6CMBREr9L8td+0pWBh5T2Mi1p+oQrUtEgkh
 LsbMHHpcpKZN2+BRNFTgootEGnyyYcBKqYODGxrhobQ11AxkFwWgvMcbzE8aMDmSdhR48OApS2
 dPplcl9rCgcEzkvPvnXm5fnN63e5kxw20NVwMPY5tJPNjcy2F5Lzgp2MhRaYECuzmV03nSHVrx
 qMN/TZtfRpDnHffKdsu/qlNGQp0qnSqyGulyZ6b3vhuh13Xdf0Ap2dkPP8AAAA=
X-Change-ID: 20261005-broken-gpe-legion-9c9f87a5898c
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, Timur Tabi <ttabi@nvidia.com>, 
 John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Lyude Paul <lyude@redhat.com>, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794345860; l=6414;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=4fzh2Kt6hyJZoUipRYGxY1lLhGP5S0v640iNKn5d27A=;
 b=9YJQTspVWw3SNIHz6DL8fo+E22qGFlOGPsa0xkwd+6tDhnlXfgCbGXQcYPGp4N3hDZTZY7I7z
 YY7fTaOLSYWCVHkiWRKOfP4aVMy0h7QLlgwP6QYEzPL6vHuIQCvyKv/
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
---
Bjorn, please pick this up if it looks good. Derek J. Clark graciously sent
a message to the Lenovo team on my behalf, but noted that the Legion side
of the business doesn't have a fully fleshed-out Linux team, and that Mark
has been helping out in their free time.

I imagine this patch has been missed by them. The patch has been tested by
many users in the linked issue, and I have been running it personally since
the patch was made.
---
Changes in v4:
- Rebased onto v7.4-rc2. No functional change.
- Ccing stable, as well as other addresses I missed when taking over the
  patchset from Lyude.
- Link to v3: https://patch.msgid.link/20261005-broken-gpe-legion-v3-1-f49f465d48ec@gmail.com
Changes in v3:
- Add the Lenovo LOQ 15AHP9 to the quirk table (@jindalpratik on GitHub)
- Also match Nvidia RTX 4070 Max-Q (0x2860), which similarly refuses to
  stay in D3Cold (@inigo001 on GitHub)
- Link to v2: https://patch.msgid.link/20260821200607.621341-1-lyude@redhat.com
Changes in v2:
- Don't forget to actually use parent_adev with acpi_remove_pm_notifier()
- Check if parent_adev is NULL (could happen if booted with acpi=off), just
  consider it a no-op if it is.
- Base the patch off Linux master instead, I based it off drm-misc-next by
  mistake because I'm too used to working on DRM drivers :).
- Link to v1: https://patch.msgid.link/20260821181203.82722-1-lyude@redhat.com
---

Tested on all the modified Legion devices. The Nvidia dGPU properly goes
into D3Cold with the patch, whereas without it, the dGPU will wake up
shortly after going to D3Cold. See the linked open-gpu-kernel-modules
issue for more details.
---
 drivers/pci/quirks.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..c2269c367279 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6336,6 +6336,94 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
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
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261005-broken-gpe-legion-9c9f87a5898c

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

