Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193A4A64CF
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361024; cv=none; b=mWRw5wY1G4p7cjMnBEWoziDxqCjQ1Rwu9l6DwOjjE1Xb196KCMkSUquAOOaeBDdzr3wPnJhmh5VU2WeAUneb/meKUimzoXeq/gCfgN60zwudlIhmBpmh3vnVBUALD9zz75XI3OQeaZ4yukplN172mFrnv7+B5Or6jvZ38rMgkfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361024; c=relaxed/simple;
	bh=YXYiQ6MlkwSY9s0/iRzorG5wwX8F6Ons+fpr1FTHCdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FI6/TcQjMnVRUDAlWNV7JtLHsW0jo2rV7pObgwyujXA8PzQGaHn2fFcELLSjxNgR+LL6pCQhPFVPwd8KNhDK2e+eHMuYI5GBNDFqjSiN5D9Irh+D4KF/M9AdRtMtGRAw04Z2OjctGmijHkFqQCAGer0RAviDZ+C8Fps3Geo2W+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng05+O7v; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng05+O7v"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so12819625e9.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788361019; x=1788965819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZKBfOg4ndfWf72OBMR4MzaBGR2UKb0LfrmxRQ5wr5p4=;
        b=ng05+O7vLEqirf+5pwkWz4sEc77tcKJTALKYq4rwr0kUqEI309d5lpke6vQF4rhdgH
         0edv06cHEY4TtsLK7+UVjCYjDYqTZgAIFl+UaWaMD/BKzavwRNFlyzTteTRbrek+Pu25
         lW/Kqq5SROXhiWH+XgfV3rwuOoc3R/3QxkKNwpmpB0eCtf+eOTheFTUnS60O5T8oLRuM
         pnFpiqYCvF1IC5BppWIpcNdg5c6os3UB3ZCM8HnWgGeuOgpmISzAD/2wM/fkpV7pa2Tc
         OgPhAURYyx0633GZ1OxDEvE2i5mYYYy4rM/TwVuKcsb362ENV+akpuW0UfBL4MN3JKR0
         qKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361019; x=1788965819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZKBfOg4ndfWf72OBMR4MzaBGR2UKb0LfrmxRQ5wr5p4=;
        b=ijLzV+P+f7j6rHTmm70Mdu2NPK9mq1N2FpIk+zfMj/CX1+9N8kAxJYPas73ZLe39j8
         LMG+fYxreWmCH71iweHaCTkqcBeUQLMpzD8mT3W/bFj7ewcn3UPeHtuWkJSaNRppnH23
         1E9K8EsSDcas4wf4naYSii4AipVfSeJ8zW7jf0CYgLO7HcVpqng9WIRj85bIY7YXVbBG
         9wPrdbX7qyZ5ZOrJMl/F4B1Coj2U1UySymfGYWAaMqyeQJaaGO404O9mjzB+apRDuYDp
         f1Tn+tbxx+EYNnEd8kqkMmtJbwZshg8YPJkbOTHCTVm4VGcxSdKU20GxbAigX9JSxOKx
         gIMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjNmU/KpZrLU2lLLehk3BKwSkYZTN37SeMtHVhks2zJzNMt1LDsAb3DD7KFkorizLZlHVK2Lk=@vger.kernel.org
X-Gm-Message-State: AFuF++k/PpT4Vo3c9JBXeMotgHeWB1APChRHT4kkTYUBj7cPAubUk9qF
	ZNWlPoM0O6K1koI5GPzXTajzoolt+c9AY7TEGYosf4Ww6VDyRtQw4P0=
X-Gm-Gg: AR+sD13e9MYCrIyxbXjO80TRxw4zcgtRugM+YxH+RSFf97KUa87jpGiSHVPFil1cvLj
	Nel8VkIu9aFKfh0eO6Xn9R/p3To5yHj2YxWvm/6InkhWDSpuy6psfKOvd9sORm+tVu06qhT+z5z
	2ZHfR8KuA+hgB8DDZUEw9QDMsX63hNZcYt5yeJ94G6Bn582hB9wendINPYLFjf5I5M8SFMUQBhf
	rngmXS2eVfg4pXJwvMmW24uqSQcuc2MyorT/ScsyIWZAxfaruRikjF1I/6FYABTPOni8gsw5N41
	M/2f51SVhDKSH5mbo1F7730cYEZ4Za9OLmst8dN8w+ohPtyJUAFpMhnkLqQ6FwWdWB14KeWWw7v
	GQmDufY9+3yIane+N5A3AGUhsLmhAORs56BOYIHyiY7LTwP0JNvbK1rKw8F/DVr/a/8Oeh+GzJo
	DD1G8/r3XJVTaoh4ANNZzrgfL5wlCbEdQqU55VidV7e6Adefz2G8Bbgu8NRI2tNZdB0vtLeBu7D
	BVA6GB9LLYGDNMSrjzOBgEeZI+W9J74js0CKACy6zC03Ch35D5hrqDWc9Ewbvn/SUBSvLj/
