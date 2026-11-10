Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354961;
	b=KKNDdrVLSXTwYxJuRtwDjtEocJy71u03mrbwokk9erUS/MxfTdPdwxClW2LjCs80FB8J
	 hbC7kzLAXKZEAbMnCmrRgg2qxu/pkiUyM+qyMsd6cy5AGCIbSIbWjm0PnlRcQ8igsukQD
	 eS+O/iGqCz3gd9l8lVnPMKdBcTOr9zU6dEMRD6Z4wciaSoLy5jc0CPOrJ1P/v62/zCmuO
	 sdrsEV3Cy/epGRbQD52Akkpw8THGJx2a3ggKpspjczcgonsrTvN0RKY7FK9w2D0YFzqE3
	 EB1v0bgnsAlxFx8JKeltZAumhnGt4Es6YgvYPD6zjLA2EC+BuPEbeksJfz3i2pS33ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rU21VRkAGsHT90VWyMnjSCOHrp1RXrTZ7jVjCSjSA4Y=;
	b=j4iJJmx4Wwf3ZZUg9M60pdO/q9KZE8HDeG02vn/IwCz78a5tNrDJSYuKTcK+NskWNlLA
	 tVvDaJoAlJzZmXkhUl6RqVC5Va99P8hEJQkpcWPs742P70sj0eAf270M0GwppEqDRny0G
	 SEA7t6nZOII6tJswevvBcFKipI2SnUej17w5gjIRRYBqm2/ip2aLM9sJiizHNt3592w7g
	 HWaCc9aiCCAE3k1zyPC/+pUrU3+vRpvZynytUqCQ58T5DIXEhe1nk9BSBw7mY94ZinufX
	 HPTI8Lx54BSwh2LyXKQOp9xAYCEW0QTneBxd+mYUVnr3hQnPDC/jbr1LNrfS8pIVcKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Vldctk/e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE74606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vldctk/e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3B01F0093E;
	Tue, 10 Nov 2026 23:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354961;
	bh=rU21VRkAGsHT90VWyMnjSCOHrp1RXrTZ7jVjCSjSA4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vldctk/eOAhPVjeB72a6wgYHrdXNvJEiuPdGulX2Ml3xatxHJBDWu/XlS+RVyyuyx
	 mA6oKttWoCsAE0ceWx921XC1/bwpLf2d+97SwWmrja0bJQ40Pt/3Ak5pEaGbcIDJ/b
	 Tb9hZh44F0mhNa0mQOPsK2HxobhpZKFKueGcTsB4FI5gM4+biM58q1S6hR0/hR2FNF
	 v5z6HKodAfQ9LWZsQrutM1sv/lxPNw7SFDORrx/Np9htB/jKH2ZvTKW/gk7b/oTmqj
	 ahlsIHYcOysqUJ0YuITTl8NbfzBV2Kt29ZfW3X3okzBzLsnAqq4KrNFA7tey9x1b3T
	 YQqrdG7Lq0Kaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] platform/x86: Use device_show_string() helper for sysfs attributes
Date: Tue, 10 Nov 2026 18:55:57 -0500
Message-ID: <20261110235541.191333-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110235541.191333-1-sashal@kernel.org>
References: <20261107053801-failed-6.6-3d9a175707ee@kernel.org>
 <20261110235541.191333-1-sashal@kernel.org>
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
Stable-dep-of: 3d9a175707ee ("platform/x86: asus-wmi: fix TUF keyboard power state shutdown naming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c     | 62 ++++++++---------------------
 drivers/platform/x86/toshiba_acpi.c |  9 +----
 2 files changed, 18 insertions(+), 53 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a76d43ca647d4..2701ab8270fdf 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -913,17 +913,12 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
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
 
@@ -965,17 +960,12 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
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
 
@@ -2492,13 +2482,6 @@ static ssize_t pwm1_enable_store(struct device *dev,
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
@@ -2533,13 +2516,6 @@ static ssize_t fan2_input_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", value * 100);
 }
 
-static ssize_t fan2_label_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
-{
-	return sysfs_emit(buf, "%s\n", ASUS_GPU_FAN_DESC);
-}
-
 /* Middle/Center fan on modern ROG laptops */
 static ssize_t fan3_input_show(struct device *dev,
 					struct device_attribute *attr,
@@ -2558,13 +2534,6 @@ static ssize_t fan3_input_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", value * 100);
 }
 
-static ssize_t fan3_label_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
-{
-	return sysfs_emit(buf, "%s\n", ASUS_MID_FAN_DESC);
-}
-
 static ssize_t pwm2_enable_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -2661,15 +2630,16 @@ static ssize_t pwm3_enable_store(struct device *dev,
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
 /* Fan3 - Middle/center fan */
 static DEVICE_ATTR_RW(pwm3_enable);
 static DEVICE_ATTR_RO(fan3_input);
-static DEVICE_ATTR_RO(fan3_label);
+static DEVICE_STRING_ATTR_RO(fan3_label, 0444, ASUS_MID_FAN_DESC);
 
 /* Temperature */
 static DEVICE_ATTR(temp1_input, S_IRUGO, asus_hwmon_temp1, NULL);
@@ -2680,11 +2650,11 @@ static struct attribute *hwmon_attributes[] = {
 	&dev_attr_pwm2_enable.attr,
 	&dev_attr_pwm3_enable.attr,
 	&dev_attr_fan1_input.attr,
-	&dev_attr_fan1_label.attr,
+	&dev_attr_fan1_label.attr.attr,
 	&dev_attr_fan2_input.attr,
-	&dev_attr_fan2_label.attr,
+	&dev_attr_fan2_label.attr.attr,
 	&dev_attr_fan3_input.attr,
-	&dev_attr_fan3_label.attr,
+	&dev_attr_fan3_label.attr.attr,
 
 	&dev_attr_temp1_input.attr,
 	NULL
@@ -2701,17 +2671,17 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
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
 	} else if (attr == &dev_attr_fan3_input.attr
-	    || attr == &dev_attr_fan3_label.attr
+	    || attr == &dev_attr_fan3_label.attr.attr
 	    || attr == &dev_attr_pwm3_enable.attr) {
 		if (asus->mid_fan_type == FAN_TYPE_NONE)
 			return 0;
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 26991b2f7ae91..669af07433482 100644
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

