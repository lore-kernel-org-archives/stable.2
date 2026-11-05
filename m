Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889544;
	b=rtCu+wndkzgCSm95bUHPo3lzhok0P+LxBE7cSdK1aZVRNag1bdPb3vaw9esTs8VT96LU
	 kt+lS81F/6ZV1nFJ3gICZeo1ewYt3+o0kT2YiEJyI1Is3+3h3oDpCIlZ0lWaufllTB0ra
	 w6sYNc6yb4Nec0hR2BGrmBK5Yr6/ljiqJuNNLgRPoZxvjmt9VlN+8RyDS+D1haDrHQe9T
	 7lhl+kccoRetSn6kUyf+idImIyYLZ8szfFyvfhDFYU/9qhL45xQ3Q5nU9B1FH+dZytWwX
	 GeFHcp4BApIwMfKdfWsHD6cNiBKh3NAFP+6Ng3pUQXplTbTCSz9RvoOFOq2HyLEpOyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eZXxbUy9FSA14Gw7y+WO+5K8lqH+LuRzqlmNhQQJ4QQ=;
	b=PYzjCfXV9wQN5tShL0UFjhuVggw0jDNSyvB2RjYwk5JqW3zffBqGp90+rO9bqlVccTF4
	 Mtwi7iTiW+GSfAmBYOGaDSgtmXyLDSX2uXnqJWUNpccrTbeG2Jgq/8ZaEBvUjDudxicPd
	 +/N64xupR02/lAPprMS/6cLWQF6pwJs6OkJKGvIqWB1/jpE1+bBhqx6t2OJjkdja1dt6w
	 uoXGajR1KeZmETI1BDGYrMRrgbAGLsIJ2GNtZxf1dr8esFQkQ5xlh6G85dN+vwzK9KGF6
	 z3kwgMhglQ0QPISvk6qs+waq3449mwG7Ws1JPsVLvjCKKUBQh6v8SKwSqf+7tL+QfpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBeSF2CY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67157606A31B;
	Thu,  5 Nov 2026 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBeSF2CY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EED1F00A1A;
	Thu,  5 Nov 2026 14:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889543;
	bh=eZXxbUy9FSA14Gw7y+WO+5K8lqH+LuRzqlmNhQQJ4QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aBeSF2CYuVs2mWqnE8Notn0dJG2IYqpsAEySY+ST2/toRdRdOMkKYydkTCSVz3+lq
	 A6/WCa3bHi+hMnyfwVjtls2amsBMBCAJCQug/kGUPk3dOF40F9TyhF74a4ekSUWcpm
	 yJrHVf7gVAS/EL06j7D9EaWls4TdXZFw3InFbyNFeB9nnx+WI2q5hodLcio7e42YfI
	 V4KI6dpIJr8BJ4i8qnv7T0IiGRPcxfp1RWTMb+QRHyGiPi3HzvTDPjksYm8Uzp8tMQ
	 GG/pNnuLwSdFu9jo2ag4TetDoNFhLEC/tsCd2qvqvNWLV5scKU30I/hi3YJSeMDach
	 jFuvLQEDr1usw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Thierry Reding <thierry.reding@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sandipan Patra <spatra@nvidia.com>,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/8] pwm: tegra: Prevent 32-bit period truncation and division by zero
Date: Thu,  5 Nov 2026 14:38:03 +0000
Message-ID: <20261105143847.2559586-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105143847.2559586-1-lee@kernel.org>
References: <20261105143847.2559586-1-lee@kernel.org>
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

tegra_pwm_apply() passes the 64-bit state->duty_cycle and state->period
values into tegra_pwm_config(), which accepts signed 32-bit int
parameters and performs DIV_ROUND_CLOSEST_ULL(c, period_ns) before
validating period_ns against pc->min_period_ns.  If a consumer requests
a period that is a non-zero multiple of 2^32 nanoseconds, period_ns
truncates to zero and triggers a divide-by-zero panic.

Widen duty_ns and period_ns to u64 and validate that period_ns lies
within [pc->min_period_ns, U32_MAX] prior to dividing by period_ns.

Fixes: 1d7796bdb63a ("pwm: tegra: Support dynamic clock frequency configuration")
Fixes: fd3ddd4355c0 ("pwm: tegra: Implement .apply() callback")
Closes: https://sashiko.dev/#/bug/linux-5c5b97d6-4da6-4d06-9dc7-957419dcd832
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pwm/pwm-tegra.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 5cdbe120ba2d..f99ae2b3a276 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -138,7 +138,7 @@ static inline void tegra_pwm_writel(struct pwm_device *pwm, unsigned int offset,
 }
 
 static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
+			    u64 duty_ns, u64 period_ns)
 {
 	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	unsigned long long c = duty_ns;
@@ -146,6 +146,12 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 val = 0;
 	int err;
 
+	/*
+	 *  min period = max clock limit / TEGRA_PWM_DEPTH
+	 */
+	if (period_ns < pc->min_period_ns || period_ns > U32_MAX)
+		return -EINVAL;
+
 	/*
 	 * Convert from duty_ns / period_ns to a fixed number of duty ticks
 	 * per TEGRA_PWM_DEPTH cycles and make sure to round to the
@@ -156,12 +162,6 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	val = (u32)c << TEGRA_PWM_DUTY_SHIFT;
 
-	/*
-	 *  min period = max clock limit / TEGRA_PWM_DEPTH
-	 */
-	if (period_ns < pc->min_period_ns)
-		return -EINVAL;
-
 	/*
 	 * Compute the prescaler value for which TEGRA_PWM_DEPTH
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
Cc: Sandipan Patra <spatra@nvidia.com>
Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
-- 
2.56.0.398.g882cbad275-goog

