Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CC9437123
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698434; cv=none; b=sDqzxlJ8/fnQaXYpi2P7UTSxqY82BRST6ccq7SeIFgo/eS27lltZEHwtZoO96W+NqcGzGHTvhmf93ukKNSuoYOFGQkB7lToZgLGWLAHJLXJRWgwkBBkGxDvtC2qLKYwVD9l4OYnPQkSfxCs6LSV8Lh9b4C6WidkVSNh+lwPJNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698434; c=relaxed/simple;
	bh=p0dCfBGGWQED9XM7FNml7ayTxCteFVgTXqdu1eu1Nvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJrfYbzHQDPtVk+ZcPCQ4HGY8XpU5TGtNUtiGYQX6m9l73XLiC1XvPsNNRO0aj1QDloYk9kt2+WQVtpCAUz3t2GsP5CWssGMqfFkAWUbYsWgPMSfBMJU5RM++lZD5/VFXp+NF8b2JJA64QZuNUCABmUo6Nuiu58HmXua8zLh1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0ZdezDd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0ZdezDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBC81F000E9;
	Fri, 10 Jul 2026 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783698432;
	bh=y7WwfTIkM+f07jflvVRsbXNfDhAJVE9xfxmtRdDBwL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I0ZdezDdDY0KPDV/nm9Plb0GXJxWnwtJQngIs0nKdd2Q5kNXJQzh1FslE9uTGUiGQ
	 d95BinrSijRkaxb3qH3aekk0CEGblvX//UiFTlB/IQXRJlaO95YBNvmrao24NvDMvd
	 l8rbZke4EEokHox03E+6VS5JgHbZNkWlRWs7VhkYqLoCK7yTpz1dfuxiUnRHlzGpEl
	 HYTgwIPMmmCnuIlIAkg+G3y3pOxq0CiAEDxolby1CBQCRe3sJPIhO1OTFMP7y5yAPZ
	 6b/CRcIAmBRG1adQDIakdvdIwkWoXcDoI9BJqZZTCNYz8wtLnr+DdpK3AXeJ/FbGTI
	 tTY91MeZ5ZHgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] ACPI: driver: Check ACPI_COMPANION() against NULL during probe
Date: Fri, 10 Jul 2026 11:47:06 -0400
Message-ID: <20260710154710.286956-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070931-earmuff-spirits-26aa@gregkh>
References: <2026070931-earmuff-spirits-26aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit e4865a56d013e86e46ea6acea15bb6eae01898ff ]

Since every platform driver can be forced to match a device that doesn't
match its list of device IDs because of device_match_driver_override(),
platform drivers that rely on the existence of a device's ACPI companion
object should verify its presence.

Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
against NULL to 13 platform drivers handling core ACPI devices.

Also change the value returned by the ACPI thermal zone driver when
the device's ACPI companion is not present to -ENODEV for consistency
with the other drivers.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/4516068.ejJDZkT8p0@rafael.j.wysocki
Cc: 7.0+ <stable@vger.kernel.org> # 7.0+
Stable-dep-of: 18a00ed0e718 ("ACPI: NFIT: core: Fix possible deadlock and missing notifications")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ac.c            | 6 +++++-
 drivers/acpi/acpi_pad.c      | 6 +++++-
 drivers/acpi/acpi_tad.c      | 6 +++++-
 drivers/acpi/pfr_telemetry.c | 6 +++++-
 drivers/acpi/pfr_update.c    | 6 +++++-
 drivers/acpi/thermal.c       | 2 +-
 6 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 1f69be8f51a29b..8738c42a3ae40a 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -203,11 +203,15 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
 
 static int acpi_ac_probe(struct platform_device *pdev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	struct power_supply_config psy_cfg = {};
+	struct acpi_device *adev;
 	struct acpi_ac *ac;
 	int result;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	ac = kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
 	if (!ac)
 		return -ENOMEM;
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index c9a0bcaba2e4c1..dea7b2b4e54459 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -426,9 +426,13 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
 
 static int acpi_pad_probe(struct platform_device *pdev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev;
 	acpi_status status;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	strscpy(acpi_device_name(adev), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
 	strscpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
 
diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 33418dd6768a1b..fcebfa7d507f5d 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -588,12 +588,16 @@ static void acpi_tad_remove(struct platform_device *pdev)
 static int acpi_tad_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	acpi_handle handle = ACPI_HANDLE(dev);
 	struct acpi_tad_driver_data *dd;
+	acpi_handle handle;
 	acpi_status status;
 	unsigned long long caps;
 	int ret;
 
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return -ENODEV;
+
 	ret = acpi_install_cmos_rtc_space_handler(handle);
 	if (ret < 0) {
 		dev_info(dev, "Unable to install space handler\n");
diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
index 32bdf8cbe8f237..2387376832a1b6 100644
--- a/drivers/acpi/pfr_telemetry.c
+++ b/drivers/acpi/pfr_telemetry.c
@@ -360,10 +360,14 @@ static void pfrt_log_put_idx(void *data)
 
 static int acpi_pfrt_log_probe(struct platform_device *pdev)
 {
-	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
 	struct pfrt_log_device *pfrt_log_dev;
+	acpi_handle handle;
 	int ret;
 
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
+
 	if (!acpi_has_method(handle, "_DSM")) {
 		dev_dbg(&pdev->dev, "Missing _DSM\n");
 		return -ENODEV;
diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 11b1c282800525..6283105bb0e8b2 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -538,10 +538,14 @@ static void pfru_put_idx(void *data)
 
 static int acpi_pfru_probe(struct platform_device *pdev)
 {
-	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
 	struct pfru_device *pfru_dev;
+	acpi_handle handle;
 	int ret;
 
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
+
 	if (!acpi_has_method(handle, "_DSM")) {
 		dev_dbg(&pdev->dev, "Missing _DSM\n");
 		return -ENODEV;
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 8537395b417b0f..e5e970daca9e5f 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -789,7 +789,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 	int i;
 
 	if (!device)
-		return -EINVAL;
+		return -ENODEV;
 
 	tz = kzalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
 	if (!tz)
-- 
2.53.0

