Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046595;
	b=SBhUKASjsWVwWqjx0RpXtpinURb7bQNskvQEaYujExoX5V3AQHygyh6lH3JNHMHtwzuq
	 tl/wtHkEQl6qU+amy5kn2P65W384RYUh6zCWlPO8WGL2aNfOTQwK1pVy9JKqkGDIZwahq
	 AE+Z7uBelYy9uimOg083INlZIF4sV2TKeyNhjF4lkpSPtVNgFrc6p//tbhAaloHq71K+B
	 3OJV+vMIx4hPqClQk2Hl2OZ6C/fBj4f4RaHppIpiiYOSg8RA/qJTBsUUpo0+qEQlDFONT
	 vYAlS3Jo59kerx799WXbGpuB+tgA0NxqSTMqawEeYMRHsLtRk0bsyBMg4ZAC2jlpIVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046595;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XAA54Qqe77i9rZOwlm7Nn6L5nlgMDFea0/eQG6bzgCs=;
	b=vRypuOXrL5TMi+ViobcJTFXMqptfv2aM7pPCCDLN+UYaqG0sPACFimLxOj/Ihnrxr1iO
	 /YTIGXi9gtiDm1rl+nHTzwpuuSdMQCmseRz0bsfGs3gYkmrbKFqNXaGdG9CDwra9E7nBj
	 fQwprVn0r3wCBpez4d2qv8ovIdAAWvLrgJ4/NnnB1EHmCe9qrn7nIvTI1LPXYUz58EkVo
	 pXPAKyEGnyzCxDGAwtVJQ/x/Wbbk7MPtaHY42eAEjtcHgFz4kFTEMHZhuODnL9DYcOEEQ
	 0YdlKEjD1U00H9hAn2M2kPicofgfVubbozmaqB/fcphmJAeESgMFR06pO7N7PvM9tvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRMEWlWA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B5606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRMEWlWA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507431F008A1;
	Sat,  7 Nov 2026 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046594;
	bh=XAA54Qqe77i9rZOwlm7Nn6L5nlgMDFea0/eQG6bzgCs=;
	h=From:To:Cc:Subject:Date;
	b=dRMEWlWAXC4dKxcPm6Z5xkrISJj9Z4biscXLDFwlfNt++3tsF3Aj/ONkVmyi2RME2
	 KaB5JpYIELflx6do6JOhdgsVLVTL41CCW6kwsIrrVX15pCXP9Wa4ZDWMaznDrhn97q
	 sZ5KUZ+0osuSh1w+3QtIbuNlkhTajkv68NLJQDYQjy1JZRqjl5/qrF8+oft4gjhJ4m
	 sopCWwzkbvXSIwTpKHbHscipicrg5+bMYKTmNw1pFM5cpbWIj/gknSrM5zhzoM8vhw
	 nz8ZCICPSIOYrmxUgXKgwz+SaE9kiuDtw8Ug+xcbOksRYYUkxARIvRuotcZdV3Mdsp
	 Z3yl6xvC99ahA==
From: Sasha Levin <sashal@kernel.org>
To: sakari.ailus@linux.intel.com,
	ribalda@chromium.org,
	rafael@kernel.org,
	dan.scally@ideasonboard.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: int3472: Fix uninitialised variable warning" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:33 -0500
Message-ID: <20261107051633-failed-6.12-70e6384fe0f4@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 70e6384fe0f4cf9768944f81924f6c1478b0ce43
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051633-failed-6.12-70e6384fe0f4@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 70e6384fe0f4cf9768944f81924f6c1478b0ce43 Mon Sep 17 00:00:00 2001
From: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Thu, 20 Aug 2026 23:19:01 +0300
Subject: [PATCH] platform/x86: int3472: Fix uninitialised variable warning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a compiler warning about an uninitialised err_msg variable by printing
the error where it is handled:

drivers/platform/x86/intel/int3472/discrete.c:440:24: warning: ‘err_msg’ may be used uninitialized [-Wmaybe-uninitialized]
  440 |                 return dev_err_probe(int3472->dev, ret, err_msg);

Fixes: 5de691bffe57 ("platform/x86: Add intel_skl_int3472 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 6c729fcfce5db..9cd4f78875abf 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -329,7 +329,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	unsigned long gpio_flags;
 	union acpi_object *obj;
 	struct gpio_desc *gpio;
-	const char *err_msg;
 	const char *con_id;
 	int ret;
 
@@ -375,7 +374,8 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
 		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, con_id, gpio_flags);
 		if (ret)
-			err_msg = "Failed to map GPIO pin to sensor\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map GPIO pin to sensor\n");
 
 		break;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
@@ -387,7 +387,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, con_id, gpio_flags);
 		if (IS_ERR(gpio)) {
 			ret = PTR_ERR(gpio);
-			err_msg = "Failed to get GPIO\n";
+			dev_err_probe(int3472->dev, ret, "Failed to get GPIO\n");
 			break;
 		}
 
@@ -395,14 +395,16 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		case INT3472_GPIO_TYPE_CLK_ENABLE:
 			ret = skl_int3472_register_gpio_clock(int3472, gpio);
 			if (ret)
-				err_msg = "Failed to register clock\n";
+				dev_err_probe(int3472->dev, ret,
+					      "Failed to register clock\n");
 
 			break;
 		case INT3472_GPIO_TYPE_PRIVACY_LED:
 		case INT3472_GPIO_TYPE_STROBE:
 			ret = skl_int3472_register_led(int3472, gpio, con_id);
 			if (ret)
-				err_msg = "Failed to register LED\n";
+				dev_err_probe(int3472->dev, ret,
+					      "Failed to register LED\n");
 
 			break;
 		case INT3472_GPIO_TYPE_POWER_ENABLE:
@@ -413,7 +415,8 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 			ret = skl_int3472_register_regulator(int3472, gpio, enable_time_us,
 							     con_id, second_sensor);
 			if (ret)
-				err_msg = "Failed to register regulator\n";
+				dev_err_probe(int3472->dev, ret,
+					      "Failed to register regulator\n");
 
 			break;
 		default: /* Never reached */
@@ -436,11 +439,11 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	int3472->ngpios++;
 	ACPI_FREE(obj);
 
-	if (ret < 0)
-		return dev_err_probe(int3472->dev, ret, err_msg);
-
-	/* Tell acpi_dev_get_resources() to not make a copy of the resource */
-	return 1;
+	/*
+	 * Either return an error or tell acpi_dev_get_resources() to not make a
+	 * copy of the resource.
+	 */
+	return ret < 0 ? ret : 1;
 }
 
 int int3472_discrete_parse_crs(struct int3472_discrete_device *int3472)
-- 
2.53.0




