Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1840C5C0
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788383799; cv=none; b=i8rvJyfhJQddCalnNHar8U1LZcvixRM7M+hmjWPkR0s3dIIiyJJlfnS2aMNbYYeY2h4mRrgpAGo3TCnPFhoRz/I/CG7UZXucgPkeOY2wT0EWz9v+tOjJnBIZ3citnrlUsLq2adHe+GNFv7yRafFEGx6RLhPVjS0cen6vn1B1Q3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788383799; c=relaxed/simple;
	bh=wfnSJYezHVptWVeIUjof3zlv6RSwe2Fg37Z2C7ov+lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inOCzOCi54IAJwoeihc5L60hCsNG4t/V710hF0dSUhcdj/fal/40hsQ5er7j07Vlqworbr3BPkqhghCdjL7zIjBTBCzeMybHBMgj86ubNII8NOLfM+/v7zxdwJ297lAQ9afB24HZyeWD85T0146Up3EjuvMkEuj+5TTMBNuSy7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sL037w78; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sL037w78"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso16647525e9.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788383787; x=1788988587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2FbcCt4oC+dx3pyx/2hfw60zNfjrZFxgpFIvEM7YZ4k=;
        b=sL037w78EfLtX83d48XFST46TUQBI4pC9WiKm8SEvhi0ZU1VLy8g9xKN6+SckUtVD9
         rHyx9dUNDCC4O14YkT2UbNEXsW5h2IxZVxQtdKsARE76204jgm8b2H33dojq5wbpxTWd
         TCX4TipTvOGEQ3Gx1uaWCFVD19OFLNlA/v5gmAoeF8Jg+27wfTwT5GywBhBQeV5/11Gx
         JPhkQy8Gh+GEKrQHou31UWGlwuvQqc5KQVlYbnHJJ0b8PYA+7QPWHQGpk77qgyZZvLOo
         vyUNeZXqNLVcDWEceXVJkdArwLQaDCQKPCdpCPM1KuFoo0tBZieA320/Fsa2uT+jVxLc
         9yjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788383787; x=1788988587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2FbcCt4oC+dx3pyx/2hfw60zNfjrZFxgpFIvEM7YZ4k=;
        b=Zb4xMMm1g6H++9+84FKsbK995KXsODbcoKc92Kg0JQj/4vS3MSeFkUDjfcrLh1+Rb9
         r3E5yyY7la5ngZ2aUxTA8NxQecbZmUtYFQr05ei3Vp5sLq1enyH7dYaniVZgUCezyY98
         9LpHjltTVfy2kyoPPi5G7shohuq2stsWdNL5GSHxSgw88w8C4d/aIWCbPhtUKNJg1t1K
         I8HMSwZv0JN0UQOw1QAFxA8+/tCpwQg8rOEQWLpJjV4hXtLrNuCUQFvfhVihVgVVfwQh
         7gV8LeiArxFlj3Ny3KIdV+cSe4R86FjxOzuvXj96HwfGd1dvgWId46lsrU7pHFm0I0Sb
         5VZA==
X-Forwarded-Encrypted: i=1; AKwUvByPI7V0UnftvWtSOKFotkYf+ELgNY/V0VW4UqDouCJZivtGYVSyjiRB2lUNO66EfFhwnTwS0yY=@vger.kernel.org
X-Gm-Message-State: AFuF++lM4DiZyrFzre5kAIc2VcokIgbr3GbY9a5ehmpsw8R4UZTWbact
	7o3iK760E86zY5P+xDe2VWVYGM4IMl7mDBLIgTVqscUUSZzufQP/uFM=
