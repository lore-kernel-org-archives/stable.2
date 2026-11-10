Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285316;
	b=d4zxx8EbvcaORs/rYw7lqjPMxCFJNBZeTGvHq01SesJcHNaZ4l+aOniR8KQ1p//rTzND
	 hqhvJ3J2jse9n0nTopOZxgFSFDw0CE0OmtQrmZwCoAfe2Bs4kbetNROsJ0MZo8Iqebyq4
	 9u4OP8Hn6ZCoeCQFZyPbAeu7+ulO5GaFWoboJCxXbC8vkKXh99otUy1Um8XYgUKkQfykJ
	 /FyMUgbBmKoimfs8xN7mFSGllBOYWSAYB2zZ3opWLNNg3edOgN2C+xojlyASoVVuK1obT
	 UaNTgmIGG4mSTHkHjFI+OPoKV5HlVhLXABBnJn0WbILZSnjEJzu1g7hsI9oldLIxK6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285316;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XtW+C6G/XU0UuwcliqwEInp0EofmKd2q8CC967z/+xE=;
	b=Et+xKER8h+yMv/3dq3mW7R1qXKq6op2je2FyuJ1fsHv5C0/10Af0wAqOM99In8wcGk8x
	 YftfhJ39S1lMeoHsheU62iIO94XGNT48AV9QjmEWC2WtLogmbGvXMPb5N7arzJe8c3Guv
	 Pp6grXTL2Vvw8V5wHRIhnQ+NtMPh95na2xpIstD8T59YN3twton595lwgcJu3DGbbQzjl
	 QAn9verSx7/Hbm5Jvt2IbDwUiY+wzIkiUERlI12oWkrD9bUKWxpNr6X/Zfyx82379FaSn
	 Xi/PumG55h8SsON7yJYJYObhSKOQS/EolrDGVxz0xK19tmfzB6sAU05TBv8DmLrjitg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T7qYDN7M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEFF60A2624
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T7qYDN7M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299141F008A2;
	Tue, 10 Nov 2026 04:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285315;
	bh=XtW+C6G/XU0UuwcliqwEInp0EofmKd2q8CC967z/+xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T7qYDN7MPtCobJ2dy9lecpk/PEwZIbv+uOamTHaEdiY93+1meLn/BOjXbLaOFc0wc
	 lGskQN9l0crO/P7V5zlVbri9IjS80wDzkb2mNTPgBzCfnSVrYAVii2ARV5GBa/Tz/F
	 puhHZ0Q/LteM2PVj4PmRBsyY8zeE5zXWLjxvBYjvUf6akY77dqUaWU3/4JblLsIyhy
	 tVdxLXEcUJ3ZRzN4DxhZPoRUEPB3kW9ymDVvglrP48XwDaQ44yRloRbmQS0ZgHrhr1
	 4L1xlcRzHiHxHX6fvW+E/2BfnSMXHCwn+tHLFE2S2felvFW8fMnt+6RgEKIgY5aciJ
	 Am6ck4iGr2eZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] platform/x86: int3472: Fix uninitialised variable warning
Date: Mon,  9 Nov 2026 23:35:13 -0500
Message-ID: <20261110043502.362465-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055737-failed-5.15-70e6384fe0f4@kernel.org>
References: <20261107055737-failed-5.15-70e6384fe0f4@kernel.org>
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 70e6384fe0f4cf9768944f81924f6c1478b0ce43 ]

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
[ sashal: adapted error reporting to the older per-type GPIO mapping handlers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/int3472/discrete.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 31494f4247864..517103ea252e5 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -227,7 +227,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	struct int3472_discrete_device *int3472 = data;
 	struct acpi_resource_gpio *agpio;
 	union acpi_object *obj;
-	const char *err_msg;
 	int ret;
 	u8 type;
 
@@ -256,27 +255,31 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, "reset",
 						     GPIO_ACTIVE_LOW);
 		if (ret)
-			err_msg = "Failed to map reset pin to sensor\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map reset pin to sensor\n");
 
 		break;
 	case INT3472_GPIO_TYPE_POWERDOWN:
 		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, "powerdown",
 						     GPIO_ACTIVE_LOW);
 		if (ret)
-			err_msg = "Failed to map powerdown pin to sensor\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map powerdown pin to sensor\n");
 
 		break;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
 	case INT3472_GPIO_TYPE_PRIVACY_LED:
 		ret = skl_int3472_map_gpio_to_clk(int3472, agpio, type);
 		if (ret)
-			err_msg = "Failed to map GPIO to clock\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map GPIO to clock\n");
 
 		break;
 	case INT3472_GPIO_TYPE_POWER_ENABLE:
 		ret = skl_int3472_register_regulator(int3472, agpio);
 		if (ret)
-			err_msg = "Failed to map regulator to sensor\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map regulator to sensor\n");
 
 		break;
 	default:
@@ -290,9 +293,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	int3472->ngpios++;
 	ACPI_FREE(obj);
 
-	if (ret < 0)
-		return dev_err_probe(int3472->dev, ret, err_msg);
-
 	return ret;
 }
 
-- 
2.53.0

