Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048150;
	b=JFVVa20pwDbcTWwRKYH9G5877JMq1Kr1INBUpre1le6qOdaYkGOsFehUZ62b8HbEvIFr
	 7iI+n3rmi47I9t1TokqGpNEyTmCv/H+I9NsiYVkBArIJtvP6N5ljWzi+DoRjjqwY2Mvhy
	 tbLpM46f5wkd7gZIxOgVN/ZHvPHjo+ppi2wNqmLhKP42STyWUA0IhURIj1Nv/ktsVj6S5
	 43yh5m1KaM6/NMaMngEv01P2bTg9CtZ0tZuMif3XQ1mbZxlwU04JQLDJV/uGbg4dtmyBq
	 ZL+yyUGBRTT0tEGwuBjYMX6X15w4zP4JbEgsRNRBkwV3O8rZbwMvbh+26ngefWdkNaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048150;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WBcIPqwjhPwRfVT1ThH3ZvA+3V5R/gTHMce4ULmIFFI=;
	b=NYgpTqTEtX+p4X+KYpMQGkMcXuRJ+fkItDbuyn836mfktjC530P345fD5za84xWiNUL3
	 udwIWXPMy4IrhXTLpiILtY7Tfp5//9fWaPFINbDWJ8o9vu0c/AVcl7uiSfY2Qy3FY02Ap
	 JKSMmsXzyRIyKEzmIlh6+V9z6AUEIbmvNktVJ3DHh6T8CG6KgkwhrN8I1H31AdWG13Qah
	 ze6TsblLWiyVj1BnG2l9sd3IMQeuj+7sPIXuddwNTqED0fOWmwqT2xQppI4pTn7xneobd
	 lVZL3y7cCHOiND815vEsr3PrL8HYUYFQJze4+mL/9Hqwgd17AM2Yl4i5yJXVM+2OM8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2md7X6e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98C606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2md7X6e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B6B1F0089F;
	Sat,  7 Nov 2026 10:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048148;
	bh=WBcIPqwjhPwRfVT1ThH3ZvA+3V5R/gTHMce4ULmIFFI=;
	h=From:To:Cc:Subject:Date;
	b=a2md7X6eS1yL+wY1lOWwGbPLtGh+iMorBCUVBgOvT+hwAw7b4R6oWvdk4A5ccny0+
	 11VeMoses8UQlNIaeTxaRig8PQh+zMcPBsd5yHKfhw0/FkJS+zYaDqR7hS+vNlZ4Dj
	 Xz5J/rw8YCvj6WrRYaI/FKWrgOnQgFHXl51+CKOsr6v3u5x9oVAnL2QPGgA7KjEEW9
	 /Bj8kzCuoLS5AJNZ1z4HTWaQPLB+MmCdzC3QdImmNx0nvSTAVczfOBGqiXOWmBGBEw
	 Mo1LdNwiyeY08TdjHtuFQ0DWJnufxP8lwPNbmAstq442ELtCb/2WUtSc9VJyBxWoG9
	 OoFk1L8bgAjhg==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] leds: ktd2692: Pass context to regulator cleanup" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:27 -0500
Message-ID: <20261107054227-failed-6.1-c73e9f04445f@kernel.org>
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
git cherry-pick -x c73e9f04445f361d5f19ca2edfde742ce18348ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054227-failed-6.1-c73e9f04445f@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c73e9f04445f361d5f19ca2edfde742ce18348ef Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 10 Sep 2026 15:45:25 -0400
Subject: [PATCH] leds: ktd2692: Pass context to regulator cleanup

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
---
 drivers/leds/flash/leds-ktd2692.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index 22fbfccd48735..43d4d55503ab5 100644
--- a/drivers/leds/flash/leds-ktd2692.c
+++ b/drivers/leds/flash/leds-ktd2692.c
@@ -69,6 +69,8 @@ static const struct expresswire_timing ktd2692_timing = {
 };
 
 struct ktd2692_context {
+	struct device *dev;
+
 	/* Common ExpressWire properties (ctrl GPIO and timing) */
 	struct expresswire_common_props props;
 
@@ -196,13 +198,12 @@ static void ktd2692_setup(struct ktd2692_context *led)
 
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
@@ -233,7 +234,7 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 			dev_err(dev, "Failed to enable supply: %d\n", ret);
 		} else {
 			ret = devm_add_action_or_reset(dev,
-						regulator_disable_action, dev);
+						regulator_disable_action, led);
 			if (ret)
 				return ret;
 		}
@@ -290,6 +291,7 @@ static int ktd2692_probe(struct platform_device *pdev)
 	if (!led)
 		return -ENOMEM;
 
+	led->dev = &pdev->dev;
 	fled_cdev = &led->fled_cdev;
 	led_cdev = &fled_cdev->led_cdev;
 	led->props.timing = ktd2692_timing;
-- 
2.53.0