X-Gm-Gg: AYBFou38oQVzL7B5I1VDECEDfxwdrEDw6IfkmXBVL8pVjXN5dldV+r9lO4zfA9aqtlC
	jlmo8T6z0l6ENiG3wtK+opn30Y53TR3kfPUiHNYN9ExkYT8LCfAmeJOmIsr0axkw8pfnh4ketyo
	im7P7hwZEbRItNeexeCvOvZXuxb7gVXl3ICUeNQFBetddvDFcztWQ4k5mdFI4+neobVbrm4GkHE
	3ZR1vpHWjkvG/n0GhuYfK6tlNxaZCnB3eBoSuH0yg61BFOttHa6s546+ZcX2JIH0mgce9pQ+T4n
	cv8T8LlI0R/e1eb+YZlUzRXB6ZG2d5ifHPrvJqpSHf9fnFd+CgipQfChmkLY3wZ4fBTZI56S9qH
	OaNtUGXhO7r2IF/Dhx2qOoVfxVHkTnnlvaRo52FaQozjbsozLx68dlH3LK7mp1wTo1wsn5+M43L
	WDN8eXr4R3Sp17GqgsVmso9/sSVPKpACVBo7lrxoiP/AtRz6PdcU0PpSPDrzTxPNSi9742sfg5U
	5nxk+2wHoJFTu6EQo9tTgJAKNeos+T/3kJaiKASwdCimy7Dh9X8/9XrPreDK0+FHcUbFK4e/cBU
	EGJpM2HH
X-Received: by 2002:a05:600c:699b:b0:49b:9205:45b3 with SMTP id 5b1f17b1804b1-49ce584c6femr140872125e9.15.1788383786582;
        Wed, 02 Sep 2026 14:16:26 -0700 (PDT)
