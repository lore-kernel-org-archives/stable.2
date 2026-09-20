Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564B23F0A9F;
	Sun, 20 Sep 2026 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905772; cv=none; b=IPkaw0bpP5PWL8feJqKZkp10HdZ5oeR0HxYLx6dIY71qGtBPYTQFCL3dEwPLed5OKhEuS9wsYB4tWek+ns3J6jP9kHBFqpLB4nj5UT8gZY4KrWf1IsrXdQ79Mum8FcuSUL+/jUtKbkxblm4J0+R4Tg3wfDmqZt2Lh6PbXlmiiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905772; c=relaxed/simple;
	bh=65YAMN2jMQMexn5NWqF+IkOHdXASL5XZWp1AxPHJhCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ue6eyk8/LsGoj7X38dmzfQVAmLo3Qnc4DhSs572VVvC4Sm5QBOeiCEKh6AbD09QZPbT6GAg0dJa81uHJVNpUHthtRKxKba1K8YhgwjWGRDR8JoecMenwJ6B7W2eCu5C5ssm9XAwBh12DyAXM79+uQ7qwSnrbV7IlBGRNvsGgFfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn2Z2oPC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn2Z2oPC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05DCBC2BCFA;
	Sun, 20 Sep 2026 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789905772;
	bh=65YAMN2jMQMexn5NWqF+IkOHdXASL5XZWp1AxPHJhCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gn2Z2oPCTHQp1xXDPmD7CnuXhRHnwxKrF6wKhBHx9FLzRywzrpe2RRHP373pv/jfv
	 XqH6elbTVNo/EWLD0k9W/4LqKVzVcgO8vpG7CwYuhGoJB7oao0A5QYBua5HGus2DlI
	 4uFKvtZs5uyrNs+E06nxnuMs3vEPeY+ISLFfg73aul4DMHcCmOSYQSqclIIc3DY/C/
	 up1AyjbIc0YWZjiRqwTbffC5ggcr/ILf9blsDdg43+ipFKlFvAlHJkifDmRrNV0R/Q
	 IzWNMqjDmd9bqNnIlisXEAKXqa2eFVl2dszvFNcOqgCk6pTbTzOzQNIcuv4A+S2y+u
	 DeDl95G6KhhFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB532C982E1;
	Sun, 20 Sep 2026 12:02:51 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Sun, 20 Sep 2026 20:02:06 +0800
Subject: [PATCH v4 1/3] pwm: loongson: Fix low pulse buffer register
 handling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-pwm-loongson-fix-v4-1-41b36b3c6497@gmail.com>
References: <20260920-pwm-loongson-fix-v4-0-41b36b3c6497@gmail.com>
In-Reply-To: <20260920-pwm-loongson-fix-v4-0-41b36b3c6497@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789905770; l=3560;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=xKFzA7ifd9ad2V7j06rPSJKnO6U/pybJmXR1kEqgFyQ=;
 b=y8wE0196pS/du7+GBxEgVSLhccaqg8LjJTqC1XqDDjw6D+7r7m6O6j6Fo/KKUozmgUH9/vrh6
 mZrYZ1OATAmBcW4aaB/bj0EDJIF3FFNdEt8nwnhCX5t7i7q9pAMq9ce
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

The Loongson PWM register at offset 0x4 is documented as the Low
Pulse Buffer Register, which stores the low pulse width rather than
the duty cycle.

However, this register was incorrectly defined and treated as a
duty-cycle register. As a result, the duty cycle and low pulse cycle
are swapped in the generated PWM waveform.

Program the low pulse (period - duty) into the register and
adjust pwm_loongson_get_state() accordingly when reconstructing the
duty cycle.

Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/pwm/pwm-loongson.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 98c809bde2b3..7af5d4ce1060 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -33,7 +33,7 @@
 #include <linux/units.h>
 
 /* Loongson PWM registers */
-#define LOONGSON_PWM_REG_DUTY		0x4 /* Low Pulse Buffer Register */
+#define LOONGSON_PWM_REG_LOW		0x4 /* Low Pulse Buffer Register */
 #define LOONGSON_PWM_REG_PERIOD		0x8 /* Pulse Period Buffer Register */
 #define LOONGSON_PWM_REG_CTRL		0xc /* Control Register */
 
@@ -120,20 +120,20 @@ static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       u64 duty_ns, u64 period_ns)
 {
-	u64 duty, period;
+	u64 low, duty, period;
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
-	/* duty = duty_ns * ddata->clk_rate / NSEC_PER_SEC */
-	duty = mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PER_SEC);
-	if (duty > U32_MAX)
-		duty = U32_MAX;
-
 	/* period = period_ns * ddata->clk_rate / NSEC_PER_SEC */
 	period = mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC);
 	if (period > U32_MAX)
 		period = U32_MAX;
 
-	pwm_loongson_writel(ddata, duty, LOONGSON_PWM_REG_DUTY);
+	/* duty = duty_ns * ddata->clk_rate / NSEC_PER_SEC */
+	duty = mul_u64_u64_div_u64_roundup(duty_ns, ddata->clk_rate, NSEC_PER_SEC);
+	duty = min(duty, period);
+	low = period - duty;
+
+	pwm_loongson_writel(ddata, low, LOONGSON_PWM_REG_LOW);
 	pwm_loongson_writel(ddata, period, LOONGSON_PWM_REG_PERIOD);
 
 	return 0;
@@ -168,15 +168,20 @@ static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				  struct pwm_state *state)
 {
-	u32 duty, period, ctrl;
+	u32 low, period, ctrl;
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
-	duty = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
+	low = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_LOW);
 	period = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
 	ctrl = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
 
-	/* duty & period have a max of 2^32, so we can't overflow */
-	state->duty_cycle = DIV64_U64_ROUND_UP((u64)duty * NSEC_PER_SEC, ddata->clk_rate);
+	/* low & period have a max of 2^32 - 1, so we can't overflow */
+	if (low >= period)
+		state->duty_cycle = 0;
+	else
+		state->duty_cycle =
+		    DIV64_U64_ROUND_UP((u64)(period - low) * NSEC_PER_SEC, ddata->clk_rate);
+
 	state->period = DIV64_U64_ROUND_UP((u64)period * NSEC_PER_SEC, ddata->clk_rate);
 	state->polarity = (ctrl & LOONGSON_PWM_CTRL_REG_INVERT) ? PWM_POLARITY_INVERSED :
 			  PWM_POLARITY_NORMAL;

-- 
2.43.0


