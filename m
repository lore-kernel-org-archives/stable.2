Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461AF309DDF;
	Thu, 18 Jun 2026 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760794; cv=none; b=Efx/mSqC/GgjVql8YiG3+RFSbI6YRWzpwWbl6/d8dHpWtwdBp7YdffpniE2R7XXCJsqMJKj5gM5KaCQ0J4Y9q2s94Fbwx7hwH7K90IbDPtnSmhTVo0E5IE0lSAM1IweOZR0bVw9ax8Ih9TAluQ/VY4wtGXe/dl6C0ni3KkIFBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760794; c=relaxed/simple;
	bh=aXOtkf4WsDbHyMK7huKIGzIXPy+7TLxtDfWWc9gIp4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fmTzsycqxFbQHIkmTRjMXkS5CbjMJnrr6mAuSAI+qMTnLEcukz1I08RK9Uy9ab0kwrlhwwSzyAnmmKWdhOq5HBjGfmGE0qsWbqYbJMbGTBw+u0kvySL7UV3dHq0r2cedLHaHprnKQYUVIKDd+aQG7GesQflIq5xe/48bvjpYyDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=mZqh4SBN; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="mZqh4SBN"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42dcad2b0;
	Thu, 18 Jun 2026 13:27:57 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Azael Avalos <coproscefalo@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>,
	Pierre Ducroquet <pinaraf@pinaraf.info>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: toshiba_acpi: use brightness_set_blocking for LED callbacks
Date: Thu, 18 Jun 2026 13:27:51 +0800
Message-Id: <20260618052751.3859461-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed933481c03a1kunmaacbda658fda4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0hNVkJJTkhISh1IQ0hOT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=mZqh4SBNK7HMCdyazIRL1l/j8GtUc0IcUnBJNnYlV+nNan2o8AEXIh4nCrxboDXWkhm13yAlK5QUP9JPyfF/GYGU6UR1+A19oVsCkP4Znlbh6K+D6PpBbsfQaBmGdjavlMOHv9Irqre2LHg6W5nrlUw7ikMd5n94WWZdXuuBQDY=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=EPcnrvimrQhPreNz1Um05FU9CjglFVRs+DukObGdwFk=;
	h=date:mime-version:subject:message-id:from;

The Toshiba illumination, eco mode, and keyboard backlight callbacks all
go through ACPI/HCI/SCI helpers that may sleep, but the driver still
registers them as brightness_set callbacks.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

A minimal Lockdep reproducer that keeps the original registration and
call chains is enough to trigger the warning in all three cases:

  toshiba_illumination_set() -> sci_open()/sci_write() -> tci_raw()
  toshiba_kbd_backlight_set() -> hci_write() -> tci_raw()
  toshiba_eco_mode_set_status() -> tci_raw()

All three paths reach ACPI object evaluation while
led_trigger_event_atomic() is still holding spin_lock_irqsave(),
and Lockdep reports sleeping function called from invalid context with
acpi_os_wait_semaphore() on the stack.

Convert the three callbacks to brightness_set_blocking and return proper
status codes from the firmware transactions.

Fixes: 360f0f39d0c5 ("toshiba_acpi: Add keyboard backlight support")
Fixes: 6c3f6e6c575a ("toshiba-acpi: Add support for Toshiba Illumination.")
Fixes: def6c4e25d31 ("toshiba_acpi: Add ECO mode led support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Notes:
  - Not tested on Toshiba hardware.

 drivers/platform/x86/toshiba_acpi.c | 42 ++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 5ad3a7183d33..22a831c9e8c4 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -486,8 +486,8 @@ static void toshiba_illumination_available(struct toshiba_acpi_dev *dev)
 	dev->illumination_supported = 1;
 }
 
