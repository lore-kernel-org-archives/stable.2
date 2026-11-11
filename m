Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356251;
	b=3t0Zef6rOEsqpeRnbCzZoRNem6tUHr1YfZSqsYl7g9hrWuo3vmDLvznNx9YeuVPreUc5
	 lymMo7mlaUaA8hgieYpZkgoCuupuvi/l2/6Tl0+sYn6SPtwRfvezrcNLF/NYxtwQwgLmc
	 uwnqq6RwzGJ3K0+9LMp9lC9P1r0RoBI7Yr+r3AbWWxIo8DuT2DgLJanbimTiP6uAW2NuG
	 zHBe9nb47zxKkEWiP5PXXgHHdsuBdL8C/twQq2GmVgxyx/EcjMo2+AzHVb6ZGYdkaGEBf
	 /KyX3P0/Q+X7RA6tX+ye7OTciRfOGGbsM0QTcpSwzl8AfKf6a0kuzmUbAftDkGa8FHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356251;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+KlaMb/t2FSMM2DP9hYWfnzJVXtL1M7I7E8fcLu+wYs=;
	b=a5d9Sb2FZ7W5f17qz+SI43QxrRReiEjZA1I+aWNmWhmYpfzlKQKOW8haotY+R2b3r9hU
	 YFfexaYz/J78uJnqLwYZoO4zOtWyFQoFaKgjOl30cZ9OUPubmKRfte/NXlSwzvQShrXxT
	 5Z3XL0ytv0elMhtGStAPkef5zhkRTsdsz/u5FwCBD3k5r5oRhAjJKsIi98uiNH7MoPitQ
	 0/CLs8uwVQRWxLr5E56ilDp3lDkXrPw0LlNBsbeXw6na+STs++AcGqgvPu5gQJ2kwcQ5p
	 YtKI5SyQbgZiDN2HYIAtKScRU3Z5yaojbzjxf82O0xtaS+3EJUZ5C+MJERhAu6qw4Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJ78cLsk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C627606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJ78cLsk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0671F00A05;
	Wed, 11 Nov 2026 00:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356251;
	bh=+KlaMb/t2FSMM2DP9hYWfnzJVXtL1M7I7E8fcLu+wYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TJ78cLsk6O0X2Ljp/LydS4NF4OvB1NAMUApgrP0CdRxm1pEDhsncPG28r2rBsOfCM
	 URfqM9DQytBCGR0v/Fl08FLb3dDEi5+yp1bje0BCYh1WBQsoTA09BZmqJjjNxFjIkG
	 LGGOK+JvWEND9g34usDPPJ2Tpo0XIUVE96J2a2GHih8i2TCirxV31Z+SET4ktFTlr+
	 f1LKqEo0ejpgUxjIMDkzp5QhTp2NT24+i7T9cbQDVY91W51mizlAA7rx+GRqP0L00y
	 MGTcbe2Kn65YS/y0TIaAjHbVHYGA9VVFl9sGsXrvVqGZueKHd2Dvv1EiSCWRsRwwen
	 vz/F5x1aMlxCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] platform/x86: Use device_show_string() helper for sysfs attributes
Date: Tue, 10 Nov 2026 19:17:26 -0500
Message-ID: <20261111001652.217391-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111001652.217391-1-sashal@kernel.org>
References: <20261107055306-failed-6.1-3d9a175707ee@kernel.org>
 <20261111001652.217391-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 3182459b7bff642eb968d6203a08aea3862436c1 ]

Deduplicate sysfs ->show() callbacks which expose a string at a static
memory location.  Use the newly introduced device_show_string() helper
in the driver core instead by declaring those sysfs attributes with
DEVICE_STRING_ATTR_RO().

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/3ae8c9a73fbb291c1c863777af175c657a2a10e9.1713608122.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The third ASUS fan and ThinkPad auxiliary MAC attributes are absent,
so omit their conversions. Keep the conversions for the existing
keyboard, CPU/GPU fan and Toshiba version attributes.

