Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0856C63E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971231; cv=none; b=qMWdSV6cBnnoO2eS1LAk0mh7StTrWFaMUdnXl6RwrNgRf/+xuD26N6pmBcV/zSFFD+K9A/TYkroGKh7GUlg2xbpYhsCWNKlkpLMjG2o7dPMyIdoYDD7V07rgaa6Rfp11uyF2PoNSRj1umOIAoOQYz04U4uITH0d6ec/u6gHXciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971231; c=relaxed/simple;
	bh=AdOULvcQvFjVi1vuiMdziG8S7k+HUsjrGiV8MiB85qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHcRvy7r36vsHNt6y4cN9oGUWc30bTNte/GlrLKl145qdaesldx71BFWpW/I8Gqy6ObiyceOHOhTDyjQuWN/bXY64MfwRgJBcQRgLNxVlAS8qWr238vbeYETrM71rvUapRlZdmFfBpJcznsYI3d5AVydme6v9LIGDW2rFGJjUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTkrY6YH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTkrY6YH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE01F1F000FF;
	Wed,  9 Sep 2026 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971230;
	bh=kBmtyg9fIYUljPAJdhQ0ttbO/+xFsNep2aQ2u/L31qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TTkrY6YHMCsuCrKUMB5xTEofeNNeNLw+YjLjLHWCIFzN0ZhefDMmSvir9NN2t/td7
	 +DeYQGbRIVPZqpjpLUjy3aCWDPZUrhlcs/YN5dXhn1/ePzJ9GxDFoPtFFnJxtA7vAU
	 d/IkqC0J40TYcSgw9wLLGb5NnW6TfN4zunC7kJbvRNcS3AIpLBc1CRr/AuDW4haIDZ
	 83l+fXX61EEvoQ61MkJ4xjbZHnSNjneNkJJyiCaoS1+gL+4CEBjXCETckP1Dh1Zddi
	 xDkFtM7nwPygo9AMZ0gbAMvSX9P6Mb1WkmnVGAENsivuIu++Ac74PQA3n/FPdSqNlD
	 nB3gv9wYooJXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] platform/x86: intel_sar: Check ACPI_HANDLE() against NULL
Date: Wed,  9 Sep 2026 12:27:06 -0400
Message-ID: <20260909162707.2982951-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-venomous-devotedly-9b77@gregkh>
References: <2026090358-venomous-devotedly-9b77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 2765f16c12af7c2533763e46b8113b727354012d ]

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add a requisite ACPI_HANDLE() check against NULL to the
platform/x86 intel_sar driver.

Fixes: dcfbd31ef4bc ("platform/x86: BIOS SAR driver for Intel M.2 Modem")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/14023870.uLZWGnKmhe@rafael.j.wysocki
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Prepare this Linux 6.1 tree for the target sar_probe() memory leak fix.

Keep the ACPI handle validation and reproduce the allocator spelling
expected by the target with two driver-local macros backed by kzalloc()
and kmalloc_array(). This preserves the existing allocation sizes,
GFP_KERNEL flags and array-overflow checking without adding functions or
backporting the newer slab API across the tree.

Convert the existing sar_remove() callback to void and register it through
.remove_new, which is available in this stable tree. This matches the
target's removal context while retaining 6.1 platform-driver compatibility.
Keep the stable ACPI DSM parsing unchanged. These preparations allow the
unmodified target patch to apply directly and retain its complete managed
allocation and error-path cleanup changes.

Stable-dep-of: 30c906cff490 ("platform/x86: int1092: Fix potential memory leak in sar_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/x86/intel/int1092/intel_sar.c    | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index e03943e6380a6..50495c3855474 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -9,6 +9,10 @@
 #include <linux/sysfs.h>
 #include "intel_sar.h"
 
+/* Compatibility with the object allocation API used by newer kernels. */
+#define kzalloc_obj(obj) kzalloc(sizeof(obj), GFP_KERNEL)
+#define kmalloc_objs(type, count) kmalloc_array((count), sizeof(type), GFP_KERNEL)
+
 /**
  * get_int_value: Retrieve integer values from ACPI Object
  * @obj: acpi_object pointer which has the integer value
@@ -91,8 +95,8 @@ static acpi_status parse_package(struct wwan_sar_context *context, union acpi_ob
 	    item->package.count <= data->total_dev_mode)
 		return AE_ERROR;
 
-	data->device_mode_info = kmalloc_array(data->total_dev_mode,
-					       sizeof(struct wwan_device_mode_info), GFP_KERNEL);
+	data->device_mode_info = kmalloc_objs(struct wwan_device_mode_info,
+					      data->total_dev_mode);
 	if (!data->device_mode_info)
 		return AE_ERROR;
 
@@ -246,15 +250,20 @@ static void sar_get_data(int reg, struct wwan_sar_context *context)
 static int sar_probe(struct platform_device *device)
 {
 	struct wwan_sar_context *context;
+	acpi_handle handle;
 	int reg;
 	int result;
 
-	context = kzalloc(sizeof(*context), GFP_KERNEL);
+	handle = ACPI_HANDLE(&device->dev);
+	if (!handle)
+		return -ENODEV;
+
+	context = kzalloc_obj(*context);
 	if (!context)
 		return -ENOMEM;
 
 	context->sar_device = device;
-	context->handle = ACPI_HANDLE(&device->dev);
+	context->handle = handle;
 	dev_set_drvdata(&device->dev, context);
 
 	result = guid_parse(SAR_DSM_UUID, &context->guid);
@@ -293,7 +302,7 @@ static int sar_probe(struct platform_device *device)
 	return result;
 }
 
-static int sar_remove(struct platform_device *device)
+static void sar_remove(struct platform_device *device)
 {
 	struct wwan_sar_context *context = dev_get_drvdata(&device->dev);
 	int reg;
@@ -305,12 +314,11 @@ static int sar_remove(struct platform_device *device)
 		kfree(context->config_data[reg].device_mode_info);
 
 	kfree(context);
-	return 0;
 }
 
 static struct platform_driver sar_driver = {
 	.probe = sar_probe,
-	.remove = sar_remove,
+	.remove_new = sar_remove,
 	.driver = {
 		.name = DRVNAME,
 		.acpi_match_table = ACPI_PTR(sar_device_ids)
-- 
2.53.0

