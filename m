Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5C3FAE09
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870015; cv=none; b=C4FA1b1b4M8YZsrgNmE566Mqk+bp/gs8B1Iw84CErQnkNgIOwA5jDQgMBR9qjy57AE9ItTm7ZfY0iMgSU50dsOiOtoS4DZfF/Y7/F8WnJl9zWFKTAE8/t5LTbviZFSPqNsHm22kJ9pnRjtRfgB+6284uVCOSKhCVZU5S8/WaFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870015; c=relaxed/simple;
	bh=+Rng1H8Ztej0vKL0j2+pO7dqlUhnPUMEq7DsZDgm8Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOfezxzKyRJSkuoy5n7eF5dniKIbFjXPz/XUbX3N9aupStuAwtr3RqwdYF8mAR5dj1dAKXuRcM/r0ws79g7TN4K8gnfnhiTrrQiZgUU3GyVL3+CQGddre+dUooelYbcOeiGyAG5Ne4iOXu4w+ezvv+o0tkrAv9ypmdHecJZQRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6i5MjFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6i5MjFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F4A1F00ACA;
	Tue,  8 Sep 2026 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870010;
	bh=jEQk72Eqky2zFF3aogCq6CtMgzuBKVV5/ZK6ljcIe3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g6i5MjFEnFFD1HtkrRrHKKNpqN5HgfyV0qnDDjXgpjc7hb2BfKaCFZN5cFA/YQckt
	 +JMys4fu3KOVAUFzhP7q5TTq6OfE2fgRl6T60MCwIiAdxkEKOPtMIZwPa/4B9zfH+Z
	 g7s1IFOSQENSYAhva46Th1mU5TObRvEHr4fFoKXNMwJQROGRr3sFHbjoNBl8k8fOzP
	 5Iy0bTndvVAhRb62xkR0vLgZz1EdIjQHTapgQraWVbBseu2utumttH4f4z7aAVmKku
	 Zm0xUsaFi+I55qij+FJIeHWXAFeZz1n/xL6cRsnRRVDBwV6TCusR+qXpbZ4JvKDeKz
	 Ky5yZFd6jHIhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] ACPI: TAD: Add locking around AML evaluations
Date: Tue,  8 Sep 2026 08:20:04 -0400
Message-ID: <20260908122004.2049483-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908122004.2049483-1-sashal@kernel.org>
References: <2026090331-quartered-robe-d833@gregkh>
 <20260908122004.2049483-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit a3df8bbe0a704fa5c1609b9666b594f350558fe0 ]

In the ACPI TAD driver, there are hidden assumptions that the ACPI
control methods used by it will not be evaluated concurrently due
to ACPICA namespace and interpreter locking.

However, that may not be the case since ACPICA may drop and re-acquire
the namespace and interpreter locks during the evaluation of a given
object in a few cases, including the one in which the AML in question
sleeps causing acpi_ex_system_do_sleep() to be called.  In that case,
the evaluation of one control method may be started while the
evaluation of another one is still in progress.

For this reason, add a global lock to the ACPI TAD driver and
acquire it every time before evaluating an ACPI control method,
except for the initial evaluation of _GCP in acpi_tad_probe().

Fixes: 95c513ec84f7 ("ACPI: Add Time and Alarm Device (TAD) driver")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/12951141.O9o76ZdvQC@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_tad.c | 50 ++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 65f0a1c91d6f5..0d62a75a4b920 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -23,6 +23,7 @@
 #include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
@@ -80,6 +81,8 @@ static bool acpi_tad_rt_is_invalid(struct acpi_tad_rt *rt)
 	    rt->daylight > 3;
 }
 
+static DEFINE_MUTEX(acpi_tad_aml_lock);
+
 static int acpi_tad_set_real_time(struct device *dev, struct acpi_tad_rt *rt)
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
@@ -101,6 +104,8 @@ static int acpi_tad_set_real_time(struct device *dev, struct acpi_tad_rt *rt)
 
 	pm_runtime_get_sync(dev);
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, "_SRT", &arg_list, &retval);
 
 	pm_runtime_put_sync(dev);
@@ -115,30 +120,27 @@ static int acpi_tad_evaluate_grt(struct device *dev, struct acpi_tad_rt *rt)
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER };
-	union acpi_object *out_obj;
-	struct acpi_tad_rt *data;
 	acpi_status status;
 	int ret = -EIO;
 
-	status = acpi_evaluate_object(handle, "_GRT", NULL, &output);
-	if (ACPI_FAILURE(status))
-		goto out_free;
-
-	out_obj = output.pointer;
-	if (out_obj->type != ACPI_TYPE_BUFFER)
-		goto out_free;
+	guard(mutex)(&acpi_tad_aml_lock);
 
-	if (out_obj->buffer.length != sizeof(*rt))
-		goto out_free;
-
-	data = (struct acpi_tad_rt *)(out_obj->buffer.pointer);
-	if (!data->valid)
-		goto out_free;
-
-	memcpy(rt, data, sizeof(*rt));
-	ret = 0;
-
-out_free:
+	status = acpi_evaluate_object(handle, "_GRT", NULL, &output);
+	if (ACPI_SUCCESS(status)) {
+		union acpi_object *out_obj;
+
+		out_obj = output.pointer;
+		if (out_obj->type == ACPI_TYPE_BUFFER &&
+		    out_obj->buffer.length == sizeof(*rt)) {
+			struct acpi_tad_rt *data;
+
+			data = (struct acpi_tad_rt *)(out_obj->buffer.pointer);
+			if (data->valid) {
+				memcpy(rt, data, sizeof(*rt));
+				ret = 0;
+			}
+		}
+	}
 	ACPI_FREE(output.pointer);
 	return ret;
 }
@@ -188,6 +190,8 @@ static int __acpi_tad_wake_set(struct device *dev, char *method, u32 timer_id,
 	args[0].integer.value = timer_id;
 	args[1].integer.value = value;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
@@ -210,6 +214,8 @@ static int __acpi_tad_wake_read(struct device *dev, char *method, u32 timer_id,
 
 	args[0].integer.value = timer_id;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, method, &arg_list, retval);
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -424,6 +430,8 @@ static int acpi_tad_clear_status(struct device *dev, u32 timer_id)
 
 	pm_runtime_get_sync(dev);
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, "_CWS", &arg_list, &retval);
 
 	pm_runtime_put_sync(dev);
@@ -465,6 +473,8 @@ static ssize_t acpi_tad_status_read(struct device *dev, char *buf, u32 timer_id)
 
 	pm_runtime_get_sync(dev);
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, "_GWS", &arg_list, &retval);
 
 	pm_runtime_put_sync(dev);
-- 
2.53.0

