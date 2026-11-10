Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345828;
	b=3MqSzcfsMIDIVp4H+n3aN6/C4pI9Z0zrBUj4nKZUPw3MBYPSzvuxy2o12zfoC1C2oPDL
	 6sujNya/E2kHYqKmUxzgB0kqa0EwdHzGnMfU5a6Em+YdD3GAofjpOA4LMaaLkAH5qL++4
	 k+jMhPC0niAgCcYff4IG2e3StYbhLp6PEJNP72IP5gAakZCz5tUUNyoIFyiKxQdvxY9HK
	 yDBjXUivScpeB1hLa7zxcNrFMvBa1XxLC7DQxVpPouiQR2tB4gjF0hTeKakb8cjxEi+BJ
	 /ZGGRNgALw87I4Grf6z/1/p3ITDPJ0678/V+QncsmJ72aB9G6Y+JYkpyjIkXY6jDKjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WjjLn9OW/dh8Ooz1Del+NUReCfrVoH+dbIK19cMu41M=;
	b=vx0ddyNZSSjMaKOOG9Pd5pme5y0jOuNS3bc0oM0wQkWQUxW026x5mhHYXME9+zlkHy7l
	 pjrXqm2rprC7Nw1Mavc9QlEc+Hh1GGW3INzoNY+rNpObr4jyFS00ZEH9kt3Pd4mRi4zGN
	 Z7eV1ZTg6Fzeuz9SajCcITBuKhB7Rq7CHLSJy2HGL+svB5TczQbJoP2I/ac4v4PK8y31Z
	 H45pvcJI8prvbFcbNqWSBYvaotoo5XEtkDCbDiLO12rHJO+dxdxkmy4t5NPdljhUahPJS
	 S7YS06PEzP8YFX4sO4iQFwMF9e6TcWg9GhqadYwZMj8hlJC748aQhLWjvI1M7ZAPTFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v55Fqf6n;
	arc=none smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F657606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F657606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v55Fqf6n
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-53c4858eb76so1055691b6e.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794345826; x=1794950626; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WjjLn9OW/dh8Ooz1Del+NUReCfrVoH+dbIK19cMu41M=;
        b=v55Fqf6nesjUwl7S3WGtyZfnSRtBELCeXx7+0keF4UefA4+3rdaZ1t8XR8QWXLajp1
         7WOU8hT7hqldekzu1sz3P+CqJN9xW5a+O8G+qHtFBayaPgSA7GkWerAmEcDHK8toyJKR
         MpfZHKeHyicTjkYxEUhKMpvNLDMdTIqvwSKTfPVXWFTqCdMUmlgRVx/PBzthmaqXIfzJ
         aLl/f+2tLGXMk2DHYFn1an1PUaXW8qKLU2hmPOLi+Ax9BNP4tJoGqpCkJxUQ8gVk+Bip
         Fr+DxJKopPuj+79l/jMmJQoI8qoZARITMKgJx8YBhvZQ+D5XBk/VpOk5far5YKujeGdw
         bdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794345826; x=1794950626;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WjjLn9OW/dh8Ooz1Del+NUReCfrVoH+dbIK19cMu41M=;
        b=k6v7OCxxwaANrJKzgTWfCCPd+mrId7HCGgYemkE6t/ASq7FX2jDIGTUBCwy0PZKonc
         q1mxY70FblxREgQBlVnkSLvOcQROoF9ZV5IPwitU5eU+Pc6yvPBeOSdTW9Ty3TfcR5I3
         H6E4jQmF4a15MF+sirDenJRcGbp3co1jEtqf8kcPfTJ3xBisKGylJfhQOf1uZZHaJ/3E
         OnsBuE/v1lgSEAlEhq3MpLFubl+Y5d9JZK1928s7ItxeR2XtuOSYRpmaWnDL08Oa9jbH
         2iixpyQKeB/nbmZl7vPuz5WCPGKKiilLMxro/XZgksBkrvHd7ucBH3ikV+GqQ0mxRiqc
         AO6w==
X-Forwarded-Encrypted: i=1; AL+hErGyR/OntJETvn3bR2rJ6bi2+WyY9okIYlxu00V1m3zopjP54rBn/5df2gYRxFAGw6oAt/SOYRQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dMXI5JWviTowW7Fc+jfpjqub02uB+m/jX9V+/XI4aXU8CxOu4
	J+pTJ0fgQJ8SgO7RooGUS1q9Ejx6MCZ9D3267BB2ju7nU2Dz+K2YmSzA
X-Gm-Gg: AYBFou3zWpdrvEfRknxoth1fl5hboMCTWVW7wOHmUSCBeiUiLoy/SkELCQwiObGm82y
	5aZjUsHR+OyzKcpRIGtwB9Gy2FDIktSVo6D457Uit2OmuDSvIW17qSs5PEZ9y/o7/XpNwmIc+pW
	NN9Er4vDeybZ7THkxjA8OiEB87Ib6mEHV+BAL4l2i6cA+7lWkdqqA3FCBbxdE6V+tesy80l8Be+
	xeaNYxLH9hRN4hBtnub84HkWhs1qAPoj/geOWs6rLFvsJiCr5QB07XPgmQfM3chKOfNnZA1euY8
	uNkJ6stRCZiLzlUtR45imQGPEqbypgIIFODcG+zxTvTHEtjsKbCWFzw7MG3080VaiAaMVSkWtFa
	4WUgpa2tMlyW05wckb5r70q1BDjEGaAsyNDQ7e2CDhxybhkDJd5WeTkUUaKSHmpYJd6FvHsTBQ9
	uKBox+1DR2mVQZdb/NZnONgrHmWBF7zeUz3VOX9X4OBJZW8WtCAbBugVlr+cUSt174De16LqPCN
	Mf2RjtmCXrkr0JIEItjxUp+mdcknvjJWwopxjJT1D9e9K4vcCC4FIX+MdB9cuhhlAcrYf9C5aM1
	7JC7xHL5ZSKLF1B8lCLQHCwlvw==
X-Received: by 2002:a05:6808:c3ea:b0:4ab:230c:5faa with SMTP id 5614622812f47-56b963a7115mr210675b6e.18.1794345826045;
        Tue, 10 Nov 2026 13:23:46 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504c276sm3229558b6e.4.2026.11.10.13.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:23:45 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 10 Nov 2026 15:23:44 -0600
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
Message-Id: <20261110-broken-gpe-legion-v4-1-3668ce0c2efd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794345824; l=6414;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=4fzh2Kt6hyJZoUipRYGxY1lLhGP5S0v640iNKn5d27A=;
 b=BreNeT4+5sRjWVoRkW2qHGfabP2EUtz4OE0rjq6itQKYCjr7cFCA+NpiP84bvcym91Vki98hM
 81kllDoWdsfCN/wa1RID/Ws+3CTH0kaYEW50aB9mvRfV9V82p0OPCD2
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