Received: from chateau.lan ([2001:818:e240:a500:b099:b999:e510:5bb4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d4938sm19143335e9.2.2026.09.02.14.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:16:23 -0700 (PDT)
From: Sergey Zagursky <gvozdoder@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Miguel Vadillo <miguel.vadillo@intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Sergey Zagursky <gvozdoder@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] media: ipu-bridge: do not use the CVS device lookup for IVSC
Date: Wed,  2 Sep 2026 22:15:24 +0100
Message-ID: <20260902211524.5572-1-gvozdoder@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit c6b1b34b5090 ("media: pci: intel: Add CVS support for IPU
bridge driver") the internal camera no longer works on laptops where the
sensor sits behind an IVSC, for example a Dell XPS 16 9640 (IPU6,
INTC10CF, ov02c10):

  intel-ipu6 0000:00:05.0: Found supported sensor OVTI02C1:00
  intel-ipu6 0000:00:05.0: Connected 1 cameras
  ivsc_csi intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da: mei-csi probed
      without device fwnode!

No sensor subdevice is registered, the media graph has no sensor entity
and userspace finds no camera at all.

ipu_bridge_get_ivsc_csi_dev() first looks for the platform device named
"intel_vsc" and returns its mei-csi child. That device is created by
mei_vsc, which on this machine only appears once the LJCA USB bridge and
its SPI controller have probed, about a second after the IPU6 probe that
runs the bridge:

  07:59:29.297  platform INTC10CF:00 created (ACPI scan)
  07:59:41      intel-ipu6 probe -> ipu_bridge_init()
  07:59:42.391  platform intel_vsc created (mei_vsc)

The commit above added two fallbacks for CVS which match on the ACPI
companion alone. They are reached for every entry of ivsc_acpi_ids[],
IVSC IDs included. The IVSC ACPI device has two physical nodes:

  INTC10CF:00/physical_node  -> platform/INTC10CF:00  (no driver bound)
  INTC10CF:00/physical_node1 -> platform/intel_vsc    (mei_vsc)

so bus_find_device_by_acpi_dev(&platform_bus_type, adev) returns the bare
platform device. ipu_bridge_instantiate_ivsc() then attaches the IVSC
software node to that device instead of to the mei-csi client, the bridge
reports success, and the probe is never retried. mei_csi later probes
without a fwnode, the CSI-2 link is never described, and the sensor ACPI
device, which has an honoured _DEP on the IVSC device, is never
enumerated.

Before those fallbacks existed the lookup returned NULL here, the bridge
failed with -ENODEV and the probe was retried once the IVSC device had
shown up.

Skip those fallbacks for IVSC devices, keying on the IVSC IDs rather than
the CVS ones: new CVS IDs keep being added, whereas the IVSC list is
complete. CVS binds a driver to the ACPI device itself, so matching on the
companion stays unambiguous there.

Fixes: c6b1b34b5090 ("media: pci: intel: Add CVS support for IPU bridge driver")
Link: https://lore.kernel.org/linux-media/20260901194526.6369-1-gvozdoder@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude Code:claude-opus-5
Signed-off-by: Sergey Zagursky <gvozdoder@gmail.com>
---
Changes since v2:
- Match the IVSC IDs rather than the CVS ones, as Sakari suggested: new CVS
  IDs keep being added (INTC10FA arrived after v7.2), whereas the IVSC list
  is complete, so keying on IVSC does not rot.
- Drop the ipu_bridge_is_cvs_dev() helper introduced in v2 and go back to
  the flat condition of v1.

Changes since v1:
- v2 wrapped the ACPI ID match in a helper for readability. Superseded by
  the above.

Not addressed here: separating the CVS and IVSC parsing so that no CVS
fallback is needed at all. That looks like a separate series rather than
part of this fix.

v1: https://lore.kernel.org/linux-media/20260901195036.7648-1-gvozdoder@gmail.com/
v2: https://lore.kernel.org/linux-media/20260902145440.1786297-1-gvozdoder@gmail.com/

The functional testing below was done with v1 on the affected machine (Dell
XPS 16 9640, IPU6 + IVSC + ov02c10) on top of 7.2.2, where
drivers/media/pci/intel/ipu-bridge.c is byte-identical to v7.2. v3 changes
which ID list the condition keys on, so it was rebuilt and booted again on
the same machine with the same results. Without the patch libcamera finds
no camera at all; with it:

  $ cam -l
  1: Internal front camera (\_SB_.PC00.LNK1)

  $ cam -c1 --capture=5
  202.794954 (30.05 fps) cam0-stream0 seq: 000003 bytesused: 8386560
  202.828224 (30.06 fps) cam0-stream0 seq: 000004 bytesused: 8386560

The media graph gains the entities that were missing:

  - entity 349: Intel IVSC CSI (2 pads, 2 links, 0 routes)
  - entity 368: ov02c10 21-0036 (1 pad, 1 link, 0 routes)

and the restored retry is visible in dmesg:

  pci 0000:00:05.0: deferred probe pending: intel-ipu6: IPU6 bridge init failed
  intel-ipu6 0000:00:05.0: Found supported sensor OVTI02C1:00
  intel-ipu6 0000:00:05.0: Connected 1 cameras

"mei-csi probed without device fwnode!" is gone, ov02c10 binds to
i2c-OVTI02C1:00, and eight v4l-subdev nodes appear.

This patch is against v7.3-rc1. The version tested on 7.2.2 is the same
change; 7.2.x has no INTC10FA in ivsc_acpi_ids[], which does not affect the
IVSC list this patch adds. Building with W=1 produces no new warnings.

Not covered: I have no CVS hardware, so the CVS path is only reasoned
about, not tested, and I have not booted v7.3-rc1 itself.

This patch was produced with the help of an AI coding assistant; see the
Assisted-by tag above and Documentation/process/generated-content.rst.

 drivers/media/pci/intel/ipu-bridge.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 1bb3a3e98d6b..bd64c0400c0d 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -232,6 +232,19 @@ static const struct acpi_device_id ivsc_acpi_ids[] = {
 	{ "INTC10FA" }, /* NVL */
 };
 
+/*
+ * The subset of ivsc_acpi_ids[] which are IVSC, rather than CVS, devices. The
+ * CVS IDs are deliberately not listed here: new ones keep being added, whereas
+ * this list is complete.
+ */
+static const struct acpi_device_id ivsc_only_acpi_ids[] = {
+	{ "INTC1059" },
+	{ "INTC1095" },
+	{ "INTC100A" },
+	{ "INTC10CF" },
+	{ }
+};
+
 static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
 {
 	unsigned int i;
@@ -283,6 +296,17 @@ static struct device *ipu_bridge_get_ivsc_csi_dev(struct acpi_device *adev)
 		return csi_dev;
 	}
 
+	/*
+	 * The lookups below match on the ACPI companion alone. That is fine for
+	 * CVS, which binds a driver to that very device, but not for IVSC: there
+	 * the ACPI device also has a driverless platform device, which would be
+	 * returned instead of the mei-csi client. Return NULL for IVSC so that
+	 * the caller fails and the probe is retried once the IVSC device shows
+	 * up.
+	 */
+	if (!acpi_match_device_ids(adev, ivsc_only_acpi_ids))
+		return NULL;
+
 	/* Try to locate CVS device on the I2C bus */
 	csi_dev = bus_find_device_by_acpi_dev(&i2c_bus_type, adev);
 	if (csi_dev)
-- 
2.55.0

