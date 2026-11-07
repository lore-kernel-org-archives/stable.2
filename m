Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048065;
	b=A46IGmYStln7YNq4MeyufgmsWLPWSVjD8pcS/j2gAt3t5X8oMJY5fuqBwSehyqpfdF58
	 qRi5mwyuIyG0LPqahZQtejzp+dY2NmTo+91iCcZoDyhrjJZLDvN2TMUgpNOoizrcrBX0+
	 vQ+BTdpJrgghNFHSE/h4RSCwY3VOSyNXPzn8sZkz9e1p7rlzh/L55z1P/Mvgdr21dEBgE
	 IOMTLkbkfLzmFmfpi5gbkQjYyHHAuXUwMTibWvbNnZaQjI0AUq5/V/ubVDIOUlqOcixpO
	 X/b4seTnoPvmz3w2fv7DO+UFcmfyful3legPtfmLbzSM49BThArtn4FMG9fJuo5r3JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048065;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vF7PsglKg2LcK2N7iG2VwCbSfsLO5TPKEl7fuZgFU4o=;
	b=vREoonVNfOLyA6P6Z48LfO2SRZg+jFebjgOUBzAwMc3ESt+37bBHePz14tSBeCJ9bqvQ
	 QkJTKQGcY1ktrJ6snt4YR6UUkGsrE34NhGSBW6+QOtx8iuPhomX4gv4NioEV8sq1ifesb
	 QvLKGQV7qSb8y0n7Mo4/rMa9XCKyeHmFdPa/VXgC4CtPa3+Ofplqjq+3ab7eXyHHPIL+f
	 SbMQPfpwvTamQP9iukWzccwBbz7qBTOZQ7o8UGrg0mDiS+crhwnSPjtyTiZBE8fdCzdqp
	 JP8wljI//zQeq2x85yZTPHBsuLQ0Dx1QmyRkCNzaeVj8k2LF6v+M4aSZfXl07edHM3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFccuuE1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFccuuE1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABC11F0089F;
	Sat,  7 Nov 2026 10:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048064;
	bh=vF7PsglKg2LcK2N7iG2VwCbSfsLO5TPKEl7fuZgFU4o=;
	h=From:To:Cc:Subject:Date;
	b=UFccuuE1WngyVlQHCjm5HZtgQpdcu8Ts6f3jI0sh2/kn4tmhMy5qgkCp0Mgyly/ZY
	 vfp+9SxIlOkNNkLwW66A9k8mCTzi6zvzLdDRa9XuLjXdncWIhFtGaDhj1KyIAcFJhC
	 SGa3LmW7lRpnYlEnY1QK54Dx2o4EvHeC+kaJqjBC4SNeH6cznKaZcyrn8l+ttlXuXw
	 a8BNvbwUdyFzXqw6CTqlbzp/huw0JbUs150i0DmUSCh+QvATfdc7h/IFJq5tJnPz4Z
	 SvzPE5G0ebl/h6/haVdWVri1P61JPaQwyGhKWkaVY2OOhLwQVABSpRGQxutsoUXCDr
	 G93bpUilJEJAg==
From: Sasha Levin <sashal@kernel.org>
To: sakari.ailus@linux.intel.com,
	ribalda@chromium.org,
	rafael@kernel.org,
	dan.scally@ideasonboard.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: int3472: Fix uninitialised variable warning" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:03 -0500
Message-ID: <20261107054103-failed-6.1-70e6384fe0f4@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 70e6384fe0f4cf9768944f81924f6c1478b0ce43
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054103-failed-6.1-70e6384fe0f4@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




