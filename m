Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889551;
	b=tC1qgM438Y74jbHRHMBMtLo8aAMdsDhCFpF/SOwOB6cxWFVPoMsqb4UkSXXFdXmPKdjA
	 4kQWvxVg5BAn0yvOT/EoPFWWDazamVqy3vCfwmxKgG8b5kp+X2VSIEX8wRvwR+G4xvVLF
	 yJLucFW5KX3nNDeowsL6StCyjMGL8BrfJoEb6P0QZ6NatLAmBH+GfmwLXaMHKPFB778Om
	 Mg/sheA9Rwptl/OcRm/V6KsqArg+qzFsUAkAV7tlBBSqgM0q18aW+XfRBsrMGak4SB/HE
	 PN4JUvo5uEgyxB0j1BMswihDPw07kV955s9NS4OSnPnLyzswwf1VzIii3xYTWIWLclw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Cz3hsHoABfHQJbIVOt0JnDILxbqus7gt6vD3k/2YVn0=;
	b=bRDVLK7QRYuiNus8tLXafEqvJt9s+Oa/pmBbTam+zQmS5rEUimMTcWVlx5xCuqLOm7J1
	 aoy5+EaFE2IwxRDECXV8AHwfAzYOGyND/np7OwkmVqCcJbnhONddqM4Q/3RDJ8lKniZvJ
	 HO1a08msSrIGD8oraivmHsczTBhTpYvF7DpfBjslil/qfkgGcuKgyZPCloU6N77WA+YpG
	 kNVvMIUGvJwyH+N6T43ooiFa4f4K2ucqVMNi0bsGNOH0PWboWTTXSRlo3cfAe9W1NZNPS
	 PUXuULt1ZRtyqCZvOzRI7HQHwaToLZ9NCFL1YZYQ0UFltHsPTFi1CIB3u0Z3Eqrk5Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XkJA2VS0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B966606A326;
	Thu,  5 Nov 2026 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XkJA2VS0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BAC1F000C1;
	Thu,  5 Nov 2026 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889550;
	bh=Cz3hsHoABfHQJbIVOt0JnDILxbqus7gt6vD3k/2YVn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XkJA2VS0NGDGHcmyWZyMjjgyvEklZ5U1BDW2fKU3a1+2QSPj86fHovI4QOs9zcxuv
	 D9YuSxDd4pnxPeZ7vHPemTMfX9KBgl4cHHcFtWHRR3D/VZmtQGks2SnEBFxWnV1wtI
	 VtRf8W8NeLSeLanr7xxLQc82ys0XJmC49lx7c8bmQ/DXDAD+PtoN7BC4ElkabBQCBx
	 d6Ujx9TZ8Esqq3LiKu9AagDPSv0DUkK2xJttIfJCbj1cT+zo4FAw/3f07TzqamQ5iQ
	 1EcNjog8xQUTT1ftVXuAKMFi2Vip362txfvKI13PEHn+1XzueuE1Y3jo3kDPliB1PH
	 ID013pdQxFHXA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-pwm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/8] pwm: mxs: Return early when disabling and fix error-path clock leak
Date: Thu,  5 Nov 2026 14:38:04 +0000
Message-ID: <20261105143847.2559586-3-lee@kernel.org>
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
Content-Transfer-Encoding: 8bit

When disabling a PWM channel (!state->enabled), the PWM core permits
state->period to be zero.  mxs_pwm_apply() currently falls through into
the period and duty-cycle calculations even when !state->enabled,
causing do_div(c, state->period) to divide by zero when state->period is
zero.  In addition, if the requested period exceeds the maximum divider
(div >= PERIOD_CDIV_MAX) while the PWM channel is currently disabled,
mxs_pwm_apply() returns -EINVAL without disabling and unpreparing
mxs->clk.

Handle the !state->enabled path upfront and return early, and balance
clk_prepare_enable() on the -EINVAL error path.

Fixes: bf29c2ff82fd ("pwm: mxs: Implement ->apply()")
Closes: https://sashiko.dev/#/bug/linux-710f863f-6964-4e4f-990a-e5043dbc1a87
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pwm/pwm-mxs.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index e1a3df6549fc..16233764fd3c 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -56,6 +56,14 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long c;
 	unsigned int pol_bits;
 
+	if (!state->enabled) {
+		if (pwm_is_enabled(pwm)) {
+			writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
+			clk_disable_unprepare(mxs->clk);
+		}
+		return 0;
+	}
+
 	/*
 	 * If the PWM channel is disabled, make sure to turn on the
 	 * clock before calling clk_get_rate() and writing to the
@@ -67,9 +75,6 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			return ret;
 	}
 
-	if (!state->enabled && pwm_is_enabled(pwm))
-		writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
-
 	rate = clk_get_rate(mxs->clk);
 	while (1) {
 		c = rate >> cdiv_shift[div];
@@ -78,8 +83,11 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (c < PERIOD_PERIOD_MAX)
 			break;
 		div++;
-		if (div >= PERIOD_CDIV_MAX)
+		if (div >= PERIOD_CDIV_MAX) {
+			if (!pwm_is_enabled(pwm))
+				clk_disable_unprepare(mxs->clk);
 			return -EINVAL;
+		}
 	}
 
 	period_cycles = c;
@@ -101,16 +109,12 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	writel(PERIOD_PERIOD(period_cycles) | pol_bits | PERIOD_CDIV(div),
 	       mxs->base + PWM_PERIOD0 + pwm->hwpwm * 0x20);
 
-	if (state->enabled) {
-		if (!pwm_is_enabled(pwm)) {
-			/*
-			 * The clock was enabled above. Just enable
-			 * the channel in the control register.
-			 */
-			writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + SET);
-		}
-	} else {
-		clk_disable_unprepare(mxs->clk);
+	if (!pwm_is_enabled(pwm)) {
+		/*
+		 * The clock was enabled above. Just enable
+		 * the channel in the control register.
+		 */
+		writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + SET);
 	}
 	return 0;
 }
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
-- 
2.56.0.398.g882cbad275-goog

