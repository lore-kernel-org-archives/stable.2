Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A224B1284
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444363; cv=none; b=TM6GYwerCrIs8FtKLKTU/90bxlePC2P4TTr08r8mH5XnNwGnhMjmSuFcJJi05SjIOkJYySyGzKJhoDvLaLUfu2yKmJyAJSvkYOKiuDUezsLHTZl6kIJuhU1Bjm9p5ZTp6aETUc+jOrQRcoJ0Ljww32fe47/6VaiB+9COCzbllD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444363; c=relaxed/simple;
	bh=OdLAUH8hqAK0hkCfqoFqtov4g9N4eiawGn/7RAkcxG8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t7A+HYbcMkbW7EDLgOqpelTWhkSyp8T6rSQ6uJdRg68xIX1RjNCC+8WNHRO/nw1ALyVrd/YJKloYfcKSZKUzd5D+7GGaDRsI9ba9jjF16z7IEyYgT5Yhphj6nS2wjmWVXxaisSU2imYASSMnwc8PJJWEk+l3fgmRyI8vgeWsW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s81X8hfQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s81X8hfQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95B31F00A3D;
	Thu,  3 Sep 2026 14:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444360;
	bh=/ZBHYsfOlkDXJtJjwhq2czUafIXJW8hMSz17KlzqJhg=;
	h=Subject:To:Cc:From:Date;
	b=s81X8hfQkHd/J3Fbi5MwWFwP6kC9TxIoyGylQAcbEfTB9QOn8pG4cvWRoiUzvX3Za
	 DTkmmSU3EdYvoPL4664DHKYtZZZZUfnuTQ8FOy78eallMZkfuAJbTswBoeZLg5Quv2
	 XbbY7j/jbYwibpebRgztrx4ptdYQOiWyQsYnDFGs=
Subject: FAILED: patch "[PATCH] ACPI: TAD: Add locking around AML evaluations" failed to apply to 5.10-stable tree
To: rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:44:33 +0200
Message-ID: <2026090333-flogging-greeting-fc93@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a3df8bbe0a704fa5c1609b9666b594f350558fe0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090333-flogging-greeting-fc93@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a3df8bbe0a704fa5c1609b9666b594f350558fe0 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 5 Aug 2026 20:53:32 +0200
Subject: [PATCH] ACPI: TAD: Add locking around AML evaluations

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

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index fc43df083738..45459a4cafae 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
@@ -86,6 +87,8 @@ static bool acpi_tad_rt_is_invalid(struct acpi_tad_rt *rt)
 	    rt->daylight > 3;
 }
 
+static DEFINE_MUTEX(acpi_tad_aml_lock);
+
 static int acpi_tad_set_real_time(struct device *dev, struct acpi_tad_rt *rt)
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
@@ -113,6 +116,8 @@ static int acpi_tad_set_real_time(struct device *dev, struct acpi_tad_rt *rt)
 	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, "_SRT", &arg_list, &retval);
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
@@ -124,30 +129,27 @@ static int acpi_tad_evaluate_grt(struct device *dev, struct acpi_tad_rt *rt)
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER };
-	union acpi_object *out_obj;
-	struct acpi_tad_rt *data;
 	acpi_status status;
 	int ret = -EIO;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_object(handle, "_GRT", NULL, &output);
-	if (ACPI_FAILURE(status))
-		goto out_free;
+	if (ACPI_SUCCESS(status)) {
+		union acpi_object *out_obj;
 
-	out_obj = output.pointer;
-	if (out_obj->type != ACPI_TYPE_BUFFER)
-		goto out_free;
+		out_obj = output.pointer;
+		if (out_obj->type == ACPI_TYPE_BUFFER &&
+		    out_obj->buffer.length == sizeof(*rt)) {
+			struct acpi_tad_rt *data;
 
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
@@ -193,6 +195,8 @@ static int __acpi_tad_wake_set(struct device *dev, char *method, u32 timer_id,
 	args[0].integer.value = timer_id;
 	args[1].integer.value = value;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
@@ -215,6 +219,8 @@ static int __acpi_tad_wake_read(struct device *dev, char *method, u32 timer_id,
 
 	args[0].integer.value = timer_id;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, method, &arg_list, retval);
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -416,6 +422,8 @@ static int acpi_tad_clear_status(struct device *dev, u32 timer_id)
 	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, "_CWS", &arg_list, &retval);
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
@@ -456,6 +464,8 @@ static ssize_t acpi_tad_status_read(struct device *dev, char *buf, u32 timer_id)
 	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, "_GWS", &arg_list, &retval);
 	if (ACPI_FAILURE(status))
 		return -EIO;

