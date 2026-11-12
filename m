Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443233;
	b=sSveJZ+sMbSFh0bHoHiQnJfD4EC4dSHWrLKoUFxdboIW/rCbLJrwpRom2Xl6MV6a/BFL
	 QDk8bEAqNtNceqcAQkc7M00ocGBQ1H9EPsTsV4C3zt8ioeaey2joZoMjl7jK6BXPDCBcL
	 SyjYcg8q2aUXI4nAYv3mmPgNQO5uz7lDjNFmQksZtJEqoD+Oc+S9BMdUG0PT67+kzRFV3
	 UrGojt5qfX47Uqa1dhBQf4xJlUu3mNTaY4PR6TqK3reu30OQYtaTz9IX1fVbpjjC6ScDC
	 lxoGHmQsWygn2xHiGdNUU0YWZmkevZT6MClP6FVtI60IXS7eK5nHWBgEySsycyNyHQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443233;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vGqzueVGz9mslqqCNOdFpgnGuacxoKSna0rcJ3p/p+Q=;
	b=O5YOgVE2yJqk6GWsTUrXrUpW+kI0FO/T+6iJVH5kGZdb2c0a+Cv+Vo47duZZABX/a2PH
	 RBXM/jS7p3ZCYBeqIzdaY8/l99MmXGHmW7meB1Gnt9fqQdf5t2A2SeNmG6t/4n3SK5y5x
	 efVSsLErTpwFzP9NhrXP78wX8DVzG8olGAGlEjeTGOY5A+b/Uuk75kWo7d93RyGoKW+Qp
	 Zg0+IAi4El+E11AFuBRnqadzkOyYWixpq0YxnJCz/HFjGxtmM5YMr/GhWX37kpnztZ7NJ
	 30xMbwzOy0wfnsYvhMhu7oXyhSk5eQNg9ooKgJ1wdsQWL/d7Qgo2v1fYdUjgZXhLuVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFtgjnjE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F130606A330
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFtgjnjE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6689A1F00A05;
	Thu, 12 Nov 2026 00:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443232;
	bh=vGqzueVGz9mslqqCNOdFpgnGuacxoKSna0rcJ3p/p+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MFtgjnjE4kz/RGqshkSIDUlmAxSkqOTUGn3vHQQSMI46YRJ3cS+r4KfO8JlsAFL6n
	 GxBhHN7jVoA5xrHKgXyOsLDp4ANYscdzitskU0nqW+QnXTCHJwtjcCm38dJXIBQEam
	 IaAivW2q5551U1+KMKD12G7QWRXPebFR0ca0g1lZIne4YpQoYs2pgKLidWrem8viuu
	 2IOh5CXJIk6Xq9Tf7rhVcYQmzloAMSnL/qfKpd1t7Q9S4RZkk4OR9btub43M0f38mp
	 46+8ZxMqiqG0sIhkq/vdnKzjGpj3gBlIQjyyGSD4qJhAE3RpCaiD5lywwou3PgrQ9z
	 NKAXjB0xjOs7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pan Chuang <panchuang@vivo.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] hwmon: (sht15) Remove redundant dev_err()
Date: Wed, 11 Nov 2026 19:27:10 -0500
Message-ID: <20261112002705.1160379-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200323-failed-6.18-5eab1e7f7ed1@kernel.org>
References: <20261109200323-failed-6.18-5eab1e7f7ed1@kernel.org>
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

From: Pan Chuang <panchuang@vivo.com>

[ Upstream commit b8ffbb950dffbcf810ba41e776516cf3438bbe25 ]

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs detailed
error messages on failure. Remove the now-redundant driver-specific
dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Link: https://lore.kernel.org/r/20260720063745.309331-7-panchuang@vivo.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: 5eab1e7f7ed1 ("hwmon: (sht15) Stop deferred work before releasing its resources")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/sht15.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 3d55047e9baf9..48bcd362c4808 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -981,10 +981,8 @@ static int sht15_probe(struct platform_device *pdev)
 			       IRQF_TRIGGER_FALLING,
 			       "sht15 data",
 			       data);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to get irq for data line\n");
+	if (ret)
 		goto err_release_reg;
-	}
 	disable_irq_nosync(gpiod_to_irq(data->data));
 	ret = sht15_connection_reset(data);
 	if (ret)
-- 
2.53.0

