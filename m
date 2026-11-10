Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351524;
	b=Gk6U4dERNaDl6JT5e/SHVsE+NAF40uCuaPLf6na1kHsyTx9/fEOWFe4tR9Hw1PyKf0o2
	 XCGsK3TfMgdC070YxfuX9D0agOy246CSVZyQxZfn/BmS93gxu7Kduy2Fj28VT7jTj+QgJ
	 rY4X6iDL+qCjRb2UL6QwuKUNgrj77K/gelsLRMsc4HStoJo18Ha+0qUp0R7ChX0+UbQFV
	 MVBZath3CjqMfPmWMxz/TvFNiJNBl73zW3IDFVFpMVgIfT7dOYKZSd9tHwTL++bIzOVFw
	 Ifv1iIWzLGpLZE4937rXtog2WT80XXrPGTzF1zZbInAizqJzu9HCtv1rtNfFqN73WyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351524;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=p/IRGbv8AcBRuUrQFi+8SUoLHQw1n+w0YTfAH+Y92nc=;
	b=m87py3adcF+MLcDXqVCW/3SJqloSCE2RloPLS9vzX6GbfaUazysnk4Alsp2+HDQAvv0g
	 vfoEF3dxjhjYgp9dvTsbAjzTNIIXXc4ZIKVNAOJI21tSWYVcKgkP7yV7E8TbHEz8miD94
	 nSU9Tokdz8IOk32mkzf8kVcB931CDP3dS53hTXZ/A/igYSV+3eVMKBSVSF1Xv8NWXddg1
	 hUQTFNYp1K+g5vZtQyt4Va7Y9/OLdwsTa57AVEuJOArdrpjDY1S0YfQVMbuRMsM8g//GA
	 T5WLPXk0j+kLvh68LW82/FwsLP0luGr3Ke2Mqb4r7QN9boEuavheNSZjw41XYqGLWIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPsSEnBL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDD3606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPsSEnBL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3DB1F0093C;
	Tue, 10 Nov 2026 22:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351523;
	bh=p/IRGbv8AcBRuUrQFi+8SUoLHQw1n+w0YTfAH+Y92nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LPsSEnBLqVQyWUgaswgFYG4qn4llkrtDEjAcqxDEJZz1DS8KfNxglxieUXdXx9snB
	 MP1yK/MjIii9z7bVOVZO32RB1yzJ8KzdvSccwagh1ULBvoxNAPh6h4t1oP5FMt1k6o
	 PcVGpBF3dBSZl48pIWBe/mKL4W/PgxCQVCk4FyNPNCJeEHsLoVRyBCrzeB7i9rEZtH
	 ZEPE/nkoBN017dcGGyIoGHKwG2f6h2cl9hNVcOS8HLLM20o0hilES6g9QEFe+hKgXw
	 LnMhT0YlEgRmSrPrT/bFvzPY39LTtQZYDJjVoJAh95Cvo+kfDbLRS65j8msy5dOjt0
	 psGL7gGMZ+Imw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] leds: ktd2692: Pass context to regulator cleanup
Date: Tue, 10 Nov 2026 17:58:41 -0500
Message-ID: <20261110225821.11051-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054227-failed-6.1-c73e9f04445f@kernel.org>
References: <20261107054227-failed-6.1-c73e9f04445f@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit c73e9f04445f361d5f19ca2edfde742ce18348ef ]

regulator_disable_action() retrieves the driver context from device
driver data.  However, ktd2692_parse_dt() registers the action before
ktd2692_probe() stores the context with platform_set_drvdata().

If devm_add_action_or_reset() cannot allocate the action, it invokes the
callback immediately.  A later probe failure also invokes it during
managed-resource unwinding.  Both paths dereference a NULL context.

Pass the already allocated context directly to the action and retain the
device pointer in it for error reporting.  The context is allocated before
the action is registered, so reverse-order devres unwinding keeps it alive
through the callback.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: ee78b9360e14 ("leds: ktd2692: Fix an error handling path")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260910194525.99654-1-mhun512@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
[ sashal: adjusted context to account for missing ExpressWire properties and timing initialization ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/flash/leds-ktd2692.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index 670f3bf2e9062..b54220658f969 100644
--- a/drivers/leds/flash/leds-ktd2692.c
+++ b/drivers/leds/flash/leds-ktd2692.c
@@ -72,6 +72,8 @@ struct ktd2692_led_config_data {
 };
 
 struct ktd2692_context {
+	struct device *dev;
+
 	/* Related LED Flash class device */
 	struct led_classdev_flash fled_cdev;
 
@@ -258,13 +260,12 @@ static void ktd2692_setup(struct ktd2692_context *led)
 
 static void regulator_disable_action(void *_data)
 {
-	struct device *dev = _data;
-	struct ktd2692_context *led = dev_get_drvdata(dev);
+	struct ktd2692_context *led = _data;
 	int ret;
 
 	ret = regulator_disable(led->regulator);
 	if (ret)
-		dev_err(dev, "Failed to disable supply: %d\n", ret);
+		dev_err(led->dev, "Failed to disable supply: %d\n", ret);
 }
 
 static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
@@ -296,7 +297,7 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 			dev_err(dev, "Failed to enable supply: %d\n", ret);
 		} else {
 			ret = devm_add_action_or_reset(dev,
-						regulator_disable_action, dev);
+						regulator_disable_action, led);
 			if (ret)
 				return ret;
 		}
@@ -354,6 +355,7 @@ static int ktd2692_probe(struct platform_device *pdev)
 	if (!led)
 		return -ENOMEM;
 
+	led->dev = &pdev->dev;
 	fled_cdev = &led->fled_cdev;
 	led_cdev = &fled_cdev->led_cdev;
 
-- 
2.53.0

