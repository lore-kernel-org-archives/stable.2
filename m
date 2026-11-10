Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352430;
	b=QG6sUOVfmgAhUaj04mOs3/W93PNo9J6mXEPxzAfujGxv8LD7JjwlvhJil3SInva7N2m/
	 mV/B+XnStYKgGZC4lovCOEgOQy356/S3eirr3ecSqwekPp/+MAZBep59LVtTe8rTRPi13
	 +fkuIjVC43woSShwxDlYwK+xZvybNLJMye7OZi29CTODuESaNqZLki+UxNy70OJmgZ4s1
	 lr8qqTUqfp3a3TY/04CRXjQq9H4fEPDjm0WVlgWA8Ytxj9DIFQ0r/EJrqALfQ6oKUT0oo
	 yHtC693o0E1bnakocm+hPrLONkFKH1uroR5UZuaGJwbUPdiR5awuJ7mKQdX0tUkGCvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352430;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=u2WJxeO0xXOIEz1FUiQ0+48PpXYiAMNR+pqNicR1hzc=;
	b=lJyQqnzEuLSpfQK9mEcuEuB8Kk1inDDY8L0OuG6rdjDFbUfa0PAzCd4uHPV2/yTsz/7J
	 fPUehrfAPR3ft3h/18fxyE09IQVNXO2xeQEg8zonvufwTtA5GBFo11XgP21gRnUIWJP2k
	 /FgLjnqFruPonuvy/8dZf3wdNYXBQcQG9aeXLQDvJBdADKSWNovPTbLJPMrTjXToJ1xhl
	 EyqvaLL8UUSS2nfffOA6LfaBOYhdAFKsXGSCk8czo7FWq+rwquuvjhsYVLOPAeDbGEVf1
	 7hEgO0Fbisbo3HjjpEo/ylBZObYsRbYYpMI57rgAqoRxNSz/L/HBHmKjE2peMkZnEOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlQ0bzQn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CAC606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlQ0bzQn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD221F0093C;
	Tue, 10 Nov 2026 23:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352430;
	bh=u2WJxeO0xXOIEz1FUiQ0+48PpXYiAMNR+pqNicR1hzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KlQ0bzQnOySOfQgrqBqXGZGuQI1ghPaAwUje1fTyn+jjdwMyuV/96iLWaHd5mSwn0
	 FdlV4Z8JbPORslZ0zQWb9Ne8Jy3w48bzIW/bAgzHiEwJtZdghPqIHEvn2kerJDXa/F
	 X6E+RWkO3IbYzMsXOBE+DeKqCT7L5/DGWJYXHyKb8mOS3YGqYHQtUdSahs5Ymf2kqE
	 jNL4Tcpa7SyJi9b9mR2aAzSNetu9MpvnO1BDNcYlkLHrIW7HMytdEiXKFjaEgbaPUl
	 e+jIIEXJD9aCzEIBbIFWDNCn+cwRe9+mmaylEopPEelWb1FNeynrLiFmwhoy+hdW+0
	 LQGjG0VUNZkwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] leds: ktd2692: Pass context to regulator cleanup
Date: Tue, 10 Nov 2026 18:13:48 -0500
Message-ID: <20261110231325.58909-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055927-failed-5.15-c73e9f04445f@kernel.org>
References: <20261107055927-failed-5.15-c73e9f04445f@kernel.org>
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
[ sashal: adjusted context for the driver layout without common ExpressWire properties ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/flash/leds-ktd2692.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index f341da1503a49..5ef8b3c530084 100644
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
@@ -301,7 +302,7 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 			dev_err(dev, "Failed to enable supply: %d\n", ret);
 		} else {
 			ret = devm_add_action_or_reset(dev,
-						regulator_disable_action, dev);
+						regulator_disable_action, led);
 			if (ret)
 				return ret;
 		}
@@ -359,6 +360,7 @@ static int ktd2692_probe(struct platform_device *pdev)
 	if (!led)
 		return -ENOMEM;
 
+	led->dev = &pdev->dev;
 	fled_cdev = &led->fled_cdev;
 	led_cdev = &fled_cdev->led_cdev;
 
-- 
2.53.0

