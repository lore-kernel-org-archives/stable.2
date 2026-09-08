Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793F33344A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883720; cv=none; b=KnkkVO9QPKf8ehdSkbcs6PKzVipbsxN/xgFfEd05H+ZVe45FHtPmhmT4k/XbRkvMloa9k6PpbKIN8gY2E8Vr/dUT711PzLW5lObPykYEckXJfjxSe7Yi8pJclVEyE1pCDKlg0eU38dIq7kOHIPVXXrb3Pen/j+aCCKN8fmML1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883720; c=relaxed/simple;
	bh=fwJVZK9xuLHslPip3uoJru+zgd8K1OULmtfdZ9KYeWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3WZeQsvyi1dhxLZpa8kUqkv+sIZVB2JYLrO9296TnzC8xte5kNTcF3bol1ZlWfu6U89KV3FH+VnlWHKJdNU3rvQ5X0gpYIa8nH0J/DDbRuIreZ0qxvlMydeScco1tRMYw3kljL/XpxmtScVd9bnn0nKLEO4ZsI3lL4Begi7hj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEPsRj1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEPsRj1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC311F00AC4;
	Tue,  8 Sep 2026 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883718;
	bh=grL0nV6MAG3Cjng+VLvQ11eTckepsTu5Aq7CWWuAmeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dEPsRj1e2OcUv47OC5u7OQ5Y0fWVBlrlZ8Re+VGtHpLcZpd781ycE+E1T25Y1izcP
	 HKLF9SkelbaqrfG0bGECjIr8M5POYXNaJXCB8kZlK1vALhOAUofg8YfN90YiFYiNU0
	 aEZatD7TfSxIyCBnhfTgoTspo0O6XGAcw9X3oWNcF2ZQhUWRhUj0xXXyi8o/hHiYfI
	 7/N9RqGddHN3RV2Ut64giMEbhqJcqYdUx1ED2jpAHVFN7Oi3MSF185E0d6hT9xMrzq
	 9oP7XHUH5ACuyoYqyEo1YXO0IiV9J4dtmqMB6w22IW6ipH3D3hnLY0WA1PPR3PM8wm
	 Zg/Vc65Se/bzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] ACPI: TAD: Add locking around AML evaluations
Date: Tue,  8 Sep 2026 12:08:33 -0400
Message-ID: <20260908160833.2575733-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908160833.2575733-1-sashal@kernel.org>
References: <2026090332-delighted-felt-tip-2059@gregkh>
 <20260908160833.2575733-1-sashal@kernel.org>
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
index 8fb892424cfb2..ca0d5640de052 100644
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
@@ -79,6 +80,8 @@ static bool acpi_tad_rt_is_invalid(struct acpi_tad_rt *rt)
 	    rt->daylight > 3;
 }
 
+static DEFINE_MUTEX(acpi_tad_aml_lock);
+
 static int acpi_tad_set_real_time(struct device *dev, struct acpi_tad_rt *rt)
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
@@ -100,6 +103,8 @@ static int acpi_tad_set_real_time(struct device *dev, struct acpi_tad_rt *rt)
 
 	pm_runtime_get_sync(dev);
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, "_SRT", &arg_list, &retval);
 
 	pm_runtime_put_sync(dev);
@@ -114,30 +119,27 @@ static int acpi_tad_evaluate_grt(struct device *dev, struct acpi_tad_rt *rt)
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
@@ -187,6 +189,8 @@ static int __acpi_tad_wake_set(struct device *dev, char *method, u32 timer_id,
 	args[0].integer.value = timer_id;
 	args[1].integer.value = value;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
@@ -209,6 +213,8 @@ static int __acpi_tad_wake_read(struct device *dev, char *method, u32 timer_id,
 
 	args[0].integer.value = timer_id;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, method, &arg_list, retval);
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -425,6 +431,8 @@ static int acpi_tad_clear_status(struct device *dev, u32 timer_id)
 
 	pm_runtime_get_sync(dev);
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, "_CWS", &arg_list, &retval);
 
 	pm_runtime_put_sync(dev);
@@ -466,6 +474,8 @@ static ssize_t acpi_tad_status_read(struct device *dev, char *buf, u32 timer_id)
 
 	pm_runtime_get_sync(dev);
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, "_GWS", &arg_list, &retval);
 
 	pm_runtime_put_sync(dev);
-- 
2.53.0