X-Received: by 2002:a05:600c:3494:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49ce57ee273mr106063775e9.6.1788361018773;
        Wed, 02 Sep 2026 07:56:58 -0700 (PDT)
Received: from chateau ([194.65.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5927b68sm61084215e9.1.2026.09.02.07.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:56:57 -0700 (PDT)
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
Subject: [PATCH v2] media: ipu-bridge: do not use the CVS device lookup for IVSC
Date: Wed,  2 Sep 2026 15:54:39 +0100
Message-ID: <20260902145440.1786297-1-gvozdoder@gmail.com>
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

Restrict the two fallbacks to the CVS IDs. CVS binds a driver to the ACPI
device itself, so matching on the companion is unambiguous there.

Fixes: c6b1b34b5090 ("media: pci: intel: Add CVS support for IPU bridge driver")
Link: https://lore.kernel.org/linux-media/20260901194526.6369-1-gvozdoder@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude Code:claude-opus-5
Signed-off-by: Sergey Zagursky <gvozdoder@gmail.com>
---
Changes since v1:
- Wrap the ACPI ID match in a named helper, ipu_bridge_is_cvs_dev(), so the
  polarity is readable at the call site. acpi_match_device_ids() returns 0
  on a match, which made the v1 condition easy to misread. No functional
  change.

v1: https://lore.kernel.org/linux-media/20260901195036.7648-1-gvozdoder@gmail.com/

The functional testing below was done with v1 on the affected machine (Dell
XPS 16 9640, IPU6 + IVSC + ov02c10) on top of 7.2.2, where
drivers/media/pci/intel/ipu-bridge.c is byte-identical to v7.2. v2 changes
only how the same condition is spelled, so I rebuilt it but did not boot it
again. Without the patch libcamera finds no camera at all; with it:

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
change without the INTC10FA entry, which 7.2.x does not have. Building
drivers/media/pci/intel/ipu-bridge.c with W=1 produces no new warnings.

Not covered: v2 itself is only compile-tested (no new warnings with W=1);
I have no CVS hardware, so the CVS path is only reasoned about, not tested;
and I have not booted v7.3-rc1 itself.

This patch was produced with the help of an AI coding assistant; see the
Assisted-by tag above and Documentation/process/generated-content.rst.

 drivers/media/pci/intel/ipu-bridge.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 1bb3a3e98d6b..a29d4bdb8f02 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -232,6 +232,20 @@ static const struct acpi_device_id ivsc_acpi_ids[] = {
 	{ "INTC10FA" }, /* NVL */
 };
 
+/* The subset of ivsc_acpi_ids[] which are CVS, rather than IVSC, devices. */
+static const struct acpi_device_id cvs_acpi_ids[] = {
+	{ "INTC10DE" }, /* LNL */
+	{ "INTC10E0" }, /* ARL */
+	{ "INTC10E1" }, /* PTL */
+	{ "INTC10FA" }, /* NVL */
+	{ }
+};
+
+static bool ipu_bridge_is_cvs_dev(struct acpi_device *adev)
+{
+	return !acpi_match_device_ids(adev, cvs_acpi_ids);
+}
+
 static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
 {
 	unsigned int i;
@@ -283,6 +297,17 @@ static struct device *ipu_bridge_get_ivsc_csi_dev(struct acpi_device *adev)
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
+	if (!ipu_bridge_is_cvs_dev(adev))
+		return NULL;
+
 	/* Try to locate CVS device on the I2C bus */
 	csi_dev = bus_find_device_by_acpi_dev(&i2c_bus_type, adev);
 	if (csi_dev)
-- 
2.55.0

