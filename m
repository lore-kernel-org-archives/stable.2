Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FB349CF1
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700086; cv=none; b=LKgW23TdE6fa1ZSiJs2SmYCT0EaWwJ73OlcJTENtffZgeiSgB/+aSbPXCo8lBz0M5csn0LdDunk4OQ0AGaQ6xYkypqlkcDAY/kwuVHwld/cqXVJBKfTkrNU6NN4cB0oYmIyd3xgGWK4/7emr7N+xJe+niL1UZC2O5ewDvgNUsso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700086; c=relaxed/simple;
	bh=8Jz0zTJFv4LZwhS5bpfSDVpX+SDt/XgkIvLSChMAgUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2SmsFC4OhIUi386hVFPQjTT6Kqd8AgMzOE9hBoseh5J+g9pPAeN5lT2SP+WhUf9L9b0TGNhdh/4rqnTDLfEefD5lxwiGIp09RbHhqqd7rjaqJIJmIOg2X51PSoiv2XzWlJ/uMuTfW/RHl7775C6+GZ0DgeuxhafrnvEjJzwLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFzUy4ZN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFzUy4ZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7381F000E9;
	Fri, 10 Jul 2026 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783700084;
	bh=0TBRz+xDVn0vflPETPHLsC2sHiEdmluiZtY8bQVl2ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QFzUy4ZND3a7XWpwH6K73d3FDUR+qJM3dNSS+/6+SFhCHjdDCEBR8xaGbrhDeXZrQ
	 sNU3egnOJmscIHzJ9tYNt4zPdJv+lzRklwEL2XbLm90J2JpugFthBXM3dhXHn7zTVG
	 i4RiBcm/93kH1nAmUhvw/1lxTXjpNHwB/C4bscx1FUL//L8b97RlF7vP5AczB4JuUp
	 AomN2VdGpOgR5qxZXC3CphkKPV2cjzdj3IQ2A6d56Pcqna1U4/Snj7wnkfRIH4yzxk
	 wc84eI4akM8tvPtQldlRpDIOiseub4XRAhdiZauh/vbXn5FaqmFxDTa6JoTolQSbaW
	 rV/GGoONYs5TA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] ACPI: driver: Check ACPI_COMPANION() against NULL during probe
Date: Fri, 10 Jul 2026 12:14:38 -0400
Message-ID: <20260710161442.293558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070931-shakily-implicit-64be@gregkh>
References: <2026070931-shakily-implicit-64be@gregkh>
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
index 7c5b040a83e8d6..71ccd07366226c 100644
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
index 42b7220d4cfda7..3207f3f536dbe4 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -427,9 +427,13 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
 
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
index b75ceaab716e80..3ceec703548b13 100644
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
index 998264a7333d6e..717361da420195 100644
--- a/drivers/acpi/pfr_telemetry.c
+++ b/drivers/acpi/pfr_telemetry.c
@@ -363,10 +363,14 @@ static void pfrt_log_put_idx(void *data)
 
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
index 35c7b04bc9d302..4aa179ca82c70b 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -505,10 +505,14 @@ static void pfru_put_idx(void *data)
 
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
index 125d7df8f30ae2..4f213486e6f96a 100644
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

