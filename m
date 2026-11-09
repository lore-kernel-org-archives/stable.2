Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212269;
	b=kBButIaLW0Eul2ib2VB/GYohKE29eyvEk9Qx9N5RHzdBk3iFDDYnWI/ueXtx7imBZk5F
	 2MGeuLi/rDXwG/fnTooaOv7cn9bvbjDZf/jXTz3aYmaNmM1VMb8zerpFxnX5vU4XvSnAO
	 4ANxFJKoQO4fEi0EpgJBXllQg0NOh+HUlsR1QSwtITJ+eGLc6eiielzX3K91PeeL9Q2kE
	 +2rym3+ES5o2NEzx8/C2EMMqRyRHZ0xwFux2rSM6D+zmA7af6PxFTI4Iw41Rl6+gQI2F7
	 97N0HazPl+EBJWPLWGs6xCNcuyycdEtftPoAZLCijXlGwaOlClOYcmbYpAIQp1jQ+Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212269;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=mdG0yVGrXx4U0QbvognYwVkPFib9r3p2FJtt9hThuDw=;
	b=3vJ/O9PIchBP7S25mL+ypSWhDCnmT/p/wxEMHFQdIEYwBNb702DQT23laxwvtwzbN1FB
	 pB+K7EQhtzSClZekZ5g3kzg/aZlVU3vsKtjjnOlWOIr9y6yutByGpc04RTiiHhjXZp6Tv
	 EY/kbqMJVuMwUmK2H/47jMHYHuwPxFkyqTK0rqcuSn0Xb5n/0Vl/r5qk6b1I/p89i5kS5
	 1AakZ9QHIuBv1T5uHxOETP3NoNTqjWo5xk8sAUTc4Ja4XKdO2QGbanfxN2P8l5bHvDTjC
	 nKJYOXzriFfNqUxrVi8znlASs0KnjHBwdg6ZPMWXm0U0oTVdTXytWsuIiGaVIXQOyOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i/leZ3HU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B7D7E606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i/leZ3HU
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BFAA11F0089F;
	Mon,  9 Nov 2026 08:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794212268;
	bh=mdG0yVGrXx4U0QbvognYwVkPFib9r3p2FJtt9hThuDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i/leZ3HUQTEjkfZzqBmWAqqDKOtjs2K7Z2y6RqJpuEXGrdxwzzpGqQ0PqMH1DmZlu
	 wOPrHfrRyLZaIkBudVnplRkmg8r55zAiMmkPz6R7H4Xt4QG3hjqtSnIFj/vlLqR74b
	 ZovttcEwW0PWWn9sYi1HhXMU5MIDsCOBo+qKNjsufAvdOw0WdPEGLdx9RjrFb+Apb+
	 alzEoqxdbZafp354Im8PMY5eRVFXcL1VwFof5PzmbuCqHDEXx+E3n3Go2MBg29zoHy
	 GARIDJTIk/l/zS0f/wn6mQNjYJra6HuG7EwsJzb9e3H0fHSsazyjrz6U85LH9XG67z
	 E9h378x1eur1A==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 6.6.y] pwm: tiehrpwm: Clear period on disable to allow reconfiguration
Date: Mon,  9 Nov 2026 09:17:29 +0100
Message-ID: <20261109081728.798045-2-ukleinek@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <20261107053048-failed-6.6-e74b9a7ee500@kernel.org>
References: <20261107053048-failed-6.6-e74b9a7ee500@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=ukleinek@kernel.org; h=from:subject; bh=+sHxlrCX4zR7UHz92Y6hDueZ3+1UPh88pRQS0cA41Rg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq8YGYqnfRZC5W1PcrMBs9RKyDz6B4+ud3CjSTX +BtW4+JXb6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCavGBmAAKCRCPgPtYfRL+ TjCYB/9DPHAU04vzR/y/KjmekAl1Tm8IudIGqb8jGcj2rES2sYDY9/rx9Vh3okY9MT2qAKU+x1r b8ulzIKWNSXg8KyN6xSjjw31LJKy+eAFYo+JMQYQ+lF52CtHGdmtd8fyzP3Urzt7wyiPGqe66bg 8uS/TB4lhQ+MsJXHQEoAiKHx3CYzbosSkzzCJudZ0G8+4w1c8ETkW97kzF27EawURA6CDAnla6V Vzj3hTfWwKr6QofHhXMbZRtTc0uW6LUQt3WFFzstMVnxqnSEf66PZ/kDNeffXGmH+xjPodLvw5T 0mk0uG+wC9OPg2E5ITDCADBufp9s3WcRG3shtpJ5io/Rh8Xe
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

[ Upstream commit e74b9a7ee50071aad25d3989bf985292f90b0c6e ]

Both channels share one period register, so ehrpwm_pwm_config() rejects a
period differing from the sibling's period_cycles[]. That value was cleared
only in .free(), not in .disable(), so a stopped channel kept blocking the
sibling from switching to a new frequency. Clear it in .disable() too.

Testcase:

  cd /sys/class/pwm/pwmchip0; echo 0 > export; echo 1 > export
  for p in pwm0 pwm1; do
    echo 1000000 > $p/period; echo 500000 > $p/duty_cycle
    echo 1 > $p/enable; echo 0 > $p/enable; echo 2000000 > $p/period
  done
  echo 1 > pwm0/enable	# before: -EINVAL, after: succeeds

Fixes: 01b2d4536f02 ("pwm: pwm-tiehrpwm: Fix conflicting channel period setting")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Link: https://patch.msgid.link/20260929120806.2790355-1-alexander.sverdlin@siemens.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/pwm/pwm-tiehrpwm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index d693b2d65ccc..9af6cb08a01c 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -386,6 +386,9 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	/* Disable clock on PWM disable */
 	pm_runtime_put_sync(chip->dev);
+
+	/* A disabled channel must not constrain the sibling's period */
+	pc->period_cycles[pwm->hwpwm] = 0;
 }
 
 static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
2.56.0.rc1

