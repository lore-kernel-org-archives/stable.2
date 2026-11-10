Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283355;
	b=oamZt0hs0pLYD2JN1KL22uhngsYAHKTbVNgD7ALTC/rmQ6l85jzU4RY+2Ov4bqvjyfr0
	 9XUZzOboDI/a3t7abF8aDzKhn/jHKBd6oGGTfsCczZ8D/Ctyys4EHbrxg9icZvu0vgDYE
	 1S/Lh9GtbNBrptIGMTpFpzBUjiQ8CSkxA+bcN6JFBDhWZcN5uC3fqmccdU1y5/T+RuuZN
	 r9XgeJNFEcv4tMie4YRg9Qz18iWrwb9e3dGTNPHoYfPSeagpnwuWWiHZOcBsjGWY/wd+Z
	 DqP1d5cc+ADT2oKz0VpHeh2TXHneOx5BwhqrYDP8heZt6AK1JX8lt+oT5zj7kgjlehQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283355;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PFupLJMIMJm9bYh0t5/ZnkhheBGvIW3kdBmgn/golQ4=;
	b=p2mOED9ojIrmeJLW9SzgPx0NpDoXKmNXSeImPH7E2hUl33nx5QvRWjwyCK5za9Dubv8u
	 FBo1BsT/qpp4zFxt7/7CmOrZLl+8EzVK/4BfU7JKaKoIeNSxeRzBw+RfzsqOWtBr6hQVw
	 4ha/3dFeJc5ugIVsLVAYyPEYRYo/O9zDIID24ujPD9n4HgxVp269OiF6VMyoQlxRxzRme
	 1voGTFsLxgpCV4eQwqBtwRUpxDrPJprCjEl9PkbOkp8cLG5SLRuEr+GnZp7ed30LH/22r
	 Y6+1zMIaFEq5ManAOuEFFwhdG6r62nRgm2LaYK0JMXzwF1wvPo+gs66Kvyc68DMcUEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDCt1jUk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72F606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDCt1jUk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708411F0089F;
	Tue, 10 Nov 2026 04:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283355;
	bh=PFupLJMIMJm9bYh0t5/ZnkhheBGvIW3kdBmgn/golQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fDCt1jUkHc+RpV8TXvww/PxASZOjGXWE6KLvp9wXtFvUx9QBE8E5e/Cz2LUSiNhx7
	 YU0EiYc6gFmhNV0lIiyg6rjZ3knw/SbyR0/oWPHPbDfYmEwqRWxgZ6xtsYW3Lmf7lz
	 Wy3eEJR7TCr7CKLXUjhLiTNTCV0KtnUzHHpD7fJr+kRY1wwXgU5TJgJUQR2X2yo8uC
	 BiKR3N9Pr1BADVAW4DXRIQqqG7Prp7WARZ1inviwPmFkhKUFrcfRzuxv8SNKpeeXn+
	 XrUszNzgaZmbW0M8L/Ghn7gock8U3OCQeIS0pH7QebRzu6jely3W9bmp+L9ztgREGA
	 bsAmUyhzpG2HQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] platform/x86: int3472: Fix uninitialised variable warning
Date: Mon,  9 Nov 2026 23:02:33 -0500
Message-ID: <20261110040220.299017-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051633-failed-6.12-70e6384fe0f4@kernel.org>
References: <20261107051633-failed-6.12-70e6384fe0f4@kernel.org>
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
[ sashal: retained return ret instead of upstream’s return 1 to preserve existing callback success behavior ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/int3472/discrete.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 9e69ac9cfb92c..06191446e38b1 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -237,7 +237,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	u8 active_value, pin, type;
 	union acpi_object *obj;
 	struct gpio_desc *gpio;
-	const char *err_msg;
 	const char *func;
 	unsigned long gpio_flags;
 	int ret;
@@ -283,7 +282,8 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	case INT3472_GPIO_TYPE_POWERDOWN:
 		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, func, gpio_flags);
 		if (ret)
-			err_msg = "Failed to map GPIO pin to sensor\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map GPIO pin to sensor\n");
 
 		break;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
@@ -292,7 +292,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, func, gpio_flags);
 		if (IS_ERR(gpio)) {
 			ret = PTR_ERR(gpio);
-			err_msg = "Failed to get GPIO\n";
+			dev_err_probe(int3472->dev, ret, "Failed to get GPIO\n");
 			break;
 		}
 
@@ -300,19 +300,22 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		case INT3472_GPIO_TYPE_CLK_ENABLE:
 			ret = skl_int3472_register_gpio_clock(int3472, gpio);
 			if (ret)
-				err_msg = "Failed to register clock\n";
+				dev_err_probe(int3472->dev, ret,
+					      "Failed to register clock\n");
 
 			break;
 		case INT3472_GPIO_TYPE_PRIVACY_LED:
 			ret = skl_int3472_register_pled(int3472, gpio);
 			if (ret)
-				err_msg = "Failed to register LED\n";
+				dev_err_probe(int3472->dev, ret,
+					      "Failed to register LED\n");
 
 			break;
 		case INT3472_GPIO_TYPE_POWER_ENABLE:
 			ret = skl_int3472_register_regulator(int3472, gpio);
 			if (ret)
-				err_msg = "Failed to map regulator to sensor\n";
+				dev_err_probe(int3472->dev, ret,
+					      "Failed to map regulator to sensor\n");
 
 			break;
 		default: /* Never reached */
@@ -331,9 +334,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	int3472->ngpios++;
 	ACPI_FREE(obj);
 
-	if (ret < 0)
-		return dev_err_probe(int3472->dev, ret, err_msg);
-
 	return ret;
 }
 
-- 
2.53.0