Stable-dep-of: 3d9a175707ee ("platform/x86: asus-wmi: fix TUF keyboard power state shutdown naming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c     | 49 ++++++++---------------------
 drivers/platform/x86/toshiba_acpi.c |  9 ++----
 2 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 8814b258caa55..2506f15ce53a1 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -783,17 +783,12 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(kbd_rgb_mode);
 
-static ssize_t kbd_rgb_mode_index_show(struct device *device,
-						 struct device_attribute *attr,
-						 char *buf)
-{
-	return sysfs_emit(buf, "%s\n", "cmd mode red green blue speed");
-}
-static DEVICE_ATTR_RO(kbd_rgb_mode_index);
+static DEVICE_STRING_ATTR_RO(kbd_rgb_mode_index, 0444,
+			     "cmd mode red green blue speed");
 
 static struct attribute *kbd_rgb_mode_attrs[] = {
 	&dev_attr_kbd_rgb_mode.attr,
-	&dev_attr_kbd_rgb_mode_index.attr,
+	&dev_attr_kbd_rgb_mode_index.attr.attr,
 	NULL,
 };
 
@@ -835,17 +830,12 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(kbd_rgb_state);
 
-static ssize_t kbd_rgb_state_index_show(struct device *device,
-						 struct device_attribute *attr,
-						 char *buf)
-{
-	return sysfs_emit(buf, "%s\n", "cmd boot awake sleep keyboard");
-}
-static DEVICE_ATTR_RO(kbd_rgb_state_index);
+static DEVICE_STRING_ATTR_RO(kbd_rgb_state_index, 0444,
+			     "cmd boot awake sleep keyboard");
 
 static struct attribute *kbd_rgb_state_attrs[] = {
 	&dev_attr_kbd_rgb_state.attr,
-	&dev_attr_kbd_rgb_state_index.attr,
+	&dev_attr_kbd_rgb_state_index.attr.attr,
 	NULL,
 };
 
@@ -2074,13 +2064,6 @@ static ssize_t pwm1_enable_store(struct device *dev,
 	return count;
 }
 
-static ssize_t fan1_label_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
-{
-	return sysfs_emit(buf, "%s\n", ASUS_FAN_DESC);
-}
-
 static ssize_t asus_hwmon_temp1(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -2115,13 +2098,6 @@ static ssize_t fan2_input_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", value * 100);
 }
 
-static ssize_t fan2_label_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
-{
-	return sysfs_emit(buf, "%s\n", ASUS_GPU_FAN_DESC);
-}
-
 static ssize_t pwm2_enable_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -2172,11 +2148,12 @@ static ssize_t pwm2_enable_store(struct device *dev,
 static DEVICE_ATTR_RW(pwm1);
 static DEVICE_ATTR_RW(pwm1_enable);
 static DEVICE_ATTR_RO(fan1_input);
-static DEVICE_ATTR_RO(fan1_label);
+static DEVICE_STRING_ATTR_RO(fan1_label, 0444, ASUS_FAN_DESC);
+
 /* Fan2 - GPU fan */
 static DEVICE_ATTR_RW(pwm2_enable);
 static DEVICE_ATTR_RO(fan2_input);
-static DEVICE_ATTR_RO(fan2_label);
+static DEVICE_STRING_ATTR_RO(fan2_label, 0444, ASUS_GPU_FAN_DESC);
 
 /* Temperature */
 static DEVICE_ATTR(temp1_input, S_IRUGO, asus_hwmon_temp1, NULL);
@@ -2186,9 +2163,9 @@ static struct attribute *hwmon_attributes[] = {
 	&dev_attr_pwm1_enable.attr,
 	&dev_attr_pwm2_enable.attr,
 	&dev_attr_fan1_input.attr,
-	&dev_attr_fan1_label.attr,
+	&dev_attr_fan1_label.attr.attr,
 	&dev_attr_fan2_input.attr,
-	&dev_attr_fan2_label.attr,
+	&dev_attr_fan2_label.attr.attr,
 
 	&dev_attr_temp1_input.attr,
 	NULL
@@ -2205,12 +2182,12 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 		if (asus->fan_type != FAN_TYPE_AGFN)
 			return 0;
 	} else if (attr == &dev_attr_fan1_input.attr
-	    || attr == &dev_attr_fan1_label.attr
+	    || attr == &dev_attr_fan1_label.attr.attr
 	    || attr == &dev_attr_pwm1_enable.attr) {
 		if (asus->fan_type == FAN_TYPE_NONE)
 			return 0;
 	} else if (attr == &dev_attr_fan2_input.attr
-	    || attr == &dev_attr_fan2_label.attr
+	    || attr == &dev_attr_fan2_label.attr.attr
 	    || attr == &dev_attr_pwm2_enable.attr) {
 		if (asus->gpu_fan_type == FAN_TYPE_NONE)
 			return 0;
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 3541c2048905b..7307249f812d3 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -1820,12 +1820,7 @@ static DECLARE_WORK(kbd_bl_work, toshiba_acpi_kbd_bl_work);
 /*
  * Sysfs files
  */
-static ssize_t version_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%s\n", TOSHIBA_ACPI_VERSION);
-}
-static DEVICE_ATTR_RO(version);
+static DEVICE_STRING_ATTR_RO(version, 0444, TOSHIBA_ACPI_VERSION);
 
 static ssize_t fan_store(struct device *dev,
 			 struct device_attribute *attr,
@@ -2434,7 +2429,7 @@ static ssize_t cooling_method_store(struct device *dev,
 static DEVICE_ATTR_RW(cooling_method);
 
 static struct attribute *toshiba_attributes[] = {
-	&dev_attr_version.attr,
+	&dev_attr_version.attr.attr,
 	&dev_attr_fan.attr,
 	&dev_attr_kbd_backlight_mode.attr,
 	&dev_attr_kbd_type.attr,
-- 
2.53.0

