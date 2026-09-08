Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384233A6F1
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883285; cv=none; b=HhTKfBpOhkWU1+INt0S+u85JYZS92cleliOtO8UOZtFxssIWsV79LpSi/pvGDCCXYP1to1NH890VS8hCiTH4lrRQseB7iU0OhmtePGYVlHCYAKMNQ3uabY0zjvBuI6qVV2tQMX2qzV+xLrlDtCHkI/EjNd3wU57bNif5qDSmMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883285; c=relaxed/simple;
	bh=77evL9aH7TGzX9DJGgNBI36UnehicuGFx6bb3u5pYiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0/1kfnRDcLUGkHPiguIey2DWPH4sOKVED/IYCA+b0uLZfdYSQG9iKvIhXZ3unfqeA11ZrhQOZ9t6KtgD7jbAegtPPaScVk8IBJ2Q2zibJVFHnDterjaHb6Inoip/k0ooBKlUpIopUeDibdoCXxStNGcw4oAvlZN+T1ZPqmSZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCbFSHeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCbFSHeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0A81F00A3F;
	Tue,  8 Sep 2026 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883284;
	bh=LK+iyz4F5dfDsXUMu3taA38uD39t1Exsgk+nQ4kYbG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LCbFSHehZJVfYnoN27LDxBIY8Wy5mJnSbykrK0tnuj5FcJxJNjXYXktqAl0mCIli/
	 qbA6/yfkEYPknFSecj8OvwQF6tckoATAuwnITs9pM3JSb/DrCpyZTj88IKwAcGA9bf
	 UxgZWZdBP9aq7ahR2OaM88IAs/YPW69sn25llIHZb92XL8yHR7gOuaGHQEeCbXIqxM
	 AUXUNoDRHjrGHLSitIcuyivq/09ILe7XaCGq68Jm7yKGv8tvn54vZvS00SQW+FeES0
	 ro/H/HxeWRyGS1vgmnOVieqGOW+EzBVc+iKFL8M1Sd55SZB2kyxA4WiRofItSsqy7c
	 0ktLH0rVy87jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] ACPI: TAD: Split three functions to untangle runtime PM handling
Date: Tue,  8 Sep 2026 12:01:20 -0400
Message-ID: <20260908160121.2547470-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908160121.2547470-1-sashal@kernel.org>
References: <2026090332-yoyo-semantic-ad89@gregkh>
 <20260908160121.2547470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit b14b77bbea0a82cb66f1538824783e63d4128510 ]

Move the core functionality of acpi_tad_get_real_time(),
acpi_tad_wake_set(), and acpi_tad_wake_read() into separate functions
called __acpi_tad_get_real_time(), __acpi_tad_wake_set(), and
__acpi_tad_wake_read(), respectively, which can be called from
code blocks following a single runtime resume of the device.

This will facilitate adding alarm support to the RTC class device
interface of the driver going forward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://patch.msgid.link/23076728.EfDdHjke4D@rafael.j.wysocki
Stable-dep-of: a3df8bbe0a70 ("ACPI: TAD: Add locking around AML evaluations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_tad.c | 128 ++++++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index c634a7d99a088..6053c0cda822c 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -111,7 +111,7 @@ static int acpi_tad_set_real_time(struct device *dev, struct acpi_tad_rt *rt)
 	return 0;
 }
 
-static int acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
+static int acpi_tad_evaluate_grt(struct device *dev, struct acpi_tad_rt *rt)
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER };
@@ -120,12 +120,7 @@ static int acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
 	acpi_status status;
 	int ret = -EIO;
 
-	pm_runtime_get_sync(dev);
-
 	status = acpi_evaluate_object(handle, "_GRT", NULL, &output);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status))
 		goto out_free;
 
@@ -141,11 +136,6 @@ static int acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
 		goto out_free;
 
 	memcpy(rt, data, sizeof(*rt));
-	if (acpi_tad_rt_is_invalid(rt)) {
-		ret = -ENODATA;
-		goto out_free;
-	}
-
 	ret = 0;
 
 out_free:
@@ -153,6 +143,82 @@ static int acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
 	return ret;
 }
 
