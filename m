Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB14483B9
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292301; cv=none; b=sUkH8zYES+cmCYuFnlJ7878E9yGuPnJqOInElrlWw2qVEguKDMKaz5RFAHkfHkHlzs75t5EoAi66KK3wT0Uvd+HmoQFU2ex+3JWZ/0Hz3C+7LexhlvBhrWVjRuwlqalGk4jJglA7F2Sj4AkdrS5y0qOFddN6lJzwLWQxNsr/IxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292301; c=relaxed/simple;
	bh=jngS6x+tIf4czuIBq+LweYf0mEUL/modiUynUQ9e7Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJPlluqoEwFkqyq/IQSc2HNfNGUFiYQNcI4hCRErgcAWD49X9HfMn2/mEBB6WgeSVL2uA5SGlzzT0uVuQ0dmhfQCWpfFWAnq7ulUxfT0+8tDyTnL3nsaxrBmo2cIj4he6sRLa6Xql3FfGTP6fUeJ6RSV8+XeIfyoEtdfH4/d13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICd/UeuP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICd/UeuP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso1774695e9.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788292297; x=1788897097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6xYO5+e2rLJr7nQr6IUR30t9mLQPc96NvTA35d5T/wc=;
        b=ICd/UeuP2/+rdRQMeAR884JF6BdAwGHiGEU2hEcYaF5cdmsytMZ6upS2FbK8Zzjf5I
         HI0a40LqUPO/IC9AMmKeNfPj4JCOUrtvuWZIvm9oblUKMOtsH0Hdr+99TPJwDyXQTpja
         Yqr/8AxORd/bjiCv9UyHpiqlzW+5ytkSOkOXzMd4iTBaY3xQqS5LGNLWW50TTHQB6PnW
         LRZCSe8gEU8eOXOQLdjpBHPe5pzNdnE/6t9c1XaXxdwY+/aOvRD199z7sx2UI5/FP6w8
         L1oCaLsjCAq6jRFy9PV8QlaNXj/q+cJWs4kxHvxOSCw9tKRFeE7rnrPPJsklL3qe2T41
         38KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788292297; x=1788897097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6xYO5+e2rLJr7nQr6IUR30t9mLQPc96NvTA35d5T/wc=;
        b=WlxoNYtYUUV7qJITs9j/ss3lbCaSgAqDHhmmOe3roe4alU4t/Z8QndG2nwkSViAvbS
         kPGEkj9v2bQztLU3LkMlR6JzeUTBggYcrTEjXBTRAXIoB3gBp+gf2BCHb4g7djMAMCtc
         gXgYb1R6Ii5hLD67mUt63IllIvHnGdCKQkxZf5hVawZYSl0Zb0oRv84yZuNFr8SijRtG
         wdUPcuX1tCFNMCPwMt1evgT6lgmAoaVup6DtAn3aUrLBs1S7heZIu5mZWYundgjzrbfR
         1NreGACdgl1wxAKf7Wx6NcTBqXDA7JKi4XBqvAPS3KX1PvvQy0+sx6jAahHl6Rs6WnDu
         T3YQ==
X-Forwarded-Encrypted: i=1; AHgh+RogDKbHSVfNH/GS4nDmYv1XBIa5S7o6pOQq4sPsu6jqblbCva+zSLPD8miWddWUiKscqZCVBCE=@vger.kernel.org
X-Gm-Message-State: AFuF++lsgiEDBNfeXQl65qS/WsPZbrctSuFkHagFOPyWwLom5611Nsfl
	QI3MHRIO1nnTHMkqVtVDtSGBdM6FEhGQ0+sb7w0HF1w8tC/jSEdiOdU=
X-Gm-Gg: AR+sD11LF6cHD3tFostT6ejT1Z2F2nTmeylQqamx28GGmdmUd02G9WMlD9ZVH5+qUY4
	Qk+CEd2nM2U2M7JCUPXwFRO9QB9rrL2AMN1B6QI00fp7Q/2zwSHe9gEPQp5cLnlByplc7yetCkf
	Dqezg4FS5AuqVfItwgUCP1MROIZC11GDXYnJJ1St9okhUiPhhYP64nXA8NyMiuBKOZK2wAWxlTK
	Mu41ri+IR521r9I+G5RaR0L8zXA9D5ElrcVwuxTaCJVKnp3Jx5NPocE03tjv/0ofg49olovpG8H
	aeVrWZZzue+bPIQWF5GM6Ob/CPalO3+F25r7pIwfv3abcGG6+H+WEFXMPz4qCuY3l+fEp9KHKhL
	NVRjwkd2skKohRwMhBkBf5r3M4zgfu97gfEL6nudtzGmR+tfNSLHlUKV4edx/pxjdaTBKFgsczq
	5/ij9fpYk8dD1jTK3yob1mGvcb18qr+qACUyNFKjyKb1sIaC1HRQmIhttMjODCGnJ+xzsGPDS2J
	m3yPFNDFlCJci3Pt5n6s+teono+0z4MbIB3Fn6Dh0Lgz99g2KNP3pniiZjX+GOP9o8SVEVpOA==
X-Received: by 2002:a05:600c:a086:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-49ce5815dddmr66415e9.11.1788292297027;
        Tue, 01 Sep 2026 12:51:37 -0700 (PDT)
Received: from chateau ([148.69.202.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce4761dd1sm5567285e9.0.2026.09.01.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:51:36 -0700 (PDT)
From: Sergey Zagursky <gvozdoder@gmail.com>
To: Miguel Vadillo <miguel.vadillo@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Sergey Zagursky <gvozdoder@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: ipu-bridge: do not use the CVS device lookup for IVSC
Date: Tue,  1 Sep 2026 20:50:36 +0100
Message-ID: <20260901195036.7648-1-gvozdoder@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901194526.6369-1-gvozdoder@gmail.com>
References: <20260901194526.6369-1-gvozdoder@gmail.com>
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
Tested on the affected machine (Dell XPS 16 9640, IPU6 + IVSC + ov02c10) on
top of 7.2.2, where drivers/media/pci/intel/ipu-bridge.c is byte-identical
to v7.2. Without the patch libcamera finds no camera at all; with it:

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

Not covered: I have no CVS hardware, so the CVS path is only reasoned
about, not tested, and I have not booted v7.3-rc1 itself.

This patch was produced with the help of an AI coding assistant; see the
Assisted-by tag above and Documentation/process/generated-content.rst. The
bug report this replies to describes what the tool did.

 drivers/media/pci/intel/ipu-bridge.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 1bb3a3e98d6b..2c3b9efb0b2f 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -232,6 +232,15 @@ static const struct acpi_device_id ivsc_acpi_ids[] = {
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
 static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
 {
 	unsigned int i;
@@ -283,6 +292,17 @@ static struct device *ipu_bridge_get_ivsc_csi_dev(struct acpi_device *adev)
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
+	if (acpi_match_device_ids(adev, cvs_acpi_ids))
+		return NULL;
+
 	/* Try to locate CVS device on the I2C bus */
 	csi_dev = bus_find_device_by_acpi_dev(&i2c_bus_type, adev);
 	if (csi_dev)
-- 
2.55.0

