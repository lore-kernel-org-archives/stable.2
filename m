Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350847;
	b=NMLkmUfJ7zpRw52SLm7SeepNRKzJhbjd9Q8zGjJjnv/5IMai/1h8yKyayHT8kIwhIYLZ
	 1A48U8wO4HnipiTAodnv/UKaLGCHK8HSFaUFunugt/FneSa0ysPkm/SrNbEVDx3D+88a4
	 ec6PmBPHmY3E8VolZnMeN5vYGJyCORI2GK/JVMENedXtYtv9j2DwWYayZ/VT2SyNNNCxd
	 DbGry3KjZoM5mkH8oqNzzOXQJKgC7ORKrVchqN83kLrQ6uWgnTmGP/tbqQsnVLSqXSb2O
	 5UF++LeeqNVjqCzjLTK0mwzt5XPvjDg7217VHxbQd92glTtqMJbnQco19noCUzpd3qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350847;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ppdsZCku2qRhBX6QE+n9TJTGZt4a+eG4jtoWjpzeE5U=;
	b=rsenbBhr/lbix7ZpU75oPVqw/u2+lw7Nc9oNVCCZV2O3vK9iWMcGHNW0ndBcFbxcqL7w
	 JyjJSsYxeqBntCaPEW5AJ4YGeSHupc7jdsTu0hMdJ7byhjkLwRIjp5HEbGQkASTMNw3T7
	 305LIohVoithEXGF6sozPKBIM26db9v+HEJj1nv3PuPsBzJeocCMkv8h9tBwHzNe47HLw
	 aJaGkTMskoURzc4HgygqeU5IG+r36E6xtEyjm9hWbNTnBmK1/xII43LD8V3jj4PPcmhMg
	 4GivldzUzCvjHigz98/Y+MeA1imr7m4FhJ1rMjVDAM8S1b9kJBxF4KAhIe77bmNN8ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TwlHlSE6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF3A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TwlHlSE6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02C91F0093C;
	Tue, 10 Nov 2026 22:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350846;
	bh=ppdsZCku2qRhBX6QE+n9TJTGZt4a+eG4jtoWjpzeE5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TwlHlSE6PF+NRrIwLiMixjDgy/bGf1iosbIL5f4TZBy+SW1+sj8lnnuhtvHNSGlDY
	 lPx+9pnc/fLsl8QzV6oYDyJE/zBqNTekH4cGlEMAHrSi5iujDW3LaGTQmJQD4KRovP
	 sYA4nbqYViRAH2cnqZLhDerE6gesegCxRzkNmjq5qVL4SqZV3/kPjjnexDkq4KPlnC
	 OZ/IGmFfyYxxNfg5/g6C7gkAyxcluDzW1HxJKJeCQK1bc3yHy1Qh1tliKPl8fC7j6e
	 uDb82wx5NNwRJRUX1MvNnSfRk7hkMkzvymCSofpNE8Rs0615/jsAVLI0Q3NLTA24zJ
	 iTbXS0j0aIbjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] leds: ktd2692: Pass context to regulator cleanup
Date: Tue, 10 Nov 2026 17:47:24 -0500
Message-ID: <20261110224548.4066104-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052945-failed-6.6-c73e9f04445f@kernel.org>
References: <20261107052945-failed-6.6-c73e9f04445f@kernel.org>
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
[ sashal: Adjusted context for the device pointer insertion because the structure lacks shared ExpressWire fields. ]
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