+static int __acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
+{
+	int ret;
+
+	ret = acpi_tad_evaluate_grt(dev, rt);
+	if (ret)
+		return ret;
+
+	if (acpi_tad_rt_is_invalid(rt))
+		return -ENODATA;
+
+	return 0;
+}
+
+static int acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
+{
+	int ret;
+
+	pm_runtime_get_sync(dev);
+
+	ret = __acpi_tad_get_real_time(dev, rt);
+
+	pm_runtime_put_sync(dev);
+
+	return ret;
+}
+
+static int __acpi_tad_wake_set(struct device *dev, char *method, u32 timer_id,
+			       u32 value)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	union acpi_object args[] = {
+		{ .type = ACPI_TYPE_INTEGER, },
+		{ .type = ACPI_TYPE_INTEGER, },
+	};
+	struct acpi_object_list arg_list = {
+		.pointer = args,
+		.count = ARRAY_SIZE(args),
+	};
+	unsigned long long retval;
+	acpi_status status;
+
+	args[0].integer.value = timer_id;
+	args[1].integer.value = value;
+
+	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
+	if (ACPI_FAILURE(status) || retval)
+		return -EIO;
+
+	return 0;
+}
+
+static int __acpi_tad_wake_read(struct device *dev, char *method, u32 timer_id,
+				unsigned long long *retval)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	union acpi_object args[] = {
+		{ .type = ACPI_TYPE_INTEGER, },
+	};
+	struct acpi_object_list arg_list = {
+		.pointer = args,
+		.count = ARRAY_SIZE(args),
+	};
+	acpi_status status;
+
+	args[0].integer.value = timer_id;
+
+	status = acpi_evaluate_integer(handle, method, &arg_list, retval);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return 0;
+}
+
+/* sysfs interface */
+
 static char *acpi_tad_rt_next_field(char *s, int *val)
 {
 	char *p;
@@ -265,31 +331,15 @@ static const struct attribute_group acpi_tad_time_attr_group = {
 static int acpi_tad_wake_set(struct device *dev, char *method, u32 timer_id,
 			     u32 value)
 {
-	acpi_handle handle = ACPI_HANDLE(dev);
-	union acpi_object args[] = {
-		{ .type = ACPI_TYPE_INTEGER, },
-		{ .type = ACPI_TYPE_INTEGER, },
-	};
-	struct acpi_object_list arg_list = {
-		.pointer = args,
-		.count = ARRAY_SIZE(args),
-	};
-	unsigned long long retval;
-	acpi_status status;
-
-	args[0].integer.value = timer_id;
-	args[1].integer.value = value;
+	int ret;
 
 	pm_runtime_get_sync(dev);
 
-	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
+	ret = __acpi_tad_wake_set(dev, method, timer_id, value);
 
 	pm_runtime_put_sync(dev);
 
-	if (ACPI_FAILURE(status) || retval)
-		return -EIO;
-
-	return 0;
+	return ret;
 }
 
 static int acpi_tad_wake_write(struct device *dev, const char *buf, char *method,
@@ -315,27 +365,17 @@ static int acpi_tad_wake_write(struct device *dev, const char *buf, char *method
 static ssize_t acpi_tad_wake_read(struct device *dev, char *buf, char *method,
 				  u32 timer_id, const char *specval)
 {
-	acpi_handle handle = ACPI_HANDLE(dev);
-	union acpi_object args[] = {
-		{ .type = ACPI_TYPE_INTEGER, },
-	};
-	struct acpi_object_list arg_list = {
-		.pointer = args,
-		.count = ARRAY_SIZE(args),
-	};
 	unsigned long long retval;
-	acpi_status status;
-
-	args[0].integer.value = timer_id;
+	int ret;
 
 	pm_runtime_get_sync(dev);
 
-	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
+	ret = __acpi_tad_wake_read(dev, method, timer_id, &retval);
 
 	pm_runtime_put_sync(dev);
 
-	if (ACPI_FAILURE(status))
-		return -EIO;
+	if (ret)
+		return ret;
 
 	if ((u32)retval == ACPI_TAD_WAKE_DISABLED)
 		return sprintf(buf, "%s\n", specval);
-- 
2.53.0

