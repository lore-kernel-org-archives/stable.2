Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB82F1EF39E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973209; cv=none; b=QnjGE1TvNyW/5dk3jnI53NMHUjWO1BMXFVnhsemsDFI9BJe+UMelVk+4w86cIH86FIypv9Q4JC8dCRmFWYCaeOuE5ldA0k4Ad5VRrsDpB4Hi/QKlYiNhbTcgddw0VKOCB7t6Obfx68ICfpdVneLqGzzoHGvGIH8kFQKJbdjWWYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973209; c=relaxed/simple;
	bh=9SuSTpl6uiXoOaxWTaUCVbkg7ZdrOdwOPY3vag+7ZXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnauwGhTBtfo81crd5JiyfjIMOlChoMpQ8jtGzhc9gU4Zks7fJ6kJ9r2V5GeljlrCXupkcLBCQKQQB/UmczSV9xCnHMf00oPysDVZBqPvWQKTMwfeDFdlWChU/VPlKqBpTZoccgTrE1KKUvQaeg/1SnwgeoqZNsPE8GIDmU4YMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne/wzajn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne/wzajn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC1A1F00893;
	Wed,  9 Sep 2026 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973207;
	bh=WkcBPLUVdG/vEYmRlMQxQlQLfdmUjqSWVbocg+TdPIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ne/wzajnlYj/RkC5a4VSbINhXeo/j7MKgy/owgHXf1GeqZvA1TDIfz++oCeHeQRUE
	 Jb7iGGbnTVe4BwPeFV/6AftHVmbAHXjVhLwOHKsdr9x08StL9LG99/h80IU3XOUGsN
	 UQ1UYaCB3jD6b/HhTZGRczaxovRZNX+QePukAnQdXAGNyGkXLi2lgPY4lS+1sO1vlA
	 SfhThmsT9ND/qvDYWUaiX57iOzCZFSzVlL4Pv9OLf97g2Uy5PAbb9lfBxXHxuBdVum
	 Lh+7Rlzhh9qpw2F0FYGllIkb/2PQ2oYDUkASibdLyxsM1ZnoQePE1VhwzIy18raXjL
	 yCT+HcZnBIt5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] platform/x86: intel_sar: Check ACPI_HANDLE() against NULL
Date: Wed,  9 Sep 2026 13:00:04 -0400
Message-ID: <20260909170005.3157069-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-subprime-ruckus-2c80@gregkh>
References: <2026090358-subprime-ruckus-2c80@gregkh>
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

[5.15 dependency preparation: Keep the ACPI handle check before allocation.
Provide driver-local kzalloc_obj() and kmalloc_objs() macros using the
existing GFP_KERNEL allocators, and align the two allocation call sites
with upstream. This preserves the allocation sizes, zeroing and array
overflow checking without importing the newer slab helper implementation.
Use the existing .remove_new callback for the void sar_remove() signature.
These changes allow commit 30c906cff490 ("platform/x86: int1092: Fix
potential memory leak in sar_probe()") to apply unchanged while keeping
its managed-allocation and error-unwind changes in the target commit.
No new functions are introduced.]

Stable-dep-of: 30c906cff490 ("platform/x86: int1092: Fix potential memory leak in sar_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/x86/intel/int1092/intel_sar.c    | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index e03943e6380a6..011b2deacce80 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -6,9 +6,14 @@
 #include <linux/acpi.h>
 #include <linux/kobject.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include "intel_sar.h"
 
+/* Local compatibility with the type-based allocation helpers. */
+#define kzalloc_obj(obj) kzalloc(sizeof(obj), GFP_KERNEL)
+#define kmalloc_objs(type, count) kmalloc_array((count), sizeof(type), GFP_KERNEL)
+
 /**
  * get_int_value: Retrieve integer values from ACPI Object
  * @obj: acpi_object pointer which has the integer value
@@ -91,8 +96,8 @@ static acpi_status parse_package(struct wwan_sar_context *context, union acpi_ob
 	    item->package.count <= data->total_dev_mode)
 		return AE_ERROR;
 
-	data->device_mode_info = kmalloc_array(data->total_dev_mode,
-					       sizeof(struct wwan_device_mode_info), GFP_KERNEL);
+	data->device_mode_info = kmalloc_objs(struct wwan_device_mode_info,
+					      data->total_dev_mode);
 	if (!data->device_mode_info)
 		return AE_ERROR;
 
@@ -246,15 +251,20 @@ static void sar_get_data(int reg, struct wwan_sar_context *context)
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
@@ -293,7 +303,7 @@ static int sar_probe(struct platform_device *device)
 	return result;
 }
 
-static int sar_remove(struct platform_device *device)
+static void sar_remove(struct platform_device *device)
 {
 	struct wwan_sar_context *context = dev_get_drvdata(&device->dev);
 	int reg;
@@ -305,12 +315,11 @@ static int sar_remove(struct platform_device *device)
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

