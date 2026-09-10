Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504658E2DC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069533; cv=none; b=aTB7XB41IYQgeHsc385NEsA8k4nOEHN8gcbi1h5wyXejql+3CjtmIOLfjLTVn5e34dm5ENY8/8o6N9ZetY29kdaxMY3EHw+qaZ487+fZtHE8ulnFkLn1Fi/549paN6eVpQfLuOevlDQ3RwPK0nfs4S+3gMZIKXqw0WZAH30SY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069533; c=relaxed/simple;
	bh=QhX+SC0aYPRnajzGgZCAyqZcT5ZumThFwIdRLkM4lt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RENCVe8+NiBPYqTP/U6xPFJKNwm4mp6ODLUxgiGSbkwtACg8PWO1czKFTcqX0Up3t1ulgWWCP2u/E9jdMtC3qeyWyEFjoFdiL96BaFp1z3CfQZaNoRC4ouE0zMb5Jdx2yVaeni3ypVEQ8sPyYcQPIz/KzdS4+LOxkohGCubpXYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ0uh9fu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ0uh9fu"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91034716d1dso814386d6.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789069530; x=1789674330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/3ZGdaWGihAcbh8PThygY3ZNQwZqvA2jilmZZCQz4o=;
        b=eQ0uh9fuf2gq46Jh/5Ao8dtwSXCVkVWM/yBJdwzLyvp2bTmGEEvIjYh3Pn5Qh40nYl
         hZ9jHtsgpNA0gZyYeQMUGfdWINb88JnIpTanKK6hNdXKcIdlv46qtNrLU5J+xD4t0vCz
         MqlDPXr49SttkxfiDsUsQ8uFLfWuliDO5PUfgLDN6TjlKgkK2TWTnVZZXHdQgG2g34ud
         KAI6m/TKMgXrlcNKkZqWFzJK02IqDE39VqENuAM48stJED54wVgZ5M9pvZJ84MDNGhQf
         rLsKbbtFOebezTcmITgtXF4RG6npZcQKZcpg85wfhpnXY5mmwfjf7nUtrvPTKE6rhaYO
         LPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789069530; x=1789674330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/3ZGdaWGihAcbh8PThygY3ZNQwZqvA2jilmZZCQz4o=;
        b=mREWcZrT6uV0G5yKsT2Dsj/JUjbquKvQLUpwxY4PHsnTA4SSJFv0OzQxsBZsn8a3SV
         z85eGye/iNohOjk+n5Rv5HTBj8DZlIhw8gHvIaQIxmkMxOHZUxVlBOrelVq+3gw7W7m+
         xSSezB6+0aFwA0yP50Fk1lHr2IGjINl9hNpGAr8tljg0+jQFsEaYuBsgJFg8QEMDoL4A
         zfCqPaSQTF6tUZdtwk/aNNxhFUIiWuYNuyyFHJTNMyMwqit+MlXp5KuAinRu6Y2JIhKu
         /Re4mBIwM5SFWZ8AqQNPdZS0NqFlFHfMGVPKNMnX1DukG0LLK/bhaHdxe50Oeev9Lum3
         wVuA==
X-Forwarded-Encrypted: i=1; AKwUvBwBDYsYsefCVjoBnv9RmCsDo9DnEerSgYnLE0RD3vGYKt3aX0W8R/TyrLlrQ+IT/TdH4EvGqhA=@vger.kernel.org
X-Gm-Message-State: AFuF++ltduIZU4Dp+9OMq45Q3bkL6mQutIHhsR/VUEe51SOIYME58QfJ
	DpJk+zHiJY3OYkiJ1s8lQQuvHEXMqaJiDG8m+/nfBAAaQX4AJ2m5NDY=
X-Gm-Gg: AYBFou3n6HQpc84za/roLHzdj6CmvA4wW3hbzy4gsSo7fQ4f4Z9Trh77WY9McUJ31ys
	6iZT8Ld8WfMRfbEqeY/NiSrHCa0S3Ywrxp+cp0TLbHpDiGBonVasavz6PxuUpkJQw/Z2nW1TBmI
	1iOMcLzq5hMGdPqpePg5z0wCgclO9O89rZQKB+npXw4qCnb5x3VdLpeTrt4GyEAkmV2woc3i3Of
	iyK7cwlKf4oydVv1rZgOtRmOMdyleQJKBHLREXv2dI5CvErWarKfDMQU7wdtdEVYKKc9YpxlP2K
	FIHn4U7jBHjVHj8w62oLRB/vBSFvXMGwULxHxuGOKLCNzc0rK/Mja3FPyAGc+OGfex+3vGGQ46L
	+2X6wrUF20h3obe92pUDFb7Bv1HIseY9MBDRR//zgMSCr1zp5QNCBVMNyYLgLV/cEL2ho5hPN/s
	WIjFesdY+QA7aKsQhdS+5lwKoUk33AXtHm7o4oB6WSqnFdQ+YW3mHeGBhxqW9rs1Oa21mSCJHvF
	ozfMDrP0yhjJ5321Uj6rhsN+GMPQdxlpteES1+scHS4lW4slgg99bMR/tGGUbWX399b4ki1J/Fn
	QbCChB2tIKMliCS5dTfJfrLAszhldXsmMA==
X-Received: by 2002:a05:6214:3218:b0:910:42f7:a111 with SMTP id 6a1803df08f44-9121208900emr5796326d6.15.1789069530089;
        Thu, 10 Sep 2026 12:45:30 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d89f9sm3530526d6.47.2026.09.10.12.45.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 12:45:29 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: lee@kernel.org,
	pavel@kernel.org
Cc: linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] leds: ktd2692: Pass context to regulator cleanup
Date: Thu, 10 Sep 2026 15:45:25 -0400
Message-ID: <20260910194525.99654-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/leds/flash/leds-ktd2692.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index 22fbfccd4873549baf390127d2f7e9aeb9c45465..43d4d55503ab50c6e31b8e83eed430cc33e014e3 100644
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
2.50.1
