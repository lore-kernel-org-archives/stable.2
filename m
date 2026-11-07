Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049060;
	b=J6FBU6wyj8uQwk00JBsojiFAKS6NMYTDOyfiRnTIsYLrtY+dbRHV/7z7mCDYfJGl/Icn
	 BzFEvsoEwcQTxSom4TzsjcJBdEvlJuG/+9JsbQlLko3M36YTLWYjmSOkBed8hi82yMInN
	 224Aua1rzd9xVtO+9hrprwjZo7dK2cg/AYI97ISLTOIlbSqpwiR/QF+LwME8Wcu5IsT7o
	 O16h6B64pEqkslEssHggBdxJdfCjYQ+FO/MS/jwC3sWwf8EZ81n31WuRiEqEEU5FGabn1
	 0/Bflvsxosv/hzYrLOfFkZMPKJ1hdIxUoi79Ex52Lb5iEI4xsp/B8AvAQGUUJe3HaQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049060;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WrEGBHM5Vf67S6RwK5gvY3IFKaLfaIqACi8iu5an/Ec=;
	b=BevPSt4zccgkUGx9rqjUYPyBZ447Rv9DovRx/4UrDd4Aeq3hAW80jkG6JNxk9iXpY0bS
	 RRkVxfxdNlQZEZuYXRWnKGuzsWblKCnC2zikv3zvnssHhR2J90wBC7x8/SJShjLYKwW6e
	 GWeE7p1srwNsIAD85N6mg4fo9PZzy2MgQkoF1CxaCfWgE7yLSzrxA+XT0NWXrATusoz6U
	 /sPaQGQvY+FXtJ5HhZbxJ5ecu5ig+hb0ElqZmDRrml710AjkusDQfHhcxij6L2IP1VDKw
	 +jVdGyv50P0Y5ivQSlkgoAUVNAC4e2biQ0hs4wOCS4eGg7ioUTcwFu3XMR/vnS2kpkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Di8wWEZY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC9606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Di8wWEZY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480991F0089F;
	Sat,  7 Nov 2026 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049059;
	bh=WrEGBHM5Vf67S6RwK5gvY3IFKaLfaIqACi8iu5an/Ec=;
	h=From:To:Cc:Subject:Date;
	b=Di8wWEZYNyFoWcocjTU2ITrYqQ8eYivzqnIcnRtaFjK98BdvDXWFvfiJiILxSgsoC
	 5+t1yv9mF5oJDv+9TqKTIfkIyCMhEie1bf8oXlr3lLBb10bNYY17cuFDgz0rVBGDi/
	 H39cZa8NtMQMjbfJPqRW+reC2uwiFMGVYiIBYsppLj3qw0On9EDxRXYdAPjiLshSrA
	 B5lP8uNBTaVs30upNB2MOw9M9z9ZzOjRElFacYdqI6dEI2DBCaEt91UMtxjiFPAmEK
	 lTWIRIvbOux/eay92ZlXuzi19DYJ9nll/ePhGCbkgNiMKyCm1wbVD/DMHTYsuUfiHZ
	 0DD7/PMnFbTXA==
From: Sasha Levin <sashal@kernel.org>
To: sakari.ailus@linux.intel.com,
	ribalda@chromium.org,
	rafael@kernel.org,
	dan.scally@ideasonboard.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: int3472: Fix uninitialised variable warning" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:37 -0500
Message-ID: <20261107055737-failed-5.15-70e6384fe0f4@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 70e6384fe0f4cf9768944f81924f6c1478b0ce43
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055737-failed-5.15-70e6384fe0f4@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