-static void toshiba_illumination_set(struct led_classdev *cdev,
-				     enum led_brightness brightness)
+static int toshiba_illumination_set(struct led_classdev *cdev,
+				    enum led_brightness brightness)
 {
 	struct toshiba_acpi_dev *dev = container_of(cdev,
 			struct toshiba_acpi_dev, led_dev);
@@ -496,14 +496,20 @@ static void toshiba_illumination_set(struct led_classdev *cdev,
 
 	/* First request : initialize communication. */
 	if (!sci_open(dev))
-		return;
+		return -EIO;
 
 	/* Switch the illumination on/off */
 	state = brightness ? 1 : 0;
 	result = sci_write(dev, SCI_ILLUMINATION, state);
 	sci_close(dev);
-	if (result == TOS_FAILURE)
+	if (result == TOS_FAILURE) {
 		pr_err("ACPI call for illumination failed\n");
+		return -EIO;
+	}
+	if (result == TOS_NOT_SUPPORTED)
+		return -ENODEV;
+
+	return result == TOS_SUCCESS ? 0 : -EIO;
 }
 
 static enum led_brightness toshiba_illumination_get(struct led_classdev *cdev)
@@ -624,7 +630,7 @@ static enum led_brightness toshiba_kbd_backlight_get(struct led_classdev *cdev)
 	return state ? LED_FULL : LED_OFF;
 }
 
-static void toshiba_kbd_backlight_set(struct led_classdev *cdev,
+static int toshiba_kbd_backlight_set(struct led_classdev *cdev,
 				     enum led_brightness brightness)
 {
 	struct toshiba_acpi_dev *dev = container_of(cdev,
@@ -635,8 +641,14 @@ static void toshiba_kbd_backlight_set(struct led_classdev *cdev,
 	/* Set the keyboard backlight state */
 	state = brightness ? 1 : 0;
 	result = hci_write(dev, HCI_KBD_ILLUMINATION, state);
-	if (result == TOS_FAILURE)
+	if (result == TOS_FAILURE) {
 		pr_err("ACPI call to set KBD Illumination mode failed\n");
+		return -EIO;
+	}
+	if (result == TOS_NOT_SUPPORTED)
+		return -ENODEV;
+
+	return result == TOS_SUCCESS ? 0 : -EIO;
 }
 
 /* TouchPad support */
@@ -737,8 +749,8 @@ toshiba_eco_mode_get_status(struct led_classdev *cdev)
 	return out[2] ? LED_FULL : LED_OFF;
 }
 
-static void toshiba_eco_mode_set_status(struct led_classdev *cdev,
-				     enum led_brightness brightness)
+static int toshiba_eco_mode_set_status(struct led_classdev *cdev,
+				       enum led_brightness brightness)
 {
 	struct toshiba_acpi_dev *dev = container_of(cdev,
 			struct toshiba_acpi_dev, eco_led);
@@ -749,8 +761,14 @@ static void toshiba_eco_mode_set_status(struct led_classdev *cdev,
 	/* Switch the Eco Mode led on/off */
 	in[2] = (brightness) ? 1 : 0;
 	status = tci_raw(dev, in, out);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
 		pr_err("ACPI call to set ECO led failed\n");
+		return -EIO;
+	}
+	if (out[0] == TOS_NOT_SUPPORTED)
+		return -ENODEV;
+
+	return out[0] == TOS_SUCCESS ? 0 : -EIO;
 }
 
 /* Accelerometer support */
@@ -3366,7 +3384,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	if (dev->illumination_supported) {
 		dev->led_dev.name = "toshiba::illumination";
 		dev->led_dev.max_brightness = 1;
-		dev->led_dev.brightness_set = toshiba_illumination_set;
+		dev->led_dev.brightness_set_blocking = toshiba_illumination_set;
 		dev->led_dev.brightness_get = toshiba_illumination_get;
 		led_classdev_register(&acpi_dev->dev, &dev->led_dev);
 	}
@@ -3375,7 +3393,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	if (dev->eco_supported) {
 		dev->eco_led.name = "toshiba::eco_mode";
 		dev->eco_led.max_brightness = 1;
-		dev->eco_led.brightness_set = toshiba_eco_mode_set_status;
+		dev->eco_led.brightness_set_blocking = toshiba_eco_mode_set_status;
 		dev->eco_led.brightness_get = toshiba_eco_mode_get_status;
 		led_classdev_register(&dev->acpi_dev->dev, &dev->eco_led);
 	}
@@ -3391,7 +3409,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		dev->kbd_led.name = "toshiba::kbd_backlight";
 		dev->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
 		dev->kbd_led.max_brightness = 1;
-		dev->kbd_led.brightness_set = toshiba_kbd_backlight_set;
+		dev->kbd_led.brightness_set_blocking = toshiba_kbd_backlight_set;
 		dev->kbd_led.brightness_get = toshiba_kbd_backlight_get;
 		led_classdev_register(&dev->acpi_dev->dev, &dev->kbd_led);
 	}
-- 
2.34.1
