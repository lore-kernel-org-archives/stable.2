Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795786364;
	b=4TWxhwFRdxUV8mB/ZCBgUIVf1XKXHtQmfoLD2IqBGke6TQx8HUAsUXtEcs9WiPu9B4+u
	 1D5ZD3Nel7LNXXEEFK1V3fWnkmc5Xic8p1FyZmkJ+6a1CAPwAf8zMOONLlr1dPVW0JSsP
	 +9M2bn992lcv4UXTN98oaOkNjqOwJK42KSe6FALNcmN1rscZehEPqmR3k+/BcETlNTRN+
	 KMV7kwqz4KptAvxl03prUNoDPmTOOKR0n+mUaZfoGLooajS+YAbGjYnoPoBHgK1SuD7Ha
	 m28QYR9BjXjPQxM44n/fpB5yvB31MwGtVVyaq9sU9IXTMR295HCMS8MHvRiaB6ZwgJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786364;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IVfRJc0hg8PdGzm8ekSlyjjO5CEVAOryc5uoYkl49iw=;
	b=LmfkdnFKJCCe70nVRK8pia1Qs4zhiCZdsQDTNEzzSEVG9iQ778zKfZ+heHi9wj8hehPo
	 qzZNfpREoXyS/eOjW3nXqeBzP71WJUwh7Eke9g5JoC/TeWIw6jReA/9ki4ZVr66zdeFEo
	 89fLnc32KAaLOkdb0Thp/8hpB3t82GViQMX/Y8yvpW8ED+4GiCZMNXMIhm5JqeLUoX0DS
	 1ITDquuboyVVDaV9WFqlDj53DBAPrpUqCPpJ84Sd2cHtCT1kvPx6cnmOzvagQlplChmGt
	 w7dhhnzQVoFezYXdHnP5ABJlcKiO3qZuffly4sGTdExxphaPbVE+xFNqQEHg5uI52Rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6V3OiLN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21563606A323;
	Fri, 27 Nov 2026 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6V3OiLN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795786363;
	b=LGFYBXDy84X6D0+ezuZIhmNMBXL7NryMNPbtNk60IsvPYYF9gKPSQ6HmXoHioCjaTE7n
	 LZELrV6gPqzE7KWERx8lB0cR4XLkIgpwPD2vHx8hwwTcVdhTP42T6qZ+hDBQ0tA93zEno
	 IzsrXCtm5mfzvy1FejY3p6j4k7odsWNZQpiR9GpiZR6qCeOgoo6RXwTo+PLUWpelb+JIB
	 zqaIcAAWFNTJTwsmKGDDPIBV1EREKuLssJVy2J8Ie1JNiDw/7U78lAIikDylLjAcbMvqI
	 bAVAPip1TlWr4wcWnYToygmU+yq4wcSv6PVhUkcvriWpBMxTaeo3NcZ5X59M8iHZcxg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795786363;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IVfRJc0hg8PdGzm8ekSlyjjO5CEVAOryc5uoYkl49iw=;
	b=J725VQV6TdpBfbAFw3kq4fE2mqcMcPU7m1AueGchy2OARTeaa874d2iYdsWVd2b/jv/E
	 ledBM2rz8EYJ3n5mkr1XBaWgKYJRqp2XCFsJxCjLlJrjYhiDgmK3kLm8dYwBPx8EUNJhb
	 M9dlSF6fPuOOVL0a+6S25bXy8jqSgQZk4xkk3bWh03PRaE5u+fnmWFidGtUOYtEIhU3EN
	 1AH1iVeJ5AXG1Xc/UufvzkQdWkWQ5jUWmXZd4cI5GjOSmYgXqmoz6m9a+/C6lBGI/AFcT
	 Ik40Lxw6i8MyMKLP5eQfq+kpRXP/6djsHMT4o1ty2n4iT6jLDvdOy7Dxu+dlLA+tcTw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A2E531F0089F;
	Fri, 27 Nov 2026 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795786363;
	bh=IVfRJc0hg8PdGzm8ekSlyjjO5CEVAOryc5uoYkl49iw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=P6V3OiLNXKcMmCzEO6qe437YLd2DqiTpvBk8xM89mOMZ9Sk9tieqosCAerrsK95lk
	 A3mO9RoumtPP/ELrBWD5dU0JW8T1U/PW+pf4jJX9sGrcSLHg8jj4mYtCecINk3x5Ot
	 Whb2YIsGdzwnO8VmSEGMihLbGqyrZiGXJLzXoYlzsiRMu0Jl5J8VwZx7G9NtbxCXL9
	 vBplsN6qgngebYj+FYS4mRCdJN7uwcynHVbVkVmtDsiT6FtkQRhzdsBDOBqabrMMTq
	 pOKz1VKkbAQKr4nCj5c1/YUnZGT3vjFXZ+hJO5OKqd+t3FS+e6MA499Q18PAFjVplW
	 MfKztXVXmAn4Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2E5714B804;
	Fri, 27 Nov 2026 13:32:32 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 21:32:23 +0800
Subject: [PATCH RESEND v4 1/3] pwm: loongson: Fix low pulse buffer register
 handling
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-pwm-loongson-fix-v4-1-607f325b74d4@gmail.com>
References: <20261127-pwm-loongson-fix-v4-0-607f325b74d4@gmail.com>
In-Reply-To: <20261127-pwm-loongson-fix-v4-0-607f325b74d4@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Imported from f20260920-pwm-loongson-fix-v4-0-41b36b3c6497"@gmail.com, 
 Keguang Zhang <keguang.zhang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795786349; l=3560;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=DFazlz12Y6/wBIS6Dam/b9mRin3D6Nzh0Lwh4VsJ77g=;
 b=F1S+cjVPx2cGUd30vfgrtNyngtI2i5floNkR6Ftpo5t3TBUWvjdJNIk3+ziX4s71NDetBNWfD
 P/39O+Vtaz/A7Ib1NQT0lnzg7/T6HxL9v8AN11T7AxY6J8AS0jWmsvm
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com
Content-Transfer-Encoding: 7bit

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
index 4e8b54c8016c..0ec773fba813 100644
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
2.53.0


